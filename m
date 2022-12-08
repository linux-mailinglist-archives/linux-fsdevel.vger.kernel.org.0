Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DE06476EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLHUCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 15:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHUCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:02:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F9D6FF32;
        Thu,  8 Dec 2022 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=j/661ETT7jvXZ2YUrlW9YzygRkEAgddfmDyMMprNc44=; b=nxLf4cAhEoBid8iykXBDVaVzoE
        V3J6KRKK8OcKs+nM+YpiSidOTJRdpKfVOQ7cx/UVBaqH7+kjW9L4CeJPhyILxXcxHrKHxpOOFyyHu
        W4mEKspnv1q4lAX47QWMxy9my3xssP63wPi0nGNMwfUaVZKhlFBk+/Gtvp8QYdYtnFdAtH13tHRXN
        lIJyUuQ/TxM9XJ5LbkZMXsAEW7h8VDNLsnGY3x+8LNxKfOXN3aKoNBWw5WBtLdXTPwJ5Lb0JRduzc
        8Me2W7mdNbQkJAXq+BUTRkkPHK/rVB6y5YUve3LM7ua8BsCMwnjcDVy3c4r0Wd+XWJfIJ5cvICPjA
        dlYCUmaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3N69-007HEG-5p; Thu, 08 Dec 2022 20:02:25 +0000
Date:   Thu, 8 Dec 2022 20:02:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Y5JC0Q3dOLS1g70/@casper.infradead.org>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 03, 2022 at 07:19:17AM +0300, Javier González wrote:
> > On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
> > As long as the protocols don't provide proof-of-work, trying this
> > doesn't really prove anything with respect to this concern.
> 
> Is this something we should bring to NVMe? Seems like the main disagreement can be addressed there. 
> 
> I will check internally if there is any existing proof-of-work that we are missing. 

I think the right thing for NVMe to standardise is a new command, HASH.

It should be quite similar to the READ command, at least for command
Dwords 10-15.  Need to specify the hash algorithm to use somewhere
(maybe it's a per-namespace setting, maybe a per-command setting).
The ctte will have to decide which hash algos are permitted / required
(it probably makes sense to permit even some quite weak hashes as we're
not necessarily looking to have cryptographic security).

While there may be ways to make use of this command for its obvious usage
(ie actually producing a hash and communicating that to somebody else),
its real purpose is for the drive to read the data from storage and prove
it's still there without transferring it to the host, as discussed in
this thread.
