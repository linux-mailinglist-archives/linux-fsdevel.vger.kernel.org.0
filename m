Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA97300985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbhAVQu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbhAVQXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:23:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B535C0613D6;
        Fri, 22 Jan 2021 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nmbJnm50gZMOc+7PIT6wU2c1XXrqeE+TUm7Cw7Zy394=; b=h6Z17Sj4n8EOAU0uLOogjb9AS1
        chcTwmbMzQVmY2eh03mUZDYIrwnhhk9Uq2Zzms6rtzlAmj7l/8UKzfqyUeY3w5wvNCy4m8+1dFkmD
        o7kKc10SFC/fMbxsIrX7FDfPgTgfwQTh5Y/moY7xzgeAsRJf1XRCl0oUq5jw9ZpNfk6LWrjpY73ji
        e6A7LyeXzE1bCeu2Et0CvE+GVnC7kfdisXM3/+VLIKXnkv/PC/BhndeO8C7EfpbYV84ESUJru9O6K
        /pcBZjwfGKAtxwfeB3c/hIBSZLVEICTYkwEKo11gW1G48HI8/VSg07TbQcyDgrLCvaVPWA0zRaikm
        XnaLnYrQ==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zD5-000xDY-2H; Fri, 22 Jan 2021 16:23:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: reduce sub-block DIO serialisation v4
Date:   Fri, 22 Jan 2021 17:20:32 +0100
Message-Id: <20210122162043.616755-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This takes the approach from Dave, but adds a new flag instead of abusing
the nowait one, and keeps a simpler calling convention for iomap_dio_rw.

Changes since v3:
 - further comment improvements
 - micro-optimize an alignment check

Changes since v2:
 - add another sanity check in __iomap_dio_rw
 - rename IOMAP_DIO_UNALIGNED to IOMAP_DIO_OVERWRITE_ONLY
 - use more consistent parameter naming
 - improve a few comments
 - cleanup an if statement

Changes since v1:
 - rename the new flags
 - add an EOF check for subblock I/O
 - minor cleanups
