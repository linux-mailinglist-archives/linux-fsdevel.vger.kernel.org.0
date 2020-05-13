Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF01D228E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgEMXAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 19:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbgEMXAr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 19:00:47 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5FF2053B;
        Wed, 13 May 2020 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589410846;
        bh=VVjNDeeIgYoZFS50soF+P5zbE1stcrvByt0YiN6Be34=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iyf3QafJgjWbHnErgMyhd1vfA3wniNq2U4Qt3zp+q7cWJuqp24NxT1b5N/pMCeR+L
         GQmpCyucvUhwMdZbUsIxGAp+8ttCTKSWpqtwxvb9jVPWwDOTg7bBg51Do/syJkRlOW
         cb+Iv/JK3W8I9m+N+N9VhcffQLDEuI4BuckjWZq8=
Message-ID: <1589410843.5098.220.camel@kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
From:   Mimi Zohar <zohar@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>
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
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 13 May 2020 19:00:43 -0400
In-Reply-To: <f8de785c-60df-3fec-c2c6-b1dd2c77db17@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
         <20200508002739.19360-2-scott.branden@broadcom.com>
         <1589395153.5098.158.camel@kernel.org>
         <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
         <1589396593.5098.166.camel@kernel.org>
         <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
         <1589398747.5098.178.camel@kernel.org>
         <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
         <1589404814.5098.185.camel@kernel.org>
         <20200513212847.GT11244@42.do-not-panic.com>
         <1589407924.5098.208.camel@kernel.org>
         <f8de785c-60df-3fec-c2c6-b1dd2c77db17@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 15:48 -0700, Scott Branden wrote:
> 
> On 2020-05-13 3:12 p.m., Mimi Zohar wrote:
> > On Wed, 2020-05-13 at 21:28 +0000, Luis Chamberlain wrote:
> >> On Wed, May 13, 2020 at 05:20:14PM -0400, Mimi Zohar wrote:
> >>> On Wed, 2020-05-13 at 12:41 -0700, Scott Branden wrote:
> >>>> On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
> >>>>> On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
> >>>>>> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
> >>>>>>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
> >>>>>> Even if the kernel successfully verified the firmware file signature it
> >>>>>> would just be wasting its time.  The kernel in these use cases is not always
> >>>>>> trusted.  The device needs to authenticate the firmware image itself.
> >>>>> There are also environments where the kernel is trusted and limits the
> >>>>> firmware being provided to the device to one which they signed.
> >>>>>
> >>>>>>> The device firmware is being downloaded piecemeal from somewhere and
> >>>>>>> won't be measured?
> >>>>>> It doesn't need to be measured for current driver needs.
> >>>>> Sure the device doesn't need the kernel measuring the firmware, but
> >>>>> hardened environments do measure firmware.
> >>>>>
> >>>>>> If someone has such need the infrastructure could be added to the kernel
> >>>>>> at a later date.  Existing functionality is not broken in any way by
> >>>>>> this patch series.
> >>>>> Wow!  You're saying that your patch set takes precedence over the
> >>>>> existing expectations and can break them.
> >>>> Huh? I said existing functionality is NOT broken by this patch series.
> >>> Assuming a system is configured to measure and appraise firmware
> >>> (rules below), with this change the firmware file will not be properly
> >>> measured and will fail signature verification.
> So no existing functionality has been broken.
> >>>
> >>> Sample IMA policy rules:
> >>> measure func=FIRMWARE_CHECK
> >>> appraise func=FIRMWARE_CHECK appraise_type=imasig
> >> Would a pre and post lsm hook for pread do it?
> > IMA currently measures and verifies the firmware file signature on the
> > post hook.  The file is read once into a buffer.  With this change,
> > IMA would need to be on the pre hook, to read the entire file,
> > calculating the file hash and verifying the file signature.  Basically
> > the firmware would be read once for IMA and again for the device.
> The entire file may not fit into available memory to measure and 
> verify.  Hence the reason for a partial read.

Previously, IMA pre-read the file in page size chunks in order to
calculate the file hash.  To avoid reading the file twice, the file is
now read into a buffer.

> 
> Is there some way we could add a flag when calling the 
> request_firmware_into_buf to indicate it is ok that the data requested 
> does not need to be measured?

The decision as to what needs to be measured is a policy decision left
up to the system owner, which they express by loading an IMA policy.

Mimi
