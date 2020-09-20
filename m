Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E05D27189E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgITXkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 19:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgITXkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:40:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DFDC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 16:40:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m5so12021503lfp.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDYTO6ZHAocBqDq8dENc7+9/1NYi0FO0+BjnujPaGI8=;
        b=JhDrBz4VpfnwLwexhSfCra/1ljR+0DDuhhSmlK485+9M4Na6YRzV375YZRt8ot7FoR
         txVEzV4FjQhUG1H2jkoLuvnO/1KJqe+mlHoMYZtxOQIBTrhesN0I421m31sdB07MvhLV
         GRmW/3mZz0d3TLrvySNRdpKtqcWatAyZd4SpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDYTO6ZHAocBqDq8dENc7+9/1NYi0FO0+BjnujPaGI8=;
        b=Cbx9mempzZiwMr4HGgXmlKKEPzyLcUS43u3rN8VpXkHscUc+Ktm/WeJdYvwz9PWNUw
         ncCrDh8jJZ8F1Vpp9HQiNp5X0KyXs+8K6WXVXpcYnI8gEmaf81ug+B1tPYC3YUySbOPk
         dfvu+WZroDlrVwApSpUen1y/4cOe9zfgKoOeWnsNwzZ5R0dGXEbICf1jG+3d2G39J1Nm
         D1U/Rf6BGOBbicFG+udKXGqX5zaYE4blBn58X+Tl04BT+Q6z5Aem9JxWyth7k4o2oscO
         z2FDxn/72zRUER8LVISl4z4x5JTQdqCMTIePTb6EzfZLuQ6+KGtRBzPxot+qGkakW+yR
         R6xQ==
X-Gm-Message-State: AOAM533nM02bszeS5hoheZFbU0HVY9db4SwLuauNqIy17RlMGQ28E2En
        6r2m8l8Vvr+cXBgzHeE9Y0kp+v/6cZSdqw==
X-Google-Smtp-Source: ABdhPJwJdCIg8g6nrllrxQp7Ma2m6TGE+Oxp1AAWNN/9eUXpz+7AgMPOs/HrpNXaWpljfh2naN/WFA==
X-Received: by 2002:a19:c788:: with SMTP id x130mr13092698lff.553.1600645239905;
        Sun, 20 Sep 2020 16:40:39 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v13sm2137953lfo.30.2020.09.20.16.40.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 16:40:38 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y2so12001718lfy.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 16:40:37 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr12864272lfr.352.1600645237669;
 Sun, 20 Sep 2020 16:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200912143704.GB6583@casper.infradead.org> <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <20200920232303.GW12096@dread.disaster.area> <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
In-Reply-To: <CAHk-=wgufDZzm7U38eG4EPvr7ctSFJBhKZpu51wYbgUbmBeECg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 16:40:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKR51JXc3LQoZ2qpJSJ9qKx7jDes9yRQgxWbddG0hPLw@mail.gmail.com>
Message-ID: <CAHk-=whKR51JXc3LQoZ2qpJSJ9qKx7jDes9yRQgxWbddG0hPLw@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 20, 2020 at 4:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And if we do end up doing it at both levels, and end up having some of
> the locking duplicated, that's still better than "sometimes we don't
> do it at all", and have odd problems on the less usual (and often less
> well maintained) filesystems..

Doing locking at a higher level also often allows for much more easily
changing and improving semantics.

For example, the only reason we have absolutely the best pathname
lookup in the industry (by a couple of orders of magnitude) is that
it's done by the VFS layer and the dentry caching has been worked on
for decades to tune it and do all the lockless lookups.

That would simply not have been possible to do at a filesystem level.
A filesystem might have some complex and cumbersom code to do multiple
sequential lookups as long as they stay inside that filesystem, but it
would be ugly and it would be strictly worse than what the VFS layer
can and does do.

That is a fairly extreme example of course - and pathname resolution
really is somewhat odd - but I do think there are advantages to having
locking and access rules that are centralized across filesystems.

               Linus
