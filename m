Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42162160A18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 06:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgBQFcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 00:32:54 -0500
Received: from len.romanrm.net ([91.121.86.59]:54424 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgBQFcy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:32:54 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 00:32:53 EST
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 7A69E40503;
        Mon, 17 Feb 2020 05:26:11 +0000 (UTC)
Date:   Mon, 17 Feb 2020 10:26:10 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: dev loop ~23% slower?
Message-ID: <20200217102610.6e92da97@natsu>
In-Reply-To: <CAJCQCtSUzj4V__vo5LxrF1Jv2MgUNux=d8JwXq6H_VN=sYunvA@mail.gmail.com>
References: <CAJCQCtSUzj4V__vo5LxrF1Jv2MgUNux=d8JwXq6H_VN=sYunvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 16 Feb 2020 20:18:05 -0700
Chris Murphy <lists@colorremedies.com> wrote:

> I don't think file system over accounts for much more than a couple
> percent of this, so I'm curious where the slow down might be
> happening? The "hosting" Btrfs file system is not busy at all at the
> time of the loop mounted filesystem's scrub. I did issue 'echo 3 >
> /proc/sys/vm/drop_caches' before the loop mount image being scrubbed,
> otherwise I get ~1.72GiB/s scrubs which exceeds the performance of the
> SSD (which is in the realm of 550MiB/s max)

Try comparing just simple dd read speed of that FS image, compared to dd speed
from the underlying device of the host filesystem. With scrubs you might be
testing the same metric, but it's a rather elaborate way to do so -- and also
to exclude any influence from the loop device driver, or at least to figure
out the extent of it.

For me on 5.4.20:

dd if=zerofile iflag=direct of=/dev/null bs=1M
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB, 2.0 GiB) copied, 3.68213 s, 583 MB/s

dd if=/dev/mapper/cryptohome iflag=direct of=/dev/null bs=1M count=2048
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB, 2.0 GiB) copied, 3.12917 s, 686 MB/s

Personally I am not really surprised by this difference, of course going
through a filesystem is going to introduce overhead when compared to reading
directly from the block device that it sits on. Although briefly testing the
same on XFS, it does seem to have less of it, about 6% instead of 15% here.

-- 
With respect,
Roman
