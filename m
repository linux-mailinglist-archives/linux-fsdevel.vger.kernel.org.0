Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219B514F97B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 19:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBASiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 13:38:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39491 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBASiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:38:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so4961426ljg.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkJZcbPG3GM9ebKeh3YrJmylA5LrC+6BQTvSZ1tS0BM=;
        b=AOSqEne73JzS5Ei2xVkag6DwnX4Pcm5Bcfqq6ZhtJ1WXnP5jDZ/BcD9EG52JUlO24h
         qMqSKLfSwGlsJRuRGiD8UfUYJyvse5ov65l2TAtvz6VuaF6ELjEX+hyxZ0lOQw9HU8LS
         iGOUYTda+sYLB6Lj5gDfNSSkXhghbF+vOriz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkJZcbPG3GM9ebKeh3YrJmylA5LrC+6BQTvSZ1tS0BM=;
        b=IAISHsItmu/QOA+Y2NaMpCYngmAkqiUHUOzSrwqmQ4eOW0545a221mGM2zrYWjD2mw
         gcsm+iPhSabpV97B4rC4PZRpr8qOpieg0Mxp8Fsr7fVymPgNijaSgsSCaO5A8YGjuOA1
         owzjEXpTUjGnrrZj52VWANy10YjPb1W3aVuaXi7SQ4sYvIDQKwmMFoN6Sku+pI8ZaQDb
         0xw2imAwSXbIRlLQI4mQuoLrGuj6/IOWFp3MQInsEZmT5J1buGkmfzXsGo68Hs22eddj
         4puJsggTXQ0kUTk+ag6h2WT630q/n/8z9SI9BKHjPChXJ0oD8So5Z4Y3CcVxmjdy2Ky+
         yb/Q==
X-Gm-Message-State: APjAAAUm1/HbJUXR879zUzreSiXaxWYJE9h+tEDsQisCObXox98beuzW
        tWc0milCmqVc9BJQLqVoFZAFcSloFDY=
X-Google-Smtp-Source: APXvYqymU3/CC+vsqX2fnfoE8WDsmgmmgpcWvY87PUxcFY4nBAzLqU4g5av7E8STMtd14H9ATwntZg==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr9609771ljl.65.1580582289295;
        Sat, 01 Feb 2020 10:38:09 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f21sm5053331ljc.30.2020.02.01.10.38.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:38:08 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id l18so7060835lfc.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 10:38:08 -0800 (PST)
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr8274829lfl.125.1580582287989;
 Sat, 01 Feb 2020 10:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20200201162645.GJ23230@ZenIV.linux.org.uk> <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
 <20200201183231.GL23230@ZenIV.linux.org.uk>
In-Reply-To: <20200201183231.GL23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Feb 2020 10:37:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXZHKJfet=DHYH7aYWvBLP87S4+NMOvXvaC0aYt-GazA@mail.gmail.com>
Message-ID: <CAHk-=whXZHKJfet=DHYH7aYWvBLP87S4+NMOvXvaC0aYt-GazA@mail.gmail.com>
Subject: Re: [PATCH] fix do_last() regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 1, 2020 at 10:32 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> >
> > I'm assuming you want me to apply this directly as a patch, or was it
> > meant as a heads-up with a future pull request?
>
> The former, actually, but I can throw it into #fixes and send a pull
> request if you prefer it that...

I've applied it. I just wanted to check, since you end up doing both at times..

               Linus
