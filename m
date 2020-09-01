Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35010259ED1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgIASxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgIASxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:53:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771AAC061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 11:53:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so1346326pfg.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DW1zJLlrp+b/X5DsaUJywWHpm9f8YdypCEJotWWzal8=;
        b=iu/mivdeQ6AWpfUigREEipYqDA+JBPragzl35o9Nu9ycwxuP1pT/n/GUj28IBjGlJy
         tASUZD6UQpFduus8RxIUHnWDo/ii2QxBTb8+/rddFmc7Q2BvQtdvriL4oOcAbvX3fTik
         a3CX0t1k/eCXUbO98m4G5hAHF2rr9hmEGAwHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DW1zJLlrp+b/X5DsaUJywWHpm9f8YdypCEJotWWzal8=;
        b=Rb6Fff4GbKOxOib4Zsc9BO1wunLUJAfEJUVJXxMAa54y1O/QUNc5T++yisZ59NKGGM
         EVM94vuJ1mjbSyE4iWZWm1CVUCdcFvV9Wf1Vn+RQaJI1mGp33bE1pZPhG1kpnSMppvno
         YpciTuwQXRY6whZ0fpQCJy/iSUYNhE1Uxl9Iv2xN8eMfXIKS637l0VGlC88ZtfhOAC0O
         6ATRHmW2lUl2r4aMu8IPyIsk3MyKuJ1KNS6C5lDo0tmYBwCkfh6ZPyeTNXwy7kqKRZqq
         hLPA6xjdR5A5i/HXuQB7Ko/V8NDs24OTi9P4qeHYoMDoRnAN5LoYeeWTTqY9504EP+tH
         scqQ==
X-Gm-Message-State: AOAM532NdblvCvdWoDCLCkTDO9fQLUjtSQ5I0acP3y5nme2T2yEu2gzC
        O04g+Th5RCoB+J7lvRzNVHooNA==
X-Google-Smtp-Source: ABdhPJw/YsKunmr1Z0dpXo1/zK3rMUMV+IlY1oP54bh4p+BaEO8LJP6shIZse5erSoELJy0YDj4+Gg==
X-Received: by 2002:a65:4187:: with SMTP id a7mr2642045pgq.102.1598986382061;
        Tue, 01 Sep 2020 11:53:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m19sm2192249pjq.18.2020.09.01.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:01 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:52:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <202009011152.335EE467@keescook>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-6-hch@lst.de>
 <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
 <20200829092406.GB8833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829092406.GB8833@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 11:24:06AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 27, 2020 at 11:06:28AM -0700, Linus Torvalds wrote:
> > On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Once we can't manipulate the address limit, we also can't test what
> > > happens when the manipulation is abused.
> > 
> > Just remove these tests entirely.
> > 
> > Once set_fs() doesn't exist on x86, the tests no longer make any sense
> > what-so-ever, because test coverage will be basically zero.
> > 
> > So don't make the code uglier just to maintain a fiction that
> > something is tested when it isn't really.
> 
> Sure fine with me unless Kees screams.

If we don't have set_fs, we don't need the tests. :)

-- 
Kees Cook
