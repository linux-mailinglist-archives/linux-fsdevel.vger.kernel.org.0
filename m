Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1817950D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgCDQ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:26:29 -0500
Received: from verein.lst.de ([213.95.11.211]:55335 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgCDQ03 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:26:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBDF168B20; Wed,  4 Mar 2020 17:26:25 +0100 (CET)
Date:   Wed, 4 Mar 2020 17:26:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     He Zhe <zhe.he@windriver.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200304162625.GA11616@lst.de>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com> <20200304133738.GF21048@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304133738.GF21048@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 02:37:38PM +0100, Jan Kara wrote:
> Hi!
> 
> On Mon 02-03-20 11:55:44, He Zhe wrote:
> > Since the following commit
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
> > until now(v5.6-rc4),
> > 
> > If we start udisksd service of systemd(v244), systemd-udevd will scan
> > /dev/hdc (the cdrom device created by default in qemu(v4.2.0)).
> > systemd-udevd will endlessly run and cause OOM.
> 
> Thanks for report! The commit you mention has this:
> 
> There is a small behavior change in that we now send the kevent change
> notice also if we were not invalidating but no partitions were found, which
> seems like the right thing to do.
> 
> And apparently this confuses systemd-udevd because it tries to open
> /dev/hdc in response to KOBJ_CHANGE event on that device and the open calls
> rescan_partitions() which generates another KOBJ_CHANGE event.  So I'm
> afraid we'll have to revert to the old behavior of not sending KOBJ_CHANGE
> event when there are no partitions found. Christoph?

Looks like it.  Let me figure out how to best do that.
