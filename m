Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7528D1E7B16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgE2K67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:58:59 -0400
Received: from smtp114.iad3a.emailsrvr.com ([173.203.187.114]:60902 "EHLO
        smtp114.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgE2K67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:58:59 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 06:58:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590749333;
        bh=t15gD2na0/H2x24kYLMgRSaadArXUlcGrrVA6FeEnP8=;
        h=Subject:To:From:Date:From;
        b=P/yGFFHljNvaZB92yovb2fTGfsmbboM+7kHjf49CcRed3UyoIxTvNSKc8/KCS2yGQ
         NgmlJNW6mAaQfF2noDdlFzI5YWwrc2P2SzFQu3D0NWpJP5qlQjQLfnmxcHMb2I83CN
         K1KqOuUJIQ86AS5zdbn67rMde5utdtP+K1L6qFCA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9B9C04E77;
        Fri, 29 May 2020 06:48:52 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:48:53 -0400
Subject: Re: [PATCHES] uaccess comedi compat
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529003419.GX23230@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <b18a9407-8124-ff94-8c9b-333a32e0a137@mev.co.uk>
Date:   Fri, 29 May 2020 11:48:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003419.GX23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: d43e263d-a7dd-4e12-b35f-2b944c640f45-1-1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/05/2020 01:34, Al Viro wrote:
> 	The way comedi compat ioctls are done is wrong.
> Instead of having ->compat_ioctl() copying the 32bit
> stuff in, then passing the kernel copies to helpers shared
> with native ->ioctl() and doing copyout with conversion if
> needed, it's playing silly buggers with creating a 64bit
> copy on user stack, then calling native ioctl (which copies
> that copy into the kernel), then fetching it from user stack,
> converting to 32bit variant and copying that to user.
> 	Extra headache for no good reason.  And the single
> largest remaining pile of __put_user()/__get_user() this side
> of arch/*.  IMO compat_alloc_user_space() should die...
> 
> 	NOTE: this is only compile-tested - I simply don't
> have the hardware in question.
> 
> 	Anyway, the branch lives in #uaccess.comedi, based
> at v5.7-rc1
> 	
> Al Viro (10):
>        comedi: move compat ioctl handling to native fops
>        comedi: get rid of indirection via translated_ioctl()
>        comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat
>        comedi: get rid of compat_alloc_user_space() mess in COMEDI_RANGEINFO compat
>        comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSN compat
>        comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSNLIST compat
>        comedi: lift copy_from_user() into callers of __comedi_get_user_cmd()
>        comedi: do_cmdtest_ioctl(): lift copyin/copyout into the caller
>        comedi: do_cmd_ioctl(): lift copyin/copyout into the caller
>        comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat

There is a bug in patch 05. Patch 10 doesn't seem to have been sent yet 
(I didn't receive it and I can't see it in the thread in the LKML 
archives). I've signed off on 01-04, 06-09.

These should be Cc'd to Greg KH and to devel@driverdev.osuosl.org.

Cheers,
Ian

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
