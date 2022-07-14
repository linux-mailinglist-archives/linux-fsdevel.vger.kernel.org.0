Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB85740BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 03:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiGNBEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 21:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiGNBEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:04:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7918385
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 18:04:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r6so497993edd.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 18:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/tLwRZh427z3A2l6jBp7FiEKD1d/gnBbyaqRrWbtcA=;
        b=hutDit+S5ymytLdUVwMlIZhQ0zz0djgiSTo1cIUlu7PTOEjv7boXAhzlGkbC3ptOYU
         79mlq05/Fa31yFnOwZej4awZZCnhvtPglkoEK/txgXJAWa4/buaJDu2Y5kcRRdvmwbvt
         fEZWqoXHDSGGIB8kWMXoU7QC1vIV7iD3yEMMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/tLwRZh427z3A2l6jBp7FiEKD1d/gnBbyaqRrWbtcA=;
        b=itz9BwviAuuhn4pwNDxdkF7x6FwHAS4hoO3EKX0jAOZvBx8RZU+Kdb3vgEcbIg/qaL
         jbXOs0AcFXNhN3ZhR4FM01eXrICPQBTB6zlQYwhrOfy0UTf6TB2FS/o5Ncjz8wkIBey1
         IYfBAjDHXUS/emitP2KBO6xBJWxVCsgpE80PVZJ7TPGwcSVz6uC27dwZd1v7gFjbMFFy
         /ZYkHyMRBeXfXT+h7XLHtfMmDEGUfnalTcUTmQKQ9qTC5cXm6k6LVhCEATDDBMGK2GEc
         M6wcOLVU7J9Dim2DlwtyUkkNYhAgvotzoRx6rUtlQxg0hgoUlhnJYVb3Vm91xAu/l5zK
         wyAQ==
X-Gm-Message-State: AJIora8MsIDZT180bFxNcXq29vgV2woNMpr/bW1Tk5pC0Dp2wFDhL0EM
        CmSgeqqF6EXeTc8vbRHPBId1n364flZCVhjYtV0=
X-Google-Smtp-Source: AGRyM1tXi1hFYHRO/StuZPlAtGKo9U9CoMn/LzYL/kKbFy9tzHXClRtb0ueWnVYaalolb4fgwhXwLA==
X-Received: by 2002:aa7:c650:0:b0:43a:2c9a:fd1f with SMTP id z16-20020aa7c650000000b0043a2c9afd1fmr8676656edr.318.1657760638852;
        Wed, 13 Jul 2022 18:03:58 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id v6-20020aa7d806000000b0043a754d53e5sm117455edq.78.2022.07.13.18.03.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 18:03:56 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n185so110919wmn.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 18:03:55 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id
 i14-20020a05600c354e00b003a19ddf468dmr12241218wmq.145.1657760634986; Wed, 13
 Jul 2022 18:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area> <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de> <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
 <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de> <20220714002219.GG3600936@dread.disaster.area>
In-Reply-To: <20220714002219.GG3600936@dread.disaster.area>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 18:03:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkrDDQrmujaFNzH-k-zBuEwhpDfMTR0Am5fSyB=bgoGQ@mail.gmail.com>
Message-ID: <CAHk-=wgkrDDQrmujaFNzH-k-zBuEwhpDfMTR0Am5fSyB=bgoGQ@mail.gmail.com>
Subject: Re: [PATCH] vf/remap: return the amount of bytes actually deduplicated
To:     Dave Chinner <david@fromorbit.com>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 5:22 PM Dave Chinner <david@fromorbit.com> wrote:
>
> e.g. If userspace is looping over a file based on the returned
> info->bytes_deduped value, can this change cause them to behave
> differently? e.g. get stuck in an endless loop on the EOF block
> always returning SAME/0 instead of DIFFER?

I don't think that case can actually happen.

There's a couple of cases where the length is updated

 (a) an initial zero length request is turned into "size of file".

Here,we'd obviously want to return that size. Plus the original len
was 0 anyway, so it already used that 0 before. Ugh.

 (b) an EOF situation with REMAP_FILE_CAN_SHORTEN does that

                *len = new_len;

but afaik "new_len" can never be zero (because if it was, that would
have been blk-aligned to begin with, and not have reached that code)

But you are right, the whole "SAME/0" return is all kinds of crazy,
and maybe that code should make explicitly sure it can never happen by
just saying "a zero-sized compare can never dedupe successfully" or
something like that. Just in case.

But returning the original length, even when you didn't actually
dedupe it also seems entirely pointless.

            Linus
