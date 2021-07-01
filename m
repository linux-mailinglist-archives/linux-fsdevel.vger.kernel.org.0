Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BA3B95DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhGASHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhGASHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:07:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33FBC061762
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jul 2021 11:04:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t17so13464602lfq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jul 2021 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cWwxEDc+AOJlBi95+cdD1+m7njOfI7cD2ln7/4BH/U=;
        b=F3x4WIzYSh/pITQimGw0qfGfN8TOJKRiE5hPvhrkvk8o94NN2Fez7zvi7Rg3sU88mb
         z4ndlWKzvK518Gw8az48DDpTAa/VBbzW44KwUicKK235LtC3fdMvFXIPKrFUJ2qtu4/V
         lc2+jXcHGEjhIgl+1ToZ7PJoOv9GkDZ+obs8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cWwxEDc+AOJlBi95+cdD1+m7njOfI7cD2ln7/4BH/U=;
        b=ftFlInQIXMPiQhKZbS/SsLpnzn77JwibKXAd5W/nNrmCyhdY2RhUGBr6WRbCk6A1wQ
         ukwUC4FXXEePZ9iyTpHTUPFuYCNZB7jPpkbRVHDJtm2Ps83V42TZNesjO5vxmikNizj/
         6f8zoj7f1VPnVO1c+a5DOglsIncfoVI42Ll6np7sMtTDb3Ofv+kyG36dE58vl9Ilpn3B
         ETk9zVZFqfEPogHSbo9xn7Fa2knWZa4P78adghOvRjhE/2STNbYFNUNyfCpzZmu/nU8i
         UkYjxyKBeB2u5SuQ2aklOMwbPvdcx4YSrguUH8Jp/ulZAVUC2X1bMnWM3t3HckxooeIh
         Tdcw==
X-Gm-Message-State: AOAM531rBFxd6LI2XrDNScB4CHMgKh6bQ0Q3+n9pIDFk7/QEPlG8U+nd
        45EOWJq4Empi3bpn58axIUry4W9RKebZ7q10dW0=
X-Google-Smtp-Source: ABdhPJyhx6gCzVZCG3Hl+kx54mEYAP5Ci9/mESzBPXvaXda8aLtQPf0mMVG9LUay8GCJ0Z4kdbT/GQ==
X-Received: by 2002:a05:6512:a94:: with SMTP id m20mr603678lfu.557.1625162685734;
        Thu, 01 Jul 2021 11:04:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i15sm36170lfl.58.2021.07.01.11.04.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 11:04:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d16so13361605lfn.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jul 2021 11:04:44 -0700 (PDT)
X-Received: by 2002:ac2:4da3:: with SMTP id h3mr609187lfe.487.1625162684137;
 Thu, 01 Jul 2021 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210630172529.GB13951@quack2.suse.cz> <CAHk-=whuUxfoYj=dRnzRybg_sOdFPMDx_t06Lz936Pgnh6QCTQ@mail.gmail.com>
 <20210701161941.GA29014@quack2.suse.cz>
In-Reply-To: <20210701161941.GA29014@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 11:04:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiELnOWPLj2g2_JFxEquRXP2GikONXjyeSjv-Mque0Aaw@mail.gmail.com>
Message-ID: <CAHk-=wiELnOWPLj2g2_JFxEquRXP2GikONXjyeSjv-Mque0Aaw@mail.gmail.com>
Subject: Re: [GIT PULL] Hole puch vs page cache filling races fixes for 5.14-rc1
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 1, 2021 at 9:19 AM Jan Kara <jack@suse.cz> wrote:
>
> That being said I don't expect the optimization to matter too much
> because in do_read_fault() we first call do_fault_around() which will
> exactly map pages that are already in cache and uptodate

Yeah, I think that ends up saving the situation.

> So do you think the optimization is still worth it despite
> do_fault_around()?

I suspect it doesn't matter that much for performance as you say due
to any filesystem that cares about performance having the "map_pages"
function pointing to filemap_map_pages, but I reacted to it just from
looking at the patch, and it just seems conceptually wrong. Taking the
lock in a situation where it's not actually needed will just cause
problems later when somebody decides that the lock protects something
else entirely.

             Linus
