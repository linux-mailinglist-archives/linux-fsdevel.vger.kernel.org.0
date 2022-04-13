Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CF4FF16C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 10:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiDMIKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiDMIKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3C2E9C2;
        Wed, 13 Apr 2022 01:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F50C6176A;
        Wed, 13 Apr 2022 08:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D273C385A3;
        Wed, 13 Apr 2022 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649837262;
        bh=TR5TOj+uquiYvhqOuy8mg9E7JyxFciDpah6gIYT+RCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLXe0jlL+clTajczhNm8PBGeZGu9MezrckDFfNHhAfDVlPn/Jg55k4rQte52RMTgF
         F28eszbIzwUv7mPzCJM3EDArt3UtncRgwKdP//bNQbdUKvEFVRlwm5dP/6JnriJBB9
         sqyAiHu8/zYAqH6ZeR1cIzoAogXIwvGRdG8JSwQLg5UfSmzF82Hkn2LJJ/8G0i158n
         oGEZTwZxdEmVU9u+JXb6lhvSeGrNZdqbo04e9j2U0aoZ2oto0MzR86NSf+EADs6FN0
         RRmHXnvLQC+ORozs6DAC/VePfMMHlGgRTDqIis0O9AQ7IjDNv5vN33BEgHuIRpKAOz
         4JIK3rgnBWQxw==
Date:   Wed, 13 Apr 2022 10:07:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3 3/5] idmapped-mounts: Add open with O_TMPFILE
 operation in setgid test
Message-ID: <20220413080733.6sz3tssi4wo3jc67@wittgenstein>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649763226-2329-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649763226-2329-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 07:33:44PM +0800, Yang Xu wrote:
> Since we can create temp file by using O_TMPFILE flag and filesystem driver also
> has this api, we should also check this operation whether strip S_ISGID.
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 148 ++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index 617f56e0..02f91558 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -51,6 +51,7 @@
>  #define FILE1_RENAME "file1_rename"
>  #define FILE2 "file2"
>  #define FILE2_RENAME "file2_rename"
> +#define FILE3 "file3"
>  #define DIR1 "dir1"
>  #define DIR2 "dir2"
>  #define DIR3 "dir3"
> @@ -337,6 +338,24 @@ out:
>  	return fret;
>  }
>  
> +static bool openat_tmpfile_supported(int dirfd)
> +{
> +	int fd = -1;
> +
> +	fd = openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +	if (fd == -1) {
> +		if (errno == ENOTSUP)
> +			return false;
> +		else
> +			return log_errno(false, "failure: create");
> +	}
> +
> +	if (close(fd))
> +		log_stderr("failure: close");
> +
> +	return true;
> +}
> +
>  /* __expected_uid_gid - check whether file is owned by the provided uid and gid */
>  static bool __expected_uid_gid(int dfd, const char *path, int flags,
>  			       uid_t expected_uid, gid_t expected_gid, bool log)
> @@ -7841,7 +7860,10 @@ static int setgid_create(void)
>  {
>  	int fret = -1;
>  	int file1_fd = -EBADF;
> +	int tmpfile_fd = -EBADF;
>  	pid_t pid;
> +	bool supported = false;
> +	char path[PATH_MAX];
>  
>  	if (!caps_supported())
>  		return 0;
> @@ -7866,6 +7888,8 @@ static int setgid_create(void)
>  		goto out;
>  	}
>  
> +	supported = openat_tmpfile_supported(t_dir1_fd);
> +
>  	pid = fork();
>  	if (pid < 0) {
>  		log_stderr("failure: fork");
> @@ -7929,6 +7953,25 @@ static int setgid_create(void)
>  		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
>  			die("failure: delete");
>  
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, t_dir1_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");

Fwiw, I don't think you need that snprintf() dance as you should be able
to use AT_EMPTY_PATH:

if (linkat(fd, "", t_dir1_fd, FILE3, AT_EMPTY_PATH))

for this.
