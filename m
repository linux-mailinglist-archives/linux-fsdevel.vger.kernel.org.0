Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA472CF95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjFLTcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjFLTbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:31:55 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB3F0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 12:31:50 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1ys1TW9zMpnRX;
        Mon, 12 Jun 2023 19:31:49 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1yq3Vpxz1WQ5;
        Mon, 12 Jun 2023 21:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686598309;
        bh=GasM/PXAmdVQmu/wE7etpr/UWkPXIvJ3I4943s9ioxk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AkpOP6gUurW0lypup7R9nHzfaSYxcp2Tcqu5RkaRVnjte7hc2hVjrPBac+pHpJrej
         l9zmNJWb/uMOEGaE5QV+hGyI6cIY8qOzOYF6uyXR+50EXns+yi2OzI6WJYNEdSQAx8
         bBHElHZ/k+/pZRMpSSz32d187kN2M7Sd+jzArugA=
Message-ID: <06d7e926-87fe-af66-c612-39ea57d0238a@digikod.net>
Date:   Mon, 12 Jun 2023 21:31:46 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 0/6] Landlock support for UML
Content-Language: en-US
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20230612191430.339153-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230612191430.339153-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've push this series into -next. Thanks Richard!

On 12/06/2023 21:14, Mickaël Salaün wrote:
> Hi,
> 
> Commit cb2c7d1a1776 ("landlock: Support filesystem access-control")
> introduced a new ARCH_EPHEMERAL_INODES configuration, only enabled for
> User-Mode Linux.  The reason was that UML's hostfs managed inodes in an
> ephemeral way: from the kernel point of view, the same inode struct
> could be created several times while being used by user space because
> the kernel didn't hold references to inodes.  Because Landlock (and
> probably other subsystems) ties properties (i.e. access rights) to inode
> objects, it wasn't possible to create rules that match inodes and then
> allow specific accesses.
> 
> This patch series fixes the way UML manages inodes according to the
> underlying filesystem.  They are now properly handles as for other
> filesystems, which enables to support Landlock (and probably other
> features).
> 
> Changes since v1:
> https://lore.kernel.org/r/20230309165455.175131-1-mic@digikod.net
> - Remove Cc stable@ (suggested by Richard).
> - Add Acked-by: Richard Weinberger to the first patch.
> - Split the test patch into two patches: one for the common
>    pseudo-filesystems, and another patch dedicated to hostfs.
> - Remove CONFIG_SECURITY_PATH because it is useless for merge_config.sh
> - Move CONFIG_HOSTFS to a new config.um file.
> - Fix commit message spelling and test warnings.
> - Improve prepare_layout_opt() with remove_path() call to avoid
>    cascading errors when some tested filesystems are not supported.
> - Remove cgroup-v1 tests because this filesystem cannot really be
>    mounted several times.
> - Add test coverage with and without kernel debug code, according to
>    GCC 12 and GCC 13.
> 
> Regards,
> 
> Mickaël Salaün (6):
>    hostfs: Fix ephemeral inodes
>    selftests/landlock: Don't create useless file layouts
>    selftests/landlock: Add supports_filesystem() helper
>    selftests/landlock: Make mounts configurable
>    selftests/landlock: Add tests for pseudo filesystems
>    selftests/landlock: Add hostfs tests
> 
>   arch/Kconfig                               |   7 -
>   arch/um/Kconfig                            |   1 -
>   fs/hostfs/hostfs.h                         |   1 +
>   fs/hostfs/hostfs_kern.c                    | 213 ++++++------
>   fs/hostfs/hostfs_user.c                    |   1 +
>   security/landlock/Kconfig                  |   2 +-
>   tools/testing/selftests/landlock/config    |   9 +-
>   tools/testing/selftests/landlock/config.um |   1 +
>   tools/testing/selftests/landlock/fs_test.c | 387 +++++++++++++++++++--
>   9 files changed, 478 insertions(+), 144 deletions(-)
>   create mode 100644 tools/testing/selftests/landlock/config.um
> 
> 
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
