Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621C84245A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhJFSHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbhJFSHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:07:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FBCC061766;
        Wed,  6 Oct 2021 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UXOqw6LYYO+wVibxP4e/orAi9rkc97L/HWtRElWnpJY=; b=462AX6p5/pblPwzDuTNTIoQdTm
        55fDtkidx88LFDHJd7iCL4sfa4X9pd49aIkLbRrrkT/4J+lPF2CIVkSNPC2uiWVCkmX0nrzfkrvP/
        hItmXQl9oeHxbtulFkxUSI/W0+fpAp++iKDSXmK0+gQRKj8fkCEQaMA36uBHA+DB6OykHj4mSmjk+
        dz1y7uErtG4BPtMRBq6TV3zWJJYGZEstq7GU3u7NYnYLpwifW4etczK1+qIIiU8EvXM/FaCATw7SE
        PBawL4Gskhv9VpWxkS4KW4rahq55RR5E3I0GyQOqQizeMF78ZUfKF7+LTMZml0Kdz5cXFy9UGOXLJ
        +3MlZq2Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYBIV-00FILd-UO; Wed, 06 Oct 2021 18:05:44 +0000
Subject: Re: mmotm 2021-10-05-19-53 uploaded
 (drivers/gpu/drm/msm/hdmi/hdmi_phy.o)
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
References: <20211006025350.a5PczFZP4%akpm@linux-foundation.org>
 <58fbf2ff-b367-2137-aa77-fcde6c46bbb7@infradead.org>
 <20211006182052.6ecc17cf@canb.auug.org.au>
 <f877a1c9-1898-23f3-bba3-3442dc1f3979@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <34c2f6ab-3982-a031-1af6-5ed482b5c344@infradead.org>
Date:   Wed, 6 Oct 2021 11:05:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f877a1c9-1898-23f3-bba3-3442dc1f3979@amd.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/21 12:24 AM, Christian König wrote:
> 
> 
> Am 06.10.21 um 09:20 schrieb Stephen Rothwell:
>> Hi Randy,
>>
>> On Tue, 5 Oct 2021 22:48:03 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>> on i386:
>>>
>>> ld: drivers/gpu/drm/msm/hdmi/hdmi_phy.o:(.rodata+0x3f0): undefined reference to `msm_hdmi_phy_8996_cfg'
>>>
>>>
>>> Full randconfig fle is attached.
>> This would be because CONFIG_DRM_MSM is set but CONFIG_COMMON_CLOCK is
>> not and has been exposed by commit
>>
>>    b3ed524f84f5 ("drm/msm: allow compile_test on !ARM")
>>
>> from the drm-misc tree.
> 
> Good point, how about this change:
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 5879f67bc88c..d9879b011fb0 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -5,7 +5,7 @@ config DRM_MSM
>          depends on DRM
>          depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
>          depends on IOMMU_SUPPORT
> -       depends on (OF && COMMON_CLK) || COMPILE_TEST
> +       depends on (OF || COMPILE_TEST) && COMMON_CLK
>          depends on QCOM_OCMEM || QCOM_OCMEM=n
>          depends on QCOM_LLCC || QCOM_LLCC=n
>          depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n

WorksForMe. Thanks.
(other than the whitespace damage)

-- 
~Randy
