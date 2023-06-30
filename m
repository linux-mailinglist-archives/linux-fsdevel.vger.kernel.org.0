Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A994F743BE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF3Map (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjF3Man (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:30:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865830F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 05:30:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e6541c98so1532195b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688128242; x=1690720242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=690i7ymbtGAPkXlZHW40Mqi14d78QphTHjVtfQzIgdI=;
        b=m9xDgJmGeJ+xVhn5yFZxCsGIulO0zsQJ2Oz9n9ALX+/gVlIFqUNVdSXVMJH5WSXrnq
         fWwHtdfoTHRGT7gW1kaa85qyUxm8/5wb2i1gql7D+p87jQLozqnECffAAOaiBwyXVYlT
         Ftjx1V0bGO7HxCRx5SVDsSqazrQjk1+TJGtBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688128242; x=1690720242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=690i7ymbtGAPkXlZHW40Mqi14d78QphTHjVtfQzIgdI=;
        b=hOcXdRcGbjX8vl3Au0kETeidQLD2WRepxiS/BcovLUU1A/j6A+SIEUtYuDAix1ixFM
         DCxutRYAqFasa6Su65SwNXPP9YIBxBFrkGrPm7WZHtjTOmyPbUGuVBYe7nrVcyD8Cx8U
         dAt6eqqLKQ9r/csDma8qcMB6zT8boWB7AJv6LhJ5Sc4cWkHuxpdVpjc5rsQP+Jxcpfvj
         DYGk7eg2CpctSLwK+K78qVAni9FOhE3WaeQE5WwTP9WT5+Hqj4aZe2UnlC8GULNRM/0t
         R7gSJPOUhASWyYXq8TfmEL3BGr36TXPM87/39aUUDwSgbGcEEJxPk6qaSCcP97dnkFp4
         xLDw==
X-Gm-Message-State: ABy/qLaAeB25ivk+uMP+jvZeFk29jAX0uLKfyduvAXGitKWdWD/b9VPO
        18QdtGYqVKVVHLA4BNgQp6VqZizmugmUa0FraQuSmg==
X-Google-Smtp-Source: APBJJlFn75kD6sDFj1gn3VWRn8fT860AgxWwAE4FUckhbNuj9GzlfZMZWtAPhgOQOObFLwZ5VNxyPm0Tt1MAxSbYjSY=
X-Received: by 2002:a05:6a00:c85:b0:64d:46b2:9a58 with SMTP id
 a5-20020a056a000c8500b0064d46b29a58mr3582975pfv.26.1688128241649; Fri, 30 Jun
 2023 05:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org> <20230629181408.GM11467@frogsfrogsfrogs>
 <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com> <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri, 30 Jun 2023 13:30:30 +0100
Message-ID: <CALrw=nHH2u=+utzy8NfP6+fM6kOgtW0hdUHwK9-BWdYq+t-UoA@mail.gmail.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to stale
 cached iomap
To:     Amir Goldstein <amir73il@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:39=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Jun 29, 2023 at 10:31=E2=80=AFPM Ignat Korchagin <ignat@cloudflar=
e.com> wrote:
> >
> > On Thu, Jun 29, 2023 at 7:14=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > [add the xfs lts maintainers]
> > >
> > > On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> > > > On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > > > > Hi Dave and Derrick,
> > > > >
> > > > > We are tracking down some corruptions on xfs for our rocksdb work=
load,
> > > > > running on kernel 6.1.25. The corruptions were
> > > > > detected by rocksdb block checksum. The workload seems to share s=
ome
> > > > > similarities
> > > > > with the multi-threaded write workload described in
> > > > > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dr=
ead.disaster.area/
> > > > >
> > > > > Can we backport the patch series to stable since it seemed to fix=
 data
> > > > > corruptions ?
> > > >
> > > > For clarity, are you asking for permission or advice about doing th=
is
> > > > yourself, or are you asking somebody else to do the backport for yo=
u?
> > >
> > > Nobody's officially committed to backporting and testing patches for
> > > 6.1; are you (Cloudflare) volunteering?
> >
> > Yes, we have applied them on top of 6.1.36, will be gradually
> > releasing to our servers and will report back if we see the issues go
> > away
> >
>
> Getting feedback back from Cloudflare production servers is awesome
> but it's not enough.
>
> The standard for getting xfs LTS backports approved is:
> 1. Test the backports against regressions with several rounds of fstests
>     check -g auto on selected xfs configurations [1]
> 2. Post the backport series to xfs list and get an ACK from upstream
>     xfs maintainers
>
> We have volunteers doing this work for 5.4.y, 5.10.y and 5.15.y.
> We do not yet have a volunteer to do that work for 6.1.y.
>
> The question is whether you (or your team) are volunteering to
> do that work for 6.1.y xfs backports to help share the load?

We are not a big team and apart from other internal project work our
efforts are focused on fixing this issue in production, because it
affects many teams and workloads. If we confirm that these patches fix
the issue in production, we will definitely consider dedicating some
work to ensure they are officially backported. But if not - we would
be required to search for a fix first before we can commit to any
work.

So, IOW - can we come back to you a bit later on this after we get the
feedback from production?

> If your employer is interested in running reliable and stable xfs
> code with 6.1.y LTS, I recommend that you seriously consider
> this option, because for the time being, it doesn't look like any
> of us are able to perform this role.
>
> For testing, you could establish your own baseline for 6.1.y or, you
> could run kdevops and use the baseline already established by
> other testers for the selected xfs configurations [1].
>
> I can help you get up to speed with kdevops if you like.

This looks interesting (regardless of this project). We will explore
it and come back with questions, if any.

>
> Thanks,
> Amir.
>
> [1]  https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstes=
ts/expunges/6.1.0-rc6/xfs/unassigned

Ignat
