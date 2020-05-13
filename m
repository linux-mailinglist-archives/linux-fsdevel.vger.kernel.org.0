Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21761D03A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 02:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgEMAdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 20:33:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46310 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 20:33:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id p21so1116568pgm.13;
        Tue, 12 May 2020 17:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xzb2WkJ8Lckk9tDc0A+TZtzrlHs529ZZrDsPqsngzw=;
        b=YX2P28J0O7nyn1xX9qbw0d1XOhwU+lMMXeoHkiv2iaxnHcSjeULIoreNQWvpBcPl9B
         RJCKJV4lD8c7gsd5sXRnvIyqNV4RSodKQZu56jOEYQNSPUb0DL+WPaPpAKtJKdwP51oe
         E2zrsxTzKAjGpvn9AmK2d19QlJB1Eo5HafaIjjHuId/SJF5ADS0ywG7gfGKYLPixVmWG
         9ZioDPkWM3W7aqFQY4cXKe6aRdsaSZJbvPma64jQHox+1tfrgzI0zG/os6hilUOu78e0
         2xa66+qsY0zOKvUjLSfmXqR0Pj5cjBrZvK9v7K0JGt6Uos+2h+jNuuyOJFeql+FVF4bL
         lqgA==
X-Gm-Message-State: AOAM532xPUhf9US8fDcA+ZS05vGT4jsWU6nVKsLSUlVL5PPId5s5xuJl
        Zho+jTXPyrkxytazEDIvuwcBIYb5fOA=
X-Google-Smtp-Source: ABdhPJwlAws5uzZEaerOiiTD/Ey2orGLhLcJcOtB7H3UIuT4+No8XR8bjj+7uROwOawsFiQOUGXMKA==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr2747525pgq.272.1589329983938;
        Tue, 12 May 2020 17:33:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a6sm2887719pfk.159.2020.05.12.17.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:33:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id ECAAA4063E; Wed, 13 May 2020 00:33:01 +0000 (UTC)
Date:   Wed, 13 May 2020 00:33:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 2/7] firmware: add offset to request_firmware_into_buf
Message-ID: <20200513003301.GH11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508002739.19360-3-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 05:27:34PM -0700, Scott Branden wrote:
> Add offset to request_firmware_into_buf to allow for portions
> of firmware file to be read into a buffer.  Necessary where firmware
> needs to be loaded in portions from file in memory constrained systems.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/base/firmware_loader/firmware.h |  5 +++
>  drivers/base/firmware_loader/main.c     | 52 +++++++++++++++++--------
>  drivers/soc/qcom/mdt_loader.c           |  7 +++-
>  include/linux/firmware.h                |  8 +++-
>  lib/test_firmware.c                     |  4 +-
>  5 files changed, 55 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index 25836a6afc9f..1147dae01148 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -32,6 +32,8 @@
>   * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded in
>   *	the platform's main firmware. If both this fallback and the sysfs
>   *      fallback are enabled, then this fallback will be tried first.
> + * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
> + *	entire file.

See, this allows us use kdoc to document his nicely. Do that with the
kernel pread stuff.

> @@ -68,6 +71,8 @@ struct fw_priv {
>  	void *data;
>  	size_t size;
>  	size_t allocated_size;
> +	size_t offset;
> +	unsigned int flags;

But flags is a misnomer, you just do two operations, just juse an enum
here to classify the read operation.

> index 76f79913916d..4552b7bb819f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -167,7 +167,8 @@ static int fw_cache_piggyback_on_request(const char *name);
>  
>  static struct fw_priv *__allocate_fw_priv(const char *fw_name,
>  					  struct firmware_cache *fwc,
> -					  void *dbuf, size_t size)
> +					  void *dbuf, size_t size,
> +					  size_t offset, unsigned int flags)

And likewise just use an enum here too.

> @@ -210,9 +213,11 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
>  static int alloc_lookup_fw_priv(const char *fw_name,
>  				struct firmware_cache *fwc,
>  				struct fw_priv **fw_priv, void *dbuf,
> -				size_t size, enum fw_opt opt_flags)
> +				size_t size, enum fw_opt opt_flags,
> +				size_t offset)

flags? But its a single variable enum!

>  {
>  	struct fw_priv *tmp;
> +	unsigned int pread_flags;
>  
>  	spin_lock(&fwc->lock);
>  	if (!(opt_flags & FW_OPT_NOCACHE)) {
> @@ -226,7 +231,12 @@ static int alloc_lookup_fw_priv(const char *fw_name,
>  		}
>  	}
>  
> -	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
> +	if (opt_flags & FW_OPT_PARTIAL)
> +		pread_flags = KERNEL_PREAD_FLAG_PART;
> +	else
> +		pread_flags = KERNEL_PREAD_FLAG_WHOLE;
> +
> +	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, pread_flags);

One of the advantages of using an enum is that you can then use a switch
here, and the compiler will warn if you haven't handled all the cases.

>  		/* load firmware files from the mount namespace of init */
> -		rc = kernel_read_file_from_path_initns(path, &buffer,
> -						       &size, msize, id);
> +		rc = kernel_pread_file_from_path_initns(path, &buffer,
> +							&size, fw_priv->offset,
> +							msize,
> +							fw_priv->flags, id);

And here you'd just pass the kernel enum.

You get the idea, I stopped reviewing after this.

  Luis
