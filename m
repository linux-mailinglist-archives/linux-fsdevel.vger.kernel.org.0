Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3141E7A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgE2KLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:11:49 -0400
Received: from smtp101.iad3b.emailsrvr.com ([146.20.161.101]:37466 "EHLO
        smtp101.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE2KLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:11:49 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 06:11:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590746736;
        bh=hBdqCLvxz/w+NZrRCtm6eGxIdN9tacjTj2TyQyUDZRw=;
        h=Subject:To:From:Date:From;
        b=duLjFscRslJ31A5bIza6CyZz1jNBXs71z9kpXCLjH4YSd1N157fjybsxpOkkvqqLC
         GXmHYWOoAy3M6F/1Ejnq96q1bX9pK05zdi8PSuOYReIlUNQoYYgSEy2ERUqT8mAmd/
         K7LovOWNlxuf9n5ES6EaGcTL7jCoc3ywj5cf+YLc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A13F660163;
        Fri, 29 May 2020 06:05:35 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:05:36 -0400
Subject: Re: [PATCH 05/10] comedi: get rid of compat_alloc_user_space() mess
 in COMEDI_INSN compat
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
 <20200529003512.4110852-5-viro@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <fa6c5bf1-7394-dda6-eb6c-a39ad5de7965@mev.co.uk>
Date:   Fri, 29 May 2020 11:05:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003512.4110852-5-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: dddbe66e-1fc3-48ec-b194-343e829ad997-1-1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/05/2020 01:35, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Just take copy_from_user() out of do_insn_ioctl() into the caller and
> have compat_insn() build a native version and pass it to do_insn_ioctl()
> directly.
> 
> One difference from the previous commits is that the helper used to
> convert 32bit variant to native has two users - compat_insn() and
> compat_insnlist().  The latter will be converted in next commit;
> for now we simply split the helper in two variants - "userland 32bit
> to kernel native" and "userland 32bit to userland native".  The latter
> is renamed old get_compat_insn(); it will be gone in the next commit.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/staging/comedi/comedi_fops.c | 73 +++++++++++++++++++++++-------------
>   1 file changed, 46 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index d96dc85d8a98..ae0067ab5ead 100644
[snip]
> @@ -2244,10 +2241,13 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
>   				       (struct comedi_insnlist __user *)arg,
>   				       file);
>   		break;
> -	case COMEDI_INSN:
> -		rc = do_insn_ioctl(dev, (struct comedi_insn __user *)arg,
> -				   file);
> +	case COMEDI_INSN: {
> +		struct comedi_insn insn;
> +		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
> +			rc = -EFAULT;

Missing an 'else' here:

> +		rc = do_insn_ioctl(dev, &insn, file);
>   		break;
> +	}
>   	case COMEDI_POLL:

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
