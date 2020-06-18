Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E951FF20A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgFRMhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 08:37:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729051AbgFRMhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592483872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eG358ofoUnmsLE/Y5rjQIbnjgCn65iK1IVr7NWl3TcA=;
        b=W5Zvzz/VwAV4xcNmBqaRSkdwftrOe6gutDIgI4O/wkxiyxdyFcnd7zDJzWIlR9H2QvENLL
        Yn+F+1WES9FLwROgtJw2MpKZTcAogegpfaKTp+/PXBgKb/zDQsp6y8cGsdyURDEQ/aWtKp
        X9ZcLJphBFEN6nK3JcwsB1pBqcNMV6A=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-a44yJlwRNlKyPH-W5oijXA-1; Thu, 18 Jun 2020 08:37:49 -0400
X-MC-Unique: a44yJlwRNlKyPH-W5oijXA-1
Received: by mail-oi1-f200.google.com with SMTP id w16so2638773oie.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 05:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eG358ofoUnmsLE/Y5rjQIbnjgCn65iK1IVr7NWl3TcA=;
        b=AgkRHX5K4VOnGz7n5fDlCVkxYAf9Qfgp2VN0aSIOQ10CCP/FQCuxJ3Ov9QhDH7Ma51
         rW/fLziEPZfRZYh+lV1m13IenZP6eyOGc86/N/qnoZ6gmqS1g47xkhoXI7iXIWDWdqYo
         ofDAE6dLPfEF07TZMA2UB4j7xc6sFspk6UiITDMMd+kQZvm6gDx+hfwNLRLgAcuTzGJQ
         ws98gl/0E55yC3wlVsrhSJtGZBUmGWNgxC9Ttul5qv6lPGpiDWjiz8vk0q0wdi+bKrIL
         h+Qu+EKidKHzV1DEFhH84t69t45RHB3Os6IVeHYcw374LQ2mIXhUlnbZo3xCGMX4T/Pb
         QIFA==
X-Gm-Message-State: AOAM533yRlgC+QuLQYkeI3s09EaEwuQIBNfuiXnqgezJzm5CBR2qiNxA
        iM64+4Xu7IhyMsOPgHW75dMLIL37TSGn2dTxmrGwk7ZsqhzhUkFnOg573oNO15YVrVmJNqlNMv5
        dEM+6j+wy4klteOTJ1tkuEBv4JLLXszbSv7gsnzb3tQ==
X-Received: by 2002:a4a:d1ca:: with SMTP id a10mr3811828oos.31.1592483868759;
        Thu, 18 Jun 2020 05:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLwUtT1EDG5M+CYqt7D1khEZwMXhLHQ9HprBeCqCod5nLvYnyxPsw1MOMrXkwBZTHrtsIKoJzZUv37sqjz46s=
X-Received: by 2002:a4a:d1ca:: with SMTP id a10mr3811816oos.31.1592483868548;
 Thu, 18 Jun 2020 05:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200615160244.741244-1-agruenba@redhat.com> <20200618013901.GR11245@magnolia>
 <20200618123227.GO8681@bombadil.infradead.org>
In-Reply-To: <20200618123227.GO8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 14:37:37 +0200
Message-ID: <CAHc6FU5x8+54zX5NWEDdsf5HV5qXLnjS1SM+oYmX1yMrh_mDfA@mail.gmail.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 2:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jun 17, 2020 at 06:39:01PM -0700, Darrick J. Wong wrote:
> > > -   if (WARN_ON(iomap.offset > pos))
> > > -           return -EIO;
> > > -   if (WARN_ON(iomap.length == 0))
> > > -           return -EIO;
> > > +   if (WARN_ON(iomap.offset > pos) || WARN_ON(iomap.length == 0)) {
> >
> > Why combine these WARN_ON?  Before, you could distinguish between your
> > iomap_begin method returning zero length vs. bad offset.
>
> Does it matter?  They're both the same problem -- the filesystem has
> returned an invalid iomap.  I'd go further and combine the two:
>
>         if (WARN_ON(iomap.offset > pos || iomap.length == 0)) {
>
> that'll save a few bytes of .text

That would be fine by me as well. Christoph may have wanted separate
warnings for a particular reason though.

Andreas

