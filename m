Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F56B5E62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCKRLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Mar 2023 12:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKRLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:11:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0ED7615F;
        Sat, 11 Mar 2023 09:11:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso5322701wmp.4;
        Sat, 11 Mar 2023 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678554664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKflYvA8UcraGyQwNuSBGmcqYYys5oOu9Tv+Rn3Pb4o=;
        b=f/p5keK0gDn+cn95qsnKc0uFP6yb5Tk64quQhjr14E486Qy1YPmwmMTNQphBA3+QTP
         pq8W94gj33ApebuATbwCcG68CQ6UsIy7PwKktFVrcsFx/VJpFNIGa0J0RIDfFHVMUKKT
         hjwBSUhR5Ii+fW0n+sQ5SWdi27pQ1/C0jfBWhsrGNu9DFRfqaHIMMPAuIEfH1E5FYvwT
         0rN/XP7KXMfDl+zddqVQNZkG154PzxCssVUbPXVrREP0g7iWbjV+miirvzOOTTC1R4bJ
         mUNBHC3gVW/WsT/qOzM8iY32akDeA6IFnIqDUSnxP03VJ1M3wA6qYEcqcDEU05wHynIS
         ch/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678554664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKflYvA8UcraGyQwNuSBGmcqYYys5oOu9Tv+Rn3Pb4o=;
        b=3K8ArE0jalojEQkqriHGqD5gQvK3zvse1t+xfWQdVh81fPUROA2kd4+LEytDIvqye3
         puaUyt2YdWtjklJpns0N1Vqw8EMJlAIBYHZfu4SSyVS2FoUGXV+O2yiab5hmcUre/j21
         7DA3/1YdRQorht/yTm/SzLBC7glBSeZZ19EtQEzrLtqtKM/i7St/arI+z8y39P2xq0Zd
         L5m4k4qShddo40B31KmDQnBUvIzrLlacCD/ZGYPhS1NHGk+14Gix5P77OqesfHxCu5cE
         ugWH+xcO5tWBf1qSA0uYnD6a+6zxWrluPJdYtCfrst4u39GYE5uTbmNRQ4wqsbfN2LHZ
         Pruw==
X-Gm-Message-State: AO0yUKUJ0mmJ7lvXitLSY2H60nfpDOFlH5SZE9g7vwQ4krh96eJbpr1f
        qmxTOcC64qe86y6NNoexlwM=
X-Google-Smtp-Source: AK7set9tx1wziatWCHhFmDDnM59Wz2TGCwApXBxtfLl3LbxbORM1FoSASnFQfNU78qdcxolkmGHk6w==
X-Received: by 2002:a05:600c:4453:b0:3de:a525:1d05 with SMTP id v19-20020a05600c445300b003dea5251d05mr4729209wmn.8.1678554663709;
        Sat, 11 Mar 2023 09:11:03 -0800 (PST)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003e204fdb160sm3630719wmn.3.2023.03.11.09.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:11:03 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] common helper for kmap_local_page() users in local filesystems
Date:   Sat, 11 Mar 2023 18:11:01 +0100
Message-ID: <8232398.NyiUUSuA9g@suse>
In-Reply-To: <20230310204431.GW3390869@ZenIV>
References: <20230310204431.GW3390869@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On venerd=EC 10 marzo 2023 21:44:31 CET Al Viro wrote:
> 	kmap_local_page() conversions in local filesystems keep running into
> kunmap_local_page()+put_page() combinations; we can keep inventing names
> for identical inline helpers, but it's getting rather inconvenient.  I've
> added a trivial helper to linux/highmem.h instead.

Yeah, "put_and_unmap_page()". Nice helper :-)

Today I decided to prepare a series to convert all the functions of all the=
=20
filesystems where I had found the above-mentioned pattern but I stopped=20
immediately after converting dir_put_page() in fs/sysv.

Why? Just because I realized that I do not understand the reasons behind th=
e=20
choice of the name of the helper... =20

Why did you name it "put_and_unmap_page()" instead of "unmap_and_put_page()=
",=20
for we always unmap first _and_ put the page immediately the unmapping?

It seems it want to imply that instead we put first and unmap later (which=
=20
would be wrong). That name sounds misleading to me and not sound (logically=
=20
speaking).

Am I missing some obscure convention behind your choice of that name for th=
e=20
helper?

If not, can you please change it from "put_and_unmap_page()" to=20
"unmap_and_put_page()"?=20

Thanks,

=46abio

>=20
> 	I would've held that back until the merge window, if not for the
> mess it causes in tree topology - I've several branches merging from that
> one, and it's only going to get worse if e.g. ext2 stuff gets picked by
> Jan.
>=20
> 	The helper is trivial and it's early in the cycle.  It would=20
simplify
> the things if you could pull it - then I'd simply rebase the affected=20
branches
> to -rc2...
>=20
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4c=
c6:
>=20
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-
highmem
>=20
> for you to fetch changes up to 849ad04cf562ac63b0371a825eed473d84de9c6d:
>=20
>   new helper: put_and_unmap_page() (2023-03-07 01:50:53 -0500)
>=20
> ----------------------------------------------------------------
> put_and_unmap_page() helper
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>=20
> ----------------------------------------------------------------
> Al Viro (1):
>       new helper: put_and_unmap_page()
>=20
>  include/linux/highmem.h | 6 ++++++
>  1 file changed, 6 insertions(+)




