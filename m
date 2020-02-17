Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1B161968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgBQSIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:08:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729822AbgBQSIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581962896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKPYNNkCF3IqXeM4Sekm3RjE/MqPpfUyUylxVmrQRcA=;
        b=dD5NETs0U0Bui6M54uaHHMFzyDD6PRmUPb1EDQ+gGi7oCJm2E+38anC9u7GQf5W9wk3eJI
        z8MZHRjIXap/H6qmEvFS+9ImmuUfBHyafdtjOG/sXpQDmFFXPj6FX3yfUC67JU/Q/ig6Z2
        y//THsTb7XkrfMAI7U+ldb55Iz1/VgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-3WlWElH3Ph-COvLq3VxCdg-1; Mon, 17 Feb 2020 13:08:12 -0500
X-MC-Unique: 3WlWElH3Ph-COvLq3VxCdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2248107ACC5;
        Mon, 17 Feb 2020 18:08:10 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E649D19C69;
        Mon, 17 Feb 2020 18:08:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 770172257D2; Mon, 17 Feb 2020 13:08:07 -0500 (EST)
Date:   Mon, 17 Feb 2020 13:08:07 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 3/7] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200217180807.GC24816@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-4-vgoyal@redhat.com>
 <20200217132607.GD14490@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217132607.GD14490@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:26:07AM -0800, Christoph Hellwig wrote:
> > +	int rc;
> > +	struct pmem_device *pmem = dax_get_private(dax_dev);
> > +	struct page *page = ZERO_PAGE(0);
> 
> Nit: I tend to find code easier to read if variable declarations
> with assignments are above those without.

Fixed in V4. 

> 
> Also I don't think we need the page variable here.

Fixed in V4.

> 
> > +	rc = pmem_do_write(pmem, page, 0, offset, len);
> > +	if (rc > 0)
> > +		return -EIO;
> 
> pmem_do_write returns a blk_status_t, so the type of rc and the > check
> seem odd.  But I think pmem_do_write (and pmem_do_read) might be better
> off returning a normal errno anyway.

Now I am using blk_status_to_errno() to convert error in V4.

        rc = pmem_do_write(pmem, ZERO_PAGE(0), 0, offset, len);
        return blk_status_to_errno(rc);

Did not modify pmem_do_read()/pmem_do_write() to return errno as there
is still one caller which expects to return blk_status_t and then that
caller will have to do the converstion.

Having said that, it probably is good idea to clean up functions called
by pmem_do_read()/pmem_do_write() to return errno. I prefer not to take
that work in that patch series as that seems like a nice to have thing
and can be handled in a separate patch series.

Thanks
Vivek

