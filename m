Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF03F9D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 19:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhH0RRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhH0RRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:17:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h1so12619672ljl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j79aTkkV7QWLMRm7gv45CG9ALkTrZZR1j0Lx/8G3d6o=;
        b=fj/ZxCs8ur2rBha43Ay0HYB7+91H8QbKZzf8dL12yK9YzzNVZrCZbQRf5t7oQpJsoI
         Wgz8k7xy+geN1KnmohU7DOJais9Vhl6IrRuWDBIc20zyIyuMKAlU0hx94AqlBsRcWyd+
         95xQ+kewg4rcEfCorLbNVHCfZaK90xSHRzBSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j79aTkkV7QWLMRm7gv45CG9ALkTrZZR1j0Lx/8G3d6o=;
        b=S81kC7CBkHgL9GCTRDS5PercqXR2MpYdJI0nP9Lp93f+2jRpz6XuopNnbfyPDyXw5f
         He/CwjJkPNpd+qOdo+I9vNMNgv5KrOfPkg1k8fDaXXhNUjIgpjPPjH0RytuYJrsrc+t1
         mxTS8R2nJzL6Sdwl9hZ3g7g2CVe8jmu0hWG6MGdtYtc9u88k1PaMRAm6cBsckCroTZpa
         sQamHWrC6+fNBTSRJA+ja1faKUXlZRJaaZOOZeVuIrDKsD96oQIK3o7ysl9dS29C3mH1
         swp5xqFFvNvjyg/RumZGDXkF52k92ItPEXbsvraxyKggybvV7Jc9JO4pVF79a0lL3gXg
         e3yw==
X-Gm-Message-State: AOAM532wvRpZOR+higiQ6vD1Pg6caWrEnknTH3Ty6ULXWHWFKayAYJVy
        2PqHmNgKZ4gK3F3wkMbG9EgnExZGPYpooQIL
X-Google-Smtp-Source: ABdhPJyBU3cl5hW2QDdVHn6ApqIEaGkRUKCQWh0QVddheC0RiayVTSZFKp8HjKj0T0xVy9iwHqMcLg==
X-Received: by 2002:a2e:a30f:: with SMTP id l15mr8792151lje.153.1630084614503;
        Fri, 27 Aug 2021 10:16:54 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o22sm641722lfu.188.2021.08.27.10.16.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:16:53 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c12so12660760ljr.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:53 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr8318181ljw.465.1630084613565;
 Fri, 27 Aug 2021 10:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 10:16:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
Message-ID: <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 9:49 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> here's another update on top of v5.14-rc7.  Changes:
>
>  * Some of the patch descriptions have been improved.
>
>  * Patch "gfs2: Eliminate ip->i_gh" has been moved further to the front.
>
> At this point, I'm not aware of anything that still needs fixing,

From a quick scan, I didn't see anything that raised my hackles.

But I skipped all the gfs2-specific changes in the series, since
that's all above my paygrade.

                 Linus
