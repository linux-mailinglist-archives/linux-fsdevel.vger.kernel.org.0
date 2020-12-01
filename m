Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46982CA0FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 12:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgLALMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 06:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbgLALMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:12:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E09C0613CF;
        Tue,  1 Dec 2020 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L4mnwU/HxbxdBQAkJAxSekprtMyJq0YPW8n3YxcjIPs=; b=PMBGkepi6WwfRYp52aqx68zI5x
        fFdZQsC0L8JEEFNN3aYmdmLtm/o5kwC9tbr9oSkp3BnFOXkTUgKjqkHxiJUunyUIdTZdhPfyL5Uol
        5mBeI+QI/GWCiFON552tzQZgDGHs+P5U1Jk1QDi2l4ClSa3w+1EhVYvFR+uGU6OHbyba4/ckTNbHZ
        NF0a1HRRzgnQ4L4Clvb3kzYPf8psyvrFZZNIBQB3cwiv2G1lUZjEIjsZ7tlw0nnn0HEiYF0LFjrNT
        zgisq9DL3miUuvvLRR2y7f2MbB4MlXPBA6t99zGVB6z8OC6DN3QiaxbeyuEbXxyDFZbguy4v7o15o
        LXXGkw1g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk3ZS-0007vM-8Y; Tue, 01 Dec 2020 11:11:46 +0000
Date:   Tue, 1 Dec 2020 11:11:46 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Message-ID: <20201201111146.GA30215@infradead.org>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
 <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <1dc43899-82de-564f-6e52-bd5b990f3887@cobb.uk.net>
 <CH2PR04MB6522151758FE8FD0ECBCB09EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6522151758FE8FD0ECBCB09EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:03:35AM +0000, Damien Le Moal wrote:
> Well, not really. HA drives, per specifications, are backward compatible. If
> they are partitioned, the block layer will force a regular drive mode use,
> hiding their zoned interface, which is completely optional to use in the first
> place.
> 
> If by "untested territory" you mean the possibility of hitting drive FW bugs
> coming from the added complexity of internal GC, then I would argue that this is
> a common territory for any FS on any drive, especially SSDs: device FW bugs do
> exist and show up from time to time, even on the simplest of drives.

Also note that most cheaper hard drives are using SMR internally,
you'll run into the same GC "issues" as with a HA drive that is used for
random writes.
