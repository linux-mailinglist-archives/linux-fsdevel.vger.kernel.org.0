Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D343265565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgIJXSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgIJXSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:18:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FBAC061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:18:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so5176059pgm.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ahcfJWxMLLWCQWWMSaduDRixyqLU7R2VmWJmYScB+xI=;
        b=e0bs/fLL5/nal1hkQQK8DqWL0oUik0NhYYhdIwGet7sKAsECUiTvD0lpGfKcU5pPSz
         UWGqg4d+81XpUEqJGRxPydRngpjoC+VeTS1Z01mtq0/4saWZosh7U4GKnJWYMXaqhvex
         MrsLwwKtAJrOwh/txFCgXVdSCsIGtRRcNzL4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ahcfJWxMLLWCQWWMSaduDRixyqLU7R2VmWJmYScB+xI=;
        b=AMOBB9B1Ijv7ddszMSPYT+7R7fEr/htxn1CUEvmrA4SHZMzawhokM/MaO/+IkzHlpT
         NQtrOzz++Tvw0j+VOyIttPfE6JkKJNPOwMT8+2G2oXSdq2SXf/ThS2iWVnohYYzJmRx6
         1BCQpSXncJSX6FQ68dauhKUv/PsiCjbbTkIBIYSlx9Rr0kX/kjuCJFhjs3/AXvq1uSXx
         4Hv5Y1oWpNizIGDv8jUep9zn2KAoe3wfko7q1VcfFm9FbAMZxx0aMA7Z4Is3MgMJDOS5
         39gsFHfkv3kUDL2nBRSKIe0wLlz8L1mMBtCbPsFTd9XKtv/C0AbUXDSuMFk87pUw9BU4
         GG6w==
X-Gm-Message-State: AOAM531h88jqaIetMWDu+tZyv3IBQpTenX5MNsk1YmxjGHnGAwjjN2h0
        kz40LQLs8qZ670ieHmJAvmAPZg==
X-Google-Smtp-Source: ABdhPJyDlBU+y8fl3h3ui9sPcSP+9dtdObZsk3zIBZIW66XSoC5FKE/37mQEGAa93/DFlZtCDe1HSw==
X-Received: by 2002:aa7:8ec7:0:b029:13e:d13d:a080 with SMTP id b7-20020aa78ec70000b029013ed13da080mr7345919pfr.23.1599779890038;
        Thu, 10 Sep 2020 16:18:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm166428pfi.55.2020.09.10.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:18:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:18:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the
 fbfam feature
Message-ID: <202009101615.8566BA3967@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910202107.3799376-2-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:21:02PM -0700, Kees Cook wrote:
> From: John Wood <john.wood@gmx.com>
> 
> Add a menu entry under "Security options" to enable the "Fork brute
> force attack mitigation" feature.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  security/Kconfig       |  1 +
>  security/fbfam/Kconfig | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 security/fbfam/Kconfig
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..00a90e25b8d5 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -290,6 +290,7 @@ config LSM
>  	  If unsure, leave this as the default.
>  
>  source "security/Kconfig.hardening"
> +source "security/fbfam/Kconfig"

Given the layout you've chosen and the interface you've got, I think
this should just be treated like a regular LSM.

>  
>  endmenu
>  
> diff --git a/security/fbfam/Kconfig b/security/fbfam/Kconfig
> new file mode 100644
> index 000000000000..bbe7f6aad369
> --- /dev/null
> +++ b/security/fbfam/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config FBFAM

To jump on the bikeshed: how about just calling this
FORK_BRUTE_FORCE_DETECTION or FORK_BRUTE, and the directory could be
"brute", etc. "fbfam" doesn't tell anyone anything.

-- 
Kees Cook
