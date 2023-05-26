Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361FF712AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjEZQkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjEZQkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 12:40:36 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9FD9
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 09:40:31 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QSVz13cjDzMqfBn;
        Fri, 26 May 2023 18:40:29 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QSVyz2XFlzMppDv;
        Fri, 26 May 2023 18:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685119229;
        bh=qgneZctsmZu9NYVEqwCZ63IYebRwqPZkfQJshIM+ino=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g8vn7bbw22o6LUCPBxp8u7iUChoXbXrE80j7X4tDjpPDGZ0CJMqSE7T8+XlA+teCx
         ImuLqBbgQ0molZYHgkbRsstgprjuS6zYERZMvEKj3KrStLFOhClSCU2A/jKXfrDii2
         i+FZof4I6D1lcDjYLsiTvh8LNbXn8dOv0y65+dPw=
Message-ID: <8249dd59-ce08-2253-1697-301ad082d905@digikod.net>
Date:   Fri, 26 May 2023 18:40:26 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 1/5] hostfs: Fix ephemeral inodes
Content-Language: en-US
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <133970354.9328381.1684703636966.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/05/2023 23:13, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Mickaël Salaün" <mic@digikod.net>
>> hostfs creates a new inode for each opened or created file, which created
>> useless inode allocations and forbade identifying a host file with a kernel
>> inode.
>>
>> Fix this uncommon filesystem behavior by tying kernel inodes to host
>> file's inode and device IDs.  Even if the host filesystem inodes may be
>> recycled, this cannot happen while a file referencing it is open, which
>> is the case with hostfs.  It should be noted that hostfs inode IDs may
>> not be unique for the same hostfs superblock because multiple host's
>> (backed) superblocks may be used.
>>
>> Delete inodes when dropping them to force backed host's file descriptors
>> closing.
>>
>> This enables to entirely remove ARCH_EPHEMERAL_INODES, and then makes
>> Landlock fully supported by UML.  This is very useful for testing
>> (ongoing and backported) changes.
> 
> Removing ARCH_EPHEMERAL_INODES should be a patch on its own, IMHO.

OK, I'll do that in the next series.

> 
>> These changes also factor out and simplify some helpers thanks to the
>> new hostfs_inode_update() and the hostfs_iget() revamp: read_name(),
>> hostfs_create(), hostfs_lookup(), hostfs_mknod(), and
>> hostfs_fill_sb_common().
>>
>> A following commit with new Landlock tests check this new hostfs inode
>> consistency.
>>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: <stable@vger.kernel.org> # 5.15.x: ce72750f04d6: hostfs: Fix writeback of
>> dirty pages
>> Cc: <stable@vger.kernel.org> # 5.15+
> 
> I'm not sure whether this patch qualifies as stable material.
> While I fully agree that the current behavoir is odd, nothing user visible
> is really broken so far.
I added the ARCH_EPHEMERAL_INODES knob to avoid unexpected behavior. 
Thanks to that there is no regression for Landlock, but it's unfortunate 
that we could not use UML to test old kernel versions. According to this 
odd behavior, I guess some user space may not work with hostfs because 
of this issue, hence this Cc. I can remove it if you think it is not the 
case.


> 
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20230309165455.175131-2-mic@digikod.net
> 
> Other than that, patch looks good to me.

Good, I'll send a new series with your suggestions.

> 
> Thanks,
> //richard
