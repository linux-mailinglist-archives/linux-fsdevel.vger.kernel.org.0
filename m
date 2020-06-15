Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78251FA4B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFOXoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 19:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgFOXon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:44:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A70C061A0E;
        Mon, 15 Jun 2020 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9LrsRcBlWqK6GZt2ILF8keDiR6lb4L76fvXL0ZgwtlM=; b=NlhknIfYOP8n71eL1v+xNNCDOB
        uvRxXLNON/+3nNycKSwnI55iiCoxlANv+8AbUenbcK9oqXuSiR+wCdqbWk/D9W5C9bwxYWWMjQ4vU
        egt7xkUvXJu6x33o6h5UBbSCPBQiVWdMcvJv0g9yoPwNh0aPrUBoCxqErqEiLr8/NHvJShN4oSa65
        wB46GUcBhx3KVBbshIPDGy4myLgOFa7Xq6oYdJ4z4tLWUpEPhjkqlU4AvNWc9sDBl4uuwY5lCl8Ay
        CFZ29K8L5oL2/n1Fby5ZNYpfuJNrmz75DYBUh61+/LYBCGkg2YMlixsZ3WAtIOG9oGfBJrCEzKVcz
        lQ1cfVkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkymL-00022q-Gn; Mon, 15 Jun 2020 23:44:37 +0000
Date:   Mon, 15 Jun 2020 16:44:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200615234437.GX8681@bombadil.infradead.org>
References: <20200615160244.741244-1-agruenba@redhat.com>
 <20200615233239.GY2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615233239.GY2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:32:39AM +1000, Dave Chinner wrote:
> On Mon, Jun 15, 2020 at 06:02:44PM +0200, Andreas Gruenbacher wrote:
> > Make sure iomap_end is always called when iomap_begin succeeds: the
> > filesystem may take locks in iomap_begin and release them in iomap_end,
> > for example.
> 
> Ok, i get that from the patch, but I don't know anything else about
> this problem, and nor will anyone else trying to determine if this
> is a fix they need to backport to other kernels. Can you add some
> more information to the commit message, such as how was this found
> and what filesystems it affects? It would also be good to know what
> commit introduced this issue and whether it need stable back ports
> (i.e. a Fixes tag).

I'd assume Andreas is looking at converting a filesystem to use iomap,
since this problem only occurs for filesystems which have returned an
invalid extent.

I almost wonder if this should return -EFSCORRUPTED rather than -EIO.
Um, except that's currently a per-fs define.  Is it time to move that
up to errno.h?
