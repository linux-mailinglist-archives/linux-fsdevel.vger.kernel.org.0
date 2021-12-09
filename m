Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958D246E093
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 02:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhLICC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 21:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLICC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:02:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D20C0617A1
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Dec 2021 17:58:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n26so4057674pff.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Dec 2021 17:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1T5kw0pZcNts8FOP/PfwU4eyj9hIko4e2Jf8qhaR54=;
        b=Am1lWsGbBD8k6Gs6ODuIUg2RL/OgQkiCvVyy+TGCnSjjaya/C4UIEKYczYZJInND5q
         NEzMQSYXefk8ofo6cX1eYWFf2M2u+mDOgvBGYc3A6CY5UsLMIfWle8rnVwAT/EMp+XMg
         ifeiXM1HzJSNTrIpPCZCNL4yKEhvyICcW2qRrW0Lm7Mv9lRiMb9GjV7EfoQri/pY4miw
         BX6KoiLnmZel7/Tf1dRQguVFSpFyshdj4rnQrdiNlmyR8RTeMPZtRbV39xo3Uw5kv6Kn
         rycicUNV+7xlGGVNkkM0OfwBaIMyB6/tQG+z5NoPSHzta5JiglKPceqAoC+2B9Qd6s/L
         NjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1T5kw0pZcNts8FOP/PfwU4eyj9hIko4e2Jf8qhaR54=;
        b=kYMepgXHOSzKzH2zRlbI0Aii7uAiW6IOLdzuqv9nVXaKiAZ9zO/BcWicDFUmQ6qOGQ
         3mIB6/hiyuHNOQteD8U35mAycXwrmiVzqy50llw6mvyigKYlJEmsI7dPB5KKQCLVqKWq
         aRy18aaKbvb4TmkmLMpCtKrUnp9+3k9wkKfGNQtj5DkKhBDvbxz5lmZ/G2ALRLuvksw7
         Pxmom/F4apI3WAb8P9bcCJD3IKAPrCeXj2dG/GXxkT+bfhGL5fQF7GdBBDfyJpWl0oCo
         IWYwK6gDE8bmbttaalg214xN61+fEHVxczByYoB5GofEJe7qtMwo4WY6Vy/orCbvCTWs
         ofDQ==
X-Gm-Message-State: AOAM533MNP7i43vrdxuGMUyaEwB5FYGukbvz3O1dM811tgW4LySJf32z
        79gLK3d2ggUpNxdpKNfl8Y8z0p79Vxcn6qi7aBHgrw==
X-Google-Smtp-Source: ABdhPJzAnoM9tgR/eh2HsITyJR3hItduz1eHZo9++I+GO7sFsnQRiKr7UiulUnv9YeK06rwF3wnyl2FTdM1vcsOiXQ8=
X-Received: by 2002:a63:c052:: with SMTP id z18mr29045322pgi.74.1639015135135;
 Wed, 08 Dec 2021 17:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20211208091203.2927754-1-hch@lst.de> <20211209004846.GA69193@magnolia>
 <20211209005559.GB69193@magnolia>
In-Reply-To: <20211209005559.GB69193@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Dec 2021 17:58:43 -0800
Message-ID: <CAPcyv4g3OG3cSpOEm9J1HLZjzRBhSWotSyV5RZxt5FYV_0=Knw@mail.gmail.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a ssize_t
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 8, 2021 at 4:56 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Dec 08, 2021 at 04:48:46PM -0800, Darrick J. Wong wrote:
> > On Wed, Dec 08, 2021 at 10:12:03AM +0100, Christoph Hellwig wrote:
> > > bytes also hold the return value from iomap_write_end, which can contain
> > > a negative error value.  As bytes is always less than the page size even
> > > the signed type can hold the entire possible range.
> > >
> > > Fixes: c6f40468657d ("fsdax: decouple zeroing from the iomap buffered I/O code")
>
> ...waitaminute, ^^^^^^ in what tree is this commit?  Did Linus merge
> the dax decoupling series into upstream without telling me?
>
> /me checks... no?
>
> Though I searched for it on gitweb and came up with this bizarre plot
> twist:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6f40468657d16e4010ef84bf32a761feb3469ea
>
> (Is this the same as that github thing a few months ago where
> everybody's commits get deduplicated into the same realm and hence
> anyone can make trick the frontend into sort of making it look like
> their rando commits end up in Linus' tree?  Or did it get merged and
> push -f reverted?)
>
> Ok, so ... I don't know what I'm supposed to apply this to?  Is this
> something that should go in Christoph's development branch?
>
> <confused, going to run away now>
>
> On the plus side, that means I /can/ go test-merge willy's iomap folios
> for 5.17 stuff tonight.

This commit is in the nvdimm.git tree and is merged in linux-next.
