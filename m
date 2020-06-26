Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7443C20B29D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgFZNhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:37:16 -0400
Received: from verein.lst.de ([213.95.11.211]:51815 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgFZNhQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:37:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A65068B02; Fri, 26 Jun 2020 15:37:14 +0200 (CEST)
Date:   Fri, 26 Jun 2020 15:37:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20200626133714.GB12646@lst.de>
References: <20200626075836.1998185-1-hch@lst.de> <20200626075836.1998185-9-hch@lst.de> <20200626122752.GN4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626122752.GN4332@42.do-not-panic.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:27:52PM +0000, Luis Chamberlain wrote:
> On Fri, Jun 26, 2020 at 09:58:35AM +0200, Christoph Hellwig wrote:
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index e765c95ff3440d..ae463bcadb6906 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -420,6 +420,18 @@ ssize_t iter_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos,
> >  	return ret;
> >  }
> >  
> > +static void warn_unsupported(struct file *file, const char *op)
> > +{
> > +	char pathname[128], *path;
> 
> Why 128? How about kstrdup_quotable_file()?

This is in the read/write path for the case where we did not end up
calling in the driver.  This is far less stack usage than any read/write
method would have used eventually.
