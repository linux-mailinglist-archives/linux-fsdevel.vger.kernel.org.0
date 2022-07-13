Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A45573BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiGMR1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiGMR1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:27:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B392317F
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:27:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z23so4514147eju.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v8CSOgr9aUSE91CSJhvQBrmllj7lg1nojWRHXxI8X8U=;
        b=TFEL2Llsbz5A9VR1G3A3juGjqWSnWQ3MzATTAP2+miRXLOwq6MWR43oMw2qrI9XJWA
         l2Tx6e170s8Of15eND4toA7anPfGK7kBqlh9VA08dvD51I2U4H8wnb8/jdjBgU1VAxSm
         pmFymJ+r8kRmwJFApW00vmh8F7paEnO/CQxrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v8CSOgr9aUSE91CSJhvQBrmllj7lg1nojWRHXxI8X8U=;
        b=4J/+f0nMtRAZur8Z08DikFY4eXQaG/gxIGC/zOTLHzmuYjvZyWWQkCWTQX2Xomkmmp
         pX8VCS6JDPnU3+4ANcMKfZu48Y692ylpyp1BRolFxBbgdRbg26wvu7eSPs/9JTyaTc3e
         XGeoKY+2Biv68um3aFu3tAdUboiP8cNdfJrkyGc2RkOR8209uKDCPkOgvTIx3YYHNthK
         tIVflq59axQlLj5BKTwULzwt+l3f33FhzqzOIBWBpQRJ7E5R66xIBRA6/3B5AZRy50sy
         BYACNK+buPz3LgKYoPC6Oq62x9y4GufJwUKgtTlvFDoq6YqjP74hh9izLhaTcdc0jgqg
         qINA==
X-Gm-Message-State: AJIora/PC/VxeJ0y36doEpvYNA2fxZnvT1Dx9GAmxWQlEVietiX+QCGx
        0+MvGse+Z0oKfA3MbFGxb8qKLArI0lc3OuWVfGY=
X-Google-Smtp-Source: AGRyM1sEb40mNCQJ5rUbyeMA0am2wAD0he1V3Z/XXHB99fCAzJt1qf3DpWigkQwSTSUGxEyNjuVZeA==
X-Received: by 2002:a17:907:2848:b0:72b:5ba5:1db5 with SMTP id el8-20020a170907284800b0072b5ba51db5mr4777559ejc.703.1657733221213;
        Wed, 13 Jul 2022 10:27:01 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090630cd00b0072637b9c8c0sm5196524ejb.219.2022.07.13.10.27.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 10:27:00 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id bk26so16425611wrb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:27:00 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr4215235wrv.281.1657733219820; Wed, 13
 Jul 2022 10:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain> <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia> <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area> <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de>
In-Reply-To: <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Jul 2022 10:26:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
Message-ID: <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
Subject: Re: [PATCH] fs/remap: constrain dedupe of EOF blocks
To:     ansgar.loesser@kom.tu-darmstadt.de
Cc:     Dave Chinner <david@fromorbit.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:18 AM Ansgar L=C3=B6=C3=9Fer
<ansgar.loesser@tu-darmstadt.de> wrote:
>
> The proposed fix is to return the actual amount of bytes that got
> deduplicated, instead of the input length.

Ack, that patch seems obviously correct.

Mind sending it with a sign-off and a short commit message?

             Linus
