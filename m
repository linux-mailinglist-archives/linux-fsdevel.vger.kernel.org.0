Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11DAACC3B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfIHKu1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 8 Sep 2019 06:50:27 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:42000 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbfIHKu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:50:26 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 971D415CBF0;
        Sun,  8 Sep 2019 19:50:25 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x88AoOmC022487
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 19:50:25 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x88AoODr012279
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 19:50:24 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x88AoH8K012277;
        Sun, 8 Sep 2019 19:50:17 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
References: <245727.1567183359@turing-police>
        <20190830164503.GA12978@infradead.org>
        <267691.1567212516@turing-police>
        <20190831064616.GA13286@infradead.org>
        <295233.1567247121@turing-police>
        <20190902073525.GA18988@infradead.org>
        <20190902152524.GA4964@kroah.com> <501797.1567450817@turing-police>
        <20190902190619.GA25019@kroah.com>
Date:   Sun, 08 Sep 2019 19:50:16 +0900
In-Reply-To: <20190902190619.GA25019@kroah.com> (Greg Kroah-Hartman's message
        of "Mon, 2 Sep 2019 21:06:19 +0200")
Message-ID: <87muffxdsn.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Sep 02, 2019 at 03:00:17PM -0400, Valdis Klētnieks wrote:
>> On Mon, 02 Sep 2019 17:25:24 +0200, Greg Kroah-Hartman said:
>> 
>> > I dug up my old discussion with the current vfat maintainer and he said
>> > something to the affect of, "leave the existing code alone, make a new
>> > filesystem, I don't want anything to do with exfat".
>> >
>> > And I don't blame them, vfat is fine as-is and stable and shouldn't be
>> > touched for new things.
>> >
>> > We can keep non-vfat filesystems from being mounted with the exfat
>> > codebase, and make things simpler for everyone involved.
>> 
>> Ogawa:
>> 
>> Is this still your position, that you want exfat to be a separate module?
>
> Personally I agree that this should be separate at least for quite some
> time to shake things out at the very least.  But I'll defer to Ogawa if
> he thinks things should be merged.

I'm not reading whole of this thread, so I can be pointless though. I
can't recall the discussion of exfat with you. My history about exfat
is,

   write read-only exfat from on-disk data -> MS published patent to
   their site or such -> stopped about exfat -> recently looks like MS
   changed mind

Well, if you are going to developing actively, IMO it would be better to
drop historically bad decisions in fat driver (some stuff would be hard
to fix without user visible changes), and re-think from basic
implementation design.

And I can't recall the detail of exfat format though, IIRC, the common
code is not so big, but some stuff can be shared with fat (timestamp
stuff, fatent stuff, IIRC). So IMO it is better to be different driver
basically, however on other hand, it is better to share the code for
same on-disk format if possible.

Anyway, I don't have strong opinion about it.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
