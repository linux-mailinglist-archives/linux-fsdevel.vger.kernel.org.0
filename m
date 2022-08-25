Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884485A0E67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbiHYKts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbiHYKtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:49:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF923F;
        Thu, 25 Aug 2022 03:49:44 -0700 (PDT)
Received: from [192.168.10.7] (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20DB46601E9A;
        Thu, 25 Aug 2022 11:49:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661424582;
        bh=XkXPRTCnn8052jSrei91LRmXIOrhuSsnF8sZf7lA8MA=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=g7ucgvT/HMYyMaHad4z8nxdP4MVUQ3ZO8rDgsIv5Mw17IyGU+TirSXECdNoQsTHA2
         mJsK2clwfJtrCff27ujqfR3UujxtMW2ltvacmS9U4f8/QMgh3YIHBQGF0ypwPYzgFy
         V2d/5vJPg/PczJM+VQBFzkxDg8wfSSaMTEKMUSJy4PeUobRnLA8R3xV74SGFkAZ+Sh
         xehd3876tXBbHz6hRF8Xo1oIPCYdIWC76LdIpHjxh7GFt+3VkZSsKRDd9D1FGCNWPu
         EN1JmKmJWXxdkzaz6LEcWE8x4yGnRSlrjCr7+ULT7NACyeLTu2LaGQy6glmfVb/0+S
         9d2ocZKEpAEXg==
Message-ID: <1bfb71e6-1553-b83d-b151-8c8c5ffc5066@collabora.com>
Date:   Thu, 25 Aug 2022 15:49:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     usama.anjum@collabora.com, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v2 2/4] fs/proc/task_mmu: Implement IOCTL to get and clear
 soft dirty PTE bit
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220825070926.2922471-1-usama.anjum@collabora.com>
 <20220825070926.2922471-3-usama.anjum@collabora.com>
 <YwcjTOgKD22TXwYk@kroah.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <YwcjTOgKD22TXwYk@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/25/22 12:22 PM, Greg KH wrote:
> On Thu, Aug 25, 2022 at 12:09:24PM +0500, Muhammad Usama Anjum wrote:
>> - The flags can be specified in the flags field. Currently only one
>>   PAGEMAP_SD_NO_REUSED_REGIONS is supported which can be specified to
>>   ignore the VMA dirty flags.
> 
> You forgot to check that all other bits in that flag are set to 0
> properly, otherwise you can never add a new bit to the field ever as you
> can't expect userspace got it right and did not accidentaly set it
> already.
> 
> There is kernel documentation on how to add a new ioctl, you might want
> to read up on that first before resending this.
Thank you so much for the review. I'll revisit and resend a v3.

> 
> thanks,
> 
> greg k-h

-- 
Muhammad Usama Anjum
