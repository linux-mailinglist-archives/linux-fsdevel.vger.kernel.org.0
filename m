Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880C020EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 20:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEPSdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 14:33:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45246 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfEPSdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 14:33:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so1957180pgi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMlWNXfPwLOEGidca8EwjtL/G7K01/lWskyq0JQp7Po=;
        b=OJlfMUFm+sYikoezqBPoEqI7bWkVQTIqogHDa6Dj1pUQipCT4q3qJIicLQxIOCRBj+
         FI/AGzliYjQFp0YP0RXMuqkZRBGv93YmodMCpxr9bpEKGpczRXG2HmMB6EyExChLipHs
         xMk6hI498cUJXjBOyL5arF5E4J+FMUd7SrD8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMlWNXfPwLOEGidca8EwjtL/G7K01/lWskyq0JQp7Po=;
        b=A8Morz2aEbaVUisgFxBABdh7Bbp3jqTdwxoNDEUPC/pZCzVRJbiLIjGl0yU3qieQSl
         Mao13OS1BfSgLBb+NMnokdC6bPQs/ur1EiXIhudHhG7Xvl7lyvQwMDxfvDOB+K7Xkeph
         Vju5+vRrPj8D+p/kjYz9yO3czB1Vryvr3+2XWXIH6uMPI1E5rTCAIy8cK6p6nIXYF6vZ
         jOBGwLlm5LdvZM2E6CgBSZtaEObuIqM0vhtx+EdNnahgFuT6cR63o7S5SeKfNwL3gwRF
         cT+0lbltiCYXYaXtTn1iTXx4GuCAWKmMEPoM7nzrWDYKRt2/ZiCHGuzodJGT0mrH4QOK
         +hNg==
X-Gm-Message-State: APjAAAUNTHz5dbG55HPG9XGyxpps8CvvY/6Ygy61/sFZ1vX6/ynrCdQ3
        xPfMMTFa7veYZ40ZaOd87s0EeSjHMR8=
X-Google-Smtp-Source: APXvYqxP772DhWABXNrxRmQR2JXgNUzAJCCUljaciwHF+kqiljZJgJB8K8UTqV6vF4M4xE9gCcLLkw==
X-Received: by 2002:a62:65c1:: with SMTP id z184mr36323550pfb.130.1558031603699;
        Thu, 16 May 2019 11:33:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 135sm11511052pfb.97.2019.05.16.11.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 11:33:22 -0700 (PDT)
Date:   Thu, 16 May 2019 11:33:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
Message-ID: <201905161132.CC4C2F3@keescook>
References: <20190430180111.10688-1-mcroce@redhat.com>
 <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
 <CAGnkfhyjmpPAjQFpm-w3v0kMWTKRHTq5v6w0m9KScN2a7bMgeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhyjmpPAjQFpm-w3v0kMWTKRHTq5v6w0m9KScN2a7bMgeg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 06:09:53PM +0200, Matteo Croce wrote:
> On Tue, Apr 30, 2019 at 8:14 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Apr 30, 2019 at 11:01 AM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > In the sysctl code the proc_dointvec_minmax() function is often used to
> > > validate the user supplied value between an allowed range. This function
> > > uses the extra1 and extra2 members from struct ctl_table as minimum and
> > > maximum allowed value.
> > >
> [...]
> > >
> > > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > --
> > Kees Cook
> 
> Hi all,
> 
> just a ping about this patch. Any tought, suggestion, concern or criticism?

Andrew, does this look okay to pick up after -rc2 for -next?

-- 
Kees Cook
