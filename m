Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E317439BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjF3Kl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjF3Kli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:41:38 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290993AB2;
        Fri, 30 Jun 2023 03:40:11 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-443571eda4dso652574137.2;
        Fri, 30 Jun 2023 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688121560; x=1690713560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S5SNIrYIQC7s8CLhmu3WBaoXezduKyzDpeMyWxh9mI=;
        b=bqbUdzlizyZC2U0ZnSFDIlh6fP7zrgcdQgibBojukgPizi/aqT0QETlu4bTr3IpBx4
         OmceahJMVWrUBvUvwfMo9WiiB7Oc10HrpdDajk3ILIVJ2O4718RmOg/Gzc3tgAyTVlZb
         zFkQmpgQBKh+5m2XYFtAjyLutBeL2t+ShBhHQKSRroHoXjibVCdK27BO1+mwz+95WY5q
         2Te6JLOOQkhfpiMRQ4vph7eQ7DKrdGNaJ3q+il4m3zE5rV43q8GkknQSL14vrQOs952c
         3yUwbcZU52A8QhgzPkIuOt03F2Fu5qfvOrrGWDUMMTlgHqAXU9VgzbhNzoZIByUv6aC1
         cwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121560; x=1690713560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S5SNIrYIQC7s8CLhmu3WBaoXezduKyzDpeMyWxh9mI=;
        b=eyGKAFybt7kQGjhTtp+Re1bip3T9kQN0byQ+WJ80MB5H9rBXo74b06ETTh5w5A7X4d
         1M0ofp2WKdAIAX5JfzSbf68R2ZRlYK4/BkOwzATMnDCo0xOohUyPTDh5FRIh3RbDv032
         irr9GkoaOjlw91E1mRgaz+Ws2yZVc2M78EDCmZ80Ix//FbdKxcAZRilWhUzqC6a8tOPA
         ZwPP9NqohTcYGOTQk7grr4d40e6AWWLhRioWrbb/uPJ/W2M1zZLpNMGT48YoAnDCwWj+
         jCzSvONZVlLyIJNN4I0HclQ0egG8NAIhgE/lgOyZ74H51vnWg5ptQ2wC3UWgY4ccL9Zr
         H1Mw==
X-Gm-Message-State: ABy/qLaZ9fBYY5p/79IZo+AaQE3GP+Ls5ksga6oCAhAiaguO01EJhgDL
        j5C0d2T2goO+Nx44+59Ov86igvYVayq1OgJ4Sb4=
X-Google-Smtp-Source: APBJJlGEBqMWr+ijbSey/HvnuL4Uz3TGMVCiIvyCerl5knxdgN+U6YC0FlcmRdPeMb+YIumDlIywAkDmPI6kTB9/QXs=
X-Received: by 2002:a05:6102:97:b0:444:59e2:f700 with SMTP id
 t23-20020a056102009700b0044459e2f700mr1686576vsp.7.1688121559691; Fri, 30 Jun
 2023 03:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org> <20230629181408.GM11467@frogsfrogsfrogs>
 <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
In-Reply-To: <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Jun 2023 13:39:08 +0300
Message-ID: <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to stale
 cached iomap
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Leah Rumancik <lrumancik@google.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 10:31=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.=
com> wrote:
>
> On Thu, Jun 29, 2023 at 7:14=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > [add the xfs lts maintainers]
> >
> > On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > > > Hi Dave and Derrick,
> > > >
> > > > We are tracking down some corruptions on xfs for our rocksdb worklo=
ad,
> > > > running on kernel 6.1.25. The corruptions were
> > > > detected by rocksdb block checksum. The workload seems to share som=
e
> > > > similarities
> > > > with the multi-threaded write workload described in
> > > > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@drea=
d.disaster.area/
> > > >
> > > > Can we backport the patch series to stable since it seemed to fix d=
ata
> > > > corruptions ?
> > >
> > > For clarity, are you asking for permission or advice about doing this
> > > yourself, or are you asking somebody else to do the backport for you?
> >
> > Nobody's officially committed to backporting and testing patches for
> > 6.1; are you (Cloudflare) volunteering?
>
> Yes, we have applied them on top of 6.1.36, will be gradually
> releasing to our servers and will report back if we see the issues go
> away
>

Getting feedback back from Cloudflare production servers is awesome
but it's not enough.

The standard for getting xfs LTS backports approved is:
1. Test the backports against regressions with several rounds of fstests
    check -g auto on selected xfs configurations [1]
2. Post the backport series to xfs list and get an ACK from upstream
    xfs maintainers

We have volunteers doing this work for 5.4.y, 5.10.y and 5.15.y.
We do not yet have a volunteer to do that work for 6.1.y.

The question is whether you (or your team) are volunteering to
do that work for 6.1.y xfs backports to help share the load?

If your employer is interested in running reliable and stable xfs
code with 6.1.y LTS, I recommend that you seriously consider
this option, because for the time being, it doesn't look like any
of us are able to perform this role.

For testing, you could establish your own baseline for 6.1.y or, you
could run kdevops and use the baseline already established by
other testers for the selected xfs configurations [1].

I can help you get up to speed with kdevops if you like.

Thanks,
Amir.

[1]  https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests=
/expunges/6.1.0-rc6/xfs/unassigned
