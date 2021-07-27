Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9C3D7569
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhG0M46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232039AbhG0M46 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:56:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2CB6608FB;
        Tue, 27 Jul 2021 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627390617;
        bh=tEJsYPPcR7cQdHztouI8BN/CYyZy8H9dTPZbM0CbK5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwYskLKOUJOnB/sL0WtJ4BQ7iz8UBAEfyUg5i3Y4iZ/GI8h9jK0kMmYNkBGQ6CI0G
         y1LSFPKY6NqvI9i08NplBPZADPCR7r+kW0jxICs0KZFt2sAvVURCcHRlrebwnV74l6
         XT9ra5IYUZ1rKorDMcCuzjjCosHmnE7tOP7K0NHg=
Date:   Tue, 27 Jul 2021 14:56:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAClXqyLhztLcm4@kroah.com>
References: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
 <YP/+g/L6+tLWjx/l@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP/+g/L6+tLWjx/l@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 03:39:31PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 27, 2021 at 02:07:54PM +0200, Greg Kroah-Hartman wrote:
> > When running static analysis tools to find where signed values could
> > potentially wrap the family of d_path() functions turn out to trigger a
> > lot of mess.  In evaluating the code, all of these usages seem safe, but
> > pointer math is involved so if a negative number is ever somehow passed
> > into these functions, memory can be traversed backwards in ways not
> > intended.
> > 
> > Resolve all of the abuguity by just making "size" an unsigned value,
> > which takes the guesswork out of everything involved.
> 
> Are you sure it's correct change?
> 
> Look into extract_string() implementation.
> 
> 	if (likely(p->len >= 0))
> 		return p->buf;
> 	return ERR_PTR(-ENAMETOOLONG);
> 
> Your change makes it equal to
> 
> 	return p->buf;
> 
> if I'm not mistaken.

Yes it does, you are right.  So now we don't need to check the wrap
there :)

So this code is explicitly wanting the value to wrap into a negative
value to check for problems, didn't expect that.

Still feels very fragile, if you look at the documentation for __d_path,
it says:
	"buflen" should be positive.
and if you look at who calls it, they are all passing in an unsigned
value, seq_path_root() uses a size_t as buflen.  What's the issues
involved there when size_t is a unsigned value going into a signed int?

And my mistake from earlier, size_t is the same as unsigned int, not
unsigned long.

Anyway, this code feels subtle and tricky here, such that parsing tools
warn "hey, something might be wrong here, check it out!"

I'm not set on changing prepend_buffer->len, but I will not complain if
it is, but we might want to have a different check in extract_string()
and prepend() to verify that p->len does not go bigger than
MAX_SOMETHING?

But in the end, you are right, this version of the patch is not ok, all
of the checks for len being < 0 are now moot, gotta love the fact that
gcc didn't say squat about that :(

thanks,

greg k-h
