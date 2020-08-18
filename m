Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1435248F5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHRUH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 16:07:29 -0400
Received: from verein.lst.de ([213.95.11.211]:34984 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHRUH3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:07:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B5EB68AFE; Tue, 18 Aug 2020 22:07:25 +0200 (CEST)
Date:   Tue, 18 Aug 2020 22:07:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/11] fs: don't allow splice read/write without
 explicit ops
Message-ID: <20200818200725.GA1081@lst.de>
References: <20200817073212.830069-1-hch@lst.de> <20200817073212.830069-4-hch@lst.de> <202008181239.E51B80265@keescook> <20200818195446.GA32691@lst.de> <202008181256.CABD56782@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008181256.CABD56782@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:58:07PM -0700, Kees Cook wrote:
> On Tue, Aug 18, 2020 at 09:54:46PM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 18, 2020 at 12:39:34PM -0700, Kees Cook wrote:
> > > On Mon, Aug 17, 2020 at 09:32:04AM +0200, Christoph Hellwig wrote:
> > > > default_file_splice_write is the last piece of generic code that uses
> > > > set_fs to make the uaccess routines operate on kernel pointers.  It
> > > > implements a "fallback loop" for splicing from files that do not actually
> > > > provide a proper splice_read method.  The usual file systems and other
> > > > high bandwith instances all provide a ->splice_read, so this just removes
> > > > support for various device drivers and procfs/debugfs files.  If splice
> > > > support for any of those turns out to be important it can be added back
> > > > by switching them to the iter ops and using generic_file_splice_read.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > This seems a bit disruptive? I feel like this is going to make fuzzers
> > > really noisy (e.g. trinity likes to splice random stuff out of /sys and
> > > /proc).
> > 
> > Noisy in the sence of triggering the pr_debug or because they can't
> > handle -EINVAL?
> 
> Well, maybe both? I doubt much _expects_ to be using splice, so I'm fine
> with that, but it seems weird not to have a fall-back, especially if
> something would like to splice a file out of there. But, I'm not opposed
> to the change, it just seems like it might cause pain down the road.

The problem is that without pretending a buffer is in user space when
it actually isn't, we can't have a generic fallback.  So we'll have to
have specific support - I wrote generic support for seq_file, and
willy did for /proc/sys, but at least the first caused a few problems
and a fair amount of churn, so I'd rather see first if we can get
away without it.

> 
> -- 
> Kees Cook
---end quoted text---
