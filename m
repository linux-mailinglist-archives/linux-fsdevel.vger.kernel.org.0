Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02581269A90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIOAms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgIOAmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:42:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D01C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 17:42:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u21so1251478ljl.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATHwcW6LeBolsSmQRf1n5otymPUivLo7weJoK55YMQ0=;
        b=L3jP3fpL6qkMWaIPqY0+H0/1FuyKQ5yoyw7GLTjvRKty6/6v5NPUTny/UzVB/w8OCr
         4/YCnPjjsk3j6dbhCaPM4zMVOcd/psYkveNin6exfkrrGCbtWAXZuJDTY8J8ZNCLNrFu
         zZQqxFq9o9G4oplkuVIEvbo3TJLnbu6GPeteM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATHwcW6LeBolsSmQRf1n5otymPUivLo7weJoK55YMQ0=;
        b=Asu9HgvRyxC1ddrbnCJeobZEpqx2Orv9/8uTL5sXywNmZGxAJKpbXgt3LVwb7GrrZk
         BgjBy36Iz/ogcjqvWR+rGG+6jGN91CDapw8YWhfZepceIErJawIbKFYvLD+UwDA5wxBV
         qqoShaAE7rxgULiE0uhfsPSN2GejvUgQeSNkpfbJoLb965hzCVBeLlq2gM6ich+CgkJj
         p94+qw8UbZpd0KfQi4uD+AxozUa5zbQ6sY1an1zcyKYune8Ytilvpl7Pm/rHUMrWHLCm
         6xd/jXbJAoM/s8hRst9VRgxMxY56DxVgSK0LgSqCXz4Tdv0w527D8kSC7Geg8X0BArDB
         bfww==
X-Gm-Message-State: AOAM531BNmPug1TVuTd+Jz/sUXUn0c7aJ4gwBLn1ya5+vw2eI2Umwh86
        Am51nTlXMxLTj0GzxMzciGgJG9yyATfv7g==
X-Google-Smtp-Source: ABdhPJyy/u+hWRBScWRtd/fcvkXGRIjtizcsqKJoswk7nD7msw0ERRy3jpp0xcSHqbFbpvWEWup3Xw==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr5573456ljc.328.1600130557067;
        Mon, 14 Sep 2020 17:42:37 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b7sm4333243lji.121.2020.09.14.17.42.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 17:42:35 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m5so1229790lfp.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 17:42:34 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr5487901lfg.344.1600130554524;
 Mon, 14 Sep 2020 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
In-Reply-To: <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 17:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsUtTRWT6kXxw6f2xpS4W=7iO6k2rJfhpLa6yFZ-b_1w@mail.gmail.com>
Message-ID: <CAHk-=wgsUtTRWT6kXxw6f2xpS4W=7iO6k2rJfhpLa6yFZ-b_1w@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 1:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> One way I can see that happening (with the fair page locking) is to do
> something like this

Note that the "lock_page()" cases in that deadlock example sequence of
mine is not necessarily at all an explicit lock_page(). It is more
likely to be something that indirectly causes it - like a user access
that faults in the page and causes lock_page() as part of that.

                    Linus
