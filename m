Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2C90B5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 01:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfHPXUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 19:20:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:4094 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbfHPXUI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 19:20:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 16:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="201680827"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2019 16:20:07 -0700
Date:   Fri, 16 Aug 2019 16:20:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;
 -)
Message-ID: <20190816232006.GA11384@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:05:28PM -0700, 'Ira Weiny' wrote:
> On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> > > > Hello!
> > > > 
> > > > On Fri 09-08-19 15:58:14, ira.weiny@intel.com wrote:
> > > > > Pre-requisites
> > > > > ==============
> > > > > 	Based on mmotm tree.
> > > > > 
> > > > > Based on the feedback from LSFmm, the LWN article, the RFC series since
> > > > > then, and a ton of scenarios I've worked in my mind and/or tested...[1]
> > > > > 
> > > > > Solution summary
> > > > > ================
> > > > > 
> > > > > The real issue is that there is no use case for a user to have RDMA pinn'ed
> > > > > memory which is then truncated.  So really any solution we present which:
> > > > > 
> > > > > A) Prevents file system corruption or data leaks
> > > > > ...and...
> > > > > B) Informs the user that they did something wrong
> > > > > 
> > > > > Should be an acceptable solution.
> > > > > 
> > > > > Because this is slightly new behavior.  And because this is going to be
> > > > > specific to DAX (because of the lack of a page cache) we have made the user
> > > > > "opt in" to this behavior.
> > > > > 
> > > > > The following patches implement the following solution.
> > > > > 
> > > > > 0) Registrations to Device DAX char devs are not affected
> > > > > 
> > > > > 1) The user has to opt in to allowing page pins on a file with an exclusive
> > > > >    layout lease.  Both exclusive and layout lease flags are user visible now.
> > > > > 
> > > > > 2) page pins will fail if the lease is not active when the file back page is
> > > > >    encountered.
> > > > > 
> > > > > 3) Any truncate or hole punch operation on a pinned DAX page will fail.
> > > > 
> > > > So I didn't fully grok the patch set yet but by "pinned DAX page" do you
> > > > mean a page which has corresponding file_pin covering it? Or do you mean a
> > > > page which has pincount increased? If the first then I'd rephrase this to
> > > > be less ambiguous, if the second then I think it is wrong. 
> > > 
> > > I mean the second.  but by "fail" I mean hang.  Right now the "normal" page
> > > pincount processing will hang the truncate.  Given the discussion with John H
> > > we can make this a bit better if we use something like FOLL_PIN and the page
> > > count bias to indicate this type of pin.  Then I could fail the truncate
> > > outright.  but that is not done yet.
> > > 
> > > so... I used the word "fail" to be a bit more vague as the final implementation
> > > may return ETXTBUSY or hang as noted.
> > 
> > Ah, OK. Hanging is fine in principle but with longterm pins, your work
> > makes sure they actually fail with ETXTBUSY, doesn't it? The thing is that
> > e.g. DIO will use page pins as well for its buffers and we must wait there
> > until the pin is released. So please just clarify your 'fail' here a bit
> > :).
> 
> It will fail with ETXTBSY.  I've fixed a bug...  See below.
> 
> > 
> > > > > 4) The user has the option of holding the lease or releasing it.  If they
> > > > >    release it no other pin calls will work on the file.
> > > > 
> > > > Last time we spoke the plan was that the lease is kept while the pages are
> > > > pinned (and an attempt to release the lease would block until the pages are
> > > > unpinned). That also makes it clear that the *lease* is what is making
> > > > truncate and hole punch fail with ETXTBUSY and the file_pin structure is
> > > > just an implementation detail how the existence is efficiently tracked (and
> > > > what keeps the backing file for the pages open so that the lease does not
> > > > get auto-destroyed). Why did you change this?
> > > 
> > > closing the file _and_ unmaping it will cause the lease to be released
> > > regardless of if we allow this or not.
> > > 
> > > As we discussed preventing the close seemed intractable.
> > 
> > Yes, preventing the application from closing the file is difficult. But
> > from a quick look at your patches it seemed to me that you actually hold a
> > backing file reference from the file_pin structure thus even though the
> > application closes its file descriptor, the struct file (and thus the
> > lease) lives further until the file_pin gets released. And that should last
> > as long as the pages are pinned. Am I missing something?
> > 
> > > I thought about failing the munmap but that seemed wrong as well.  But more
> > > importantly AFAIK RDMA can pass its memory pins to other processes via FD
> > > passing...  This means that one could pin this memory, pass it to another
> > > process and exit.  The file lease on the pin'ed file is lost.
> > 
> > Not if file_pin grabs struct file reference as I mentioned above...
> >  
> > > The file lease is just a key to get the memory pin.  Once unlocked the procfs
> > > tracking keeps track of where that pin goes and which processes need to be
> > > killed to get rid of it.
> > 
> > I think having file lease being just a key to get the pin is conceptually
> > wrong. The lease is what expresses: "I'm accessing these blocks directly,
> > don't touch them without coordinating with me." So it would be only natural
> > if we maintained the lease while we are accessing blocks instead of
> > transferring this protection responsibility to another structure - namely
> > file_pin - and letting the lease go.
> 
> We do transfer that protection to the file_pin but we don't have to "let the
> lease" go.  We just keep the lease with the file_pin as you said.  See below...
> 
> > But maybe I miss some technical reason
> > why maintaining file lease is difficult. If that's the case, I'd like to hear
> > what...
> 
> Ok, I've thought a bit about what you said and indeed it should work that way.
> The reason I had to think a bit is that I was not sure why I thought we needed
> to hang...  Turns out there were a couple of reasons...  1 not so good and 1 ok
> but still not good enough to allow this...
> 
> 1) I had a bug in the XFS code which should have failed rather than hanging...
>    So this was not a good reason...  And I was able to find/fix it...  Thanks!
> 
> 2) Second reason is that I thought I did not have a good way to tell if the
>    lease was actually in use.  What I mean is that letting the lease go should
>    be ok IFF we don't have any pins...  I was thinking that without John's code
>    we don't have a way to know if there are any pins...  But that is wrong...
>    All we have to do is check
> 
> 	!list_empty(file->file_pins)

