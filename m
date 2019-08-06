Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6E82B08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfHFFdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:33:43 -0400
Received: from verein.lst.de ([213.95.11.211]:53237 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfHFFdn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:33:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E5E7068BFE; Tue,  6 Aug 2019 07:33:39 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:33:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] iomap: copy the xfs writeback code to iomap.c
Message-ID: <20190806053339.GF13409@lst.de>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia> <156444947277.2682261.14371480217831737439.stgit@magnolia> <CAHc6FU6Q5gz-i9DmdXEqNbc4f3=U7CKryb2+ETO1U1yR3r0hDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6Q5gz-i9DmdXEqNbc4f3=U7CKryb2+ETO1U1yR3r0hDg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas,

any chance you could trim your quote to the relevant parts?

On Sun, Aug 04, 2019 at 04:59:25PM +0200, Andreas Gruenbacher wrote:
> > +       /*
> > +        * File systems can perform actions at submit time and/or override
> > +        * the end_io handler here for complex operations like copy on write
> > +        * extent manipulation or unwritten extent conversions.
> > +        */
> > +       if (wpc->ops->submit_ioend)
> > +               error = wpc->ops->submit_ioend(ioend, error);
> 
> I think we only want to call submit_ioend here if error isn't set already.

No, we need to call it even with an error so that the file system can
override the bi_end_io handler, which bio_endio ends up calling even
for the error case.

Maybe the comment above could use an update to make that more clear.
