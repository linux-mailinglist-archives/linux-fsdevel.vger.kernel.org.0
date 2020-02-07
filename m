Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551F1155ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGPbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 10:31:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgBGPbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581089472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJl9IZ4rUKZV3MVrE3d9DP7C/ZB0uGxE0eGmP9j33k8=;
        b=GhdYeeRSEDGNyeY0Up/X+TEsyD07gQJDWNIGh95Y7ZlSSowdPJsCWCEckrNoZK/l6v8C+z
        ngf9r9x1MEV5Y53ZTU5bTGcl2dyMFYgR63+G/hr10RlJr2Ik2o1+VAzUZFGJLOfUIuY4/f
        brcmiSXYee+N84auIbT+ZAY6K1uI34I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-uIY1Wbw4ODWEPr8MtHbRMg-1; Fri, 07 Feb 2020 10:31:11 -0500
X-MC-Unique: uIY1Wbw4ODWEPr8MtHbRMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7746189F762;
        Fri,  7 Feb 2020 15:31:09 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D38B68ECE6;
        Fri,  7 Feb 2020 15:31:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 645CD220A24; Fri,  7 Feb 2020 10:31:06 -0500 (EST)
Date:   Fri, 7 Feb 2020 10:31:06 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH 4/5] dax,iomap: Start using dax native zero_page_range()
Message-ID: <20200207153106.GA11998@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-5-vgoyal@redhat.com>
 <20200205183356.GD26711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205183356.GD26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:33:56AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 03:00:28PM -0500, Vivek Goyal wrote:
> > +	id = dax_read_lock();
> > +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> > +	dax_read_unlock(id);
> > +	return rc;
> 
> Is there a good reason not to move the locking into dax_zero_page_range?

Thinking more about it. If we keep locking outside, then we don't have
to take lock again when we recurse into dax_zero_page_range() in device
mapper path. IIUC, just taking lock once at top level is enough. If that's
the case then it probably is better to keep locking outside of
dax_zero_page_range().

Thanks
Vivek

