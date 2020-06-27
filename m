Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD63A20BF3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgF0HKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 03:10:37 -0400
Received: from verein.lst.de ([213.95.11.211]:53843 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgF0HKh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:10:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2364368B02; Sat, 27 Jun 2020 09:10:33 +0200 (CEST)
Date:   Sat, 27 Jun 2020 09:10:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20200627071033.GC11854@lst.de>
References: <20200626075836.1998185-1-hch@lst.de> <20200626075836.1998185-9-hch@lst.de> <20200626135147.GB25039@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135147.GB25039@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:51:47PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 26, 2020 at 09:58:35AM +0200, Christoph Hellwig wrote:
> > +static void warn_unsupported(struct file *file, const char *op)
> > +{
> > +	char pathname[128], *path;
> > +
> > +	path = file_path(file, pathname, sizeof(pathname));
> > +	if (IS_ERR(path))
> > +		path = "(unknown)";
> > +	pr_warn_ratelimited(
> > +		"kernel %s not supported for file %s (pid: %d comm: %.20s)\n",
> > +		op, path, current->pid, current->comm);
> > +}
> > +
> 
> how about just:
> 
> 	pr_warn_ratelimited(
> 		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
> 			op, file, current->pid, current->comm);

Sure, we could use %pD for a few less line of code and a little less
typesafety.  I'm not a huge fan of these custom, unchecked format
specifiers, but given that they exist we might a well use them.
