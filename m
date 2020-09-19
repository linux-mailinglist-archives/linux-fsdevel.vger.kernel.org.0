Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56B271071
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgISURq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgISURq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 16:17:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15035C0613CE;
        Sat, 19 Sep 2020 13:17:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so5734093pfk.2;
        Sat, 19 Sep 2020 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nufqMxRxzBynEUzPSmKE11m5kNg4+eB3mixf5Nnih4E=;
        b=dswyVVpWzVbiP2kS5AD/QD8cHzI45lM/MxkySFRQSVYmP2C8cVcZnsoIUHMkeP0p6/
         NlTrTAXVIQGKSljeVEQhU+rnZwZ3C/3m2dB4u56v+olo8gfT5B9MdaXdKTVwCBBXSfso
         d5Z4wDdJJBRlamEyPm/YjKSiZ8yioEkioxLfq+AigV1SPZ/xhfZr0jOIVyYzat9wDWYC
         51w3q3tm5bQ7RG8qzu+7WpdTHbkb0eyDyFpKSEapx3qUPx39/PPaLOEEJuICYPy02oWM
         UnjgNwiJitmwsUd5YiujlNl9YLxZIOY8BPW9NDqyDoHD3//eqchZuhpJIFz3Tx97SysN
         eKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nufqMxRxzBynEUzPSmKE11m5kNg4+eB3mixf5Nnih4E=;
        b=L7q3f+lVdQWz5koVnjAq++F2J045zwW+UsnLWFb2cdoChW+tdV9g2b7PeM4nG+OdqA
         0WVyNt7Ssad8I2VFRgattaVfuMbenElb2M/sCD7nL/F96amVb413wNm0LVg/aVRVtUU1
         pJhuXPep9Adfd/UPkSyAFUUqyHmERBVH/MoZ627oVBdLRoPIOjJTP5AROPohdLhWq8D0
         drNLTPK3ipjC+bjKsOcI9iPWCfeWK5ba9KM4y1uKhNWoorlh0+nSnJTfGNUURNObHY68
         /zRSynaIk22FZq1M0hk3hR5CqAuDxCv5uoUn0AXQ3JsRylWCgjvE5HZhEwGZCu/7XY9s
         UNyQ==
X-Gm-Message-State: AOAM532ORsq3/aD383vrB/oD9QGONCSOLttvFL78oT3KQyns55nMvScT
        i3nsadjXVV57YNGdX8ndoPEmRmUWhO3FMTvfj+A=
X-Google-Smtp-Source: ABdhPJwmaLvMmQ0FhJwwhvT/7QRl99Kv7dcwIDpJdJkJ/7+mObcFcvLUIlKkLC9FIB3sn+NWTWMmwg==
X-Received: by 2002:aa7:8aca:0:b029:13e:d13d:a07d with SMTP id b10-20020aa78aca0000b029013ed13da07dmr37930221pfd.20.1600546664624;
        Sat, 19 Sep 2020 13:17:44 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.212.24])
        by smtp.gmail.com with ESMTPSA id d20sm6371822pjv.39.2020.09.19.13.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 13:17:43 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: fix KMSAN uninit-value bug by
 initializing nd in do_file_open_root
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
References: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
 <20200916054157.GC825@sol.localdomain>
 <20200917002238.GO3421308@ZenIV.linux.org.uk>
 <20200919144451.GF2712238@kroah.com>
 <20200919161727.GG3421308@ZenIV.linux.org.uk>
 <20200919165558.GH3421308@ZenIV.linux.org.uk>
 <26d881e5-f68a-b3b7-4cb0-04a3c6c384ac@gmail.com>
Message-ID: <e8b218d4-e64a-ac0a-ea53-567d07a58f42@gmail.com>
Date:   Sun, 20 Sep 2020 01:47:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <26d881e5-f68a-b3b7-4cb0-04a3c6c384ac@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19-09-2020 17:03, Anant Thazhemadam wrote:
> On 19-09-2020 22:25, Al Viro wrote:
>> On Sat, Sep 19, 2020 at 05:17:27PM +0100, Al Viro wrote:
>>
>>> Lovely...  That would get an empty path and non-directory for a starting
>>> point, but it should end up with LAST_ROOT in nd->last_type.  Which should
>>> not be able to reach the readers of those fields...  Which kernel had
>>> that been on?
>> Yecchhh...  I see what's going on; I suspect that this ought to be enough.
>> Folks, could somebody test it on the original reproducer setup?
> Sure. I can do that.

Looks like this patch actually fixes this bug.
I made syzbot test the patch, and no issues were triggered!

Note:    syzbot tested the patch with the KMSAN kernel, which
was recently rebased on v5.9-rc4.

Thanks,
Anant

