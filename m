Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575684C71BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 17:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiB1QcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 11:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiB1QcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:32:05 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DD85BCE
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 08:31:26 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id e5so13516230vsg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEXCndZSqLw0KM8FF9WWJNcYaW+CrKBAI4mMearLYPA=;
        b=ANoxucz13gEbrU2XLyJD6T/y/p9MiAGAUqM62cR9ahEyy/aYJzqZDmd7hBIkvtPvy1
         xJr6OR3uS9molaigPyNOU44vUw3vClQbGNZvsckB+Lzc8zRvHP4e/sc81iswdocSlcwz
         mzVk6xW932C2C+84CVZgHEydzH2p6eY3ohp1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEXCndZSqLw0KM8FF9WWJNcYaW+CrKBAI4mMearLYPA=;
        b=HA2iupd0V38yeVJ1UB1ur/5FxDWJJ5hgZCtA0W1NAuRA5KtbuYG1UjVetjlQ25jaDS
         h6MmDpzQIzmu0KF6KD9e5e5pKkkCDpUqpJPj/0082TFxlckJXFqXSzs60yiVQ2CXCtNC
         l9aezTQd+KXxUBwabbYvRxghMVV7oZ/NmVIfmYRNs58HjH7rwINR2yBegVpST4nlN/Xb
         H8xrpB2JnLG7k+skcg8urLGa/2vfFuhlxoU/vLsCcX/LF7P4cIJjZAxOoWlceWkerjFL
         /sDm2pXHnUL2XDFBsyqLGgQ4Ug8YgJfe8Asjk/gu700xlrX+o1I0ImRkgHMQkgaS09KV
         uZ3Q==
X-Gm-Message-State: AOAM530SkdpPxApkPuAePiF8ohRn48xNFzSZiUEpGMi/sr55wH56LNCF
        Qvwc1kTqu9x6cKwzYmqZj/JhBEf/i+10va/D516nmg==
X-Google-Smtp-Source: ABdhPJxl9qhvXsw99bcbpm0zcQ74AP/OgSf/MYNZUyPpf3nKztuC8fS11Im4ziH++b6Yi5zrBpk+AdkBUkJhAQz8K4M=
X-Received: by 2002:a05:6102:32c7:b0:31b:8f98:5fd with SMTP id
 o7-20020a05610232c700b0031b8f9805fdmr7917679vss.24.1646065885559; Mon, 28 Feb
 2022 08:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20220228113910.1727819-1-amir73il@gmail.com> <20220228113910.1727819-5-amir73il@gmail.com>
 <CAJfpegvZefGp9NChm_69Km0FgpxwUs+og-uc2mpMAbH6mZ2azQ@mail.gmail.com> <CAOQ4uxgg8PDweNvkhXE20Gbb+=OGBbwLXjR6Yffc4ZkiKzGM0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgg8PDweNvkhXE20Gbb+=OGBbwLXjR6Yffc4ZkiKzGM0w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Feb 2022 17:31:14 +0100
Message-ID: <CAJfpegvnhsBB_Ym3VGs7xBQM3OWsXCsqBZncBVNFCDJXka_AwA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fs: report per-mount io stats
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        containers@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022 at 17:19, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 5:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 28 Feb 2022 at 12:39, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Show optional collected per-mount io stats in /proc/<pid>/mountstats
> > > for filesystems that do not implement their own show_stats() method
> > > and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.
> >
> > This would allow some filesystems to report per-mount I/O stats, while
> > leaving CIFS and NFS reporting a different set of per-sb stats.  This
> > doesn't sound very clean.
> >
> > There was an effort to create saner and more efficient interfaces for
> > per-mount info.  IMO this should be part of that effort instead of
> > overloading the old interface.
> >
>
> That's fair, but actually, I have no much need for per-mount I/O stats
> in overlayfs/fuse use cases, so I could amend the patches to collect and
> show per-sb I/O stats.
>
> Then, the generic show_stats() will not be "overloading the old interface".
> Instead, it will be creating a common implementation to share among different
> filesystems and using an existing vfs interface as it was intended.
>
> Would you be willing to accept adding per-sb I/O stats to overlayfs
> and/or fuse via /proc/<pid>/mountstats?

Yes, that would certainly be more sane.   But I'm also wondering if
there could be some commonality with the stats provided by NFS...

Thanks,
Miklos
