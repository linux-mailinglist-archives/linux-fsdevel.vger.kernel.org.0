Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACE5AB33E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 16:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiIBOSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiIBOSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:18:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBEC167445;
        Fri,  2 Sep 2022 06:44:27 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJxr94kmWzkWwq;
        Fri,  2 Sep 2022 20:22:33 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 20:26:15 +0800
Subject: Re: [PATCH v5 0/4] landlock: truncate support
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>
CC:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        <linux-fsdevel@vger.kernel.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <0bf1e5f2-3764-d697-d3ab-d3c4064484ef@huawei.com>
Date:   Fri, 2 Sep 2022 20:26:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2022/9/2 1:10, Mickaël Salaün 写道:
> Hmm, I think there is an issue with this series. Landlock only enforces 
> restrictions at open time or when dealing with user-supplied file paths 
> (relative or absolute). The use of the path_truncate hook in this series 
> doesn't distinguish between file descriptor from before the current 
> sandbox or from after being sandboxed. For instance, if a file 
> descriptor is received through a unix socket, it is assumed that this is 
> legitimate and no Landlock restriction apply on it, which is not the 
> case with this series anymore. It is the same for files opened before 
> the process sandbox itself.

so I think this issue also exists in the chown/chmod series, right? 
there is a testcase in that patchset verify the corresponding rights 
inside the sanbox with a fd opened before sanboxing.
> 
> To be able to follow the current semantic, I think we should control the 
> truncate access at open time (or when dealing with a user-supplied path) 
> but not on any file descriptor as it is currently done. >
> 
> On 17/08/2022 22:30, Günther Noack wrote:
>> The goal of these patches is to work towards a more complete coverage
>> of file system operations that are restrictable with Landlock.
>>
>> The known set of currently unsupported file system operations in
>> Landlock is described at [1]. Out of the operations listed there,
>> truncate is the only one that modifies file contents, so these patches
>> should make it possible to prevent the direct modification of file
>> contents with Landlock.
>>
>> The patch introduces the truncation restriction feature as an
>> additional bit in the access_mask_t bitmap, in line with the existing
>> supported operations.
>>
>> The truncation flag covers both the truncate(2) and ftruncate(2)
>> families of syscalls, as well as open(2) with the O_TRUNC flag.
>> This includes usages of creat() in the case where existing regular
>> files are overwritten.
>>
>> Apart from Landlock, file truncation can also be restricted using
>> seccomp-bpf, but it is more difficult to use (requires BPF, requires
>> keeping up-to-date syscall lists) and it is not configurable by file
>> hierarchy, as Landlock is. The simplicity and flexibility of the
>> Landlock approach makes it worthwhile adding.
>>
>> While it's possible to use the "write file" and "truncate" rights
>> independent of each other, it simplifies the mental model for
>> userspace callers to always use them together.
>>
>> Specifically, the following behaviours might be surprising for users
>> when using these independently:
>>
>>   * The commonly creat() syscall requires the truncate right when
>>     overwriting existing files, as it is equivalent to open(2) with
>>     O_TRUNC|O_CREAT|O_WRONLY.
>>   * The "write file" right is not always required to truncate a file,
>>     even through the open(2) syscall (when using O_RDONLY|O_TRUNC).
>>
>> Nevertheless, keeping the two flags separate is the correct approach
>> to guarantee backwards compatibility for existing Landlock users.
>>
>> These patches are based on version 6.0-rc1.
>>
>> Best regards,
>> Günther
>>
>> [1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
>>
>> Past discussions:
>> V1: 
>> https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
>> V2: 
>> https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
>> V3: 
>> https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
>> V4: 
>> https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/
>>
>> Changelog:
>>
>> V5:
>> * Documentation
>>    * Fix wording in userspace-api headers and in landlock.rst.
>>    * Move the truncation limitation section one to the bottom.
>>    * Move all .rst changes into the documentation commit.
>> * selftests
>>    * Remove _metadata argument from helpers where it became unnecessary.
>>    * Open writable file descriptors at the top of both tests, before 
>> Landlock
>>      is enabled, to exercise ftruncate() independently from open().
>>    * Simplify test_ftruncate and decouple it from exercising open().
>>    * test_creat(): Return errno on close() failure (it does not 
>> conflict).
>>    * Fix /* comment style */
>>    * Reorder blocks of EXPECT_EQ checks to be consistent within a test.
>>    * Add missing |O_TRUNC to a check in one test.
>>    * Put the truncate_unhandled test before the other.
>>
>> V4:
>>   * Documentation
>>     * Clarify wording and syntax as discussed in review.
>>     * Use a less confusing error message in the example.
>>   * selftests:
>>     * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
>>       (This is an intentionally uncommon error code, so that the source
>>       of the error is clear and the test can distinguish test setup
>>       failures from failures in the actual system call under test.)
>>   * samples/Documentation:
>>     * Use additional clarifying comments in the kernel backwards
>>       compatibility logic.
>>
>> V3:
>>   * selftests:
>>     * Explicitly test ftruncate with readonly file descriptors
>>       (returns EINVAL).
>>     * Extract test_ftruncate, test_truncate, test_creat helpers,
>>       which simplified the previously mixed usage of EXPECT/ASSERT.
>>     * Test creat() behaviour as part of the big truncation test.
>>     * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
>>       This simplifies the tests a bit. The kernel implementations are the
>>       same as for truncate(2) and ftruncate(2), so there is little 
>> benefit
>>       from testing them exhaustively. (We aren't testing all open(2)
>>       variants either.)
>>   * samples/landlock/sandboxer.c:
>>     * Use switch() to implement best effort mode.
>>   * Documentation:
>>     * Give more background on surprising truncation behaviour.
>>     * Use switch() in the example too, to stay in-line with the sample 
>> tool.
>>     * Small fixes in header file to address previous comments.
>> * misc:
>>    * Fix some typos and const usages.
>>
>> V2:
>>   * Documentation: Mention the truncation flag where needed.
>>   * Documentation: Point out connection between truncation and file 
>> writing.
>>   * samples: Add file truncation to the landlock/sandboxer.c sample tool.
>>   * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
>>   * selftests: Exercise truncation syscalls when the truncate right
>>     is not handled by Landlock.
>>
>> Günther Noack (4):
>>    landlock: Support file truncation
>>    selftests/landlock: Selftests for file truncation support
>>    samples/landlock: Extend sample tool to support
>>      LANDLOCK_ACCESS_FS_TRUNCATE
>>    landlock: Document Landlock's file truncation support
>>
>>   Documentation/userspace-api/landlock.rst     |  52 +++-
>>   include/uapi/linux/landlock.h                |  17 +-
>>   samples/landlock/sandboxer.c                 |  23 +-
>>   security/landlock/fs.c                       |   9 +-
>>   security/landlock/limits.h                   |   2 +-
>>   security/landlock/syscalls.c                 |   2 +-
>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>   tools/testing/selftests/landlock/fs_test.c   | 257 ++++++++++++++++++-
>>   8 files changed, 336 insertions(+), 28 deletions(-)
>>
>>
>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>> -- 
>> 2.37.2
> .
