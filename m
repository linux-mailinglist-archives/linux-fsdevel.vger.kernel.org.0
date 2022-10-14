Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A535FEEEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJNNsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJNNsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:48:07 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B5E106E23
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 06:48:06 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id f35-20020a0565123b2300b004a442356475so1660483lfv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiT4AGCUafLoWk2pbrHo53OIgKYTElZc1R+Afi5d73I=;
        b=cQ+NKquQ/ldSjGX4EJ8OLK4ogWivX0GdXKT4EZ8E/QdhOMBcueIkAC0xr6OxDaRDYM
         +tATfZPmv1h53MAXVlvW6sTBatupqhAGwCKXjDrLqSRkOQ3MDkNlFkPziiaKIABE5hmo
         tjv6ccHnxLp8jlI5dhPUSUtrsbwg0mOJjGS6h1CPeIEH9tTXylG8bSanvx7wRwYRJAba
         uQLNVdR+W6ZXLhNRiOha8/AcyGVywyyJoS+8d9MtYyY2/122/PCTOWirAsysu7eTofIE
         j4u49Anavdk7FmDseRf/UVUI2StrsJNSuH1Q2jcM3gj+Adr0/HGcz0LJ2cnkD1c0wcaA
         Q4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aiT4AGCUafLoWk2pbrHo53OIgKYTElZc1R+Afi5d73I=;
        b=3I3WSaGWYm8ufiG1RuyjFmkLC3lhLsDhLYUy+K8EqmRTswnjeP1SQc0W+w7zCEnhPf
         TWyqGlnBnqdjtw9avIoqiGpFSvAvgK7YRWveSFZYr7iSSEpKBotHnM6wnZaJEzP8cRHc
         1KoBw6BgDTlnjm8QCyWCffjPdgRGUvvnuNEvRvwaMB6tkIqPqv/fdTo2lVPdBgTjZZlz
         cBoHLmy5Xt9vHcyYkW8Gik/l2O9rikWw+URpsQHC2cxqC0+i3SIBOGMnStOypyrYf2Z5
         IVHX2e+FueJRSKUuIRB2jJh8JhXFtGHYfo2ZHzKhnLWbND6AzQJspzY2F0eXM0g2ZIoC
         pc+Q==
X-Gm-Message-State: ACrzQf3ucfEN3h8YdZutcfZKSaV3znEL5OC0PB5xSCFyBx+FkmtVSbjA
        yUBTk2Orcnww6TCpnqSdtGqi5fziQ1K2
X-Google-Smtp-Source: AMsMyM6fAAMwou9/zT1qtfIkwskBg+TuKICMRMPbatPuP2ZTJQELmBdb4OuYKL3cJ8Y/9OwlVd/w/gMEaLLo
X-Received: from mdanylo.waw.corp.google.com ([2a00:79e0:9b:0:9507:b1bd:1910:a25d])
 (user=mdanylo job=sendgmr) by 2002:a05:651c:4ca:b0:26c:50be:5df6 with SMTP id
 e10-20020a05651c04ca00b0026c50be5df6mr1791206lji.177.1665755284565; Fri, 14
 Oct 2022 06:48:04 -0700 (PDT)
Date:   Fri, 14 Oct 2022 15:48:02 +0200
In-Reply-To: <Y0T2l3HaH2MU8M9m@gmail.com>
Mime-Version: 1.0
References: <Y0T2l3HaH2MU8M9m@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221014134802.1361436-1-mdanylo@google.com>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
From:   Danylo Mocherniuk <mdanylo@google.com>
To:     avagin@gmail.com
Cc:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        gregkh@linuxfoundation.org, kernel@collabora.com,
        krisman@collabora.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mdanylo@google.com, peter.enderborg@sony.com, shuah@kernel.org,
        surenb@google.com, usama.anjum@collabora.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, emmir@google.com,
        figiel@google.com, kyurtsever@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 6:52 AM Andrei Vagin <avagin@gmail.com> wrote:
