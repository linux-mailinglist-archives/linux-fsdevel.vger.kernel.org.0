Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349085423B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiFHEsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 00:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiFHErX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99631248035
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 18:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654650339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DYVGlTfcixWRpDZ+Xnrns02OLERH2O9N67sLNCT2XaM=;
        b=BaIWN7rF0q/HANe/gQrvFrIrdspxPxhE2OGfFS3BAu/fJXejA6kjeidkoCvBaejophPAVC
        LGHYAOYjDbrQDPZg5uzUTuuNsb/eHC5GtcdVkYkbQ0LmbNTBk/WZgRWjp+YxYoHWSJ1S/s
        /z8wc0b5NDJy7G191s7HEdAu+UID4eE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-H_xe-6JtPiCty6iROnStrQ-1; Tue, 07 Jun 2022 20:58:59 -0400
X-MC-Unique: H_xe-6JtPiCty6iROnStrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D12800124;
        Wed,  8 Jun 2022 00:58:59 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 783F6492C3B;
        Wed,  8 Jun 2022 00:58:58 +0000 (UTC)
Date:   Wed, 8 Jun 2022 08:58:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     sashal@kernel.org, ebiederm@xmission.com, rburanyi@google.com,
        akpm@linux-foundation.org, gthelen@google.com,
        viro@zeniv.linux.org.uk, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to
 ssize_t
Message-ID: <Yp/0TjxQGJJtjqAu@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527025535.3953665-2-pasha.tatashin@soleen.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> Currently, the maximum file size that is supported is 2G. This may be
> too small in some cases. For example, kexec_file_load() system call
> loads initramfs. In some netboot cases initramfs can be rather large.
> 
> Allow to use up-to ssize_t bytes. The callers still can limit the
> maximum file size via buf_size.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
>  include/linux/kernel_read_file.h | 32 +++++++++++++--------------
>  include/linux/limits.h           |  1 +
>  3 files changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index 1b07550485b9..5d826274570c 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -29,15 +29,15 @@
>   * change between calls to kernel_read_file().
>   *
>   * Returns number of bytes read (no single read will be bigger
> - * than INT_MAX), or negative on error.
> + * than SSIZE_MAX), or negative on error.
>   *
>   */
> -int kernel_read_file(struct file *file, loff_t offset, void **buf,
> -		     size_t buf_size, size_t *file_size,
> -		     enum kernel_read_file_id id)
> +ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
> +			 size_t buf_size, size_t *file_size,
> +			 enum kernel_read_file_id id)
>  {
>  	loff_t i_size, pos;
> -	size_t copied;
> +	ssize_t copied;
>  	void *allocated = NULL;
>  	bool whole_file;
>  	int ret;
> @@ -58,7 +58,7 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
>  		goto out;
>  	}
>  	/* The file is too big for sane activities. */
> -	if (i_size > INT_MAX) {
> +	if (i_size > SSIZE_MAX) {
>  		ret = -EFBIG;
>  		goto out;
>  	}
> @@ -124,12 +124,12 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file);
>  
> -int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> -			       size_t buf_size, size_t *file_size,
> -			       enum kernel_read_file_id id)
> +ssize_t kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> +				   size_t buf_size, size_t *file_size,
> +				   enum kernel_read_file_id id)
>  {
>  	struct file *file;
> -	int ret;
> +	ssize_t ret;
>  
>  	if (!path || !*path)
>  		return -EINVAL;
> @@ -144,14 +144,14 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>  
> -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> -				      void **buf, size_t buf_size,
> -				      size_t *file_size,
> -				      enum kernel_read_file_id id)
> +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> +					  void **buf, size_t buf_size,
> +					  size_t *file_size,
> +					  enum kernel_read_file_id id)
>  {
>  	struct file *file;
>  	struct path root;
> -	int ret;
> +	ssize_t ret;
>  
>  	if (!path || !*path)
>  		return -EINVAL;
> @@ -171,12 +171,12 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>  
> -int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> -			     size_t buf_size, size_t *file_size,
> -			     enum kernel_read_file_id id)
> +ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> +				 size_t buf_size, size_t *file_size,
> +				 enum kernel_read_file_id id)
>  {
>  	struct fd f = fdget(fd);
> -	int ret = -EBADF;
> +	ssize_t ret = -EBADF;
>  
>  	if (!f.file || !(f.file->f_mode & FMODE_READ))
>  		goto out;
> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index 575ffa1031d3..90451e2e12bd 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -35,21 +35,21 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
>  	return kernel_read_file_str[id];
>  }
>  
> -int kernel_read_file(struct file *file, loff_t offset,
> -		     void **buf, size_t buf_size,
> -		     size_t *file_size,
> -		     enum kernel_read_file_id id);
> -int kernel_read_file_from_path(const char *path, loff_t offset,
> -			       void **buf, size_t buf_size,
> -			       size_t *file_size,
> -			       enum kernel_read_file_id id);
> -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> -				      void **buf, size_t buf_size,
> -				      size_t *file_size,
> -				      enum kernel_read_file_id id);
> -int kernel_read_file_from_fd(int fd, loff_t offset,
> -			     void **buf, size_t buf_size,
> -			     size_t *file_size,
> -			     enum kernel_read_file_id id);
> +ssize_t kernel_read_file(struct file *file, loff_t offset,
> +			 void **buf, size_t buf_size,
> +			 size_t *file_size,
> +			 enum kernel_read_file_id id);
> +ssize_t kernel_read_file_from_path(const char *path, loff_t offset,
> +				   void **buf, size_t buf_size,
> +				   size_t *file_size,
> +				   enum kernel_read_file_id id);
> +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> +					  void **buf, size_t buf_size,
> +					  size_t *file_size,
> +					  enum kernel_read_file_id id);
> +ssize_t kernel_read_file_from_fd(int fd, loff_t offset,
> +				 void **buf, size_t buf_size,
> +				 size_t *file_size,
> +				 enum kernel_read_file_id id);
>  
>  #endif /* _LINUX_KERNEL_READ_FILE_H */
> diff --git a/include/linux/limits.h b/include/linux/limits.h
> index b568b9c30bbf..f6bcc9369010 100644
> --- a/include/linux/limits.h
> +++ b/include/linux/limits.h
> @@ -7,6 +7,7 @@
>  #include <vdso/limits.h>
>  
>  #define SIZE_MAX	(~(size_t)0)
> +#define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
>  #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
>  
>  #define U8_MAX		((u8)~0U)
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 

