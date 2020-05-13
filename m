Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051B21D1DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbgEMSjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389392AbgEMSjQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:39:16 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F77205CB;
        Wed, 13 May 2020 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589395156;
        bh=Y72i32UeQj+BsN6BKrnODAZOyq4SZCE3vWjHFMJMOD4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TP2TVJqWDchujAXs3H+unY5RWOz7Ssm4Qu5ScHyxOZ24eRyGNg3WN/x4DcUVwDm/m
         hEc4/xWzV4YyI4bdRua4fnknB3rz9+nyzRGnNqHGC6NKmeq8r+3HqLzYRfjceAUxXt
         5XequixI4+crdC+u0oFCs+Q3fz7YnIBnGQQYf36A=
Message-ID: <1589395153.5098.158.camel@kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
From:   Mimi Zohar <zohar@kernel.org>
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
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 13 May 2020 14:39:13 -0400
In-Reply-To: <20200508002739.19360-2-scott.branden@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
         <20200508002739.19360-2-scott.branden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc'ing linux-security-module, linux-integrity]

On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
> Add kernel_pread_file* support to kernel to allow for partial read
> of files with an offset into the file.  Existing kernel_read_file
> functions call new kernel_pread_file functions with offset=0 and
> flags=KERNEL_PREAD_FLAG_WHOLE.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---

<snip>

> @@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
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

Prior to the patch set that introduced this security hook, firmware
would be read twice, once for measuring/appraising the firmware and
again reading the file contents into memory.  Partial reads will break
both IMA's measuring the file and appraising the file signatures.

Mimi
