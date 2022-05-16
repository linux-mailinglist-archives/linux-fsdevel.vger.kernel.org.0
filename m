Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DCE529345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 23:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349535AbiEPV72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349539AbiEPV7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 17:59:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5554617E;
        Mon, 16 May 2022 14:59:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h14so2583615wrc.6;
        Mon, 16 May 2022 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcmBvUgsVeNM17CUNnfRIku+R4yL2gP60EC6MoAvwrg=;
        b=IFPjQkUx6GkRaADbf42xb/jtRznMIH61XR1C1J/SPH5ePYaVsHDqdqkBMX5LaBkHhr
         1ytV3SU4nMwLxjZZExiByoLP8OLiiLdBwqhA1q5XXcXaOiFoap0YU536uOL7ro0kQys+
         up0tQT2lFx0wwR5d43Via0+btZhUY9LPADgEfluawiYt+ZLWZzOGHpvEzF2VRAfpXUA/
         G13Qjl+WWCjI5EIZ0eMCTEuT6rhpKy6PkubfuPMAFWm/j44uaIB7CqNBd3s2DMSo7ZLB
         if1Fhlvd7BT1hnmFkEXuiGMx2Xp0Dat8nC/oM2DuDe6BVVj+VFyHQ+gN5Tspmd9ClJbd
         PneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcmBvUgsVeNM17CUNnfRIku+R4yL2gP60EC6MoAvwrg=;
        b=v/kssIvQEdHP8SqOFMEDdej7XLd/axE3lZqPpqdnFrSf1sD+83F4ktQkkwQrXHG7k5
         WKIrd9zvyyyp5GYMWRg8/qdbVjtwY/I78cb6+QNlawZ6f0LOwnvGlk6wQrguwuGuOCn5
         keUHDI4KmggtVyqZn+tpMJopoLvZpZo0NlOd2gcMZwLNhcNziQVswfCRojv7uFvCREr2
         U7lNrgjbq851E0A2UpWJg+QzOs4oK0nK8tZY6Qz+SC3sMR58uuW/yokSjNgjHDYuQtpD
         xNEHWXCEI1zw6yoZQnm8Ujvba53XF5TwS3D9xh9cxKiA+r7K2iVLrgx8ruPnNWOSuysx
         T9BA==
X-Gm-Message-State: AOAM533BmR3Fc1fFrmujmpIy36lAtfX4x0q7Q/Na/AXao23VA64Utpfh
        KUsGuksnja+FhGEeEy4X6qU=
X-Google-Smtp-Source: ABdhPJwNMVgFJjW9VU03XHirlfrHvC4J/bHqM3E3Dq2ucnd4p2MQKweoc23r9WDrtvbM5OJ/vuZH6w==
X-Received: by 2002:a5d:47ac:0:b0:20c:550b:4cf2 with SMTP id 12-20020a5d47ac000000b0020c550b4cf2mr16005442wrb.420.1652738358559;
        Mon, 16 May 2022 14:59:18 -0700 (PDT)
Received: from leap.localnet (host-79-50-182-226.retail.telecomitalia.it. [79.50.182.226])
        by smtp.gmail.com with ESMTPSA id e12-20020adfa44c000000b0020c5253d8dcsm10422969wra.40.2022.05.16.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:59:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 16 May 2022 23:59:15 +0200
Message-ID: <2117615.Icojqenx9y@leap>
In-Reply-To: <YoJl+lh0QELbv/TL@casper.infradead.org>
References: <20220516101925.15272-1-fmdefrancesco@gmail.com> <YoJl+lh0QELbv/TL@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
No, I have not done more than compile-testing.=20

However, I understand your concerns regarding these changes. I can only say
that, while they may seem like mechanical replacements, I have carefully
checked the code to be sure enough not to break the logic of the UFS and /
or the rules of local mapping.

I have nothing against testing, but I think they are not needed here unless
you see something that is potentially harmful or suspiciously broken and=20
you explicitly request it. If so, I'll be testing the code by the end of
this week (I cannot before).

Thanks,

=46abio



