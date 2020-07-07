Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD98217AA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgGGVpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgGGVpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:45:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4BCC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 14:45:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so10706805plk.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+X2Xhmqqsv0iqlLQQgWOIh/h4XwKHm7DRSh8jQWFnII=;
        b=c1U9uUkdrkhW1asUELPte2OOBTvNiETRx3xLuK0Jg7I453xkG+Y+lWevjhbk9Q33v8
         +8X4WBO3m2tBmVN1D8DLJqjiJ6rP34+a4QGgzHsR8v8VD2UN/8nVX4qAgNARioPhUATW
         V+FlQoeq3bNgrBvlSUJvyTH63wOE59cHAsydM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+X2Xhmqqsv0iqlLQQgWOIh/h4XwKHm7DRSh8jQWFnII=;
        b=Rmyb2EA3OgicASpxq0qPHm39wN77d8GGK4bEwEt2o3i/eBa679Ua6cZWWuYjzjeDkR
         wOMFV9sFX2LEtjoXmA2GEiKJBGi6RpZybS3dse5l0EXnRI6txb2f+kNctZjGnnpRtRMm
         0EPSn4ooSe00AH+MoCpS5O3aNSQXr7vy5p2+EuRtHrTyzBeZZA1Fzlk1PR1Z4Sl4XhpQ
         1pNStCUshEJdNNxGoNMKb2qcrIrFKBttwzBZf/QCNQUSxNaiGVB2IZHsrCFju/DLmbKr
         Rp3U7RyQdXrxd9QmUCOPn1nsmbudE2vQBpHqtH+cBYDctDQMbycDeTibUOTRkjJ+cBSE
         teOg==
X-Gm-Message-State: AOAM5326YMPTpOwl+wiAPmWhZWyBbA57Fs77Ik+RA2aERc7WFeJg/oHz
        xyrBLKpKWCEsLIoIr7FLjY4lyQ==
X-Google-Smtp-Source: ABdhPJwJvh8fkTd5j8YoULkHA3MqKVqIp0iKE5PJOfznsAz0swonzvETE92J5nlo2+4ZNlrYhFctrA==
X-Received: by 2002:a17:90a:234c:: with SMTP id f70mr6654067pje.13.1594158313261;
        Tue, 07 Jul 2020 14:45:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c134sm8777846pfc.115.2020.07.07.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:45:11 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:45:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
Message-ID: <202007071433.55488B0C@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <1594136164.23056.76.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594136164.23056.76.camel@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 11:36:04AM -0400, Mimi Zohar wrote:
> Hi Kees,
> 
> On Tue, 2020-07-07 at 01:19 -0700, Kees Cook wrote:
> > Hi,
> > 
> > In looking for closely at the additions that got made to the
> > kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
> > and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
> > *kinds* of files for the LSM to reason about. They are a "how" and
> > "where", respectively. Remove these improper aliases and refactor the
> > code to adapt to the changes.
> 
> Thank you for adding the missing calls and the firmware pre allocated
> buffer comment update.
> 
> > 
> > Additionally adds in missing calls to security_kernel_post_read_file()
> > in the platform firmware fallback path (to match the sysfs firmware
> > fallback path) and in module loading. I considered entirely removing
> > security_kernel_post_read_file() hook since it is technically unused,
> > but IMA probably wants to be able to measure EFI-stored firmware images,
> > so I wired it up and matched it for modules, in case anyone wants to
> > move the module signature checks out of the module core and into an LSM
> > to avoid the current layering violations.
> 
> IMa has always verified kernel module signatures.  Recently appended

Right, but not through the kernel_post_read_file() hook, nor via
out-of-band hooks in kernel/module.c. I was just meaning that future
work could be done here to regularize module_sig_check() into an actual
LSM (which could, in theory, be extended to kexec() to avoid code
duplication there, as kimage_validate_signature() has some overlap with
mod_verify_sig()). into a bit more normal of an LSM.

As far as IMA and regularizing things, though, what about fixing IMA to
not manually stack:

$ grep -B3 ima_ security/security.c
        ret = call_int_hook(bprm_check_security, 0, bprm);
        if (ret)
                return ret;
        return ima_bprm_check(bprm);
--
        ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
        if (ret)
                return ret;
        return ima_file_mprotect(vma, prot);
...

Can IMA implement a hook-last method to join the regular stacking routines?

> kernel module signature support was added to IMA.  The same appended
> signature format is also being used to sign and verify the kexec
> kernel image.
> 
> With IMA's new kernel module appended signature support and patch 4/4
> in this series, IMA won't be limit to the finit_module syscall, but
> could support the init_module syscall as well.

Exactly.

> > This touches several trees, and I suspect it would be best to go through
> > James's LSM tree.
> 
> Sure.

Is this an "Acked-by"? :)

-- 
Kees Cook
