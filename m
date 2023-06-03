Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8F720F05
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 11:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFCJr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFCJry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0191AC
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685785626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpVCFUo5GMnPwvDWypDcvvGvza9lcUEE09oRJn4R2IQ=;
        b=D+iwTn4NKX9VRz6tOuTU40Fz8RM5Y769S8IzgrdYV67jxNTdNi1qCWr1oxAZKP97Y4tgLA
        NHh8kVB3KoIaGie70t/eW97mLfS3ritWeDnrHyGO3ghGJq3udMrDoY3exFEJ9hzSNo2rdD
        /ySUzyJdIw7jGQndQ+9JEnAEtCg5twg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-bRD-HChnNy6lGf1QmRgJJA-1; Sat, 03 Jun 2023 05:47:05 -0400
X-MC-Unique: bRD-HChnNy6lGf1QmRgJJA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39a869f633aso1261687b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jun 2023 02:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685785624; x=1688377624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpVCFUo5GMnPwvDWypDcvvGvza9lcUEE09oRJn4R2IQ=;
        b=UgnC2noMhT1st32j+rWw197legSC7pgHMz6x0/M3JFETJVL8rHoL7QbL9HLPuEyl98
         TUg2ISTv7pQSmjiBxs/lvMjhOhICWK0ngBPSaOs6IVPAI8fhLjA9+xCFxUm3ZHolRW36
         qmuD/fHbdgoB/Nylfw+YdEUDII7saigFiHi1sXdZtCySJquOGlmlxmJwYa90wVlrxsQk
         K9YsYeCpZ4pkDyNeDWGG+Ng/HUHfo3Yta0agEMyuSXe+MGJaTVE6j1X3iFzHW3AVd45P
         Ntsd53ck98asi9NLiCZy+5KZqvqhqxalAJCDm+T2+VafPdQcvlaHwo/ztJGUK/O64cxm
         JdVw==
X-Gm-Message-State: AC+VfDz1MrlcFrSAkhQ1Rgvzhp1/a1074Lyqd+vSroXcpBEVZJsLlXFE
        G21r5Xgr5B5ODirFoXjzvUV2Pnk8ftRPvG6qOwEIytL6R8+RoiE24DmvOM3DFVatSIu9lSNDliv
        L/aea07PQ0Af+LjDVRBNiv+aDspu3iPzl0I9hTqZlzlzam3nZ5g==
X-Received: by 2002:a05:6808:48b:b0:396:cd:829c with SMTP id z11-20020a056808048b00b0039600cd829cmr3038337oid.3.1685785623767;
        Sat, 03 Jun 2023 02:47:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7B9jETQTaMcLjJ77KxcE0Jzos1GkS20jhQAcnVBsvLy49hL44IJNM3QrNwFq7XxjxJYaBfGb3sWSOaeXoP3IU=
X-Received: by 2002:a05:6808:48b:b0:396:cd:829c with SMTP id
 z11-20020a056808048b00b0039600cd829cmr3038323oid.3.1685785623556; Sat, 03 Jun
 2023 02:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230517032442.1135379-1-willy@infradead.org> <20230517032442.1135379-6-willy@infradead.org>
 <CAHc6FU6GowpTfX-MgRiqqwZZJ0r-85C9exc2pNkBkySCGUT0FA@mail.gmail.com> <ZGzBikVAWeXOmGQd@casper.infradead.org>
In-Reply-To: <ZGzBikVAWeXOmGQd@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 3 Jun 2023 11:46:51 +0200
Message-ID: <CAHc6FU4F6nrEew=Bdgxr3hAgFq6+9JjfvRmiVH1JFy5ooaW8zA@mail.gmail.com>
Subject: Re: [PATCH 5/6] gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 3:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Tue, May 23, 2023 at 02:46:07PM +0200, Andreas Gruenbacher wrote:
> > >  void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *fo=
lio,
> > > -                            unsigned int from, unsigned int len)
> > > +                            size_t from, size_t len)
> > >  {
> > >         struct buffer_head *head =3D folio_buffers(folio);
> > >         unsigned int bsize =3D head->b_size;
> >
> > This only makes sense if the to, start, and end variables in
> > gfs2_trans_add_databufs() are changed from unsigned int to size_t as
> > well.
>
> The history of this patch is that I started doing conversions from page
> -> folio in gfs2, then you came out with a very similar series.  This
> patch is the remainder after rebasing my patches on yours.  So we can
> either drop this patch or just apply it.  I wasn't making a concerted
> effort to make gfs2 support 4GB+ sized folios, it's just part of the
> conversion that I do.

Right. What do we do with these patches now, though? We probably don't
want to put them in the gfs2 tree given the buffer.c changes. Shall I
post a revised version? Will you?

> > >  extern void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct fo=
lio *folio,
> > > -                                   unsigned int from, unsigned int l=
en);
> > > +                                   size_t from, size_t len);

Thanks,
Andreas

