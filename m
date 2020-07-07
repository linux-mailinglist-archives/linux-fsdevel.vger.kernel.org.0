Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94C4217BF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgGGX44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 19:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgGGX4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:56:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD07C08C5E2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 16:56:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so20784908pgq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PrB6tSwZut3YhXvmRxKyIxp+o4bcGYiCaIgYmdScaAY=;
        b=Iw4yW9ylrL0U/XpBOdhXkOV6x4pABnCzwwT15pR89LgGter+AnxnFZse85PXllDV1W
         xEAfSH5Wqr5jk1VxD1gOy5RfI+ZkQ1RbHfr4I7dSr5sm0rbQLRTJo7LWU33sCpNZpS7V
         YpMI4rJsxFOC4w3BTNfAGYT8xQf4L3bZkm2ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrB6tSwZut3YhXvmRxKyIxp+o4bcGYiCaIgYmdScaAY=;
        b=gQdrXt0ixLEkOPq2+z0DhicrMH1+net1qtC33IY7C2p2NvYTTln0bhdDknZhgQRlBj
         mkP5VCAb3HYoRffdmvzwkQ1Tp0CYSxdFZKbX56RYSBqoFya82DE2OxI69pLDlZtKFMIv
         NtvbKmlndCvDDbAJXO4iAl4wyGDKX5fbSKNhvdJv5LIej0IeBX92WBB+VCP9AriLoiPF
         yp0FHpIUWon+N+xnQDFu0znoYzNtUOOs3Ye8zU7FcP8Dnx4kbJ3rPQGpcAEwIcqa31vx
         VVPR7XjNo+orS9HErukZSf0Hp+8p+UWvnmo7Vqc0ZzcTrosd5WD2L2DsmpZ3ITwSRhQ6
         ZebQ==
X-Gm-Message-State: AOAM533BNktz1lq19NJEVYeFr7LP9gC9oFSj+uu78c1VYXenPBaht6ND
        U/CzDwdVFwMs2f7UySEIvFt2/A==
X-Google-Smtp-Source: ABdhPJxkDoJk/3SICeILCjbmCiKZisDW+o0RKxesz+r2nVdsA3hgAWUzZPUDXoKXVXdQIYQV1oSOnQ==
X-Received: by 2002:a63:3d07:: with SMTP id k7mr47093213pga.93.1594166214542;
        Tue, 07 Jul 2020 16:56:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r204sm16865354pfc.134.2020.07.07.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:56:53 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:56:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 2/9] fs: introduce kernel_pread_file* support
Message-ID: <202007071642.AA705B2A@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-3-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 04:23:02PM -0700, Scott Branden wrote:
> Add kernel_pread_file* support to kernel to allow for partial read
> of files with an offset into the file.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  fs/exec.c                        | 93 ++++++++++++++++++++++++--------
>  include/linux/kernel_read_file.h | 17 ++++++
>  2 files changed, 87 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 4ea87db5e4d5..e6a8a65f7478 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -928,10 +928,14 @@ struct file *open_exec(const char *name)
>  }
>  EXPORT_SYMBOL(open_exec);
>  
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> +		      loff_t max_size, loff_t pos,
> +		      enum kernel_read_file_id id)
> +{
> +	loff_t alloc_size;
> +	loff_t buf_pos;
> +	loff_t read_end;
> +	loff_t i_size;
>  	ssize_t bytes = 0;
>  	int ret;
>  
> @@ -951,21 +955,32 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +
> +	/* Default read to end of file */
> +	read_end = i_size;
> +
> +	/* Allow reading partial portion of file */
> +	if ((id == READING_FIRMWARE_PARTIAL_READ) &&
> +	    (i_size > (pos + max_size)))
> +		read_end = pos + max_size;

There's no need to involve "id" here. There are other signals about
what's happening (i.e. pos != 0, max_size != i_size, etc).

> +
> +	alloc_size = read_end - pos;
> +	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
>  		ret = -EFBIG;
>  		goto out;
>  	}
>  
> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> -		*buf = vmalloc(i_size);
> +	if ((id != READING_FIRMWARE_PARTIAL_READ) &&
> +	    (id != READING_FIRMWARE_PREALLOC_BUFFER))
> +		*buf = vmalloc(alloc_size);
>  	if (!*buf) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}

The id usage here was a mistake in upstream, and the series I sent is
trying to clean that up.

Greg, it seems this series is going to end up in your tree due to it
being drivers/misc? I guess I need to direct my series to Greg then, but
get LSM folks Acks.

