Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307AF6618A7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjAHTlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjAHTla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B52B85D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33qTT0r6wAZ1WTwwlWCp7SkxG6n6RS0yiwUpFiSj+fQ=;
        b=B3vDuFqzYFB518eYF3YTNmkgBdBUc5A5wg0WMtaQ7c3zqkHLRCjfCx4C538P5NgGXVvI+v
        lCNgHWbY4f178R+5/4N2dbFr6JKvpvVIWI5aYJNHjCkSovCY7asMdXxI1ZhrMc/ugnl9di
        t8VK8hLOl+7pUD62Wwx/yblY3PX3L2s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-ODBZrPyVOHSleswOESxswA-1; Sun, 08 Jan 2023 14:40:42 -0500
X-MC-Unique: ODBZrPyVOHSleswOESxswA-1
Received: by mail-pg1-f199.google.com with SMTP id k16-20020a635a50000000b0042986056df6so2971751pgm.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 11:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33qTT0r6wAZ1WTwwlWCp7SkxG6n6RS0yiwUpFiSj+fQ=;
        b=cN1APfV9MNihv9rSs2TmN+7wS0SD+gUUF7nau99J9kMQ+8/y8JOCGHTc4EPMESmhqP
         HnUQ3GCbkLV8UDSGAT3q0HHECOFitNbl69d3Ety6O5aEBNzCDKzejgoDsP30a4Jc7wHG
         ljskGdF3zjcIKYZhshcYLN4dJR6wRjb4SToDr79xAZmkAQ7eQ2JPxu6G3bbrz1XK5ivP
         GZY7TPfs7170tq9t9kHbtOLuWPAcbNOGavYyBvkl7PcTjhzN2qYDL2HozRXgj/LZ8tum
         bV9jneY09ixTyPBcJ161x85wxDT4uZ1BO0Ce7PUBq3V2lklgL9rHkwBnq5sPFS/e219J
         1tzw==
X-Gm-Message-State: AFqh2kon+fQh8A/vPel+h/pJ7ZDGsYkLCv7fWB2/txmVdgfMuQ7g5/qm
        8of2W8mbQRy2JZQNQa1Eb7/7qHs/Ak3xQl3ZukKCr80+eOgCKyASm8LwGPppbue8KyQHgaZVedI
        J7AuUYzdZ2Vvq6FnzAlvkpwMffXie98x/zszgmXUvrg==
X-Received: by 2002:a63:5d1b:0:b0:495:fb5f:439d with SMTP id r27-20020a635d1b000000b00495fb5f439dmr3366899pgb.68.1673206841648;
        Sun, 08 Jan 2023 11:40:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1lJQZfWW6xV/PSksmTNaQzyZoMTAsvtqnDEI+7F2q3BfsEW4wdkPdTNM+CpyXNcR3EqzkjBqi270j/f370sU=
X-Received: by 2002:a63:5d1b:0:b0:495:fb5f:439d with SMTP id
 r27-20020a635d1b000000b00495fb5f439dmr3366894pgb.68.1673206841425; Sun, 08
 Jan 2023 11:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20221231150919.659533-1-agruenba@redhat.com> <20221231150919.659533-6-agruenba@redhat.com>
 <Y7r9gnn2q3PnQ030@infradead.org>
In-Reply-To: <Y7r9gnn2q3PnQ030@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 8 Jan 2023 20:40:29 +0100
Message-ID: <CAHc6FU6UF3CZWqdDoDieFgKZk6_PiJfmBi5jWFTRoNgk9D8-5Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iomap/gfs2: Get page in page_prepare handler
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 8, 2023 at 6:29 PM Christoph Hellwig <hch@infradead.org> wrote:
> > +     if (page_ops && page_ops->page_prepare)
> > +             folio = page_ops->page_prepare(iter, pos, len);
> > +     else
> > +             folio = iomap_get_folio(iter, pos);
> > +     if (IS_ERR(folio))
> >               return PTR_ERR(folio);
>
> I'd love to have a iomap_get_folio helper for this sequence so that
> we match iomap_put_folio.  That would require renaming the current
> iomap_get_folio to __iomap_get_folio.

That's the wrong way around though. iomap_get_folio() is exported to
filesystems, so if at all, we should rename iomap_put_folio() which is
a static function only used in the iomap code.

I'll post an update.

Thanks,
Andreas

