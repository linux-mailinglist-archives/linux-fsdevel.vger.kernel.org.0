Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38C0711109
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 18:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjEYQcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjEYQcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 12:32:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4612F
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 09:32:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-95fde138693so157196866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685032323; x=1687624323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNfCUobrUAUA40iHcw/nxcay95zNsz3B8ogepnZvesE=;
        b=OgAplwi7dHaym7T2CTKHHAsLwjXeqAptxqzsXZUWF7LBssaQhTyBj9It8cJKUwWmrQ
         F/KE+QT4dmKSj8OHM7gPgVN+qazjmOSfhODoYI+yi/UVf46tUREtl1vAB9KmefcGCESR
         K86Pp1wxOhxpuvnjErBd4KM7YC8XTaUR/ZKUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032323; x=1687624323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNfCUobrUAUA40iHcw/nxcay95zNsz3B8ogepnZvesE=;
        b=ODq6EO77hfV3qBTsgjw1hv94IIOfqQ6mUxFDtfbJcdeg7yZAA3Mnz88Cq77usUjFUA
         bazZ3ldpsK8OdH54ehqWzqcsEPEqJxyutU9VO1EZcspaWS54kmOfT5pyZiKXNokA47qh
         kHGcvE4yTF8lNtlGqxYJKR6GfQdHjF/1mHdlOrlI93ogTnjWRwjXMNn0J3FxzjeWTDCO
         HBAahwpmO2nVLs708u3vZf+BO52l6bpLAwBR5PWwyfBJGoL9WQSwzLYs47CjmF2suqre
         YNl7ecBv1l7/8oeoyUxFb0UhyMZ2ATOqyVn313VmUE8m5racFfwZymsl1CRvqS20+oJU
         fZjQ==
X-Gm-Message-State: AC+VfDxOAaYFwgDHocP8q+6P0vC497o6D5X6BlrsUdWo2MaQy56LXVRR
        FJsRxe8oNOiKHEAgpsPy+vc2RvAWymKsWas7t3MwYpi5
X-Google-Smtp-Source: ACHHUZ6DXUbD7Hr4dht8rMR5SbEWbJ9W8Qu5ZeCeXhSewKngKkD1JeqUfP9mU2f8U/u6o9/FeZgFOA==
X-Received: by 2002:a17:907:7f0d:b0:96f:f56a:e9be with SMTP id qf13-20020a1709077f0d00b0096ff56ae9bemr2232429ejc.8.1685032322918;
        Thu, 25 May 2023 09:32:02 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906054700b0096f675ce45csm1036853eja.182.2023.05.25.09.32.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:32:01 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso2442794a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 09:32:01 -0700 (PDT)
X-Received: by 2002:a17:907:a407:b0:96f:5511:8803 with SMTP id
 sg7-20020a170907a40700b0096f55118803mr1880847ejc.22.1685032321217; Thu, 25
 May 2023 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org> <3215177.1684918030@warthog.procyon.org.uk>
In-Reply-To: <3215177.1684918030@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 09:31:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Message-ID: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 1:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> True - but I was thinking of just treating the zero_page specially and ne=
ver
> hold a pin or a ref on it.  It can be checked by address, e.g.:
>
>     static inline void bio_release_page(struct bio *bio, struct page *pag=
e)
>     {
>             if (page =3D=3D ZERO_PAGE(0))
>                     return;

That won't actually work.

We do have cases that try to use the page coloring that we support.

Admittedly it seems to be only rmda that does it directly with
something like this:

        vmf->page =3D ZERO_PAGE(vmf->address);

but you can get arbitrary zero pages by pinning or GUPing them from
user space mappings.

Now, the only architectures that *use* multiple zero pages are - I
think - MIPS (including Loongarch) and s390.

So it's rare, but it does happen.

             Linus
