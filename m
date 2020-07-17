Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E573224411
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGQTRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgGQTRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:17:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E456EC0619D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:17:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so12239678wrm.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n8O46usBchtSHCfeAGHh+h7YSR1FpLP9i8w8Jhlo/5Y=;
        b=XDpuU1+Cv3dWz7jVTTP8WHIGTi6YuyjOI3T1FZiEYrnsIlj8mcFQqfDnFTKRRrzH9u
         TbgxilEMUrpQH10WRSdgftDDsNich8CEV9HlaQGZkMotTF3a63pgDPRx94nodIuu2eGI
         cWOWVG3LI4mCZv7N7Q78cSbu7w1XxUq5xTA8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n8O46usBchtSHCfeAGHh+h7YSR1FpLP9i8w8Jhlo/5Y=;
        b=dZpBMnIKVe9GQbiG1ESp1APr/Xd+3WrlbJEaZlyyipP+k0RT4oESW1RkXwXxQ90FE0
         dAFL9VvwhOYWAgku/51ryZB+GkKibt0xp2pU/Bwn6XqiuavlfUgV62VVDD+semABWTMN
         Eh85OGfmzjmkRaEsSO53wmCgl/YNcKoBFwq4FvEAHixepUlggSQ76aGA38s/p29Z/FO8
         G9e+TDIdehT4nDxQuWEWbSVWux/DfN4XeuQ2MjiSDta0o2i+ejdzcEIhPzgcfRCboYQU
         uAN7bEEhpRxEsi8GN8PLBnT5pr08/os3FBJ2HOeSA9sDhJafp/bIcP6IwkV2paCM3IKx
         VhMQ==
X-Gm-Message-State: AOAM532opmpKllSltoMN7wCWinDqj20fjn4Yy73nSGLWkfd8VIPxOmCv
        dDJ9k7tsHMfId/p2ArPDm73bPQ==
X-Google-Smtp-Source: ABdhPJwW1FFKlIY3h+hSleFLd2aPm6qM91p1On9iePncPUkHySNWgYSJZWiZVpa0Bf+tpYWTd3xKWw==
X-Received: by 2002:adf:f608:: with SMTP id t8mr11981560wrp.308.1595013431346;
        Fri, 17 Jul 2020 12:17:11 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 133sm16372350wme.5.2020.07.17.12.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:17:10 -0700 (PDT)
Subject: Re: [PATCH 00/13] Introduce partial kernel_read_file() support
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8de85fc3-9f31-fc59-abc1-29f43fb90988@broadcom.com>
Date:   Fri, 17 Jul 2020 12:17:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

Thanks for sending out.  This looks different than your other patch series.
We should get the first 5 patches accepted now though as they are
simple cleanups and fixes.  That will reduce the number of outstanding
patches in the series.

At first glance the issue with the changes after that is the existing
API assumes it has read the whole file and failed if it did not.
Now, if the file is larger than the amount requested there is no indication?

On 2020-07-17 10:42 a.m., Kees Cook wrote:
> Hi,
>
> Here's my attempt at clearing the path to partial read support in
> kernel_read_file(), which fixes a number of issues along the way. I'm
> still fighting with the firmware test suite (it doesn't seem to pass
> for me even in stock v5.7... ?) But I don't want to block Scott's work[1]
> any this week, so here's the series as it is currently.
>
> The primary difference to Scott's approach is to avoid adding a new set of
> functions and just adapt the existing APIs to deal with "offset". Also,
> the fixes for the enum are first in the series so they can be backported
> without the header file relocation.
>
> I'll keep poking at the firmware tests...
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/202007161415.10D015477@keescook/
>
> Kees Cook (12):
>    firmware_loader: EFI firmware loader must handle pre-allocated buffer
>    fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
>    fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
>    fs/kernel_read_file: Split into separate source file
>    fs/kernel_read_file: Remove redundant size argument
>    fs/kernel_read_file: Switch buffer size arg to size_t
>    fs/kernel_read_file: Add file_size output argument
>    LSM: Introduce kernel_post_load_data() hook
>    firmware_loader: Use security_post_load_data()
>    module: Call security_kernel_post_load_data()
>    LSM: Add "contents" flag to kernel_read_file hook
>    fs/kernel_file_read: Add "offset" arg for partial reads
>
> Scott Branden (1):
>    fs/kernel_read_file: Split into separate include file
>
>   drivers/base/firmware_loader/fallback.c       |   8 +-
>   .../base/firmware_loader/fallback_platform.c  |  12 +-
>   drivers/base/firmware_loader/main.c           |  13 +-
>   fs/Makefile                                   |   3 +-
>   fs/exec.c                                     | 132 +-----------
>   fs/kernel_read_file.c                         | 189 ++++++++++++++++++
>   include/linux/fs.h                            |  39 ----
>   include/linux/ima.h                           |  19 +-
>   include/linux/kernel_read_file.h              |  55 +++++
>   include/linux/lsm_hook_defs.h                 |   6 +-
>   include/linux/lsm_hooks.h                     |  12 ++
>   include/linux/security.h                      |  19 +-
>   kernel/kexec.c                                |   2 +-
>   kernel/kexec_file.c                           |  18 +-
>   kernel/module.c                               |  24 ++-
>   security/integrity/digsig.c                   |   8 +-
>   security/integrity/ima/ima_fs.c               |   9 +-
>   security/integrity/ima/ima_main.c             |  58 ++++--
>   security/integrity/ima/ima_policy.c           |   1 +
>   security/loadpin/loadpin.c                    |  17 +-
>   security/security.c                           |  26 ++-
>   security/selinux/hooks.c                      |   8 +-
>   22 files changed, 432 insertions(+), 246 deletions(-)
>   create mode 100644 fs/kernel_read_file.c
>   create mode 100644 include/linux/kernel_read_file.h
>

