Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973BF4FF2E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiDMJIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDMJII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C42366AD;
        Wed, 13 Apr 2022 02:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A08761ACA;
        Wed, 13 Apr 2022 09:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC13C385A3;
        Wed, 13 Apr 2022 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649840747;
        bh=ntEzPV9SQU+tQZKOO3Zq9fxRPQVItN/tlHqKDKltSLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fhp5+jtSTodG7A9OE54HBzOB/bYJVrk6+/ecYhUZjdCpl3qTO7byVsGniJ0tJnUDP
         QqY2qbHmcMu3IbPDyPQIkne/POGoiuwK5QqbNBF1sCHxrnEY0RVRNLCpufBmGoDXNL
         0tBa+3n35l14ppErBaGt9lra4YmFYI+XnP6UU9T+JYJAGtj9BKlF/mgBV1/3Z4Y384
         YdBG3QBydjkTtnZcR8sYj/Z4H2lSiQREbUFYgPagVGx3/cPhalZF1ST4IcxqvSNT1W
         paIg/RNSNjK6tY7NbAB87Wo+YhjvjRIQztBsH2rGj69onWSE/tYV+cLSHmMPX1RLP5
         sXmmpt4WgEoGg==
Date:   Wed, 13 Apr 2022 11:05:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] idmapped-mounts: Add mknodat operation in setgid
 test
Message-ID: <20220413090543.wzhi2tg7alfmupk4@wittgenstein>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649763226-2329-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220413075925.f52jcurkieorm2df@wittgenstein>
 <625698B9.9090509@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <625698B9.9090509@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:31:45AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/13 15:59, Christian Brauner wrote:
> > On Tue, Apr 12, 2022 at 07:33:43PM +0800, Yang Xu wrote:
> >> Since mknodat can create file, we should also check whether strip S_ISGID.
> >> Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
> >> depend on this cap and keep other cap(ie CAP_MKNOD) because create character
> >> device needs it when using mknod.
> >>
> >> Only test mknodat with character device in setgid_create function and the another
> >> two functions test mknodat with whiteout device.
> >>
> >> Since kernel commit a3c751a50 ("vfs: allow unprivileged whiteout creation") in
> >> v5.8-rc1, we can create whiteout device in userns test. Since kernel 5.12, mount_setattr
> >> and MOUNT_ATTR_IDMAP was supported, we don't need to detect kernel whether allow
> >> unprivileged whiteout creation. Using fs_allow_idmap as a proxy is safe.
> >>
> >> Tested-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> >> Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >>   src/idmapped-mounts/idmapped-mounts.c | 219 +++++++++++++++++++++++++-
> >>   1 file changed, 213 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> >> index 8e6405c5..617f56e0 100644
> >> --- a/src/idmapped-mounts/idmapped-mounts.c
> >> +++ b/src/idmapped-mounts/idmapped-mounts.c
> >> @@ -241,6 +241,34 @@ static inline bool caps_supported(void)
> >>   	return ret;
> >>   }
> >>
> >> +static int caps_down_fsetid(void)
> >> +{
> >> +	bool fret = false;
> >> +#ifdef HAVE_SYS_CAPABILITY_H
> >> +	cap_t caps = NULL;
> >> +	cap_value_t cap = CAP_FSETID;
> >> +	int ret = -1;
> >> +
> >> +	caps = cap_get_proc();
> >> +	if (!caps)
> >> +		goto out;
> >> +
> >> +	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1,&cap, 0);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = cap_set_proc(caps);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	fret = true;
> >> +
> >> +out:
> >> +	cap_free(caps);
> >> +#endif
> >> +	return fret;
> >> +}
> >> +
> >>   /* caps_down - lower all effective caps */
> >>   static int caps_down(void)
> >>   {
> >> @@ -7805,8 +7833,8 @@ out_unmap:
> >>   #endif /* HAVE_LIBURING_H */
> >>
> >>   /* The following tests are concerned with setgid inheritance. These can be
> >> - * filesystem type specific. For xfs, if a new file or directory is created
> >> - * within a setgid directory and irix_sgid_inhiert is set then inherit the
> >> + * filesystem type specific. For xfs, if a new file or directory or node is
> >> + * created within a setgid directory and irix_sgid_inhiert is set then inherit the
> >>    * setgid bit if the caller is in the group of the directory.
> >>    */
> >>   static int setgid_create(void)
> >> @@ -7863,18 +7891,44 @@ static int setgid_create(void)
> >>   		if (!is_setgid(t_dir1_fd, DIR1, 0))
> >>   			die("failure: is_setgid");
> >>
> >> +		/* create a special file via mknodat() vfs_create */
> >> +		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> >> +			die("failure: mknodat");
> >> +
> >> +		if (!is_setgid(t_dir1_fd, FILE2, 0))
> >> +			die("failure: is_setgid");
> >> +
> >> +		/* create a character device via mknodat() vfs_mknod */
> >> +		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
> >> +			die("failure: mknodat");
> >> +
> >> +		if (!is_setgid(t_dir1_fd, CHRDEV1, 0))
> >> +			die("failure: is_setgid");
> >> +
> >>   		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
> >>   			die("failure: check ownership");
> >>
> >>   		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
> >>   			die("failure: check ownership");
> >>
> >> +		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
> >> +			die("failure: check ownership");
> >> +
> >> +		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
> >> +			die("failure: check ownership");
> >> +
> >>   		if (unlinkat(t_dir1_fd, FILE1, 0))
> >>   			die("failure: delete");
> >>
> >>   		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
> >>   			die("failure: delete");
> >>
> >> +		if (unlinkat(t_dir1_fd, FILE2, 0))
> >> +			die("failure: delete");
> >> +
> >> +		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
> >> +			die("failure: delete");
> >> +
> >>   		exit(EXIT_SUCCESS);
> >>   	}
> >>   	if (wait_for_pid(pid))
> >> @@ -7889,8 +7943,8 @@ static int setgid_create(void)
> >>   		if (!switch_ids(0, 10000))
> >>   			die("failure: switch_ids");
> >>
> >> -		if (!caps_down())
> >> -			die("failure: caps_down");
> >> +		if (!caps_down_fsetid())
> >> +			die("failure: caps_down_fsetid");
> >>
> >>   		/* create regular file via open() */
> >>   		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >> @@ -7917,6 +7971,19 @@ static int setgid_create(void)
> >>   				die("failure: is_setgid");
> >>   		}
> >
> > Please see my comment on the earlier thread:
> > https://lore.kernel.org/linux-fsdevel/20220407134009.s4shhomfxjz5cf5r@wittgenstein
> >
> > The same issue still exists afaict, i.e. you're not handling the irix
> > case.
> I remember it has two issues
> 1)replace 0755 with valid flags
> 2)consider fs.xfs.irix_sgid_inherit enable situation because it will 
> strip S_ISGID for directory
> 
> I used t_dir1_fd directory instead of old DIR1, so I don't need to raise 

Ah, sorry, I missed this. Then this should all be fine:
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
