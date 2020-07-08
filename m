Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB8217D70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGHDOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGHDOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:14:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3821C08C5E1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 20:14:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so10033311pfn.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oAwKqHK24P/HMH2S8nsQQ/C5A8edfnTk57osWeiH3rQ=;
        b=jPcn8u79M2ubqWOVgArEpIpOZmykPitfCUoGWRa6+qdIOI97B2U6jelnkbvjXAuChZ
         Z+MmJ0LdTQYzcxBmMKHTCKwjfciCn6vEWhb6CmddE9e2sdVlginnSJcI4hynjLkczzbl
         LS+umlChhWR4lhCrtRCR4GWrBQVV9t7/5Gyow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oAwKqHK24P/HMH2S8nsQQ/C5A8edfnTk57osWeiH3rQ=;
        b=CLx7FJRnDKjov8r4z7SxqHcQLmQ3X4UCtXeRtjOHkVq0MpYg7e2pfcAM2XdBq/hqT1
         i/Z6gi5ZKtRbjjRKZcS/wbtLOmIhUTP+uGD6UftIxwU12wl1XGwEO/aYME0EeBcbelK+
         8o540dDEKC/pfaeseJ3l+kER5mBXuroCJkuLwRx9zRD6qrTN9OGtwugfurN5QWfKQOzc
         cl9XUb/b2bYBtou7yTvS5WV8FxijyzLOqPMOaewFFHgtvxBFfICUVxxDuVMy+vEFfwul
         0qOkRf54/Sj8l/Io4gO2cE7XH19YvxUiurR011TBiS9wCyeUEIDM0lbjedobKMJ+Ibr6
         5OZw==
X-Gm-Message-State: AOAM532IXjZ0ffPPAYy7E+IcmVRoD6eliUxb7wMwoHrA8f86ZT8gkZ7+
        Pg2eIVEF40kc+XPunD145hcYbQ==
X-Google-Smtp-Source: ABdhPJxhvCX833Au2SUtzVOGW9yxrRzRu1ollAu0zOyXR108vtcu6tLLUi/3fOYAAPRVVk6z2XGUHw==
X-Received: by 2002:a65:6554:: with SMTP id a20mr41872771pgw.301.1594178090263;
        Tue, 07 Jul 2020 20:14:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm3665683pjp.47.2020.07.07.20.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 20:14:49 -0700 (PDT)
Date:   Tue, 7 Jul 2020 20:14:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
Message-ID: <202007072011.91509B7C@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <0a5e2c2e-507c-9114-5328-5943f63d707e@broadcom.com>
 <202007071447.D96AA42ECE@keescook>
 <c2e4f5ae-0a2f-454e-6847-c413ca719abf@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e4f5ae-0a2f-454e-6847-c413ca719abf@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 08:06:23PM -0700, Scott Branden wrote:
> Some people want the header files included in each c file they are used.
> Others want header files not included if they are included in another header
> file.

Ah, yes. That's fine then, leave them in the .c files.

-- 
Kees Cook
