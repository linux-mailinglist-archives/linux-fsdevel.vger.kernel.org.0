Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2413A7C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFOLAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 07:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231533AbhFOLAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623754706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=updnfYb9CdDp+GA55N24Pifns9KAHQTHmZPCQ9YHgmg=;
        b=IpzR/ICl327cJkP9PLN1Z7cdIyPinNdVpyBYf6Fcnh8CsSx0bgG++BBTUS/h5zVfPxDVpT
        pnyFXwyDurUplqgkXR3abW21V+ufd61XE3qQB0Zh7RenYb36JaFd31Rk7bOp+c8ANt6Tzc
        hAI6CUH3eXTll2BX9qWH7VFXPxuA0G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-1ddxtAuYNHeIAuXQ8bwnAg-1; Tue, 15 Jun 2021 06:58:23 -0400
X-MC-Unique: 1ddxtAuYNHeIAuXQ8bwnAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234D98005A2;
        Tue, 15 Jun 2021 10:58:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8587319C66;
        Tue, 15 Jun 2021 10:58:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YLAXfvZ+rObEOdc/@localhost.localdomain>
References: <YLAXfvZ+rObEOdc/@localhost.localdomain>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dhowells@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        akpm@linux-foundation.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <643720.1623754699.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 15 Jun 2021 11:58:19 +0100
Message-ID: <643721.1623754699@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's my take on fixing this.

David
---
afs: Fix tracepoint string placement with built-in AFS

To quote Alexey[1]:

    I was adding custom tracepoint to the kernel, grabbed full F34 kernel
    .config, disabled modules and booted whole shebang as VM kernel.

    Then did

        perf record -a -e ...

    It crashed:

        general protection fault, probably for non-canonical address 0x435=
f5346592e4243: 0000 [#1] SMP PTI
        CPU: 1 PID: 842 Comm: cat Not tainted 5.12.6+ #26
        Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0=
-1.fc33 04/01/2014
        RIP: 0010:t_show+0x22/0xd0

    Then reproducer was narrowed to

        # cat /sys/kernel/tracing/printk_formats

    Original F34 kernel with modules didn't crash.

    So I started to disable options and after disabling AFS everything
    started working again.

    The root cause is that AFS was placing char arrays content into a
    section full of _pointers_ to strings with predictable consequences.

    Non canonical address 435f5346592e4243 is "CB.YFS_" which came from
    CM_NAME macro.

    Steps to reproduce:

        CONFIG_AFS=3Dy
        CONFIG_TRACING=3Dy

        # cat /sys/kernel/tracing/printk_formats

Fix this by the following means:

 (1) Add enum->string translation tables in the event header with the AFS
     and YFS cache/callback manager operations listed by RPC operation ID.

 (2) Modify the afs_cb_call tracepoint to print the string from the
     translation table rather than using the string at the afs_call name
     pointer.

 (3) Switch translation table depending on the service we're being accesse=
d
     as (AFS or YFS) in the tracepoint print clause.  Will this cause
     problems to userspace utilities?

     Note that the symbolic representation of the YFS service ID isn't
     available to this header, so I've put it in as a number.  I'm not sur=
e
     if this is the best way to do this.

 (4) Remove the name wrangling (CM_NAME) macro and put the names directly
     into the afs_call_type structs in cmservice.c.

Fixes: 8e8d7f13b6d5a9 ("afs: Add some tracepoints")
Reported-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/linux-fsdevel/YLAXfvZ+rObEOdc%2F@localhost.l=
ocaldomain/ [1]
---
 fs/afs/cmservice.c         |   25 ++++------------
 include/trace/events/afs.h |   67 +++++++++++++++++++++++++++++++++++++++=
++----
 2 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index d3c6bb22c5f4..a3f5de28be79 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -29,16 +29,11 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_s=
truct *);
 =

 static int afs_deliver_yfs_cb_callback(struct afs_call *);
 =

-#define CM_NAME(name) \
-	char afs_SRXCB##name##_name[] __tracepoint_string =3D	\
-		"CB." #name
-
 /*
  * CB.CallBack operation type
  */
