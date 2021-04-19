Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67201363F05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhDSJnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbhDSJm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:42:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A0C06174A;
        Mon, 19 Apr 2021 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TJVXtI9X2kcptz9UBE/JvUwJanKZ4gbvYwSLMqz6T0=; b=V0/cr8zLKuJGdpCGbZew7airJL
        46ipns0v+MwJUhsQBXTH+DZlRTHjocgl9d7jgveKVxfDJEyNaZoJjd1lXaNF00eZ/2CivzveEEHqw
        edPsPTmSI/imOc293tM3R3jGSDjJ2ntpCaOedZeyVjtEeWP6U6o+ofHOSkZB8PuqFvXlhkxLJInsQ
        kl9ZGgCHZGvV9HR9PMLxNlFP4fB0656W/wYNz8NGOGq05Ks/zT4Fn0rES1V+Tjly7p+RfeFNnruMs
        r9b+TZanWhZViH/3TCVgYaLIwZMOfugEyoq++Y2hFqZDGLZq1lDMMy6V8i9qCLBW27GcHz+v1IJI/
        XAj1YZlw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYQNF-00DXWh-2b; Mon, 19 Apr 2021 09:39:47 +0000
Date:   Mon, 19 Apr 2021 10:39:21 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Message-ID: <20210419093921.GA3226573@infradead.org>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
 <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 09:35:37AM +0000, Damien Le Moal wrote:
> This is only to avoid someone from running zoned-btrfs on top of dm-crypt.
> Without this patch, mount will be OK and file data writes will also actually be
> OK. But all reads will miserably fail... I would rather have this patch in than
> deal with the "bug reports" about btrfs failing to read files. No ?
> 
> Note that like you, I dislike having to add such code. But it was my oversight
> when I worked on getting dm-crypt to work on zoned drives. Zone append was
> overlooked at that time... My bad, really.

dm-crypt needs to stop pretending it supports zoned devices if it
doesn't.  Note that dm-crypt could fairly trivially support zone append
by doing the same kind of emulation that the sd driver does.
