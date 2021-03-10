Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB7333D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhCJNDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJNCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:02:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AEC061760;
        Wed, 10 Mar 2021 05:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ALr5iWDNLGdU3HVoDSzUHGSO+jgvXP9RVBf6+KXFgYU=; b=G03GxTkrZ0HvyN9TVTTGv9fFLu
        gglr3sTaBNVnfJtIdTSSB3LxjkuAQCN2m8iNAGscB85rKFvB+BNOo0fcOeMhm6uSOC32XSEbiHq8C
        pqA92+K31BjmkI5VQ4CKOtGV0af3hjaG+wyN5nnEIbT1f4dhM5s114qtLSudoKjXcF4vjuLaUUQuW
        PBedOIBQUD58iR43kVmEiEOTxom08dYlGj2BYh9vMwA+ltYAI5zuIhaV6NSnijO6ClL59uCl0bJTl
        iwWyJUrreoI1HR6Nn9PaGnXWN98KC9HTZzq/VQTuGCX7GPBlPOIRxLVlfNfcjMjnM+7KQ62pgaidJ
        hsNHYh/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJyTr-003TrT-Va; Wed, 10 Mar 2021 13:02:28 +0000
Date:   Wed, 10 Mar 2021 13:02:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, dan.j.williams@intel.com, jack@suse.cz,
        viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310130227.GN3479805@casper.infradead.org>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> Forgive my ignorance, but is there a reason why this isn't wired up to
> Btrfs at the same time? It seems weird to me that adding a feature

btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.

If you think about it, btrfs and DAX are diametrically opposite things.
DAX is about giving raw access to the hardware.  btrfs is about offering
extra value (RAID, checksums, ...), none of which can be done if the
filesystem isn't in the read/write path.

That's why there's no DAX support in btrfs.  If you want DAX, you have
to give up all the features you like in btrfs.  So you may as well use
a different filesystem.
