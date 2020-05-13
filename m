Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD481D2321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 01:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbgEMXeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 19:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732728AbgEMXeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 19:34:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140CFC05BD0B
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 16:34:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so424547plq.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9+kHGmySmNxox5wuBQoQwck1bLpTOuP5gTxm3+9miDE=;
        b=a5bkxw4lZ5KtU/7XSy6vFoZNzxoQzbwCg8Ve+eRR31EJupSDG7nd9WLXO+x/fuH+oD
         T1iajkovrL+KE9IJDAnGZnwmEOeil6jnqMj0ZttdnSHvAjbD2Xl9s8EUwYBVXUeQAo9q
         t1ZXN1sRSkY/OXB5O/18TcHvWPlpTqquHyqAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9+kHGmySmNxox5wuBQoQwck1bLpTOuP5gTxm3+9miDE=;
        b=B+TmDRiWmQ12LD5/LA8moSE/Tsp0zJeoWB4GgX93aVd2ZMPHsQY5wkBaRD6nyS2LQ3
         6VwsJR6dDML52ttCo40eFBw2spAZnjrJ6rXXxATwbbEgLwq2CkWyytntzSi8RZFFwXiU
         fubDBB/qeCT8xpXD/Jb/h/Jtjna9uc9PwpJuRXfrz2JIuBRs3/2PZXMMMBTrD2Gp3M0i
         OgkQ5l29o9C/SVE8xDdQuCbDXoGDJjCBYOdFijH0hWcf2ma3n8INu7WongqNUoMPBx0l
         448rFPPUNDbHDk065t5hap7F72uqvqs3vgOTiprRoDg6+gKE8t6H786wg6fPsG/Y2YxB
         1aHg==
X-Gm-Message-State: AOAM530qEql7mCwhaXD6HZZ0lC1Q6qO3YMjP99pTD38MhsUsRyopit6p
        jiNa/bvqMZOjxyZ1wfCz8OcUtsB0KgA=
X-Google-Smtp-Source: ABdhPJx1Ph3/b2uAHkh09Mf7p8FRkdK0oKGy1ttISPQpTjgvGcQqjdCtv4Wgy2sxJ8WWEUMPB5YOOA==
X-Received: by 2002:a17:90b:1994:: with SMTP id mv20mr863273pjb.41.1589412856445;
        Wed, 13 May 2020 16:34:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm568374pfd.108.2020.05.13.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:34:15 -0700 (PDT)
Date:   Wed, 13 May 2020 16:34:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@kernel.org>
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
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
Message-ID: <202005131630.8B1ECE0@keescook>
References: <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
 <1589396593.5098.166.camel@kernel.org>
 <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
 <1589398747.5098.178.camel@kernel.org>
 <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
 <1589404814.5098.185.camel@kernel.org>
 <20200513212847.GT11244@42.do-not-panic.com>
 <1589407924.5098.208.camel@kernel.org>
 <f8de785c-60df-3fec-c2c6-b1dd2c77db17@broadcom.com>
 <1589410843.5098.220.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589410843.5098.220.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 07:00:43PM -0400, Mimi Zohar wrote:
> On Wed, 2020-05-13 at 15:48 -0700, Scott Branden wrote:
> > 
> > On 2020-05-13 3:12 p.m., Mimi Zohar wrote:
> > > On Wed, 2020-05-13 at 21:28 +0000, Luis Chamberlain wrote:
> > >> On Wed, May 13, 2020 at 05:20:14PM -0400, Mimi Zohar wrote:
> > >>> On Wed, 2020-05-13 at 12:41 -0700, Scott Branden wrote:
> > >>>> On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
> > >>>>> On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
> > >>>>>> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
> > >>>>>>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
> > >>>>>> Even if the kernel successfully verified the firmware file signature it
> > >>>>>> would just be wasting its time.  The kernel in these use cases is not always
> > >>>>>> trusted.  The device needs to authenticate the firmware image itself.
> > >>>>> There are also environments where the kernel is trusted and limits the
> > >>>>> firmware being provided to the device to one which they signed.
> > >>>>>
> > >>>>>>> The device firmware is being downloaded piecemeal from somewhere and
> > >>>>>>> won't be measured?
> > >>>>>> It doesn't need to be measured for current driver needs.
> > >>>>> Sure the device doesn't need the kernel measuring the firmware, but
> > >>>>> hardened environments do measure firmware.
> > >>>>>
> > >>>>>> If someone has such need the infrastructure could be added to the kernel
> > >>>>>> at a later date.  Existing functionality is not broken in any way by
> > >>>>>> this patch series.
> > >>>>> Wow!  You're saying that your patch set takes precedence over the
> > >>>>> existing expectations and can break them.
> > >>>> Huh? I said existing functionality is NOT broken by this patch series.
> > >>> Assuming a system is configured to measure and appraise firmware
> > >>> (rules below), with this change the firmware file will not be properly
> > >>> measured and will fail signature verification.
> > So no existing functionality has been broken.
> > >>>
> > >>> Sample IMA policy rules:
> > >>> measure func=FIRMWARE_CHECK
> > >>> appraise func=FIRMWARE_CHECK appraise_type=imasig
> > >> Would a pre and post lsm hook for pread do it?
> > > IMA currently measures and verifies the firmware file signature on the
> > > post hook.  The file is read once into a buffer.  With this change,
> > > IMA would need to be on the pre hook, to read the entire file,
> > > calculating the file hash and verifying the file signature.  Basically
> > > the firmware would be read once for IMA and again for the device.
> > The entire file may not fit into available memory to measure and 
> > verify.  Hence the reason for a partial read.
> 
> Previously, IMA pre-read the file in page size chunks in order to
> calculate the file hash.  To avoid reading the file twice, the file is
> now read into a buffer.

Can the VFS be locked in some way and then using the partial reads would
trigger the "read twice" mode? I.e. something like:

open
first partial read:
	lock file contents (?)
	perform full page-at-a-time-read-and-measure
	rewind, read partial
other partial reads
final partial read
	unlock

-- 
Kees Cook
