Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0A1BA17D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgD0Ki5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 06:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726504AbgD0Ki4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:38:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C9C0610D5;
        Mon, 27 Apr 2020 03:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sw+Gz0B1RPAiyQjtRtSaz9HX0MO96kOBToT1rHJ/CnQ=; b=kxOmwFjWfczqIhl2MpNpVzUU7u
        NOZr4eVIT5rOYv4QZ0kXVdGssHpI3JnKHaXyhbJ4l9YGB5vSg8A+Exd1p0dkEP+SkENA/s52XleY0
        qYjArcX12b5+x5tknzbxIT4ZH8DLYbhi3JPhwqQ4ZlTc1gWtZ6O9qJwek/B0Ow2dudfviR3ImuGXT
        KlTjJcXe7I+xwmg1HjhYdpqj4vgml0606SeajgkhTDHKZiF5g8PbKK3fcVJ7RfsjUTPuTBJus8TGc
        gGsV91mCXhq+1RgtogkVcYqrrnOKgpm5RrG35LbQf+okwPEdmGnbVyL8hQ7mkpSE8u4BXoGwHnldH
        o4bCwjDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT1A6-0008KE-9g; Mon, 27 Apr 2020 10:38:54 +0000
Date:   Mon, 27 Apr 2020 03:38:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200427103854.GA30463@infradead.org>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
 <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
 <20200425094350.GA11881@infradead.org>
 <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
 <20200427062810.GA12930@infradead.org>
 <CAOQ4uxicztq5toBst2tEO4MfbrTPyhyP8KVwki36V9fZ=24RCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxicztq5toBst2tEO4MfbrTPyhyP8KVwki36V9fZ=24RCw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 01:15:22PM +0300, Amir Goldstein wrote:
> On Mon, Apr 27, 2020 at 9:28 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Apr 25, 2020 at 01:49:43PM +0300, Amir Goldstein wrote:
> > > I would use as generic helper name generic_fiemap_checks()
> > > akin to generic_write_checks() and generic_remap_file_range_prep() =>
> > > generic_remap_checks().
> >
> > None of the other fiemap helpers use the redundant generic_ prefix.
> 
> Fine. I still don't like the name _validate() so much because it implies
> yes or no, not length truncating.
> 
> What's more, if we decide that FIEMAP_FLAG_SYNC handling should
> be done inside this generic helper, we would definitely need to rename it
> again. So how about going for something a bit more abstract like
> fiemap_prep() or whatever.

Ok, I'll rename it to fiemap_prep.

> 
> What is your take about FIEMAP_FLAG_SYNC handling btw?

Oh, I hadn't really noticed that mess.  Taking it into fiemap_prep
might make most sense, so that it nominally is under fs control for
e.g. locking purposes.
