Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163E225A02A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 22:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIAUqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 16:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgIAUqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598993207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lkkfKV7UxnQHqWDYOZ6Ov1jWnZGUnUAogAr7PBe8O60=;
        b=VKyM2PG0O7jBG4sUGZMqZk75Thc2zXK5ITF3VF0F6YjbjHosu3bGWEYR8DdfXmDLGbBQKt
        2whVVVGVz3nCekTMVwkubHOoZBpGRREF/xIvsGM8nvE3tXD0kMn5u613tr5PH2lJXGuTt1
        dYZJ+KMjQess/jQcBaDau4wuEENyuEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-YKaQdF9COX2DKoKuOWd24Q-1; Tue, 01 Sep 2020 16:46:45 -0400
X-MC-Unique: YKaQdF9COX2DKoKuOWd24Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D632B802B66;
        Tue,  1 Sep 2020 20:46:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29ABB78B4F;
        Tue,  1 Sep 2020 20:46:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9F6FD22053E; Tue,  1 Sep 2020 16:46:37 -0400 (EDT)
Date:   Tue, 1 Sep 2020 16:46:37 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     stefanha@redhat.com, dgilbert@redhat.com
Subject: Re: [RFC PATCH 0/2] fuse: Enable SB_NOSEC if filesystem is not shared
Message-ID: <20200901204637.GA1232696@redhat.com>
References: <20200901204045.1250822-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901204045.1250822-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 04:40:43PM -0400, Vivek Goyal wrote:
> Hi,
> 
> I want to enable SB_NOSEC in fuse in some form so that performance of
> small random writes can be improved. As of now, we call file_remove_privs(),
> which results in fuse always sending getxattr(security.capability) to
> server to figure out if security.capability has been set on file or not.
> If it has been set, it needs to be cleared. This slows down small
> random writes tremendously.
> 
> I posted couple of proposals in the past here.
> 
> Proposal 1:
> 
> https://lore.kernel.org/linux-fsdevel/20200716144032.GC422759@redhat.com/
> 
> Proposal 2:
> 
> https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/
> 
> This is 3rd proposal now. One of the roadblocks in enabling SB_NOSEC
> is shared filesystem. It is possible that another client modified the
> file data and this client does not know about it. So we might regress
> if we don't fetch security.capability always.
> 
> So looks like this needs to be handled different for shared filesystems
> and non-shared filesystems. non-shared filesystems will be more like
> local filesystems where fuse does not expect file data/metadata to
> change outside the fuse. And we should be able to enable SB_NOSEC
> optimization. This is what this proposal does.
> 
> It does not handle the case of shared filesystems. I believe solution
> to that will depend on filesystem based on what's the cache coherency
> guarantees filesystem provides and what's the cache invalidation 
> mechanism it uses.
> 
> For now, all filesystems which are not shared can benefit from this
> optimization. I am interested in virtiofs which is not shared in
> many of the cases. In fact we don't even support shared mode yet. 

Here is the corresponding qemu virtiofsd patch which can enable this
feature.


Subject: virtiofsd: Enable FUSE_NONSHARED_FS by default

Set FUSE_NONSHARED_FS flag by default as we don't support sharing of
virtiofs filesystem yet. Once that is supported, it should not be set
for shared mode.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/standard-headers/linux/fuse.h |    4 ++++
 tools/virtiofsd/fuse_lowlevel.c       |    9 +++++++++
 2 files changed, 13 insertions(+)

Index: qemu/include/standard-headers/linux/fuse.h
===================================================================
--- qemu.orig/include/standard-headers/linux/fuse.h	2020-09-01 15:22:31.449707002 -0400
+++ qemu/include/standard-headers/linux/fuse.h	2020-09-01 15:23:18.776668542 -0400
@@ -172,6 +172,8 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *  7.32
+ *  - add FUSE_NONSHARED_FS flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -310,6 +312,7 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_NONSHARED_FS: Filesystem is not shared.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -338,6 +341,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_NONSHARED_FS	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
Index: qemu/tools/virtiofsd/fuse_lowlevel.c
===================================================================
--- qemu.orig/tools/virtiofsd/fuse_lowlevel.c	2020-09-01 15:22:31.449707002 -0400
+++ qemu/tools/virtiofsd/fuse_lowlevel.c	2020-09-01 15:23:18.777668583 -0400
@@ -2218,6 +2218,15 @@ static void do_init(fuse_req_t req, fuse
         outarg.map_alignment = ffsl(sysconf(_SC_PAGE_SIZE)) - 1;
     }
 
+    if (arg->flags & FUSE_NONSHARED_FS) {
+        /*
+         * By default virtiofs is not shared. Once we support sharing,
+         * this will be have to a conditional and driven by user's
+         * selection.
+         */
+         outarg.flags |= FUSE_NONSHARED_FS;
+    }
+
     fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outarg.minor);
     fuse_log(FUSE_LOG_DEBUG, "   flags=0x%08x\n", outarg.flags);
     fuse_log(FUSE_LOG_DEBUG, "   max_readahead=0x%08x\n", outarg.max_readahead);

