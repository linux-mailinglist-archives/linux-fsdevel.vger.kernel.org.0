Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4162C936
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 20:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKPTt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 14:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiKPTty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:49:54 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B656578;
        Wed, 16 Nov 2022 11:49:52 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e68so19430066ybh.2;
        Wed, 16 Nov 2022 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLk5Bv9pyzmOmKmpiRdrbFX7MTtlMoGgKbcUXnSuZlI=;
        b=Mr/rVM5gWvDOXLWlos1ler/CMAMfiIgz4Sml3kFSyjECZnlSPcVBU4y3VfCTu/0aDq
         2Hx+c24+SP+0/wnV2C0+rZ0YnJMzkJqQZ07KplG/jYFNeJ/AdVuTulsQOta/yskYT4co
         lO+DYR3t4HZuIy39N3Pc5nd7f8R7UyAmkEcYR6dxKgZ3kO04wSNctDpA5HdAa/nF2Np5
         iI7sEspYjGhADXPrJaY9jmcKzsMSJwcbVqjhbJhW4py4F4S/B3LAslAjpOlTFVcsVoxC
         FpqtJGeWYIq5qmN19F7mWs1i+OrcK1voWBxuSePpcTDigFfWwQtwggtf/qd5BZtGSYBH
         2NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLk5Bv9pyzmOmKmpiRdrbFX7MTtlMoGgKbcUXnSuZlI=;
        b=SAYYHezRpXZfNnz/+3tYxg1fKGHUeW5Z52bb/lDEpV4vFsJYdGgsqT6zKRZ0wXFHWW
         f/DYZxBFoc9/Qa8IS+8o623B0r16xQ52DjtMbfhLz8j9KgvyzqIFd1SVTluBerdcsKlm
         Z0RIdEWUZZs/U5BWtKYN3fIeCzgzIsi3PpBkr0bvXC56HPEq/abtvA3tKHbi6+iRmPWG
         HY0D+X73JQ34JxwNPT4mRE8OZrX/n6JXnzKZ2XtYwp8NJ1TyRkknyDuP46DZH9n1cYPQ
         vY1og3qXLuSD873NTzuhtEaK3TkVvZbGLpmDkP4LhX66ZFed0aYM3l6qmfsIR4eTn6XS
         SoDw==
X-Gm-Message-State: ANoB5pkUt1UFIj4riSU8DzxbUZ7oPDAD9wjqzVs5Tx4QQsSpRqo/Nf3N
        sMBxr+21M33JG3q+MZBQrAm2/9XHRY+5rbhTC7c=
X-Google-Smtp-Source: AA0mqf6Yj2bGl28yKEI97oe+OajLC3QX2soh79yTZPgp6unUy7vmMfUDtsTI6pyxXekCj6K0TeOICP3O9Xan+y3YZu4=
X-Received: by 2002:a25:248a:0:b0:6e6:aa56:f59 with SMTP id
 k132-20020a25248a000000b006e6aa560f59mr1021192ybk.595.1668628191611; Wed, 16
 Nov 2022 11:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20221116021011.54164-1-vishal.moola@gmail.com>
 <20221116021011.54164-2-vishal.moola@gmail.com> <Y3SaskD7QurUVJFr@casper.infradead.org>
In-Reply-To: <Y3SaskD7QurUVJFr@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 16 Nov 2022 11:49:40 -0800
Message-ID: <CAOzc2pxAG2-y7eNTbhDzh6X_Aqzj4o7BVkzudmhdkTy6rghU7A@mail.gmail.com>
Subject: Re: [PATCH 1/4] ext4: Convert move_extent_per_page() to use folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com, tytso@mit.edu
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

On Wed, Nov 16, 2022 at 12:09 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 15, 2022 at 06:10:08PM -0800, Vishal Moola (Oracle) wrote:
> >  {
> >       struct inode *orig_inode = file_inode(o_filp);
> >       struct page *pagep[2] = {NULL, NULL};
> > +     struct folio *folio[2] = {NULL, NULL};
>
> I have a feeling that mext_page_double_lock() should also be converted
> to use folios.  But this makes me nervous:
>
>         int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
>
> and I'm not sure what will happen if one or both of the orig_page
> and donor_page is large -- possibly different sizes of large.
>
> Obviously ext4 doesn't allow large folios today, but it would be good to
> get some reasoning about why this isn't laying a trap for later (or at
> least assertions that neither folio is large so that there's an obvious
> scream instead of silent data corruption).

I had thought once mext_page_mkuptodate() and block_commit_write()
were converted to folios, large folios wouldn't be a problem. I hadn't
considered
that the folios may be of different sizes. I can add assertions about both
folios being large and the same size in v2.
