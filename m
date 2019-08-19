Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E63291D37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHSGhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 02:37:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfHSGhC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:37:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01D2AAC26;
        Mon, 19 Aug 2019 06:36:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB8171E155E; Mon, 19 Aug 2019 08:36:58 +0200 (CEST)
Date:   Mon, 19 Aug 2019 08:36:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-nvdimm@lists.01.org,
        linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;
 -)
Message-ID: <20190819063658.GB20455@quack2.suse.cz>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190816232006.GA11384@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816232006.GA11384@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-08-19 16:20:07, Ira Weiny wrote:
> On Fri, Aug 16, 2019 at 12:05:28PM -0700, 'Ira Weiny' wrote:
> > On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> > > > > Hello!
> > > > > 
> > > > > On Fri 09-08-19 15:58:14, ira.weiny@intel.com wrote:
> > > > > > Pre-requisites
> > > > > > ==============
> > > > > > 	Based on mmotm tree.
> > > > > > 
> > > > > > Based on the feedback from LSFmm, the LWN article, the RFC series since
> > > > > > then, and a ton of scenarios I've worked in my mind and/or tested...[1]
> > > > > > 
> > > > > > Solution summary
> > > > > > ================
> > > > > > 
> > > > > > The real issue is that there is no use case for a user to have RDMA pinn'ed
> > > > > > memory which is then truncated.  So really any solution we present which:
> > > > > > 
> > > > > > A) Prevents file system corruption or data leaks
> > > > > > ...and...
> > > > > > B) Informs the user that they did something wrong
> > > > > > 
> > > > > > Should be an acceptable solution.
> > > > > > 
> > > > > > Because this is slightly new behavior.  And because this is going to be
> > > > > > specific to DAX (because of the lack of a page cache) we have made the user
> > > > > > "opt in" to this behavior.
> > > > > > 
> > > > > > The following patches implement the following solution.
> > > > > > 
> > > > > > 0) Registrations to Device DAX char devs are not affected
> > > > > > 
> > > > > > 1) The user has to opt in to allowing page pins on a file with an exclusive
> > > > > >    layout lease.  Both exclusive and layout lease flags are user visible now.
> > > > > > 
> > > > > > 2) page pins will fail if the lease is not active when the file back page is
> > > > > >    encountered.
> > > > > > 
> > > > > > 3) Any truncate or hole punch operation on a pinned DAX page will fail.
> > > > > 
> > > > > So I didn't fully grok the patch set yet but by "pinned DAX page" do you
> > > > > mean a page which has corresponding file_pin covering it? Or do you mean a
> > > > > page which has pincount increased? If the first then I'd rephrase this to
> > > > > be less ambiguous, if the second then I think it is wrong. 
> > > > 
> > > > I mean the second.  but by "fail" I mean hang.  Right now the "normal" page
> > > > pincount processing will hang the truncate.  Given the discussion with John H
> > > > we can make this a bit better if we use something like FOLL_PIN and the page
> > > > count bias to indicate this type of pin.  Then I could fail the truncate
> > > > outright.  but that is not done yet.
> > > > 
> > > > so... I used the word "fail" to be a bit more vague as the final implementation
> > > > may return ETXTBUSY or hang as noted.
> > > 
> > > Ah, OK. Hanging is fine in principle but with longterm pins, your work
> > > makes sure they actually fail with ETXTBUSY, doesn't it? The thing is that
> > > e.g. DIO will use page pins as well for its buffers and we must wait there
> > > until the pin is released. So please just clarify your 'fail' here a bit
> > > :).
> > 
> > It will fail with ETXTBSY.  I've fixed a bug...  See below.
> > 
> > > 
> > > > > > 4) The user has the option of holding the lease or releasing it.  If they
> > > > > >    release it no other pin calls will work on the file.
> > > > > 
> > > > > Last time we spoke the plan was that the lease is kept while the pages are
> > > > > pinned (and an attempt to release the lease would block until the pages are
> > > > > unpinned). That also makes it clear that the *lease* is what is making
> > > > > truncate and hole punch fail with ETXTBUSY and the file_pin structure is
> > > > > just an implementation detail how the existence is efficiently tracked (and
> > > > > what keeps the backing file for the pages open so that the lease does not
> > > > > get auto-destroyed). Why did you change this?
> > > > 
> > > > closing the file _and_ unmaping it will cause the lease to be released
> > > > regardless of if we allow this or not.
> > > > 
> > > > As we discussed preventing the close seemed intractable.
> > > 
> > > Yes, preventing the application from closing the file is difficult. But
> > > from a quick look at your patches it seemed to me that you actually hold a
> > > backing file reference from the file_pin structure thus even though the
> > > application closes its file descriptor, the struct file (and thus the
> > > lease) lives further until the file_pin gets released. And that should last
> > > as long as the pages are pinned. Am I missing something?
> > > 
> > > > I thought about failing the munmap but that seemed wrong as well.  But more
> > > > importantly AFAIK RDMA can pass its memory pins to other processes via FD
> > > > passing...  This means that one could pin this memory, pass it to another
> > > > process and exit.  The file lease on the pin'ed file is lost.
> > > 
> > > Not if file_pin grabs struct file reference as I mentioned above...
> > >  
> > > > The file lease is just a key to get the memory pin.  Once unlocked the procfs
> > > > tracking keeps track of where that pin goes and which processes need to be
> > > > killed to get rid of it.
> > > 
> > > I think having file lease being just a key to get the pin is conceptually
> > > wrong. The lease is what expresses: "I'm accessing these blocks directly,
> > > don't touch them without coordinating with me." So it would be only natural
> > > if we maintained the lease while we are accessing blocks instead of
> > > transferring this protection responsibility to another structure - namely
> > > file_pin - and letting the lease go.
> > 
> > We do transfer that protection to the file_pin but we don't have to "let the
> > lease" go.  We just keep the lease with the file_pin as you said.  See below...
> > 
> > > But maybe I miss some technical reason
> > > why maintaining file lease is difficult. If that's the case, I'd like to hear
> > > what...
> > 
> > Ok, I've thought a bit about what you said and indeed it should work that way.
> > The reason I had to think a bit is that I was not sure why I thought we needed
> > to hang...  Turns out there were a couple of reasons...  1 not so good and 1 ok
> > but still not good enough to allow this...
> > 
> > 1) I had a bug in the XFS code which should have failed rather than hanging...
> >    So this was not a good reason...  And I was able to find/fix it...  Thanks!
> > 
> > 2) Second reason is that I thought I did not have a good way to tell if the
> >    lease was actually in use.  What I mean is that letting the lease go should
> >    be ok IFF we don't have any pins...  I was thinking that without John's code
> >    we don't have a way to know if there are any pins...  But that is wrong...
> >    All we have to do is check
> > 
> > 	!list_empty(file->file_pins)
> 
> Oops...  I got my "struct files" mixed up...  The RDMA struct file has the
> file_pins hanging off it...  This will not work.
> 
> I'll have to try something else to prevent this.  However, I don't want to walk
> all the pages of the inode.
> 
> Also I'm concerned about just failing if they happen to be pinned.  They need
> to be LONGTERM pinned...  Otherwise we might have a transient failure of an
> unlock based on some internal kernel transient pin...  :-/

My solution for this was that file_pin would contain counter of pinned
pages which vaddr_pin_pages() would increment and vaddr_unpin_pages() would
decrement. Checking whether there's any outstanding page pinned attached to
the file_pin is then trivial...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
