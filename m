Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D832677FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 07:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgILFbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 01:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgILFbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 01:31:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69286C061573;
        Fri, 11 Sep 2020 22:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0x/t0oX5H4dK+bk/bCWfoS6UtexU6TQHHM8GfgvOht0=; b=d8pFiNp1WzQ40/xFXvBgeTi0ZX
        vaf1GWLLPeagUSZkHgR6eIzz9keki3nMdCDdhwRfuLybtW06MZvfYRBGWnbrJMkG10Stq0GDAJ+hW
        kL8LDXC+AIUPRqneVdpf4Q4r3rQCbK9+1HFzR7zM3nFgj24b1FpugJwYsBZTo8kW5ap7Ecyu0+g8/
        njsAjePLqTckEUfY8WgGJ+S7RAxPabejhJ8IEucxdgXd9tUAIziu4+Yi9MT5Mtgxl0rCsgyGqmQa5
        BXzTyL8y3W+KqIaF+R6U5q/STbp8fobS9yA7qAtocYLTI9O2J8DXafbyUyt8WyLDoCMY6g/4HEZqP
        cSBZcB+A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGy7k-0004CY-PY; Sat, 12 Sep 2020 05:30:56 +0000
Date:   Sat, 12 Sep 2020 06:30:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 19/39] btrfs: limit bio size under max_zone_append_size
Message-ID: <20200912053056.GA15640@infradead.org>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200911123259.3782926-20-naohiro.aota@wdc.com>
 <20200911141719.GA15317@infradead.org>
 <20200912041424.w4jhmsvrgtrcie2n@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912041424.w4jhmsvrgtrcie2n@naota.dhcp.fujisawa.hgst.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 01:14:24PM +0900, Naohiro Aota wrote:
> > For zoned devices you need to use bio_add_hw_page instead of so that all
> > the hardware restrictions are applied.  bio_add_hw_page asso gets the
> > lenght limited passed as the last parameter so we won't need a separate
> > check.
> 
> I think we can't use it here. This bio is built for btrfs's logical space,
> so the corresponding request queue is not available here.
> 
> Technically, we can use fs_devices->lateste_bdev. But considering this bio
> can map to multiple bios to multiple devices, limiting the size of this bio
> under the minimum queue_max_zone_appends_sectors() among devices is
> feasible.

Well, how do you then ensure the bio actually fits all the other
device limits as well?  e.g. max segment size, no SG gaps policy,
etc?
