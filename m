Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB133D798B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhG0PRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:17:37 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:57594 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhG0PRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:17:36 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8OpR-004OC3-9R; Tue, 27 Jul 2021 15:17:09 +0000
Date:   Tue, 27 Jul 2021 15:17:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jordy Zomer <jordy@pwning.systems>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAjdSPCwrnoc+YO@zeniv-ca.linux.org.uk>
References: <20210727103625.74961-1-gregkh@linuxfoundation.org>
 <YQAdK0z5jFdw6cLz@zeniv-ca.linux.org.uk>
 <YQAhQ2dYWCmnFMwM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAhQ2dYWCmnFMwM@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:07:47PM +0100, Matthew Wilcox wrote:

> umm ... what if someone passes in -ENOMEM as buflen?  Not saying we
> have such a path right now, but I could imagine it happening.
> 
> 	if (unlikely(buflen < 0))
> 		return ERR_PTR(buflen);
> 	if (unlikely(buflen > 0x8000)) {
> 		buf += buflen - 0x8000;
> 		buflen = 0x8000;
> 	}

Not really.  You don't want ERR_PTR() of random negative numbers to start
flying around...