Oops...  I got my "struct files" mixed up...  The RDMA struct file has the
file_pins hanging off it...  This will not work.

I'll have to try something else to prevent this.  However, I don't want to walk
all the pages of the inode.

Also I'm concerned about just failing if they happen to be pinned.  They need
to be LONGTERM pinned...  Otherwise we might have a transient failure of an
unlock based on some internal kernel transient pin...  :-/

Ira

> 
> So now with this detail I think you are right, we should be able to hold the
> lease through the struct file even if the process no longer has any
> "references" to it (ie closes and munmaps the file).
> 
> I'm going to add a patch to fail releasing the lease and remove this (item 4)
> as part of the overall solution.
> 
> >  
> > > > > 5) Closing the file is ok.
> > > > > 
> > > > > 6) Unmapping the file is ok
> > > > > 
> > > > > 7) Pins against the files are tracked back to an owning file or an owning mm
> > > > >    depending on the internal subsystem needs.  With RDMA there is an owning
> > > > >    file which is related to the pined file.
> > > > > 
> > > > > 8) Only RDMA is currently supported
> > > > 
> > > > If you currently only need "owning file" variant in your patch set, then
> > > > I'd just implement that and leave "owning mm" variant for later if it
> > > > proves to be necessary. The things are complex enough as is...
> > > 
> > > I can do that...  I was trying to get io_uring working as well with the
> > > owning_mm but I should save that for later.
> > 
> > Ah, OK. Yes, I guess io_uring can be next step.
> 
> FWIW I have split the mm_struct stuff out.  I can keep it as a follow on series
> for other users later.  At this point I have to solve the issue Jason brought
> up WRT the RDMA file reference counting.
> 
> Thanks!
> Ira
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
