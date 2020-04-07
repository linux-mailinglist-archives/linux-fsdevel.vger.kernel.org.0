Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489401A04DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 04:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDGCZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 22:25:40 -0400
Received: from mail.cock.li ([37.120.193.124]:44758 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgDGCZk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:25:40 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 22:25:39 EDT
Date:   Tue, 7 Apr 2020 05:16:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1586225788; bh=qGyX1HAPEsmwawjGfgfHc62Pd/1AP3V4lb8GMUPYgI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lll4n0UHK6zDbeXwmQeKbYCRle2Ckod6ONDIFvBXJyYIA9WflPyz/XHG+MRCZUejl
         M+jyxLy+2MpfcpUpXUEDtgK6Szd63wYw8dhGw08NPLVwr/6+6fo1+x/1X1HcuXYW/2
         t2TkRHYH7UKLknO71pouxikDYwLUw6aqyaWjsIK7kI8dGC5DtFFYoi0zZguqHhnmn5
         CLn6tUYNvcMwLG5Q1qUVJ7cZ9OWILgZfvrh8CFlSMXxc/FxB3Y1Sin/3Y1URUVbdSY
         Mrl+7rLPbx6qAAHREDghiv3oHkjTka4qNdnRgUw5WMpf2mMeCN4FPja9PkhTCDHJPO
         pv41uqpfKQm4g==
From:   L29Ah <l29ah@cock.li>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406164057.GA18312@nautica>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:40:57PM +0200, Dominique Martinet wrote:
> The use-case here is stuff like reading from synthetic files (think fake
> pipes) where data comes in like a pipe and one would want read to return
> as soon as data is available.
> Just thinking out loud it might be possible to make pipes go through the
> server and somewhat work, but this might bring its own share of other
> problems and existing programs would need to be changed (e.g. wmii's
> synthetic filesystem exposes this kind of files as well as regular
> files, which works fine for their userspace client (wmiir) but can't
> really be used with a linux client)

> Anyway, I agree looking at O_NONBLOCK for that isn't obvious.
> I agree with the usecase here and posix allows short reads regardless of
> the flag so the behaviour is legal either way ; the filesystem is
> allowed to return whenever it wants on a whim - let's just add some docs
> as you suggest unless Sergey has something to add.

In fact i would prefer disabling the full reads unconditionally, but AFAIR some userspace programs might interpret a short read as EOF (and also would need to check the logic that motivated the kernel-side looping).

-- 
()  ascii ribbon campaign - against html mail
/\  http://arc.pasp.de/   - against proprietary attachments
