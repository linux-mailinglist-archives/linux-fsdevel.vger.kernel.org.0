Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD26782AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjAWROZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjAWROW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:14:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2EE2BF1F;
        Mon, 23 Jan 2023 09:14:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m15so9594487wms.4;
        Mon, 23 Jan 2023 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9WC8iywZy8Gy4k31tytTzptJaROkkZyQXyD+YWBff4=;
        b=niARWAClPn5CEhnc5TbZjK0C6MA+Al4Zz5BEom0JB+HEZO+fROvZODe0XcZYGpoOsT
         EWDugffaEi5D5Wxk/4LoyC6z1EsSafqn1fhjqmUmcOCpKd4wLNCa77iBnXGVXQwzv0q4
         5dEkV1/QQAHQS8rWwBVUEDpJ0ef+O3QfyjjNOS++Ej+8LuQILMnZRTpJJyeRmUrIKo/P
         68wjbe5QoQZF4iwckyoVAWmxUDFc3k7rw3pE/NS1jyh3jjRpvTTTKyfK22uu1Yl8f723
         58zcWXkNHmN7Zme4e9Hh5U2EzUl+GAGDJ8O3sM8aNg+93Tsj4DKBrndYxd3Isx3fiZyB
         H8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9WC8iywZy8Gy4k31tytTzptJaROkkZyQXyD+YWBff4=;
        b=Kf1xgrxi6RXxRb1IPm2chDktIqtCRYbj1QmQVVTPwdh97AaX9HSF2bhR+gymWFbQ+f
         lrMWcQeGGhEPHLfdRHPe8vv6rM/wtbUw3eYQmGP3u0CwnFOfwxOKqQjAVkajxZWFn9kD
         0DsH4T1kAR5wTU+O6vVXQI6VX95Ey9YFBWr0DWR7OC/3YCg0PHbV2rJa0Ebypv/HTd5E
         EeK8LlnRtDz2AbOv5bQPsnXkdnFYZ9Ai9EG4JA/C0Y8joLJdwQmrdihIrBnbeWoXtrIx
         qIlcTXGSk57C9zraXn8VI0q5SYNR962GqtCxlZ7m9rVYwU2D2lsxkBcJVBCmvygUuULg
         Sp3w==
X-Gm-Message-State: AFqh2kqGjl7mtl0GOIqeKfXemyHOdjl5gzqy/vcXnHVC7sx9XQmDzh88
        hwvU/AiVBVztPX7UDVUlt9NRRysLx18=
X-Google-Smtp-Source: AMrXdXvj590jQ4cuSJsYid21AZrgyTvU232zWpp6A+1cM6zyr/WBseNyMFwpDJrXbNSo1Nw4eNKQLg==
X-Received: by 2002:a05:600c:3d10:b0:3d9:ee3d:2f54 with SMTP id bh16-20020a05600c3d1000b003d9ee3d2f54mr32765649wmb.13.1674494057280;
        Mon, 23 Jan 2023 09:14:17 -0800 (PST)
Received: from suse.localnet (host-79-36-37-176.retail.telecomitalia.it. [79.36.37.176])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c00d900b003daf672a616sm10976252wmm.22.2023.01.23.09.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:14:16 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Mon, 23 Jan 2023 18:14:15 +0100
Message-ID: <3146373.5fSG56mABF@suse>
In-Reply-To: <Y8os8QR1pRXyu4N8@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com> <Y8ohpDtqI8bPAgRn@ZenIV>
 <Y8os8QR1pRXyu4N8@ZenIV>
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

On venerd=EC 20 gennaio 2023 06:56:01 CET Al Viro wrote:
> On Fri, Jan 20, 2023 at 05:07:48AM +0000, Al Viro wrote:
> > On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:
> > > > Sure, but... there's also this:
> > > >=20
> > > > static inline void __kunmap_local(const void *addr)
> > > > {
> > > > #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> > > >=20
> > > >         kunmap_flush_on_unmap(addr);
> > > >=20
> > > > #endif
> > > > }
> > > >=20
> > > > Are you sure that the guts of that thing will be happy with address=
=20
that
> > > > is not page-aligned?  I've looked there at some point, got scared of
> > > > parisc (IIRC) MMU details and decided not to rely upon that...
> > >=20
> > > Ugh, PA-RISC (the only implementer) definitely will flush the wrong
> > > addresses.  I think we should do this, as having bugs that only manif=
est
> > > on one not-well-tested architecture seems Bad.
> > >=20
> > >  static inline void __kunmap_local(const void *addr)
> > >  {
> > >  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> > >=20
> > > -       kunmap_flush_on_unmap(addr);
> > > +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
> > >=20
> > >  #endif
> > >  }
> >=20
> > PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?
>=20
> 	Anyway, that's a question to parisc folks; I _think_ pdtlb
> quietly ignores the lower bits of address, so that part seems
> to be safe, but I wouldn't bet upon that.  And when I got to
> flush_kernel_dcache_page_asm I gave up - it's been a long time
> since I've dealt with parisc assembler.

There seems to be consensus that __kunmap_local() needs to be fixed for the=
=20
parisc case (ARCH_HAS_FLUSH_ON_KUNMAP).

Is anyone doing this task?

If you agree, I could make this change and give proper credits for the tip.

Thank you,

=46abio



