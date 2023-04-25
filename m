Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBCA6EDC59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjDYHSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDYHSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:18:37 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 00:18:35 PDT
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6D664ED5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 00:18:35 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rCpKpcPOC0ulprCpKpYEyY; Tue, 25 Apr 2023 09:11:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682406663;
        bh=HsVyTMR83ttxuxKZQEOXlJIEnSx7WFKLjIUf5uGlz4k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=K6ZFNMvQnqvN61urx9LXNTzA6mMEvkC3DY5Uwq8pOIyr6z2zS6MqJ8mECK2iClJwR
         uDHePAGgIY+PErtHVMsNS+miKnJF/ePoGyWxjzpb1D0RX6tg++szbb8GtvIymQpd1n
         ekHsBJsb58p/PGF7HVgDKfFsSjwnqKBl8SD0cuIhJZ/OKW2ZjWmd+6/5nTOEPhn2VP
         hsC/rwIfWIRYrkn10e7H2N+iHdRP2dHJAewozjtACiBuOYYRT/vT/1e3AgWRN7q2jR
         8lfHzDnwVXkLnsHYDuBG0VnaSUs7BSSX/UOv3VEGJWxqOX7I5efuQyysVd7VEcQc0D
         qOvP+Bs1f22OA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 09:11:03 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7686c810-4ed6-9e3a-3714-8b803e2d3c46@wanadoo.fr>
Date:   Tue, 25 Apr 2023 09:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] fs/9p: remove writeback fid and fix per-file modes
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net
Cc:     asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com
References: <20230218003323.2322580-11-ericvh@kernel.org>
 <ZCEGmS4FBRFClQjS@7e9e31583646>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZCEGmS4FBRFClQjS@7e9e31583646>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 27/03/2023 à 04:59, Eric Van Hensbergen a écrit :
> This patch removes the creating of an additional writeback_fid
> for opened files.  The patch addresses problems when files
> were opened write-only or getattr on files with dirty caches.
> 
> This patch also incorporates information about cache behavior
> in the fid for every file.  This allows us to reflect cache
> behavior from mount flags, open mode, and information from
> the server to inform readahead and writeback behavior.
> 
> This includes adding support for a 9p semantic that qid.version==0
> is used to mark a file as non-cachable which is important for
> synthetic files.  This may have a side-effect of not supporting
> caching on certain legacy file servers that do not properly set
> qid.version.  There is also now a mount flag which can disable
> the qid.version behavior.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>   fs/9p/fid.c            | 48 +++++++++-------------
>   fs/9p/fid.h            | 33 ++++++++++++++-
>   fs/9p/v9fs.h           |  1 -
>   fs/9p/vfs_addr.c       | 22 +++++-----
>   fs/9p/vfs_file.c       | 91 ++++++++++++++----------------------------
>   fs/9p/vfs_inode.c      | 45 +++++++--------------
>   fs/9p/vfs_inode_dotl.c | 48 +++++++++-------------
>   fs/9p/vfs_super.c      | 33 ++++-----------
>   8 files changed, 135 insertions(+), 186 deletions(-)
> 

Hi,

this patch has already reached -next, but there is some spurious code.

As, I'm not sure what the real intent is, I prefer to reply here instead 
of sending a patch.


[...]

> @@ -817,9 +814,14 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
>   
>   	v9ses = v9fs_inode2v9ses(dir);
>   	perm = unixmode2p9mode(v9ses, mode);
> -	fid = v9fs_create(v9ses, dir, dentry, NULL, perm,
> -				v9fs_uflags2omode(flags,
> -						v9fs_proto_dotu(v9ses)));
> +	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
> +
> +	if ((v9ses->cache >= CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
> +		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;

This code looks strange.
P9_OWRITE is 0x01, so !P9_OWRITE is 0.
So the code is equivalent to "p9_omode = P9_ORDWR;"

Is it what is expexted?

Maybe
	p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
?

> +		p9_debug(P9_DEBUG_CACHE,
> +			"write-only file with writeback enabled, creating w/ O_RDWR\n");
> +	}
> +	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
>   	if (IS_ERR(fid)) {
>   		err = PTR_ERR(fid);
>   		goto error;

[...]

> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index a28eb3aeab29..4b9488cb7a56 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -232,12 +232,12 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>   	int err = 0;
>   	kgid_t gid;
>   	umode_t mode;
> +	int p9_omode = v9fs_open_to_dotl_flags(flags);
>   	const unsigned char *name = NULL;
>   	struct p9_qid qid;
>   	struct inode *inode;
>   	struct p9_fid *fid = NULL;
> -	struct v9fs_inode *v9inode;
> -	struct p9_fid *dfid = NULL, *ofid = NULL, *inode_fid = NULL;
> +	struct p9_fid *dfid = NULL, *ofid = NULL;
>   	struct v9fs_session_info *v9ses;
>   	struct posix_acl *pacl = NULL, *dacl = NULL;
>   	struct dentry *res = NULL;
> @@ -282,14 +282,19 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>   	/* Update mode based on ACL value */
>   	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
>   	if (err) {
> -		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat %d\n",
> +		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in create %d\n",
>   			 err);
>   		goto out;
>   	}
> -	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
> -				    mode, gid, &qid);
> +
> +	if ((v9ses->cache >= CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
> +		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;

Same here.

CJ

> +		p9_debug(P9_DEBUG_CACHE,
> +			"write-only file with writeback enabled, creating w/ O_RDWR\n");
> +	}
> +	err = p9_client_create_dotl(ofid, name, p9_omode, mode, gid, &qid);
>   	if (err < 0) {
> -		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
> +		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in create %d\n",
>   			 err);
>   		goto out;
>   	}

