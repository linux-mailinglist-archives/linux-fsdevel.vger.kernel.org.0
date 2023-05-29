Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014F714CAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjE2PHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjE2PHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 11:07:31 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C9CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 08:07:28 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QVJXW2WkFzMpyk5;
        Mon, 29 May 2023 16:57:15 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QVJXS2kmszMq014;
        Mon, 29 May 2023 16:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685372235;
        bh=k2yksphiVr17PfyANZFLI9Exwg8Jhb/+C2VCBIF3McU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=vnqdvI7B2gcSPoa7xG8gAG2+wFvjlop8mh8W0i0AQQCQpGtFQWtCyZw5X1UmldqHK
         tyXavk+wtMv7AztQ2Am3KJETPgAycVz0ahjWSwI3uyosYnEBM8/hQROg2eos2b6C+5
         QIm1JmslgodAazXJaphzDWQX+cq57AuR2F6jmPDc=
Message-ID: <a0c3e6d4-2827-d9b4-8f4e-aef25997fa8a@digikod.net>
Date:   Mon, 29 May 2023 16:57:11 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 1/5] hostfs: Fix ephemeral inodes
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
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
References: <20230309165455.175131-1-mic@digikod.net>
 <20230309165455.175131-2-mic@digikod.net>
 <133970354.9328381.1684703636966.JavaMail.zimbra@nod.at>
 <8249dd59-ce08-2253-1697-301ad082d905@digikod.net>
In-Reply-To: <8249dd59-ce08-2253-1697-301ad082d905@digikod.net>
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


On 26/05/2023 18:40, Mickaël Salaün wrote:
> 
> On 21/05/2023 23:13, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>>> Von: "Mickaël Salaün" <mic@digikod.net>
>>> hostfs creates a new inode for each opened or created file, which created
>>> useless inode allocations and forbade identifying a host file with a kernel
>>> inode.
>>>
>>> Fix this uncommon filesystem behavior by tying kernel inodes to host
>>> file's inode and device IDs.  Even if the host filesystem inodes may be
>>> recycled, this cannot happen while a file referencing it is open, which
>>> is the case with hostfs.  It should be noted that hostfs inode IDs may
>>> not be unique for the same hostfs superblock because multiple host's
>>> (backed) superblocks may be used.
>>>
>>> Delete inodes when dropping them to force backed host's file descriptors
>>> closing.
>>>
>>> This enables to entirely remove ARCH_EPHEMERAL_INODES, and then makes
>>> Landlock fully supported by UML.  This is very useful for testing
>>> (ongoing and backported) changes.
>>
>> Removing ARCH_EPHEMERAL_INODES should be a patch on its own, IMHO.
> 
> OK, I'll do that in the next series.

Well, I added ARCH_EPHEMERAL_INODES for Landlock specifically because of 
this hostfs inconsistency, and it is not used by anything else in the 
kernel: https://git.kernel.org/torvalds/c/cb2c7d1a1776
I then think it makes sense to remove this Kconfig option with the 
hostfs change. Moreover, this protects against erroneously backporting 
the ARCH_EPHEMERAL_INODES change, which would silently introduce a bug 
for Landlock.


> 
>>
>>> These changes also factor out and simplify some helpers thanks to the
>>> new hostfs_inode_update() and the hostfs_iget() revamp: read_name(),
>>> hostfs_create(), hostfs_lookup(), hostfs_mknod(), and
>>> hostfs_fill_sb_common().
>>>
>>> A following commit with new Landlock tests check this new hostfs inode
>>> consistency.
>>>
>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>> Cc: Johannes Berg <johannes@sipsolutions.net>
>>> Cc: Richard Weinberger <richard@nod.at>
>>> Cc: <stable@vger.kernel.org> # 5.15.x: ce72750f04d6: hostfs: Fix writeback of
>>> dirty pages
>>> Cc: <stable@vger.kernel.org> # 5.15+
>>
>> I'm not sure whether this patch qualifies as stable material.
>> While I fully agree that the current behavoir is odd, nothing user visible
>> is really broken so far.
> I added the ARCH_EPHEMERAL_INODES knob to avoid unexpected behavior.
> Thanks to that there is no regression for Landlock, but it's unfortunate
> that we could not use UML to test old kernel versions. According to this
> odd behavior, I guess some user space may not work with hostfs because
> of this issue, hence this Cc. I can remove it if you think it is not the
> case.
> 
> 
>>
>>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>>> Link: https://lore.kernel.org/r/20230309165455.175131-2-mic@digikod.net
>>
>> Other than that, patch looks good to me.
> 
> Good, I'll send a new series with your suggestions.

Can I add your Signed-off-by to this patch (without touching 
ARCH_EPHEMERAL_INODES changes, but removing the Cc stable)?

Are you OK for me to push this patch (with the whole series) in the 
Landlock and next tree?

I'll send a new series splitting the Landlock tests to make a patch 
dedicated to Landlock with hostfs tests (not backported), and with 
another patch containing backportable and independent new Landlock FS tests.
