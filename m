Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0362848C82F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355126AbiALQW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 11:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbiALQWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:22:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C54C06173F;
        Wed, 12 Jan 2022 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=73ISc36zHOBbEPIhT2sXi6cBIDsEirS073hxwaFHAkc=; b=Gm6sjutaovbsmQFVS4tBvsnKqR
        klDEQUdaJ6DZADSOFORP17pQvvGEMWoxOCyEVojQcTlTy6kvEnAngUEzvibTR+9DMV9X6OK62Nmxt
        JgHaj3CX7PdXieVCE8GDYvMiUHjm6RTdLbHcOFxSsflS3dqM6wdckF8c+cEvbD4MXnwXwCQgrMgy4
        9AuvHGGUNivKYA0KOPwC6d4aGWu52WQnKxQ/Cd8bGeM5SMlEe0PsLy0f/uRsZ93VfDdGZyw+IBpME
        y4uCLrMcba/hmWMKXHfeoyXP/Zj0eSSPiyruXjKvIPxJ4i9vShbdvK3teHdoBDwjBLucKuXKA5lzU
        79xtOZYw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7gOC-000pSp-Db; Wed, 12 Jan 2022 16:22:20 +0000
Message-ID: <0ccb377d-0073-9e3b-758d-441747002f6f@infradead.org>
Date:   Wed, 12 Jan 2022 08:22:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] firmware_loader: simplfy builtin or module check
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        bp@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220112160053.723795-1-mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220112160053.723795-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/12/22 08:00, Luis Chamberlain wrote:
> The existing check is outdated and confuses developers. Use the
> already existing IS_REACHABLE() defined on kconfig.h which makes
> the intention much clearer.

Yes.

> Reported-by: Borislav Petkov <bp@alien8.de>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Ackd-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/firmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index 3b057dfc8284..ec2ccfebef65 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
>  }
>  #endif
>  
> -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
> +#if IS_REACHABLE(CONFIG_FW_LOADER)
>  int request_firmware(const struct firmware **fw, const char *name,
>  		     struct device *device);
>  int firmware_request_nowarn(const struct firmware **fw, const char *name,

-- 
~Randy
