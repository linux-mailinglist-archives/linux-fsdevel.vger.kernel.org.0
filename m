Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BDB22CE4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXTEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXTEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:04:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38380C0619E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:04:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so5823035pge.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LrMXrDf7YIZaoWeBKOjSOSMpqfT8SAqX0JXj+wrASIM=;
        b=YJdzU2vsfQm7AZSEbQDHOGAXkb0FDmlYvGdDHcCBV0Mb+I/0YGXEnNHZP0ITEGdZnq
         rMUzebIoCugRClDH5RJXQ2VNELpwlavB8ApMKzNJeTwVnKrJanhG9XCaDVo5IwEReNVE
         3/qzt3XofNbnyZe3522KpHnb11vBLC4noGHZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LrMXrDf7YIZaoWeBKOjSOSMpqfT8SAqX0JXj+wrASIM=;
        b=VB5Cdh1cLJgVFKycZHBMIZNeqQq2bVwnxdb/jmw4la8HY/6J2FEm1IkOytROfu1k6J
         6PTLBlDEcbMh1WMR8jntDVlAnLT4PLE7RA2waAhJDXnTIYcOZbOhC26tM4c1LGMge9GC
         NJqJJjNGWuSpG18e2O9WzWldi+c21v9nT75+mLqk8qkOGX7/n6ctzhPR8nnodXLPxd9J
         EOzzVrUA+pRyw0X7+O+vmanc4hN9wxjB+cBsh0qQCw3nZ9HnJg3pl81zrDNg4NNsW4xi
         3O+4je11SPiqUd3wWBbWmzajRRRQjP7ustjcdIywveIkJk1NrbmHggBBMAoBVSjPf51v
         ui/A==
X-Gm-Message-State: AOAM533Ep0BnlhAHkaE35fTnap3RFOjzaEfVQcfi3OpJe5jxeX5JQsjY
        hwT/ruOapWsBVaoCUoJckORNTw==
X-Google-Smtp-Source: ABdhPJwByOH/4ROCOy3QCc3kWU3xI1XY75NRzmOAdHNrzalnVxff+4jx3AjnVMN92eX9iE8obAmE4g==
X-Received: by 2002:a62:5297:: with SMTP id g145mr10327624pfb.28.1595617479754;
        Fri, 24 Jul 2020 12:04:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm6228743pjp.47.2020.07.24.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 12:04:38 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:04:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 7/7] ima: add policy support for the new file open
 MAY_OPENEXEC flag
Message-ID: <202007241204.3DD9B905E@keescook>
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-8-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723171227.446711-8-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:12:27PM +0200, Mickaël Salaün wrote:
> From: Mimi Zohar <zohar@linux.ibm.com>
> 
> The kernel has no way of differentiating between a file containing data
> or code being opened by an interpreter.  The proposed O_MAYEXEC
> openat2(2) flag bridges this gap by defining and enabling the
> MAY_OPENEXEC flag.
> 
> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> 
> Example:
> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

^^^ this S-o-b should the last in the fields.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Link: https://lore.kernel.org/r/1588167523-7866-3-git-send-email-zohar@linux.ibm.com

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
