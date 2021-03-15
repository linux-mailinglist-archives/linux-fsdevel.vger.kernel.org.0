Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450F733C390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhCORJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234184AbhCORIz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A15F61494;
        Mon, 15 Mar 2021 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615828135;
        bh=NPhL1YlgUxxI25d29OfqBymy6lFh47nfLoh6850iVNI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZvV5iSI2f2IdhwRH/tvaXHCJhZsrJvO8JozwuWklLCxIS1q3fW2WUwmYw2mDeogKz
         Yw2h71KkIMkiqfTOiqa9SHZWRYwmkxnyp0zKw9ZMFdmARh/ibC70h4j5+YDVh4Uhcx
         DmbDOnFYadmdiqjEdlNykh25N1uCNSb4IKnSJ2ZQKfgmHKYw8ZyZoz8Hi5mE21Yrqm
         9+Vx6HwadGxLyiP8MY6i3EuTzTAIcSIEGFY8lIZ5HTxcOUUPKlOWW25X+LkqlA8Hkz
         N1cmxsbpQGamUsyGbOvb7sQGtv2teuXjQE7sFmxF6SvquIZTfJau7bwbKWI+uneMLp
         HeJ9xsonFspTA==
Message-ID: <33555846ce325ceb7b282f359861fbbcf22840ec.camel@kernel.org>
Subject: Re: [PATCH v2 10/15] cifs: have ->mkdir() handle race with another
 client sanely
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
Date:   Mon, 15 Mar 2021 13:08:53 -0400
In-Reply-To: <20210313043824.1283821-10-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
         <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
         <20210313043824.1283821-10-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-03-13 at 04:38 +0000, Al Viro wrote:
> if we have mkdir request reported successful *and* simulating lookup
> gets us a non-directory (which is possible if another client has
> managed to get rmdir and create in between), the sane action is not
> to mangle ->i_mode of non-directory inode to S_IFDIR | mode, it's
> "report success and return with dentry negative unhashed" - that
> way the next lookup will do the right thing.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/cifs/inode.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index d46b36d52211..80c487fcf10e 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -1739,6 +1739,16 @@ cifs_mkdir_qinfo(struct inode *parent, struct dentry *dentry, umode_t mode,
>  	if (rc)
>  		return rc;
>  
> 
> +	if (!S_ISDIR(inode->i_mode)) {
> +		/*
> +		 * mkdir succeeded, but another client has managed to remove the
> +		 * sucker and replace it with non-directory.  Return success,
> +		 * but don't leave the child in dcache.
> +		 */
> +		 iput(inode);
> +		 d_drop(dentry);
> +		 return 0;
> +	}
>  	/*
>  	 * setting nlink not necessary except in cases where we failed to get it
>  	 * from the server or was set bogus. Also, since this is a brand new
> @@ -1790,7 +1800,7 @@ cifs_mkdir_qinfo(struct inode *parent, struct dentry *dentry, umode_t mode,
>  		}
>  	}
>  	d_instantiate(dentry, inode);
> -	return rc;
> +	return 0;
>  }
>  
> 
>  static int

Reviewed-by: Jeff Layton <jlayton@kernel.org>

