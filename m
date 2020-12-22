Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5058B2E0C95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 16:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgLVPTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 10:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgLVPTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608650277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tTFkFhqQiFvkcjFjc4tkOpbQPJev2vnoHc/ozrwHws=;
        b=Uxe4+pUvEpPH4bN6Ey47ytxc2em1+y0AT2HgNmcsN25eilKXQxQwH4daFAgTjt7m6nYSlo
        J2liz7zV0yJnMKCv63f/D1sqLbp+LmH+PrZAVKPXX/XKZbJUzMf4hRBq7noiPxHTCvOHOq
        rwqe1cSA3kh6kKFPwSLKmpK3pZhPql0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Xve2CONNOLCdr03yvpH2uQ-1; Tue, 22 Dec 2020 10:17:55 -0500
X-MC-Unique: Xve2CONNOLCdr03yvpH2uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85EB1107ACE4;
        Tue, 22 Dec 2020 15:17:53 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-207.rdu2.redhat.com [10.10.114.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10F9C1971C;
        Tue, 22 Dec 2020 15:17:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 934A0220BCF; Tue, 22 Dec 2020 10:17:52 -0500 (EST)
Date:   Tue, 22 Dec 2020 10:17:52 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        willy@infradead.org, jack@suse.cz, neilb@suse.com,
        viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 1/3] vfs: Do not ignore return code from s_op->sync_fs
Message-ID: <20201222151752.GA3248@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-2-vgoyal@redhat.com>
 <878s9qmy68.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s9qmy68.fsf@notabene.neil.brown.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:23:11PM +1100, NeilBrown wrote:

[...]
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 1373a610dc78..b5fb83a734cd 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -30,14 +30,18 @@
> >   */
> >  static int __sync_filesystem(struct super_block *sb, int wait)
> >  {
> > +	int ret, ret2;
> > +
> >  	if (wait)
> >  		sync_inodes_sb(sb);
> >  	else
> >  		writeback_inodes_sb(sb, WB_REASON_SYNC);
> >  
> >  	if (sb->s_op->sync_fs)
> > -		sb->s_op->sync_fs(sb, wait);
> > -	return __sync_blockdev(sb->s_bdev, wait);
> > +		ret = sb->s_op->sync_fs(sb, wait);
> > +	ret2 = __sync_blockdev(sb->s_bdev, wait);
> > +
> > +	return ret ? ret : ret2;
> 
> I'm surprised that the compiler didn't complain that 'ret' might be used
> uninitialized.

Indeed. That "ret" can be used uninitialized. Here is the fixed patch.


Subject: vfs: Do not ignore return code from s_op->sync_fs

Current implementation of __sync_filesystem() ignores the
return code from ->sync_fs(). I am not sure why that's the case.

Ignoring ->sync_fs() return code is problematic for overlayfs where
it can return error if sync_filesystem() on upper super block failed.
That error will simply be lost and sycnfs(overlay_fd), will get
success (despite the fact it failed).

Al Viro noticed that there are other filesystems which can sometimes
return error in ->sync_fs() and these errors will be ignored too.

fs/btrfs/super.c:2412:  .sync_fs        = btrfs_sync_fs,
fs/exfat/super.c:204:   .sync_fs        = exfat_sync_fs,
fs/ext4/super.c:1674:   .sync_fs        = ext4_sync_fs,
fs/f2fs/super.c:2480:   .sync_fs        = f2fs_sync_fs,
fs/gfs2/super.c:1600:   .sync_fs                = gfs2_sync_fs,
fs/hfsplus/super.c:368: .sync_fs        = hfsplus_sync_fs,
fs/nilfs2/super.c:689:  .sync_fs        = nilfs_sync_fs,
fs/ocfs2/super.c:139:   .sync_fs        = ocfs2_sync_fs,
fs/overlayfs/super.c:399:	.sync_fs        = ovl_sync_fs,
fs/ubifs/super.c:2052:  .sync_fs       = ubifs_sync_fs,

Hence, this patch tries to fix it and capture error returned
by ->sync_fs() and return to caller. I am specifically interested
in syncfs() path and return error to user.

I am assuming that we want to continue to call __sync_blockdev()
despite the fact that there have been errors reported from
->sync_fs(). So this patch continues to call __sync_blockdev()
even if ->sync_fs() returns an error.

Al noticed that there are few other callsites where ->sync_fs() error
code is being ignored. 

sync_fs_one_sb(): For this it seems desirable to ignore the return code.

dquot_disable(): Jan Kara mentioned that ignoring return code here is fine
		 because we don't want to fail dquot_disable() just beacuse
		 caches might be incoherent.

dquot_quota_sync(): Jan thinks that it might make some sense to capture
		    return code here. But I am leaving it untouched for
		   now. When somebody needs it, they can easily fix it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/sync.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: redhat-linux/fs/sync.c
===================================================================
--- redhat-linux.orig/fs/sync.c	2020-12-22 09:56:04.543483440 -0500
+++ redhat-linux/fs/sync.c	2020-12-22 10:01:28.560483440 -0500
@@ -30,14 +30,18 @@
  */
 static int __sync_filesystem(struct super_block *sb, int wait)
 {
+	int ret = 0, ret2;
+
 	if (wait)
 		sync_inodes_sb(sb);
 	else
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 
 	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, wait);
-	return __sync_blockdev(sb->s_bdev, wait);
+		ret = sb->s_op->sync_fs(sb, wait);
+	ret2 = __sync_blockdev(sb->s_bdev, wait);
+
+	return ret ? ret : ret2;
 }
 
 /*

