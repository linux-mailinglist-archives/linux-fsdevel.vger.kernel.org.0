Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B047C5730E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiGMIXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiGMIWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:22:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16284EF9E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 01:19:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dn9so18496308ejc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J86sz5rjD8S+RdbPShd8K7hNcQHOtA9wJfy8AFqqeMo=;
        b=DtG5GreWkOvUw7ZmfWHj8D+qYW+12PaUFLiNXyptwuMG4aJM7rIHwZzNFjGIl4wHbX
         4hO1ICGODGB9mJBahqidY2pciTVGfRgp8xz74GC2hSB5pbIt5mUePXJSQAFWei1jWxBF
         QOvQwgdCXR0ScJVLN2tGqe47JJwH4Je9Ldn04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J86sz5rjD8S+RdbPShd8K7hNcQHOtA9wJfy8AFqqeMo=;
        b=gg2J31U91UhOHU9lvpd4QPmRo1yWBoIAempbBZMZfOPs6Mx1jr5ru45tOZdtOr17ws
         w5MImkqxZ2sUJNm/T8MN1qeinclRXuMtxKc8EMIXkraUR1y5IBjvOTLRlfp0idze14Kb
         HESgc+JUiBjrjz4xq5RTOzAKQJTI46QIeiIJow+DqjydxhAqn1FnsKbmkpKIGpo50tx0
         U/Wt2tG78qPGBY85ry0qAIacYqlOtwQAU4DV/q8vqMgxxBge4w/kbxbKZy/GfkGNSWiJ
         Eo1JtZ6MSkHrQFqR5j1+9vv47cZoz+VLv6eu1wdLkvwKmtt2Tb3Xt7ffIMEFCIOK850g
         4HBA==
X-Gm-Message-State: AJIora9cgv+BIQMjVDJ0Z44Er2818XAbu3RzwewShhb3fDHI2DlHBAii
        mnlhODrst0tZR/Hatahtpg2kGE1FoA1Go1P7nNQ=
X-Google-Smtp-Source: AGRyM1utxqtN9ctGu1L59dS2dwQTGDrBAfBpnYpIZsvZA6V6Bf056Irdu7seJxS8bfZNKJ1mZhbWXg==
X-Received: by 2002:a17:907:72cf:b0:72b:9943:4caf with SMTP id du15-20020a17090772cf00b0072b99434cafmr2098714ejc.370.1657700391113;
        Wed, 13 Jul 2022 01:19:51 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d6d1000000b0043a71775903sm7472820edr.39.2022.07.13.01.19.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:19:50 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id n185so6047302wmn.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 01:19:49 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr2238954wmq.8.1657700389618; Wed, 13 Jul
 2022 01:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area> <20220713074915.GD3600936@dread.disaster.area>
In-Reply-To: <20220713074915.GD3600936@dread.disaster.area>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 01:19:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjipbt1gq5c+NV5XbtQcp9sc3OJcphA-6b+ocHQHLkbPw@mail.gmail.com>
Message-ID: <CAHk-=wjipbt1gq5c+NV5XbtQcp9sc3OJcphA-6b+ocHQHLkbPw@mail.gmail.com>
Subject: Re: [PATCH] fs/remap: constrain dedupe of EOF blocks
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
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

On Wed, Jul 13, 2022 at 12:49 AM Dave Chinner <david@fromorbit.com> wrote:
>
> Fix this by constraining the EOF block matching to only match
> against other EOF blocks that have identical EOF offsets and data.

So I agree that this patch fixes the bug, but I just spent a long time
writing an email about how I think it makes oddly written and fairly
incomprehensible code even harder to read.

This is likely a minimal patch and as such good for backporting (and
just for "current stage of release cycle too" for that matter), but I
*really* think the code here could do with a nice chunk of cleanup.

               Linus
