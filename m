Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2F2B30BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 21:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKNUuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 15:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgKNUuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:50:12 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48DC0613D1;
        Sat, 14 Nov 2020 12:50:12 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke2Ui-0061hp-LP; Sat, 14 Nov 2020 20:50:01 +0000
Date:   Sat, 14 Nov 2020 20:50:00 +0000
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
Message-ID: <20201114205000.GP3576660@ZenIV.linux.org.uk>
References: <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114070025.GO3576660@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 07:00:25AM +0000, Al Viro wrote:
> On Fri, Nov 13, 2020 at 11:19:34PM -0700, Nathan Chancellor wrote:
> 
> > Assuming so, I have attached the output both with and without the
> > WARN_ON. Looks like mountinfo is what is causing the error?
> 
> Cute...  FWIW, on #origin + that commit with fix folded in I don't
> see anything unusual in reads from mountinfo ;-/  OTOH, they'd
> obviously been... creative with readv(2) arguments, so it would
> be very interesting to see what it is they are passing to it.
> 
> I'm half-asleep right now; will try to cook something to gather
> that information tomorrow morning.  'Later...

OK, so let's do this: fix in seq_read_iter() + in do_loop_readv_writev()
(on entry) the following (racy as hell, but will do for debugging):

	bool weird = false;

	if (unlikely(memcmp(file->f_path.dentry->d_name.name, "mountinfo", 10))) {
		int i;

		for (i = 0; i < iter->nr_segs; i++)
			if (!iter->iov[i].iov_len)
				weird = true;
		if (weird) {
			printk(KERN_ERR "[%s]: weird readv on %p4D (%ld) ",
				current->comm, filp, (long)filp->f_pos);
			for (i = 0; i < iter->nr_segs; i++)
				printk(KERN_CONT "%c%zd", i ? ':' : '<',
					iter->iov[i].iov_len);
			printk(KERN_CONT "> ");
		}
	}
and in the end (just before return)
	if (weird)
		printk(KERN_CONT "-> %zd\n", ret);

Preferably along with the results of cat /proc/<whatever it is>/mountinfo both
on that and on the working kernel...
