Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9519D70B0A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjEUVOJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 17:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEUVOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 17:14:03 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E6B4;
        Sun, 21 May 2023 14:14:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 224F8616B2D5;
        Sun, 21 May 2023 23:13:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rrieuuPGfCQW; Sun, 21 May 2023 23:13:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5F4AA616B2E1;
        Sun, 21 May 2023 23:13:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o4O3u6pDXA4P; Sun, 21 May 2023 23:13:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 34319616B2D5;
        Sun, 21 May 2023 23:13:57 +0200 (CEST)
Date:   Sun, 21 May 2023 23:13:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        kuba <kuba@kernel.org>, James Morris <jmorris@namei.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Message-ID: <133970354.9328381.1684703636966.JavaMail.zimbra@nod.at>
In-Reply-To: <20230309165455.175131-2-mic@digikod.net>
References: <20230309165455.175131-1-mic@digikod.net> <20230309165455.175131-2-mic@digikod.net>
Subject: Re: [PATCH v1 1/5] hostfs: Fix ephemeral inodes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Fix ephemeral inodes
Thread-Index: tKJAlvYqiwgTPVoEW6hlXkXRgBTN3A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Mickaël Salaün" <mic@digikod.net>
> hostfs creates a new inode for each opened or created file, which created
> useless inode allocations and forbade identifying a host file with a kernel
> inode.
> 
> Fix this uncommon filesystem behavior by tying kernel inodes to host
> file's inode and device IDs.  Even if the host filesystem inodes may be
> recycled, this cannot happen while a file referencing it is open, which
> is the case with hostfs.  It should be noted that hostfs inode IDs may
> not be unique for the same hostfs superblock because multiple host's
> (backed) superblocks may be used.
> 
> Delete inodes when dropping them to force backed host's file descriptors
> closing.
> 
> This enables to entirely remove ARCH_EPHEMERAL_INODES, and then makes
> Landlock fully supported by UML.  This is very useful for testing
> (ongoing and backported) changes.

Removing ARCH_EPHEMERAL_INODES should be a patch on its own, IMHO.

> These changes also factor out and simplify some helpers thanks to the
> new hostfs_inode_update() and the hostfs_iget() revamp: read_name(),
> hostfs_create(), hostfs_lookup(), hostfs_mknod(), and
> hostfs_fill_sb_common().
> 
> A following commit with new Landlock tests check this new hostfs inode
> consistency.
> 
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: <stable@vger.kernel.org> # 5.15.x: ce72750f04d6: hostfs: Fix writeback of
> dirty pages
> Cc: <stable@vger.kernel.org> # 5.15+

I'm not sure whether this patch qualifies as stable material.
While I fully agree that the current behavoir is odd, nothing user visible
is really broken so far.

> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20230309165455.175131-2-mic@digikod.net

Other than that, patch looks good to me.

Thanks,
//richard
