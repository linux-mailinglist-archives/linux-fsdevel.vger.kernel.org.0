Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2325197F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 09:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbiEDHV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345269AbiEDHV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 03:21:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EE21AF39
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 00:18:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba17so695096edb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeDEBC07UgqxsnebnTXHGSAnBgMOF2dSI/K4/ycdir4=;
        b=YU5OMd73Si+5Q7eezRvTwdPDhF0jXaVTuwFWRU724SKGGloQXdlPG0YIbvGIPIvCEh
         dbB6OBn/F3ingQg0jfPVD96Mzywvz5BjjGP6iFXZu+DCNmDCBkwsDrGygbU0vRiTBlSB
         lz1a0yhiew8HtumOPuAlYiBHyLzRep6vC6wrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeDEBC07UgqxsnebnTXHGSAnBgMOF2dSI/K4/ycdir4=;
        b=pcw3rxERdgbRZ/nmd7qeiRuR8oOpEg9oSX46LJyIm/FcdB3UKYHlSKWX/g3gG3njmm
         SosKRyeirYudRq5YevY/qSueNsghj7i7mNlZAKESJJz81eD4li96+iHxIZlnyjyeB3mC
         ahWfmTKm1C165aRLqbOaNbTVkVDbSD42RiazHvZHKj2hGw2y1gebd6/uvcutsyaKwfh3
         N1HV1vMo3jsCSEbuJh+weC6TBxA+wQtehWD5q5ZPWGcN8fQQNZWuLqV+yuQodEIHKMpX
         YJL+bOjjdpX3J+PzXkonK+ukRvH7pCTyD54J4pH7JfGC855XaQXvbfSEOcoQ9n9QdISn
         kR6A==
X-Gm-Message-State: AOAM531JkBBD3W8/U/1n4RPbIaSBrkTwAPc07cEcWfm8UrrqCNvcj28k
        xJ+ai+O8ZGjrP4EEh2gh3lNW1wgeI+vD/f/4QQyPVA==
X-Google-Smtp-Source: ABdhPJzPGISWNzSmwrZpgSCpom5e+dKvg459tFdiZ6LU4rFalV9aIdDy7O0Kq0ESHKyLyirLYCZEKqYQh1xQDoPwch4=
X-Received: by 2002:a50:9346:0:b0:425:e4c0:ab4b with SMTP id
 n6-20020a509346000000b00425e4c0ab4bmr21853531eda.154.1651648694663; Wed, 04
 May 2022 00:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220503224305.GF1360180@dread.disaster.area>
In-Reply-To: <20220503224305.GF1360180@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 May 2022 09:18:03 +0200
Message-ID: <CAJfpegt_p2Tg+Tr34PtKSXvTyTJdTTwALMPRVE8KK2NmNVZhEg@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 May 2022 at 00:43, Dave Chinner <david@fromorbit.com> wrote:

> "values" is a very generic name - probably should end up being
> something more descriptive of the functionality is provides,
> especially if the header file is going to be dumped in
> include/linux/. I don't really have a good suggestion at the moment,
> though.

The obvious ones are stat and attr, which are taken already.   Info is
probably too generic as well.

Ideas are welcome.

>
> ....
>
> > +
> > +enum {
> > +     VAL_MNT_INFO,
> > +};
> > +
> > +static struct val_desc val_mnt_group[] = {
> > +     { VD_NAME("info"),              .idx = VAL_MNT_INFO             },
> > +     { }
> > +};
> ....
> > +
> > +
> > +static struct val_desc val_toplevel_group[] = {
> > +     { VD_NAME("mnt:"),      .get = val_mnt_get,     },
> > +     { VD_NAME("mntns:"),    .get = val_mntns_get,   },
> > +     { },
> > +};
>
> I know this is an early POC, my main question is how do you
> envisiage this table driven structure being extended down from just
> the mount into the filesystem so we can expose filesystem specific
> information that isn't covered by generic interfaces like statx?

I was thinking of adding a i_op callback.   The details are a bit
fuzzy, since the vfs and the fs would have to work together when
listing the attributes and possibly also when retrieving the attribute
itself (think mount options).

Thanks,
Miklos
