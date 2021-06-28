Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D793B6A70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhF1VbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 17:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234521AbhF1VbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624915729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJ767vfrh4IXdfvFNAN+IwQrIGxYG6OsAHfRcAZ7fBg=;
        b=VN+P0I5NahzyIzJzHE+DeQBhhWHCRVpLQhJ569guw/G3Irqsv1h/lueH51cFGL5+5x8irE
        gtW7NX6yQBcso8Q8i5Ube1L58h8VPH1mVGVZsC8n5i0s7/leZai+TeUr+JjQl//VwpRVDJ
        lb5xagsaSacj1KM0xaLhttVnfO5s1x8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-Xn1VkTN3NM-XuOYAm2E5pg-1; Mon, 28 Jun 2021 17:28:16 -0400
X-MC-Unique: Xn1VkTN3NM-XuOYAm2E5pg-1
Received: by mail-wr1-f69.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so1284209wrq.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 14:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJ767vfrh4IXdfvFNAN+IwQrIGxYG6OsAHfRcAZ7fBg=;
        b=Zz0mqshRcTTu123zWWjTRm8EsriIQs14m6MaKhoX5yGQ/eU/Kb2IN1WYP2EXp40cdr
         IIizk0279amVI7wn/2eLCqKHZT1TG/4JDdcwnHNKyw3Zaa5nJtprb5BNJW9QIrGrslyR
         gALXIoI5kmKWHw7yXcW6gcWU71mo+4Z1846HJ2C03VQn8a0pDZ66Zj6L810+DPc8OZCF
         X2ry43TvLPgHnaafm3ySJ+zTBS/Ze4CJXqRhpyRcqh27IeIxPNptrhzjAABnhuq/Xscy
         EJ5rN59Hr+TBnNkwH/eR8S7h0pWTiefJavmhJBP3d+kHbBKJroMJcO6+4jkpxrKneXdt
         pb7g==
X-Gm-Message-State: AOAM531Y+9vhyuyKfnJ+R1zgwSLfpERqsKPjencf6+tXHaa8zJRQLWwJ
        kEGfLS0fNpQdQ1VRgqjJJ1qeWscW0j00jouXMiMwFtg72v90RfzvZwvWaS6PWWwkgld7pLnYrHW
        avOVB22Lki5TfPh1JZ3qvVcizoidWv2WLhrZ1T87PkQ==
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr28513962wrx.289.1624915695209;
        Mon, 28 Jun 2021 14:28:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziXT1hg1vICxPlVCGN6ewQfxaaiJ7z4+Orc+ZtFBtB0qT203Z7V708+3eTxQuHdvZEwWWyDocdducb1VXOQNw=
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr28513946wrx.289.1624915695043;
 Mon, 28 Jun 2021 14:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210628172727.1894503-1-agruenba@redhat.com> <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org>
In-Reply-To: <YNoLTl602RrckQND@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 28 Jun 2021 23:28:03 +0200
Message-ID: <CAHc6FU7Aa2ja+UDV84O=xt5hzSE7b9JkhtECzX8DRxxP=W0AXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] iomap: small block problems
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 8:07 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 28, 2021 at 06:39:09PM +0100, Matthew Wilcox wrote:
> > Not hugely happy with either of these options, tbh.  I'd rather we apply
> > a patch akin to this one (plucked from the folio tree), so won't apply:
>
> > so permit pages without an iop to enter writeback and create an iop
> > *then*.  Would that solve your problem?
>
> It is the right thing to do, especially when combined with a feature
> patch to not bother to create the iomap_page structure on small
> block size file systems when the extent covers the whole page.
>
> >
> > > (3) We're not yet using iomap_page_mkwrite, so iomap_page objects don't
> > > get created on .page_mkwrite, either.  Part of the reason is that
> > > iomap_page_mkwrite locks the page and then calls into the filesystem for
> > > uninlining and for allocating backing blocks.  This conflicts with the
> > > gfs2 locking order: on gfs2, transactions must be started before locking
> > > any pages.  We can fix that by calling iomap_page_create from
> > > gfs2_page_mkwrite, or by doing the uninlining and allocations before
> > > calling iomap_page_mkwrite.  I've implemented option 2 for now; see
> > > here:
> >
> > I think this might also solve this problem?
>
> We'll still need to create the iomap_page structure for page_mkwrite
> if there is an extent boundary inside the page.

Yes, but the iop wouldn't need to be allocated in page_mkwrite; that
would be taken care of by iomap_writepage / iomap_writepages as in the
patch suggested by Matthew, right?

Thanks,
Andreas

