Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83522E422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgG0CzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 22:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgG0CzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 22:55:09 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A78C0619D2;
        Sun, 26 Jul 2020 19:55:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jztIB-003NQO-S9; Mon, 27 Jul 2020 02:55:07 +0000
Date:   Mon, 27 Jul 2020 03:55:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/23] initramfs: switch initramfs unpacking to struct
 file based APIs
Message-ID: <20200727025507.GC795125@ZenIV.linux.org.uk>
References: <20200714190427.4332-1-hch@lst.de>
 <20200714190427.4332-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190427.4332-18-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:04:21PM +0200, Christoph Hellwig wrote:

> -		ssize_t rv = ksys_write(fd, p, count);
> +		ssize_t rv = kernel_write(file, p, count, &file->f_pos);

No.  Sure, that'll work for ramfs with nobody else playing with those.
However, this is the wrong way to do such things; do *NOT* pass the
address of file->f_pos to anything.  The few places that still do that
are wrong.

As a general rule, ->read() and ->write() instances should never be
given &file->f_pos.  Address of a local variable - sure, no problem.
Copy it back into ->f_pos when they are done?  Also fine.  But not
this,

Keep that offset in a variable (static in file, argument of xwrite(),
whatever).
