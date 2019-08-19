Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFCE91C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 07:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfHSFjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 01:39:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39589 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfHSFjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:39:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so414483pln.6;
        Sun, 18 Aug 2019 22:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhdD4nGoQvU5n/1LnS+74dxquQ0QLgV1hJecRt6Zdes=;
        b=DZXIhmTLcFvTmOOgTKQM8bDOFcP8VgXfdYFgxU5CVyle2qQBZaCeU5BharcXPQPEom
         IdpPakOS9tjMEyM/28gjEMUTCbKhjpwWTPATn2oYwI8Oodvo8LE5m9K+mvZfvZJKYmYY
         9mrE4vmWLzoVYGgzA8QzOybZt0OszT6g5wJK0Qc/4Hr3HLp/YzZ/SRv1RBaz7NXCPoME
         mO5fr1LewGLaUgArpIBo56nCnge3ap7xvfHvPb4pUk/WsnnPLwrfDkH9fLvcPb01AUu9
         01NTEEa6VU4KPcw7zqy0DDw/UK5IhezV6c1jfjBvKKF7GQqcO4p9NIIwROgNKX25vbwZ
         5rQQ==
X-Gm-Message-State: APjAAAVstweEKK4Z2YZya2VvLJcnxGyQowfpL5uVZwGY0VtF5YGJa5Y4
        98nI2hDz7bmkoISJ5L25a1Y=
X-Google-Smtp-Source: APXvYqzAFtQXXW3pcv30yxt6s5lAVNCPF8br2jgsEl+Gkwxrz25ad1yh5ZHpIIPUgvJvsXA26ymIHA==
X-Received: by 2002:a17:902:1e3:: with SMTP id b90mr20264552plb.82.1566193179760;
        Sun, 18 Aug 2019 22:39:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n128sm13832271pfn.46.2019.08.18.22.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 22:39:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EA62040605; Mon, 19 Aug 2019 05:39:37 +0000 (UTC)
Date:   Mon, 19 Aug 2019 05:39:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
Message-ID: <20190819053937.GR16384@42.do-not-panic.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816000945.29810-4-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 05:09:45PM -0700, Scott Branden wrote:
> A race condition exists between _request_firmware_prepare checking
> if firmware is assigned and firmware_fallback_sysfs creating a sysfs
> entry (kernel trace below).  To avoid such condition add a mutex
> fw_lock_fallback to protect against such condition.

I am not buying this fix, and it seems sloppy. More below.

> misc test_firmware: Falling back to sysfs fallback for: nope-test-firmware.bin

So the fallback kicks in with the file that is not there.

> sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'

And we have a duplicate entry, for the *device* created to allow us to
create a file entry to allow us to copy the file. Your tests had a loop,
so there is actually a race between two entries being created while
one one failed.

> CPU: 4 PID: 2059 Comm: test_firmware-3 Not tainted 5.3.0-rc4 #1
> Hardware name: Dell Inc. OptiPlex 7010/0KRC95, BIOS A13 03/25/2013
> Call Trace:
>  dump_stack+0x67/0x90
>  sysfs_warn_dup.cold+0x17/0x24
>  sysfs_create_dir_ns+0xb3/0xd0
>  kobject_add_internal+0xa6/0x2a0
>  kobject_add+0x7e/0xb0

Note: kobject_add().

>  ? _cond_resched+0x15/0x30
>  device_add+0x121/0x670
>  firmware_fallback_sysfs+0x15c/0x3c9
>  _request_firmware+0x432/0x5a0
>  ? devres_find+0x63/0xc0
>  request_firmware_into_buf+0x63/0x80
>  test_fw_run_batch_request+0x96/0xe0
>  kthread+0xfb/0x130
>  ? reset_store+0x30/0x30
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x3a/0x50
> kobject_add_internal failed for nope-test-firmware.bin with -EEXIST, don't try to register things with the same name in the same directory.

So above it makes it even clearer, two kobjets with the same name.

> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/base/firmware_loader/main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index bf44c79beae9..ce9896e3b782 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -88,6 +88,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
>  /* fw_lock could be moved to 'struct fw_sysfs' but since it is just
>   * guarding for corner cases a global lock should be OK */
>  DEFINE_MUTEX(fw_lock);
> +DEFINE_MUTEX(fw_lock_fallback);

The reason I don't like this fix is that this mutex is named after ther
fallback interface... but...

>  
>  static struct firmware_cache fw_cache;
>  
> @@ -758,6 +759,17 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	if (!firmware_p)
>  		return -EINVAL;
>  
> +	/*
> +	 * There is a race condition between _request_firmware_prepare checking
> +	 * if firmware is assigned and firmware_fallback_sysfs creating sysfs
> +	 * entries with duplicate names.
> +	 * Yet, with this lock the firmware_test locks up with cache enabled
> +	 * and no event used during firmware test.
> +	 * This points to some very racy code I don't know how to entirely fix.
> +	 */
> +	if (opt_flags & FW_OPT_NOCACHE)
> +		mutex_lock(&fw_lock_fallback);

Whoa.. What does no-cache have anything to do with the fallback interface
other than the fact we enable this feature for the fallback interface?
We don't need to penalize non-fallback users who *also* may want to
enable the no-cache feature.

So, the fix should be within the boundaries of the creation / deletion
of the kobject, not this nocache feature. Can you please re-evaluate
this code and look for a more compartamentalized solution to the
fallback code only?

  Luis
