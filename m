Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2147C4E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhLURWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 12:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhLURWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:22:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA9C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:22:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so27664204edc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RciAcnWyVHWI3EHz4UlmUBMKLfdlkLS3DXjlC5GePT0=;
        b=cjvZQXVO+yHzd3mZg0uoHHs2c8B3Ix1oGnL/jHK6ue6lmvuhiKGSQTA4n/z1XfEQls
         glhwCS7oNUlwMlYC3iPo1WclkyEYk3k+5AC7hQNooGKfMc7fFjTUzBbeosM7O16o14V6
         +AvQmIW+AKMtnS9LSu1l0C0SXGsmXH1qBws1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RciAcnWyVHWI3EHz4UlmUBMKLfdlkLS3DXjlC5GePT0=;
        b=KmoEw1M4y1xG/6HKbrQwOGCoLR4FcBrobvblVaUty0S6ZXViiiGgNSEBsZ0sQ4um5d
         soB/GCUkhtZs4UgFeBmL9/pcnv+4fapJLNZ/I2s+CGay2jtnKSElxXzQ1TiH2Dnz6MHK
         B9fuQZMDCvSiM5GdxuNR0Yho5mKWoNZUMdr6oCqp5RbQIFEWJqK4il7FIZ1KNH0rVT5S
         pAVWMEWUxKbRE6SbtfwekZGYq6dRXQyhk2V54qzwudAqArsqM6qIlPOy2ByBcbpBRRPW
         9GV/VZy5Gs38uno8gWKo0m/AhUsOAvF5e0M1rNegPJNEbCVMeIURJKTBaNKk2lh2ORHX
         bzIw==
X-Gm-Message-State: AOAM533MrXL6TWviH80AIwyMGI4z+mnoKUdx2uc0Nq951pryAVpOAXwL
        wAprNPK0ZubaLvqYq4k/rtT1AXc4wpzB68Xv68k=
X-Google-Smtp-Source: ABdhPJxHbaoIv5w7auwYcWoZ9UdECOgCof8EkAngMNDRvdLbvYC3HsJaBxlTNpEykGbXv7KnrP3ywQ==
X-Received: by 2002:aa7:d593:: with SMTP id r19mr4386352edq.168.1640107338857;
        Tue, 21 Dec 2021 09:22:18 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id e4sm6692045ejl.196.2021.12.21.09.22.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:22:18 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id e5so28330752wrc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 09:22:18 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr3336062wrc.274.1640107337991;
 Tue, 21 Dec 2021 09:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20211221164959.174480-1-shr@fb.com> <20211221164959.174480-4-shr@fb.com>
In-Reply-To: <20211221164959.174480-4-shr@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 09:22:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whChmLy02-degmLFC9sgwpdgmF=XoAjeF1bTdHcEc8bdQ@mail.gmail.com>
Message-ID: <CAHk-=whChmLy02-degmLFC9sgwpdgmF=XoAjeF1bTdHcEc8bdQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] fs: split off do_getxattr from getxattr
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 8:50 AM Stefan Roesch <shr@fb.com> wrote:
>
> This splits off do_getxattr function from the getxattr
> function. This will allow io_uring to call it from its
> io worker.

Hmm.

My reaction to this one is

 "Why isn't do_getxattr() using 'struct xattr_ctx' for its context?"

As far as I can tell, that's *exactly* what it wants, and it would be
logical to match up with the setxattr side.

Yeah, yeah, setxattr has a 'const void __user *value' while getxattr
obviously has just a 'void __user *value'. But if the cost of having a
unified interface is that you lose the 'const' part for the setxattr,
I think that's still a good thing.

Yes? No? Comments?

              Linus
