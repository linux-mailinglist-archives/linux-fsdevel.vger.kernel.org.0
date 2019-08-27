Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642429EA2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfH0Ny4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 09:54:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40146 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0Ny4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:54:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so18550709ljb.7;
        Tue, 27 Aug 2019 06:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Kf3meBMH3dQOB0zq1dnP5knGHxGEskGGNRVHv4UiP8=;
        b=TpkbHDIfYaeEylgq0sgjAUsdpYob3r6v6kqMacjw4BXrSp6CG7wc0dl9LEHLesWk4s
         t0kyk2dueMjs7BWhCsmormsV5y3sNzJ/MLVKdWyNP8sBQuwUwcuIHst73B8OsSqOy9E/
         rWk7THpFSavlvEB1qZUAWzZFIrrqYh0/zO7MudkHFcVK4BJu622VJO/8z0IKRdfrtx5B
         oMRUTCTxpou4CKvIf89YtfJ1sbe2vNB8/mbvhlu8A0MkEig1vfJ3gFToc+C00mTMhQuT
         6H3JajHDOsefWM3tOwIyn7nK0/oc8f7f5yt+d6IGh4ggTYPwET1CwBOxds1cp0Zw06wD
         52IQ==
X-Gm-Message-State: APjAAAXDTiHeIKBhL1oo8W3C42ZZLtw60npH44upyR/dyS/Xz6JeA8IA
        VzddwrJOXm/HCG+JKbWiIKCwH8IowRh2TCtg3Vo=
X-Google-Smtp-Source: APXvYqwuwRUIjB3o/4c3qWijdsknjBy3Rd/MVd/pLrE6XKykRfE2nVir4Chtanumul2xY6GgJdU+rsdvDOUV9NyUax8=
X-Received: by 2002:a2e:8e87:: with SMTP id z7mr13778817ljk.211.1566914093399;
 Tue, 27 Aug 2019 06:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190822192451.5983-1-scott.branden@broadcom.com> <20190822192451.5983-6-scott.branden@broadcom.com>
In-Reply-To: <20190822192451.5983-6-scott.branden@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 15:54:36 +0200
Message-ID: <CAK8P3a0QaYFCFkFSx5yOq-E-pt3tXdgMVKQM+POQK5ADN=b8qg@mail.gmail.com>
Subject: Re: [PATCH 5/7] bcm-vk: add bcm_vk UAPI
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
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 9:25 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> Add user space api for bcm-vk driver.

> +
> +struct vk_metadata {
> +       /* struct version, always backwards compatible */
> +       __u32 version;
> +
> +       /* Version 0 fields */
> +       __u32 card_status;
> +#define VK_CARD_STATUS_FASTBOOT_READY BIT(0)
> +#define VK_CARD_STATUS_FWLOADER_READY BIT(1)
> +
> +       __u32 firmware_version;
> +       __u32 fw_status;
> +       /* End version 0 fields */
> +
> +       __u64 reserved[14];
> +       /* Total of 16*u64 for all versions */
> +};

I'd suggest getting rid of the API version fields, just leave the version 0
fields here and add a new structure + ioctl if you need other
fields

Versioning usually just adds complexity and is hard to get right.

> +struct vk_access {
> +       __u8 barno;     /* BAR number to use */
> +       __u8 type;      /* Type of access */
> +#define VK_ACCESS_READ 0
> +#define VK_ACCESS_WRITE 1
> +       __u32 len;      /* length of data */
> +       __u64 offset;   /* offset in BAR */
> +       __u32 *data;    /* where to read/write data to */
> +};

The pointer in the last member makes the structure incompatible between
32-bit and 64-bit user space. You could work around that using a __u64
member and turning that into a pointer using the u64_to_user_ptr()
macro in the driver in a portable way.

However, since this seems to be a read/write type interface, maybe
it's better to just use read/write file operations.

I also wonder if the interface should be on a higher abstraction level
here.

      Arnd
