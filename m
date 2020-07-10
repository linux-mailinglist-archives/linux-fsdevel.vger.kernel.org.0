Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D821BEE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 23:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGJVAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgGJVAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:00:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC03C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 14:00:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so3045988pfu.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cyPZ2F8Elm/X30AvLL1oEN+KGMJ5jtRTB8rf0GQJuQU=;
        b=CSG6ET/DEoTdyvRO4iN3bYezY58ajzJ63SpVhvOqXxT0zPMKr+VjjZhxRiQvdQVTcK
         pP5iJk8t1/K01jHv8rehu+9M45OI1F12or/xjemjXMkwwEAD1idXHk5ol+2C1yDoi44t
         u1Sjhfh5SGd5lW408UKk6ZZDogLt9jqa//FtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cyPZ2F8Elm/X30AvLL1oEN+KGMJ5jtRTB8rf0GQJuQU=;
        b=fFsrpP4ehfmcB5D0upclgRgYyOCQdPhez1lpe6+qNYCsjupP8xz2SKGXSYI9+jtyMO
         I2vD6vygEEG4RxFTCrM/zUGoi0f4jCRwdIspIwLL8GPV++2rpUd1iXOrKYrQJOb5lu4i
         hiBL5DyPw7PIKY5a9Wxz+Dwwtdx/bEeYMMMw2wBosO1Zet2QyneE3QtiI4wwEAoYcQ6x
         4k3IcmZAMzk9/HR7McRtLvbIHGGVL8Yy6wvRIpZQmnu/ynrL9WuNnP7vMCee8SpOJ80A
         3HAiD1yTCEyFWumLhVkbZE64RUZqADyNt3RfhjSekDVRN6Lvk7yQZRcj+K6BCdOjOytP
         +3mg==
X-Gm-Message-State: AOAM530Sy5MzHukJy+QycBySevGIlaaRGR+yB2tqE7EJvA6waRnmrRkx
        9G2lLmsd5CteNLMjN9Hvt3IaLQ==
X-Google-Smtp-Source: ABdhPJx9N2FJKG78sh217VkA3T8P4l6LMqcB/e6Ykg2KomvFC7EXnwO8oLP7kDriJaQKbqt4vg18jQ==
X-Received: by 2002:a63:3c2:: with SMTP id 185mr61414088pgd.46.1594414845795;
        Fri, 10 Jul 2020 14:00:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e28sm6852810pfm.177.2020.07.10.14.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 14:00:44 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
Date:   Fri, 10 Jul 2020 14:00:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707081926.3688096-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

This patch fails during booting of my system - see below.

On 2020-07-07 1:19 a.m., Kees Cook wrote:
> FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
> that are interested in filtering between types of things. The "how"
> should be an internal detail made uninteresting to the LSMs.
>
> Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
> Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
> Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/base/firmware_loader/main.c | 5 ++---
>   fs/exec.c                           | 7 ++++---
>   include/linux/fs.h                  | 2 +-
>   security/integrity/ima/ima_main.c   | 6 ++----
>   4 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index ca871b13524e..c2f57cedcd6f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -465,14 +465,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   	int i, len;
>   	int rc = -ENOENT;
>   	char *path;
> -	enum kernel_read_file_id id = READING_FIRMWARE;
>   	size_t msize = INT_MAX;
>   	void *buffer = NULL;
>   
>   	/* Already populated data member means we're loading into a buffer */
>   	if (!decompress && fw_priv->data) {
>   		buffer = fw_priv->data;
> -		id = READING_FIRMWARE_PREALLOC_BUFFER;
>   		msize = fw_priv->allocated_size;
>   	}
>   
> @@ -496,7 +494,8 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   
>   		/* load firmware files from the mount namespace of init */
>   		rc = kernel_read_file_from_path_initns(path, &buffer,
> -						       &size, msize, id);
> +						       &size, msize,
> +						       READING_FIRMWARE);
>   		if (rc) {
>   			if (rc != -ENOENT)
>   				dev_warn(device, "loading %s failed with error %d\n",
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..2bf549757ce7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -927,6 +927,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   {
>   	loff_t i_size, pos;
>   	ssize_t bytes = 0;
> +	void *allocated = NULL;
>   	int ret;
>   
>   	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   		goto out;
>   	}
>   
> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> -		*buf = vmalloc(i_size);
> +	if (!*buf)
The assumption that *buf is always NULL when id != 
READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
I get unhandled page faults due to this change on boot.
> +		*buf = allocated = vmalloc(i_size);
>   	if (!*buf) {
>   		ret = -ENOMEM;
>   		goto out;
> @@ -980,7 +981,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   
>   out_free:
>   	if (ret < 0) {
> -		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +		if (allocated) {
>   			vfree(*buf);
>   			*buf = NULL;
>   		}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..95fc775ed937 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
>   #endif
>   extern int do_pipe_flags(int *, int);
>   
> +/* This is a list of *what* is being read, not *how*. */
>   #define __kernel_read_file_id(id) \
>   	id(UNKNOWN, unknown)		\
>   	id(FIRMWARE, firmware)		\
> -	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
>   	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
>   	id(MODULE, kernel-module)		\
>   	id(KEXEC_IMAGE, kexec-image)		\
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c1583d98c5e5..f80ee4ce4669 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -611,19 +611,17 @@ void ima_post_path_mknod(struct dentry *dentry)
>   int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>   {
>   	/*
> -	 * READING_FIRMWARE_PREALLOC_BUFFER
> -	 *
>   	 * Do devices using pre-allocated memory run the risk of the
>   	 * firmware being accessible to the device prior to the completion
>   	 * of IMA's signature verification any more than when using two
> -	 * buffers?
> +	 * buffers? It may be desirable to include the buffer address
> +	 * in this API and walk all the dma_map_single() mappings to check.
>   	 */
>   	return 0;
>   }
>   
>   const int read_idmap[READING_MAX_ID] = {
>   	[READING_FIRMWARE] = FIRMWARE_CHECK,
> -	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
>   	[READING_MODULE] = MODULE_CHECK,
>   	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
>   	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,

