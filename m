Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E796B68E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 08:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfGQGVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 02:21:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQGVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8acWEJVKozUDgbpRsbTOTilbmLjq4nOryNdKnvI3qyI=; b=aWKQb3fHRk6FMee1FGDNwMLKe
        M4Nqa+LepSV7tm+3LRwMfSbx4YMi0yKJm++e0dwlPzvuu27wTU55lV/eOOee2V9w5Vp22S11zU+Fv
        eMfWoMv0NtG0DCNW/L6kHVbz6lV70XsOcbLToJCrwjYX6DcM7MQeUw75slz52UzQrL7e1rjxcFo71
        FW9uqsmTIxpBvyyI78MZqW93YZ9orfltYRCirJ60GcYxMc45MGbelUJeOeuEu/dDYvmrgHf3w90QH
        FZxAzZhM1jOBFIVXjMmm+BLRmYL4cBf+fQCT07AS8xT87dMHt9OeDHAsQUU2rZ2Nx4uW3c6Ubfv8U
        Ed+H3mQ3w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hndK0-0007nf-Mj; Wed, 17 Jul 2019 06:21:48 +0000
Subject: Re: mmotm 2019-07-16-17-14 uploaded
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
References: <20190717001534.83sL1%akpm@linux-foundation.org>
 <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
 <20190717143830.7f7c3097@canb.auug.org.au>
 <a9d0f937-ef61-1d25-f539-96a20b7f8037@infradead.org>
Message-ID: <072ca048-493c-a079-f931-17517663bc09@infradead.org>
Date:   Tue, 16 Jul 2019 23:21:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a9d0f937-ef61-1d25-f539-96a20b7f8037@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/16/19 11:19 PM, Randy Dunlap wrote:
> On 7/16/19 9:38 PM, Stephen Rothwell wrote:
>> Hi Randy,
>>
>> On Tue, 16 Jul 2019 20:50:11 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> drivers/gpu/drm/amd/amdgpu/Kconfig contains this (from linux-next.patch):
>>>
>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig~linux-next
>>> +++ a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>> @@ -27,7 +27,12 @@ config DRM_AMDGPU_CIK
>>>  config DRM_AMDGPU_USERPTR
>>>  	bool "Always enable userptr write support"
>>>  	depends on DRM_AMDGPU
>>> +<<<<<<< HEAD
>>>  	depends on HMM_MIRROR
>>> +=======
>>> +	depends on ARCH_HAS_HMM
>>> +	select HMM_MIRROR
>>> +>>>>>>> linux-next/akpm-base  
>>>  	help
>>>  	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
>>>  	  isn't already selected to enabled full userptr support.
>>>
>>> which causes a lot of problems.
>>
>> Luckily, I don't apply that patch (I instead merge the actual
>> linux-next tree at that point) so this does not affect the linux-next
>> included version of mmotm.
>>
> 
> for the record:  drivers/gpio/Makefile:
> 
> <<<<<<< HEAD
> obj-$(CONFIG_GPIO_BD70528)              += gpio-bd70528.o
> =======
> obj-$(CONFIG_GPIO_BD70528)              += gpio-bd70528.o
>>>>>>>> linux-next/akpm-base
> 
> 
> 

drivers/dma-buf/dma-buf.c:
<<<<<<< HEAD
=======
#include <linux/pseudo_fs.h>
>>>>>>> linux-next/akpm-base



-- 
~Randy
