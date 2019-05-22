Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220372652C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfEVNxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 09:53:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50862 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVNxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 09:53:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hTRgR-0006NS-M5; Wed, 22 May 2019 13:53:31 +0000
Date:   Wed, 22 May 2019 14:53:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190522135331.GM17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 12:40:55PM +0200, Vicente Bergas wrote:
> Hi,
> since a recent update the kernel is reporting d_lookup errors.
> They appear randomly and after each error the affected file or directory
> is no longer accessible.
> The kernel is built with GCC 9.1.0 on ARM64.
> Four traces from different workloads follow.

Interesting...  bisection would be useful.

> This trace is from v5.1-12511-g72cf0b07418a while untaring into a tmpfs
> filesystem:
> 
> Unable to handle kernel paging request at virtual address 0000880001000018
> user pgtable: 4k pages, 48-bit VAs, pgdp = 000000007ccc6c7d
> [0000880001000018] pgd=0000000000000000

Attempt to dereference 0x0000880001000018, which is not mapped at all?

> pc : __d_lookup+0x58/0x198

... and so would objdump of the function in question.

> This trace is from v5.2.0-rc1:
> Unable to handle kernel paging request at virtual address 0000880001000018
[apparently identical oops, modulo the call chain to d_lookup(); since that's
almost certainly buggered data structures encountered during the hash lookup,
exact callchain doesn't matter all that much; procfs is the filesystem involved]

> This trace is from v5.2.0-rc1 while executing 'git pull -r' from f2fs. It
> got repeated several times:
> 
> Unable to handle kernel paging request at virtual address 0000000000fffffc
> user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000092bdb9cd
> [0000000000fffffc] pgd=0000000000000000
> pc : __d_lookup_rcu+0x68/0x198

> This trace is from v5.2.0-rc1 while executing 'rm -rf' the directory
> affected from the previous trace:
> 
> Unable to handle kernel paging request at virtual address 0000000001000018

... and addresses involved are

0000880001000018
0000000000fffffc
0000000001000018

AFAICS, the only registers with the value in the vicinity of those addresses
had been (in all cases so far) x19 - 0000880001000000 in the first two traces,
0000000001000000 in the last two...

I'd really like to see the disassembly of the functions involved (as well as
.config in question).
