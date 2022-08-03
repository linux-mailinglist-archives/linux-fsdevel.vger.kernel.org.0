Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58EF589290
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiHCTEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHCTEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:04:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33202625A;
        Wed,  3 Aug 2022 12:04:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v3so21704420wrp.0;
        Wed, 03 Aug 2022 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZmFCP5kEPrv3Hm+gp8AsaEcC+Ii9IBa+hXoHMy9CTk=;
        b=n77uky2dkW/DDgUZElKQ1ym5ncS3KR9Gi2OHLMypQODiLH4I2XkQ7HMkrDRsEfTzOI
         EkM9d+g84LWHgWV6DpAU3mqs0CHg/fCt0NRjDzewWMYPj3j8QM96VyJceBoPexoN+uOb
         Z2IUqemn60XCw8v8v+Fi3s7qCFnY6iZQ/z7lK9CPFvcYiJbaF9gXs05u2lkm85uDwI9E
         jlnAc3aEpeDkp3OCrpzcEUYYATPK5CVCNu4UY8QSCFP+/KM8GpgHaHlC2E2AtVGwUTyY
         toqGjv57au9i6ZJHDe2R/VzDoOJUocclscou/aLxQyVezoIwMK3EpCFWaYY3RyRsDB+9
         cuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZmFCP5kEPrv3Hm+gp8AsaEcC+Ii9IBa+hXoHMy9CTk=;
        b=rYKJxI6Pu30S74+NyC3A1D0OslydOeCEBJfX0RxCBQrXLEjMlbt1ngh6qV4hQ8g+Sz
         fCdvIlAOaY/U5XE7DMlhP24y4+Nqp4SL1TwcwosqgTZX0w0g3Mdala9SjclhNK7u3toN
         4DdK9qT4Eh4B6IMKu1A/O35wlG1nJU9YYVMDnXDPdyM1sXxfMKfQSdoNsqd3sIPQyP+M
         8CGhGjOhjPZLXUHF+hXy7+e0guKxoLhuAJaZY+HPBF4Ys3fUWKcMehEiN/tBcYZqu9MF
         iMF3JRUbcP24k3VcaftK3Y6QqejFxCpAQU1UQNRf/k4qXJmue0X/uexKnSpeMA9uveo4
         LiWQ==
X-Gm-Message-State: ACgBeo0qyN/pZ6y1BbkdGcTpf+LmYxNTDhLLUFvaU7ZmNTDeDnECDX9y
        I5LnXM9sWpEiEOj+h++WILI=
X-Google-Smtp-Source: AA6agR7+VhpNvm+P2HOcuwsa4FwFENjegKTGY9vY8pis3XSu8qVYETNJHTMdH+eumKhcytWgfL1HLA==
X-Received: by 2002:a5d:52cb:0:b0:21a:3cc5:f5f4 with SMTP id r11-20020a5d52cb000000b0021a3cc5f5f4mr17430417wrv.367.1659553475656;
        Wed, 03 Aug 2022 12:04:35 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id c2-20020adffb42000000b0021e860f1bd4sm18978019wrs.100.2022.08.03.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 12:04:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Wed, 03 Aug 2022 21:04:32 +0200
Message-ID: <4784407.31r3eYUQgx@opensuse>
In-Reply-To: <2589292.k3LOHGUjKi@opensuse>
References: <20220516101925.15272-1-fmdefrancesco@gmail.com> <YoJl+lh0QELbv/TL@casper.infradead.org> <2589292.k3LOHGUjKi@opensuse>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On marted=C3=AC 2 agosto 2022 09:06:26 CEST Fabio M. De Francesco wrote:
> On luned=C3=AC 16 maggio 2022 16:55:54 CEST Matthew Wilcox wrote:
> > On Mon, May 16, 2022 at 12:19:25PM +0200, Fabio M. De Francesco wrote:
> > > The use of kmap() is being deprecated in favor of kmap_local_page().=
=20
> With
> > > kmap_local_page(), the mapping is per thread, CPU local and not=20
> globally
> > > visible.
> > >=20
> > > The usage of kmap_local_page() in fs/ufs is pre-thread, therefore=20
> replace
> > > kmap() / kunmap() calls with kmap_local_page() / kunmap_local().
> > >=20
> > > kunmap_local() requires the mapping address, so return that address=20
> from
> > > ufs_get_page() to be used in ufs_put_page().
> > >=20
> > > These changes are essentially ported from fs/ext2 and are largely=20
based=20
> on
> > > commit 782b76d7abdf ("fs/ext2: Replace kmap() with=20
kmap_local_page()").
> > >=20
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> >=20
> > Have you done more than compile-tested this?  I'd like to know that=20
it's
> > been tested on a machine with HIGHMEM enabled (in a VM, presumably).
> > UFS doesn't get a lot of testing, and it'd be annoying to put out a
> > patch that breaks the kmap_local() rules.
> >=20
> As said in another message of this thread, these changes have only been=20
> compile-tested. I can't see anything which may break the rules about=20
using=20
> local mappings properly.
>=20
> I'm working on converting all kmap() call sites I can do across the whole=
=20
> kernel to kmap_local_page(). Practically all of those conversions have=20
> already been reviewed / acked, and many of them have already been taken=20
by=20
> their respective maintainers. Others are still too recent.
>=20
> Most of those patches have been properly tested on a QEMU/KVM x86_32 VM,=
=20
> 4GB to 6GB RAM, booting kernels with HIGHMEM64GB enabled.
>=20
> Instead, despite this submission is very old, I haven't yet been able to=
=20
> figure out how to test these changes. I really don't know how I can=20
create=20
> and test a UFS filesystem.
>=20
> Can you please help somewhat with hints about how to test this patch or=20
> with testing it yourself? I'm thinking of this option because I suppose=20
> that you may have access to a Solaris system (if I recall correctly, UFS=
=20
is=20
> the default filesystem of that OS. Isn't it?).
>=20
> I'm sorry to bother you with this issue, however I'd appreciate any help=
=20
> you may provide. I'd hate to see all patches applied but one :-)=20
>=20
> Thanks,
>=20
> Fabio
>=20
=46or the sake of completeness I'd like to add something that I forgot to=20
mention in the last email...

The only reference to creating a ufs file system I can find is many years=20
old and shows using 'newfs' which seems to be a precursor to mkfs.[1] mkfs=
=20
does not seem to support ufs.[2][3].

This is why I'm not sure how to begin testing a ufs file system.

[1] https://docs.oracle.com/cd/E19683-01/806-4073/6jd67r9it/index.html
[2] https://linux.die.net/man/8/mkfs
[3] https://linux.die.net/man/5/fs

Thanks,

=46abio






