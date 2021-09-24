Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9941697F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbhIXBgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240863AbhIXBgt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A7F061211;
        Fri, 24 Sep 2021 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632447317;
        bh=yzSlcJlodQPFhlSMh5PwiSmOV+Bw1IPnLYmM3uz+kms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmin/oBNLAuiT83PwkxTaD8dzsimeP/ZBO1u2se8UtcmNPl0oDW4Gio/bn9gkBA9p
         yvHf4gBx3TLCrpYjGiMY+7Ow0IYUZqgvo4+Z1fQtAcXJy1O+HPNvfTwzheSdQP1jQX
         cETTjSkEDk5BQ6pQ8DU0dWgshrA7EYPXceqLufzyUDkrl03FUxe9o3knNClVpYtGY/
         PDWdaqsajxIK/s3gFQ3o2k+W1VgLDUPoqHvh5vhRc/4HczsFpg2v651SNeytZbdmzX
         MaZUq3Pfa/93qTPZt2cToEeiDffv/XucIxxK8qyqxxNVt7Jt8b/MsaUQqj/qghOuEQ
         2kswN5xneMD+A==
Date:   Thu, 23 Sep 2021 18:35:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210924013516.GB570577@magnolia>
References: <20210922041354.GE570615@magnolia>
 <20210922054931.GT1756565@dread.disaster.area>
 <20210922212725.GN570615@magnolia>
 <20210923000255.GO570615@magnolia>
 <20210923014209.GW1756565@dread.disaster.area>
 <CAPcyv4j77cWASW1Qp=J8poVRi8+kDQbBsLZb0HY+dzeNa=ozNg@mail.gmail.com>
 <CAPcyv4in7WRw1_e5iiQOnoZ9QjQWhjj+J7HoDf3ObweUvADasg@mail.gmail.com>
 <20210923225433.GX1756565@dread.disaster.area>
 <CAPcyv4jsU1ZBY0MNKf9CCCFaR4qcwUCRmZHstPpF02pefKnDtg@mail.gmail.com>
 <09ed3c3c-391b-bf91-2456-d7f7ca5ab2fb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ed3c3c-391b-bf91-2456-d7f7ca5ab2fb@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:21:19PM -0700, Jane Chu wrote:
> 
> On 9/23/2021 6:18 PM, Dan Williams wrote:
> > On Thu, Sep 23, 2021 at 3:54 PM Dave Chinner <david@fromorbit.com> wrote:
> > > 
> > > On Wed, Sep 22, 2021 at 10:42:11PM -0700, Dan Williams wrote:
> > > > On Wed, Sep 22, 2021 at 7:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > 
> > > > > On Wed, Sep 22, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > [..]
> > > > > > Hence this discussion leads me to conclude that fallocate() simply
> > > > > > isn't the right interface to clear storage hardware poison state and
> > > > > > it's much simpler for everyone - kernel and userspace - to provide a
> > > > > > pwritev2(RWF_CLEAR_HWERROR) flag to directly instruct the IO path to
> > > > > > clear hardware error state before issuing this user write to the
> > > > > > hardware.
> > > > > 
> > > > > That flag would slot in nicely in dax_iomap_iter() as the gate for
> > > > > whether dax_direct_access() should allow mapping over error ranges,
> > > > > and then as a flag to dax_copy_from_iter() to indicate that it should
> > > > > compare the incoming write to known poison and clear it before
> > > > > proceeding.
> > > > > 
> > > > > I like the distinction, because there's a chance the application did
> > > > > not know that the page had experienced data loss and might want the
> > > > > error behavior. The other service the driver could offer with this
> > > > > flag is to do a precise check of the incoming write to make sure it
> > > > > overlaps known poison and then repair the entire page. Repairing whole
> > > > > pages makes for a cleaner implementation of the code that tries to
> > > > > keep poison out of the CPU speculation path, {set,clear}_mce_nospec().
> > > > 
> > > > This flag could also be useful for preadv2() as there is currently no
> > > > way to read the good data in a PMEM page with poison via DAX. So the
> > > > flag would tell dax_direct_access() to again proceed in the face of
> > > > errors, but then the driver's dax_copy_to_iter() operation could
> > > > either read up to the precise byte offset of the error in the page, or
> > > > autoreplace error data with zero's to try to maximize data recovery.
> > > 
> > > Yes, it could. I like the idea - say RWF_IGNORE_HWERROR - to read
> > > everything that can be read from the bad range because it's the
> > > other half of the problem RWF_RESET_HWERROR is trying to address.
> > > That is, the operation we want to perform on a range with an error
> > > state is -data recovery-, not "reinitialisation". Data recovery
> > > requires two steps:
> > > 
> > > - "try to recover the data from the bad storage"; and
> > > - "reinitialise the data and clear the error state"
> > > 
> > > These naturally map to read() and write() operations, not
> > > fallocate(). With RWF flags they become explicit data recovery
> > > operations, unlike fallocate() which needs to imply that "writing
> > > zeroes" == "reset hardware error state". While that reset method
> > > may be true for a specific pmem hardware implementation it is not a
> > > requirement for all storage hardware. It's most definitely not a
> > > requirement for future storage hardware, either.
> > > 
> > > It also means that applications have no choice in what data they can
> > > use to reinitialise the damaged range with because fallocate() only
> > > supports writing zeroes. If we've recovered data via a read() as you
> > > suggest we could, then we can rebuild the data from other redundant
> > > information and immediately write that back to the storage, hence
> > > repairing the fault.
> > > 
> > > That, in turn, allows the filesystem to turn the RWF_RESET_HWERROR
> > > write into an exclusive operation and hence allow the
> > > reinitialisation with the recovered/repaired state to run atomically
> > > w.r.t. all other filesystem operations.  i.e. the reset write
> > > completes the recovery operation instead of requiring separate
> > > "reset" and "write recovered data into zeroed range" steps that
> > > cannot be executed atomically by userspace...
> > 
> > /me nods
> > 
> > Jane, want to take a run at patches for this ^^^?
> > 
> 
> Sure, I'll give it a try.
> 
> Thank you all for the discussions!

Cool, thank you!

--D

> 
> -jane
> 
> 
