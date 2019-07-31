Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108A07B750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfGaAsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 20:48:52 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:55550 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfGaAsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:48:52 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 3B5A815F925;
        Wed, 31 Jul 2019 09:48:51 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6V0mnIT008251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 09:48:51 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6V0mnSu010060
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 09:48:49 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x6V0mnvJ010059;
        Wed, 31 Jul 2019 09:48:49 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH 12/20] fs: fat: Initialize filesystem timestamp ranges
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
        <20190730014924.2193-13-deepa.kernel@gmail.com>
        <878ssfc1id.fsf@mail.parknet.co.jp>
        <CABeXuvoZCqGLaiOrf+qrg8pYNYnrY5qzDnwGpnuV+jh3jNvhjw@mail.gmail.com>
Date:   Wed, 31 Jul 2019 09:48:49 +0900
In-Reply-To: <CABeXuvoZCqGLaiOrf+qrg8pYNYnrY5qzDnwGpnuV+jh3jNvhjw@mail.gmail.com>
        (Deepa Dinamani's message of "Tue, 30 Jul 2019 10:39:41 -0700")
Message-ID: <874l33av0u.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> writes:

>> At least, it is wrong to call fat_time_fat2unix() before setup parameters
>> in sbi.
>
> All the parameters that fat_time_fat2unix() cares in sbi is accessed through
>
> static inline int fat_tz_offset(struct msdos_sb_info *sbi)
> {
>     return (sbi->options.tz_set ?
>            -sbi->options.time_offset :
>            sys_tz.tz_minuteswest) * SECS_PER_MIN;
> }
>
> Both the sbi fields sbi->options.tz_set and sbi->options.time_offset
> are set by the call to parse_options(). And, parse_options() is called
> before the calls to fat_time_fat2unix().:
>
> int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>            void (*setup)(struct super_block *))
> {
>      <snip>
>
>     error = parse_options(sb, data, isvfat, silent, &debug, &sbi->options);
>     if (error)
>         goto out_fail;
>
>    <snip>
>
>     sbi->prev_free = FAT_START_ENT;
>     sb->s_maxbytes = 0xffffffff;
>     fat_time_fat2unix(sbi, &ts, 0, cpu_to_le16(FAT_DATE_MIN), 0);
>     sb->s_time_min = ts.tv_sec;
>
>     fat_time_fat2unix(sbi, &ts, cpu_to_le16(FAT_TIME_MAX),
>               cpu_to_le16(FAT_DATE_MAX), 0);
>     sb->s_time_max = ts.tv_sec;
>
>    <snip>
> }
>
> I do not see what the problem is.

Ouch, you are right. I was reading that patch wrongly, sorry.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
