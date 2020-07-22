Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D44228CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 02:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGVAJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgGVAJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:09:31 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D7C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 17:09:30 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b24so74045uak.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 17:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mK85RUGmwRYffliq+MRSbfx2SUtfwZmJnFiHDQarqLA=;
        b=vdHaaaa9IE2S38rf1OOdBGMCtcqKWiiXSSoVcwkPuAA/Op7k48Xcv5bIHUGHrNaSO+
         /EoDVOzVWw/2+fyMgxyh4ZHq/JGxvQAckTOQKU/CCZTN4zMs+UJYqaoIkXVU1aZZ0hDF
         /iya58oVKtmixWpxPy0oyt5p2E98nDspu/ULCEbd0lE95lR/cQId1MURVaH9c+R5MSuq
         MfQMswQfTa8am4zkexMwcDniT3sQgxtnAp7DQCK9o96gXD9gDtJi/U1xdPnf2+ShZ1r0
         zBvH4PilGuGoTO6TStVIxyq+/V6KGki/CBSPyF5XRTtY9q+wyTIAemS6kjc3VSj3K7Bn
         NQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mK85RUGmwRYffliq+MRSbfx2SUtfwZmJnFiHDQarqLA=;
        b=VScLZ/B1pTqrpYs0mCFkWdq6ZKnNBxZAlKYtetmi7q/D+o7zdUQlIcuBvp61V1Jhvu
         m+Z5+epqEqoYChkmOPYdooYwM/P9/xnfDLfINYSJjy1Wt3UQZJYdtg9iXdK5FX1ZtuK8
         S4BtdLdPZ3e+vV21ZKMegaR3ZjlPvP6ArF3lN9pUnW06TEt6RUSSC7LVWqIL3x6wSCSU
         mXLKgWXsN9+kMhfCT6FmEn2G3LbL4/laz8J17LqY6UoFhfhB/jtr/OR2ZZ3qrY0FuWdm
         THCoqC+DIC/ZtZgB9tcfPPxZGmoyKB+C7WA17KEwNMCg0aCny/6mV4fO4OuvZCPIIm/b
         cKgg==
X-Gm-Message-State: AOAM5309HWoCzrQd7yzXDGib+w6Ed1qg4kcDWdeRTQLGef2Ay5bWddxn
        DC5cYwO7S3zRCSnLnlYQsLDytkZHBPp7xWZziP/61Q==
X-Google-Smtp-Source: ABdhPJx6Jec9MJG+B1or+S03mhb/8U2LGhCRDecxPuzNvED8pDeuKCizZaXpCWHX7Dv3A6yU5IdcVtZJ30CJ7grHfYU=
X-Received: by 2002:ab0:7182:: with SMTP id l2mr22366441uao.13.1595376569751;
 Tue, 21 Jul 2020 17:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200714161203.31879-1-yanfei.xu@windriver.com>
 <e3cbdb26-9bfb-55e7-c9a7-deb7f8831754@windriver.com> <20200719165746.GJ2786714@ZenIV.linux.org.uk>
 <021ffaaa-daa4-8d80-c5bd-3a6c816d4703@windriver.com>
In-Reply-To: <021ffaaa-daa4-8d80-c5bd-3a6c816d4703@windriver.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 21 Jul 2020 17:09:18 -0700
Message-ID: <CAJuCfpHUcnEr1duHDjWTRDhpscE6=FWKvjid1eWiMObYY0bL4A@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: avoid the duplicated release for userfaultfd_ctx
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 19, 2020 at 6:34 PM Xu, Yanfei <yanfei.xu@windriver.com> wrote:
>
>
>
> On 7/20/20 12:57 AM, Al Viro wrote:
> > On Sun, Jul 19, 2020 at 09:58:34PM +0800, Xu, Yanfei wrote:
> >> ping Al Viro
> >>
> >> Could you please help to review this patch? Thanks a lot.
> >
> > That's -next, right?  As for the patch itself...  Frankly,
> Yes, it's -next.
> > Daniel's patch looks seriously wrong.
> Get it.
>
> Regards,
> Yanfei
> >       * why has O_CLOEXEC been quietly smuggled in?  It's
> > a userland ABI change, for fsck sake...
> >       * the double-put you've spotted
> >       * the whole out: thing - just make it
> >       if (IS_ERR(file)) {
> >               userfaultfd_ctx_put(ctx);
> >               return PTR_ERR(file);
> >       }
> >       and be done with that.
> >

Adding Lokesh to take a look.
