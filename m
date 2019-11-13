Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1CBFB002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 12:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfKMLvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 06:51:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45453 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfKMLvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:51:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so2191632ljg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F3ba3fPaNjj6mlJHz6ZNFQ1Kt4UtZpzpsGyGcMEsfIQ=;
        b=zP4PL6GGMs7Kj1scjhgJHt2sVT3/NC5Acea4ch+a+0FuOqO5MOtgX0w4hMuz/ja5Iy
         Gt38FE9o1dloB4Z5+S0lVOSLOYCqD0+IJh1Cl6Yhz32Thzkp0P4qCXoyAyDjW+OQLaEB
         DhAU7qFnVX/Z+8DM1kYLOww9SLjFRtV3GPwa+UQeqQyJWfmp3RAPAV5MuOtOAol3wuyH
         o+tQBc3FZzL+aIBxqkJy6JaxIuTDoCf0Exg0gAuugREZVVM2CWvOuB8Dn5vUZVDipNJY
         Ci26/iXyMUHacFU2dBbl/GnTQwRMzj039b9UmINh2AoUz3NT3tAiuDVVU+uEGQ0U7DuO
         id0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F3ba3fPaNjj6mlJHz6ZNFQ1Kt4UtZpzpsGyGcMEsfIQ=;
        b=sBYyptvPcNySUeauswt8WKhHJMjQZu5qQ7LwP1qce3uONmrREN1BLpaoEWsOh2Uiz4
         iz8UcoW9XMUa/J7DKirzxseTAOZuUs5v7sWV6LoSBeoazYI7P//by20ezz+eVo8Zy6/A
         WjJZ2j4y7pbW51fDq89jDlZ0fB7OMtDLJi2MFaWuwtXxvXak6BBV3cykdC/AiSeveHy1
         g1t2FhVK5L3mY7fPC3WaNSf+nOLFwSuWzgsnKfXbiHMdxOWAZ/2enOqYQar6Y+lOz2N2
         ML6+CGiydRCvAWbFi3YnL4m/Ygs4uNZBA/7clne6SQUeHDQ3dF8EEyTs8i77x9rMVsO9
         Rvag==
X-Gm-Message-State: APjAAAVNBLxNhlAYdxGlAg51ELiTAxJsLGcwRd3/odIBtqNQqa5dCCRG
        i0OHFZmVSXL/N1HBzEqdZGPs1Q==
X-Google-Smtp-Source: APXvYqzKYvomWMYyrqmUw0GA6R5IG9gdUX23Ot2rzD6JQd1DJwcOXpb4Rwcb+3ZDxTO+fAwaPzJErA==
X-Received: by 2002:a2e:7204:: with SMTP id n4mr2215410ljc.139.1573645863283;
        Wed, 13 Nov 2019 03:51:03 -0800 (PST)
Received: from [10.94.250.119] ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id q124sm789120ljq.93.2019.11.13.03.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 03:51:02 -0800 (PST)
Subject: Re: [PATCH RT 2/2 v2] list_bl: avoid BUG when the list is not locked
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        Mike Snitzer <msnitzer@redhat.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <alpine.LRH.2.02.1911121110430.12815@file01.intranet.prod.int.rdu2.redhat.com>
 <335dafcb-5e07-63ed-b288-196516170bde@arrikto.com>
 <alpine.LRH.2.02.1911130616240.20335@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <7020d479-e8c7-7249-c6cd-c6d01b01c92a@arrikto.com>
Date:   Wed, 13 Nov 2019 13:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1911130616240.20335@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/19 1:16 PM, Mikulas Patocka wrote:
> 
> 
> On Wed, 13 Nov 2019, Nikos Tsironis wrote:
> 
>> On 11/12/19 6:16 PM, Mikulas Patocka wrote:
>>> list_bl would crash with BUG() if we used it without locking. dm-snapshot 
>>> uses its own locking on realtime kernels (it can't use list_bl because 
>>> list_bl uses raw spinlock and dm-snapshot takes other non-raw spinlocks 
>>> while holding bl_lock).
>>>
>>> To avoid this BUG, we must set LIST_BL_LOCKMASK = 0.
>>>
>>> This patch is intended only for the realtime kernel patchset, not for the 
>>> upstream kernel.
>>>
>>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>>
>>> Index: linux-rt-devel/include/linux/list_bl.h
>>> ===================================================================
>>> --- linux-rt-devel.orig/include/linux/list_bl.h	2019-11-07 14:01:51.000000000 +0100
>>> +++ linux-rt-devel/include/linux/list_bl.h	2019-11-08 10:12:49.000000000 +0100
>>> @@ -19,7 +19,7 @@
>>>   * some fast and compact auxiliary data.
>>>   */
>>>  
>>> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>>> +#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CONFIG_PREEMPT_RT_BASE)
>>>  #define LIST_BL_LOCKMASK	1UL
>>>  #else
>>>  #define LIST_BL_LOCKMASK	0UL
>>> @@ -161,9 +161,6 @@ static inline void hlist_bl_lock(struct
>>>  	bit_spin_lock(0, (unsigned long *)b);
>>>  #else
>>>  	raw_spin_lock(&b->lock);
>>> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>>> -	__set_bit(0, (unsigned long *)b);
>>> -#endif
>>>  #endif
>>>  }
>>>  
>>
>> Hi Mikulas,
>>
>> I think removing __set_bit()/__clear_bit() breaks hlist_bl_is_locked(),
>> which is used by the RCU variant of list_bl.
>>
>> Nikos
> 
> OK. so I can remove this part of the patch.
> 

I think this causes another problem. LIST_BL_LOCKMASK is used in various
functions to set/clear the lock bit, e.g. in hlist_bl_first(). So, if we
lock the list through hlist_bl_lock(), thus setting the lock bit with
__set_bit(), and then call hlist_bl_first() to get the first element,
the returned pointer will be invalid. As LIST_BL_LOCKMASK is zero the
least significant bit of the pointer will be 1.

I think for dm-snapshot to work using its own locking, and without
list_bl complaining, the following is sufficient:

--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -25,7 +25,7 @@
 #define LIST_BL_LOCKMASK       0UL
 #endif

-#ifdef CONFIG_DEBUG_LIST
+#if defined(CONFIG_DEBUG_LIST) && !defined(CONFIG_PREEMPT_RT_BASE)
 #define LIST_BL_BUG_ON(x) BUG_ON(x)
 #else
 #define LIST_BL_BUG_ON(x)

Nikos

> Mikulas
> 
>>> @@ -172,9 +169,6 @@ static inline void hlist_bl_unlock(struc
>>>  #ifndef CONFIG_PREEMPT_RT_BASE
>>>  	__bit_spin_unlock(0, (unsigned long *)b);
>>>  #else
>>> -#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>>> -	__clear_bit(0, (unsigned long *)b);
>>> -#endif
>>>  	raw_spin_unlock(&b->lock);
>>>  #endif
>>>  }
>>>
>>
> 
