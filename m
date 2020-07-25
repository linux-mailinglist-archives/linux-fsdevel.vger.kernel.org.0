Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113222DAAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 02:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGYX76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 19:59:58 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:42893 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727936AbgGYX76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 19:59:58 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id A7CF21A8F1C;
        Sun, 26 Jul 2020 09:59:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jzU53-0001Vy-Lo; Sun, 26 Jul 2020 09:59:53 +1000
Date:   Sun, 26 Jul 2020 09:59:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200725235953.GS2005@dread.disaster.area>
References: <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200723220752.GF2005@dread.disaster.area>
 <20200723230345.GB870@sol.localdomain>
 <20200724013910.GH2005@dread.disaster.area>
 <20200724034628.GC870@sol.localdomain>
 <20200724053130.GO2005@dread.disaster.area>
 <20200724174132.GB819@sol.localdomain>
 <20200725234751.GR2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725234751.GR2005@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=Tb48QDFj_K4opPCY4YMA:9 a=wVewhsGeiREcnvQl:21 a=ko93nJrUK3cXB_oi:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 09:47:51AM +1000, Dave Chinner wrote:
> On Fri, Jul 24, 2020 at 10:41:32AM -0700, Eric Biggers wrote:
> > But again, as far as I can tell, fs/iomap/direct-io.c currently *does* guarantee
> > that *if* the input is fully filesystem-block-aligned and if blocksize <=
> > PAGE_SIZE, then the issued I/O is also filesystem-block-aligned.
> 
> Please listen to what I'm saying, Eric.
> 
> The -current iomap implementation- may provide that behaviour. That
> doesn't mean we guarantee that behaviour. i.e. the iomap -design-
> does not guaranteee that behaviour, and we don't guarantee such
> behaviour into the future. And we won't guarantee this behaviour -
> even though the current implementation may provide it - because the
> rest of the IO stack below iomap does not provide iomap with that
> guarantee.
> 
> Hence if iomap cannot get a guarantee that IO it issues won't get
> split at some arbitrary boundary, it cannot provide filesystems with
> that guarantee.

BTW, if you want iomap_dio_rw() to provide an arbitrary bio
alignment guarantee at the iomap layer, then it should be returned
in the iomap along with the extent mapping. That could then be used
instead of the bdev logical block size. That won't guarantee the
behaviour of the rest of the stack, but it would provide a defined
IO submission behaviour that iomap would have to guarantee into the
future...

That would also remove the need to duplicate the alignment checks
in the filesystem for fscrypt DIO...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
