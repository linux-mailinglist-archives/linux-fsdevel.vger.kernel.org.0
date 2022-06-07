Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE153F894
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiFGItG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbiFGIsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:48:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F4419AE
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 01:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1A5AB81DA6
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 08:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B61BC385A5;
        Tue,  7 Jun 2022 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654591650;
        bh=5toDH5vzxjpFX5QTO3J3WkWEC+LSds2wTBAsR5+qmMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpMNnJIbVCUJ8IKvEB6NkpEHoaRTVTUe0GuUOYyadV+oo3hSgqkQfDIEhUSfjKiYo
         qhvX8+htVGBIVlJyguQFIoS9aOPF6Ax7N1fuHKacPU/PvueOepcQCXSD+0/l7CFkLf
         +NAR9dJI77xYRgQQzIN/OF6Ub1RPL/S0v6G3ZG4ut4YiPY34gy5vUwcvPGHZumd1J3
         fOR6vYmbghcQf3EgCRoSG3yJnc6h84uqdPfNHftcD4Jm0GLsTpTk1cCF9bdCvLVowa
         iCcMh1Sqx9EnoxnHPZP4aB6B3Ne6KYrDStM92B+stZtrCH5B1Tv8Pj3x/um2QpFiXv
         SMNa46QiZZLaQ==
Date:   Tue, 7 Jun 2022 10:47:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, clm@fb.com
Subject: Re: [PATCH v2] fuse: Add module param for non-descendant userns
 access to allow_other
Message-ID: <20220607084724.7gseviks4h2seeza@wittgenstein>
References: <20220601184407.2086986-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601184407.2086986-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:44:07AM -0700, Dave Marchevsky wrote:
> Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
> superblock's namespace or a descendant"), access to allow_other FUSE
> filesystems has been limited to users in the mounting user namespace or
> descendants. This prevents a process that is privileged in its userns -
> but not its parent namespaces - from mounting a FUSE fs w/ allow_other
> that is accessible to processes in parent namespaces.
> 
> While this restriction makes sense overall it breaks a legitimate
> usecase: I have a tracing daemon which needs to peek into
> process' open files in order to symbolicate - similar to 'perf'. The
> daemon is a privileged process in the root userns, but is unable to peek
> into FUSE filesystems mounted with allow_other by processes in child
> namespaces.
> 
> This patch adds a module param, allow_other_parent_userns, to act as an
> escape hatch for this descendant userns logic. Setting
> allow_other_parent_userns allows non-descendant-userns processes to
> access FUSEs mounted with allow_other. A sysadmin setting this param
> must trust allow_other FUSEs on the host to not DoS processes as
> described in 73f03c2b4b52.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> 
> This is a followup to a previous attempt to solve same problem in a
> different way: "fuse: allow CAP_SYS_ADMIN in root userns to access
> allow_other mount" [0].
> 
> v1 -> v2:
>   * Use module param instead of capability check
> 
>   [0]: lore.kernel.org/linux-fsdevel/20211111221142.4096653-1-davemarchevsky@fb.com
> 
>  fs/fuse/dir.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 9dfee44e97ad..3d593ae7dc66 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -11,6 +11,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/file.h>
>  #include <linux/fs_context.h>
> +#include <linux/moduleparam.h>
>  #include <linux/sched.h>
>  #include <linux/namei.h>
>  #include <linux/slab.h>
> @@ -21,6 +22,12 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  
> +static bool __read_mostly allow_other_parent_userns;
> +module_param(allow_other_parent_userns, bool, 0644);
> +MODULE_PARM_DESC(allow_other_parent_userns,
> + "Allow users not in mounting or descendant userns "
> + "to access FUSE with allow_other set");

The name of the parameter also suggests that access is granted to parent
userns tasks whereas the change seems to me to allows every task access
to that fuse filesystem independent of what userns they are in.

So even a task in a sibling userns could - probably with rather
elaborate mount propagation trickery - access that fuse filesystem.

AFaict, either the module parameter is misnamed or the patch doesn't
implement the behavior expressed in the name.

The original patch restricted access to a CAP_SYS_ADMIN capable task.
Did we agree that it was a good idea to weaken it to all tasks?
Shouldn't we still just restrict this to CAP_SYS_ADMIN capable tasks in
the initial userns?

> +
>  static void fuse_advise_use_readdirplus(struct inode *dir)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(dir);
> @@ -1230,7 +1237,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  	const struct cred *cred;
>  
>  	if (fc->allow_other)
> -		return current_in_userns(fc->user_ns);
> +		return current_in_userns(fc->user_ns) || allow_other_parent_userns;
>  
>  	cred = current_cred();
>  	if (uid_eq(cred->euid, fc->user_id) &&
> -- 
> 2.30.2
>
