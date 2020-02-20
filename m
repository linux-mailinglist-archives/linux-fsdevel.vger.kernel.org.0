Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA14165402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 02:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBTBEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 20:04:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgBTBEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3BHL21ZqYvf4cXWBd1/ab6+pZgwMbOograui/t2in4Q=; b=Y2F8BNU9IGvys2N2MQOenMYNwp
        +IrnfcmBH0shv9ZUFezaJBrOrMWeJ56kYqWE/S2Co2mp3i1dhZ7D41EsTGAV/yzAHp6kmpl8pMx4y
        Vz+b2TRxJIDtn63xKBdI/AxAsIUmmRSsdA0yrfu2DcbWpKDkCNyl11/OByWqIF3rNO4EpuEqokqvl
        A+cSkuI1maBCBJMyQexlSpmMIWzduXQ5i5x6IDABAtR/jrqMXVlFPWizsED2mb2ICNUcnpIu4sfhS
        DlNmlg3WSV+qRWWX67zw3p/LatenkuXdRZMB4pl0HHOBu8MAy/7r98fbw0e+OLYch2F8b73oqiTyz
        XcLFyvyA==;
Received: from [2603:3004:32:9a00::4074]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4aGe-0002wj-9E; Thu, 20 Feb 2020 01:04:40 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <827a4520-95ce-5264-90d9-ed730e5918e6@infradead.org>
Date:   Wed, 19 Feb 2020 17:04:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200220004825.23372-7-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2/19/20 4:48 PM, Scott Branden wrote:
> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> new file mode 100644
> index 000000000000..c75dfb89a38d
> --- /dev/null
> +++ b/drivers/misc/bcm-vk/Kconfig
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Broadcom VK device
> +#
> +config BCM_VK
> +	tristate "Support for Broadcom VK Accelerators"
> +	depends on PCI_MSI
> +	default m

Need to justify default m. Normally we don't add drivers as enabled unless
they are required for basic (boot) operation.

> +	help
> +	  Select this option to enable support for Broadcom
> +	  VK Accelerators.  VK is used for performing
> +	  specific video offload processing.  This driver enables
> +	  userspace programs to access these accelerators via /dev/bcm-vk.N
> +	  devices.
> +
> +	  If unsure, say N.
> +
> +if BCM_VK
> +
> +config BCM_VK_H2VK_VERIFY_AND_RETRY
> +	bool "Host To VK Verifiy Data and Retry"

	                 Verify

> +	help
> +	  Turn on to verify the data passed down to VK is good,
> +	  and if not, do a retry until it succeeds.

No timeout on that retry?

> +	  This is a debug/workaround on FPGA PCIe timing issues
> +	  but may be found useful for debugging other PCIe hardware issues.
> +	  Small performance loss by enabling this debug config.
> +	  For properly operating PCIe hardware no need to enable this.
> +
> +	  If unsure, say N.
> +
> +config BCM_VK_QSTATS
> +	bool "VK Queue Statistics"
> +	help
> +	  Turn on to enable Queue Statistics.
> +	  These are useful for debugging purposes.
> +	  Some performance loss by enabling this debug config.
> +	  For properly operating PCIe hardware no need to enable this.
> +
> +	  If unsure, say N.
> +
> +endif

cheers.
-- 
~Randy
