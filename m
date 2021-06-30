Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018383B8534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhF3Osa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234882AbhF3Os3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625064360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4vf1yqzrS3vFpHReQKYOpbBl+OSfAyb+Khv5JrEsWA=;
        b=L5uai/n08lzbxA0Ida8FNuOGq+f0gBdxtZSUk+HX3oyW1bG8uEGwg0pPzZrJ+Km1+BRRMe
        2BDXB1hYZoXtmlStyHCEW8z1aG4CwsLLyCImqyTWYq8CXeKAynFucTNJM7BsofqhjimwxB
        A8eFg169zSXs3DVCptqovApl1fUJIHs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ZNjg2VygOp6aDE1BRm2DYw-1; Wed, 30 Jun 2021 10:45:58 -0400
X-MC-Unique: ZNjg2VygOp6aDE1BRm2DYw-1
Received: by mail-wr1-f70.google.com with SMTP id j1-20020adfb3010000b02901232ed22e14so1071374wrd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 07:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4vf1yqzrS3vFpHReQKYOpbBl+OSfAyb+Khv5JrEsWA=;
        b=P02TI4RyQ2tnUArxBSMF+uAqAF/Kk0pJ0hPEQkEr7eoecidmYuItzzT6t1kriG2K6F
         BYwO30VOUDONQVQz2WEfG0zNjA+3E/xp3YxwTnS3AXTFPscnjMe206ZVo05J3cnI5J9e
         lpPp2ar4S7IRWEY4rnDnhLjgde7Sxwpdu8bpoOcbklhbuzvMmb54/2o1l+ZIZVwrRz73
         jd1SaKcupBgOoKUqZwv9vFUvWsW41JjihdHwaMOPTkn6eoJzgDXNgirzKKYfrPmC6Fqz
         fKblZ9CvtzbAaY7G7QGezmNCMVGjntsDyrJxbfCqE4yWwHyJ7b8T+ex6AZc7WhCmc7dq
         XCpg==
X-Gm-Message-State: AOAM530dqEnP2Vp4IDcc0se5KwtUinPTy/udnaF96gmBCPR1Wcwwp3UO
        0pOJYUsatoVRWpMz3kEhuAYCA8baRzS/dXMuhg3d7x41+Jliby0AQpCGmM6dblR+7z/A06HL3iv
        6HcaSk0LXyZTJah64r0tDTjlKpsOKqj9h/w59f1/o1g==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr13230653wrw.329.1625064357357;
        Wed, 30 Jun 2021 07:45:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgU5oFUHVMXKdZBHHmE78pYqUjAWgIPUUXK096keRw4Ekq8bzPm3W555Qgaz0gc7LPesnRODsUtpLUc8qY2+Y=
X-Received: by 2002:a5d:5745:: with SMTP id q5mr13230628wrw.329.1625064357193;
 Wed, 30 Jun 2021 07:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <YNoJPZ4NWiqok/by@casper.infradead.org> <20210628172727.1894503-1-agruenba@redhat.com>
 <20210629091239.1930040-1-agruenba@redhat.com> <YNx69luCAxlLMDAG@casper.infradead.org>
In-Reply-To: <YNx69luCAxlLMDAG@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 30 Jun 2021 16:45:45 +0200
Message-ID: <CAHc6FU4_eQMQinMfTHG42phuW6r7PTtyecDfMESp-KziaicL8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] iomap: small block problems
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 4:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Jun 29, 2021 at 11:12:39AM +0200, Andreas Gruenbacher wrote:
> > Below is a version of your patch on top of v5.13 which has passed some
> > local testing here.
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > iomap: Permit pages without an iop to enter writeback
> >
> > Permit pages without an iop to enter writeback and create an iop *then*.  This
> > allows filesystems to mark pages dirty without having to worry about how the
> > iop block tracking is implemented.
>
> How about ...
>
> Create an iop in the writeback path if one doesn't exist.  This allows
> us to avoid creating the iop in some cases.  The only current case we
> do that for is pages with inline data, but it can be extended to pages
> which are entirely within an extent.  It also allows for an iop to be
> removed from pages in the future (eg page split).
>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Sure, that works for me.

Thanks,
Andreas

