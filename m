Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8977740B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjHHRIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjHHRHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:07:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959AE1BC3;
        Tue,  8 Aug 2023 09:02:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FF9421C09;
        Tue,  8 Aug 2023 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691489158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOTJYjkBLnwjV/lxEVtUyReuFAMisDvl/3KW3rcsa80=;
        b=RYwrn0fdjwhhRR7l27SfhU6sEIZlfDKsRmqY6BlBC/mbMQlEPGtvhbIdRr7h8egn/oN8yh
        Oz6U9UuTleHENrCE1avR3NSOn0guqcLSLu7iBXijjb70nxn/BQDxhjUWhk7QvvA5/v4PB8
        VNLrqst7KIs78O2ejOjXiqcNSNVttFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691489158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOTJYjkBLnwjV/lxEVtUyReuFAMisDvl/3KW3rcsa80=;
        b=3BwMkd6c3zAZ5/EGX3xW7irKJimW+k7SoacxDa/XvD8/WW5BAqfXsGAeW7PnSgHdphBpnB
        7inqEIuyeW8nM7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2554713451;
        Tue,  8 Aug 2023 10:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9iarCIYT0mRwKwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 08 Aug 2023 10:05:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F18AA0769; Tue,  8 Aug 2023 12:05:57 +0200 (CEST)
Date:   Tue, 8 Aug 2023 12:05:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 13/13] btrfs: convert to multigrain timestamps
Message-ID: <20230808100557.dowlxz2destpseqr@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-13-d1dec143a704@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-mgctime-v7-13-d1dec143a704@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-08-23 15:38:44, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> Beyond enabling the FS_MGTIME flag, this patch eliminates
> update_time_for_write, which goes to great pains to avoid in-memory
> stores. Just have it overwrite the timestamps unconditionally.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: David Sterba <dsterba@suse.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/file.c  | 24 ++++--------------------
>  fs/btrfs/super.c |  5 +++--
>  2 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index d7a9ece7a40b..b9e75c9f95ac 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1106,25 +1106,6 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
>  	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>  }
>  
> -static void update_time_for_write(struct inode *inode)
> -{
> -	struct timespec64 now, ctime;
> -
> -	if (IS_NOCMTIME(inode))
> -		return;
> -
> -	now = current_time(inode);
> -	if (!timespec64_equal(&inode->i_mtime, &now))
> -		inode->i_mtime = now;
> -
> -	ctime = inode_get_ctime(inode);
> -	if (!timespec64_equal(&ctime, &now))
> -		inode_set_ctime_to_ts(inode, now);
> -
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> -}
> -
>  static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
>  			     size_t count)
>  {
> @@ -1156,7 +1137,10 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
>  	 * need to start yet another transaction to update the inode as we will
>  	 * update the inode when we finish writing whatever data we write.
>  	 */
> -	update_time_for_write(inode);
> +	if (!IS_NOCMTIME(inode)) {
> +		inode->i_mtime = inode_set_ctime_current(inode);
> +		inode_inc_iversion(inode);
> +	}
>  
>  	start_pos = round_down(pos, fs_info->sectorsize);
>  	oldsize = i_size_read(inode);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f1dd172d8d5b..8eda51b095c9 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2144,7 +2144,7 @@ static struct file_system_type btrfs_fs_type = {
>  	.name		= "btrfs",
>  	.mount		= btrfs_mount,
>  	.kill_sb	= btrfs_kill_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
> +	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MGTIME,
>  };
>  
>  static struct file_system_type btrfs_root_fs_type = {
> @@ -2152,7 +2152,8 @@ static struct file_system_type btrfs_root_fs_type = {
>  	.name		= "btrfs",
>  	.mount		= btrfs_mount_root,
>  	.kill_sb	= btrfs_kill_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
> +	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
> +			  FS_ALLOW_IDMAP | FS_MGTIME,
>  };
>  
>  MODULE_ALIAS_FS("btrfs");
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
