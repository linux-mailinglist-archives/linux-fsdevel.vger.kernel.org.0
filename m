Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FF56B855
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiGHLWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiGHLWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:22:08 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB8904C0
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 04:22:06 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LfW1q0LHFzMqChq;
        Fri,  8 Jul 2022 13:16:31 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LfW1p3N5pzlqK2Q;
        Fri,  8 Jul 2022 13:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1657278991;
        bh=8SyHUZswIrAcK24Rl/MkBRWVmxlRYy96Eoo8tzFUVI0=;
        h=Date:To:References:Cc:From:Subject:In-Reply-To:From;
        b=v1eh+3xrVFXnRanCOy+l7F3WoioTP/Ku7XLSdBOSoGNGRK/d2ZvZxXx+W5rrDAnLu
         KjgKj1brUoiSTc2JPPSOalgkFQGAa2nA3oKTT7lRhizIsQKrfQwtSJ1r/GQ878dMf+
         bxcvmT6BkCOo2PdGRk+VsThpBdcLX2ZSXUZBezu4=
Message-ID: <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net>
Date:   Fri, 8 Jul 2022 13:16:29 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
References: <20220707200612.132705-1-gnoack3000@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 0/2] landlock: truncate(2) support
In-Reply-To: <20220707200612.132705-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Günther, this looks good!

Added linux-fsdevel@vger.kernel.org

On 07/07/2022 22:06, Günther Noack wrote:
> The goal of these patches is to work towards a more complete coverage
> of file system operations that are restrictable with Landlock.
> 
> The known set of currently unsupported file system operations in
> Landlock is described at [1]. Out of the operations listed there,
> truncate is the only one that modifies file contents, so these patches
> should make it possible to prevent the direct modification of file
> contents with Landlock.
> 
> The patch introduces the truncate(2) restriction feature as an
> additional bit in the access_mask_t bitmap, in line with the existing
> supported operations.
> 
> Apart from Landlock, the truncate(2) and ftruncate(2) family of system
> calls can also be restricted using seccomp-bpf, but it is a
> complicated mechanism (requires BPF, requires keeping up-to-date
> syscall lists) and it also is not configurable by file hierarchy, as
> Landlock is. The simplicity and flexibility of the Landlock approach
> makes it worthwhile adding.
> 
> I am aware that the documentation and samples/landlock/sandboxer.c
> tool still need corresponding updates; I'm hoping to get some early
> feedback this way.
Yes, that's a good approach.

Extending the sandboxer should be straightforward, you can just extend 
the scope of LL_FS_RW, taking into account the system Landlock ABI 
because there is no "contract" for this sample.

You'll need to remove the warning about truncate(2) in the 
documentation, and maybe to move it to the "previous limitations" 
section, with the LANDLOCK_ACCESS_TRUNCATE doc pointing to it. I think 
it would be nice to extend the LANDLOCK_ACCESS_FS_WRITE documentation to 
point to LANDLOCK_ACCESS_FS_TRUNCATE because this distinction could be 
disturbing for users. Indeed, all inode-based LSMs (SELinux and Smack) 
deny such action if the inode is not writable (with the inode_permission 
check), which is not the case for path-based LSMs (AppArmor and Tomoyo).

While we may question whether a dedicated access right should be added 
for the Landlock use case, two arguments are in favor of this approach:
- For compatibility reasons, the kernel must follow the semantic of a 
specific Landlock ABI, otherwise it could break user space. We could 
still backport this patch and merge it with the ABI 1 and treat it as a 
bug, but the initial version of Landlock was meant to be an MVP, hence 
this lack of access right.
- There is a specific access right for Capsicum (CAP_FTRUNCATE) that 
could makes more sense in the future.

Following the Capsicum semantic, I think it would be a good idea to also 
check for the O_TRUNC open flag: 
https://www.freebsd.org/cgi/man.cgi?query=rights


> 
> These patches are based on version 5.19-rc5.
> The patch set can also be browsed on the web at [2].
> 
> Best regards,
> Günther
> 
> [1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
> [2] https://github.com/gnoack/linux/tree/landlock-truncate
> 
> Günther Noack (2):
>    landlock: Support truncate(2).
>    landlock: Selftests for truncate(2) support.
> 
>   include/uapi/linux/landlock.h                |  2 +
>   security/landlock/fs.c                       |  9 +-
>   security/landlock/limits.h                   |  2 +-
>   security/landlock/syscalls.c                 |  2 +-
>   tools/testing/selftests/landlock/base_test.c |  2 +-
>   tools/testing/selftests/landlock/fs_test.c   | 87 +++++++++++++++++++-
>   6 files changed, 97 insertions(+), 7 deletions(-)
> 
> --
> 2.37.0