>
> On Mon, Oct 03, 2022 at 04:21:22PM +0500, Muhammad Usama Anjum wrote:
> > On 9/28/22 10:24 PM, Andrei Vagin wrote:
> > > On Wed, Sep 21, 2022 at 11:26 AM Muhammad Usama Anjum
> > > <usama.anjum@collabora.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> Thank you for reviewing.
> > >>
> > >> On 9/19/22 7:58 PM, Andrei Vagin wrote:
> > >>>> This ioctl can be used by the CRIU project and other applications =
which
> > >>>> require soft-dirty PTE bit information. The following operations a=
re
> > >>>> supported in this ioctl:
> > >>>> - Get the pages that are soft-dirty.
> > >>>
> > >>> I think this interface doesn't have to be limited by the soft-dirty
> > >>> bits only. For example, CRIU needs to know whether file, present an=
d swap bits
> > >>> are set or not.
> > >> These operations can be performed by pagemap procfs file. Definitely
> > >> performing them through IOCTL will be faster. But I'm trying to add =
a
> > >> simple IOCTL by which some specific PTE bit can be read and cleared
> > >> atomically. This IOCTL can be extended to include other bits like fi=
le,
> > >> present and swap bits by keeping the interface simple. The following
> > >> mask advice is nice. But if we add that kind of masking, it'll start=
 to
> > >> look like a filter on top of pagemap. My intention is to not duplica=
te
> > >> the functionality already provided by the pagemap. One may ask, then=
 why
> > >> am I adding "get the soft-dirty pages" functionality? I'm adding it =
to
> > >> complement the get and clear operation. The "get" and "get and clear=
"
> > >> operations with special flag (PAGEMAP_SD_NO_REUSED_REGIONS) can give
> > >> results quicker by not splitting the VMAs.
> > >
> > > This simple interface is good only for a limited number of use-cases.
> > > The interface
> > > that I suggest doesn't duplicate more code than this one, but it is m=
uch more
> > > universal. It will be a big mess if you add a separate API for each
> > > specific use-case.
> > >
> > >
> > >>> I mean we should be able to specify for what pages we need to get i=
nfo
> > >>> for. An ioctl argument can have these four fields:
> > >>> * required bits (rmask & mask =3D=3D mask) - all bits from this mas=
k have to be set.
> > >>> * any of these bits (amask & mask !=3D 0) - any of these bits is se=
t.
> > >>> * exclude masks (emask & mask =3D=3D 0) =3D none of these bits are =
set.
> > >>> * return mask - bits that have to be reported to user.
> > The required mask (rmask) makes sense to me. At the moment, I only know
> > about the practical use case for the required mask. Can you share how
> > can any and exclude masks help for the CRIU?
> >
>
> I looked at should_dump_page in the CRIU code:
> https://github.com/checkpoint-restore/criu/blob/45641ab26d7bb78706a6215fd=
ef8f9133abf8d10/criu/mem.c#L102
>
> When CRIU dumps file private mappings, it needs to get pages that have
> PME_PRESENT or PME_SWAP but don't have PME_FILE.

I would really like to see the mask discussed will be adopted. With it CRIU=
 will
be able to migrate huge sparse VMAs assuming that a single hole is processe=
d in=20
O(1) time.=20

Use cases for migrating sparse VMAs are binaries sanitized with ASAN, MSAN =
or
TSAN [1]. All of these sanitizers produce sparse mappings of shadow memory =
[2].
Being able to migrate such binaries allows to highly reduce the amount of w=
ork
needed to identify and fix post-migration crashes, which happen constantly.

>
> > >>>> - Clear the pages which are soft-dirty.
> > >>>> - The optional flag to ignore the VM_SOFTDIRTY and only track per =
page
> > >>>> soft-dirty PTE bit
> > >>>>
> > >>>> There are two decisions which have been taken about how to get the=
 output
> > >>>> from the syscall.
> > >>>> - Return offsets of the pages from the start in the vec
> > >>>
> > >>> We can conside to return regions that contains pages with the same =
set
> > >>> of bits.
> > >>>
> > >>> struct page_region {
> > >>> =C2=A0 =C2=A0 =C2=A0 void *start;
> > >>> =C2=A0 =C2=A0 =C2=A0 long size;
> > >>> =C2=A0 =C2=A0 =C2=A0 u64 bitmap;
> > >>> }
> > >>>
> > >>> And ioctl returns arrays of page_region-s. I believe it will be mor=
e
> > >>> compact form for many cases.
> > >> Thank you for mentioning this. I'd considered this while development=
.
> > >> But I gave up and used the simple array to return the offsets of the
> > >> pages as in the problem I'm trying to solve, the dirty pages may be
> > >> present amid non-dirty pages. The range may not be useful in that ca=
se.
> > >
> > > This is a good example. If we expect more than two consequent pages
> > > on average, the "region" interface looks more prefered. I don't know =
your
> > > use-case, but in the case of CRIU, this assumption looks reasonable.

Plus one for page_region data structure. It will make ASAN shadow memory
representation much more compact as well as any other classical use-case.=
=20

[1] https://github.com/google/sanitizers=09
[2] https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-=
bit=09

Best,
Danylo

