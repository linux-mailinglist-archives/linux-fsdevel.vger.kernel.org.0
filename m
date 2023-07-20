Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F075B767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGTTFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGTTFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:05:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4168C1984;
        Thu, 20 Jul 2023 12:05:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666eb03457cso770900b3a.1;
        Thu, 20 Jul 2023 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879930; x=1690484730;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5WxwIIVZh3vzM0O7OdWvee0FQLOrckntfrL4WlrpgQ=;
        b=bOKuuxgP+6quZ+4NX2C9oFQ+beZmM/S7D8G3o+OQ8U8a8F63PTiN4HLfyowMoixzmb
         jR7sAxui0n3J+8OLtE2EVOOTkBUtjb/m/A5BFog5beYPKhokIZFPPKXjM8Yk1OuyZIi+
         7u2jvGL+KeZ7CjNFXvW6U4Mj+u8O51kSCjNIpqtZIeOqLmkzsVpzx2GjBALWOt9IK58t
         +cF9/iXeysIL3tMC2DR7hPDZwP0bz2oEfdzJWXA00TKXV7FUNrNYE50atqJj+FNG87Pu
         itRmnPVbIBSuDfb2FE8Zrvv+STUumvkDb0vQngOpuYZKkbI8hFB4VMemcv+0kDBHZVPU
         KlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879930; x=1690484730;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5WxwIIVZh3vzM0O7OdWvee0FQLOrckntfrL4WlrpgQ=;
        b=IgKhjNf9wpCipfmAxDmx/Q+2eUxSJS1k556geMwfZmXMZcGnwVoUcFFzdxQ5yPtOw0
         ideXS+XsxV5Ndr7ENMUrOS5i7TDn0U/CM287apoA7QuvEl30hySyGCOdiBcwfhGgXqg2
         rSLPEtpSmHY51wkYPJwtUsCPkFnmKApwaf6h6v9UzOMf/sEAUAjQJ72R4KLzUPpYvRQb
         sybMbETIGar79d26Hudg53YLhVY/vCfhuZATVG/9hT0mz2H0lnG+d1IsSBHIIb7/yrYC
         Y/ErVXytL3Nk47ZSNCLRwvGOxmnfHpTvxqBzjzjCciR/vzToPnRpKfJRk1TVx2S1ZUi3
         4Jzw==
X-Gm-Message-State: ABy/qLZfYRqK06ns0d1/Ujm0Qn/OSdYeCcbcFrhg7Ku4i923f3yZnQxc
        so6dPadEkc6qrZ3TzLsXzgc=
X-Google-Smtp-Source: APBJJlFvRck6wx9MK8Vvu72MnjOOPhgvvKr/kY3NbAZI66XwRPemH27+SiwJt1uqr7U6/bMVOoCfuQ==
X-Received: by 2002:a17:90a:8410:b0:263:1213:df3b with SMTP id j16-20020a17090a841000b002631213df3bmr195471pjn.11.1689879930509;
        Thu, 20 Jul 2023 12:05:30 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a194e00b00267dd51778asm109061pjh.7.2023.07.20.12.05.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:05:29 -0700 (PDT)
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <b93ff5ca1ecd40084cd7a18e8490bf4e421fd6b9.camel@physik.fu-berlin.de>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-powerpc <debian-powerpc@lists.debian.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <47a12957-9d9b-4134-0736-bedb15428627@gmail.com>
Date:   Fri, 21 Jul 2023 07:05:19 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <b93ff5ca1ecd40084cd7a18e8490bf4e421fd6b9.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Adrian,

Am 21.07.2023 um 05:56 schrieb John Paul Adrian Glaubitz:
> (Please ignore my previous mail which was CC'ed to the wrong list)
>
> Hello!
>
> On Thu, 2023-07-20 at 18:30 +0100, Matthew Wilcox wrote:
>> On Thu, Jul 20, 2023 at 05:27:57PM +0200, Dmitry Vyukov wrote:
>>> On Thu, 5 Jan 2023 at 17:45, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>>>>> On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
>>>>>> Also, as far as I can see, available volume in report (mount_0.gz) somehow corrupted already:
>>>>>
>>>>> Syzbot generates deliberately-corrupted (aka fuzzed) filesystem images.
>>>>> So basically, you can't trust anything you read from the disc.
>>>>>
>>>>
>>>> If the volume has been deliberately corrupted, then no guarantee that file system
>>>> driver will behave nicely. Technically speaking, inode write operation should never
>>>> happened for corrupted volume because the corruption should be detected during
>>>> b-tree node initialization time. If we would like to achieve such nice state of HFS/HFS+
>>>> drivers, then it requires a lot of refactoring/implementation efforts. I am not sure that
>>>> it is worth to do because not so many guys really use HFS/HFS+ as the main file
>>>> system under Linux.
>>>
>>>
>>> Most popular distros will happily auto-mount HFS/HFS+ from anything
>>> inserted into USB (e.g. what one may think is a charger). This creates
>>> interesting security consequences for most Linux users.
>>> An image may also be corrupted non-deliberately, which will lead to
>>> random memory corruptions if the kernel trusts it blindly.
>>
>> Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
>> MAINTAINERS and if distros are going to do such a damnfool thing,
>> then we must stop them.
>
> Both HFS and HFS+ work perfectly fine. And if distributions or users are so
> sensitive about security, it's up to them to blacklist individual features
> in the kernel.
>
> Both HFS and HFS+ have been the default filesystem on MacOS for 30 years
> and I don't think it's justified to introduce such a hard compatibility
> breakage just because some people are worried about theoretical evil
> maid attacks.

Seconded.

> HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerMac
> and I don't think it's okay to break all these systems running Linux.

You can still boot Linux on these systems without HFS support.

Installing a new kernel to the HFS filesystem, or a boot loader like 
yaboot, might be another matter. But there still is an user space option 
like hfsutils or hfsplus.

That said, in terms of the argument about USB media with corrupt HFS 
filesystems presenting a security risk, I take the view that once you 
have physical access to a system, all bets are off. Doubly so if 
auto-mounting USB media is enabled.

Cheers,

	Michael


>
> Thanks,
> Adrian
>
