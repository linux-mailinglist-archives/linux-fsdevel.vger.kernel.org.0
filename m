Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC914DCFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 15:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgA3OpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 09:45:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60653 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3OpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:45:22 -0500
Received: from [109.134.33.162] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ixB4K-0002Bk-94; Thu, 30 Jan 2020 14:45:20 +0000
Date:   Thu, 30 Jan 2020 15:45:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 04/17] follow_automount() doesn't need the entire
 nameidata
Message-ID: <20200130144520.hnf2yk5tjalxfddn@wittgenstein>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
 <20200119031738.2681033-4-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200119031738.2681033-4-viro@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 19, 2020 at 03:17:16AM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> only the address of ->total_link_count and the flags
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namei.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index d30a74a18da9..3b6f60c02f8a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1133,7 +1133,7 @@ EXPORT_SYMBOL(follow_up);
>   * - return -EISDIR to tell follow_managed() to stop and return the path we
>   *   were called with.
>   */
> -static int follow_automount(struct path *path, struct nameidata *nd)
> +static int follow_automount(struct path *path, int *count, unsigned lookup_flags)
>  {
>  	struct dentry *dentry = path->dentry;
>  
> @@ -1148,13 +1148,12 @@ static int follow_automount(struct path *path, struct nameidata *nd)
>  	 * as being automount points.  These will need the attentions
>  	 * of the daemon to instantiate them before they can be used.
>  	 */
> -	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
> +	if (!(lookup_flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
>  			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>  	    dentry->d_inode)
>  		return -EISDIR;
>  
> -	nd->total_link_count++;
> -	if (nd->total_link_count >= 40)
> +	if (count && *count++ >= 40)

He, side-effects galore. :)
Isn't this incrementing the address but you want to increment the
counter?
Seems like this should be

if (count && (*count)++ >= 40)

and even then it seems to me not incrementing at all when we have hit
the limit seems more natural?

Christian
