Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26833752160
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjGMMiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMMiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:38:19 -0400
X-Greylist: delayed 101 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 05:38:17 PDT
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D1FC213C;
        Thu, 13 Jul 2023 05:38:17 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36DCZRRM027222;
        Thu, 13 Jul 2023 14:35:27 +0200
Date:   Thu, 13 Jul 2023 14:35:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@devkernel.io>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH] procfs: block chmod on /proc/thread-self/comm
Message-ID: <ZK/vj5qnkaeBt6cR@1wt.eu>
References: <20230713121907.9693-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713121907.9693-1-cyphar@cyphar.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Cc Thomas Weiﬂschuh <thomas@t-8ch.de> as this seems quite related to
his finding about /proc/self/net:

  https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net/#b

On Thu, Jul 13, 2023 at 10:19:04PM +1000, Aleksa Sarai wrote:
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
>  
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
>  		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
>  		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
>  		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
> -- 
> 2.41.0
