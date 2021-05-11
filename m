Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE97637B29F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKXes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 19:34:48 -0400
Received: from sandeen.net ([63.231.237.45]:49568 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKXes (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 19:34:48 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 95ABB615D71;
        Tue, 11 May 2021 18:33:22 -0500 (CDT)
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Pavel Reichl <preichl@redhat.com>,
        chritophe.vu-brugier@seagate.com,
        Hyeoncheol Lee <hyc.lee@gmail.com>
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
 <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: problem with exfat on 4k logical sector devices
Message-ID: <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
Date:   Tue, 11 May 2021 18:33:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 4:21 PM, Namjae Jeon wrote:
>> Hi Namjae -
> Hi Eric,
>>
>> It seems that exfat is unhappy on 4k logical sector size devices:
> Thanks for your report!
> We have got same report from Christophe Vu-Brugier. And he sent us
> the patch(https://github.com/exfatprogs/exfatprogs/pull/164) to fix it
> yesterday.(Thanks Christophe!), I will check it today

Oh, good timing! ;)

gI'll try to look at that in more depth. It does seem to make everything
work for me, and resolves a couple other misunderstandings I may have had, and
they seem to match with the spec.

For example, I now see that boot sector signature does go at the end of 512 for
the primary boot sector, and at the end of $SECTOR_SIZE for the extended boot
sector.

One other thing that I ran across is that fsck seems to validate an image
against the sector size of the device hosting the image rather than the sector size
found in the boot sector, which seems like another issue that will come up:

# fsck/fsck.exfat /dev/sdb
exfatprogs version : 1.1.1
/dev/sdb: clean. directories 1, files 0

# dd if=/dev/sdb of=test.img
524288+0 records in
524288+0 records out
268435456 bytes (268 MB) copied, 1.27619 s, 210 MB/s

# fsck.exfat test.img 
exfatprogs version : 1.1.1
checksum of boot region is not correct. 0, but expected 0x3ee721
boot region is corrupted. try to restore the region from backup. Fix (y/N)? n

Right now the utilities seem to assume that the device they're pointed at is
always a block device, and image files are problematic.

Also, as an aside, it might be useful to have a "set sector size" commandline
option at least for testing, or to create 4k images that could be transferred
to a 4k device.

Thanks,
-Eric
