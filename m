Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A026027267B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgIUOAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:00:17 -0400
Received: from verein.lst.de ([213.95.11.211]:40145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbgIUOAR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:00:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A75DA68AFE; Mon, 21 Sep 2020 16:00:11 +0200 (CEST)
Date:   Mon, 21 Sep 2020 16:00:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Coly Li <colyli@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/13] bcache: inherit the optimal I/O size
Message-ID: <20200921140010.GA14672@lst.de>
References: <20200921080734.452759-1-hch@lst.de> <20200921080734.452759-4-hch@lst.de> <b547a1b6-ab03-0520-012d-86d112c83d92@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b547a1b6-ab03-0520-012d-86d112c83d92@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:54:59PM +0800, Coly Li wrote:
> I am not sure whether virtual bcache device's optimal request size can
> be simply set like this.
> 
> Most of time inherit backing device's optimal request size is fine, but
> there are two exceptions,
> - Read request hits on cache device
> - User sets sequential_cuttoff as 0, all writing may go into cache
> device firstly.
> For the above two conditions, all I/Os goes into cache device, using
> optimal request size of backing device might be improper.
> 
> Just a guess, is it OK to set the optimal request size of the virtual
> bcache device as the least common multiple of cache device's and backing
> device's optimal request sizes ?

Well, if the optimal I/O size is wrong, the read ahead size also is
wrong.  Can we just drop the setting?
