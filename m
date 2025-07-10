Return-Path: <linux-fsdevel+bounces-54536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94DB008CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7191C25639
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE717A303;
	Thu, 10 Jul 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJjthCTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364A2EFDA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165111; cv=none; b=ocrdjRqW1xRPi2XSwNfVopooxJwRGmbpMxFsA3mkKpJYStqbnFxLsejPxJ8sAgW0USkbstd4OR/S+MMAoKZsITjXfxq91Sb4VaACEpiKqdLu4dhzcIKhkoT5A3273hM1Zk4nmIHMP2Ac8EfVOCTp7UbsU8/Ng85MAj4evao3wz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165111; c=relaxed/simple;
	bh=0/7e0fhDD+nhfhomUm5QCNroWeBizuBJN14rsfB0VjY=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=oRySyu1AxdDDA+0CuTcZRZbVVkFGpASQN3UwRehEWbN/fZiu1BWYbcpc1dCgS5WUtmYEWWH+Wop2VtyBU8CaDTZoVerGZqXhEpj8lfFlO5TkCE3ikPSLZ5u0z22uoc8NINtABCiqtnaG9H151A+B2ygBwGPPwGzeprcIw7U/kUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJjthCTq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752165108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbVgBYU1j7RlLF0+RFun00uhaSaH2KoCdahv4lEZ8ho=;
	b=LJjthCTqLZGGYTopfGNiF1LBZRzU8KSHnfIXK//AfLpKmy0gefvFV/Fw9TVu5PAQ2kd7Jm
	D2vdA1a1NvvXLRk7nLMiis2SX8RCPgBpn8Fjx9Vcp4BvXzHnwUTg1tSk3b7KNzh1y62KM8
	X2RHkogL2qE5eurSqIoyH68Eu58YTIU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-77Io-M4CMMG3K5g-BpBdDw-1; Thu,
 10 Jul 2025 12:31:46 -0400
X-MC-Unique: 77Io-M4CMMG3K5g-BpBdDw-1
X-Mimecast-MFC-AGG-ID: 77Io-M4CMMG3K5g-BpBdDw_1752165099
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8AF18001D1;
	Thu, 10 Jul 2025 16:31:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CC423000221;
	Thu, 10 Jul 2025 16:31:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2904424.1752161530@warthog.procyon.org.uk>
References: <2904424.1752161530@warthog.procyon.org.uk> <CAKPOu+9TN4hza48+uT_9W5wEYhZGLc2F57xxKDiyhy=pay5XAw@mail.gmail.com> <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com> <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com> <2738562.1752092552@warthog.procyon.org.uk> <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com> <2807750.1752144428@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Christian Brauner <christian@brauner.io>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2919958.1752165094.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 17:31:34 +0100
Message-ID: <2919959.1752165094@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> Depending on what you're doing on ceph, you might need the attached patc=
h as
> well.  I managed to reproduce it by doing a git clone and kernel build o=
n a
> ceph mount with cachefiles active.

Here's a version of the patch that conditionally does the needed wakeup.  =
I
don't want to force processing if there's no need.

David
---
commit 1fe42a9a7f0b2f51107574f0b8e151d13dc766cc
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jul 10 15:02:57 2025 +0100

    netfs: Fix race between cache write completion and ALL_QUEUED being se=
t
    =

    When netfslib is issuing subrequests, the subrequests start processing
    immediately and may complete before we reach the end of the issuing
    function.  At the end of the issuing function we set NETFS_RREQ_ALL_QU=
EUED
    to indicate to the collector that we aren't going to issue any more su=
breqs
    and that it can do the final notifications and cleanup.
    =

    Now, this isn't a problem if the request is synchronous
    (NETFS_RREQ_OFFLOAD_COLLECTION is unset) as the result collection will=
 be
    done in-thread and we're guaranteed an opportunity to run the collecto=
