Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98255DD8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbiF0RQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbiF0RQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:16:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A56390
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 10:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C39FB810FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 17:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863BAC3411D;
        Mon, 27 Jun 2022 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656350182;
        bh=lsYrEOvS+z6tfV9fHH9LsrqQOjwnmHU2brHTgMpzBcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxDmjTuYZSktghf6FYng/MW+8aP8yW1ldGOE6u6D1s4gmweo0yX2cdmv32f1vS4kf
         vHTrrxAK2r0xOXLDlCl57ZOR5RRki9XSY1hLPhucNtvJqAnG0RWuF0G7Yxpb4WENNh
         ixQOjbgVyIpzp62p+VISDEFhlRH3c0ZKQj0yJzfwOioumLjsC7y3VWSANP0fYD5Zn8
         zMYoaerURtuiiRYKoyeSX2+oSQOWbral4EvMG1mF1EOxwz3ylo16tBIcWDrghfXptR
         YSt765QhB8A1Duug+xcCwsObQ6Ycz8x6Fx3jxWE2CEgV3hhM1yj1SPhDy+tbvUAx+x
         j5LhjyLAO2aQw==
Date:   Mon, 27 Jun 2022 19:16:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, clm@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v4] fuse: Add module param for CAP_SYS_ADMIN access
 bypassing allow_other
Message-ID: <20220627171617.77epjb3lppofqwg4@wittgenstein>
References: <20220617204821.1821592-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220617204821.1821592-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:48:21PM -0700, Dave Marchevsky wrote:
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
> into FUSE filesystems mounted by processes in child namespaces.
> 
> This patch adds a module param, allow_sys_admin_access, to act as an
> escape hatch for this descendant userns logic and for the allow_other
> mount option in general. Setting allow_sys_admin_access allows
> processes with CAP_SYS_ADMIN in the initial userns to access FUSE
> filesystems irrespective of the mounting userns or whether allow_other
> was set. A sysadmin setting this param must trust FUSEs on the host to
> not DoS processes as described in 73f03c2b4b52.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

Fine by me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Now that documentation clearly reflects the semantics and possible
dangers I think this is ok to do.

> 
> v3 -> v4: lore.kernel.org/linux-fsdevel/20220617004710.621301-1-davemarchevsky@fb.com
>   * Add discussion of new module option and allow_other userns
>     interaction in docs (Christian)
> 
> v2 -> v3: lore.kernel.org/linux-fsdevel/20220601184407.2086986-1-davemarchevsky@fb.com
>   * Module param now allows initial userns CAP_SYS_ADMIN to bypass allow_other
>     check entirely
> 
> v1 -> v2: lore.kernel.org/linux-fsdevel/20211111221142.4096653-1-davemarchevsky@fb.com
>   * Use module param instead of capability check
> 
>  Documentation/filesystems/fuse.rst | 29 ++++++++++++++++++++++++-----
>  fs/fuse/dir.c                      | 10 ++++++++++
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
> index 8120c3c0cb4e..1e31e87aee68 100644
> --- a/Documentation/filesystems/fuse.rst
> +++ b/Documentation/filesystems/fuse.rst
> @@ -279,7 +279,7 @@ How are requirements fulfilled?
>  	the filesystem or not.
>  
>  	Note that the *ptrace* check is not strictly necessary to
> -	prevent B/2/i, it is enough to check if mount owner has enough
> +	prevent C/2/i, it is enough to check if mount owner has enough
>  	privilege to send signal to the process accessing the
>  	filesystem, since *SIGSTOP* can be used to get a similar effect.
>  
> @@ -288,10 +288,29 @@ I think these limitations are unacceptable?
>  
>  If a sysadmin trusts the users enough, or can ensure through other
>  measures, that system processes will never enter non-privileged
> -mounts, it can relax the last limitation with a 'user_allow_other'
> -config option.  If this config option is set, the mounting user can
> -add the 'allow_other' mount option which disables the check for other
> -users' processes.
> +mounts, it can relax the last limitation in several ways:
> +
> +  - With the 'user_allow_other' config option. If this config option is
> +    set, the mounting user can add the 'allow_other' mount option which
> +    disables the check for other users' processes.
> +
> +    User namespaces have an unintuitive interaction with 'allow_other':
> +    an unprivileged user - normally restricted from mounting with
> +    'allow_other' - could do so in a user namespace where they're
> +    privileged. If any process could access such an 'allow_other' mount
> +    this would give the mounting user the ability to manipulate
> +    processes in user namespaces where they're unprivileged. For this
> +    reason 'allow_other' restricts access to users in the same userns
> +    or a descendant.
> +
> +  - With the 'allow_sys_admin_access' module option. If this option is
> +    set, super user's processes have unrestricted access to mounts
> +    irrespective of allow_other setting or user namespace of the
> +    mounting user.
> +
> +Note that both of these relaxations expose the system to potential
> +information leak or *DoS* as described in points B and C/2/i-ii in the
> +preceding section.
>  
>  Kernel - userspace interface
>  ============================
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 9dfee44e97ad..d325d2387615 100644
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
> +static bool __read_mostly allow_sys_admin_access;
> +module_param(allow_sys_admin_access, bool, 0644);
> +MODULE_PARM_DESC(allow_sys_admin_access,
> + "Allow users with CAP_SYS_ADMIN in initial userns "
> + "to bypass allow_other access check");
> +
>  static void fuse_advise_use_readdirplus(struct inode *dir)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(dir);
> @@ -1229,6 +1236,9 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  {
>  	const struct cred *cred;
>  
> +	if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> +		return 1;
> +
>  	if (fc->allow_other)
>  		return current_in_userns(fc->user_ns);
>  
> -- 
> 2.30.2
> 
