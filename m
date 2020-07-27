Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACC22E9B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgG0KDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0KDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:03:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FEC061794;
        Mon, 27 Jul 2020 03:03:19 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j9so9165170ilc.11;
        Mon, 27 Jul 2020 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbcIk9QRVNmTa64FQw2LUqJ0DwejPGC1RXXC9k0XwjI=;
        b=H88LdCbSw6dH961YkMIE7I7REvkthDXLwiokY35x5QKJe+KgovD4xNQNHCYC2B2smH
         hMvJQOZ8f1lzV0rwAT2fZGHlWcciAuUiw4yawOGZb1OgEXBvguPS4Vkvgui/UAvqZeR4
         g1LoiCRi7IrrYF51ggb/CK4qoYdO68669xmNVUxDJbglXy1x+SeOgN1uO6w+U2/YFcHw
         wOJXZKtvoqUG2LBWoZpFJda+vvJoKH8Ms+zt/UZYkMMr5lMb1WSlfcZ8VvxLKIA3RSK4
         xHsaQtMH8I1+rn6MLe+Fr+ryuPLgjKpUd1nbBYmH0nkXH20Aqc3b9V4Ef33XrbFgWLN+
         7cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbcIk9QRVNmTa64FQw2LUqJ0DwejPGC1RXXC9k0XwjI=;
        b=JLoA2JFVGOM7Pa6obJ5M6yebJWdy2oghB1t2t4zG3nSfXUmuJe5Q/8DOSRmtKf6G/F
         cAI1+25z5Abv/pfB3ExqPiqTYu7bVusAHeSFkEBOMiLDZfGlL9Z3fv3i6B9bFbJY6md6
         9f1++7WIUj/6T5DzGGg+p28FTTEu6ZazNuTXh9spvPEmdjIzscfTraoEud2noZBJvqKU
         U3q+QLanmgitDuGlTkQ55U+khb3fEyESGmQ/gmFz2PUpqk2nB/8k/SYgIOEPlC9VatN2
         FmefpfDZss5JiaWd6X1Qa+SgS+BjROgtVhUC75QCnGHqMhGXHv5yRAM7y+vFQDSYO/e4
         wwBw==
X-Gm-Message-State: AOAM531uql5L497t1JiLfDujs3Kz0mJs1vih6XKSIWLTUV3UnX92jziD
        z5jrBeoMBRXeN7AJgJCgBOBUfNJM7BPNGaVx66ewNz62
X-Google-Smtp-Source: ABdhPJxJSBcMJciRLSTi9EnWlJPB63Ai95H7UpZj0ExgEiiivXRREnUn9J5JqqB/sEzaPW4V0p/djZBaW8EAeKmCTjE=
X-Received: by 2002:a92:730e:: with SMTP id o14mr15302562ilc.203.1595844198388;
 Mon, 27 Jul 2020 03:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200726145726.1484-1-laoar.shao@gmail.com> <20200726160400.GF23808@casper.infradead.org>
In-Reply-To: <20200726160400.GF23808@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 27 Jul 2020 18:02:42 +0800
Message-ID: <CALOAHbBVK2qK0y3vtU7VgxaWOGTk1VAV_k9LSgGcXgy85dJDhQ@mail.gmail.com>
Subject: Re: [PATCH v3] xfs: introduce task->in_fstrans for transaction
 reservation recursion protection
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 26, 2020 at 10:57:26AM -0400, Yafang Shao wrote:
> > Bellow comment is quoted from Dave,
>
> FYI, you mean "Below", not "Bellow".  Dave doesn't often bellow.

Ah, thanks for pointing that out. I often make that kind of misstake.

>
> > As a result, we should reintroduce PF_FSTRANS. Because PF_FSTRANS is only
> > set by current, we can move it out of task->flags to avoid being out of PF_
> > flags. So a new flag in_fstrans is introduced.
>
> I don't think we need a new flag for this.  I think you can just set
> current->journal_info to a non-NULL value.

Seems like a good suggestion.
I will think about it.

>
> > +++ b/fs/xfs/xfs_linux.h
> > @@ -111,6 +111,20 @@ typedef __u32                    xfs_nlink_t;
> >  #define current_restore_flags_nested(sp, f)  \
> >               (current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
> >
> > +static inline unsigned int xfs_trans_context_start(void)
> > +{
> > +     unsigned int flags = current->in_fstrans;
> > +
> > +     current->in_fstrans = 1;
> > +
> > +     return flags;
> > +}
> > +
> > +static inline void xfs_trans_context_end(unsigned int flags)
> > +{
> > +     current->in_fstrans = flags ? 1 : 0;
> > +}
>
> Does XFS support nested transactions?  If we're just using
> current->journal_info, we can pretend its an unsigned long and use it
> as a counter rather than handle the nesting the same way as the GFP flags.
>


-- 
Thanks
Yafang
