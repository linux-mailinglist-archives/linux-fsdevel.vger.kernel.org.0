Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663AC435461
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 22:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhJTUN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJTUNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:13:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922AC061749
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 13:11:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t9so308363lfd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mjyTuiMt0G/NI9j2uGhr176LQ8tHUDaZsPCBpnXywo=;
        b=JNYtSv2gblmlTKXiqtL4y6TtoOuGzc68cZHueN9cP+lj++0rs+VLST38HhlFDoPg2f
         q/iXqIc7waXQwRes5r5w9NeAF++++Ur7bf/OJfMU2qanF+BgkZ215gZA/vba1jIbqtrg
         YKY42GAegLHMretczDWyIsPvSaAr/LVgePt/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mjyTuiMt0G/NI9j2uGhr176LQ8tHUDaZsPCBpnXywo=;
        b=ab8eg44Utctk3eGnjFqgn4BYrD4rfWEaLIoHA+2Es+dCHWJSKlRKL8e7GXGgRNT/Qm
         B8EwWuQzK8nfFBhCWQM+mf4gZgzNXQl/k3X6iPfamtHLUa9apvx38gbcQgxVVgAUGnK0
         RkQoEOudKgycwNwFFNSlLtUgRmA7UMPyw9r1o6ewCS3/U8SthVCASiNbtOZMdrO0cp8B
         wElbcVz+yfnPeSIYshweE+hdgjcmlayRhKw5707Xd1rJfPgi1CLLr0GdlKG8R7pT3khq
         It8eWxBQ9PDfvWsTcgB3K6/iiS5KPr2WlGZDpg1bSzCsZc6jVAiX55YCRfQsJU/sECEM
         dj/A==
X-Gm-Message-State: AOAM531jwTdaFIAI5iCRa8rqlTGq1LtR62rXRa6SUt79nriIfKnagjSe
        qj8KxKOc0v2ed/w3OcIS17GbvMc60acaqLzA
X-Google-Smtp-Source: ABdhPJyZfpN6zYalq+MGHZ9RL3KipJkA7Fgbz/Wp+voDDbf9llp4UtFqhj31cowpJHU/Bw56b4O63A==
X-Received: by 2002:a05:6512:22d2:: with SMTP id g18mr1324447lfu.456.1634760698711;
        Wed, 20 Oct 2021 13:11:38 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s11sm266619lfd.262.2021.10.20.13.11.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:11:36 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o26so296585ljj.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 13:11:35 -0700 (PDT)
X-Received: by 2002:a2e:9945:: with SMTP id r5mr1210626ljj.249.1634760695569;
 Wed, 20 Oct 2021 13:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
In-Reply-To: <YXBFqD9WVuU8awIv@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 10:11:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
Message-ID: <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 6:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> The atomic "add zero" trick isn't that simple for MTE since the arm64
> atomic or exclusive instructions run with kernel privileges and
> therefore with the kernel tag checking mode.

Are there any instructions that are useful for "probe_user_write()"
kind of thing? We could always just add that as an arch function, with
a fallback to using the futex "add zero" if the architecture doesn't
need anything special.

Although at least for MTE, I think the solution was to do a regular
read, and that checks the tag, and then we could use the gup machinery
for the writability checks.

                Linus
