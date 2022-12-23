Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3BF6554DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiLWWFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 17:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWWFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:05:05 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBCE1C435;
        Fri, 23 Dec 2022 14:05:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bp44so2057258qtb.0;
        Fri, 23 Dec 2022 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XOJ5z7kFjWc68B5B6Sh1NWt9teGCI8E34Z2/SZr41S8=;
        b=CaDLvp1QLFx2Hzqz3sPsHWemPlSRGIVm6N0Ga8quwoX390HaGi6C/ooR/jUv1tMncn
         EAHfSzlVh7lg8HE7dlsOVfNt1aRvMKnylga/ihg1jTkePYaOSPOk26xGxzFUN1n+kULd
         31rZLbaBrNcWdfmGI9utk6Jt6MRev80E/G15Yzt63eA9U2dWEwNtaqsWq/B3UuPMhjDw
         QNmanZbagRuK/IDoRljUMi2u8Gml6zKNvOK9DkEgqLmRIEHvHZIvj0vApRbArdAb0OtN
         kL85EmMcMOM1LTnJBA0ann4v1DzewhMieom0TfuLVs0sXLxUqRVZt8otJPdK943rUnIk
         SvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOJ5z7kFjWc68B5B6Sh1NWt9teGCI8E34Z2/SZr41S8=;
        b=cgaCEcMrxFaiixLKBOCFSj2dwJ8zhZ3YwQXabk1VvRkjf2o6HjmOxjTXtaWtVFy418
         ekTGsVrSgI4Ec1QhLDyWsQAdM/VV0PeFkR4YU4Wh7DmO24IwcoaziRmRtBZO5TEK+fXv
         /vRTY7YKJ0uTW/DOQcaYbXrh80B9qNfwWQa1ee/K5zCftEJ2m3ruCQZzLe5faQTtlR87
         OprOx2iZ1C8vavRTZn5uFrOtZMdEW+sjMT2i8myq4y+eqAL93md3mM21mh/N3dCLWFMD
         iXUrZLxGCiAkD6lw/PRtAIPt8fLziLKMetJWechI3Tt7+mm1UFYEVZSWzf3lj3qxf8wQ
         3agw==
X-Gm-Message-State: AFqh2kripjgXQ8S791MlpdKvKPJ3usHDz2S/oZu0B8m731M1r8b0l4RI
        I6iUqousRflBgqRfuQpXllaQRDU+j7R+Bsl6TCwfPKn7orCDYg==
X-Google-Smtp-Source: AMrXdXuipY+SQ8jSfCWfT/V64MUdmK6UvoWduFpm5A8Hx7l02aMdqZw2KCqhbqXafoBpp8zEGiBHF8fUV8HiMG2klj4=
X-Received: by 2002:a05:622a:244c:b0:3a8:12f6:69ff with SMTP id
 bl12-20020a05622a244c00b003a812f669ffmr451928qtb.567.1671833103695; Fri, 23
 Dec 2022 14:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20221216150626.670312-1-agruenba@redhat.com> <20221216150626.670312-2-agruenba@redhat.com>
 <Y6XBi/YJ4QV3NK5q@infradead.org>
In-Reply-To: <Y6XBi/YJ4QV3NK5q@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 23 Dec 2022 23:04:51 +0100
Message-ID: <CAHpGcMKJO7HhgyU5NKX3h6vVeNAGp-8xFrOf+nSTEWHC-PekzA@mail.gmail.com>
Subject: Re: [RFC v3 1/7] fs: Add folio_may_straddle_isize helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 23. Dez. 2022 um 16:06 Uhr schrieb Christoph Hellwig
<hch@infradead.org>:
> On Fri, Dec 16, 2022 at 04:06:20PM +0100, Andreas Gruenbacher wrote:
> > Add a folio_may_straddle_isize() helper as a replacement for
> > pagecache_isize_extended() when we have a locked folio.
>
> I find the naming very confusing.  Any good reason to not follow
> the naming of pagecache_isize_extended an call it
> folio_isize_extended?

A good reason for a different name is because
folio_may_straddle_isize() requires a locked folio, while
pagecache_isize_extended() will fail if the folio is still locked. So
this doesn't follow the usual "replace 'page' with 'folio'" pattern.

> > Use the new helper in generic_write_end(), iomap_write_end(),
> > ext4_write_end(), and ext4_journalled_write_end().
>
> Please split this into a patch per caller in addition to the one
> adding the helper, and write commit logs explaining the rationale
> for the helper.  The obious ones I'm trying to guess are that
> the new helper avoid a page cache radix tree lookup and a lock
> page/folio cycle, but I'd rather hear that from the horses mouth
> in the commit log.

Yes, that's what the horse says.

> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2164,16 +2164,15 @@ int generic_write_end(struct file *file, struct address_space *mapping,
> >        * But it's important to update i_size while still holding page lock:
> >        * page writeout could otherwise come in and zero beyond i_size.
> >        */
> > -     if (pos + copied > inode->i_size) {
> > +     if (pos + copied > old_size) {
>
> This is and unrelated and undocument (but useful) change.  Please split
> it out as well.
>
> > + * This function must be called while we still hold i_rwsem - this not only
> > + * makes sure i_size is stable but also that userspace cannot observe the new
> > + * i_size value before we are prepared to handle mmap writes there.
>
> Please add a lockdep_assert_held_write to enforce that.
>
> > +void folio_may_straddle_isize(struct inode *inode, struct folio *folio,
> > +                           loff_t old_size, loff_t start)
> > +{
> > +     unsigned int blocksize = i_blocksize(inode);
> > +
> > +     if (round_up(old_size, blocksize) >= round_down(start, blocksize))
> > +             return;
> > +
> > +     /*
> > +      * See clear_page_dirty_for_io() for details why folio_set_dirty()
> > +      * is needed.
> > +      */
> > +     if (folio_mkclean(folio))
> > +             folio_set_dirty(folio);
>
> Should pagecache_isize_extended be rewritten to use this helper,
> i.e. turn this into a factoring out of a helper?

I'm not really sure about that. The boundary conditions in the two
functions are not identical. I think the logic in
folio_may_straddle_isize() is sufficient for the
extending-write-under-folio-lock case, but I'd still need confirmation
for that. If the same logic would also be enough in
pagecache_isize_extended() is more unclear to me.

> > +EXPORT_SYMBOL(folio_may_straddle_isize);
>
> Please make this an EXPORT_SYMBOL_GPL just like folio_mkclean.

Thanks,
Andreas
