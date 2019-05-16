Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5494820746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfEPMvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:51:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49334 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfEPMvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:51:10 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4GComBb001967;
        Thu, 16 May 2019 21:50:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Thu, 16 May 2019 21:50:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4GComi8001962
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 16 May 2019 21:50:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
 <20190515102133.GA16193@quack2.suse.cz>
 <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
 <20190515130730.GA9526@quack2.suse.cz>
 <20190516114817.GD13274@quack2.suse.cz>
 <ca1e5916-73ee-6fc4-1d78-428691f7fc64@i-love.sakura.ne.jp>
 <20190516123201.GG13274@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e9ffd00a-809c-9eca-45b4-31449a64032e@i-love.sakura.ne.jp>
Date:   Thu, 16 May 2019 21:50:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516123201.GG13274@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/05/16 21:32, Jan Kara wrote:
> On Thu 16-05-19 21:17:14, Tetsuo Handa wrote:
>> On 2019/05/16 20:48, Jan Kara wrote:
>>> OK, so non-racy fix was a bit more involved and I've ended up just
>>> upgrading the file reference to an exclusive one in loop_set_fd() instead
>>> of trying to hand-craft some locking solution. The result is attached and
>>> it passes blktests.
>>
>> blkdev_get() has corresponding blkdev_put().
>> bdgrab() does not have corresponding bdput() ?
> 
> Yes, and that's hidden inside blkdev_put() (or failing blkdev_get()). Don't
> get me started on calling conventions of these functions... I've wasted half
> an hour trying to figure out where I'm leaking inode references in my patch
> ;).

Ah, found tricky comment. Please apply the patch. Thank you.

/**
 * blkdev_get - open a block device
 * @bdev: block_device to open
 * @mode: FMODE_* mask
 * @holder: exclusive holder identifier
 *
 * Open @bdev with @mode.  If @mode includes %FMODE_EXCL, @bdev is
 * open with exclusive access.  Specifying %FMODE_EXCL with %NULL
 * @holder is invalid.  Exclusive opens may nest for the same @holder.
 *
 * On success, the reference count of @bdev is unchanged.  On failure,
 * @bdev is put.
 *
 * CONTEXT:
 * Might sleep.
 *
 * RETURNS:
 * 0 on success, -errno on failure.
 */
