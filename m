Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30ED58777A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiHBHGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiHBHGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:06:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEAD4A833;
        Tue,  2 Aug 2022 00:06:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m13so12728840wrq.6;
        Tue, 02 Aug 2022 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmMOmLSJX+RzCR7biJYmLUZVQCiFdcK4fy7tSbKi77k=;
        b=LMHSu5Dd188FY3TEyEo63Pk3NPgQycUxvJ2cSw6MReQ5goUojzRe3EED21z6SboUW6
         jWA3BtvhfAD8EA/iJCOlUB4ri3mw2O1fHI9aGfCFEvXKh7NkeTSKM3dIHdQHRN05XhNP
         L5D2DDm3BKghO9EN4yPtv4NI9Dfv/VlhF1eqxu8F+PDZekGxEZvPKofkRmhEP7zBbO2S
         hbvUJPsXX0b7kntTE24FWhw0SAsapdTLJ5/A1Wy0vreQgF6ecLislCfzmZZrJYfVQiif
         ajXklZTEzJ1jsiORpg1C2zXEgNIoQtDWDcbCxI8+jLY1y9wMUsGwodHdK3RBEKvuosOZ
         C2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmMOmLSJX+RzCR7biJYmLUZVQCiFdcK4fy7tSbKi77k=;
        b=71DjVHxacahox/1jd+N8cyGGjGKQK+N6VwKyIeetW/Bocva0PkzZ+aQjkXVRhjME/Z
         guwi8FG07rdqs6+oOplpsWnro/0AyPctbua7rbyGtq4QD6k3lGweRSIqj8dllTKbY8Ik
         Q6cHPueBKMDfth7gyHNcPtZwrMw6tRDhUAIoj/uSTtDqugFi7dq2Sp+J86gkSWYTZZzq
         o9KJp9QP/aXusn/fEmXPMDGcB7JhA2FJRarAbhac4N5vuUTAwRN1PCMAqF54/9AE9Sxw
         TrsZLZXaL2bUcVEiL5rlgcy34gW4D6B+m3kZK+ditBpSZW/6huAUJ0mmdmzYU+SlIOU7
         KLrg==
X-Gm-Message-State: ACgBeo3OoP744D8d0a/+XXhtDDSiU3aQ6WOmke9cF32TVp/SRF89u2qz
        UnvKrbllipGmxF/PJR7lkmo=
X-Google-Smtp-Source: AA6agR6G5EpnVnBvkcxlzW7mPnOz/ceSYW0olJa8SWIzXPSF8tAS5hYqSbxfG0s+lDDyrSHZKgRJKw==
X-Received: by 2002:adf:e88c:0:b0:220:7084:4c91 with SMTP id d12-20020adfe88c000000b0022070844c91mr1151320wrm.212.1659423989583;
        Tue, 02 Aug 2022 00:06:29 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003a2f96935c0sm26094455wmi.9.2022.08.02.00.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:06:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Tue, 02 Aug 2022 09:06:26 +0200
Message-ID: <2589292.k3LOHGUjKi@opensuse>
In-Reply-To: <YoJl+lh0QELbv/TL@casper.infradead.org>
References: <20220516101925.15272-1-fmdefrancesco@gmail.com> <YoJl+lh0QELbv/TL@casper.infradead.org>
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

On luned=C3=AC 16 maggio 2022 16:55:54 CEST Matthew Wilcox wrote:
> On Mon, May 16, 2022 at 12:19:25PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is per thread, CPU local and not=20
globally
> > visible.
> >=20
> > The usage of kmap_local_page() in fs/ufs is pre-thread, therefore=20
replace
> > kmap() / kunmap() calls with kmap_local_page() / kunmap_local().
> >=20
> > kunmap_local() requires the mapping address, so return that address=20
from
> > ufs_get_page() to be used in ufs_put_page().
> >=20
> > These changes are essentially ported from fs/ext2 and are largely based=
=20
on
> > commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").
> >=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Have you done more than compile-tested this?  I'd like to know that it's
> been tested on a machine with HIGHMEM enabled (in a VM, presumably).
> UFS doesn't get a lot of testing, and it'd be annoying to put out a
> patch that breaks the kmap_local() rules.
>=20
As said in another message of this thread, these changes have only been=20
compile-tested. I can't see anything which may break the rules about using=
=20
local mappings properly.

I'm working on converting all kmap() call sites I can do across the whole=20
kernel to kmap_local_page(). Practically all of those conversions have=20
already been reviewed / acked, and many of them have already been taken by=
=20
their respective maintainers. Others are still too recent.

Most of those patches have been properly tested on a QEMU/KVM x86_32 VM,=20
4GB to 6GB RAM, booting kernels with HIGHMEM64GB enabled.

Instead, despite this submission is very old, I haven't yet been able to=20
figure out how to test these changes. I really don't know how I can create=
=20
and test a UFS filesystem.

Can you please help somewhat with hints about how to test this patch or=20
with testing it yourself? I'm thinking of this option because I suppose=20
that you may have access to a Solaris system (if I recall correctly, UFS is=
=20
the default filesystem of that OS. Isn't it?).

I'm sorry to bother you with this issue, however I'd appreciate any help=20
you may provide. I'd hate to see all patches applied but one :-)=20

Thanks,

=46abio



