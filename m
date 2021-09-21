Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D41C41302C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 10:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhIUIcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 04:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhIUIb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:31:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A4C061574;
        Tue, 21 Sep 2021 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hyM4Qp2zpVFqYLg/eBbj985or6BuMwU9PP/6MWkDIkk=; b=PSX2hL22n1ZYAnETPGPeVgtt5O
        4UJcYEh02QzoCZjgk9qowR+lHUEwI9Y4QEyVKp4Du4xDXBlS0+U/JBACYW1JIeY+Ep7yjJTjG8G0t
        x0VWNaSf3KznA3VMlKRK9diCaCCy/+1YHy3yMd6fLnS/wp6/PP/PqKXQluixcPWYXS3UwnR2C6uxC
        a+R53/Ae3xisXgAz6bWV/SCPLVQuxi8JVXS/QTU4IiJ0R+Rs0Bvcz7+BPKtTZ0tFasEwAqh6nUbsp
        M3dBZ+cyPEZSNZ8uYzz4ko04S19h5PBq4VAnWRPlkDsE32XlXGxWqHSEGMVNy4urVS4EE7Vv1SrRG
        9Gjl17UQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSb9Z-003dXs-VC; Tue, 21 Sep 2021 08:29:33 +0000
Date:   Tue, 21 Sep 2021 09:29:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: use accelerated zeroing on a block device to
 zero a file range
Message-ID: <YUmX5VD7zOtWtBo8@infradead.org>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865577.417973.11122330974455662098.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192865577.417973.11122330974455662098.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:30:55PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a function that ensures that the storage backing part of a file
> contains zeroes and will not trip over old media errors if the contents
> are re-read.

I don't think this has anything to do with direct I/O, so I'd rather
not have it clutter direct-io.c.  Also do we really want to wait
synchronously for every bio instead of batching them up?  Especially
as a simple bio_chain is probably all that is needed.
