Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A101D234F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgEMX64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 19:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbgEMX6z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 19:58:55 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9C120659;
        Wed, 13 May 2020 23:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589414335;
        bh=k7d/LyV6/crKMI22byjJd9hAviD5VxpO78pU5eT8y2k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oBxa/gfQQuQhzphTY+MmzddBFdYANvOzL69/j0LUCqoCdJAyjI7Ha50dh8igvPyiU
         ft3RTEd0N5e3O+aByRtxnNHWRgwxNyYXX9LJdlvhieNbhXmnEWJuKW5lOFbJUrRjQr
         SaRqovklhMbxBuEcXuh4wLwaV5ZRZRT7PagwZWQc=
Message-ID: <1589414332.5098.246.camel@kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
From:   Mimi Zohar <zohar@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 13 May 2020 19:58:52 -0400
In-Reply-To: <202005131630.8B1ECE0@keescook>
References: <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
         <1589396593.5098.166.camel@kernel.org>
         <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
         <1589398747.5098.178.camel@kernel.org>
         <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
         <1589404814.5098.185.camel@kernel.org>
         <20200513212847.GT11244@42.do-not-panic.com>
         <1589407924.5098.208.camel@kernel.org>
         <f8de785c-60df-3fec-c2c6-b1dd2c77db17@broadcom.com>
         <1589410843.5098.220.camel@kernel.org> <202005131630.8B1ECE0@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 16:34 -0700, Kees Cook wrote:
> On Wed, May 13, 2020 at 07:00:43PM -0400, Mimi Zohar wrote:
> > On Wed, 2020-05-13 at 15:48 -0700, Scott Branden wrote:
> > > 
> > > On 2020-05-13 3:12 p.m., Mimi Zohar wrote:
> > > > On Wed, 2020-05-13 at 21:28 +0000, Luis Chamberlain wrote:
> > > >> On Wed, May 13, 2020 at 05:20:14PM -0400, Mimi Zohar wrote:
> > > >>> On Wed, 2020-05-13 at 12:41 -0700, Scott Branden wrote:
> > > >>>> On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
> > > >>>>> On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
> > > >>>>>> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
> > > >>>>>>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
> > > >>>>>> Even if the kernel successfully verified the firmware file signature it
> > > >>>>>> would just be wasting its time.  The kernel in these use cases is not always
> > > >>>>>> trusted.  The device needs to authenticate the firmware image itself.
> > > >>>>> There are also environments where the kernel is trusted and limits the
> > > >>>>> firmware being provided to the device to one which they signed.
> > > >>>>>
> > > >>>>>>> The device firmware is being downloaded piecemeal from somewhere and
> > > >>>>>>> won't be measured?
> > > >>>>>> It doesn't need to be measured for current driver needs.
> > > >>>>> Sure the device doesn't need the kernel measuring the firmware, but
> > > >>>>> hardened environments do measure firmware.
> > > >>>>>
> > > >>>>>> If someone has such need the infrastructure could be added to the kernel
> > > >>>>>> at a later date.  Existing functionality is not broken in any way by
> > > >>>>>> this patch series.
> > > >>>>> Wow!  You're saying that your patch set takes precedence over the
> > > >>>>> existing expectations and can break them.
> > > >>>> Huh? I said existing functionality is NOT broken by this patch series.
> > > >>> Assuming a system is configured to measure and appraise firmware
> > > >>> (rules below), with this change the firmware file will not be properly
> > > >>> measured and will fail signature verification.
> > > So no existing functionality has been broken.
> > > >>>
> > > >>> Sample IMA policy rules:
> > > >>> measure func=FIRMWARE_CHECK
> > > >>> appraise func=FIRMWARE_CHECK appraise_type=imasig
> > > >> Would a pre and post lsm hook for pread do it?
> > > > IMA currently measures and verifies the firmware file signature on the
> > > > post hook.  The file is read once into a buffer.  With this change,
> > > > IMA would need to be on the pre hook, to read the entire file,
> > > > calculating the file hash and verifying the file signature.  Basically
> > > > the firmware would be read once for IMA and again for the device.
> > > The entire file may not fit into available memory to measure and 
> > > verify.  Hence the reason for a partial read.
> > 
> > Previously, IMA pre-read the file in page size chunks in order to
> > calculate the file hash.  To avoid reading the file twice, the file is
> > now read into a buffer.
> 
> Can the VFS be locked in some way and then using the partial reads would
> trigger the "read twice" mode? I.e. something like:
> 
> open
> first partial read:
> 	lock file contents (?)
> 	perform full page-at-a-time-read-and-measure
> 	rewind, read partial
> other partial reads
> final partial read
> 	unlock

The security_kernel_read_file(), the pre-hook, would need to be moved
after getting the file size, but yes that's exactly what would be done
in the pre-hook, when the current offset is 0 and the file size and
buffer size aren't the same.

Mimi
