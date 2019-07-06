Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4F60EA8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 06:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfGFECl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jul 2019 00:02:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43473 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725826AbfGFECl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jul 2019 00:02:41 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6642MTo014588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 Jul 2019 00:02:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EEBD342002E; Sat,  6 Jul 2019 00:02:21 -0400 (EDT)
Date:   Sat, 6 Jul 2019 00:02:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: Question about ext4 testing: need to produce a high depth extent
 tree to verify mapping code
Message-ID: <20190706040221.GC11665@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
 <20190702002355.GB3315@mit.edu>
 <1562028814.2762.50.camel@HansenPartnership.com>
 <20190702173301.GA3032@mit.edu>
 <1562095894.3321.52.camel@HansenPartnership.com>
 <20190702203937.GG3032@mit.edu>
 <1562343948.2953.8.camel@HansenPartnership.com>
 <20190705173905.GA32320@bombadil.infradead.org>
 <1562352542.2953.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562352542.2953.10.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:49:02AM -0700, James Bottomley wrote:
> > Create a series of 4kB files numbered sequentially, each 4kB in size
> > until you fill the partition.  Delete the even numbered ones.  Create
> > a 20MB file.
> 
> Well, I know *how* to do it ... I was just hoping, in the interests of
> creative laziness, that someone else had produced a script for this
> before I had to ... particularly one which leaves more randomized gaps.

You mean something like this?  It doesn't do randomized gaps, since
usually I'm trying to stress test block allocations.

#!/bin/bash

DEV=/dev/lambda/scratch
SIZE=10M

mke2fs -Fq -t ext4 -i 4096 -b 4096 $DEV $SIZE
max=$(dumpe2fs -h $DEV 2>/dev/null | awk -F: '/^Free blocks:/{print $2}')
mount $DEV /mnt
cd /mnt
mkdir -p d{0,1,2,3,4,5,6,7,8,9}/{0,1,2,3,4,5,6,7,8,9}
seq 1 $max | sed -E -e 's;^([[:digit:]])([[:digit:]])([[:digit:]]);d\1/\2/\3;' > /tmp/files$$
cat /tmp/files$$ | xargs -n 1 fallocate -l 4096 2>/dev/null
sed -ne 'p;n' < /tmp/files$$ | xargs rm -f
cd /
umount $DEV
rm /tmp/files$$
