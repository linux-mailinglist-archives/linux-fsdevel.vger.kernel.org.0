Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EEA206FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfEPMcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:32:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfEPMcD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:32:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2229AFBE;
        Thu, 16 May 2019 12:32:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 879F81E3ED6; Thu, 16 May 2019 14:32:01 +0200 (CEST)
Date:   Thu, 16 May 2019 14:32:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190516123201.GG13274@quack2.suse.cz>
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
 <20190515102133.GA16193@quack2.suse.cz>
 <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
 <20190515130730.GA9526@quack2.suse.cz>
 <20190516114817.GD13274@quack2.suse.cz>
 <ca1e5916-73ee-6fc4-1d78-428691f7fc64@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1e5916-73ee-6fc4-1d78-428691f7fc64@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-05-19 21:17:14, Tetsuo Handa wrote:
> On 2019/05/16 20:48, Jan Kara wrote:
> > OK, so non-racy fix was a bit more involved and I've ended up just
> > upgrading the file reference to an exclusive one in loop_set_fd() instead
> > of trying to hand-craft some locking solution. The result is attached and
> > it passes blktests.
> 
> blkdev_get() has corresponding blkdev_put().
> bdgrab() does not have corresponding bdput() ?

Yes, and that's hidden inside blkdev_put() (or failing blkdev_get()). Don't
get me started on calling conventions of these functions... I've wasted half
an hour trying to figure out where I'm leaking inode references in my patch
;).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
