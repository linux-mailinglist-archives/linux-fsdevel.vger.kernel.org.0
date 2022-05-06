Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406E951DD9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443807AbiEFQdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiEFQdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:33:38 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031426E8CF;
        Fri,  6 May 2022 09:29:54 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwyT4LLBzMpt82;
        Fri,  6 May 2022 18:29:53 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwyS25M7zlhRVT;
        Fri,  6 May 2022 18:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651854593;
        bh=5oj7hdI4Rj2ExwGYaOYEvvUzEy2tnYUuMitHlfxtsZs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=eti4l+QSiv/912WPo99HWiKwdLRXF7I+vnsJ8P71DmSJkPUK5qdYZjhpVZ2qHvkWp
         QOF62IJbqEhi3Lyi46H0spdGplVO0Xhch7bo/QNYPYA8KQ6BDy2XX1JhhLMFVxp5Sn
         lg1uCApeKQEZBKS/+hAkimmuhDoHbgik4Alg1eKU=
Message-ID: <d6a6d963-a8d3-0f21-c35e-9d430c6f19ea@digikod.net>
Date:   Fri, 6 May 2022 18:31:19 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220506161102.525323-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v3 00/12] Landlock: file linking and renaming support
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The four related patch series are available here: 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=landlock-wip

On 06/05/2022 18:10, Mickaël Salaün wrote:
> Hi,
> 
> This third patch series is mostly a rebase with some whitespace changes
> because of clang-format.  There is also some new "unlikely()" calls and
> minor code cleanup.
> 
> Test coverage for security/landlock was 94.4% of 504 lines (with the
> previous patch series), and it is now 95.4% of 604 lines according to
> gcc/gcov-11.
> 
> Problem
> =======
> 
> One of the most annoying limitations of Landlock is that sandboxed
> processes can only link and rename files to the same directory (i.e.
> file reparenting is always denied).  Indeed, because of the unprivileged
> nature of Landlock, file hierarchy are identified thanks to ephemeral
> inode tagging, which may cause arbitrary renaming and linking to change
> the security policy in an unexpected way.
> 
> Solution
> ========
> 
> This patch series brings a new access right, LANDLOCK_ACCESS_FS_REFER,
> which enables to allow safe file linking and renaming.  In a nutshell,
> Landlock checks that the inherited access rights of a moved or renamed
> file cannot increase but only reduce.  Eleven new test suits cover file
> renaming and linking, which improves test coverage.
> 
> The documentation and the tutorial is extended with this new access
> right, along with more explanations about backward and forward
> compatibility, good practices, and a bit about the current access
> rights rational.
> 
> While developing this new feature, I also found an issue with the
> current implementation of Landlock.  In some (rare) cases, sandboxed
> processes may be more restricted than intended.  Indeed, because of the
> current way to check file hierarchy access rights, composition of rules
> may be incomplete when requesting multiple accesses at the same time.
> This is fixed with a dedicated patch involving some refactoring.  A new
> test suite checks relevant new edge cases.
> 
> As a side effect, and to limit the increased use of the stack, I reduced
> the number of Landlock nested domains from 64 to 16.  I think this
> should be more than enough for legitimate use cases, but feel free to
> challenge this decision with real and legitimate use cases.
> 
> Additionally, a new dedicated syzkaller test has been developed to cover
> new paths.
> 
> This patch series is based on and was developed with some complementary
> new tests sent in a standalone patch series:
> https://lore.kernel.org/r/20220506160820.524344-1-mic@digikod.net
> 
> Previous versions:
> v2: https://lore.kernel.org/r/20220329125117.1393824-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20220221212522.320243-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (12):
>    landlock: Define access_mask_t to enforce a consistent access mask
>      size
>    landlock: Reduce the maximum number of layers to 16
>    landlock: Create find_rule() from unmask_layers()
>    landlock: Fix same-layer rule unions
>    landlock: Move filesystem helpers and add a new one
>    LSM: Remove double path_rename hook calls for RENAME_EXCHANGE
>    landlock: Add support for file reparenting with
>      LANDLOCK_ACCESS_FS_REFER
>    selftests/landlock: Add 11 new test suites dedicated to file
>      reparenting
>    samples/landlock: Add support for file reparenting
>    landlock: Document LANDLOCK_ACCESS_FS_REFER and ABI versioning
>    landlock: Document good practices about filesystem policies
>    landlock: Add design choices documentation for filesystem access
>      rights
> 
>   Documentation/security/landlock.rst          |   17 +-
>   Documentation/userspace-api/landlock.rst     |  151 ++-
>   include/linux/lsm_hook_defs.h                |    2 +-
>   include/linux/lsm_hooks.h                    |    1 +
>   include/uapi/linux/landlock.h                |   27 +-
>   samples/landlock/sandboxer.c                 |   40 +-
>   security/apparmor/lsm.c                      |   30 +-
>   security/landlock/fs.c                       |  771 ++++++++++---
>   security/landlock/fs.h                       |    2 +-
>   security/landlock/limits.h                   |    6 +-
>   security/landlock/ruleset.c                  |    6 +-
>   security/landlock/ruleset.h                  |   22 +-
>   security/landlock/syscalls.c                 |    2 +-
>   security/security.c                          |    9 +-
>   security/tomoyo/tomoyo.c                     |   11 +-
>   tools/testing/selftests/landlock/base_test.c |    2 +-
>   tools/testing/selftests/landlock/fs_test.c   | 1039 ++++++++++++++++--
>   17 files changed, 1853 insertions(+), 285 deletions(-)
> 
> 
> base-commit: 4b0cdb0cf6eefa7521322007931ccfb7edc96c53
