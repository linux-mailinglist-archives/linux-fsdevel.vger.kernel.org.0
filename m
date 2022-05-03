Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48C51912A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 00:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiECWTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 18:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiECWTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 18:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0782B3EA86
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651616161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+m2HgviktRF7+FLg8goUykshnn/6YyM7aMOuMI2GmY=;
        b=I7W5GRNVVCWkgoIquD8H2TyaeFhhHyLcSBgnb57FA+hOlja16j1MKJmA3kx/cuKvT8qWEo
        W448/vI78qZaEstk9QTSkGH6itNu6G2YVdlFGH1Z0GgPeBf7eS4/IK5ZZdU7lViRV+A1Jp
        eDQaEcUWbf/LJ323lRHiWn2F0urHpLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-d3nshr0SOna_-gz0_fe6mQ-1; Tue, 03 May 2022 18:15:58 -0400
X-MC-Unique: d3nshr0SOna_-gz0_fe6mQ-1
Received: by mail-wm1-f72.google.com with SMTP id p13-20020a05600c358d00b00394586f6959so206922wmq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 May 2022 15:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+m2HgviktRF7+FLg8goUykshnn/6YyM7aMOuMI2GmY=;
        b=o2NnOxJNL4S/Q6jW40kPbftkXxI5AVBcp6EZVy1SUVUJTF+y29f3EgnfUy5+Syaikk
         IgbIKKTNil2HmtjfFDmC4Z4w2Q3oZrIKhoFR81qB7N5xj7k4yT49IWxfl6C9S/F/7vxd
         Mi9t5b7wccB7fqhnilcJ2lvqobacd4WYo3CmqAk7nas8eFT4GJHpDPb790svTOWFvRgr
         lwHmne5l8mqtAVVr8jEDgC7HkW3q6VUQ/jujkzSFMQHebOm4Y7sX4p7BEkMpWKzIfOuP
         UD/44BzaoOBGu2mUVAiRoLx6sR9M1q2mN0Iw0SS4QfMh9Xn/5gdXs8/6SUjQ9D/XAUvI
         vvPQ==
X-Gm-Message-State: AOAM531BlBcoBwAoGlaJdWGaM8cN6SVcTtdCvEUMBKrFpIygNUIETUQy
        aq3KnsPkpxYT+wvoaYQfMLcrGiPR5E021c9slTOOVLtSDeivGm4oOkwryFnAMVKz9ABnByuo79N
        DutDjDtnOyGV+zVDWXj20f/ptAmL/fHnt0ctNXyO1qQ==
X-Received: by 2002:a5d:5547:0:b0:20c:7a44:d8e7 with SMTP id g7-20020a5d5547000000b0020c7a44d8e7mr2669718wrw.349.1651616156776;
        Tue, 03 May 2022 15:15:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL53Ke/vMFevWvEj+93LosE7xTi3VcEpQe/7CC8eovlyg0cDTCp1nV8tksVq6NS6fQ3BiB3qNeWVMEA7a4a10=
X-Received: by 2002:a5d:5547:0:b0:20c:7a44:d8e7 with SMTP id
 g7-20020a5d5547000000b0020c7a44d8e7mr2669709wrw.349.1651616156627; Tue, 03
 May 2022 15:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503213727.3273873-1-agruenba@redhat.com> <YnGkO9zpuzahiI0F@casper.infradead.org>
In-Reply-To: <YnGkO9zpuzahiI0F@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 4 May 2022 00:15:45 +0200
Message-ID: <CAHc6FU5_JTi+RJxYwa+CLc9tx_3_CS8_r8DjkEiYRhyjUvbFww@mail.gmail.com>
Subject: Re: [PATCH] iomap: iomap_write_end cleanup
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 3, 2022 at 11:53 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, May 03, 2022 at 11:37:27PM +0200, Andreas Gruenbacher wrote:
> > In iomap_write_end(), only call iomap_write_failed() on the byte range
> > that has failed.  This should improve code readability, but doesn't fix
> > an actual bug because iomap_write_failed() is called after updating the
> > file size here and it only affects the memory beyond the end of the
> > file.
>
> I can't find a way to set 'ret' to anything other than 0 or len.  I know
> the code is written to make it look like we can return a short write,
> but I can't see a way to do it.

Good point, but that doesn't make the code any less confusing in my eyes.

Thanks,
Andreas

> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 358ee1fb6f0d..8fb9b2797fc5 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -734,7 +734,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> >       folio_put(folio);
> >
> >       if (ret < len)
> > -             iomap_write_failed(iter->inode, pos, len);
> > +             iomap_write_failed(iter->inode, pos + ret, len - ret);
> >       return ret;
> >  }
> >
> > --
> > 2.35.1
> >
>