-static CM_NAME(CallBack);
 static const struct afs_call_type afs_SRXCBCallBack =3D {
-	.name		=3D afs_SRXCBCallBack_name,
+	.name		=3D "CB.CallBack",
 	.deliver	=3D afs_deliver_cb_callback,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_CallBack,
@@ -47,9 +42,8 @@ static const struct afs_call_type afs_SRXCBCallBack =3D =
{
 /*
  * CB.InitCallBackState operation type
  */
-static CM_NAME(InitCallBackState);
 static const struct afs_call_type afs_SRXCBInitCallBackState =3D {
-	.name		=3D afs_SRXCBInitCallBackState_name,
+	.name		=3D "CB.InitCallBackState",
 	.deliver	=3D afs_deliver_cb_init_call_back_state,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_InitCallBackState,
@@ -58,9 +52,8 @@ static const struct afs_call_type afs_SRXCBInitCallBackS=
tate =3D {
 /*
  * CB.InitCallBackState3 operation type
  */
-static CM_NAME(InitCallBackState3);
 static const struct afs_call_type afs_SRXCBInitCallBackState3 =3D {
-	.name		=3D afs_SRXCBInitCallBackState3_name,
+	.name		=3D "CB.InitCallBackState3",
 	.deliver	=3D afs_deliver_cb_init_call_back_state3,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_InitCallBackState,
@@ -69,9 +62,8 @@ static const struct afs_call_type afs_SRXCBInitCallBackS=
tate3 =3D {
 /*
  * CB.Probe operation type
  */
-static CM_NAME(Probe);
 static const struct afs_call_type afs_SRXCBProbe =3D {
-	.name		=3D afs_SRXCBProbe_name,
+	.name		=3D "CB.Probe",
 	.deliver	=3D afs_deliver_cb_probe,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_Probe,
@@ -80,9 +72,8 @@ static const struct afs_call_type afs_SRXCBProbe =3D {
 /*
  * CB.ProbeUuid operation type
  */
-static CM_NAME(ProbeUuid);
 static const struct afs_call_type afs_SRXCBProbeUuid =3D {
-	.name		=3D afs_SRXCBProbeUuid_name,
+	.name		=3D "CB.ProbeUuid",
 	.deliver	=3D afs_deliver_cb_probe_uuid,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_ProbeUuid,
@@ -91,9 +82,8 @@ static const struct afs_call_type afs_SRXCBProbeUuid =3D=
 {
 /*
  * CB.TellMeAboutYourself operation type
  */
-static CM_NAME(TellMeAboutYourself);
 static const struct afs_call_type afs_SRXCBTellMeAboutYourself =3D {
-	.name		=3D afs_SRXCBTellMeAboutYourself_name,
+	.name		=3D "CB.TellMeAboutYourself",
 	.deliver	=3D afs_deliver_cb_tell_me_about_yourself,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_TellMeAboutYourself,
@@ -102,9 +92,8 @@ static const struct afs_call_type afs_SRXCBTellMeAboutY=
ourself =3D {
 /*
  * YFS CB.CallBack operation type
  */
-static CM_NAME(YFS_CallBack);
 static const struct afs_call_type afs_SRXYFSCB_CallBack =3D {
-	.name		=3D afs_SRXCBYFS_CallBack_name,
+	.name		=3D "YFSCB.CallBack",
 	.deliver	=3D afs_deliver_yfs_cb_callback,
 	.destructor	=3D afs_cm_destructor,
 	.work		=3D SRXAFSCB_CallBack,
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 3ccf591b2374..9f73ed2cf061 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -174,6 +174,34 @@ enum afs_vl_operation {
 	afs_VL_GetCapabilities	=3D 65537,	/* AFS Get VL server capabilities */
 };
 =

+enum afs_cm_operation {
+	afs_CB_CallBack			=3D 204,	/* AFS break callback promises */
+	afs_CB_InitCallBackState	=3D 205,	/* AFS initialise callback state */
+	afs_CB_Probe			=3D 206,	/* AFS probe client */
+	afs_CB_GetLock			=3D 207,	/* AFS get contents of CM lock table */
+	afs_CB_GetCE			=3D 208,	/* AFS get cache file description */
+	afs_CB_GetXStatsVersion		=3D 209,	/* AFS get version of extended statist=
ics */
+	afs_CB_GetXStats		=3D 210,	/* AFS get contents of extended statistics da=
ta */
+	afs_CB_InitCallBackState3	=3D 213,	/* AFS initialise callback state, ver=
sion 3 */
+	afs_CB_ProbeUuid		=3D 214,	/* AFS check the client hasn't rebooted */
+};
+
+enum yfs_cm_operation {
+	yfs_CB_Probe			=3D 206,	/* YFS probe client */
+	yfs_CB_GetLock			=3D 207,	/* YFS get contents of CM lock table */
+	yfs_CB_XStatsVersion		=3D 209,	/* YFS get version of extended statistics=
 */
+	yfs_CB_GetXStats		=3D 210,	/* YFS get contents of extended statistics da=
ta */
+	yfs_CB_InitCallBackState3	=3D 213,	/* YFS initialise callback state, ver=
sion 3 */
+	yfs_CB_ProbeUuid		=3D 214,	/* YFS check the client hasn't rebooted */
+	yfs_CB_GetServerPrefs		=3D 215,
+	yfs_CB_GetCellServDV		=3D 216,
+	yfs_CB_GetLocalCell		=3D 217,
+	yfs_CB_GetCacheConfig		=3D 218,
+	yfs_CB_GetCellByNum		=3D 65537,
+	yfs_CB_TellMeAboutYourself	=3D 65538, /* get client capabilities */
+	yfs_CB_CallBack			=3D 64204,
+};
+
 enum afs_edit_dir_op {
 	afs_edit_dir_create,
 	afs_edit_dir_create_error,
@@ -436,6 +464,32 @@ enum afs_cb_break_reason {
 	EM(afs_YFSVL_GetCellName,		"YFSVL.GetCellName") \
 	E_(afs_VL_GetCapabilities,		"VL.GetCapabilities")
 =

+#define afs_cm_operations \
+	EM(afs_CB_CallBack,			"CB.CallBack") \
+	EM(afs_CB_InitCallBackState,		"CB.InitCallBackState") \
+	EM(afs_CB_Probe,			"CB.Probe") \
+	EM(afs_CB_GetLock,			"CB.GetLock") \
+	EM(afs_CB_GetCE,			"CB.GetCE") \
+	EM(afs_CB_GetXStatsVersion,		"CB.GetXStatsVersion") \
+	EM(afs_CB_GetXStats,			"CB.GetXStats") \
+	EM(afs_CB_InitCallBackState3,		"CB.InitCallBackState3") \
+	E_(afs_CB_ProbeUuid,			"CB.ProbeUuid")
+
+#define yfs_cm_operations \
+	EM(yfs_CB_Probe,			"YFSCB.Probe") \
+	EM(yfs_CB_GetLock,			"YFSCB.GetLock") \
+	EM(yfs_CB_XStatsVersion,		"YFSCB.XStatsVersion") \
+	EM(yfs_CB_GetXStats,			"YFSCB.GetXStats") \
+	EM(yfs_CB_InitCallBackState3,		"YFSCB.InitCallBackState3") \
+	EM(yfs_CB_ProbeUuid,			"YFSCB.ProbeUuid") \
+	EM(yfs_CB_GetServerPrefs,		"YFSCB.GetServerPrefs") \
+	EM(yfs_CB_GetCellServDV,		"YFSCB.GetCellServDV") \
+	EM(yfs_CB_GetLocalCell,			"YFSCB.GetLocalCell") \
+	EM(yfs_CB_GetCacheConfig,		"YFSCB.GetCacheConfig") \
+	EM(yfs_CB_GetCellByNum,			"YFSCB.GetCellByNum") \
+	EM(yfs_CB_TellMeAboutYourself,		"YFSCB.TellMeAboutYourself") \
+	E_(yfs_CB_CallBack,			"YFSCB.CallBack")
+
 #define afs_edit_dir_ops				  \
 	EM(afs_edit_dir_create,			"create") \
 	EM(afs_edit_dir_create_error,		"c_fail") \
@@ -569,6 +623,8 @@ afs_server_traces;
 afs_cell_traces;
 afs_fs_operations;
 afs_vl_operations;
+afs_cm_operations;
+yfs_cm_operations;
 afs_edit_dir_ops;
 afs_edit_dir_reasons;
 afs_eproto_causes;
@@ -649,20 +705,21 @@ TRACE_EVENT(afs_cb_call,
 =

 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
-		    __field(const char *,		name		)
 		    __field(u32,			op		)
+		    __field(u16,			service_id	)
 			     ),
 =

 	    TP_fast_assign(
 		    __entry->call	=3D call->debug_id;
-		    __entry->name	=3D call->type->name;
 		    __entry->op		=3D call->operation_ID;
+		    __entry->service_id	=3D call->service_id;
 			   ),
 =

-	    TP_printk("c=3D%08x %s o=3D%u",
+	    TP_printk("c=3D%08x %s",
 		      __entry->call,
-		      __entry->name,
-		      __entry->op)
+		      __entry->service_id =3D=3D 2501 ?
+		      __print_symbolic(__entry->op, yfs_cm_operations) :
+		      __print_symbolic(__entry->op, afs_cm_operations))
 	    );
 =

 TRACE_EVENT(afs_call,

