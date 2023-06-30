Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71435743D29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3OGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjF3OG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:06:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD8297C;
        Fri, 30 Jun 2023 07:06:24 -0700 (PDT)
X-QQ-mid: bizesmtp88t1688133972tps58rre
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:06:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: V4JOsym0FHqCqJmQlnD2l8SkfrQEZVY9NptJ2TcjxV7sRXyUtJ9Enl2xfdhz+
        0hGa/4YyEZzoY3duK31fYRejq1j4LZFvWf1DqoISA69EGDQRVdblDk3TohwH3ZoohdSnJMe
        VMX3dmbDHRx9+XqnvHioN26Y50xRgoaBwNYb329ofovzfRhsJ3Cp12RSGLAPaxOdrnZGcHr
        6xE21FP5G/B8jKIHQ3rT4FMD1TFpQW8E8JLvyCBBtrFwVt+J9U2LCvzMGbed+ds9hEjMXqu
        /uyIperG1ls4ZPuNc/JUG7A6zZ9GU1Agyr+gg1+1BapqyvccpN3Nn3cjdAmRT/BpnbQcmp2
        jVPIEQK1GqxPOk/AxWzghg52cCIg0BKxbn2M8isj8sRMU2eSWbQYYyzn4RORAw6oAEx8Clh
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15545205547833323079
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, w@1wt.eu
Subject: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Date:   Fri, 30 Jun 2023 22:06:09 +0800
Message-Id: <20230630140609.263790-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Thomas

Just applied your patchset on v6.4, and then:

  - revert the 1st patch: 'selftests/nolibc: drop test chmod_net' manually

  - do the 'run' test of nolibc on arm/vexpress-a9

The 'chmod_net' test of tools/testing/selftests/nolibc/nolibc-test.c
really failed as expected (and therefore, should be removed):

    11 chdir_root = 0                                                [OK]
    12 chdir_dot = 0                                                 [OK]
    13 chdir_blah = -1 ENOENT                                        [OK]
    14 chmod_net = -1 EPERM                                         [FAIL]
    15 chmod_self = -1 EPERM                                         [OK]
    16 chmod_tmpdir = 0                                              [OK]
    17 chown_self = -1 EPERM                                         [OK]

So, If this test result is enough for this patch, here is my:

Tested-by: Zhangjin Wu <falcon@tinylab.org>

Best regards,
Zhangjin

> /proc/$PID/net currently allows the setting of file attributes,
> in contrast to other /proc/$PID/ files and directories.
> 
> This would break the nolibc testsuite so the first patch in the series
> removes the offending testcase.
> The "fix" for nolibc-test is intentionally kept trivial as the series
> will most likely go through the filesystem tree and if conflicts arise,
> it is obvious on how to resolve them.
> 
> Technically this can lead to breakage of nolibc-test if an old
> nolibc-test is used with a newer kernel containing the fix.
> 
> Note:
> 
> Except for /proc itself this is the only "struct inode_operations" in
> fs/proc/ that is missing an implementation of setattr().
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (2):
>       selftests/nolibc: drop test chmod_net
>       proc: use generic setattr() for /proc/$PID/net
> 
>  fs/proc/proc_net.c                           | 1 +
>  tools/testing/selftests/nolibc/nolibc-test.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> ---
> base-commit: a92b7d26c743b9dc06d520f863d624e94978a1d9
> change-id: 20230624-proc-net-setattr-8f0a6b8eb2f5
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
