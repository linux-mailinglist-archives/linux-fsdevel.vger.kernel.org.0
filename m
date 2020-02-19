Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3E163A63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 03:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBSCmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 21:42:35 -0500
Received: from mail.hallyn.com ([178.63.66.53]:49664 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgBSCmf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:42:35 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 170EEB83; Tue, 18 Feb 2020 20:42:33 -0600 (CST)
Date:   Tue, 18 Feb 2020 20:42:33 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 09/25] fs: add is_userns_visible() helper
Message-ID: <20200219024233.GA19334@mail.hallyn.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-10-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143411.2389182-10-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:33:55PM +0100, Christian Brauner wrote:
> Introduce a helper which makes it possible to detect fileystems whose
> superblock is visible in multiple user namespace. This currently only
> means proc and sys. Such filesystems usually have special semantics so their
> behavior will not be changed with the introduction of fsid mappings.

Hi,

I'm afraid I've got a bit of a hangup about the terminology here.  I
*think* what you mean is that SB_I_USERNS_VISIBLE is an fs whose uids are
always translated per the id mappings, not fsid mappings.  But when I see
the name it seems to imply that !SB_I_USERNS_VISIBLE filesystems can't
be seen by other namespaces at all.

Am I right in my first interpretation?  If so, can we talk about the
naming?

> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
> 
> /* v3 */
> unchanged
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..fdc8fb2d786b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3651,4 +3651,9 @@ static inline int inode_drain_writes(struct inode *inode)
>  	return filemap_write_and_wait(inode->i_mapping);
>  }
>  
> +static inline bool is_userns_visible(unsigned long iflags)
> +{
> +	return (iflags & SB_I_USERNS_VISIBLE);
> +}
> +
>  #endif /* _LINUX_FS_H */
> -- 
> 2.25.0
