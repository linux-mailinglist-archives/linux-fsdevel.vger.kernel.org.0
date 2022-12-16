Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82A64F031
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 18:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiLPRQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 12:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiLPRQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D02A275
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671210957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FMxxbypNViBdI4yIgrSC4IXd1P5dO6tqxf8uJ4BBzw8=;
        b=hvZALtjRA6pYnbDarAOcKYmL3WB9TX/xmoRa4VKPjH5HxwUbpqCsV8sIO4C2sdLT+quRho
        Z5H2gdlvCJz8h0L0pzQUIxV9dHAaQpMotjj2piooyCf8dbtSaBuFl19htS4JCnhHNzDyuv
        RWRS2I5SusBMXLj43CJm3Inx0b6Hl+E=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-104-ISuuaQFQOheYlrvoqPnLvg-1; Fri, 16 Dec 2022 12:15:56 -0500
X-MC-Unique: ISuuaQFQOheYlrvoqPnLvg-1
Received: by mail-yb1-f200.google.com with SMTP id n197-20020a25d6ce000000b00702558fba96so3405749ybg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 09:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMxxbypNViBdI4yIgrSC4IXd1P5dO6tqxf8uJ4BBzw8=;
        b=fSYO0V4zn0ZpqCBf/DEeau3yW/DzLGJGBY8/a7fpGMWvOtX6N23Vmo/eAAfFLe2yRY
         84wU8jFmhKNkYDNSq8431/Ri/lQqg7GcsQHvY3TY4SksWHif+0NwKTNGzY1pwjg3JoZT
         RGGh046KE4PAIXp/6s+Fl5PKnn5/iVkd0u5DZwoeR+5XgqYcl97Kh68ISx78B8FXQkeN
         9FJfhlGMkdFCftGtu/zn92lTv831SMyLQMFgq76joSiAV+/VnhJ3NV0SfQCwkVStQBmt
         KioOkTN9Sr6tl1XaezSmCc0z4MHW4Fdrjrhrx0fB0DoEwwJKOgrTBMp0+S436pt9sbHj
         /CjA==
X-Gm-Message-State: ANoB5pklU8r2zOOeTWhVwq4XtE7DCU8d0VGeZ3yv9inWQT/t3t6pYxen
        FsXiTgoNRRAk2ev4p7sOXM34oq27ivP9QEhV+wKUDNmmEKwyvoNX7iq4wKSBvCU8M46wrontYeO
        cYenG5Fop+HAolRIeJ0mt8PeJZ6UTEMylnjBAOitAEQ==
X-Received: by 2002:a81:8407:0:b0:3e2:c77b:2563 with SMTP id u7-20020a818407000000b003e2c77b2563mr27749512ywf.54.1671210955579;
        Fri, 16 Dec 2022 09:15:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5sSx3su6laK9Kl+Wo+aUvlhEYchIP7sOq3J3e9vBxi/aJmFLAxjsr1EmGJ4JGxvgXw8z2oIHThFHswEOSM94k=
X-Received: by 2002:a81:8407:0:b0:3e2:c77b:2563 with SMTP id
 u7-20020a818407000000b003e2c77b2563mr27749506ywf.54.1671210955331; Fri, 16
 Dec 2022 09:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20221216150626.670312-1-agruenba@redhat.com> <20221216150626.670312-6-agruenba@redhat.com>
 <Y5ydHlw4orl/gP3a@casper.infradead.org>
In-Reply-To: <Y5ydHlw4orl/gP3a@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 16 Dec 2022 18:15:44 +0100
Message-ID: <CAHc6FU7Svp7XG8T5X4kak8Gz2kB2_OK1b5xbtn6uKrEnb6=3TQ@mail.gmail.com>
Subject: Re: [RFC v3 5/7] iomap: Get page in page_prepare handler
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 5:30 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Dec 16, 2022 at 04:06:24PM +0100, Andreas Gruenbacher wrote:
> > +     if (page_ops && page_ops->page_prepare)
> > +             folio = page_ops->page_prepare(iter, pos, len);
> > +     else
> > +             folio = iomap_folio_prepare(iter, pos);
> > +     if (IS_ERR_OR_NULL(folio)) {
> > +             if (!folio)
> > +                     return (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> > +             return PTR_ERR(folio);
>
> Wouldn't it be cleaner if iomap_folio_prepare() always
> returned an ERR_PTR on failure?

Yes indeed, thanks.

Andreas

