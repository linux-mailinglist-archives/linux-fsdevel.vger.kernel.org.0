Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7125D22874
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2019 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfESSxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 May 2019 14:53:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35603 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfESSxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 May 2019 14:53:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id a132so8490651oib.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gj9Btx/jtZWCRzYf1e68GHq9hnNL+Ogbx99PZIgoB74=;
        b=he4EegSmAY2zYl4r6S9HGzKLVkT8LcOlIiHygVYp7zaifYHKTOnLMI3o86dBf9LnbA
         hNpn27eEyN+qjhPr4EWsh41NZcuWKx0QV/Lm3hbJvmg4w/a4SM3A6yP64JFNN7ArzrWN
         LmBZN1YUxjOCOk3FCPXXbnD3ysP2yAjgaksZCoteXGH8VH61lmvwvYl8cSGa8tPvrlXr
         xPan3agZZxXKJmJ5Js9Nz6/gSEQCRSxaaZuflHI0xI3I3tFi+kBW1X+kpQ85pzisWSZk
         tKdYRCV0JX/Fq5SKy2oGR4hlkUeMEXHgWn14Ltr+Tbi08WwF6ZAeblRmiNNtO42MgwiT
         kfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gj9Btx/jtZWCRzYf1e68GHq9hnNL+Ogbx99PZIgoB74=;
        b=FSqpVxjHJjs84hAAOuzLnyLeqahE1PPV9DkocKKisLdb1l568mgBcHjoJByfKo8ypQ
         pOi0u139MS3axnnEJ7sFRCqY3Yak6qWRRWsSHtDy0R/vo113sHvq9AjHSH7kY/nxSkoh
         l6HzXOoniXcpiCalgHHu4aQsppqwq/DweT94FMUYMjnC0SA2RxhVD9dwD5AtlUfNKTCx
         jNcQ5oVDEv/YMWaa2Fobk6ndSR2VJTPWLHAkFe+6uzuMs5fOvy1MK3wp+CG7nv8WqE1V
         Mr+DoEnBvbBoWmemP2oYTnVCQ4x3RXfLjE6mKSzjBSEogrqoM6xaM1yM+z3F2xJEDh90
         J+EA==
X-Gm-Message-State: APjAAAUavYBvjtxzkV/RQBtSjsCeGvg6tB6qq/T4KsfvsVqgrdN6xM64
        un25Enwdp2f5d6sZERGHzujTaKGH2X5esHJArJBz9O7r
X-Google-Smtp-Source: APXvYqzKuIF7DjE9geOB0iP+nbKCvx7yts/nthzaKm8X4SzrLuLauoovdM83byX6mPO6HfMrjjhanslT2cwm2r59jc8=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr2335808oie.73.1558241173924;
 Sat, 18 May 2019 21:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz> <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
 <201905170855.8E2E1AC616@keescook> <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
 <201905171225.29F9564BA2@keescook>
In-Reply-To: <201905171225.29F9564BA2@keescook>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 18 May 2019 21:46:03 -0700
Message-ID: <CAPcyv4iSeUPWFeSZW-dmYz9TnWhqVCx1Y1VjtUv+125_ZSQaYg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Smits <jeff.smits@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 12:25 PM Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 17, 2019 at 10:28:48AM -0700, Dan Williams wrote:
> > It seems dax_iomap_actor() is not a path where we'd be worried about
> > needing hardened user copy checks.
>
> I would agree: I think the proposed patch makes sense. :)

Sounds like an acked-by to me.
