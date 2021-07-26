Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC713D5C07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhGZOFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:05:17 -0400
Received: from verein.lst.de ([213.95.11.211]:45519 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234451AbhGZOFR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:05:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2249667373; Mon, 26 Jul 2021 16:45:41 +0200 (CEST)
Date:   Mon, 26 Jul 2021 16:45:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 01/21] namei: add mapping aware lookup helper
Message-ID: <20210726144540.GA12779@lst.de>
References: <20210726102816.612434-1-brauner@kernel.org> <20210726102816.612434-2-brauner@kernel.org> <YP7JgZCb/AAG17xf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP7JgZCb/AAG17xf@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 03:41:05PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 26, 2021 at 12:27:56PM +0200, Christian Brauner wrote:
> > +/**
> > + * lookup_mapped_one_len - filesystem helper to lookup single pathname component
> 
> Can we think about the name a bit?  In the ur-times (2.3.99), we had
> lookup_dentry(), which as far as I can tell walked an entire path.
> That got augmented with lookup_one() which just walked a single path
> entry.  That was replaced with lookup_one_len() which added the 'len'
> parameter.  Now we have:
> 
> struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
> struct dentry *lookup_one_len(const char *, struct dentry *, int);
> struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
> struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
> 
> I think the 'len' part of the name has done its job, and this new
> helper should be 'lookup_one_mapped'.

Heh.  I'd drop the mapped as well as this should be the new normal
going ahead.
