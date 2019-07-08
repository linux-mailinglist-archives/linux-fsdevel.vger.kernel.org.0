Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0C6271D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfGHR3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 13:29:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34761 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfGHR3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:29:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so17045518otk.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 10:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nA6Jna13w+RzGgaq8zqHZyOTzP+Rl2ic3AndNFYmYd4=;
        b=AFB315xLziXd6fMwsmGYrjrVzce9Lo90h1aBil5lDsltFkW4M0LOZ/6PsZAPSMHbGf
         f2i+vjHaBTefqrvwf1GENPSidfRdyJ+LxpfJfNHyYyQXIoa8KBCJL5i6PZNa31mlYEdB
         NQQnKJQsXPiEiGjWPKT4eL2c5vVIr9/Kwx87xUh3eNFDJuNYQ+TSm6SIMKt9HVZgnVrY
         fpJRrVbYHKdo5z4jARGLivrKKRwc9jb20lPESqk5njQuDNzDfVz2meQQNykpwpmIR7MR
         yCSLWH23xz3gL3VPPV+rZKmAr+3tMbub/9Ig98rT2chvtz00cvGNAbwiMIXkx32Bj5fx
         eb2Q==
X-Gm-Message-State: APjAAAWAJOgC16l22V50ZLHDB1UcGm8f9/hr4F/TtxyXSoduflGMceX1
        ogrLjpZaUZDh9wNGhP3D1CQXmYJMtDk/eTcmMx1e8A==
X-Google-Smtp-Source: APXvYqx0RPvy74yzmrSczU2RfOeT51FXoyiAVwrmEDfjnlD9nHbQUGYVCsDvdT1tpWknkWW1QJvBsFLFOqZUsxSEAWw=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr15913810oti.341.1562606972599;
 Mon, 08 Jul 2019 10:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190701215439.19162-1-hch@lst.de> <CAHc6FU5MHCdXENW_Y++hO_qhtCh4XtAHYOaTLzk+1KU=JNpPww@mail.gmail.com>
 <20190708160351.GA9871@lst.de>
In-Reply-To: <20190708160351.GA9871@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 8 Jul 2019 19:29:21 +0200
Message-ID: <CAHc6FU5942i0XrCjUAhR9NCmfLuu7_CoPXNDsdF0X+gCpF1cDQ@mail.gmail.com>
Subject: Re: RFC: use the iomap writepage path in gfs2
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 8 Jul 2019 at 18:04, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jul 04, 2019 at 12:35:41AM +0200, Andreas Gruenbacher wrote:
> > Patch "gfs2: implement gfs2_block_zero_range using iomap_zero_range"
> > isn't quite ready: the gfs2 iomap operations don't handle IOMAP_ZERO
> > correctly so far, and that needs to be fixed first.
>
> What is the issue with IOMAP_ZERO on gfs2?  Zeroing never does block
> allocations except when on COW extents, which gfs2 doesn't support,
> so there shouldn't really be any need for additional handling.

We still want to set iomap->page_ops for journalled data files on gfs2.

Also, if we go through the existing gfs2_iomap_begin_write /
__gfs2_iomap_begin logic for iomap_zero_range, it will work for
stuffed files as well, and so we can replace stuffed_zero_range with
iomap_zero_range.

> > Some of the tests assume that the filesystem supports unwritten
> > extents, trusted xattrs, the usrquota / grpquota / prjquota mount
> > options. There shouldn't be a huge number of failing tests beyond
> > that, but I know things aren't perfect.
>
> In general xfstests is supposed to have tests for that and not run
> the tests if not supported.  In most cases this is automatic, but
> in case a feature can't be autodetect we have a few manual overrides.

Yes, that needs a bit of work. Let's see.

Thanks,
Andreas
