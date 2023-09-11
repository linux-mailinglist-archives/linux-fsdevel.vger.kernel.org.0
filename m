Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86CE79AF2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjIKUwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbjIKO51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C22C71B9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694444193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjLlk28N+IES7lbOqPkjnpN8fiIPP2Upbjgts+irvBQ=;
        b=Ka403U70Pm4dDCQAuboOmW+p40Kpgw0zmLceGTcM1ZfCGr6dwxSWV+W0nDag+zlPir995s
        5b2vwb7/9w2TEInxdh0TzsxJcA9xx6tbWe11nfCtiqWw3v45Yvv0wiQp90+UOtRFfSGdAr
        84FKCNQFKtTvmQvjqplhMdHhXRYpT38=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-afFQbOZ9MX2uF2feENa89A-1; Mon, 11 Sep 2023 10:56:32 -0400
X-MC-Unique: afFQbOZ9MX2uF2feENa89A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401b91039b4so15517425e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 07:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444191; x=1695048991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjLlk28N+IES7lbOqPkjnpN8fiIPP2Upbjgts+irvBQ=;
        b=SvZnBK5n/xAs693ZKytveinX0grjZJPFt+mW/Yd1Ms1lPaIZLdiXMHORTd7Lr4E5JI
         zoFNIuYfovu/PA4pgCstQjkA5BuI2y6PN5SPoyOCu2Yaa53BmumhDzKJBYlCYhA+my0i
         tvS13ZAWy/p+iJcvpUiPFSCSNqCQGPD1LZlfY+mv8S1dXtX6U9xUIv2SUbtW7BaRecCe
         K7y1GHQaQo65JqUN4LDoJHlqDnwNNR8Xktb0geA21CVxC/XekNfEjFRfIt+ZApe0joXM
         hGdk59m3K9tq3OctG1jlJ6uOTnkYXfD3h1//bv/vwxh6Nxw8Edu0DmCzPRalxthKDqbj
         jmgg==
X-Gm-Message-State: AOJu0YzeMTWIDPY7LJn0TISg9KOKZbbdXK7ujbTV9zOJO5oS5Lf4+yFZ
        WpaYFQ0rs7k5K3k8LrQp7Zvw5bHh8/UqnrUR2pHCmfz1UIJ2O9felNZUsxsJxNbpkjDluNX8ZQq
        ZRZFcM/e5E+8salIt4pdKezUz5g==
X-Received: by 2002:a05:600c:3b03:b0:401:7d3b:cc84 with SMTP id m3-20020a05600c3b0300b004017d3bcc84mr9201120wms.0.1694444191198;
        Mon, 11 Sep 2023 07:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaTgIxufT0B9URByqaq4dCwny2mOEmdqr573NpnWdMHJnL3oRf2uiW9GgG/9l/4bSxs5Py6Q==
X-Received: by 2002:a05:600c:3b03:b0:401:7d3b:cc84 with SMTP id m3-20020a05600c3b0300b004017d3bcc84mr9201102wms.0.1694444190779;
        Mon, 11 Sep 2023 07:56:30 -0700 (PDT)
Received: from [10.32.64.154] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0ac900b003fef60005b5sm10317032wmr.9.2023.09.11.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:56:30 -0700 (PDT)
Message-ID: <4a09c32167528e0082559bc170699765f0c49c58.camel@redhat.com>
Subject: Re: [PATCH v3] xarray: Document necessary flag in alloc-functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Sep 2023 16:56:29 +0200
In-Reply-To: <ZP8pbgeBQMKyLjcI@casper.infradead.org>
References: <20230911144837.13540-1-pstanner@redhat.com>
         <ZP8pbgeBQMKyLjcI@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oh =E2=80=93 well, nope, that's fine.
I just 'abused' v3 as a RESEND as I didn't receive a "merged" message
;)

Let's leave it as it is, thx for merging :)

P.

