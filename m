Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462274F74B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 06:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiDGE2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 00:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiDGE2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:28:04 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB95E159;
        Wed,  6 Apr 2022 21:26:02 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id h7so3074104uan.4;
        Wed, 06 Apr 2022 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzyMjesxZrkAFOB6DXZrDGwnfcNbPaMjKymwklBUkhg=;
        b=bBlnksobnNuVqb1lJSZBEikWKn0QnbqnyoWc8tn/yYpawolkxbsPXp75oMXMM3jB0x
         lz76wTi/i95MtZa6WUC/fEzeFzkuyvHICKzTx2HgkwMkwug2BVpD8VMiVgqR16ZYWVvb
         xXtd4S2jIBgPSFLk0yQmcHlXPk+03y7DyVcMeDORgsfWgw0RoG88z//Mk9yxZk+Fj56w
         +v6JFkQ3X63htBVUzOQHfyJNA9yL49cW7V8vanIzGs3mgzHJJRC7dM/sfmujnDEnysTh
         Fxo7iN2poGhN7hqvHMuWUlIxTjWcOxwzga84nwQjaU3nFSUtdwUKrBgY71SUMXoMKy7B
         AZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzyMjesxZrkAFOB6DXZrDGwnfcNbPaMjKymwklBUkhg=;
        b=ETlyHjnQT8T4YHC4fbwebXoP7A5gzAg1Sutb2Vriu3Xr3HFrROOI6M8hDaP9s2hy/w
         h4jOKJUWJPE7HOD3yHOxZIx1HiQB2u7uOkd47acCpqJUWl9qJwLllpuioENn1MR3xZsv
         YRHqzahNzJ4kfZ33AYEPo4qekxhIJwc5ynv/l2yJfzfwXbz5OlQjrk2nZhQrSyr2vR3N
         Yn3TZPNsYbHecVPqkzLXwNfoaDyIRENspc5pfjC2vXrf8T/vp1UFbBFl/A9Q4iM0em3P
         7C7TwyZGnBn2XC/bHZiek1YKRG3Td8XMIGE/jUg9BkvI+bqKmzP74bXse2I2BV6E7lEG
         1jYQ==
X-Gm-Message-State: AOAM530e4PryQrF1AAJfPmctp7FfxeNIsdiRlFvxGhkiT7c276PwJUzF
        iMe/OlPCUramowp6Kh93cNUCj5/O4/fvth5ldJtnhu27KtU=
X-Google-Smtp-Source: ABdhPJx/B2frk/TmaPzK1fHRk6zyCRzDsnUQtuYpFVwPiWeuW5ya0fj7g4a6WE3i5ToSqfdmeneldXBq5WwO3tdQPuo=
X-Received: by 2002:a9f:2046:0:b0:35d:bfc:2c9 with SMTP id 64-20020a9f2046000000b0035d0bfc02c9mr74389uam.119.1649305561699;
 Wed, 06 Apr 2022 21:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com> <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
In-Reply-To: <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 7 Apr 2022 05:25:49 +0100
Message-ID: <CANe_+UhOQzGcz9hsKdc1N2=r-gALN6RK-fkBdBkoxD+cv1ZFnA@mail.gmail.com>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
To:     Hugh Dickins <hughd@google.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Apr 2022 at 01:19, Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 6 Apr 2022, Chuck Lever III wrote:
>
> > Good day, Hugh-
>
> Huh! If you were really wishing me a good day, would you tell me this ;-?
>
> >
> > I noticed that several fsx-related tests in the xfstests suite are
> > failing after updating my NFS server to v5.18-rc1. I normally test
> > against xfs, ext4, btrfs, and tmpfs exports. tmpfs is the only export
> > that sees these new failures:
> >
[...]
> > generic/075 fails almost immediately without any NFS-level errors.
> > Likely this is data corruption rather than an overt I/O error.
>
> That's sad.  Thanks for bisecting and reporting.  Sorry for the nuisance.
>
> I suspect this patch is heading for a revert, because I shall not have
> time to debug and investigate.  Cc'ing fsdevel and a few people who have
> an interest in it, to warn of that likely upcoming revert.
>
> But if it's okay with everyone, please may we leave it in for -rc2?
> Given that having it in -rc1 already smoked out another issue (problem
> of SetPageUptodate(ZERO_PAGE(0)) without CONFIG_MMU), I think keeping
> it in a little longer might smoke out even more.
>
> The xfstests info above doesn't actually tell very much, beyond that
> generic/075 generic/091 generic/112 generic/127, each a test with fsx,
> all fall at their first hurdle.  If you have time, please rerun and
> tar up the results/generic directory (maybe filter just those failing)
> and send as attachment.  But don't go to any trouble, it's unlikely
> that I shall even untar it - it would be mainly to go on record if
> anyone has time to look into it later.  And, frankly, it's unlikely
> to tell us anything more enlightening, than that the data seen was
> not as expected: which we do already know.
>
> I've had no problem with xfstests generic 075,091,112,127 testing
> tmpfs here, not before and not in the month or two I've had that
> patch in: so it's something in the way that NFS exercises tmpfs
> that reveals it.  If I had time to duplicate your procedure, I'd be
> asking for detailed instructions: but no, I won't have a chance.
>
> But I can sit here and try to guess.  I notice fs/nfsd checks
> file->f_op->splice_read, and employs fallback if not available:
> if you have time, please try rerunning those xfstests on an -rc1
> kernel, but with mm/shmem.c's .splice_read line commented out.
> My guess is that will then pass the tests, and we shall know more.
>
> What could be going wrong there?  I've thought of two possibilities.
> A minor, hopefully easily fixed, issue would be if fs/nfsd has
> trouble with seeing the same page twice in a row: since tmpfs is
> now using the ZERO_PAGE(0) for all pages of a hole, and I think I
> caught sight of code which looks to see if the latest page is the
> same as the one before.  It's easy to imagine that might go wrong.

When I worked at Veritas, data corruption over NFS was hit when
sending the same page in succession.  This was triggered via VxFS's
shared page cache, after a file had been dedup'ed.
I can't remember all the details (~15yrs ago), but the core issue was
skb_can_coalesce() returning a false-positive for the 'same page' case
(no check for crossing a page boundary).

> A more difficult issue would be, if fsx is racing writes and reads,
> in a way that it can guarantee the correct result, but that correct
> result is no longer delivered: because the writes go into freshly
> allocated tmpfs cache pages, while reads are still delivering
> stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.
>
> But unless someone has time to help out, we're heading for a revert.
>
> Thanks,
> Hugh

Cheers,
Mark
