Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03733C3BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhCORMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234431AbhCORMJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6AF564E99;
        Mon, 15 Mar 2021 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615828328;
        bh=I3pRBUwSpdfZFbCEJdEZhaXlV/7cL3dhS7d1Tr9fopg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ePZc4bV2v72YeXfwQp77jV/x/zPRBIuWHq+MNcHpQ+vVuobPCxNBfQGOQBv/oPQ+C
         NB/EaGq80F15m/ZdA4YQzehsWhn9G2DjwZnWyiZCsijHIRVl/G5PV5fK8SYmRKM06X
         afzF0ycQBZHpecRdiLXF5gLNUTiD6ecH1mkwXApQUueaNpcguiJMirLSihatWn8B7p
         q5Cph0/wV9lErA6chbz34U0zue/pqC+UkG2uaJ1X9B1zcF8cBQiga2f+KrYmoQDudu
         rtLjdtYw6P1N3E7Isy8lzu0UZUTjeojk4mjwpT6KhFFZNyP0Ss2mUmDxIhCAZ0bKtA
         9V3nv/x8JJZiA==
Message-ID: <dfd701cc48c7ff379f5a4abe074b2e4c46abca86.camel@kernel.org>
Subject: Re: [PATCH v2 09/15] do_cifs_create(): don't set ->i_mode of
 something we had not created
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Mar 2021 13:12:06 -0400
In-Reply-To: <20210313043824.1283821-9-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
         <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
         <20210313043824.1283821-9-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-03-13 at 04:38 +0000, Al Viro wrote:
> If the file had existed before we'd called ->atomic_open() (without
> O_EXCL, that is), we have no more business setting ->i_mode than
> we would setting ->i_uid or ->i_gid.  We also have no business
> doing either if another client has managed to get unlink+mkdir
> between ->open() and cifs_inode_get_info().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/cifs/dir.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index a3fb81e0ba17..9d7ae93c8af7 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -418,15 +418,16 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
>  		if (newinode) {
>  			if (server->ops->set_lease_key)
>  				server->ops->set_lease_key(newinode, fid);
> -			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM)
> -				newinode->i_mode = mode;
> -			if ((*oplock & CIFS_CREATE_ACTION) &&
> -			    (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID)) {
> -				newinode->i_uid = current_fsuid();
> -				if (inode->i_mode & S_ISGID)
> -					newinode->i_gid = inode->i_gid;
> -				else
> -					newinode->i_gid = current_fsgid();
> +			if ((*oplock & CIFS_CREATE_ACTION) && S_ISREG(newinode->i_mode)) {
> +				if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM)
> +					newinode->i_mode = mode;
> +				if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
> +					newinode->i_uid = current_fsuid();
> +					if (inode->i_mode & S_ISGID)
> +						newinode->i_gid = inode->i_gid;
> +					else
> +						newinode->i_gid = current_fsgid();
> +				}
>  			}
>  		}
>  	}

Reviewed-by: Jeff Layton <jlayton@kernel.org>

