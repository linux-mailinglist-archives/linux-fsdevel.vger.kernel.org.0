Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC8179184
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgCDNho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 08:37:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:59622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbgCDNhn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:37:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9E02B12A;
        Wed,  4 Mar 2020 13:37:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B36D61E0E99; Wed,  4 Mar 2020 14:37:38 +0100 (CET)
Date:   Wed, 4 Mar 2020 14:37:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200304133738.GF21048@quack2.suse.cz>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Mon 02-03-20 11:55:44, He Zhe wrote:
> Since the following commit
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
> until now(v5.6-rc4),
> 
> If we start udisksd service of systemd(v244), systemd-udevd will scan
> /dev/hdc (the cdrom device created by default in qemu(v4.2.0)).
> systemd-udevd will endlessly run and cause OOM.

Thanks for report! The commit you mention has this:

There is a small behavior change in that we now send the kevent change
notice also if we were not invalidating but no partitions were found, which
seems like the right thing to do.

And apparently this confuses systemd-udevd because it tries to open
/dev/hdc in response to KOBJ_CHANGE event on that device and the open calls
rescan_partitions() which generates another KOBJ_CHANGE event.  So I'm
afraid we'll have to revert to the old behavior of not sending KOBJ_CHANGE
event when there are no partitions found. Christoph?

								Honza
--
Jan Kara <jack@suse.com>
SUSE Labs, CR
