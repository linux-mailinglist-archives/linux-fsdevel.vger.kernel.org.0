Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771FD624994
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 19:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKJSg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 13:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKJSg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:36:56 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF515A18;
        Thu, 10 Nov 2022 10:36:55 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id n85so3365715yba.1;
        Thu, 10 Nov 2022 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwspPYGBddXm8y18FFeJS4hoZNm7qA1CuZanJwJrbZ0=;
        b=L/Fdih1NjChjaeOatBG2yhtKKiZp/gnoj3u7+lTQ6qP4DwAwO+H1Pw5OeHnPEFGDUR
         chlCVc705CqZ0SA298hfRExI1cgkcF2/B0lxplCOKNM79Trb/B06rmgeGm5ObO9vc2P8
         oo180CBK92mxUiPCghyLfTjiJjPOKWLqRMpi2CJ1VRGADs8/YuaYhQmg87u6RX7HviSi
         Pz6nLPhPLlW2TYZyCWui1F5/+UbB6VBaQx0A8ZyZqcqf/KleIVzu3pW4VlC+VRdfleoC
         1i9abXOmV2aMtsKb2ZBRVQhD36aZN1845Li8aQ2j07vwO1D6NMObuzS12FyjElqYborf
         VHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwspPYGBddXm8y18FFeJS4hoZNm7qA1CuZanJwJrbZ0=;
        b=Ps96tNaUzDtjamfCX6vhEgCs/Zv2IPYVLVUGzs8UqkNhI6SbAIMdGuaYYLJk3PRUmp
         vxl/RoK4SEfea2R5Q1YUJrWuSkw1qmIRfJtfNtM7SgNiGs9jBe1tjnsDxWx8cVErEWsW
         uSsuEbcYorjyqTeUqWXPYwS0vxZwVutvrDo6UdOEXvVc5K3WuDgXwqCnbokUTPOoIFu4
         Hkn2krkXn/YmbJCVkhVA7DcvGOvoLNwVdHMzH+1hrHeID0McIWuqb0o+583RWGiEOAj8
         Mllv4+nGhEHvBzBPRJBfVHZUw+yk2ixeaZxrJFwxPUM+MA/zACnp2+wa/j9aofRrv3zY
         y/Aw==
X-Gm-Message-State: ACrzQf08k/fsD3mrUY1aARukIyTnAu5cMxAZaY21EQc1vHf992Bqkrl9
        IGl1ym1A9akNu1r7ebBCNEihEh0wll+RZ/ovBct8kLNq
X-Google-Smtp-Source: AMsMyM7LuAxLd405p2TB01URPcdsT3cuLA+jlMsKGTwWf+mbCZLvTcx8u0p4cWBP9ql0rr87rpNplX3z1rLSRrTRBU8=
X-Received: by 2002:a25:94a:0:b0:6d0:ee14:628a with SMTP id
 u10-20020a25094a000000b006d0ee14628amr38086493ybm.50.1668105414353; Thu, 10
 Nov 2022 10:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-3-vishal.moola@gmail.com> <Y2FkV0wogVhMHkkO@casper.infradead.org>
In-Reply-To: <Y2FkV0wogVhMHkkO@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 10 Nov 2022 10:36:43 -0800
Message-ID: <CAOzc2px2POjBU-6X=YB+rd-87vhDx0cUu0m8EFWA=Q_Peu1gUg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: Convert fuse_try_move_page() to use folios
To:     miklos@szeredi.hu
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>
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

On Tue, Nov 1, 2022 at 11:24 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 01, 2022 at 10:53:23AM -0700, Vishal Moola (Oracle) wrote:
> > Converts the function to try to move folios instead of pages. Also
> > converts fuse_check_page() to fuse_get_folio() since this is its only
> > caller. This change removes 15 calls to compound_head().
>
> This all looks good.  I wonder if we should't add an assertion that the
> page we're trying to steal is !large?  It seems to me that there are
> assumptions in this part of fuse that it's only dealing with order-0
> pages, and if someone gives it a page that's part of a large folio,
> it's going to be messy.  Miklos, any thoughts?

Miklos, could you please look over this patch?

> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  fs/fuse/dev.c | 55 ++++++++++++++++++++++++++-------------------------
> >  1 file changed, 28 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 26817a2db463..204c332cd343 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -764,11 +764,11 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
> >       return ncpy;
> >  }
> >
> > -static int fuse_check_page(struct page *page)
> > +static int fuse_check_folio(struct folio *folio)
> >  {
> > -     if (page_mapcount(page) ||
> > -         page->mapping != NULL ||
> > -         (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
> > +     if (folio_mapped(folio) ||
> > +         folio->mapping != NULL ||
> > +         (folio->flags & PAGE_FLAGS_CHECK_AT_PREP &
> >            ~(1 << PG_locked |
> >              1 << PG_referenced |
> >              1 << PG_uptodate |
> > @@ -778,7 +778,7 @@ static int fuse_check_page(struct page *page)
> >              1 << PG_reclaim |
> >              1 << PG_waiters |
> >              LRU_GEN_MASK | LRU_REFS_MASK))) {
> > -             dump_page(page, "fuse: trying to steal weird page");
> > +             dump_page(&folio->page, "fuse: trying to steal weird page");
> >               return 1;
> >       }
> >       return 0;
> > @@ -787,11 +787,11 @@ static int fuse_check_page(struct page *page)
> >  static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
> >  {
> >       int err;
> > -     struct page *oldpage = *pagep;
> > -     struct page *newpage;
> > +     struct folio *oldfolio = page_folio(*pagep);
> > +     struct folio *newfolio;
> >       struct pipe_buffer *buf = cs->pipebufs;
> >
> > -     get_page(oldpage);
> > +     folio_get(oldfolio);
> >       err = unlock_request(cs->req);
> >       if (err)
> >               goto out_put_old;
> > @@ -814,35 +814,36 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
> >       if (!pipe_buf_try_steal(cs->pipe, buf))
> >               goto out_fallback;
> >
> > -     newpage = buf->page;
> > +     newfolio = page_folio(buf->page);
> >
> > -     if (!PageUptodate(newpage))
> > -             SetPageUptodate(newpage);
> > +     if (!folio_test_uptodate(newfolio))
> > +             folio_mark_uptodate(newfolio);
> >
> > -     ClearPageMappedToDisk(newpage);
> > +     folio_clear_mappedtodisk(newfolio);
> >
> > -     if (fuse_check_page(newpage) != 0)
> > +     if (fuse_check_folio(newfolio) != 0)
> >               goto out_fallback_unlock;
> >
> >       /*
> >        * This is a new and locked page, it shouldn't be mapped or
> >        * have any special flags on it
> >        */
> > -     if (WARN_ON(page_mapped(oldpage)))
> > +     if (WARN_ON(folio_mapped(oldfolio)))
> >               goto out_fallback_unlock;
> > -     if (WARN_ON(page_has_private(oldpage)))
> > +     if (WARN_ON(folio_has_private(oldfolio)))
> >               goto out_fallback_unlock;
> > -     if (WARN_ON(PageDirty(oldpage) || PageWriteback(oldpage)))
> > +     if (WARN_ON(folio_test_dirty(oldfolio) ||
> > +                             folio_test_writeback(oldfolio)))
> >               goto out_fallback_unlock;
> > -     if (WARN_ON(PageMlocked(oldpage)))
> > +     if (WARN_ON(folio_test_mlocked(oldfolio)))
> >               goto out_fallback_unlock;
> >
> > -     replace_page_cache_folio(page_folio(oldpage), page_folio(newpage));
> > +     replace_page_cache_folio(oldfolio, newfolio);
> >
> > -     get_page(newpage);
> > +     folio_get(newfolio);
> >
> >       if (!(buf->flags & PIPE_BUF_FLAG_LRU))
> > -             lru_cache_add(newpage);
> > +             folio_add_lru(newfolio);
> >
> >       /*
> >        * Release while we have extra ref on stolen page.  Otherwise
> > @@ -855,28 +856,28 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
> >       if (test_bit(FR_ABORTED, &cs->req->flags))
> >               err = -ENOENT;
> >       else
> > -             *pagep = newpage;
> > +             *pagep = &newfolio->page;
> >       spin_unlock(&cs->req->waitq.lock);
> >
> >       if (err) {
> > -             unlock_page(newpage);
> > -             put_page(newpage);
> > +             folio_unlock(newfolio);
> > +             folio_put(newfolio);
> >               goto out_put_old;
> >       }
> >
> > -     unlock_page(oldpage);
> > +     folio_unlock(oldfolio);
> >       /* Drop ref for ap->pages[] array */
> > -     put_page(oldpage);
> > +     folio_put(oldfolio);
> >       cs->len = 0;
> >
> >       err = 0;
> >  out_put_old:
> >       /* Drop ref obtained in this function */
> > -     put_page(oldpage);
> > +     folio_put(oldfolio);
> >       return err;
> >
> >  out_fallback_unlock:
> > -     unlock_page(newpage);
> > +     folio_unlock(newfolio);
> >  out_fallback:
> >       cs->pg = buf->page;
> >       cs->offset = buf->offset;
> > --
> > 2.38.1
> >
> >
