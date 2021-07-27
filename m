Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA23D7914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhG0OwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 10:52:08 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:57226 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbhG0OuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:50:21 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8OPT-004NnD-Le; Tue, 27 Jul 2021 14:50:19 +0000
Date:   Tue, 27 Jul 2021 14:50:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAdK0z5jFdw6cLz@zeniv-ca.linux.org.uk>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727103625.74961-1-gregkh@linuxfoundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:36:25PM +0200, Greg Kroah-Hartman wrote:
> When running static analysis tools to find where signed values could
> potentially wrap the family of d_path() functions turn out to trigger a
> lot of mess.  In evaluating the code, all of these usages seem safe, but
> pointer math is involved so if a negative number is ever somehow passed
> into these functions, memory can be traversed backwards in ways not
> intended.
> 
> Resolve all of the abuguity by just making "size" an unsigned value,
> which takes the guesswork out of everything involved.

TBH, I'm not sure it's the right approach.  Huge argument passed to d_path()
is a bad idea, no matter what.  Do you really want to have the damn thing
try and fill 3Gb of buffer, all while holding rcu_read_lock() and a global
spinlock or two?  Hell, s/3Gb/1Gb/ and it won't get any better...


How about we do this instead:

d_path(const struct path *path, char *buf, int buflen)
{
	if (unlikely((unsigned)buflen > 0x8000)) {
		buf += (unsigned)buflen - 0x8000;
		buflen = 0x8000;
	}
	as in mainline
}

and take care of both issues?
