Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09C63AEC32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFUPZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:25:00 -0400
Received: from verein.lst.de ([213.95.11.211]:42390 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUPZA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:25:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED0E268B05; Mon, 21 Jun 2021 17:22:43 +0200 (CEST)
Date:   Mon, 21 Jun 2021 17:22:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: [PATCH 1/2] init: split get_fs_names
Message-ID: <20210621152243.GA6392@lst.de>
References: <20210621062657.3641879-1-hch@lst.de> <20210621062657.3641879-2-hch@lst.de> <YNCrnCvtlOuZO9jV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCrnCvtlOuZO9jV@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:09:16PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 21, 2021 at 08:26:56AM +0200, Christoph Hellwig wrote:
> > -static void __init get_fs_names(char *page)
> > +static void __init split_fs_names(char *page, char *names)
> 
> If you're going to respin it anyway, can you rename 'page' to 'buf'
> or something?  Kind of confusing to have a char * called 'page'.

I was hoping that we did not need a respin.  While Al's suggestion is
nice, and I've added a variant of it to my local tree it really
is just incremental improvements.

I actually thing that page name is not too bad, as it implements the
implicit assumptions that it is a PAGE_SIZE allocation (which is a bad
idea to start with, but we're digging a deeper and deeper hole here..)

> is it really worth doing a strcpy() followed by a custom strtok()?
> would this work better?
> 
> 	char c;
> 
> 	do {
> 		c =  *root_fs_names++;
> 		*buf++ = c;
> 		if (c == ',')
> 			buf[-1] = '\0';
> 	} while (c);

Maybe.  Then again all this is age old rarely used code, so it might be
better to not stirr it too much..

> > +static void __init get_all_fs_names(char *page)
> > +{
> > +	int len = get_filesystem_list(page);
> 
> it occurs to me that get_filesystem_list() fails silently.  if you build
> every linux filesystem in, and want your root on zonefs (assuming
> they're alphabetical), we'll fail to find it without a message
> indicating that we overflowed the buffer.

Yes.  The only sensible way to fix this would be some kind of cursor.
We could use an xarray for the file_systems list, but unless we want
to assume file systems can't go away at init type (which might be an
ok assumption) we'd then need to get into refcount, and and and..
