Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29114F96A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBAS3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 13:29:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44393 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBAS3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:29:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so10468016ljj.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 10:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSI0TK8DtQcgu7WAq2+0dqsq5n6ujNavCAHjt896Jhg=;
        b=A5Ie0buo7SpllcOPGmNpyxOG7YA6j+kdIqsnzFtc1W8MKL4VnNs71wro8qKmqbCCNO
         jnMq/AjHCV4Ub2WdHib6Xp5vXi7cyE7o55BhCqAOvz18NMJybm8Jby8Z4vYrkHB5j76B
         SVGzrUeALZlF/zC8ExpgB54jGYy4T2P1Ol/wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSI0TK8DtQcgu7WAq2+0dqsq5n6ujNavCAHjt896Jhg=;
        b=gqeuxwmMWfXVs0D7zCpBOueADnpxfuiU5mb3i7DUOVKO/09cTGFY6viEyECQWBc2FM
         lQ+JRwuzsjiwXvRw9AoVTwQ7PsZRRfp9nSDGLyT9XBo6sA/z7oH5pHuizQ4hrUkI21Kl
         zbk6S+szHx2XXlvmGKVE2ostUlqZ89bkQ27zilmGkaR51SrUuDanrzimHqBen1k82A1S
         JSADQPUxgdwgAi/9PoJ/Yx/KzWIeEksYe5ZPdBEfoO/7EcwmE5vcgEhEfg5wuTizXdeX
         IKVlnFosePHL6CEo51xV4UDSs6ivaLcoAB8GR55EkAwFFAsiNqe6ZSDtn4MHnPT6K5PV
         BvJA==
X-Gm-Message-State: APjAAAUvC8cebm9owVrozSpY8infVjzsu5lGtc97WaYKbtQF8Odixt0L
        BI4lHgHLNP1880vrXC6zRudsstSDekc=
X-Google-Smtp-Source: APXvYqzdOvph9ynv/t22tYf72TsJSmMo58vyw8PsABsKVmDikZzPUIpEqHcQL6GNFiNKm1bHJr8dsQ==
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr8831910ljo.240.1580581775552;
        Sat, 01 Feb 2020 10:29:35 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w19sm6383163lfl.55.2020.02.01.10.29.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:29:35 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id v201so6991442lfa.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 10:29:34 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr8157515lfm.152.1580581773681;
 Sat, 01 Feb 2020 10:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20200201162645.GJ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200201162645.GJ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Feb 2020 10:29:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
Message-ID: <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
Subject: Re: [PATCH] fix do_last() regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 1, 2020 at 8:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Brown paperbag time: fetching ->i_uid/->i_mode really should've been
> done from nd->inode.

I'm assuming you want me to apply this directly as a patch, or was it
meant as a heads-up with a future pull request?

                 Linus
