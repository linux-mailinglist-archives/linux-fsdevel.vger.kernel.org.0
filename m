Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737AF42168
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437701AbfFLJwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 05:52:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437415AbfFLJwJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:52:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECAA6AF52;
        Wed, 12 Jun 2019 09:52:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 89C291E4328; Wed, 12 Jun 2019 11:46:34 +0200 (CEST)
Date:   Wed, 12 Jun 2019 11:46:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 02/10] fs/locks: Export F_LAYOUT lease to user space
Message-ID: <20190612094634.GA14578@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606014544.8339-3-ira.weiny@intel.com>
 <4e5eb31a41b91a28fbc83c65195a2c75a59cfa24.camel@kernel.org>
 <20190611213812.GC14336@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611213812.GC14336@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-06-19 14:38:13, Ira Weiny wrote:
> On Sun, Jun 09, 2019 at 09:00:24AM -0400, Jeff Layton wrote:
> > On Wed, 2019-06-05 at 18:45 -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > GUP longterm pins of non-pagecache file system pages (eg FS DAX) are
> > > currently disallowed because they are unsafe.
> > > 
> > > The danger for pinning these pages comes from the fact that hole punch
> > > and/or truncate of those files results in the pages being mapped and
> > > pinned by a user space process while DAX has potentially allocated those
> > > pages to other processes.
> > > 
> > > Most (All) users who are mapping FS DAX pages for long term pin purposes
> > > (such as RDMA) are not going to want to deallocate these pages while
> > > those pages are in use.  To do so would mean the application would lose
> > > data.  So the use case for allowing truncate operations of such pages
> > > is limited.
> > > 
> > > However, the kernel must protect itself and users from potential
> > > mistakes and/or malicious user space code.  Rather than disabling long
> > > term pins as is done now.   Allow for users who know they are going to
> > > be pinning this memory to alert the file system of this intention.
> > > Furthermore, allow users to be alerted such that they can react if a
> > > truncate operation occurs for some reason.
> > > 
> > > Example user space pseudocode for a user using RDMA and wanting to allow
> > > a truncate would look like this:
> > > 
> > > lease_break_sigio_handler() {
> > > ...
> > > 	if (sigio.fd == rdma_fd) {
> > > 		complete_rdma_operations(...);
> > > 		ibv_dereg_mr(mr);
> > > 		close(rdma_fd);
> > > 		fcntl(rdma_fd, F_SETLEASE, F_UNLCK);
> > > 	}
> > > }
> > > 
> > > setup_rdma_to_dax_file() {
> > > ...
> > > 	rdma_fd = open(...)
> > > 	fcntl(rdma_fd, F_SETLEASE, F_LAYOUT);
> > 
> > I'm not crazy about this interface. F_LAYOUT doesn't seem to be in the
> > same category as F_RDLCK/F_WRLCK/F_UNLCK.
> > 
> > Maybe instead of F_SETLEASE, this should use new
> > F_SETLAYOUT/F_GETLAYOUT cmd values? There is nothing that would prevent
> > you from setting both a lease and a layout on a file, and indeed knfsd
> > can set both.
> > 
> > This interface seems to conflate the two.
> 
> I've been feeling the same way.  This is why I was leaning toward a new lease
> type.  I called it "F_LONGTERM" but the name is not important.
> 
> I think the concept of adding "exclusive" to the layout lease can fix this
> because the NFS lease is non-exclusive where the user space one (for the
> purpose of GUP pinning) would need to be.
> 
> FWIW I have not worked out exactly what this new "exclusive" code will look
> like.  Jan said:
> 
> 	"There actually is support for locks that are not broken after given
> 	timeout so there shouldn't be too many changes need."
> 
> But I'm not seeing that for Lease code.  So I'm working on something for the
> lease code now.

Yeah, sorry for misleading you. Somehow I thought that if lease_break_time
== 0, we will wait indefinitely but when checking the code again, that
doesn't seem to be the case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
