Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31944335F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhKBQqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhKBQqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:46:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B018C06120A
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Nov 2021 09:04:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id n23so9888342pgh.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqUtMw42srMAJfM2b3lzp/b+ILplHJlRcpIaRS/3TQM=;
        b=M1Jy4rAev2XNNrOaCWRPKKonIM70Nc4Pm5SPQkebmdl++tjn6a6C7m3mnLdNZFp0pr
         Dw88LtEJTtN1PUO++FTkdtdNtjTNQDnlwv2yLNTeMXrjP9ZyYAKGTMcL8r9RTRPBw3il
         4C97/+Sa7C2wkCTq6baD8je9LdaO98oiGYYt7spVrtyDRzBtQpt9dbnzUI85k/5rztRv
         YJjx1bNAw3Odr4BoA8nGSa8XDcp5bV9j8cNbaFaDoC0vNAdSZH4jYZcFSEHleUzrSlpk
         yxIbYa611I/q0MBtSK4EowjkBNpDUpLqBOxKzNjkyNInHvPRJou4mqsFW/Ul7RBz7G+C
         9qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqUtMw42srMAJfM2b3lzp/b+ILplHJlRcpIaRS/3TQM=;
        b=WX2J1Da1aoznEH4j7e3/rXb3bDaYwB6y8XUn3oQnvfssOMbZmZD0mY+mjvThjjb+sP
         TSGVn9W0AZTPM4J5lsWmqIus0AcrEYhwHyckDKWga8DvGS2UaauyvoPHf16TjCf39XwM
         XbXqUEq3Nb7m0NArz1TKWYbRjQw7gHY2CEPUqzpYEfqgm7XiDbiwggXXCZ/BwEYWT9rD
         p4DtGJ9lXhZlSws1GeXPMxrl0eFx4DFwOSgk5EChavlxQneNC59TklvJk9PAFfzE5Koh
         xCq8Zb2wfDCOonbM+4Xd25sGQQuCs14T+H4hEXTJweT646QOUp60UjbBOo76pNEquR20
         T0nw==
X-Gm-Message-State: AOAM5309jCR79a52DU3h/nmw6NC8cfxHpn7ydk02KtJpjR3+Jrh59w3+
        2WZiMAz8zKdjXaSBnTLmcPZA88nV+2bq1XCmqrESog==
X-Google-Smtp-Source: ABdhPJyi2jXIzQpJmrRalOBu2yRBUoqURsVK2whse/fQ0ZQUdF57+LmGNFNbptM0HlteOtS8dkMwnbU4y4A7thJeMNM=
X-Received: by 2002:a63:6302:: with SMTP id x2mr11074410pgb.5.1635869046166;
 Tue, 02 Nov 2021 09:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211021001059.438843-1-jane.chu@oracle.com> <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com> <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com> <YXj2lwrxRxHdr4hb@infradead.org>
In-Reply-To: <YXj2lwrxRxHdr4hb@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 09:03:55 -0700
Message-ID: <CAPcyv4hK18DetEf9+NcDqM5y07Vp-=nhysHJ3JSnKbS-ET2ppw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:50 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Oct 22, 2021 at 08:52:55PM +0000, Jane Chu wrote:
> > Thanks - I try to be honest.  As far as I can tell, the argument
> > about the flag is a philosophical argument between two views.
> > One view assumes design based on perfect hardware, and media error
> > belongs to the category of brokenness. Another view sees media
> > error as a build-in hardware component and make design to include
> > dealing with such errors.
>
> No, I don't think so.  Bit errors do happen in all media, which is
> why devices are built to handle them.  It is just the Intel-style
> pmem interface to handle them which is completely broken.

No, any media can report checksum / parity errors. NVME also seems to
do a poor job with multi-bit ECC errors consumed from DRAM. There is
nothing "pmem" or "Intel" specific here.

> > errors in mind from start.  I guess I'm trying to articulate why
> > it is acceptable to include the RWF_DATA_RECOVERY flag to the
> > existing RWF_ flags. - this way, pwritev2 remain fast on fast path,
> > and its slow path (w/ error clearing) is faster than other alternative.
> > Other alternative being 1 system call to clear the poison, and
> > another system call to run the fast pwrite for recovery, what
> > happens if something happened in between?
>
> Well, my point is doing recovery from bit errors is by definition not
> the fast path.  Which is why I'd rather keep it away from the pmem
> read/write fast path, which also happens to be the (much more important)
> non-pmem read/write path.

I would expect this interface to be useful outside of pmem as a
"failfast" or "try harder to recover" flag for reading over media
errors.
