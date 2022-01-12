Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6548BE9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 07:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351006AbiALGhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 01:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiALGhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:37:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323EC06173F;
        Tue, 11 Jan 2022 22:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YqoElJ4gLoFxpMmqTr6DXyFLLJ3IMJmaBEiGkV4Xy7k=; b=TQAu79R/g92s8CNB5s5e4alPpz
        m6gDq1emVz6gWBhx0RaZEJ4Fz1kXkIISiu3CC+JtDtXJ0qQ06SzIuCQQFSdQ2PHtzNfJY3POpNc9L
        OpzfND/mvZpH88V6kSs5kGaBNUoUT2EUv0QIUmlQ9NSRCtv7ybw5WK1JXGSpdv+zsGSSv7X2qIpO1
        vF8OBLJTbhq4YEcoW9hG5VA/SZXmmfuh4pErh12cHzyDc3x3H8LW9PYaydJrQv/ZOh7JxSXzgj/2j
        6e3EYPH2kVlTVxDpkncsaN6Wgb310mWJpZInMmHDMF7eQcMYvCut6LBmwjWF+T9jJIX8GQg5syyVn
        TN+vvm5A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7XG1-000kZb-1C; Wed, 12 Jan 2022 06:37:17 +0000
Message-ID: <3e721c69-afa9-6634-2e52-e9a9c2a89372@infradead.org>
Date:   Tue, 11 Jan 2022 22:37:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] firmware_loader: simplfy builtin or module check
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        bp@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
References: <20220112023416.215644-1-mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220112023416.215644-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/11/22 18:34, Luis Chamberlain wrote:
> The existing check is outdated and confuses developers. Use the
> already existing IS_ENABLED() defined on kconfig.h which makes
> the intention much clearer.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/firmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index 3b057dfc8284..fa3493dbe84a 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
>  }
>  #endif
>  
> -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))

The "defined(MODULE)" part wasn't needed here. :)

> +#if IS_ENABLED(CONFIG_FW_LOADER)
>  int request_firmware(const struct firmware **fw, const char *name,
>  		     struct device *device);
>  int firmware_request_nowarn(const struct firmware **fw, const char *name,

-- 
~Randy
