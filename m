Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52D61FF17F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgFRMVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 08:21:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35957 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727106AbgFRMVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592482898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVIx3Lw3mCtvicq1Con/Tph1Hck+YrpwlfvxN0WeRQA=;
        b=J/DN6BZSvzdN9abhvs2S0wzX+2nwhdiHBw3NOOzeq/q+d7NwTJ/0K7CJPzhMzxDKMwQw4d
        FUBbJKTl63NmnclxJ8rWHuJGyO/x5bk5lS/NLc1UzemSYEO5oX/RuYIcYBKe+dd5DGzuC8
        Vqo2Hiize4hhcDRnLtMEz2AEw8FsxCc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-ARy7cjGENlS_1a2DRM-BpQ-1; Thu, 18 Jun 2020 08:21:36 -0400
X-MC-Unique: ARy7cjGENlS_1a2DRM-BpQ-1
Received: by mail-ot1-f70.google.com with SMTP id m5so2506728otp.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 05:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVIx3Lw3mCtvicq1Con/Tph1Hck+YrpwlfvxN0WeRQA=;
        b=KYbkQP2g7JVArbi8r2oeuc6qqtBe2C1ETH4L18cPCL2sRRu/6UgR1+7C3aZ5wyN6rZ
         ILJDoeqnojZTqA+lkPURqj7/EFJWm2CUNTiT39YpHbVPP128ZZ4+NBXYShAEEYwoTPRX
         NQBneJTDz2Uk9e8EW4YVzG3CkJH7X5q/qBh30PSNh7z6eK5W0i12W3ehR/xrQTR1K4FX
         yKUd+ptdhGLu8kubUOnuCeOjdBO59wSXAvjzg/dvlu9Y2OrORrWrmtck7dp3Ic5ODeLW
         0uPsMR7LKrxvo2T+4JL9UqtLLOCMd/ld6zQCYa7aShqPf2VYMhFIpyCIz5BE10axp3wM
         S3rw==
X-Gm-Message-State: AOAM533MzW43YkIO3fVMlbOhVl8EUMivGHiov+r/XO5kosUqPUWIbu2v
        lUx9jc0bJoeM1EQ8xuJq2X2im3I72yBqNw8LYlowT5M8Nx8I3Z1l9JjNq7dMZiJg42rypq6Rqvf
        QSAMM4Tl6eafzDNj0wR2MjKYz/I4yjsun8V/o2E23Sg==
X-Received: by 2002:a4a:e049:: with SMTP id v9mr3772923oos.22.1592482895725;
        Thu, 18 Jun 2020 05:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8Vz5RoMaRMnhgrKw5BwObY2thiM8ANkKOLKrEUi3X7FXXUq1RapjKFAWIzm+QaaDyB5zq65OkmBNh89rmsAU=
X-Received: by 2002:a4a:e049:: with SMTP id v9mr3772904oos.22.1592482895397;
 Thu, 18 Jun 2020 05:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200615160244.741244-1-agruenba@redhat.com> <20200618013901.GR11245@magnolia>
In-Reply-To: <20200618013901.GR11245@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 14:21:23 +0200
Message-ID: <CAHc6FU714HhtJdbfZXL26fxQ1_AV7rpsOVbhx8sLrdqwOUJBzg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 3:39 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Mon, Jun 15, 2020 at 06:02:44PM +0200, Andreas Gruenbacher wrote:
> > Make sure iomap_end is always called when iomap_begin succeeds: the
> > filesystem may take locks in iomap_begin and release them in iomap_end,
> > for example.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/apply.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> > index 76925b40b5fd..c00a14d825db 100644
> > --- a/fs/iomap/apply.c
> > +++ b/fs/iomap/apply.c
> > @@ -46,10 +46,10 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
> >       ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
> >       if (ret)
> >               return ret;
> > -     if (WARN_ON(iomap.offset > pos))
> > -             return -EIO;
> > -     if (WARN_ON(iomap.length == 0))
> > -             return -EIO;
> > +     if (WARN_ON(iomap.offset > pos) || WARN_ON(iomap.length == 0)) {
>
> <urk> Forgot to actually review the original patch. :P
>
> Why combine these WARN_ON?  Before, you could distinguish between your
> iomap_begin method returning zero length vs. bad offset.

Right, the WARN_ONs shouldn't both report the same line number. I'll
send an update.

Thanks,
Andreas

