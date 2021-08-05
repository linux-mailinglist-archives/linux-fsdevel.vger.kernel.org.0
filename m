Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4218F3E1B36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbhHES2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 14:28:04 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:60480 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhHES2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:28:03 -0400
X-Greylist: delayed 2259 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 14:28:03 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mBhR0-001psM-2y; Thu, 05 Aug 2021 19:45:34 +0200
Date:   Thu, 5 Aug 2021 19:45:34 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Could it be made possible to offer "supplementary" data to a DIO
 write ?
Message-ID: <YQwjvlvnBNPJbMwc@angband.pl>
References: <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1186271.1628174281@warthog.procyon.org.uk>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:38:01PM +0100, David Howells wrote:
> Generally, I prefer to write back the minimum I can get away with (as does the
> Linux NFS client AFAICT).
> 
> However, if everyone agrees that we should only ever write back a multiple of
> a certain block size, even to network filesystems, what block size should that
> be?  Note that PAGE_SIZE varies across arches and folios are going to
> exacerbate this.  What I don't want to happen is that you read from a file, it
> creates, say, a 4M (or larger) folio; you change three bytes and then you're
> forced to write back the entire 4M folio.

grep . /sys/class/block/*/queue/minimum_io_size
and also hw_sector_size, logical_block_size, physical_block_size.

The data seems suspect to me, though.  I get 4096 for a spinner (looks
sane), 512 for nvme (less than page size), and 4096 for pmem (I'd expect
cacheline or ECC block).


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ Certified airhead; got the CT scan to prove that!
⠈⠳⣄⠀⠀⠀⠀
