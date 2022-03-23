Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B64E5815
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiCWSF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiCWSF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:05:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360D3981B
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 11:04:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 10B841F41BC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648058664;
        bh=6st8P9PTIqIRBk5ipYU/AiKop2mvK2Z5ytdzu76/Ykg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A4mkEhjaiR/Gqv0ga1PvnZ8DSqmLx4NFcuKLd0lY7Ym3yqrJnrVvcY2IresH8xBEF
         C3u514XRlgsQFbmnbOIbKgvacWPy7GNv/Uf1JlV/3AHTsflgCkLe8/4UWok2Jd796j
         j0s2+Gmi5lLC8qOVMfuuTBqAcgxirfuFNRsR3VlT/Py+kRDy8Bd8KRTKGfkM1VIGsL
         +bk5NJjBXnqwP4LPpz4GMbaKKmGwGkWymxg8d4wJftIR93UrwCCvcn0y40tg5APHlt
         cMLuVwgrtKo/tPEr5tCGK3IV6q/g8SlpvQFtMfw+oK9yZ6oyj8T47H3EwpwM0ErjA0
         xp7KaCkNsJlIw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>, kernel@collabora.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] shmem: Introduce /sys/fs/tmpfs support
Organization: Collabora
References: <20220322222738.182974-1-krisman@collabora.com>
        <20220322222738.182974-3-krisman@collabora.com>
        <CAOQ4uxhLQp4ujuR8k16k9EfeOC2TiwwiCeVGYOzpViwRpa5oqw@mail.gmail.com>
Date:   Wed, 23 Mar 2022 14:04:21 -0400
In-Reply-To: <CAOQ4uxhLQp4ujuR8k16k9EfeOC2TiwwiCeVGYOzpViwRpa5oqw@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 23 Mar 2022 01:58:07 +0200")
Message-ID: <87sfr8r1ei.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

>> +static int shmem_register_sysfs(struct super_block *sb)
>> +{
>> +       int err;
>> +       struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
>> +       __kernel_fsid_t fsid = uuid_to_fsid(sb->s_uuid.b);
>> +
>> +       init_completion(&sbinfo->s_kobj_unregister);
>> +       err = kobject_init_and_add(&sbinfo->s_kobj, &tmpfs_sb_ktype, shmem_root,
>> +                                  "%x%x", fsid.val[0], fsid.val[1]);
>
> uuid (and fsid) try to be unique across tmpfs instances from different times.
> You don't need that.
> I think you'd rather use s_dev (minor number) which is unique among all tmpfs
> instances at a given time and also much easier from user scripts to read from
> (e.g. stat or /proc/self/mountinfo).
>
> That's btw the same number is used as an entry in /sys/fs/fuse/connections
> (fusectl pseudo fs).

Hi Amir, thanks for the review.

Sounds good.  I will follow up with a new version that uses
MINOR(sb->s_dev).

Thank you,


-- 
Gabriel Krisman Bertazi
