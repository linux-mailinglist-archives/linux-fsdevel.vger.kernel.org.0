Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55299218569
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGHLB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:01:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24413 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728579AbgGHLB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594206115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5NESMLlssU1+fU+MzHpdMP4ATVfk6Mh7mmKV6aiRHE=;
        b=YS/Nf+ldhQ6NhSsRWzRqzoakNyW4t/dL1YJlj8oBOLXE2ICG8Ob3suSLBmV0foq/wm36Ap
        72IKAf1nV0FVsf//3Xl374HcKekFSUOGmcy43OJ91ucFvRykWgnx03NVuTaDd45ShYPEZz
        I27lDeKIZo4q7+PvRui+o7oCGcR/97w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-hKktApQNOnyH42sefk-tdg-1; Wed, 08 Jul 2020 07:01:54 -0400
X-MC-Unique: hKktApQNOnyH42sefk-tdg-1
Received: by mail-ed1-f72.google.com with SMTP id c25so58499266edr.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5NESMLlssU1+fU+MzHpdMP4ATVfk6Mh7mmKV6aiRHE=;
        b=AaEV77uHWfQEmUpOx+SBdsX0nvblI/+/PT1fFE8Qydx1cdw8PngsmIKJWNzt/g65/4
         HHx2OqA+1RSaACoB0nkd7Hg/CBVGYCgSbah4U2DBORZhxEEaoxpSxnP88wx6kHHNJkaO
         xbCHYFh/VbtXVgADOr11UyOqZzp6e1IB7yo8LezlmVy/91GSQNNlVVyXbm5v2lPxMV/U
         TAVd40vx/Rc000fqyxoDwiyu65pTjSwW6s+x+qev8cnABJUf8Mb6Lrwttm3Di2++T3Mc
         S9z7C4+4Y0hTgdg3UWk7m6fD8RgoKTM9nFeZg1X6o7vABTuiy2PuvlN8VXYfMP8mOOUY
         E9+A==
X-Gm-Message-State: AOAM530cV19sCJx8u3nf4iH0Uk+mKZdBZK1jWsTXTxV3WlhfcoxAFT7+
        oMe+JfMisl1D7Tpcfn0xyia/yl+f1h8v+C+kHln3mNjZ+vLhKGb7rw5n7vHLmW9HPDsWtnsUjZg
        6MqFGDBojv23aBUfTyllSD/3yzg==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr63681843edq.49.1594206112970;
        Wed, 08 Jul 2020 04:01:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu3h7uw896uTUPxnA3LkPYXdQN/SwlS39PF0fY2ZywJDOPl8R3ZF8j4DbvajdrArtX/ozobQ==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr63681803edq.49.1594206112726;
        Wed, 08 Jul 2020 04:01:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p4sm1776088eja.9.2020.07.08.04.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:01:52 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
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
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
Date:   Wed, 8 Jul 2020 13:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 7/7/20 10:19 AM, Kees Cook wrote:
> Hi,
> 
> In looking for closely at the additions that got made to the
> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
> *kinds* of files for the LSM to reason about. They are a "how" and
> "where", respectively. Remove these improper aliases and refactor the
> code to adapt to the changes.
> 
> Additionally adds in missing calls to security_kernel_post_read_file()
> in the platform firmware fallback path (to match the sysfs firmware
> fallback path) and in module loading. I considered entirely removing
> security_kernel_post_read_file() hook since it is technically unused,
> but IMA probably wants to be able to measure EFI-stored firmware images,
> so I wired it up and matched it for modules, in case anyone wants to
> move the module signature checks out of the module core and into an LSM
> to avoid the current layering violations.
> 
> This touches several trees, and I suspect it would be best to go through
> James's LSM tree.
> 
> Thanks!


I've done some quick tests on this series to make sure that
the efi embedded-firmware support did not regress.
That still works fine, so this series is;

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> -Kees
> 
> Kees Cook (4):
>    firmware_loader: EFI firmware loader must handle pre-allocated buffer
>    fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
>    fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
>    module: Add hook for security_kernel_post_read_file()
> 
>   drivers/base/firmware_loader/fallback_platform.c | 12 ++++++++++--
>   drivers/base/firmware_loader/main.c              |  5 ++---
>   fs/exec.c                                        |  7 ++++---
>   include/linux/fs.h                               |  3 +--
>   include/linux/lsm_hooks.h                        |  6 +++++-
>   kernel/module.c                                  |  7 ++++++-
>   security/integrity/ima/ima_main.c                |  6 ++----
>   7 files changed, 30 insertions(+), 16 deletions(-)
> 

