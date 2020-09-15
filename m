Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820F3269F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIOHHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 03:07:14 -0400
Received: from verein.lst.de ([213.95.11.211]:46699 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgIOHGO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:06:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B14E68AFE; Tue, 15 Sep 2020 09:05:22 +0200 (CEST)
Date:   Tue, 15 Sep 2020 09:05:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        Hans de Goede <hdegoede@redhat.com>,
        Song Liu <song@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        dm-devel@redhat.com, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, drbd-dev@tron.linbit.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 06/14] block: lift setting the readahead size into the
 block layer
Message-ID: <20200915070522.GA19974@lst.de>
References: <20200726150333.305527-1-hch@lst.de> <20200726150333.305527-7-hch@lst.de> <20200826220737.GA25613@redhat.com> <20200902151144.GA1738@lst.de> <20200902162007.GB5513@redhat.com> <20200910092813.GA27229@lst.de> <20200910171541.GB21919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910171541.GB21919@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:15:41PM -0400, Mike Snitzer wrote:
> > I'll move it to blk_register_queue, which should work just fine.
> 
> That'll work for initial DM table load as part of DM device creation
> (dm_setup_md_queue).  But it won't account for DM table reloads that
> might change underlying devices on a live DM device (done using
> __bind).
> 
> Both dm_setup_md_queue() and __bind() call dm_table_set_restrictions()
> to set/update queue_limits.  It feels like __bind() will need to call a
> new block helper to set/update parts of queue_limits (e.g. ra_pages and
> io_pages).
> 
> Any chance you're open to factoring out that block function as an
> exported symbol for use by blk_register_queue() and code like DM's
> __bind()?

I agree with the problem statement.  OTOH adding an exported helper
for two trivial assignments seems a little silly..

For now I'll just keep the open coded ->io_pages assignment in
dm.  Note that dm doesn't currently update the ->ra_pages value
based on the underlying devices, so an incremental patch to do that
might be useful as well.
