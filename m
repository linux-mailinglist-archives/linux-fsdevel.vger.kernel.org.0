Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7141E7231
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 03:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbgE2Br5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 21:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgE2Brz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 21:47:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75466C08C5C6;
        Thu, 28 May 2020 18:47:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeU7l-00HHZ1-Ef; Fri, 29 May 2020 01:47:53 +0000
Date:   Fri, 29 May 2020 02:47:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
Message-ID: <20200529014753.GZ23230@ZenIV.linux.org.uk>
References: <20200529000345.GV23230@ZenIV.linux.org.uk>
 <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
 <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 06:27:36PM -0700, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 5:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         if (*ppos >= i_size_read(inode))
> >                 return 0;
> >
> > +       /* don't read past the lvb */
> > +       if (count > i_size_read(inode) - *ppos)
> > +               count = i_size_read(inode) - *ppos;
> 
> This isn't a new problem, since you effectively just moved this code,
> but it's perhaps more obvious now..
> 
> "i_size_read()" is not necessarily stable - we do special things on
> 32-bit to make sure that we get _a_ stable value for it, but it's not
> necessarily guaranteed to be the same value when called twice. Think
> concurrent pread() with a write..
> 
> So the inode size could change in between those two accesses, and the
> subtraction might end up underflowing despite the check just above.
> 
> This might not be an issue with ocfs2 (I didn't check locking), but ..

        case S_IFREG:
                inode->i_op = &dlmfs_file_inode_operations;
                inode->i_fop = &dlmfs_file_operations;

                i_size_write(inode,  DLM_LVB_LEN);
is the only thing that does anything to size of that sucker.  IOW, that
i_size_read() might as well had been an explicit 64.  Actually,
looking at that thing I would suggest simply

static ssize_t dlmfs_file_read(struct file *filp,
                               char __user *buf,
                               size_t count,
                               loff_t *ppos)
{
        struct inode *inode = file_inode(filp);
	char lvb_buf[DLM_LVB_LEN];

	if (!user_dlm_read_lvb(inode, lvb_buf, DLM_LVB_LEN))
		return 0;
	return simple_read_from_buffer(buf, count, ppos,
				       lvb_buf, DLM_LVB_LEN);
}

But that's belongs in a followup, IMO.
