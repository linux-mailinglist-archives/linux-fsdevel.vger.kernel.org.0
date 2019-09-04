Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC759A8336
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfIDMvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 08:51:14 -0400
Received: from verein.lst.de ([213.95.11.211]:39076 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfIDMvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:51:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2168F227A8A; Wed,  4 Sep 2019 14:51:11 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:51:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 2/2] iomap: move the iomap_dio_rw ->end_io callback
 into a structure
Message-ID: <20190904125110.GB17285@lst.de>
References: <20190903130327.6023-1-hch@lst.de> <20190903130327.6023-3-hch@lst.de> <20190903161446.GH29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903161446.GH29434@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:14:46AM -0700, Matthew Wilcox wrote:
> On Tue, Sep 03, 2019 at 03:03:27PM +0200, Christoph Hellwig wrote:
> > Add a new iomap_dio_ops structure that for now just contains the end_io
> > handler.  This avoid storing the function pointer in a mutable structure,
> > which is a possible exploit vector for kernel code execution, and prepares
> > for adding a submit_io handler that btrfs needs.
> 
> Is it really a security win?  If I can overwrite dio->end_io, I can as
> well overwrite dio->dops.

Which you'd then need to point to another place where you can stuff
function pointer.  Not impossible, but just another hoop to jump
through.  At least until we add run-time checks that ops structures
are in read-only memory, which sounds more sensible than some of the
other security hardening patches floating around.
