Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2F270FB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgISRD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F29C0613CE;
        Sat, 19 Sep 2020 10:03:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so5400519pgd.3;
        Sat, 19 Sep 2020 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0w8QbwM4kvqqRSaS1CHSdmOE6xRTZzX0zjgQjqhKDF0=;
        b=qx/oIGreK31Y6ETNGs/oln3jQ0qx9pvT8TBNtkNN19nR4lNugF6enbJTX4d0iWk7Ms
         dPvb2UoEnAjmBcHnjynt8u7rFvxEUYM3+iEvgVwr2hW4PEgfdCu1B4Ueribxo7hfy9SR
         HnxwBFa3s3kdu2CiWYcABCW2IhFzbwWQnn0JYqZkYaAcmN7HE2HNDH4aKDaE+K2S+zoK
         geUinYva8s+J8N2Yib7FDRNdPTOa27AUEEechVAdPKMaqQQM5wT36mRuNmS81b6PtfYf
         E1S5hl4+R68/og0k0Jn8qnZaNcYUvKHb3FYR4lJ/3N9LJwURlyGGCZrFxrGePMyc1ALN
         enZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0w8QbwM4kvqqRSaS1CHSdmOE6xRTZzX0zjgQjqhKDF0=;
        b=kdXhIIXGcktMgfaIpywEzk1Xzye4wbANOuqZ5cnR63ybeqEAHKLOPNLS2v47fTv8xx
         H52hgKPJdqXCrCgreliLCp39Bbvd/5L+wv88ywi96Y2/R/LFXK4sLVYNT+k874w+wdX7
         qvLaOAu6HCyvYG5DzlKCq0kNB6SreoSiJUUs0Bb+4gqCiva0icFOiCtdokv/gu7fPQhx
         Icm965zMMc1VyRnm1DkqI9kFRt+7UoVzb7WV8v2KqSb/5qZMhaOIuMKC5bsAM9asXiU0
         zicd2/dqqgbHjv0R21/c5vg+/HPN2npM/wnJarLAWB4t+nZywsap4VoeVKOHeq6fvCqE
         0pWw==
X-Gm-Message-State: AOAM5300OYSLhkZsZt0OVr+7iRFS3mdzzWExyAsjrGrZ0tkIAja3I3sf
        mIn28sUiXHA/eXXiNjad4cT76anQgmrt90C4a/U=
X-Google-Smtp-Source: ABdhPJxexXsrnXptAxi5so8K363t5vhAMff8n1qfJ44WUX0aS/CL9GTAnnqtJntEjZjKUhVbBRFdjg==
X-Received: by 2002:a63:485c:: with SMTP id x28mr31998096pgk.289.1600535034888;
        Sat, 19 Sep 2020 10:03:54 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.212.24])
        by smtp.gmail.com with ESMTPSA id k28sm6958398pfh.196.2020.09.19.10.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:03:54 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: fix KMSAN uninit-value bug by
 initializing nd in do_file_open_root
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
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <26d881e5-f68a-b3b7-4cb0-04a3c6c384ac@gmail.com>
Date:   Sat, 19 Sep 2020 17:03:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200919165558.GH3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19-09-2020 22:25, Al Viro wrote:
> On Sat, Sep 19, 2020 at 05:17:27PM +0100, Al Viro wrote:
>
>> Lovely...  That would get an empty path and non-directory for a starting
>> point, but it should end up with LAST_ROOT in nd->last_type.  Which should
>> not be able to reach the readers of those fields...  Which kernel had
>> that been on?
> Yecchhh...  I see what's going on; I suspect that this ought to be enough.
> Folks, could somebody test it on the original reproducer setup?

Sure. I can do that.

Thanks,
Anant