On Mon, 2023-09-11 at 15:51 +0100, Matthew Wilcox wrote:
> On Mon, Sep 11, 2023 at 04:48:37PM +0200, Philipp Stanner wrote:
> > Calling functions that wrap __xa_alloc() or __xa_alloc_cyclic()
> > without
> > the xarray previously having been initialized with the flag
> > XA_FLAGS_ALLOC being set in xa_init_flags() results in undefined
> > behavior.
> >=20
> > Document the necessity of setting this flag in all docstrings of
> > functions that wrap said two functions.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > I used the time available until we can get this merged to create a
> > version-3, improving a few things.
>=20
> Umm, too late, v2 went upstream last week during the merge window.
>=20
> Do you still want to change the wording?
>=20
> > Changes since v2:
> > - Phrase the comment differently: say "requires [...] an xarray
> > [...]"
> > =C2=A0 instead of "must be operated on".
> > - Improve the commit message and use the canonical format: a)
> > describe
> > =C2=A0 the problem, b) name the solution in imperative form.
> >=20
> > Regards,
> > P.
> > ---
> > =C2=A0include/linux/xarray.h | 18 ++++++++++++++++++
> > =C2=A0lib/xarray.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 ++++++
> > =C2=A02 files changed, 24 insertions(+)
> >=20
> > diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> > index 741703b45f61..746a17b64aa6 100644
> > --- a/include/linux/xarray.h
> > +++ b/include/linux/xarray.h
> > @@ -856,6 +856,9 @@ static inline int __must_check
> > xa_insert_irq(struct xarray *xa,
> > =C2=A0 * stores the index into the @id pointer, then stores the entry a=
t
> > =C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitia=
lised
> > @id.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock.=C2=
=A0 May
> > sleep if
> > =C2=A0 * the @gfp flags permit.
> > =C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated
> > or
> > @@ -886,6 +889,9 @@ static inline __must_check int xa_alloc(struct
> > xarray *xa, u32 *id,
> > =C2=A0 * stores the index into the @id pointer, then stores the entry a=
t
> > =C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitia=
lised
> > @id.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock whi=
le
> > =C2=A0 * disabling softirqs.=C2=A0 May sleep if the @gfp flags permit.
> > =C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated
> > or
> > @@ -916,6 +922,9 @@ static inline int __must_check
> > xa_alloc_bh(struct xarray *xa, u32 *id,
> > =C2=A0 * stores the index into the @id pointer, then stores the entry a=
t
> > =C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitia=
lised
> > @id.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Process context.=C2=A0 Takes and releases the xa_lock=
 while
> > =C2=A0 * disabling interrupts.=C2=A0 May sleep if the @gfp flags permit=
.
> > =C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated
> > or
> > @@ -949,6 +958,9 @@ static inline int __must_check
> > xa_alloc_irq(struct xarray *xa, u32 *id,
> > =C2=A0 * The search for an empty entry will start at @next and will wra=
p
> > =C2=A0 * around if necessary.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock.=C2=
=A0 May
> > sleep if
> > =C2=A0 * the @gfp flags permit.
> > =C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 =
1 if
> > the
> > @@ -983,6 +995,9 @@ static inline int xa_alloc_cyclic(struct xarray
> > *xa, u32 *id, void *entry,
> > =C2=A0 * The search for an empty entry will start at @next and will wra=
p
> > =C2=A0 * around if necessary.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock whi=
le
> > =C2=A0 * disabling softirqs.=C2=A0 May sleep if the @gfp flags permit.
> > =C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 =
1 if
> > the
> > @@ -1017,6 +1032,9 @@ static inline int xa_alloc_cyclic_bh(struct
> > xarray *xa, u32 *id, void *entry,
> > =C2=A0 * The search for an empty entry will start at @next and will wra=
p
> > =C2=A0 * around if necessary.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Process context.=C2=A0 Takes and releases the xa_lock=
 while
> > =C2=A0 * disabling interrupts.=C2=A0 May sleep if the @gfp flags permit=
.
> > =C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 =
1 if
> > the
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index 2071a3718f4e..2b07c332d26b 100644
> > --- a/lib/xarray.c
> > +++ b/lib/xarray.c
> > @@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
> > =C2=A0 * stores the index into the @id pointer, then stores the entry a=
t
> > =C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitia=
lised
> > @id.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Any context.=C2=A0 Expects xa_lock to be held on entr=
y.=C2=A0
> > May
> > =C2=A0 * release and reacquire xa_lock if @gfp flags permit.
> > =C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated
> > or
> > @@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
> > =C2=A0 * The search for an empty entry will start at @next and will wra=
p
> > =C2=A0 * around if necessary.
> > =C2=A0 *
> > + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC
> > set
> > + * in xa_init_flags().
> > + *
> > =C2=A0 * Context: Any context.=C2=A0 Expects xa_lock to be held on entr=
y.=C2=A0
> > May
> > =C2=A0 * release and reacquire xa_lock if @gfp flags permit.
> > =C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 =
1 if
> > the
> > --=20
> > 2.41.0
> >=20
>=20

