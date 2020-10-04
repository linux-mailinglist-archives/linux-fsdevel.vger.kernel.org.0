Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E457282B68
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgJDPZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDPZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 11:25:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3AC0613CE;
        Sun,  4 Oct 2020 08:25:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so1588447pfp.13;
        Sun, 04 Oct 2020 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=61Y9XXa32aHa2HBH5bKa29Ys7Tpne59ThWARVK1VO5M=;
        b=S/9vKvvNgK6Nw/O7vNDqpFYfPPRkGTRDHFm4Liv+pjE8n0McxtM9JKVieg6pvxyIAI
         mg2fO1mmY3MaVzzQwu4WqZ8mHX3GFbPM9mLSsGaAayWu+euQzELw7Lg5wFPRibD6J0Bv
         2zvSAWMfueSWaXeGuMNizP2MYcHzbtd046vnj09llBpIek/rJwpSYo5jcIAE/aHxky0V
         sYrkKDCldPUTyGrlM4JU7MrrCpLxZizijbdNcZGehttMA58KX+sPtAPCKZN3GD125TCk
         eWoh9RIVtDQYtV1hIiCSo6IacX0rLxYHbfHyhvnYj4ER3YFsZdKF7op6o3PhBum4dLDm
         GE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=61Y9XXa32aHa2HBH5bKa29Ys7Tpne59ThWARVK1VO5M=;
        b=Hd9RrEcIcQWYzhM6Ht++VUFKWDMkPS/sewc8IQ+eO0ouADznPl7/15oJBwE33jb/Sh
         fJ+Od29OKWzkTC+Fb588xcr9JmuiKYJbBMQG38W3OOlertMM04/Psvb2wfEwwZUrLRaN
         Gg2Qc9kJOIJ//4g++BHh5wKek4b+7O80z9wv7ys446/4TXfnuVfuYHGq2sLfIxPjyxNq
         X7CIkTVLO+jMZEax1Ks3Z8Rm2Kw49RAMUuLgVCYLy/da/FSib6b2hwapS12hoAB9joN3
         o4bEOXBQ2h7eliufYm0nffOgybokaxlaQ6OkJ+kqDDvCW+SD5TVxftsTMpU2BgqFa8tl
         Tlfg==
X-Gm-Message-State: AOAM532IiXAZA2azZb5IfN2eqS/g7mtOiInD0HGbP/0TDubK99UnYJa7
        bsW81MFz5Lv38QlSsJ8O8LmSuC/e48n3Q4Ho2OY=
X-Google-Smtp-Source: ABdhPJx97wWLfx3WjXcyASNCqXzkrzVfdDgRFx87Yag9PXstJOg4yR1urxl581eZE2Q9026h1+snWA==
X-Received: by 2002:a65:644c:: with SMTP id s12mr1176142pgv.327.1601825134548;
        Sun, 04 Oct 2020 08:25:34 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.217.69])
        by smtp.gmail.com with ESMTPSA id v10sm7698991pjf.34.2020.10.04.08.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 08:25:33 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: fix KMSAN uninit-value bug by
 initializing nd in do_file_open_root
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
References: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
 <20200916054157.GC825@sol.localdomain>
 <20200917002238.GO3421308@ZenIV.linux.org.uk>
 <20200919144451.GF2712238@kroah.com>
 <20200919161727.GG3421308@ZenIV.linux.org.uk>
 <20200919165558.GH3421308@ZenIV.linux.org.uk>
 <26d881e5-f68a-b3b7-4cb0-04a3c6c384ac@gmail.com>
 <e8b218d4-e64a-ac0a-ea53-567d07a58f42@gmail.com>
Message-ID: <0537f532-1499-f644-2c91-ad91da7901df@gmail.com>
Date:   Sun, 4 Oct 2020 20:55:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e8b218d4-e64a-ac0a-ea53-567d07a58f42@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 20-09-2020 01:47, Anant Thazhemadam wrote:
> On 19-09-2020 17:03, Anant Thazhemadam wrote:
>> On 19-09-2020 22:25, Al Viro wrote:
>>> On Sat, Sep 19, 2020 at 05:17:27PM +0100, Al Viro wrote:
>>>
>>>> Lovely...  That would get an empty path and non-directory for a starting
>>>> point, but it should end up with LAST_ROOT in nd->last_type.  Which should
>>>> not be able to reach the readers of those fields...  Which kernel had
>>>> that been on?
>>> Yecchhh...  I see what's going on; I suspect that this ought to be enough.
>>> Folks, could somebody test it on the original reproducer setup?
>> Sure. I can do that.
> Looks like this patch actually fixes this bug.
> I made syzbot test the patch, and no issues were triggered!
>
> Note:    syzbot tested the patch with the KMSAN kernel, which
> was recently rebased on v5.9-rc4.
>
> Thanks,
> Anant

Ping.
Has the patch that was tested been applied to any tree yet?
If yes, could someone please let me know the commit details, so we can close
the issue? (Unfortunately, I was unable to find it. :( )

Thanks,
Anant

