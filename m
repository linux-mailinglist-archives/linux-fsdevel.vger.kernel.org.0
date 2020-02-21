Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C63166B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgBUAVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:21:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgBUAVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=tMJ8YKxTeBtxTcT9+8gwag/FsvtT3wSn7stN9kvfG0Q=; b=I6fAixvGMEOmvfzzpJEepAfJtm
        PXVdq7yCLQEEvy3t4ujzGyV7hIW+tgNWOV8C5gsgeQYhP6ptOwGo++BOf6tv10ZObHBITktO81YPa
        4jTb5lEt5DXYFa/oiYiSp7rLSDtYv9RCg2hyZx+zX+bQ/SrQKlYio37lgRDJw1YECZxMGJfkoLMwR
        CN/nFFlNnR7HtjwlPFeDw5VT4YPCJkAPkoD9d4K90iqtIkPIfypmhBbxTdEdhNu3K0GaPha8Nmgqp
        yuh3hYYGgfpmN2VKO1HvdUWu2GBjyqBPghv3XIiekadWeA8GpLbHW3OafvDVigtMmp/mfiK4hAPQO
        vAbEVGdQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4w4H-0003FS-Sz; Fri, 21 Feb 2020 00:21:21 +0000
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <827a4520-95ce-5264-90d9-ed730e5918e6@infradead.org>
 <22c48aaf-21e2-56ab-3f40-e497a69cd936@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bfbb883b-f222-922e-bdf0-3491af14e446@infradead.org>
Date:   Thu, 20 Feb 2020 16:21:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <22c48aaf-21e2-56ab-3f40-e497a69cd936@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/20/20 4:06 PM, Scott Branden wrote:
> Hi Randy,
> 
> On 2020-02-19 5:04 p.m., Randy Dunlap wrote:
>> Hi,
>>
>> On 2/19/20 4:48 PM, Scott Branden wrote:
>>> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
>>> new file mode 100644
>>> index 000000000000..c75dfb89a38d
>>> --- /dev/null
>>> +++ b/drivers/misc/bcm-vk/Kconfig
>>> @@ -0,0 +1,42 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +#
>>> +# Broadcom VK device
>>> +#
>>> +config BCM_VK
>>> +    tristate "Support for Broadcom VK Accelerators"
>>> +    depends on PCI_MSI
>>> +    default m
>> Need to justify default m. Normally we don't add drivers as enabled unless
>> they are required for basic (boot) operation.
> Will remove default m as not needed to boot.  Interesting other offload engines misc/ocxl/Kconfig and misc/cxl/Kconfig have default m.

Thanks.

Uh, yes, that is interesting.  They both depend on PPC_POWERNV,
which I know nothing about.

>>> +    help
>>> +      Select this option to enable support for Broadcom
>>> +      VK Accelerators.  VK is used for performing
>>> +      specific video offload processing.  This driver enables
>>> +      userspace programs to access these accelerators via /dev/bcm-vk.N
>>> +      devices.
>>> +
>>> +      If unsure, say N.

-- 
~Randy

