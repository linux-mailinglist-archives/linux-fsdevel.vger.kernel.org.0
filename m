Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE774FDCF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358746AbiDLKsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357260AbiDLKpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:55 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9237F1E3E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 02:45:39 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 685CE15F93A;
        Tue, 12 Apr 2022 18:45:38 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23C9jbNF134332
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 18:45:38 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23C9jaYj339502
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 18:45:36 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23C9jaC7339500;
        Tue, 12 Apr 2022 18:45:36 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Subject: Re: [PATCH v2 2/3] fat: make ctime and mtime identical explicitly
References: <20220406085459.102691-1-cccheng@synology.com>
        <20220406085459.102691-2-cccheng@synology.com>
        <87h771ueov.fsf@mail.parknet.co.jp>
        <CAHuHWtmYdRzh=4_ou_u=KdpQi8nSr0=XKX4JLaq+=jCaN_47cA@mail.gmail.com>
Date:   Tue, 12 Apr 2022 18:45:36 +0900
In-Reply-To: <CAHuHWtmYdRzh=4_ou_u=KdpQi8nSr0=XKX4JLaq+=jCaN_47cA@mail.gmail.com>
        (Chung-Chiang Cheng's message of "Tue, 12 Apr 2022 17:23:35 +0800")
Message-ID: <87czhm4ou7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chung-Chiang Cheng <shepjeng@gmail.com> writes:

> On Sun, Apr 10, 2022 at 11:43 PM OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> wrote:
>>
>> Hm, this changes mtime includes ctime update. So, the question is, this
>> behavior is compatible with Windows's fatfs behavior? E.g. Windows
>> updates mtime on rename?
>>
>> If not same behavior with Windows, new behavior is new incompatible
>> behavior, and looks break fundamental purpose of this.
>>
>> I was thinking, we ignores ctime update (because fatfs doesn't have) and
>> always same with mtime. What behavior was actually compatible with
>> Windows?
>>
>
> If possible, to ignore ctime update may be a better choice that doesn't
> affect mtime. But we need an initial value for ctime when the inode is
> loaded.
>
> One possible option is to use mtime. Although ctime won't be updated
> anymore, when mtime is changed, ctime needs to take effect. Otherwise
> the next time the inode is loaded, ctime will be inconsistent. That is,
> ctime is still updated indirectly by mtime. It seems impossible to avoid
> updating ctime, or do we just show ctime a non-sense value?

I mean I also think the behavior what you said sounds like reasonable.
mtime change affect to ctime, but ctime change doesn't affect to mtime.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
