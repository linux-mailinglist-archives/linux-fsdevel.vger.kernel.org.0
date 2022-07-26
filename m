Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D325812B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 14:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiGZMEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiGZMEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:04:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3032ED6;
        Tue, 26 Jul 2022 05:04:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z23so25501978eju.8;
        Tue, 26 Jul 2022 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1Ti0MGUlytygruMrxGo/AxcFFddUNIpSzRkXp5uaKM=;
        b=ncpP8atAdpRpWKpzIsTpRmvzzAOSS9AR3b5F2asPL1nHQH9IuPRgdSjkQJ5pt31Xsq
         qt5PsITCmjzuuTuJ8aKGZs2IWDkMqPM/VJyhLE6E1rwyi/yq/1ZpvZVgWqnNdVctMCJ1
         7YrfR/FneIuPmAATkrTiFkh96jSojMbAaIXE1cYbge5/gM2QiCZuxnzW+au3Smtt/YuZ
         LyTVqQ5gnyLqMOZi06Pjt79lBdZ7RA78TeKIyQTB3uW6mBXEbileM9hjuv6QKGWsxm2D
         1LUiRMo4x9gsuhG75crklqUiRDW6jmOnFFT5ZPzicePfdGXDmngYR9y0jbHTceqHAulY
         JbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1Ti0MGUlytygruMrxGo/AxcFFddUNIpSzRkXp5uaKM=;
        b=4jgskMmT9OHkhHX2Urcn6KyP5oGKENmOuvRCycSkS7X1H8WwFIuaZFar9c7AEfDQ0G
         +9DmVmC39sinF8B1KpRY97LwxS0OgXhBCXR4SAXIvQtGGS1EJNwOgqDYEYRe6kuA4zpc
         /Ek/o6ZfQQ0BcUJ7RNSogAqPmg0YXXgnsIk5IFCrqIleU736Jxh8mMHx3ENBFHtGFTW4
         t/sfxCFONdZ3ZqqJMksSl1/3S9wiAvacTgfaTVslNPBCoyVLKmgyY20OeITZS8dGB973
         wMk+A/oU55+Nrf4CU2UXMZZMJaSE4We2gS3ksKNkzg7LTeE5rlxnEXEU3j8tKli+J/E2
         pceA==
X-Gm-Message-State: AJIora/87NCP2cSYyP2JmGBK6eh0x3S5H56wKhXpZBsbt3jxgLmslHLy
        0hf4tyv47/Tr7peCmhyTyHGCDDnv3uE=
X-Google-Smtp-Source: AGRyM1tTUjSzkin2nzJthOEa96aJ9L+KPCjN9ILcrLW1LZlo6LAH22J+PhI4OkoznXnticPcITEWwA==
X-Received: by 2002:a17:907:7ea4:b0:72b:6929:4571 with SMTP id qb36-20020a1709077ea400b0072b69294571mr13377689ejc.257.1658837042488;
        Tue, 26 Jul 2022 05:04:02 -0700 (PDT)
Received: from opensuse.localnet (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id h12-20020a1709060f4c00b006ff0b457cdasm6335192ejj.53.2022.07.26.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:04:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Date:   Tue, 26 Jul 2022 14:04:00 +0200
Message-ID: <2050755.bB369e8A3T@opensuse>
In-Reply-To: <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com> <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
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

On luned=C3=AC 25 luglio 2022 19:17:13 CEST Viacheslav Dubeyko wrote:
>=20
> > On Jul 24, 2022, at 1:50 PM, Fabio M. De Francesco=20
<fmdefrancesco@gmail.com> wrote:
> >=20
> > kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > There are two main problems with kmap(): (1) It comes with an overhead=
=20
as
> > mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when=20
the
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> >=20
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again,=20
the
> > kernel virtual addresses are restored and are still valid.
> >=20
> > Since its use in bitmap.c is safe everywhere, it should be preferred.
> >=20
> > Therefore, replace kmap() with kmap_local_page() in bnode.c.
> >=20
>=20
> Looks good. Maybe, it makes sense to combine all kmap() related=20
modifications in HFS+ into
> one patchset?
>=20
> Reviewed by: Viacheslav Dubeyko <slava@dubeyko.com>=20

Thanks for your reviews of this and of the other patch to bnode.c.

Actually, I started with the first file I met (bnode.c) because I noticed=20
that maintainers don't need to care about any special ordering for applying=
=20
the patches, since each of them is self-contained.

This is why I haven't thought of making a series of them.

Currently only one file is still left with some kmap() call sites. I'll=20
work on that within the next days.

Again thanks,

=46abio=20

> Thanks,
> Slava.
>=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > fs/hfsplus/bitmap.c | 18 +++++++++---------
> > 1 file changed, 9 insertions(+), 9 deletions(-)

[snip]


