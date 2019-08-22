Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0031B9A074
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbfHVTrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:47:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41013 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHVTrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:47:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so4037368pls.8;
        Thu, 22 Aug 2019 12:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7farA7jorlmfZ2e+AMW8oiTvvYc+aUzfxfRcuDpHnk=;
        b=XO4/rwGLYk9SBYN8k7GRXHDJphUJmcRBvDWG44PY0QNg4zarCGqP8SQnHDyXKGZ3+M
         doJ1GLX4b3OrVB/XVGKbBKAjw5QZN7Y/sf9EyO12Dx/Md0Zem8PiQ510+QghLiapF353
         NEjs8KjS6x7LFgqS9j37zXpDdEdbVWk4xzJgyl4plClMJ9JwBsXatMrkIHtzzdkKvWep
         DszRlTYo3xdTOOSkx1w5rJA8hd1o6ANEg3m9L9lQf+LkH7ELC2ZWziLlC14NPXxkFRw+
         Q+rgwbzLCdzpTWNDnNdn/gF8027ea0R43zKbSC7gTabiPEJAqpRoIrAM/XF8LDxM3ns5
         bYOA==
X-Gm-Message-State: APjAAAXsYlBkxja3KFMZjogKk3Gd6UmmI8qGhGRRxVHu0V4uY91luxQ1
        AIyevmmzEYb07svMXGkpUYI=
X-Google-Smtp-Source: APXvYqx6e1XLcwxb1JcJfBbBHwrao8k3VyUgyeVUu0YdIROLSdrc1+tR5DYnDeiqbeePBddV80b7dA==
X-Received: by 2002:a17:902:5a04:: with SMTP id q4mr543629pli.280.1566503234605;
        Thu, 22 Aug 2019 12:47:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s4sm324360pjp.15.2019.08.22.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:47:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 92076403DC; Thu, 22 Aug 2019 19:47:12 +0000 (UTC)
Date:   Thu, 22 Aug 2019 19:47:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
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
        mcgrof@kernel.org
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
Message-ID: <20190822194712.GG16384@42.do-not-panic.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822192451.5983-3-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:24:46PM -0700, Scott Branden wrote:
> @@ -923,16 +936,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
>   */
>  int
>  request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
> -			  struct device *device, void *buf, size_t size)
> +			  struct device *device, void *buf, size_t size,
> +			  size_t offset, unsigned int pread_flags)

This implies you having to change the other callers, and while currently
our list of drivers is small, following the history of the firmware API
and the long history of debate of *how* we should evolve its API, its
preferred we add yet another new caller for this functionality. So
please add a new caller, and use EXPORT_SYMBOL_GPL().

And while at it, pleaase use firmware_request_*() as the prefix, as we
have want to use that as the instilled prefix. We have yet to complete
the rename of the others older callers but its just a matter of time.

So something like: firmware_request_into_buf_offset()

And thanks for adding a test case!

  Luis
