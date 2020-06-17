Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB271FCD9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQMmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 08:42:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQMmA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:42:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC2CAAAC6;
        Wed, 17 Jun 2020 12:42:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF0ED1E128D; Wed, 17 Jun 2020 14:41:57 +0200 (CEST)
Date:   Wed, 17 Jun 2020 14:41:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, zhangxiaoxu5@huawei.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ext4: detect metadata async write error when
 getting journal's write access
Message-ID: <20200617124157.GB29763@quack2.suse.cz>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
 <20200617115947.836221-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617115947.836221-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-06-20 19:59:45, zhangyi (F) wrote:
> Although we have already introduce s_bdev_wb_err_work to detect and
> handle async write metadata buffer error as soon as possible, there is
> still a potential race that could lead to filesystem inconsistency,
> which is the buffer may reading and re-writing out to journal before
> s_bdev_wb_err_work run. So this patch detect bdev mapping->wb_err when
> getting journal's write access and also mark the filesystem error if
> something bad happened.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

So instead of all this, cannot we just do:

	if (work_pending(sbi->s_bdev_wb_err_work))
		flush_work(sbi->s_bdev_wb_err_work);

? And so we are sure the filesystem is aborted if the abort was pending?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
