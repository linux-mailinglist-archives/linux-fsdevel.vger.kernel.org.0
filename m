Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A03AE2BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 07:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFUF2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 01:28:31 -0400
Received: from verein.lst.de ([213.95.11.211]:40524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhFUF23 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 01:28:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E33B68BEB; Mon, 21 Jun 2021 07:26:13 +0200 (CEST)
Date:   Mon, 21 Jun 2021 07:26:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitry Osipenko <digetx@gmail.com>, Tyler Hicks <code@tyhicks.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: require ->set_page_dirty to be explicitly wire
 up
Message-ID: <20210621052612.GA4064@lst.de>
References: <20210614061512.3966143-1-hch@lst.de> <20210614061512.3966143-4-hch@lst.de> <ddafcc0d-8636-46ca-44b7-54392e0d22b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddafcc0d-8636-46ca-44b7-54392e0d22b4@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:23:55PM +0300, Dmitry Osipenko wrote:
> >  21 files changed, 29 insertions(+), 14 deletions(-)
> 
> The ecryptfs is now crashing with NULL deference, please fix.

Which means it crashed the same before on configs without CONFIG_BLOCK.

Tyler, can you look at what ecryptfs should do for ->set_page_dirty?
Currently it implicitly gets __set_page_dirty_buffers for kernels
with COFIG_BLOCK set, but given that this function looks at buffer_heads
that ecryptfs doesn't use it can't really be the right choice.
__set_page_dirty_nobuffers will probably work, but I'd love to see an
audit of the page dirtying and writeback for ecryptfs while we're at it.