>  
> -	pos = 0;
> -	while (pos < i_size) {
> -		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> +	buf_pos = 0;
> +	while (pos < read_end) {
> +		bytes = kernel_read(file, *buf + buf_pos, read_end - pos, &pos);
>  		if (bytes < 0) {
>  			ret = bytes;
>  			goto out_free;
> @@ -973,20 +988,23 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  
>  		if (bytes == 0)
>  			break;
> +
> +		buf_pos += bytes;
>  	}
>  
> -	if (pos != i_size) {
> +	if (pos != read_end) {
>  		ret = -EIO;
>  		goto out_free;
>  	}
>  
> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> +	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
>  	if (!ret)
>  		*size = pos;

This call cannot be inside kernel_pread_file(): any future LSMs will see
a moving window of contents, etc. It'll need to be in kernel_read_file()
proper.

>  
>  out_free:
>  	if (ret < 0) {
> -		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +		if ((id != READING_FIRMWARE_PARTIAL_READ) &&
> +		    (id != READING_FIRMWARE_PREALLOC_BUFFER)) {
>  			vfree(*buf);
>  			*buf = NULL;
>  		}
> @@ -996,10 +1014,18 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  	allow_write_access(file);
>  	return ret;
>  }
> +
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +		     loff_t max_size, enum kernel_read_file_id id)
> +{
> +	return kernel_pread_file(file, buf, size, max_size, 0, id);
> +}
>  EXPORT_SYMBOL_GPL(kernel_read_file);
>  
> -int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> -			       loff_t max_size, enum kernel_read_file_id id)
> +int kernel_pread_file_from_path(const char *path, void **buf,
> +				loff_t *size,
> +				loff_t max_size, loff_t pos,
> +				enum kernel_read_file_id id)
>  {
>  	struct file *file;
>  	int ret;
> @@ -1011,15 +1037,22 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
>  
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> +	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
>  	fput(file);
>  	return ret;
>  }
> +
> +int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> +			       loff_t max_size, enum kernel_read_file_id id)
> +{
> +	return kernel_pread_file_from_path(path, buf, size, max_size, 0, id);
> +}
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>  
> -int kernel_read_file_from_path_initns(const char *path, void **buf,
> -				      loff_t *size, loff_t max_size,
> -				      enum kernel_read_file_id id)
> +int kernel_pread_file_from_path_initns(const char *path, void **buf,
> +				       loff_t *size,
> +				       loff_t max_size, loff_t pos,
> +				       enum kernel_read_file_id id)
>  {
>  	struct file *file;
>  	struct path root;
> @@ -1037,14 +1070,22 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
>  
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> +	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
>  	fput(file);
>  	return ret;
>  }
> +
> +int kernel_read_file_from_path_initns(const char *path, void **buf,
> +				      loff_t *size, loff_t max_size,
> +				      enum kernel_read_file_id id)
> +{
> +	return kernel_pread_file_from_path_initns(path, buf, size, max_size, 0, id);
> +}
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>  
> -int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> -			     enum kernel_read_file_id id)
> +int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
> +			      loff_t max_size, loff_t pos,
> +			      enum kernel_read_file_id id)
>  {
>  	struct fd f = fdget(fd);
>  	int ret = -EBADF;
> @@ -1052,11 +1093,17 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>  	if (!f.file)
>  		goto out;
>  
> -	ret = kernel_read_file(f.file, buf, size, max_size, id);
> +	ret = kernel_pread_file(f.file, buf, size, max_size, pos, id);
>  out:
>  	fdput(f);
>  	return ret;
>  }
> +
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +			     enum kernel_read_file_id id)
> +{
> +	return kernel_pread_file_from_fd(fd, buf, size, max_size, 0, id);
> +}
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);

For each of these execution path, the mapping to LSM hooks is:

- all path must call security_kernel_read_file(file, id) before reading
  (this appears to be fine as-is in your series).

- anything doing a "full" read needs to call
  security_kernel_post_read_file() with the file and full buffer, size,
  etc (so all the kernel_read_file*() paths). I imagine instead of
  adding 3 copy/pasted versions of this, it may be possible to refactor
  the helpers into a single core "full" caller that takes struct file,
  or doing some logic in kernel_pread_file() that notices it has the
  entire file in the buffer and doing the call then.
  As an example of what I mean about doing the call, here's how I might
  imagine it for one of the paths if it took struct file:

int kernel_read_file_from_file(struct file *file, void **buf, loff_t *size,
			       loff_t max_size, enum kernel_read_file_id id)
{
	int ret;

	ret = kernel_pread_file_from_file(file, buf, size, max_size, 0, id);
	if (ret)
		return ret;
	return security_kernel_post_read_file(file, buf, *size, id);
}

>  
>  #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index 53f5ca41519a..f061ccb8d0b4 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -8,6 +8,7 @@
>  #define __kernel_read_file_id(id) \
>  	id(UNKNOWN, unknown)		\
>  	id(FIRMWARE, firmware)		\
> +	id(FIRMWARE_PARTIAL_READ, firmware)	\
>  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
>  	id(FIRMWARE_EFI_EMBEDDED, firmware)	\

And again, sorry that this was in here as a misleading example.

>  	id(MODULE, kernel-module)		\
> @@ -36,15 +37,31 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
>  	return kernel_read_file_str[id];
>  }
>  
> +int kernel_pread_file(struct file *file,
> +		      void **buf, loff_t *size, loff_t pos,
> +		      loff_t max_size,
> +		      enum kernel_read_file_id id);
>  int kernel_read_file(struct file *file,
>  		     void **buf, loff_t *size, loff_t max_size,
>  		     enum kernel_read_file_id id);
> +int kernel_pread_file_from_path(const char *path,
> +				void **buf, loff_t *size, loff_t pos,
> +				loff_t max_size,
> +				enum kernel_read_file_id id);
>  int kernel_read_file_from_path(const char *path,
>  			       void **buf, loff_t *size, loff_t max_size,
>  			       enum kernel_read_file_id id);
> +int kernel_pread_file_from_path_initns(const char *path,
> +				       void **buf, loff_t *size, loff_t pos,
> +				       loff_t max_size,
> +				       enum kernel_read_file_id id);
>  int kernel_read_file_from_path_initns(const char *path,
>  				      void **buf, loff_t *size, loff_t max_size,
>  				      enum kernel_read_file_id id);
> +int kernel_pread_file_from_fd(int fd,
> +			      void **buf, loff_t *size, loff_t pos,
> +			      loff_t max_size,
> +			      enum kernel_read_file_id id);
>  int kernel_read_file_from_fd(int fd,
>  			     void **buf, loff_t *size, loff_t max_size,
>  			     enum kernel_read_file_id id);

I remain concerned that adding these helpers will lead a poor
interaction with LSMs, but I guess I get to hold my tongue. :)

-- 
Kees Cook
