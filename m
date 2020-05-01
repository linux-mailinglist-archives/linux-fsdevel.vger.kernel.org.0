Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A21C1DD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgEAT0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 15:26:43 -0400
Received: from verein.lst.de ([213.95.11.211]:48441 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgEAT0n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 15:26:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 256FE68C4E; Fri,  1 May 2020 21:26:40 +0200 (CEST)
Date:   Fri, 1 May 2020 21:26:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaw@google.com
Subject: Re: [PATCH 2/2] exec: open code copy_string_kernel
Message-ID: <20200501192639.GA25896@lst.de>
References: <20200501104105.2621149-1-hch@lst.de> <20200501104105.2621149-3-hch@lst.de> <20200501125049.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501125049.GL23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 01:50:49PM +0100, Al Viro wrote:
> On Fri, May 01, 2020 at 12:41:05PM +0200, Christoph Hellwig wrote:
> > Currently copy_string_kernel is just a wrapper around copy_strings that
> > simplifies the calling conventions and uses set_fs to allow passing a
> > kernel pointer.  But due to the fact the we only need to handle a single
> > kernel argument pointer, the logic can be sigificantly simplified while
> > getting rid of the set_fs.
> 
> I can live with that...  BTW, why do we bother with flush_cache_page() (by
> way of get_arg_page()) here and in copy_strings()?  How could *anything*
> have accessed that page by its address in new mm - what are we trying to
> flush here?

s/get_arg_page/flush_arg_page/ ?

No idea, what the use case is, but this comes from:

commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba
Author: Ollie Wild <aaw@google.com>
Date:   Thu Jul 19 01:48:16 2007 -0700

    mm: variable length argument support
