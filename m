Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8C41543D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 01:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhIVXwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 19:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbhIVXwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:52:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D3AC061574;
        Wed, 22 Sep 2021 16:51:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w11so2808570plz.13;
        Wed, 22 Sep 2021 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XgsEeLYbI0UodBnr5lEX+ShnspAuT3D7cmzwnoUdmpI=;
        b=K9gSs3wE0vKD30XeVAtdrlMuNXXyCgj+Bw2AwXWygL82Cb7ahh5TjRL/6p2m42yhqI
         8pCejBWe6CpxxEVq6OIe7k6Mv4HWjkJCtsE+buNTRbzRIFD7SsJVgoXFa55acGaEmshy
         RUmzJNBjFFtIvfw1hSqFrWzknRwugpxzgD4zMaxcE6gkBCOA+uEeAMiL3lVRVw1GpEYk
         jiKClW13no5FIRrQIgTVVXB5HFhPGJXz3oA0JoQhcc1yATxDEHx95Ni+IKdCrj2Dgdmn
         Zd2vK9R+23a1L+mDTdP9TooNJR9wWG8kg5QJqL/c1ysTfKF68IG6JqGxsRQPpmLitqaA
         mv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XgsEeLYbI0UodBnr5lEX+ShnspAuT3D7cmzwnoUdmpI=;
        b=sJhTxnTyP0UpXa5vns7KhXFl0pMW91e+xEvDpDuC4RaUTM2ynP4lCcwUT1OiBQ0Zmz
         a1VhkoIqUWk64ZtQ7a4VFFUtYmtRwFi3kOrwSj/eLkTBhX9Y3eq04Ip1RAsHUqSQ2bOh
         tND/EN889Bik7EXwz2Rurdz89WBAKnFakc7T5VqxuOwClTgdFTYlOymeARdLHzXmSwgy
         6TIboAJ2kDr3gwI8rrmvCPsYFC8jfK4TUnbnd8d/92pcouY177WbWaFnLvG7KVy++uGu
         s5OviPhlMnu38FimtGX580y4nx/h2c1uvt3SE7K/jA1GcQfFiua3DZqGPuIdFaEdNfIN
         a7dA==
X-Gm-Message-State: AOAM533WKvD8IOvj/OtVfh4HfPh7GF3+vtti/sqRhZe2t8eP+m9aY5o2
        pXaA5tya1cd8UT7OhCHHKX4=
X-Google-Smtp-Source: ABdhPJxSECMetH5CJrAF4QRktI/abljPiV+7Jg0aPgE6MLXfH/WZ9kGeVNzMdiVATS/aFMygi0foVQ==
X-Received: by 2002:a17:902:e785:b0:13d:a0a6:4bd with SMTP id cp5-20020a170902e78500b0013da0a604bdmr1589806plb.30.1632354682421;
        Wed, 22 Sep 2021 16:51:22 -0700 (PDT)
Received: from ?IPV6:2600:8802:380b:9e00:5524:2ae2:3f26:1cbf? ([2600:8802:380b:9e00:5524:2ae2:3f26:1cbf])
        by smtp.gmail.com with ESMTPSA id g14sm3375410pjk.20.2021.09.22.16.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 16:51:22 -0700 (PDT)
Message-ID: <cf0af95b-4937-0d98-a048-a2e1a90172e6@gmail.com>
Date:   Wed, 22 Sep 2021 16:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        willy@infradead.org
References: <20210922115222.8987-1-ddiss@suse.de>
 <YUu91kH8kOcVHxyb@zeniv-ca.linux.org.uk>
From:   Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <YUu91kH8kOcVHxyb@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/22/2021 4:35 PM, Al Viro wrote:
> On Wed, Sep 22, 2021 at 01:52:18PM +0200, David Disseldorp wrote:
>> do_header() is called for each cpio entry and first checks for "newc"
>> magic before parsing further. The magic check includes a special case
>> error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
>> special case POSIX.1 check needn't be done in the hot path, so move it
>> under the non-newc-magic error path.
> You keep refering to hot paths; do you have any data to support that
> assertion?
> 
> How much does that series buy you on average, and what kind of dispersion
> do you get before and after it?
> 
> I'm not saying I hate the patches themselves, but those references in commit
> messages ping my BS detectors every time I see them ;-/

And this exactly why cover-letter with a quantitative date for such
series is important based on my experience...
