Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF620B29A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFZNgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 09:36:37 -0400
Received: from verein.lst.de ([213.95.11.211]:51809 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgFZNgh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:36:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0111168B02; Fri, 26 Jun 2020 15:36:33 +0200 (CEST)
Date:   Fri, 26 Jun 2020 15:36:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] proc: add a read_iter method to proc proc_ops
Message-ID: <20200626133633.GA12646@lst.de>
References: <20200626075836.1998185-1-hch@lst.de> <20200626075836.1998185-3-hch@lst.de> <20200626120624.GL4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626120624.GL4332@42.do-not-panic.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:06:24PM +0000, Luis Chamberlain wrote:
> On Fri, Jun 26, 2020 at 09:58:29AM +0200, Christoph Hellwig wrote:
> > diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> > index 28d6105e908e4c..fa86619cebc2be 100644
> > --- a/fs/proc/inode.c
> > +++ b/fs/proc/inode.c
> > @@ -297,6 +297,29 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
> >  	return rv;
> >  }
> >  
> > +static ssize_t pde_read_iter(struct proc_dir_entry *pde, struct kiocb *iocb,
> > +		struct iov_iter *iter)
> > +{
> > +	if (!pde->proc_ops->proc_read_iter)
> > +		return -EINVAL;
> 
> When is this true?

Whenever a user sets up the method..
