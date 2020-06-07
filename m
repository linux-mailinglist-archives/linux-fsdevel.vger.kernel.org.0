Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479421F0B5C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFGNWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFGNWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:22:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43622C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2020 06:22:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so15239052eja.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2020 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fzHKd/0Iik52KxAHm17miqHrvv8VGhsBlmCTklHYBK0=;
        b=RTqzxRQSbAil8qchRl589zrlc8vgCLgJXlDKlctrTiR6SE4e630dxGjEVVMmvoI0g7
         Rjn9gWOtfOxqB1rhf5xpCNQ5YtandOBkwYH1zPlSmnoGT2bfKdckbdTDe4PJtwpBgunz
         IF6+1Mn8yjbbVH77tmCjaT7tRzqLyScUFLGSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fzHKd/0Iik52KxAHm17miqHrvv8VGhsBlmCTklHYBK0=;
        b=QZwcZGv9G5XbAarkYcutdsTJ1j7iOHhpRNcAUrpKU+ZrQGlcaud2lsPMIqR8ZSs3tE
         Q//riyMmg5AEI/2rSqRAcKOoiqbWfNhgw3quf9n1dRNcUnvKIpzV8t3lpr0Y1IshpuMb
         pQJ/vP6y2jRrjYpcvFm9+7YISfRtaXQKw1NDRywKmKaYEOwjsNJwId/4BQcknB0gt0lb
         DBt0gwC4Ck5zkYmog17Gnl5c9G6ZnWoTHJNicNY9gmBCTkgdHp/lUzlxcXRiXO2b6VgO
         OD7Kykl8sKoccOC/fVlNRDWn3bBaLdsgvQZ005i3dkTwHzv7jdARAEahjAkaOo6UHOAd
         x1/Q==
X-Gm-Message-State: AOAM53187O+xjrUwDeZ7tBO2eqrurDM0yQqc6nkuvCeFRx+8Oh/XsYXt
        nwDpS1of8F5pbewutrHzFpRAkQ==
X-Google-Smtp-Source: ABdhPJzf8CLvNZNNXbqFYmb0UVquLXUsUW98berfmNFKWpfgPm3Y8VOMkt/oakzb+bYcCF4FBIW4Ug==
X-Received: by 2002:a17:906:2615:: with SMTP id h21mr16577823ejc.84.1591536136693;
        Sun, 07 Jun 2020 06:22:16 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id l1sm8526325ejd.114.2020.06.07.06.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 06:22:15 -0700 (PDT)
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
Date:   Sun, 7 Jun 2020 15:22:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/06/2020 22.18, Linus Torvalds wrote:
> On Fri, Jun 5, 2020 at 7:23 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> +               /*
>> +                * If the "group" and "other" permissions are the same,
>> +                * there's no point calling in_group_p() to decide which
>> +                * set to use.
>> +                */
>> +               if ((((mode >> 3) ^ mode) & 7) && in_group_p(inode->i_gid))
>>                         mode >>= 3;
> 
> Ugh. Not only is this ugly, but it's not even the best optimization.
>
> We don't care that group and other match exactly. We only care that
> they match in the low 3 bits of the "mask" bits.

Yes, I did think about that, but I thought this was the more obviously
correct approach, and that in practice one only sees the 0X44 and 0X55
cases.

> So if we want this optimization - and it sounds worth it - I think we
> should do it right. But I also think it should be written more
> legibly.
> 
> And the "& 7" is the same "& (MAY_READ | MAY_WRITE | MAY_EXEC)" we do later.
> 
> In other words, if we do this, I'd like it to be done even more
> aggressively, but I'd also like the end result to be a lot more
> readable and have more comments about why we do that odd thing.
> 
> Something like this *UNTESTED* patch, perhaps?

That will kinda work, except you do that mask &= MAY_RWX before
check_acl(), which cares about MAY_NOT_BLOCK and who knows what other bits.

> I might have gotten something wrong, so this would need
> double-checking, but if it's right, I find it a _lot_ more easy to
> understand than making one expression that is pretty complicated and
> opaque.

Well, I thought this was readable enough with the added comment. There's
already that magic constant 3 in the shifts, so the 7 seemed entirely
sensible, though one could spell it 0007. Whatever.

Perhaps this? As a whole function, I think that's a bit easier for
brain-storming. It's your patch, just with that rwx thing used instead
of mask, except for the call to check_acl().

static int acl_permission_check(struct inode *inode, int mask)
{
	unsigned int mode = inode->i_mode;
	unsigned int rwx = mask & (MAY_READ | MAY_WRITE | MAY_EXEC);

	/* Are we the owner? If so, ACL's don't matter */
	if (likely(uid_eq(current_fsuid(), inode->i_uid))) {
		if ((rwx << 6) & ~mode)
			return -EACCES;
		return 0;
	}

	/* Do we have ACL's? */
	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
		int error = check_acl(inode, mask);
		if (error != -EAGAIN)
			return error;
	}

	/*
	 * Are the group permissions different from
	 * the other permissions in the bits we care
	 * about? Need to check group ownership if so.
	 */
	if (rwx & (mode ^ (mode >> 3))) {
		if (in_group_p(inode->i_gid))
			mode >>= 3;
	}

	/* Bits in 'mode' clear that we require? */
	return (rwx & ~mode) ? -EACCES : 0;
}

Rasmus
