Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9566E16B2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEGTSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:18:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46819 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfEGTSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:18:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so12657663lfj.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtF42CqL123SSRl10dCYLKTcv2hhlfrc0BUh3e4ZyQA=;
        b=MDNkFF5/XrluyqCwIMfLlVttmyMxCjmI2wG7YwAycEXZCEOWsEc2x6MssI+Rlbi/iu
         yQsVKdRqLbBtdsbUldIBJx0z/BfyC9QXVCs0johj7JFgnda+gRiZW//uOT35LvQueJfP
         e5w65jeDG6ogGawBTKsmIemyIVj87dZWPIMVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtF42CqL123SSRl10dCYLKTcv2hhlfrc0BUh3e4ZyQA=;
        b=UPI4udoewjrEW4wLTerhPtRVTZ8tmHf0SYoMrR4DcW2v2hr5VDvRMJl0KmrR0QLcJZ
         R9/gm4qCJ0tByonquthzjTVVMLNm3N8jOloM07kmd9YuEVBJQMNQdTKSuR6WmEkKrPPt
         5uDPRhnAB+cFiIXBVvKFgRreJ+05oGOIifr/Z4Oshwzhiul+6FFVso2ZA/d/jCcfLX75
         6UBOkIe+R0PKZL9e2vMlAoYPyJiRt/ZGmYeAwYi8WQkrkIbFm1Xzw6pY9Tj1AD2RUWgf
         Cdfcm/0mdaG8IyQL8iUGOsFeqGGd0ABqRtN0ioDmvWmqxwA50OgZ4CQYJ5GXTJa4LvhZ
         BDTQ==
X-Gm-Message-State: APjAAAU2QPUOAWC9qi4kOkLyFNcmYGcEn3DezkkiTB287i2yb9V5ikul
        u/N9SlZiHwvzwxhaeq5P308bVZo9XL4=
X-Google-Smtp-Source: APXvYqwHIIxKOnq2T+JRAEL3LfAkz2C84RuMBdvazkEbiwI+SYHyDlIuvAo66FF4ONkf40Fw6bdHlQ==
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr4126821lfn.148.1557256701073;
        Tue, 07 May 2019 12:18:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p26sm2857555lfh.71.2019.05.07.12.18.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:18:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z1so3138257ljb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 12:18:19 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr3212578ljg.94.1557256699430;
 Tue, 07 May 2019 12:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557162679.git.kirr@nexedi.com> <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
 <20190507190939.GA12729@deco.navytux.spb.ru>
In-Reply-To: <20190507190939.GA12729@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 12:18:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWusqMfU25eBofgBHVSrQaVxr-EwCPCWcBaFMjzf_=Cg@mail.gmail.com>
Message-ID: <CAHk-=wgWusqMfU25eBofgBHVSrQaVxr-EwCPCWcBaFMjzf_=Cg@mail.gmail.com>
Subject: Re: [PATCH 0/3] stream_open bits for Linux 5.2
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 7, 2019 at 12:09 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> I've pushed corresponding gpg-signed tag (stream_open-5.2) to my tree. I
> did not go the gpg way initially because we do not have a gpg-trust
> relation established and so I thought that signing was useless.

Ok, since I hadn't pushed out my pull yet, I just re-did it with your
signature, so that the key is visible in the git tree.

                   Linus
