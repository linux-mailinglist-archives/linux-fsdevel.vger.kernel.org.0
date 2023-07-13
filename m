Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948C752212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjGMNBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGMNB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:01:29 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A19173B;
        Thu, 13 Jul 2023 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689253285; bh=yupFDaQfBUJDGYQkoGNGPCB4kwzNRglkYY4WfTsQAWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSW/8Nr5ap4LZT45TYM21VhMlU1KpKTveQU/R1eLWHTG7GcTes3d4N4Ugj7E2Dz/X
         Ov6XIu/ywxhBG9gU8MQm0cIcHEPkyLeeIrSyEsAnPD4BXIvZCGfCE5MuutuFShyQq/
         EmfmdBx6FGqYTaw1zz+rlCUm/6Ccq06GWTVd5Ads=
Date:   Thu, 13 Jul 2023 15:01:24 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@devkernel.io>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] procfs: block chmod on /proc/thread-self/comm
Message-ID: <e26a9bab-6443-4a0a-809a-ca1c1b4d28c3@t-8ch.de>
References: <20230713121907.9693-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713121907.9693-1-cyphar@cyphar.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-13 22:19:04+1000, Aleksa Sarai wrote:
> Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
> cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
> chmod operations on /proc/thread-self/comm were no longer blocked as
> they are on almost all other procfs files.
> 
> A very similar situation with /proc/self/environ was used to as a root
> exploit a long time ago, but procfs has SB_I_NOEXEC so this is simply a
> correctness issue.
> 
> Ref: https://lwn.net/Articles/191954/
> Ref: 6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files")
> Fixes: 1b3044e39a89 ("procfs: fix pthread cross-thread naming if !PR_DUMPABLE")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  fs/proc/base.c                               | 3 ++-
>  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 05452c3b9872..7394229816f3 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3583,7 +3583,8 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
>  }
>  
>  static const struct inode_operations proc_tid_comm_inode_operations = {
> -		.permission = proc_tid_comm_permission,
> +		.setattr	= proc_setattr,
> +		.permission	= proc_tid_comm_permission,
>  };

Given that this seems to be a recurring theme a more systematic
aproach would help.

Something like the following (untested) patch:

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..b90f2e9cda66 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2649,6 +2649,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
 		set_nlink(inode, 2);	/* Use getattr to fix if necessary */
 	if (p->iop)
 		inode->i_op = p->iop;
+	WARN_ON(!inode->i_op->setattr);
 	if (p->fop)
 		inode->i_fop = p->fop;
 	ei->op = p->op;

>  /*
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 486334981e60..08f0969208eb 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -580,6 +580,10 @@ int run_syscall(int min, int max)
>  		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
>  		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
>  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
> +		CASE_TEST(chmod_self_comm);   EXPECT_SYSER(proc, chmod("/proc/self/comm", 0777), -1, EPERM); break;
> +		CASE_TEST(chmod_tid_comm);    EXPECT_SYSER(proc, chmod("/proc/thread-self/comm", 0777), -1, EPERM); break;
> +		CASE_TEST(chmod_self_environ);EXPECT_SYSER(proc, chmod("/proc/self/environ", 0777), -1, EPERM); break;
> +		CASE_TEST(chmod_tid_environ); EXPECT_SYSER(proc, chmod("/proc/thread-self/environ", 0777), -1, EPERM); break;

I'm not a big fan of this, it abuses the nolibc testsuite to test core
kernel functionality.
If this needs to be tested explicitly there is hopefully a better place.

Those existing tests focus on testing functionality provided by nolibc.
The test chmod_net just got removed because it suffered from the same
bug as /proc/thread-self/comm.

>  		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
>  		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
>  		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
> -- 
> 2.41.0
> 
