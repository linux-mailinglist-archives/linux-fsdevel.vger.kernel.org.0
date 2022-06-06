Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018B53DFDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 04:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbiFFC4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349135AbiFFC4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06ABA4F9F8
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jun 2022 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654484194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEXtX0sGH9JESHp2vh7ZVWLUxp9Rfq4NGJnnAwZRSPw=;
        b=NFrq/sk/ZrTOoYDKpdVgwc0M7btHjl/Ts0a82HoBc085bnQHBU5HBJClNJBC8HudQs4JUO
        gACAO2REzi16+8bjoZhdJf6MLEjRqOc/eaDFapa59FtfyQkHpmq5ac6dzNIJAplQGmcs1P
        qVlH5plfH2sRxKWsbPS/rUcysazRJSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-_RCa0zPqOy6XrOVyXq6ZBA-1; Sun, 05 Jun 2022 22:56:31 -0400
X-MC-Unique: _RCa0zPqOy6XrOVyXq6ZBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DF6E801228;
        Mon,  6 Jun 2022 02:56:30 +0000 (UTC)
Received: from localhost (ovpn-12-209.pek2.redhat.com [10.72.12.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EBCC1121314;
        Mon,  6 Jun 2022 02:56:28 +0000 (UTC)
Date:   Mon, 6 Jun 2022 10:56:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     sashal@kernel.org, ebiederm@xmission.com, rburanyi@google.com,
        gthelen@google.com, viro@zeniv.linux.org.uk,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
Message-ID: <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527025535.3953665-3-pasha.tatashin@soleen.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> In some case initrd can be large. For example, it could be a netboot
> image loaded by u-root, that is kexec'ing into it.
> 
> The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> not very obvious because it is hidden behind a generic INT_MAX macro.
> 
> Theoretically, we could make it LONG_MAX, but it is safer to keep it
> sane, and just increase it to 4G.

Do we need to care about 32bit system where initramfs could be larger
than 2G? On 32bit system, SSIZE_MAX is still 2G, right?

Another concern is if 2G is enough. If we can foresee it might need be
enlarged again in a near future, LONG_MAX certainly is not a good
value, but a little bigger multiple of 2G can be better?

> 
> Increase the size to 4G, and make it obvious by having a new macro
> that specifies the maximum file size supported by kexec_file_load()
> syscall: KEXEC_FILE_SIZE_MAX.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec_file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..f00cf70d82b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -31,6 +31,9 @@
>  
>  static int kexec_calculate_store_digests(struct kimage *image);
>  
> +/* Maximum size in bytes for kernel/initrd files. */
> +#define KEXEC_FILE_SIZE_MAX	min_t(s64, 4LL << 30, SSIZE_MAX)
> +
>  /*
>   * Currently this is the only default function that is exported as some
>   * architectures need it to do additional handlings.
> @@ -223,11 +226,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			     const char __user *cmdline_ptr,
>  			     unsigned long cmdline_len, unsigned flags)
>  {
> -	int ret;
> +	ssize_t ret;
>  	void *ldata;
>  
>  	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
> -				       INT_MAX, NULL, READING_KEXEC_IMAGE);
> +				       KEXEC_FILE_SIZE_MAX, NULL,
> +				       READING_KEXEC_IMAGE);
>  	if (ret < 0)
>  		return ret;
>  	image->kernel_buf_len = ret;
> @@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
> -					       INT_MAX, NULL,
> +					       KEXEC_FILE_SIZE_MAX, NULL,
>  					       READING_KEXEC_INITRAMFS);
>  		if (ret < 0)
>  			goto out;
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 

