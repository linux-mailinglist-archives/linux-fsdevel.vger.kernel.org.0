Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3022D82B02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfHFFco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:32:44 -0400
Received: from verein.lst.de ([213.95.11.211]:53223 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfHFFco (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:32:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A8B268B20; Tue,  6 Aug 2019 07:32:39 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:32:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] iomap: copy the xfs writeback code to iomap.c
Message-ID: <20190806053239.GE13409@lst.de>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia> <156444947277.2682261.14371480217831737439.stgit@magnolia> <CAHc6FU5QpFPRtt0U0+v+zEjL9YcuesLaoGeU0qrn_NhpyHbynw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5QpFPRtt0U0+v+zEjL9YcuesLaoGeU0qrn_NhpyHbynw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:31:24PM +0200, Andreas Gruenbacher wrote:

> > +       WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> > +       WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
> 
> How about this instead?
> 
>        if (iop)
>                WARN_ON_ONCE(atomic_read(&iop->write_count) != 0);
>        else
>                WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE);

For one I don't really want to change the code from before in a move
patch, but second I also wrote it like that as having conditionals just
around asserts seems a little odd.

This also helps with the next step of the evolution where we'll allocate
the iops on demand and skip it for small block size file systems as long
as a page is only covered by a single extent, as we then can remove the
first assert.
