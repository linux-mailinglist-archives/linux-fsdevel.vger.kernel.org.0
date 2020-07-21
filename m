Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F022835A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgGUPOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgGUPOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42AAC061794;
        Tue, 21 Jul 2020 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L2IbMCLmXxLVXEbJI5GOxqFQTK+vaWxJ0qX9RDKgocU=; b=N93dj4NpDZw8qnGw993PSgn1jU
        ivKEowyzoIxKFcSLhMslSWJyETkzgzuoIPasc66y7jJmr49TmmM6FIqRUGY143DY69PpwM8wS8YQR
        7RVnpRFnvczE0qeq29vnCSn1Uovtq6atrO3wT3SZML0l0UMe3gIaUqXCoEPYQKd4czRz2VdMZMEtF
        U9qWGdSxrVtZTR9wjXWNL5Ptkg2h5hctcStWWx7wk0z96OD32o7xtpfLsoRijWi+uA9t7PtEjkOkV
        NDqFHCaA14wIjI3IHpVWdqM/5bTsCrx++3zd2tlxoUOxXGXYFFCeBUBNcMop+0yi1/ih4aj2EgSbs
        F8xVS06g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxtyX-0002lR-7v; Tue, 21 Jul 2020 15:14:37 +0000
Date:   Tue, 21 Jul 2020 16:14:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721151437.GI15516@casper.infradead.org>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
 <20200721150432.GH15516@casper.infradead.org>
 <20200721150615.GA10330@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721150615.GA10330@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:06:15PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 04:04:32PM +0100, Matthew Wilcox wrote:
> > I thought you were going to respin this with EREMCHG changed to ENOTBLK?
> 
> Oh, true.  I'll do that ASAP.

Michael, could we add this to manpages?

--- write.2.old	2020-07-21 11:11:17.740491825 -0400
+++ write.2	2020-07-21 11:13:05.900389249 -0400
@@ -192,6 +192,12 @@
 .IR count ,
 or the file offset is not suitably aligned.
 .TP
+.B ENOTBLK
+The file was opened with the
+.B O_DIRECT
+flag, and the I/O could not be completed due to another process using
+the file.
+.TP
 .B EIO
 A low-level I/O error occurred while modifying the inode.
 This error may relate to the write-back of data written by an earlier

