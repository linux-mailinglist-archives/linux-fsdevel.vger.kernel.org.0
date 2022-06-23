Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A488355711E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 04:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiFWCg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 22:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFWCg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:36:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AED3C722;
        Wed, 22 Jun 2022 19:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=db7NnTeCjfS9BKlQ0hulk5gOY3mV9QEguoXPLgKe2zw=; b=qaKWc0IcE5h2mxvXPnQZRK30zN
        wx/5x3BCCv1RW+DT/F+qaQExUVIZzt9lq1t5f8yhmO/Qc2smO4fvI1zOtXDJvtNLDNNK0Kx+ZfxUi
        ggZXoGIGZ08R+0+isyhtks8bLUmm6gEZQUOVB19SMxmOaHjHaHmJNt987S+pVdj7Msi3rSC2b5FJB
        E/NTG/RPjNKiqXv0VpgDjUNJ2LZcAe7ByLQt0qsQmQK8VMEOWVfTJv83DUcWoBmf5kBJwBo6iBfiO
        k4Vdz0PMWoXkc9mw67p7y+eA/kNZoUTiI+r57Yzop572GZ7qBvUq3RpgitNrPKe61BpPZl5YndSmO
        f5t0Db0A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Ci2-007XGJ-Sd; Thu, 23 Jun 2022 02:36:43 +0000
Message-ID: <b769c0f6-76a8-2e80-f68b-4ada036c789a@infradead.org>
Date:   Wed, 22 Jun 2022 19:36:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 3/3] powerpc/pseries: expose authenticated
 variables stored in LPAR PKS
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
 <20220622215648.96723-4-nayna@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220622215648.96723-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/22/22 14:56, Nayna Jain wrote:
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 6c1ca487103f..9c52095e20c4 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -152,6 +152,23 @@ config PSERIES_PLPKS
>  	  config to enable operating system interface to hypervisor to
>  	  access this space.
>  
> +config PSERIES_FWSECURITYFS_ARCH
> +	depends on FWSECURITYFS
> +	bool "Support fwsecurityfs for pseries"
> +	help
> +	  Enable fwsecuirtyfs arch specific code. This would initialize

	         fwsecurityfs                   . This initializes

> +	  the firmware security filesystem with initial platform specific
> +	  structure.
> +
> +config PSERIES_PLPKS_SECVARS
> +	depends on PSERIES_PLPKS
> +	select PSERIES_FWSECURITYFS_ARCH
> +	tristate "Support for secvars"
> +	help
> +	  This interface exposes authenticated variables stored in the LPAR
> +	  Platform KeyStore using fwsecurityfs interface.
> +	  If you are unsure how to use it, say N.

-- 
~Randy
