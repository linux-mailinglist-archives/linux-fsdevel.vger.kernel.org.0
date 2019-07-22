Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1699970A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfGVUMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 16:12:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45586 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGVUMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:12:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so30547285oib.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2019 13:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKpNvjyeav2TkrWNw26KJV5Yk/ocQzfpVIZmY2lx9vA=;
        b=C6/ZOoeKjTy2ngPebCBc4bOidSEYTcEetvrYZW20RdC6ksKGGPg9qCJoQs2YcMYJ8j
         pWVsElKjB9m+zmTLUL6UMBvXhsBRIALU7cCG469R1azyc9IuR/ddYNf5dZJxjKmcPX2+
         C+QEJJkm1WrIAmoV0E3+VW7refpcFw6a1HgYlkXS6RdhLlBbZCJeGUdSeTdDmGLGnDL0
         2gzLKxhEPbINrPkgw5Ix8eMafnXF/+N6B2XnEQJuGDdODaS4ysYDfrs2WT32RyNLhmm4
         oJCr9c+SgPyMPc3+DvCyBbWFNmP0AZKf35m6nJImcHcs6J65EN2pj4EvM0djzdKBkXqN
         DEYw==
X-Gm-Message-State: APjAAAXWy49+pSCqhq/hHgkNf4DI8eJrhGidrz1iXQpGj7aZCci9+bOY
        J01gISuux4N2f96lOfexMrQUoXNk0G8wLMsnZNFG8A==
X-Google-Smtp-Source: APXvYqyhRxhuqfN9NPb1NOuvkt5AsL/yran3Id9FVtnziQurnms/xJCxtrVqV/RaSFxGA3nruRayA2spZawkzf5B0Mg=
X-Received: by 2002:aca:72d0:: with SMTP id p199mr22915331oic.178.1563826353288;
 Mon, 22 Jul 2019 13:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190722095024.19075-1-hch@lst.de>
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 22 Jul 2019 22:12:21 +0200
Message-ID: <CAHc6FU6oAsVGDA_7zMRiU=gR6EDh-P2x8sbjxr7XcKn4epS3UQ@mail.gmail.com>
Subject: Re: lift the xfs writepage code into iomap v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, 22 Jul 2019 at 11:50, Christoph Hellwig <hch@lst.de> wrote:
> this series cleans up the xfs writepage code and then lifts it to
> fs/iomap.c so that it could be use by other file system.  I've been
> wanting to this for a while so that I could eventually convert gfs2
> over to it, but I never got to it.  Now Damien has a new zonefs
> file system for semi-raw access to zoned block devices that would
> like to use the iomap code instead of reinventing it, so I finally
> had to do the work.
>
>
> Changes since v2:
>  - rebased to v5.3-rc1
>  - folded in a few changes from the gfs2 enablement series

thanks for the much appreciated update.

I've added that and the remaining gfs2 iomap patches to this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git iomap

Your final patch on this branch, "gfs2: use iomap for buffered I/O in
ordered and writeback mode", still causes the following four xfstest
failures:

  generic/311 generic/322 generic/393 generic/418

The bug in generic/393 is that in the nobh case, when unstuffing an
inode, we fail to dirty the unstuffed page and so the page is never
written. This should be easy to fix. The other failures have other
causes (still investigating).

> Changes since v1:
>  - rebased to the latest xfs for-next tree
>  - keep the preallocated transactions for size updates
>  - rename list_pop to list_pop_entry and related cleanups
>  - better document the nofs context handling
>  - document that the iomap tracepoints are not a stable API

Thanks,
Andreas
