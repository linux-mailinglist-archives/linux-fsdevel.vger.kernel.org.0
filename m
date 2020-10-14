Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987F828E79D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJNUAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 16:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgJNUAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602705624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7I+CkkVyW0LEBsjAsDgn5kJF253GDQKmssIfCD+tfuw=;
        b=fZVSYNUXM42BpWtwfly5a0iEt+u2RITiLPpJSlDIVCR9IvilY55omsRPfWijDDzWD1sq/h
        wwPcAwDLTcsgUAgLBCujHQXA4UJF1oEHccoEQE2m//UIo/F0ShQCzJ9LCbrRqna6jJWgsv
        +el4bVw6lJqP3pwuxOqVCNcQOa9LqP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-J_dcwuqWOT6ktYOxYFDOlQ-1; Wed, 14 Oct 2020 16:00:22 -0400
X-MC-Unique: J_dcwuqWOT6ktYOxYFDOlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EDB51020915;
        Wed, 14 Oct 2020 20:00:21 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4D8176655;
        Wed, 14 Oct 2020 20:00:20 +0000 (UTC)
Date:   Wed, 14 Oct 2020 16:00:19 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 05/14] iomap: Support THPs in invalidatepage
Message-ID: <20201014200019.GA1119840@bfoster>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-6-willy@infradead.org>
 <20201014163347.GI9832@magnolia>
 <20201014172634.GP20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014172634.GP20115@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 06:26:34PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 14, 2020 at 09:33:47AM -0700, Darrick J. Wong wrote:
> > > @@ -1415,7 +1420,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > >  			 */
> > >  			if (wpc->ops->discard_page)
> > >  				wpc->ops->discard_page(page);
> > > -			ClearPageUptodate(page);
> > 
> > Er, I don't get it -- why do we now leave the page up to date after
> > writeback fails?
> 
> The page is still uptodate -- every byte in this page is at least as new
> as the corresponding bytes on disk.
> 

That seems rather odd if the preceding ->discard_page() turned an
underlying delalloc block into a hole. Technically the original written
data is still in the page, but it's no longer allocated/mapped or dirty
so really no longer in sync with on-disk state. Hm?

Brian

