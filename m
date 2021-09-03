Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA54002A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349750AbhICPxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349726AbhICPxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:53:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13357C061575
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 08:52:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h1so10252249ljl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kr5rIfOe6Hwe2+y+jDes91fVUZ+f9S7J89384UtJgA8=;
        b=N8R50bKnZffPltj2pL6sAt/boekXEIz4AQ9Z/o/XuD4vPBxfG3r/2QGNeC3Td8/XlQ
         R0kZIgMPO8AoZ5aHXt7NM2HAmls86mjYLAHi42E+wudU8oKf8/JE6qalzvKuxXxORS9D
         NAlDdP45oLxOK+MFKC/0wdIbO7rTVRb8fcucQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kr5rIfOe6Hwe2+y+jDes91fVUZ+f9S7J89384UtJgA8=;
        b=Fc9HIAmH3J9ra8XOXJl/ZkTiDsmmI2+mzj4+xnJhXjJCPiSjhIAC9C78suJFQ2GktL
         vzbDTHDb1hVUj/XAjHuipCgYuEXzbWCf+ucqQ+IUzdk9du0yjfkB2hVS7pZ+RIMRKHmI
         2wXoyMNKZYkIEDyA6XYr+KDQOkBNeHoW9ClaXXTNdVTKj0z69V33EU/W/ddhfXwztHIx
         DwR2Y5I+dN8FAeivazRLE6pru2sPlB3MgJcZ50BHMruLpEagJE9EIqTfh6kmnvCvk3HA
         4u9LjVbdMujw5Ght5dZrKMeUlitoJ+utLuinoqHPw2vJGrOPrj3fcXEPR0C2R+e60UjV
         yXIQ==
X-Gm-Message-State: AOAM532bXFOjLQvDy8q8yS3coh3Gyz44uTJIvJzHWD+HpPOupvv9NMEL
        0EjAi9PWIkJtARa566NWJSaNKy7ARBxcEXUw5X4=
X-Google-Smtp-Source: ABdhPJwDMGIIfgzXZZraNikpXmjMC9R4Z0uXkOIUGYbeMLnNMQlVComtIRTMoNGTo+MEJQmc651cwA==
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr3502146ljp.312.1630684338261;
        Fri, 03 Sep 2021 08:52:18 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n25sm615224ljj.42.2021.09.03.08.52.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 08:52:16 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t19so12584534lfe.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 08:52:16 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr3415205lfv.655.1630684336092;
 Fri, 03 Sep 2021 08:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
 <CAHc6FU7K0Ho=nH6fCK+Amc7zEg2G31v+gE3920ric3NE4MfH=A@mail.gmail.com>
In-Reply-To: <CAHc6FU7K0Ho=nH6fCK+Amc7zEg2G31v+gE3920ric3NE4MfH=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 08:52:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUs8qy3hTEy-7QX4L=SyS85jF58eiT2Yq2YMUdTFAgvA@mail.gmail.com>
Message-ID: <CAHk-=wjUs8qy3hTEy-7QX4L=SyS85jF58eiT2Yq2YMUdTFAgvA@mail.gmail.com>
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

On Wed, Sep 1, 2021 at 12:53 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> So there's a minor merge conflict between Christoph's iomap_iter
> conversion and this patch queue now, and I should probably clarify the
> description of "iomap: Add done_before argument to iomap_dio_rw" that
> Darrick ran into. Then there are the user copy issues that Al has
> pointed out. Fixing those will create superficial conflicts with this
> patch queue, but probably nothing serious.
>
> So how should I proceed: do you expect a v8 of this patch queue on top
> of the current mainline?

So if you rebase for fixes, it's going to be a "next merge window" thing again.

Personally, I'm ok with the series as is, and the conflict isn't an
issue. So I'd take it as is, and then people can fix up niggling
issues later.

But if somebody screams loudly..

             Linus
