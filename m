Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5482C586B75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiHAM5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiHAM5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:57:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C6025B;
        Mon,  1 Aug 2022 05:56:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso5541903wms.2;
        Mon, 01 Aug 2022 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amOVaEp2aJMXMYvtbYzw3nRq3jlNitwj6qz5H8qFoGc=;
        b=BqYKsNrMndL+OkTW5BRsQUtwvUBqHr/a+eb23/GRq6C2R7pQ5B++RsubyNk6CxrN8d
         eh1IzUn0PKeZjVBpTUzRxjUU54cVREYlEs20wC/Y3k669zctwikr8FRVzv+YNTc0RbW8
         W+paJSYvuhJ0QvzFgSvWMjna8XZIDt5u4yWBglVWqq6b7WtLjJn+blbb/lQ5fnAb2syi
         TuQ3ntHuQB+/8r7C8djrVjlXr6a8jKS/K/iteWu6G9pbfSLIc+Ykxo/8c0QQFI2nZgr2
         Crv5ZDtDcrRAP+TAbbKtH621ydl26WWzH/z/5Q7ryNwqD/X6Hed/0AvhrGuK3Qw2bpLp
         vXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amOVaEp2aJMXMYvtbYzw3nRq3jlNitwj6qz5H8qFoGc=;
        b=4tzlfKB+LRnOVMUWCH0+db0mJPYfqsTcSFldP/A9XyUYTpWYUh6xhCVNVN/zuhZY1k
         eJTZuTVcXWIJ05DjqFlKYVnSjn1gx8Jx5vZlJaGdV8Ld/BETRY9pXYp9TdWwYYiVlAqi
         i+4kIKibt+99UkVT0Z2o1J7cBm9vzNyRVRhR56ceHDSdRmYyZB62GLffwKFXN4Ngg17K
         Sx3YmT9hnodxr30AKn8a0aZOOhw/Fs2+YmN+VoQ+DrhLC+CVaYyeMwB6ZHmEQMG/F4ZS
         6mJoqXILk/d0HrJwjtP+NdbQlIbU34F2dVldBpdDwl2O6dVbcVyrs4i/A0m78bzWMU11
         g+fg==
X-Gm-Message-State: AJIora/2qBJ4083+iNu1knq/Xd/vKfta7Yc43Z1i+MjVjO6O+uSlfQyS
        nHUR77prVkRiESzi6IlM8gU=
X-Google-Smtp-Source: AGRyM1t5smML+r9ybya2UYUbuKs8LQaVnQqseftlpmWpAETpou7r7fvw72VyW/R3aDMusrflA/2tkQ==
X-Received: by 2002:a05:600c:354e:b0:3a3:2ede:853d with SMTP id i14-20020a05600c354e00b003a32ede853dmr10559954wmq.61.1659358617592;
        Mon, 01 Aug 2022 05:56:57 -0700 (PDT)
Received: from opensuse.localnet (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b00397402ae674sm19372876wma.11.2022.08.01.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:56:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Date:   Mon, 01 Aug 2022 14:56:42 +0200
Message-ID: <2117828.irdbgypaU6@opensuse>
In-Reply-To: <5834FD23-A333-40B7-9678-43E61986512E@dubeyko.com>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com> <Yt7Y6so92vXTOI+Q@casper.infradead.org> <5834FD23-A333-40B7-9678-43E61986512E@dubeyko.com>
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

On marted=C3=AC 26 luglio 2022 20:40:29 CEST Viacheslav Dubeyko wrote:
>=20
> > On Jul 25, 2022, at 10:54 AM, Matthew Wilcox <willy@infradead.org>=20
wrote:
> >=20
> > On Mon, Jul 25, 2022 at 10:17:13AM -0700, Viacheslav Dubeyko wrote:
> >> Looks good. Maybe, it makes sense to combine all kmap() related=20
modifications in HFS+ into
> >> one patchset?
> >=20
> > For bisection, I'd think it best to leave them separate?
>=20
> I am OK with any way. My point that it will be good to have patchset to=20
see all modified places together, from logical point of view. Even if we=20
have some issue with kmap() change on kmap_local_page(), then, as far as I=
=20
can see, the root of issue should be kmap_local_page() but not HFS+ code.=20
Oppositely, if it=E2=80=99s some undiscovered HFS+ issue, then again=20
kmap_local_page() changes nothing. But I am OK if it is separate patches=20
too.
>=20
> Thanks,
> Slava.
>=20
And I am OK with sending a patchset :-)

I'm sorry because, while working on the last conversions for HFS+ in=20
btree.c, I just noticed that I had overlooked one other kmap() call site in=
=20
bitmap.c.

Therefore, I'd like to ask to drop this patch and I'll also ask to drop the=
=20
patch to bnode.c in the related thread.=20

When done, I'll send a series of three patches, one per file (bnode.c,=20
bitmap.c, btree.c).

Thanks,

=46abio



