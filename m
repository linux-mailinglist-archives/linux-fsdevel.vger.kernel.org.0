Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6116195A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgBQSFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:05:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbgBQSFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581962704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRqcrGPHEdqvwZNYYrrPoLpqoBOsV7DSl5ls/cswJjQ=;
        b=HvlPe76UCfOUheA9Fn3Wdl+zh+KPct0krdJ0mOYO++plq9Q9Ch8spJjaf9+ohjOLfUHVmq
        7b/Snzc8F8vVPiXcFYP0uAoL+4O35aEi8Oh3jAPknC5AI0TWDB0FjuQilPU/btRFHqxMIs
        X6ZbgBsLBAvrBZjqcexo+2RcoLPyHC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Ntyb3J08PpyLN9WEeRLa9Q-1; Mon, 17 Feb 2020 13:05:01 -0500
X-MC-Unique: Ntyb3J08PpyLN9WEeRLa9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A5313F5;
        Mon, 17 Feb 2020 18:04:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B21C119C69;
        Mon, 17 Feb 2020 18:04:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2E8782257D2; Mon, 17 Feb 2020 13:04:56 -0500 (EST)
Date:   Mon, 17 Feb 2020 13:04:56 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 1/7] pmem: Add functions for reading/writing page
 to/from pmem
Message-ID: <20200217180456.GB24816@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-2-vgoyal@redhat.com>
 <20200217132138.GB14490@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217132138.GB14490@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:21:38AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 07, 2020 at 03:26:46PM -0500, Vivek Goyal wrote:
> > +static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> > +			unsigned int len, unsigned int off, unsigned int op,
> > +			sector_t sector)
> > +{
> > +	if (!op_is_write(op))
> > +		return pmem_do_read(pmem, page, off, sector, len);
> > +
> > +	return pmem_do_write(pmem, page, off, sector, len);
> 
> Why not:
> 
> 	if (op_is_write(op))
> 		return pmem_do_write(pmem, page, off, sector, len);
> 	return pmem_do_read(pmem, page, off, sector, len);
> 
> that being said I don't see the point of this pmem_do_bvec helper given
> that it only has two callers.

Ok, I am about to post V4 of patches and I got rid of pmem_do_bvec() and
callers are directly calling pmem_do_read()/pmem_do_write().

Vivek

