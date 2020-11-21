Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F12BC08B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 17:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKUQYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 11:24:17 -0500
Received: from verein.lst.de ([213.95.11.211]:46174 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgKUQYQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 11:24:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 951F467373; Sat, 21 Nov 2020 17:24:11 +0100 (CET)
Date:   Sat, 21 Nov 2020 17:24:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/20] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201121162411.GA18475@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-15-hch@lst.de> <20201119120525.GW1981@quack2.suse.cz> <20201120090820.GD21715@lst.de> <20201120112121.GB15537@quack2.suse.cz> <20201120153253.GA18990@lst.de> <20201120155956.GB4327@casper.infradead.org> <20201120200548.GA27360@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120200548.GA27360@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:05:48PM +0100, Jan Kara wrote:
> The code is already switched to it AFAICT (the lock is really only used in
> the two places that write i_size). But the problem is that in theory two
> i_size_write() calls can race in a way that the resulting stored i_size is a
> mix of two stored sizes. Now I have hard time imagining how this could
> happen for a block device and if two reconfigurations of a block device
> could race like that we'd have a large problems anyway...

Now that you mention it, yes - i_size_write needs to be under i_rwsem
or an equivalent lock.  We could look into using i_rwsem also for block
device, but for now the spinlock seems to be doing fine.  Note that
in current mainline we only have such a lock protecting i_size of the
block_device inode, but none for the size in hd_struct.
