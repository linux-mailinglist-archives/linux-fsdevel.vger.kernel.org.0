Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3314F3781B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfFFPf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 11:35:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34630 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfFFPfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:35:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id u64so1908685oib.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uRCmoXjULyV6kNTp2XKoB1qQmxkPSNDXYL9A3FHXFA=;
        b=QHJOC2ZZhCoDsF3kkt0jD8pflX+D1g9wOGO30jisMp6VkS20cZbHhajfwYZJVXdiNh
         JvAq7go3CRc5C+qomPxstLKznxkYPvd1O8ef7VHSAdG1rMnaPbbiOm9MuPNkCt7QxXaR
         tW2MckCN4CHKIL8N13EVae4FrQAMJth8VAaKv/3gRwubZltnT7kNI3PWIXvq1c0vgZdi
         L4XQGyBb2kkKpfIMhfb2YWP8o3M95HB+am83dkZODoLq1I1UWGrX6Sp8tjJSrVa2UG3+
         kN4AXQu3lycB826+fr4/pUl5FixrZTURACJPQlnP2NuCi+p38m+p145UkX/P89XlKLdK
         QHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uRCmoXjULyV6kNTp2XKoB1qQmxkPSNDXYL9A3FHXFA=;
        b=ZiqE4U0Sf43vdrBUd0YXq0+Zl0LWb1zul5BGv+ivi+xDhnd6wz2fSE5YpZzl/E8aiL
         wZBRONwaI7Og66UfDOs8R5VIIFqqlx5uHk6+UXnfWPmnoVrBEaqOQONcncUnuWqCk8kA
         I9uZxb941TFcyLZkU8HABd3te6yRbxM+nsB7JQyLWwuJA8DfK9dnpjrCC2QZfBJtvpe0
         arP9TXppeNVhodmf+Ih8ui2hxY8u0QX8q6Q+gdn95ZTwKokSAUV3J3EbiwsAbdxKZsCB
         R/8cgpHt4tTGklWmNCdAi5wZrX3DKVDPyMirDx+FHKUoU1Ibgd+nM629MjWcbO/PLVCt
         hs5w==
X-Gm-Message-State: APjAAAV6Qie6AJV+sZ4G7PXkpTplgnbzcIgHkwGQpIehDwlICDNil9sy
        x4rZeUDKxduF9Pbbbu1T4irh2Z7Tc7eOLkbLvxYtxw==
X-Google-Smtp-Source: APXvYqwQgzrGrWeJ2qr6zRt1Kh72wsL96qCKSVk7C2TBZflDvhLK6wlI/C4trmZ0QEDDo8Q9KA4CrwRdXYqf7oGmgHc=
X-Received: by 2002:aca:bbc5:: with SMTP id l188mr410988oif.73.1559835355090;
 Thu, 06 Jun 2019 08:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190606014544.8339-1-ira.weiny@intel.com> <20190606104203.GF7433@quack2.suse.cz>
In-Reply-To: <20190606104203.GF7433@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Jun 2019 08:35:42 -0700
Message-ID: <CAPcyv4h-k_5T39fDY+SVrLXG_XETmgz-6N3NjQUteYG7g9NdDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
To:     Jan Kara <jack@suse.cz>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 6, 2019 at 3:42 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > ... V1,000,000   ;-)
> >
> > Pre-requisites:
> >       John Hubbard's put_user_pages() patch series.[1]
> >       Jan Kara's ext4_break_layouts() fixes[2]
> >
> > Based on the feedback from LSFmm and the LWN article which resulted.  I've
> > decided to take a slightly different tack on this problem.
> >
> > The real issue is that there is no use case for a user to have RDMA pinn'ed
> > memory which is then truncated.  So really any solution we present which:
> >
> > A) Prevents file system corruption or data leaks
> > ...and...
> > B) Informs the user that they did something wrong
> >
> > Should be an acceptable solution.
> >
> > Because this is slightly new behavior.  And because this is gonig to be
> > specific to DAX (because of the lack of a page cache) we have made the user
> > "opt in" to this behavior.
> >
> > The following patches implement the following solution.
> >
> > 1) The user has to opt in to allowing GUP pins on a file with a layout lease
> >    (now made visible).
> > 2) GUP will fail (EPERM) if a layout lease is not taken
> > 3) Any truncate or hole punch operation on a GUP'ed DAX page will fail.
> > 4) The user has the option of holding the layout lease to receive a SIGIO for
> >    notification to the original thread that another thread has tried to delete
> >    their data.  Furthermore this indicates that if the user needs to GUP the
> >    file again they will need to retake the Layout lease before doing so.
> >
> >
> > NOTE: If the user releases the layout lease or if it has been broken by
> > another operation further GUP operations on the file will fail without
> > re-taking the lease.  This means that if a user would like to register
> > pieces of a file and continue to register other pieces later they would
> > be advised to keep the layout lease, get a SIGIO notification, and retake
> > the lease.
> >
> > NOTE2: Truncation of pages which are not actively pinned will succeed.
> > Similar to accessing an mmap to this area GUP pins of that memory may
> > fail.
>
> So after some through I'm willing accept the fact that pinned DAX pages
> will just make truncate / hole punch fail and shove it into a same bucket
> of situations like "user can open a file and unlink won't delete it" or
> "ETXTBUSY when user is executing a file being truncated".  The problem I
> have with this proposal is a lack of visibility from sysadmin POV. For
> ETXTBUSY or "unlinked but open file" sysadmin can just do lsof, find the
> problematic process and kill it. There's nothing like that with your
> proposal since currently once you hold page reference, you can unmap the
> file, drop layout lease, close the file, and there's no trace that you're
> responsible for the pinned page anymore.
>
> So I'd like to actually mandate that you *must* hold the file lease until
> you unpin all pages in the given range (not just that you have an option to
> hold a lease). And I believe the kernel should actually enforce this. That
> way we maintain a sane state that if someone uses a physical location of
> logical file offset on disk, he has a layout lease. Also once this is done,
> sysadmin has a reasonably easy way to discover run-away RDMA application
> and kill it if he wishes so.

Yes, this satisfies the primary concern that made me oppose failing
truncate. If the administrator determines that reclaiming capacity is
more important than maintaining active RDMA mappings "lsof + kill" is
a reasonable way to recover. I'd go so far as to say that anything
less is an abdication of the kernel's responsibility as an arbiter of
platform resources.

> The question is on how to exactly enforce that lease is taken until all
> pages are unpinned. I belive it could be done by tracking number of
> long-term pinned pages within a lease. Gup_longterm could easily increment
> the count when verifying the lease exists, gup_longterm users will somehow
> need to propagate corresponding 'filp' (struct file pointer) to
> put_user_pages_longterm() callsites so that they can look up appropriate
> lease to drop reference - probably I'd just transition all gup_longterm()
> users to a saner API similar to the one we have in mm/frame_vector.c where
> we don't hand out page pointers but an encapsulating structure that does
> all the necessary tracking. Removing a lease would need to block until all
> pins are released - this is probably the most hairy part since we need to
> handle a case if application just closes the file descriptor which would
> release the lease but OTOH we need to make sure task exit does not deadlock.
> Maybe we could block only on explicit lease unlock and just drop the layout
> lease on file close and if there are still pinned pages, send SIGKILL to an
> application as a reminder it did something stupid...
>
> What do people think about this?

SIGKILL on close() without explicit unlock and wait-on-last-pin with
explicit unlock sounds reasonable to me.
