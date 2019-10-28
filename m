Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AD9E7211
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfJ1Mrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:47:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37454 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfJ1Mrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:47:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id b20so7694564lfp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43kMuxdcCYrw75OLEIGgvwzIRnKZbO0/qUIAHUs9fjA=;
        b=cSff5S6yI6dM9Egn5nfRqiok4k+70KNtQ3WNH3IFY088k4NXJ0NPflQG3OPr/taxkR
         xUEu/NkPtLE3zKEmQ7IjUCeeOc/9Hp5IaxSHYqvykCfrbI+eUodqR/b3+Jt0SEG2pKNN
         mNt1URIKmIq+awJoY+ucdy0NXoIrExTx+dTRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43kMuxdcCYrw75OLEIGgvwzIRnKZbO0/qUIAHUs9fjA=;
        b=Q9wUTug0gOzcpJi4GDe7ktyStIxaNMAaIW5r3lP/duDjClE+OZebXkqJGPioHF9okJ
         K+9EVUXNhAcCE4UEQOkLogsILvDrL1iGeU8FrOs5Zh/SWNNhCEQRAUIA/LEHvV7NiiJp
         cwx8p1XAixWRX6IFkglXAHKsu8xnzvxbB9p7YPU2PDlXpmhgjGLHmTmmizm2n92nUjLF
         o/gSrkm3tbjwiUCGNYxRn6d6eGzEaUcdH0K9neSiCpf+yGeniJHzidEtQPUX/hMbuDfs
         jzdGWl31BQWZpqnmcuAgO4/pc7kW2Ev7Bl8MBtZgv8OgQ7GuukJBdQPGhSunOMI/QEZ9
         HeRA==
X-Gm-Message-State: APjAAAW7St2JUE30HW5/33hHoeS3ZI7rraJfkNdIKwFT7jdnKGm1NBG2
        sNgEStzQtUIJWwgxs87AuHlvOKMwjt97lw==
X-Google-Smtp-Source: APXvYqzH+tUyde57+c/LWD2iTXXR9Rss1NCXphex88aE60OrwJZh6zS15I/bHhyW0TupFiObmiEuSQ==
X-Received: by 2002:a19:9202:: with SMTP id u2mr11254148lfd.1.1572266855282;
        Mon, 28 Oct 2019 05:47:35 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b28sm2280991ljp.9.2019.10.28.05.47.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:47:34 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s4so10302889ljj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:47:33 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr11792488ljp.133.1572266853717;
 Mon, 28 Oct 2019 05:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz> <20191028124222.ld6u3dhhujfqcn7w@box>
In-Reply-To: <20191028124222.ld6u3dhhujfqcn7w@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:47:16 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
Message-ID: <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 1:42 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I've tried something of this sort back in 2013:
>
> http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com
>
> and I've got push back.
>
> Apparently, some filesystems may not have valid i_size before >readpage().
> Not sure if it's still the case...

Well, I agree that there might be some network filesystem that might
have inode sizes that are stale, but if that's the case then I don't
think your previous patch works either.

It too will avoid the readpage() if the read position is beyond i_size.

No?

               Linus
