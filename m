Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8D1EFBB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFEOmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 10:42:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgFEOmi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:42:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24986AAD0;
        Fri,  5 Jun 2020 14:42:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B4D41E1281; Fri,  5 Jun 2020 16:42:36 +0200 (CEST)
Date:   Fri, 5 Jun 2020 16:42:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jason Yan <yanaijie@huawei.com>, Jan Kara <jack@suse.cz>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hulkci@huawei.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
Message-ID: <20200605144236.GB13248@quack2.suse.cz>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605094353.GS30374@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 05-06-20 12:43:54, Dan Carpenter wrote:
> I wonder if maybe the best fix is to re-add the "if (!res) " check back
> to blkdev_get().

Well, it won't be that simple since we need to call bd_abort_claiming()
under bdev->bd_mutex. And the fact that __blkdev_get() frees the reference
you pass to it is somewhat subtle and surprising so I think we are better
off getting rid of that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
