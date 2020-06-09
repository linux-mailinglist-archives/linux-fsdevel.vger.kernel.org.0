Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8A1F497A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFIWkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgFIWkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:40:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11EC05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 15:40:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so41362lji.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1TRNNjJlvLVpkzYtiyuKXMMAtHYz93D6qUBO+R17NY=;
        b=K1f23i0fqTaybBaIL91PC/uUGVhXSo8qFOrRZ6HkWINEL8dEywUK3T3EhTHBQo1onI
         W2B23FJguSy+2BibfIkn2DkdpPgkPHbOxwkYkGJwdrS+/ZW6LOzw/y+emhKjQsn4I6lP
         cbjUZmLILbknLg40OFWdmE+Q2u7LZ3zRFbcGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1TRNNjJlvLVpkzYtiyuKXMMAtHYz93D6qUBO+R17NY=;
        b=E3+lVX0mTgaRc8s2i5zCQn0RhSnvWg9mKHUC/mjh9XktbIG+/8hTppFliC2a4t1rAY
         7gvOBI9+3uOnVGfH9wPk/d+klrIJyiqSz3C2PaJuifHGYTFRPOGJaRVqxe51lyEKfZuk
         Gj2HgHKllAKqroyS97y5qHc2o0OmvlDvyYIqa8ZnXdvSRUoEumCWIRr6VN3oV6ZX8xHp
         sCfEGP+hSQJNvcOyHrnpc5JVD9+B3HSIJSVjZ4IjCa/s7xcVqjW3mxuCOEZEZ95hopBB
         nJwaW2IHRkSflCnmwmTWMLB5PDgbjGHzHx9I1CseelQWDNZU9DgIfHuLOr23OALJVS6h
         kd3Q==
X-Gm-Message-State: AOAM533DPH6iciDGtA9+QCLJsGQeqdQo2QQRlCsJwz9GpNNZBDYEmxiC
        KFxPOHc13C+AFUC1qmG7zIWe09AC78Q=
X-Google-Smtp-Source: ABdhPJyrtuUIUO4vBowbS/Lk5c9Xk6ofeY+rRb3em0yaVXtHnKSew0h8vuYJd+1S+g/Fp/tHqgdVWQ==
X-Received: by 2002:a2e:8809:: with SMTP id x9mr202391ljh.442.1591742442496;
        Tue, 09 Jun 2020 15:40:42 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q25sm5309755lfb.43.2020.06.09.15.40.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 15:40:41 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c12so268236lfc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 15:40:41 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr73046lfc.142.1591742441027;
 Tue, 09 Jun 2020 15:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <3071963.1591734633@warthog.procyon.org.uk>
In-Reply-To: <3071963.1591734633@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jun 2020 15:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4VjVHkMcALg3T4A+Vwfyo0NBWtPoKwvO8pWe_v=NF6Q@mail.gmail.com>
Message-ID: <CAHk-=wi4VjVHkMcALg3T4A+Vwfyo0NBWtPoKwvO8pWe_v=NF6Q@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Misc small fixes
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, chengzhihao1@huawei.com,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 9, 2020 at 1:30 PM David Howells <dhowells@redhat.com> wrote:
>
> Would you prefer I defer and submit it again after -rc1?

No, I'll take fixes at any time, and the better shape rc1 is in, the
happier everybody will be and the more likely we'll have testers..

             Linus
