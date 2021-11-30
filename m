Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD94641E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 00:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhK3XEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 18:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhK3XEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:04:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80159C061574;
        Tue, 30 Nov 2021 15:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7s1aPT3qHD5YCR49RxSxx9XhraS/zuizMh2ONmra3+g=; b=a6j7Q0Qtys/oL3gKZPuCruyL1Y
        VwlL8cYDBwKH5FRU4FMWBN50k2BTulOcIKq7sDwiCVCBOvZTDoUYKF58EYkvQ2nIqrwcxjYieVg5i
        ML9yKmWO6IhTMAGkGqsHddvZc0JHQsxlMObhfA9eL+7BUUyyzlKmoA/84W47Mo2WMr0GLHslKsCOV
        OwfqFPgRkksEJzVbqaZHzyibcS/+8CyzkgH+W+i5mFCg57nf6hJ4um2P8TOUrfQrEq7WBhjNOS9jv
        uikMInCZlMSs9ltTZ+2y2lIm5iOR47m5MoqZg/HsYPI/vRBEIEUIxVh2pawRZ7OR5dB6RB6kIJcrJ
        sSeFmWBA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msC6C-001Wgu-SU; Tue, 30 Nov 2021 22:59:45 +0000
Message-ID: <183b6172-c04e-42d9-00c5-d760c04f0b96@infradead.org>
Date:   Tue, 30 Nov 2021 14:59:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] firmware_loader: export sysctl registration
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, tytso@mit.edu, viro@zeniv.linux.org.uk,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130164525.1478009-1-mcgrof@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211130164525.1478009-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/30/21 08:45, Luis Chamberlain wrote:
> The firmware loader fallback sysctl table is always built-in,
> but when FW_LOADER=m the build will fail. We need to export
> the sysctl registration and de-registration. Use the private
> symbol namespace so that only the firmware loader uses these
> calls.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: firmware_loader: move firmware sysctl to its own files
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/base/firmware_loader/fallback_table.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 51751c46cdcf..255823887c70 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -56,10 +56,12 @@ int register_firmware_config_sysctl(void)
>  		return -ENOMEM;
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(register_firmware_config_sysctl, FIRMWARE_LOADER_PRIVATE);
>  
>  void unregister_firmware_config_sysctl(void)
>  {
>  	unregister_sysctl_table(firmware_config_sysct_table_header);
>  	firmware_config_sysct_table_header = NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(unregister_firmware_config_sysctl, FIRMWARE_LOADER_PRIVATE);
>  #endif /* CONFIG_SYSCTL */
> 

-- 
~Randy
