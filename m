Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855701D210B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 23:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgEMV2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 17:28:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50457 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgEMV2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 17:28:50 -0400
Received: by mail-pj1-f65.google.com with SMTP id t9so11666936pjw.0;
        Wed, 13 May 2020 14:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jFpZxJjBWza/kWR3tD171A9RdRcfWTU4Z4g63bnqZJQ=;
        b=MXCkU6xI6IpcuACtIHMntxwRWcX5rt9K4YNzkCn+FF6wXtHQSwhfb84wUHf8iSNe4J
         +KmNJgVPnwCnIdC9PujSz50jeePyRF4FfjbkCbtU9s3Ph+OzvS5q1nEQMSu10koDvjjC
         bU3B53dxr9P/pF856iTKjhEyRi7j5BeWoSVks68BEDRCUfQ+zNs2zQwygxZ27dilh+L1
         iutpZRFnjZTHs5PIwGUzeBdUZMjB9YRMrGlFeFFalyorWVRym2bFqM847OOjaEkF35/u
         14h7gaxzyBEp0VCpdz8ZGdoQ4plJJzosX4wo5j+SzydlgtOXz1v+MzPDDDM1Bq3VUBrH
         fTDA==
X-Gm-Message-State: AGi0Pua5Q5h8OqRvZ/Lnh2+pXKFC/ecP3QSamFmB54DeI5khulfXSr64
        byHbXx66Z7hapTqZV3ADv0N7sh449Mlmlg==
X-Google-Smtp-Source: APiQypIK+uC5UrzbKxzZc1CCBNVsrdbUnp3vZEUQzYdaSLvxgjqSKS3rrrSs5sXQv9l3ptXF/JHruw==
X-Received: by 2002:a17:90a:9311:: with SMTP id p17mr36891312pjo.145.1589405329840;
        Wed, 13 May 2020 14:28:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 82sm414078pfv.214.2020.05.13.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:28:48 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D5FDC4063E; Wed, 13 May 2020 21:28:47 +0000 (UTC)
Date:   Wed, 13 May 2020 21:28:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
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
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
Message-ID: <20200513212847.GT11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <1589395153.5098.158.camel@kernel.org>
 <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
 <1589396593.5098.166.camel@kernel.org>
 <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
 <1589398747.5098.178.camel@kernel.org>
 <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
 <1589404814.5098.185.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589404814.5098.185.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 05:20:14PM -0400, Mimi Zohar wrote:
> On Wed, 2020-05-13 at 12:41 -0700, Scott Branden wrote:
> > 
> > On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
> > > On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
> > >> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
> > >>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
> > >> Even if the kernel successfully verified the firmware file signature it
> > >> would just be wasting its time.  The kernel in these use cases is not always
> > >> trusted.  The device needs to authenticate the firmware image itself.
> > > There are also environments where the kernel is trusted and limits the
> > > firmware being provided to the device to one which they signed.
> > >
> > >>> The device firmware is being downloaded piecemeal from somewhere and
> > >>> won't be measured?
> > >> It doesn't need to be measured for current driver needs.
> > > Sure the device doesn't need the kernel measuring the firmware, but
> > > hardened environments do measure firmware.
> > >
> > >> If someone has such need the infrastructure could be added to the kernel
> > >> at a later date.  Existing functionality is not broken in any way by
> > >> this patch series.
> > > Wow!  You're saying that your patch set takes precedence over the
> > > existing expectations and can break them.
> > Huh? I said existing functionality is NOT broken by this patch series.
> 
> Assuming a system is configured to measure and appraise firmware
> (rules below), with this change the firmware file will not be properly
> measured and will fail signature verification.
> 
> Sample IMA policy rules:
> measure func=FIRMWARE_CHECK
> appraise func=FIRMWARE_CHECK appraise_type=imasig

Would a pre and post lsm hook for pread do it?

  Luis
