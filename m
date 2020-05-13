Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0701D1E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgEMTDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390021AbgEMTDR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:03:17 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E31F20671;
        Wed, 13 May 2020 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589396597;
        bh=JI6Bcx1e5I0b//i3CRdT98HUPH8i1BeSBewHUjyc5Gc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=z59eA5eRAiyCiuxUQzprR/t+ePsfTbHqMebUvWR9hw+6ql5W3gWarFW8b+usW31Wk
         9ViZb7sqp8IyDK/8aHlqMQSKcDNHrtP5NGhtQU1iYj/UDBdR+PyEtkVFhZcEqYiJ5D
         d1pMsiBjZ5JNPWirsmOYIKSiy+7o2LmuHO9bVfCs=
Message-ID: <1589396593.5098.166.camel@kernel.org>
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
Date:   Wed, 13 May 2020 15:03:13 -0400
In-Reply-To: <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
         <20200508002739.19360-2-scott.branden@broadcom.com>
         <1589395153.5098.158.camel@kernel.org>
         <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
> Hi Mimi,
> 
> On 2020-05-13 11:39 a.m., Mimi Zohar wrote:
> > [Cc'ing linux-security-module, linux-integrity]
> >
> > On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
> >> Add kernel_pread_file* support to kernel to allow for partial read
> >> of files with an offset into the file.  Existing kernel_read_file
> >> functions call new kernel_pread_file functions with offset=0 and
> >> flags=KERNEL_PREAD_FLAG_WHOLE.
> >>
> >> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> >> ---
> > <snip>
> >
> >> @@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> The checkpatch shows this as kernel_read_file when it is actually the 
> new function kernel_pread_file.
> Please see the call to kernel_pread_file from kernel_read_file in the 
> complete patch rather this snippet.
> >>   
> >>   		if (bytes == 0)
> >>   			break;
> >> +
> >> +		buf_pos += bytes;
> >>   	}
> >>   
> >> -	if (pos != i_size) {
> >> +	if (pos != read_end) {
> >>   		ret = -EIO;
> >>   		goto out_free;
> >>   	}
> >>   
> >> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> >> +	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
> >>   	if (!ret)
> >>   		*size = pos;
> > Prior to the patch set that introduced this security hook, firmware
> > would be read twice, once for measuring/appraising the firmware and
> > again reading the file contents into memory.  Partial reads will break
> > both IMA's measuring the file and appraising the file signatures.
> The partial file read support is needed for request_firmware_into_buf 
> from drivers.  The EXPORT_SYMBOL_GPL is being removed so that
> there can be no abuse of the partial file read support.  Such file 
> integrity checks are not needed for this use case.  The partial file 
> (firmware image) is actually downloaded in portions and verified on the 
> device it is loaded to.

It's all fine that the device will verify the firmware, but shouldn't
the kernel be able to also verify the firmware file signature it is
providing to the device, before providing it?

The device firmware is being downloaded piecemeal from somewhere and
won't be measured?

Mimi
