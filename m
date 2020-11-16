Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D534D2B3BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 04:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKPD3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 22:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgKPD3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:29:49 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B79C0613CF;
        Sun, 15 Nov 2020 19:29:48 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keVD4-006zpa-RU; Mon, 16 Nov 2020 03:29:43 +0000
Date:   Mon, 16 Nov 2020 03:29:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201116032942.GV3576660@ZenIV.linux.org.uk>
References: <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk>
 <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk>
 <20201116003416.GA345@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116003416.GA345@Ryzen-9-3900X.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 05:34:16PM -0700, Nathan Chancellor wrote:
 
> Still good.
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Pushed into #fixes

> > BTW, is that call of readv() really coming from init?  And if it
> > is, what version of init are you using?
> 
> I believe that it is but since this is WSL2, I believe that /init is a
> proprietary Microsoft implementation, rather than systemd or another
> init system:
> 
> https://wiki.ubuntu.com/WSL#Keeping_Ubuntu_Updated_in_WSL
> 
> So I am not sure how possible it is to see exactly what is going on or
> getting it improved.

Oh, well...  Anyway, as a regression test it's interesting:

#include <sys/uio.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
main()
{
	static char s[1024];
	static struct iovec v[2] = {{NULL, 0}, {s, 1024}};

	for(;;) {
		ssize_t n = readv(0, v, 2), m, w;

		if (n < 0) {
			perror("readv");
			return -1;
		}
		if (!n)
			return 0;
		for (m = 0; m < n; m += w) {
			w = write(1, s + m, n - m);
			if (w < 0)
				perror("write");
		}
	}
}

which ought to copy stdin to stdout; with this bug it would (on sufficiently
large seq_file-based files) fail with "readv: Bad address" (-EFAULT, that is).
