Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4972638B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjFGO7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFGO7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:59:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83851BD;
        Wed,  7 Jun 2023 07:59:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so34281265e9.0;
        Wed, 07 Jun 2023 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686149956; x=1688741956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc32lgaIBhKotdDaWWQj793WD5Z51UEUi1uIpd7T5Lk=;
        b=HElglTIyG8gzx4dMVUHPNdXZCuVgJaWMRrPD5UqN6A29NB+hpwnNFMU6CngFEvxjBc
         lVvWfUejRGgSxjUsdH/fKBoa3IGhMaphs1cQrfLpnHs1i0xzk2KfVNeh/DG9m/MpI+EP
         XcPMJPiAOC4wPpXs2JXzzTsX++dQPTsner8hPAIp56+nTltUiIrp+9zSfEhMXVqi99sU
         TZKPzkQXzDEps0fgdpuJGIvDepIcjb6fhDIPFZ4eUS39qWtG0aGb3Ul933Ip6CnPAVTt
         Keck3Wcicz/14xWPoNn4KSEDpnfZfMivnWWhquVe8pmrnddzzoUE2MK7mxL74K5vfwPG
         hcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149956; x=1688741956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc32lgaIBhKotdDaWWQj793WD5Z51UEUi1uIpd7T5Lk=;
        b=IukcEWbKoaX/xb0xTFRs7hKUI/tZGgqcfAdDBR66XGNUXqqaLV1Dvyuv6M6wgKNpl/
         I0Jt6KtREOCbO2zXyqZqZIVQaIfrmYv+iaf9tbzgGRWT3jT0c7RqM4k4aibJ9n26XzVs
         JwCYid40TjC3bAcEy/QdU2hDQlxerrot6J0KS9I+3GUuCcwwd5oamO0N2SEsOFOKFvZg
         8X3OHDDzSrLsglbvqHi98T5MwCUk+DC1jaBsYyxJjRDlg6VUmDMV6/+xHK8rZzAZwiHU
         QXEpyUvmcwrRzVQyPCJ88eRtsQA7u1gEQtB8wWDCZNnrcXRE9XSSS3DCjc33Rvjw4RB5
         vjWA==
X-Gm-Message-State: AC+VfDzqGZfK84W4ZxY0rG0M4Hxva4q++e5QY/7xcVlCCBB7tKXmxr8J
        rtzgTCIiqjjXk0IIwnIifjyq6p/+W6M=
X-Google-Smtp-Source: ACHHUZ6xvD6uymas9CeOxoTcoNoQ20XmLZM6KF4Ov7xSqWao+W9YmDfOGQUlN239/sH1/FdCXJVm9Q==
X-Received: by 2002:a05:600c:230f:b0:3f5:1241:6cfa with SMTP id 15-20020a05600c230f00b003f512416cfamr4837883wmo.37.1686149956066;
        Wed, 07 Jun 2023 07:59:16 -0700 (PDT)
Received: from suse.localnet (host-79-23-99-244.retail.telecomitalia.it. [79.23.99.244])
        by smtp.gmail.com with ESMTPSA id f5-20020a7bcc05000000b003f18b942338sm2464011wmh.3.2023.06.07.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:59:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v3] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Wed, 07 Jun 2023 16:59:13 +0200
Message-ID: <2287966.ElGaqSPkdT@suse>
In-Reply-To: <ZCGYps2z5IlaEaxU@casper.infradead.org>
References: <20230119162055.20944-1-fmdefrancesco@gmail.com> <2114426.VsPgYW4pTa@suse>
 <ZCGYps2z5IlaEaxU@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On luned=EC 27 marzo 2023 15:22:46 CEST Matthew Wilcox wrote:
> On Mon, Mar 27, 2023 at 12:08:20PM +0200, Fabio M. De Francesco wrote:
> > On gioved=EC 19 gennaio 2023 17:20:55 CEST Fabio M. De Francesco wrote:
> > > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > > kmap_local_page().
> > >
> > > [...]
> > >
> > > Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> > > fs/aio.c.
>
> Or should we just stop allocating aio rings from HIGHMEM and remove
> the calls to kmap()?  How much memory are we talking about here?

Matthew,

Well, I'll do as you suggested. Actually, I should have made this change wh=
en=20
you suggested it but... well, I think you can easily guess why I did not.

Here it seems that a call of find_or_create_pages() with the GFP_USER flag
instead of GFP_HIGHUSER is all that is required. And then I'll get rid of t=
he
mappings in favor of some straight page_address().

I just gave a look after months, so I could very well have missed something=
=20
else. If what I just saw it's all that must be changed, I'll send the new=20
patch by tomorrow.

Thanks,

=46abio

P.S.: I had sent other patches that must also be changed according to a=20
similar comment you made. Obviously, I'll work also on them (no matter if y=
ou=20
can't probably recall the short series to fs/ufs I'm referring to).



