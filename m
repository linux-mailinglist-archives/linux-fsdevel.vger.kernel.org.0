Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5991FB301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFPN5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 09:57:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728696AbgFPN5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592315842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mxL0md2vs9aP4NRN6scYuB5CiMGDrbZCWGjDCy0BQrw=;
        b=OSaDlEdipp7xjxXlZPC+rbkA5tcVKXTDmicrWlPaVCrBIO8Fjh0AEpI1Pzy29UhX6JY4OF
        m+BajCyzHhI+boOBq2Jt3Jls3bvNL6m+qTd27MURvMVewrSxV2kOMsvVjbb08dKESnMRj0
        SYXeBDLpxjeZ00CgxGQgJ3+TXB9iI3k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-SMtnqRciOfenTzoUQ9H2AQ-1; Tue, 16 Jun 2020 09:57:20 -0400
X-MC-Unique: SMtnqRciOfenTzoUQ9H2AQ-1
Received: by mail-ot1-f72.google.com with SMTP id z6so9843539otq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 06:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxL0md2vs9aP4NRN6scYuB5CiMGDrbZCWGjDCy0BQrw=;
        b=CrHQcxTQP/2MAiCNEypb6ltn9W5kr5QbvOKTXGPDlSWeisAjUri+LHt8Px1Gvz36n2
         cKKRvekCj/VhV9gQaQ4zvbgxinFsNXDJeBG2MCtt6khwdSV91nSzwFO5xulf6jJzrwys
         1vBOp5S3N2zvS3pT8h8wkw1kmuwcaEVb9HUngLcmSBqgruTpek0DrszKBxUBwwyL6PZG
         xK2lIH/yxKt5koEwligi3PO7Mg+PzEJFdFJvwpzes6GA4H8+hoieSPeZxKmZvUbHES8j
         r/rFEjuAUIWZEyvaqQtxn4V/DeMrZLN0td7cQCpRRDzQR7PohQR386XY+GNWBFfNx0wk
         wnog==
X-Gm-Message-State: AOAM532y+UDiqLjPKJ9er+G8rtGpYVfAl9YR3CAxmkCgNt8cr79FGPEw
        e6c83otqcDGLT+bwzjGjJ34CVndZOtjvEbak6AmvljxmnN7aoQdO0CnFuF0BSV8LOxeVgCex8oL
        3b8pAN4R3TOELdo3Wkiqk3fNvCa+QTDBf2JZB1BlVqw==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr2490381otm.297.1592315839810;
        Tue, 16 Jun 2020 06:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2fk3/Mp9qtZPBw8lguU7HnnDH6p9/1XySC487M/O8qetk+5hVKpY6RDtmPOKgYMjal9GAhKQBddiRFTUcTQ4=
X-Received: by 2002:a9d:798c:: with SMTP id h12mr2490368otm.297.1592315839524;
 Tue, 16 Jun 2020 06:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200615160244.741244-1-agruenba@redhat.com> <20200615233239.GY2040@dread.disaster.area>
 <20200615234437.GX8681@bombadil.infradead.org> <20200616003903.GC2005@dread.disaster.area>
 <315900873.34076732.1592309848873.JavaMail.zimbra@redhat.com> <20200616132318.GZ8681@bombadil.infradead.org>
In-Reply-To: <20200616132318.GZ8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 16 Jun 2020 15:57:08 +0200
Message-ID: <CAHc6FU7uU8rUMdkspqH+Zv_O5zi2eEyOYF4x4Je-eCNeM+7NHA@mail.gmail.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 3:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Jun 16, 2020 at 08:17:28AM -0400, Bob Peterson wrote:
> > ----- Original Message -----
> > > > I'd assume Andreas is looking at converting a filesystem to use iomap,
> > > > since this problem only occurs for filesystems which have returned an
> > > > invalid extent.
> > >
> > > Well, I can assume it's gfs2, but you know what happens when you
> > > assume something....
> >
> > Yes, it's gfs2, which already has iomap. I found the bug while just browsing
> > the code: gfs2 takes a lock in the begin code. If there's an error,
> > however unlikely, the end code is never called, so we would never unlock.
> > It doesn't matter to me whether the error is -EIO because it's very unlikely
> > in the first place. I haven't looked back to see where the problem was
> > introduced, but I suspect it should be ported back to stable releases.
>
> It shouldn't just be "unlikely", it should be impossible.  This is the
> iomap code checking whether you've returned an extent which doesn't cover
> the range asked for.  I don't think it needs to be backported, and I'm
> pretty neutral on whether it needs to be applied.

Right, when these warnings trigger, the filesystem has already screwed
up; this fix only makes things less bad. Those kinds of issues are
very likely to be fixed long before the code hits users, so it
shouldn't be backported.

This bug was in iomap_apply right from the start, so:

Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")

Thanks,
Andreas

