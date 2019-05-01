Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9120A105A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 08:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfEAGto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 02:49:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44597 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAGtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 02:49:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id s10so19119016qtc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/2rF64aRaDUSZBrA9IJUuBuyItqcz2FNBCbr5ui9w8=;
        b=YUFV8mM+ygoPgPR2my7rzrjO4Tcc2KN7Hhg7QsfLluc8JvFnOGquAQp2Zt+aJ/+BCf
         Hoi4lm+j2TcrGP3Q/AeiBajkKHmXkhwx+HGBpmPeZTEAX/LNpthQvpUYP/r3ki0sx0b5
         t1cFeQLTVqAiYaVnriVe4UxnsClRQo4qm0K5WXbeKW35c3Qh9eYfOmvKcwBsFlXIgTVX
         +2nFT3DkTHtGP1/W1hdmaGAwus628oN4l30AsV8HxkFOzQ8pXcT/NfH97vzZjWD8SyP5
         fCDDiTbMCOL0VNeyK7zubJPLc+mnNS1LhJM/9/MOG2MX0v92lzGP+O6iLWn9jyoLeEdH
         QZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/2rF64aRaDUSZBrA9IJUuBuyItqcz2FNBCbr5ui9w8=;
        b=MJCQoInhLanPJ+eA7JPWjOkIZv82HsBQWaj0USRn4+grJC9aJWQPwB/Ur0l1JgVaHc
         1lCAs6Vcxy7LDSbkx5WMclm4GqnsKvI5awKznxEbJAPlRoGEl85RETHNtgEQf6jLYR2X
         Zg7i9uPeGVuOOFr2kZhbB4WqKAWSkzrS8l37ez1+oSZE8bUxsK2/biZN2lVxsbX5jGq1
         /AQGN1grGLKJoOBX/Ql0OD+QTasiCJvsQPFLVDCOJNkyUMSmqgVfcDtik4+wf5iVqbsa
         TS2Mvu8bzo/d8A9YiG3HKpgEMA6YEWb1RnygdE8DIGawDuFjLva0J4YK0WxPSlV/7x0r
         qnEA==
X-Gm-Message-State: APjAAAUQ7yF1K/2dBhrR15J797cUnLVWNVtihH6Qy76HkZ9j4iiQVpF3
        phMH2Qg/Tn1Z7JLwiKyShyyFsBxieCLFxW6Salg=
X-Google-Smtp-Source: APXvYqyxdr/kouVHncCCtc3/TJQj7PmvKG+5ws9O4PorPQzWGc8akf32T9jfvVH9ybnE6aJs4wdBgZMBZPS9exen/s4=
X-Received: by 2002:ac8:2d24:: with SMTP id n33mr49306580qta.70.1556693383039;
 Tue, 30 Apr 2019 23:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190501003535.23426-1-jencce.kernel@gmail.com> <20190501010338.GN23075@ZenIV.linux.org.uk>
In-Reply-To: <20190501010338.GN23075@ZenIV.linux.org.uk>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 1 May 2019 14:49:31 +0800
Message-ID: <CADJHv_ved62oihqNmj=JB6PfDKx1AJrv5WsD+aTpsUTOQEwaCw@mail.gmail.com>
Subject: Re: [PATCH resend] vfs: return EINVAL instead of ENOENT when missing source
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 1, 2019 at 9:03 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, May 01, 2019 at 08:35:35AM +0800, Murphy Zhou wrote:
> > From: Xiong Zhou <jencce.kernel@gmail.com>
> >
> > mount(2) with a NULL source device would return ENOENT instead of EINVAL
> > after this commit:
>
> See ee948837d7fa in vfs.git#fixes...

Got it. Thanks!
