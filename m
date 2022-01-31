Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852B54A4DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiAaSHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiAaSHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:07:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE2C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 10:07:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u18so28181190edt.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ngbIhCdogOcBSU1e6pp7yjPEGqtjsYnsxL5Y/3BpBs=;
        b=MWuX920xhwonGe/Eb70HBXGdjtu5RWpImkn9WM5pAZLILk/by+T+gAKQz/5ki2lADw
         ahNGvnc4HO9cFwyKxVCsJVfkrcrG7gniiWGieXnlzfe/2y+gBJm8alG9ty1aFzqpcBxZ
         uhsIC39YV0NmuPj2wAfQThdYZ5J29CbkiQZm6ux11SRxNh2wz3GyJ9cW+ziYHgSfFZRG
         f6gf0+csG0COT81NSw2TlP0ORR6mF7X1jao/BWb4X/Q+hzIykX0brdlNiRx8Nmuz0+Dd
         DOjAOzM8e8xnWD27OTh5Wm6zdca6CDEHBb3ZJxsj1Lzxpm79u43XqAPsQNA7zEsvubwN
         zVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ngbIhCdogOcBSU1e6pp7yjPEGqtjsYnsxL5Y/3BpBs=;
        b=ulFpgP7ADSKTlVhgdB0n0/wCD2jP0ut31hM+Mt381H5QM8Lv7YMvjJTP6dQgV64Ymz
         Hg9IhpKksxnz+m3wLagbcGRqHpLvZKqyQ+VTjSr6WMzCuHmVt8R1WzyaTkLsdLBYwaDL
         4oigYTGZJO0UioWxVCzr8vyv79+8wbd0CLcptE6qkvryKsDV9Ztkawh3F/WJHkd7sqQu
         Q6m+RalkYSBM+hgXfqg/7yY1LhvS3EtwMTLYWAf+r38PT0hWFds9g+3ZlFqLKBSm5gVT
         R+jCnIIBhY5mYG7G5MrvZ8CWXZKJaIOBrqp9jiF2A1lg5RrSCO7LMkfsnrVwcdf+hquw
         f3dA==
X-Gm-Message-State: AOAM530CdOIiNEu177bl/MwgQHcdekoINWuwL9AGbJu/68zshQWZhyxY
        Sh6WqqBA/sKxFKgQpC10cWBQ8D6kQrZoJVKw4U8TjuEafg1HSVjP
X-Google-Smtp-Source: ABdhPJxEX+n+D2eQlJRrREPiJ7wffLrZ03BnYNKye/ZjKAndcysFBqZMj1aZaz1ZTaqJGUM4F6BF+1mZFxobl19IeCI=
X-Received: by 2002:a05:6402:2707:: with SMTP id y7mr22007921edd.294.1643652426755;
 Mon, 31 Jan 2022 10:07:06 -0800 (PST)
MIME-Version: 1.0
References: <YfgivbCgwKjJu9ec@fedora> <Yfgjhq6LIzhKNaTU@casper.infradead.org>
In-Reply-To: <Yfgjhq6LIzhKNaTU@casper.infradead.org>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Mon, 31 Jan 2022 15:06:55 -0300
Message-ID: <CAH7FV3kL=6-aKjrYNS7LkbN3Z2MzKufCCrWP5xHSicytAGTPkQ@mail.gmail.com>
Subject: Re: [PATCH v2] seq_file: fix NULL pointer arithmetic warning
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em seg., 31 de jan. de 2022 =C3=A0s 14:59, Matthew Wilcox
<willy@infradead.org> escreveu:
>
> On Mon, Jan 31, 2022 at 02:56:13PM -0300, Ma=C3=ADra Canal wrote:
> > +EXPORT_SYMBOL(single_start);
>
> kernfs is a 'bool', which means it can't be a module, so there's
> no need to EXPORT this symbol.

Thank you for the feedback! Still learning...
