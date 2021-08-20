Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB193F34C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 21:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhHTTqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 15:46:18 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:57662 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbhHTTqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:46:18 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHASE-00ESrA-C0; Fri, 20 Aug 2021 19:45:26 +0000
Date:   Fri, 20 Aug 2021 19:45:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        david@redhat.com, willy@infradead.org, linux-nfs@vger.kernel.org,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, luto@kernel.org, bfields@fieldses.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v3 2/2] fs: remove mandatory file locking support
Message-ID: <YSAGVsTOc/Fw0x8l@zeniv-ca.linux.org.uk>
References: <20210820163919.435135-1-jlayton@kernel.org>
 <20210820163919.435135-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820163919.435135-3-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:39:19PM -0400, Jeff Layton wrote:

> diff --git a/fs/locks.c b/fs/locks.c

> @@ -2857,8 +2744,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  			seq_puts(f, "POSIX ");
>  
>  		seq_printf(f, " %s ",
> -			     (inode == NULL) ? "*NOINODE*" :
> -			     mandatory_lock(inode) ? "MANDATORY" : "ADVISORY ");
> +			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");

Huh?

<looks>
        if (fl->fl_file != NULL)
		inode = locks_inode(fl->fl_file);

So basically that's fl->fl_file ? "ADVISORY" : "*NOINODE*"?

How could that trigger, though?  With locks_mandatory_area() gone, I don't
see how FL_POSIX file_lock with NULL ->fl_file could be ever found...
Confused...

Why is locks_copy_conflock() exported (hell, non-static), BTW?

> diff --git a/fs/namespace.c b/fs/namespace.c


> -#ifdef	CONFIG_MANDATORY_FILE_LOCKING
> -static bool may_mandlock(void)
> +static void warn_mandlock(void)
>  {
> -	pr_warn_once("======================================================\n"
> -		     "WARNING: the mand mount option is being deprecated and\n"
> -		     "         will be removed in v5.15!\n"
> -		     "======================================================\n");
> -	return capable(CAP_SYS_ADMIN);
> +	pr_warn_once("=======================================================\n"
> +		     "WARNING: The mand mount option has been deprecated and\n"
> +		     "         and is ignored by this kernel. Remove the mand\n"
> +		     "         option from the mount to silence this warning.\n"
> +		     "=======================================================\n");
>  }
> -#else
> -static inline bool may_mandlock(void)
> -{
> -	pr_warn("VFS: \"mand\" mount option not supported");
> -	return false;
> -}
> -#endif

Is there any point in having the previous patch not folded into this one?
