Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72831217948
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 22:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGGUYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgGGUYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:24:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEDC061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 13:24:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so38276355ljm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XqDOhPELSzMgZFeHVQzNLAfVHgv7dPOLnk5RnzM4P4=;
        b=LY4FvMZzILikh15a8T4+gZcC0iBGtJIHSCWGKPXPFccoqV7BkYRThzmBYw+Gn++IR0
         KDHlg9I55kRP3bn6OA1SY3gKt8aJQqmugf/5wZuoWhDeEEHYDWHOD/dvGo2Wt9x4Qui/
         iilyA/ngA43BVbE72OqjP1/UYdQ3shqLk3Ktc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XqDOhPELSzMgZFeHVQzNLAfVHgv7dPOLnk5RnzM4P4=;
        b=cVC3VZ3BCG0yg0vWxO6F4WueRkwuoZFANkdpBfAVlU6bwRkxuFni+HqV8TNm8Fgsbi
         JJjKkHhFRTglIlYwbUNzy9z1INozxTUAIiqzhsth2nDQy3hgofmrU0upSFnPC4sY0meZ
         f7OSNrrOnp2p4bQCc9XiiC3aFeo6d4t+fU5RdcfdjvJ2U/4nIwO6/SOxAHloR9ag2aQ9
         a++vM6yR+C7o5Lkv0zNDlnonbUZ8ox30dMNFLsF4doAQQ/zeSrQtF3a1EUZvp7HgSzmp
         560lMKrXRTFRkMpDfu6/HpxGASC2FvJh5TR6LAAmd54Yj+XP5ZYiNnj0A5qZPHbzsdoI
         eAWQ==
X-Gm-Message-State: AOAM532PeU81ZCP/oWaZ2ETgkDFV+FTlF64THa0vcSpqfv+4/KU5G/HJ
        x+aTcm2NYRUfywOcabi45ZqkW8iWyqc=
X-Google-Smtp-Source: ABdhPJz4E6h8PizUBAYp7dQgYN6ER5+T3IwEjWu+CEuG5RGvcI3P7SS1pNs+0mlHTQtCDoteeWpAig==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr25760813ljg.344.1594153458945;
        Tue, 07 Jul 2020 13:24:18 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m10sm431107lji.72.2020.07.07.13.24.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 13:24:18 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id s9so51480572ljm.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 13:24:17 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr30598178ljj.102.1594153457543;
 Tue, 07 Jul 2020 13:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707174801.4162712-1-hch@lst.de>
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jul 2020 13:24:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
Message-ID: <CAHk-=wib3BP9AoFzhR_Z0oPRwx7vkcS=zsDuUmx0FbCrtia7CA@mail.gmail.com>
Subject: Re: stop using ->read and ->write for kernel access v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 7, 2020 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Al and Linus (and Stephen, see below),
>
> as part of removing set_fs entirely (for which I have a working
> prototype), we need to stop calling ->read and ->write with kernel
> pointers under set_fs.

I'd be willing to pick up patches 1-6 as trivial and obvious cleanups
right now, if you sent those to me as a pull request. That would at
least focus the remaining series a bit on the actual changes..

           Linus
