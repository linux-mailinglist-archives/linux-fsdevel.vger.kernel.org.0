Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA51C4F80DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiDGNmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiDGNmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:42:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34974DDF;
        Thu,  7 Apr 2022 06:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1113CB8254E;
        Thu,  7 Apr 2022 13:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F64C385A0;
        Thu,  7 Apr 2022 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649338813;
        bh=nt2Qi0JtDehpqgqmMLo1nhpk1Y0xkOOP1NzwCDORdSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex0dPnq562Luk799ET88o8kQHQyMaPk1Mfu03RcSgCkGHGzJBt3UXclPaa2DM2ivd
         n4IRh0zTXTg3NqnOIfgGbJOU3NQRIe5HKXjCEAk06v3UoTQnfo0P1yGWZJC7Mebre0
         qTL2AR1ujiH2Rz/x7HwUR4Vzldzqy0jkJnFqs2YynXVdTuBrPIgvJKHgNOZxRQjguD
         /a7OlHkox/GWVfO65un3lmJLWadGYiyYSsHzjlX/GvZoAQSZS/XbUCbff98Ifg7dkT
         zmB2WviDQyJqlEiqE/7kpaXqq3oOLLvz9/o546DCYh4e+9P+z/TmJVIq22gof1KfPu
         DgUpuMJ81CKcA==
Date:   Thu, 7 Apr 2022 15:40:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/6] idmapped-mounts: Add mknodat operation in setgid
 test
Message-ID: <20220407134009.s4shhomfxjz5cf5r@wittgenstein>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649333375-2599-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:09:31PM +0800, Yang Xu wrote:
> Since mknodat can create file, we should also check whether strip S_ISGID.
> Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
> depond on this cap and keep other cap(ie CAP_MKNOD) because create character
> device needs it when using mknod.
> 
> Only test mknodat with character device in setgid_create function because the another
> two functions test mknodat with whiteout device.
> 
> Since kernel commit a3c751a50 ("vfs: allow unprivileged whiteout creation") in
> v5.8-rc1, we can create whiteout device in userns test. Since kernel 5.12, mount_setattr
> and MOUNT_ATTR_IDMAP was supported, we don't need to detect kernel whether allow
> unprivileged whiteout creation. Using fs_allow_idmap as a proxy is safe.
> 
> Tested-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 190 +++++++++++++++++++++++++-
>  1 file changed, 183 insertions(+), 7 deletions(-)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index dff6820f..e8a856de 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -241,6 +241,34 @@ static inline bool caps_supported(void)
>  	return ret;
>  }
>  
> +static int caps_down_fsetid(void)
> +{
> +	bool fret = false;
> +#ifdef HAVE_SYS_CAPABILITY_H
> +	cap_t caps = NULL;
> +	cap_value_t cap = CAP_FSETID;
> +	int ret = -1;
> +
> +	caps = cap_get_proc();
> +	if (!caps)
> +		goto out;
> +
> +	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret = cap_set_proc(caps);
> +	if (ret)
> +		goto out;
> +
> +	fret = true;
> +
> +out:
> +	cap_free(caps);
> +#endif
> +	return fret;
> +}
> +
>  /* caps_down - lower all effective caps */
>  static int caps_down(void)
>  {
> @@ -7805,8 +7833,8 @@ out_unmap:
>  #endif /* HAVE_LIBURING_H */
>  
>  /* The following tests are concerned with setgid inheritance. These can be
> - * filesystem type specific. For xfs, if a new file or directory is created
> - * within a setgid directory and irix_sgid_inhiert is set then inherit the
> + * filesystem type specific. For xfs, if a new file or directory or node is
> + * created within a setgid directory and irix_sgid_inhiert is set then inherit the
>   * setgid bit if the caller is in the group of the directory.
>   */
>  static int setgid_create(void)
> @@ -7863,15 +7891,41 @@ static int setgid_create(void)
>  		if (!is_setgid(t_dir1_fd, DIR1, 0))
>  			die("failure: is_setgid");
>  
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(t_dir1_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
> +			die("failure: mknodat");

Can you please replace 0755 with the corresponding flags everywhere?
I personally find them easier to parse but it's also what we've been
using mostly everywhere in the testsuite.

> +
> +		if (!is_setgid(t_dir1_fd, DIR1 "/" FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		/* create a character device via mknodat() vfs_mknod */
> +		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, makedev(5, 1)))
> +			die("failure: mknodat");
> +
> +		if (!is_setgid(t_dir1_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
>  		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
>  			die("failure: check ownership");
>  
> +		if (!expected_uid_gid(t_dir1_fd, DIR1 "/" FILE1, 0, 0, 0))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
> +			die("failure: check ownership");
> +
>  		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
>  			die("failure: check ownership");
>  
>  		if (unlinkat(t_dir1_fd, FILE1, 0))
>  			die("failure: delete");
>  
> +		if (unlinkat(t_dir1_fd, DIR1 "/" FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
>  		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
>  			die("failure: delete");
>  
> @@ -7889,8 +7943,8 @@ static int setgid_create(void)
>  		if (!switch_ids(0, 10000))
>  			die("failure: switch_ids");
>  
> -		if (!caps_down())
> -			die("failure: caps_down");
> +		if (!caps_down_fsetid())
> +			die("failure: caps_down_fsetid");
>  
>  		/* create regular file via open() */
>  		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> @@ -7917,6 +7971,19 @@ static int setgid_create(void)
>  				die("failure: is_setgid");
>  		}
>  
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(t_dir1_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(t_dir1_fd, DIR1 "/" FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		/* create a character device via mknodat() vfs_mknod */
> +		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, makedev(5, 1)))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(t_dir1_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");

Right above this section you can see the following:

		if (xfs_irix_sgid_inherit_enabled()) {
			/* We're not in_group_p(). */
			if (is_setgid(t_dir1_fd, DIR1, 0))
				die("failure: is_setgid");
		} else {

which tests xfs specific behavior. If this is turned on then
t_dir1_fd/DIR1 won't bet a setgid directory.

Consequently the test:

		/* create a special file via mknodat() vfs_create */
		if (mknodat(t_dir1_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
			die("failure: mknodat");

		if (is_setgid(t_dir1_fd, DIR1 "/" FILE1, 0))
			die("failure: is_setgid");

will fail because the branch in the kernel that strips the setgid bit
won't be hit.

So afiact, you need to ensure that the setgid bit is raised in the if
(xfs_irix_sgid_inherit_enabled()) branch after having verified that the
directory hasn't inherited the setgid bit with the legacy irix behavior.

If you don't do that then the test will be a false negative for xfs with
the sysctl turned on. It's super rare but it'll be annoying if we have
to track this down later.
