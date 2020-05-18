Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87191D7DEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgERQIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgERQIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 12:08:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61232C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 09:08:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so36574pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UvPpDrJRTISjRmaitgDIto8RJyndLCc2sSj57LCcK5s=;
        b=kJriiaT8bwsbMU+17BfUzGJkZ5x7ACjzaUbUglQ0rEiAY4dvdhLlmrkZ7+euuzmk+j
         4qsmp7fzIrkvDRISd7JmCZvLc9Gyv51lm8tg3i2ltRzdUwDpEN/LXoB8wd02AqeRBr/B
         lzfu/wW2z8yfRnFdZmtyJ/Yx5/0hqU2LYRXLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvPpDrJRTISjRmaitgDIto8RJyndLCc2sSj57LCcK5s=;
        b=XNxUZ7dVYJynZRT0w5j/a7G18WsFZy2LK2ZRk+8C60ftu1bI2eqV02MKUkZKTi9gIV
         feunQPhHkwbpHFu33uqMfw8hIThInAnfum7w8HXkCoX/GFdxJt2ennKmQNYpVtT3AOFD
         8ecAFeuKJKlS0nAorZcwEWlb1/HVq92wZVEiawO6zgRtXoPScdyNW5Eld5RdRtzqyHte
         dT81Uh4tukfIM7FcbQ3fJho7fTXJz2+Do2pcYGwrHnXQpLVQx9c9emciED1e9GsVhH4E
         HWN4ETWvDLKREQLFtYuhUhahzxPzd9ZXUBfqnrQaABL7MhLrwgZOVhahEHXDvSLHRfpp
         m6yA==
X-Gm-Message-State: AOAM532lqsyY25D98AJRRv5vQElSrA7RWf6PRUIojKvPIAemjLPD66Rn
        FQnlnX88dDTdE+GmMujfKY6x1uNVqaA=
X-Google-Smtp-Source: ABdhPJx943rWOZXiT1nWV3r0+zppQzp7AjAdvm8rHRNKXd1IRHY+obmDA08JLGYcXz6Qui/u3thMaQ==
X-Received: by 2002:a17:902:8c8f:: with SMTP id t15mr16690559plo.183.1589818104936;
        Mon, 18 May 2020 09:08:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm8225907pfo.3.2020.05.18.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:08:24 -0700 (PDT)
Date:   Mon, 18 May 2020 09:08:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: const-ify ngroups_max
Message-ID: <202005180908.C016C44D2@keescook>
References: <20200518155727.10514-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518155727.10514-1-steve@sk2.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 05:57:27PM +0200, Stephen Kitt wrote:
> ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
> it const, in the same way as cap_last_cap.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
