Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F83D7494
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 13:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhG0LvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 07:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236406AbhG0LvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46A4061051;
        Tue, 27 Jul 2021 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627386674;
        bh=PwgZ/sniqipDPy80HTZsnP6zkGQY9a5mjUjeMFrp+aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsM19gkoinqjY+scEUoQTkWqF9eaJ+aiGvHj9qMwliN+y4A7OzgwRq53uooT1XH5W
         vpIuvyvhqqRkLsRUqeYZ/2U+QTy7/Bo68gLgQYpVeyw1eb6sfLyNiqlUjtY29+2y2a
         FF7/eqdR7Ymum9WLmyKPUVOa7ntMF9aclJQykLak=
Date:   Tue, 27 Jul 2021 13:51:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YP/zK8WKGVyLXMqu@kroah.com>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
 <YP/r29mss1BqctYT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP/r29mss1BqctYT@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:19:55PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 27, 2021 at 12:36:25PM +0200, Greg Kroah-Hartman wrote:
> > When running static analysis tools to find where signed values could
> > potentially wrap the family of d_path() functions turn out to trigger a
> > lot of mess.  In evaluating the code, all of these usages seem safe, but
> > pointer math is involved so if a negative number is ever somehow passed
> > into these functions, memory can be traversed backwards in ways not
> > intended.
> 
> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index 23a53f7b5c71..7876b741a47e 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -182,7 +182,7 @@ static int prepend_path(const struct path *path,
> >   */
> >  char *__d_path(const struct path *path,
> >  	       const struct path *root,
> > -	       char *buf, int buflen)
> > +	       char *buf, unsigned int buflen)
> >  {
> >  	DECLARE_BUFFER(b, buf, buflen);
> 
> I have questions about the quality of the analysis tool you're using.
> 
> struct prepend_buffer {
>         char *buf;
>         int len;
> };
> #define DECLARE_BUFFER(__name, __buf, __len) \
>         struct prepend_buffer __name = {.buf = __buf + __len, .len = __len}
> 
> Why is it not flagging the assignment of an unsigned int buflen to
> a signed int len?

Ah, I could not run the tool after I made this change.  I can change len
in prepend_buffer as well.

> > +char *__d_path(const struct path *, const struct path *, char *, unsigned int);
> > +char *d_absolute_path(const struct path *, char *, unsigned int);
> > +char *d_path(const struct path *, char *, unsigned int);
> > +char *dentry_path_raw(const struct dentry *, char *, unsigned int);
> > +char *dentry_path(const struct dentry *, char *, unsigned int);
> 
> While you're touching these declarations, please name the 'unsigned int'
> parameter.  I don't care about the others; they are obvious, but an
> unsigned int might be flags, a length, or a small grey walrus.

Sure, will respin this with both of those changes.  Thanks for the
review.

greg k-h
