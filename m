Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6376F48425B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiADN1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 08:27:02 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:51054 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiADN1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:27:02 -0500
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 204DQnIh029242;
        Tue, 4 Jan 2022 22:26:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 04 Jan 2022 22:26:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 204DQn84029235
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Jan 2022 22:26:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8b2a61cb-4850-8bd7-3ff3-cebebefdb01b@I-love.SAKURA.ne.jp>
Date:   Tue, 4 Jan 2022 22:26:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] block: add filemap_invalidate_lock_killable()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000007305e805d4a9e7f9@google.com>
 <3392d41c-5477-118a-677f-5780f9cedf95@I-love.SAKURA.ne.jp>
 <YdPzygDErbQffQMM@infradead.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YdPzygDErbQffQMM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/01/04 16:14, Christoph Hellwig wrote:
> On Mon, Jan 03, 2022 at 07:49:11PM +0900, Tetsuo Handa wrote:
>> syzbot is reporting hung task at blkdev_fallocate() [1], for it can take
>> minutes with mapping->invalidate_lock held. Since fallocate() has to accept
>> size > MAX_RW_COUNT bytes, we can't predict how long it will take. Thus,
>> mitigate this problem by using killable wait where possible.
> 
> Well, but that also means we want all other users of the invalidate_lock
> to be killable, as fallocate vs fallocate synchronization is probably
> not the interesting case.

Right. But being responsive to SIGKILL is generally preferable.

syzbot (and other syzkaller based fuzzing) is reporting many hung task reports,
but many of such reports are simply overstressing.

We can't use killable lock wait for release operation because it is a "void"
function. But we can use killable lock wait for majority of operations which
are not "void" functions. Use of killable lock wait where possible can improve
situation.

