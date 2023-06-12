Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD272CAD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjFLP72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjFLP7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BF10FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686585491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MaW8k4BiMcy3VNz0QknaUl+mGPTFiF92AIL3GY/vzM=;
        b=FSinp74VyIt8jItYNojC4lwLw6VFOq8TK9W/UAyQFArwHX5Iv0T67enLMRVITtGbXAPbQ2
        WZApcM9ykjZkrjDpoScAjOfV4h4VAk4GVKt1eafVYnPNNudBPCqi6ryXnoVpCyBacCSRZb
        aNKnjifUGCHmkfu0WCcumKBwgj1uKSg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-YgVasuv0OSyZ42Oo68tydA-1; Mon, 12 Jun 2023 11:58:01 -0400
X-MC-Unique: YgVasuv0OSyZ42Oo68tydA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b3bb3dd181so10142705ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 08:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585480; x=1689177480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MaW8k4BiMcy3VNz0QknaUl+mGPTFiF92AIL3GY/vzM=;
        b=Xb7LhiM0ktdO0PJffc5DtIVE31OsoIc50PBjVMo3X5BhYCEo1hJobwwYv/d+k4Vbbw
         mYBpwuQlW0iOtoVFI+JpsOBT0G53VGU5vgFeeUZmL26KHyaKOjanD9szUswFSeL6CzDp
         tssUmr/jEYUtGLNa1M6syXOfT5BOh4U8vBqW6IxNP19BVmVMW6m9BiatOOhk9bhJdSdt
         qDjbBh8CsPKahK73wnPtJzOQ+F27tJCYwKUm0G4Ms8s4xzA0FyrPpSsxQkcExj8v1jCY
         IIDRzbMEShObY5D0Ve8jXtrDM1pD/HjgkbhVlrdVG8oA7jcujDZ0XgAlFbqcvEGsAbNr
         SEjA==
X-Gm-Message-State: AC+VfDxOYeRyIguWxmXh2dyjYDLJA3qlh81nD7YzcRkmwp1orvIwgSom
        wGTcVx3QsMNVkY9DYf/rnBQjcAh/KSq8V5DBVRFUTZsT03D9ko51/+ZzjyM3wcCmBzkmfL6PaCW
        aJX2ugthKqoZl898ZVJPNYZe0SJTqp3pmh0bUwI6niw==
X-Received: by 2002:a17:903:2286:b0:1ac:9cad:1845 with SMTP id b6-20020a170903228600b001ac9cad1845mr7935717plh.18.1686585480535;
        Mon, 12 Jun 2023 08:58:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yOiCf5BTOxgVMTE+GRdfgui8plW5bqROqPlURsSezkT44MIgjpNtQdfo37M1rHXmtSWVYzGzYFWAmg4uMHXc=
X-Received: by 2002:a17:903:2286:b0:1ac:9cad:1845 with SMTP id
 b6-20020a170903228600b001ac9cad1845mr7935704plh.18.1686585480237; Mon, 12 Jun
 2023 08:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU5xMQfGPuTBDChS=w2+t4KAbu9po7yE+7qGaLTzV-+AFw@mail.gmail.com>
 <87o7lkhfpj.fsf@doe.com> <ZIc4ujLJixghk6Zp@casper.infradead.org>
In-Reply-To: <ZIc4ujLJixghk6Zp@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 12 Jun 2023 17:57:48 +0200
Message-ID: <CAHc6FU7GnVeKmUC4GkySqE1bV3WgbA_WTuQ3D0dcMyn193M4VA@mail.gmail.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for
 ifs state bitmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 5:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Mon, Jun 12, 2023 at 08:48:16PM +0530, Ritesh Harjani wrote:
> > > Since we're at the nitpicking, I don't find those names very useful,
> > > either. How about the following instead?
> > >
> > > iomap_ifs_alloc -> iomap_folio_state_alloc
> > > iomap_ifs_free -> iomap_folio_state_free
> > > iomap_ifs_calc_range -> iomap_folio_state_calc_range
> >
> > First of all I think we need to get used to the name "ifs" like how we
> > were using "iop" earlier. ifs =3D=3D iomap_folio_state...
> >
> > >
> > > iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
> > > iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
> > > iomap_ifs_is_block_dirty -> iomap_block_is_dirty
> > >
> >
> > ...if you then look above functions with _ifs_ =3D=3D _iomap_folio_stat=
e_
> > naming. It will make more sense.
>
> Well, it doesn't because it's iomap_iomap_folio_state_is_fully_uptodate.

Exactly.

> I don't think there's any need to namespace this so fully.
> ifs_is_fully_uptodate() is just fine for a static function, IMO.

I'd be perfectly happy with that kind of naming scheme as well.

Thanks,
Andreas

