Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E79EAA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfH0OPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 10:15:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34013 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0OPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:15:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so18662088ljh.1;
        Tue, 27 Aug 2019 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfeseVQWz48HAsLr5kcHWdtkdT6kJKG3U+x7h2FYyGM=;
        b=aOGBqq4Z85flFdMhhFl9AvnbOfU7QDOmEVBPnoX21w4aDGd0QjB01vrR0GhSwtmw1L
         dhb+Qa3SnEUgASCKtYNN3kRj9hV6w0R6o2tDd6/MxnXn6QZaKe/QbqKr85uzZ5w/u7bK
         KJMCJz8JASMbf8OyuOzrMXrdIRoO+Co4Pty/fBQZrYb8EhY7HXsktEUDWLh5OcirFdMh
         t01hzebLjzQVXg42WVcByA9x4z1Sb4nBlnohhoW66ooWM+JyFUzZWGpAwO3hHIj6tbok
         N5GbLjUaLhs68IOPk6ciZc3cZfMOt2EWaC7EuV7MAdcybjrP3cnmZpsdCwHT+5Z4i8+v
         8gog==
X-Gm-Message-State: APjAAAXYirbHHlrkRAL+Iyc5m62UrRLjMBQiIdVa5Q0UJ5e4JfDWNju4
        7P+bfJDedfXEGPiVKhg+rvBHofBOzIY4wxZL6Y8=
X-Google-Smtp-Source: APXvYqynbPEMJ5NJosXQEn553TI+EwJm9qEyttNHdgRx0B6Cd7hXJqH69rtOKEoglJrjQ9eC04IA7D0x4NcOdaJK7k0=
X-Received: by 2002:a2e:980d:: with SMTP id a13mr14098210ljj.145.1566915310400;
 Tue, 27 Aug 2019 07:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190822192451.5983-1-scott.branden@broadcom.com> <20190822192451.5983-7-scott.branden@broadcom.com>
In-Reply-To: <20190822192451.5983-7-scott.branden@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 16:14:54 +0200
Message-ID: <CAK8P3a1WBkmXbJx=rZMumxn7EN4bmA1AdZEgrWBVyQ3XNngU6Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] misc: bcm-vk: add Broadcom Valkyrie driver
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 9:25 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> Add Broadcom Valkyrie driver offload engine.
> This driver interfaces to the Valkyrie PCIe offload engine to perform
> should offload functions as video transcoding on multiple streams
> in parallel.  Valkyrie device is booted from files loaded using
> request_firmware_into_buf mechanism.  After booted card status is updated
> and messages can then be sent to the card.
> Such messages contain scatter gather list of addresses
> to pull data from the host to perform operations on.
>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: James Hu <james.hu@broadcom.com>

Can you explain the decision to make this is a standalone misc driver
rather than hooking into the existing framework in drivers/media?

There is an existing interface that looks like it could fit the hardware
in include/media/v4l2-mem2mem.h. Have you considered using that?

There is also support for video transcoding using GPUs in
driver/gpu/drm/, that could also be used in theory, though it sounds
like a less optimal fit.

      Arnd