r.
    =

    However, if the request is asynchronous, collection is primarily trigg=
ered
    by the termination of subrequests queuing it on a workqueue.  Now, a r=
ace
    can occur here if the app thread sets ALL_QUEUED after the last subreq=
uest
    terminates.
    =

    This can happen most easily with the copy2cache code (as used by Ceph)
    where, in the collection routine of a read request, an asynchronous wr=
ite
    request is spawned to copy data to the cache.  Folios are added to the
    write request as they're unlocked, but there may be a delay before
    ALL_QUEUED is set as the write subrequests may complete before we get
    there.
    =

    If all the write subreqs have finished by the ALL_QUEUED point, no fur=
ther
    events happen and the collection never happens, leaving the request
    hanging.
    =

    Fix this by queuing the collector after setting ALL_QUEUED.  This is a=
 bit
    heavy-handed and it may be sufficient to do it only if there are no ex=
tant
    subreqs.
    =

    Also add a tracepoint to cross-reference both requests in a copy-to-re=
quest
    operation and add a trace to the netfs_rreq tracepoint to indicate the
    setting of ALL_QUEUED.
    =

    Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only =
use one work item")
    Reported-by: Max Kellermann <max.kellermann@ionos.com>
    Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=3DshxyGLw=
fe-L7AV3DhebS3w@mail.gmail.com/
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Paulo Alcantara <pc@manguebit.org>
    cc: Viacheslav Dubeyko <slava@dubeyko.com>
    cc: Alex Markuze <amarkuze@redhat.com>
    cc: Ilya Dryomov <idryomov@gmail.com>
    cc: netfs@lists.linux.dev
    cc: ceph-devel@vger.kernel.org
    cc: linux-fsdevel@vger.kernel.org
    cc: stable@vger.kernel.org

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 080d2a6a51d9..8097bc069c1d 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -111,6 +111,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_co=
py_to_cache(
 		goto cancel_put;
 =

 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
+	trace_netfs_copy2cache(rreq, creq);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache =3D creq;
@@ -155,6 +156,9 @@ void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_r=
equest *rreq)
 	netfs_issue_write(creq, &creq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_end_copy_to_cache);
+	if (list_empty_careful(&creq->io_streams[1].subrequests))
+		netfs_wake_collector(creq);
 =

 	netfs_put_request(creq, netfs_rreq_trace_put_return);
 	creq->copy_to_cache =3D NULL;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 73e96ccbe830..64a382fbc31a 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -55,6 +55,7 @@
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
+	EM(netfs_rreq_trace_end_copy_to_cache,	"END-C2C")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_ki_complete,	"KI-CMPL")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
@@ -559,6 +560,35 @@ TRACE_EVENT(netfs_write,
 		      __entry->start, __entry->start + __entry->len - 1)
 	    );
 =

+TRACE_EVENT(netfs_copy2cache,
+	    TP_PROTO(const struct netfs_io_request *rreq,
+		     const struct netfs_io_request *creq),
+
+	    TP_ARGS(rreq, creq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		creq)
+		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		ino)
+			     ),
+
+	    TP_fast_assign(
+		    struct netfs_inode *__ctx =3D netfs_inode(rreq->inode);
+		    struct fscache_cookie *__cookie =3D netfs_i_cookie(__ctx);
+		    __entry->rreq	=3D rreq->debug_id;
+		    __entry->creq	=3D creq->debug_id;
+		    __entry->cookie	=3D __cookie ? __cookie->debug_id : 0;
+		    __entry->ino	=3D rreq->inode->i_ino;
+			   ),
+
+	    TP_printk("R=3D%08x CR=3D%08x c=3D%08x i=3D%x ",
+		      __entry->rreq,
+		      __entry->creq,
+		      __entry->cookie,
+		      __entry->ino)
+	    );
+
 TRACE_EVENT(netfs_collect,
 	    TP_PROTO(const struct netfs_io_request *wreq),
 =


