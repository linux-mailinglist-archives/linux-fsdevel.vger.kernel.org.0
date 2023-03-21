Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648BE6C3C82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCUVS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 17:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCUVSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:18:24 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5F1259F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 14:18:21 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ph4G3236kzMqrrH;
        Tue, 21 Mar 2023 22:18:19 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ph4G037PKzMtb2b;
        Tue, 21 Mar 2023 22:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1679433499;
        bh=AgKPiy7F5VngjyGIL3NQ14WbEEGl71phtnGYVDOOFK4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C0SINHKlnr2CqFRxb6HMxLhGImy5difrGWxbhH8duWG3iWaChE7HA1oFO2TuZJfTI
         Ihf7M4LpPe8520IBXV5Hlqq/H2ILhWOEF21p8F0uULkAVIvY7/7WH9IG1fBwpNDRqm
         ZqasefLB8Rh8VocFhNJnv+wKXBI0wwt55E3rRCSU=
Message-ID: <cb7e6a4b-63d9-ddba-e0fc-d6352df2b3b6@digikod.net>
Date:   Tue, 21 Mar 2023 22:18:15 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 0/5] Landlock support for UML
Content-Language: en-US
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230309165455.175131-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230309165455.175131-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Richard, Anton, Johannes, what do you think about these UML changes?


On 09/03/2023 17:54, Mickaël Salaün wrote:
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
> Backporting these patches requires some selftest harness patches
> backports too.
> 
> Regards,
> 
> Mickaël Salaün (5):
>    hostfs: Fix ephemeral inodes
>    selftests/landlock: Don't create useless file layouts
>    selftests/landlock: Add supports_filesystem() helper
>    selftests/landlock: Make mounts configurable
>    selftests/landlock: Add tests for pseudo filesystems
> 
>   arch/Kconfig                               |   7 -
>   arch/um/Kconfig                            |   1 -
>   fs/hostfs/hostfs.h                         |   1 +
>   fs/hostfs/hostfs_kern.c                    | 213 ++++++------
>   fs/hostfs/hostfs_user.c                    |   1 +
>   security/landlock/Kconfig                  |   2 +-
>   tools/testing/selftests/landlock/config    |   8 +-
>   tools/testing/selftests/landlock/fs_test.c | 381 +++++++++++++++++++--
>   8 files changed, 472 insertions(+), 142 deletions(-)
> 
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
