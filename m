Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF153206C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBTTLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 14:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTTLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:11:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA018C061574;
        Sat, 20 Feb 2021 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8+/WNpbsZkqwy3FrYALDel13DrFd2M7SHQC2LqXykk=; b=Coqv5TZ84pbYV63BlHltSBs+O6
        PKlkeMKd9GjQBqahXNppgY+/xX6UfosepmWfMMZGYxfbMYZLokGKnYGxzrHd//hRD3ea6ydPU5Ytr
        jk14BWdCLSI0Xjk4dUlY/0AuGf7+IS46QTKPcxQDHjVPt697wE7M9ASyd68sRt67wCFENbj1Sy0kt
        KqqHpoWVrNfHkIOOJDK9bcVxCM3THBS7gsYqggibHRGGsuhhWcqYjoHcE5wj4W2q5T06Uq2cui7oH
        FimgH0MLEq4pfqGbJ2iPd/+91tRxJFefAI/iiGCu+kY3koSvRTlYD9gNzRUZzIek5wvaRqZ0H05K1
        L7LLTzpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDXcL-004MAE-36; Sat, 20 Feb 2021 19:08:48 +0000
Date:   Sat, 20 Feb 2021 19:08:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'SelvaKumar S' <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210220190837.GE2858050@casper.infradead.org>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 06:01:56PM +0000, David Laight wrote:
> From: SelvaKumar S
> > Sent: 19 February 2021 12:45
> > 
> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
> > v2020.05.04 ("Ratified")
> > 
> > The Specification can be found in following link.
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> > 
> > Simple copy command is a copy offloading operation and is  used to copy
> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
> > LBA within the device reducing traffic between host and device.
> 
> Sounds to me like the real reason is that the copy just ends up changing
> some indirect block pointers rather than having to actually copy the data.

That would be incorrect, at least for firmware that I have knowledge of.
There are checksums which involve the logical block address of the data,
and you can't just rewrite the checksum on NAND, you have to write the
entire block.

Now, firmware doesn't have to implement their checksum like this,
but there are good reasons to do it this way (eg if the command gets
corrupted in transfer and you read the wrong block, it will fail the
checksum, preventing the drive from returning Somebody Else's Data).

So let's take these people at their word.  It is to reduce traffic
between drive and host.  And that is a good enough reason to do it.
