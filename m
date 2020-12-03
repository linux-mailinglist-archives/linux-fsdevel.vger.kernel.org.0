Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9B2CDA60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 16:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLCPv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 10:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLCPv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:51:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47055C061A4E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qMp9uzMJSCPuOk5Suoki8K6MrVesaZ0px0kuLniWQ0g=; b=DwCb3erR+VvjYmid7x5vTrqy8g
        cCTe0YIKi6H0uPAyBMy7cXtKnJid7wJTo/GrFK3825/0iAz/ULn5jFCZm1HiaZ6KUppHEzoRSjazL
        n1OqMtjKtwYdoP3eKBiDh0TbIC64UnCdq6+p41Oo6ZEIyqtWgewO0d8MfsFLy0pKuTpGbIe3NKNro
        +X8CpshY3sheJdLeNzocbulA5m3vpW4Xjhk/QnX3KGygnrswe0aLn10dOE2LmswVqfO/OjeJiI8cL
        B189HBXsV3Ttw8bTX2Di8W6q3SDrcVALezs3c62efrjm28LlqtDKdMFzfyFiawnb9Nc0lF2V4783e
        9wT56ECg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkqsV-0003bW-AL; Thu, 03 Dec 2020 15:50:43 +0000
Date:   Thu, 3 Dec 2020 15:50:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, jlayton@redhat.com,
        dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: Problems doing DIO to netfs cache on XFS from Ceph
Message-ID: <20201203155043.GI11935@casper.infradead.org>
References: <914680.1607004656@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914680.1607004656@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:10:56PM +0000, David Howells wrote:
> Note that I'm only doing async DIO reads and writes, so I was a bit surprised
> that XFS is doing a writeback at all - but I guess that IOCB_DIRECT is
> actually just a hint and the filesystem can turn it into buffered I/O if it
> wants.

That's almost the exact opposite of what is going on.  XFS sees that
you're going to do an O_DIRECT read, so it writes back the dirty memory
that's currently in the page cache so that your read doesn't read stale
data from disk.

