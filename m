Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69F59A8A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiHSWbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHSWbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:31:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF566104441;
        Fri, 19 Aug 2022 15:31:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e21so2377616edc.7;
        Fri, 19 Aug 2022 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AhRHfO8iehFCCtUowGE0tDVkHBkaER+EpAHuQQt15oc=;
        b=csqNUCUvJsvxtE4jVAKKtuYnZTdoPzEWZddaKZTbfqriRyKxrQIS3i7Yi/C5OPY7gt
         /50rUoYRzc0U7Epx0QSQyjIT9enLFPnSqL3lkshcGvgi7jH0pX4OS3kck265cQff3tdu
         K2jjyk/oy1hqeLqArpRYmMgyBmy3d7ddq+dVmLvOp7Mk+rAMX3wJEX9yUZBug/tfvx08
         oVRPIT2a/J5iqOrYaG2WxC0uZI2OYDf4vBtn1Ukeg8BBJDPuPYIDz9Jp1UI8TlhOyoVr
         VWZM+DCTnSNiAgWs8qrC8uSSYcA6W0/sRGuEjTvbjNlX1NgPhxdHlfrDTy4AeNAre8hP
         6g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AhRHfO8iehFCCtUowGE0tDVkHBkaER+EpAHuQQt15oc=;
        b=Gp+RXpHYif6QzgVBVYq9L+cjYRCxb1SsItPOnyDGlrbf+G6ttxTvQon78Gg77/nY1C
         BhwPDlY+mr16UzBvr/MG8knDGehK1ps1z/FzpZs0Rwl2JU5AZ69KNsWWW7E0CJbp4P1y
         F6TGNiN28Ye7uvQISYDr9qshJhlJaGNa3sdxcM4F8e/lUsxHvCTfmasPveFXW4ndxYwz
         UzlRqLfUOwbZXjo4vdq8r4L5NOWNVsdWr2sSn3T+3YN8UlKvFUiocKqQV25/O2e9EnGP
         xZkiTqMQn6remcatHJKzjgos5ESv4btomnmATaf440RBVFUSOtTb/dvyuiQrhaOqKAbN
         oKlQ==
X-Gm-Message-State: ACgBeo19C+VR6bMNcCpcrjKvjLAKxH1lp1Hk2dXQwv3KK+qRStRfLCTH
        WuhzHiE2i41jc+oe6jrDXPyaoyTGXr4=
X-Google-Smtp-Source: AA6agR4m85we7sUC2H6jAFrF9/7vo0AenPmlyIe2typeJ83W140l74mTBGmd9pjlhcmnyC+Aqk4LvA==
X-Received: by 2002:a05:6402:b90:b0:446:6871:7bfa with SMTP id cf16-20020a0564020b9000b0044668717bfamr1027737edb.143.1660948295350;
        Fri, 19 Aug 2022 15:31:35 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0072af2460cd6sm2875378eju.30.2022.08.19.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:31:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] fs-verity: use kmap_local_page() instead of kmap()
Date:   Sat, 20 Aug 2022 00:31:31 +0200
Message-ID: <2255194.ElGaqSPkdT@opensuse>
In-Reply-To: <Yv/Wi/2IH/bY05zG@casper.infradead.org>
References: <20220818224010.43778-1-ebiggers@kernel.org> <44912540.fMDQidcC6G@opensuse> <Yv/Wi/2IH/bY05zG@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On venerd=C3=AC 19 agosto 2022 20:29:31 CEST Matthew Wilcox wrote:
> On Fri, Aug 19, 2022 at 09:50:37AM +0200, Fabio M. De Francesco wrote:
> > On venerd=C3=AC 19 agosto 2022 00:40:10 CEST Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > >=20
> > > Convert the use of kmap() to its recommended replacement
> > > kmap_local_page().  This avoids the overhead of doing a non-local
> > > mapping, which is unnecessary in this case.
> > >=20
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >=20
> > >  fs/verity/read_metadata.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > It looks good to me...
> >=20
> > > -		virt =3D kmap(page);
> > > +		virt =3D kmap_local_page(page);
> > >=20
> > >  		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy))
> >=20
> > {
> >=20
> > > -			kunmap(page);
> > > +			kunmap_local(virt);
> > >=20
> > >  			put_page(page);
> > >  			err =3D -EFAULT;
> > >  			break;
> > >  	=09
> > >  		}
> > >=20
> > > -		kunmap(page);
> > > +		kunmap_local(virt);
>=20
> Is this a common pattern?  eg do we want something like:
>=20
> static inline int copy_user_page(void __user *dst, struct page *page,
> 		size_t offset, size_t len)
> {
> 	char *src =3D kmap_local_page(page) + offset;
> 	int err =3D 0;
>=20
> 	VM_BUG_ON(offset + len > PAGE_SIZE);
> 	if (copy_to_user(dst, src, len))
> 		err =3D -EFAULT;
>=20
> 	kunmap_local(src);
> 	return err;
> }
>=20
> in highmem.h?

Not sure that it is much common...

Can the following command provide any insight?

opensuse:/usr/src/git/kernels/linux> grep -rn copy_to_user -B7 . --exclude-
dir\=3DDocumentation | grep kmap

=2E/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2306-         ptr =3D=20
kmap_local_page(p);
=2E/drivers/gpu/drm/i915/i915_gem.c-215-  vaddr =3D kmap_local_page(page);
=2E/drivers/gpu/drm/radeon/radeon_ttm.c-872-                      ptr =3D=20
kmap(page);
=2E/drivers/vfio/pci/mlx5/main.c-182-             from_buff =3D=20
kmap_local_page(page);
=2E/arch/parisc/kernel/cache.c-580-       kto =3D kmap_local_page(to);
=2E/mm/memory.c-5474-                     maddr =3D kmap(page);
=2E/fs/verity/read_metadata.c-56-         virt =3D kmap(page);
=2E/fs/aio.c-1252-                ev =3D kmap_local_page(page);
=2E/fs/exec.c-883-                char *src =3D kmap_local_page(bprm->page[=
index])=20
+ offset;

If this command is good to provide any hint, it suggests that having=20
copy_to_user() in highmem.h is not probably worth.

Thanks,

=46abio=20



