Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172E0678FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfGMH0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jul 2019 03:26:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42325 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfGMH0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jul 2019 03:26:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8so7946679wrj.9;
        Sat, 13 Jul 2019 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTda/cITUXIF+PEg2x+FosTA/UQoJG4ptdSoWYZhjFA=;
        b=eTImpNHLHhUrMdeHJ5cpqJXfAd0sBU6hb2usHBk9Acs/xR/nVDlvqTR/Ox82BwSG1a
         fOUhvLLI/FWpl2971uOTQeeGeuc0zW4T+iN2fDicqnLjBZwAVk5N/OCQpKSfrpz6Owx+
         JO7Kw8G/LkSoP/caSO0ww2vPI74x+2iDO4qR6vdvvQfXtm/WwX5JDMyX2FryQRSQ4Iqp
         rJ6YuiZum1kDPaf1gZ8PYDtEmB1Yn+x0xEUZcr9jFLYw4CR+tf4ZywSrwF7z11FtPSx+
         VdogAaguqRyFd0xB89mPFCDILqTQulrWvrXf7eB63bdiclegffgjnPyfO5bhZPsoq85e
         XfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTda/cITUXIF+PEg2x+FosTA/UQoJG4ptdSoWYZhjFA=;
        b=CbFD9VkT6J+10dNfA4CiYXpSzPFvxbxFkqV/wCVYZlYldyRQnIhzlepiB2XOf+3ar+
         m2NmbSmmMeMdw9/cO9TA1R7Ou4P6fkcDkBAI4+G+jZ2S1wbDgBbkvIR3c2Er2N3l9pAd
         MyiVpQicrGJltXy+QbARgSS7j3Vrbd5qTGl+4/cB7zt71rSD45I3cTWeCSIJdbKj/iz6
         lVBP60NRefYlHFA/n7jTAje++WwmCGfRbom+pCreGPggoIH02oO+6HGzjrRQkoCeuCy/
         YersM1m0+7r9VlBeo094Noj/EpjLVdmxsOQNPp/eBrpKICkzuSurjzZwmhicqpRpMqJc
         wIjA==
X-Gm-Message-State: APjAAAWs6wo2kRT5bg/6+UpqzsrTmjHV5O90gtQK/tFTIK/E2Sy9exUX
        bYzwZRD6kaJsWUoiebNmFxBCPEE=
X-Google-Smtp-Source: APXvYqzP+hv+GekYHm/8Be16aiqzJ3WQwUmY/U/I6ah9MIpx/DA0IyNJIBTIglL7Zy038wTpx0+U+w==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr11792214wrp.202.1563002769250;
        Sat, 13 Jul 2019 00:26:09 -0700 (PDT)
Received: from avx2 ([46.53.248.114])
        by smtp.gmail.com with ESMTPSA id c78sm13581465wmd.16.2019.07.13.00.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 00:26:08 -0700 (PDT)
Date:   Sat, 13 Jul 2019 10:26:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
Message-ID: <20190713072606.GA23167@avx2>
References: <20190712160913.17727-1-izbyshev@ispras.ru>
 <20190712163625.GF21989@redhat.com>
 <20190712174632.GA3175@avx2>
 <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3de2d71b-37be-6238-7fd8-0a40c9b94a98@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 09:43:03PM +0300, Alexey Izbyshev wrote:
> On 7/12/19 8:46 PM, Alexey Dobriyan wrote:
> > On Fri, Jul 12, 2019 at 06:36:26PM +0200, Oleg Nesterov wrote:
> >> On 07/12, Alexey Izbyshev wrote:
> >>>
> >>> --- a/fs/proc/base.c
> >>> +++ b/fs/proc/base.c
> >>> @@ -275,6 +275,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
> >>>  		if (got <= offset)
> >>>  			break;
> >>>  		got -= offset;
> >>> +		if (got < size)
> >>> +			size = got;
> >>
> >> Acked-by: Oleg Nesterov <oleg@redhat.com>
> > 
> > The proper fix to all /proc/*/cmdline problems is to revert
> > 
> > 	f5b65348fd77839b50e79bc0a5e536832ea52d8d
> > 	proc: fix missing final NUL in get_mm_cmdline() rewrite
> > 
> > 	5ab8271899658042fabc5ae7e6a99066a210bc0e
> > 	fs/proc: simplify and clarify get_mm_cmdline() function
> > 
> Should this be interpreted as an actual suggestion to revert the patches,
> fix the conflicts, test and submit them, or is this more like thinking out
> loud?

Of course! Do you have a reproducer?

> In the former case, will it be OK for long term branches?

For everyone.

If a rewrite causes 1 bug, 1 user visible change and a infoleak, it is
called revert.

> get_mm_cmdline() does seem easier to read for me before 5ab8271899658042.
> But it also has different semantics in corner cases, for example:

All semantics changes are recent.

> - If there is no NUL at arg_end-1, it reads only the first string in
> the combined arg/env block, and doesn't terminate it with NUL.

That's because fixed-length /proc/*/cmdline did that.

> - If there is any problem with access_remote_vm() or copy_to_user(),
> it returns -EFAULT even if some data were copied to userspace.
> 
> On the other hand, 5ab8271899658042 was merged not too long ago (about a year),
> so it's possible that the current semantics isn't heavily relied upon.
