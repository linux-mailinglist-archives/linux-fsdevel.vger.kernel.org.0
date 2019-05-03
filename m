Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2327312AEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfECJqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 05:46:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50435 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725777AbfECJqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 05:46:15 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x439jhYI011160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 May 2019 05:45:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5AD4D420024; Fri,  3 May 2019 05:45:43 -0400 (EDT)
Date:   Fri, 3 May 2019 05:45:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vijay Chidambaram <vijay@cs.utexas.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190503094543.GD23724@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 10:15:01PM -0500, Vijay Chidambaram wrote:
> 
> A few things to clarify:
> 1) We are not suggesting that all file systems follow SOMC semantics.
> If ext4 does not want to do so, we are quite happy to document ext4
> provides a different set of reasonable semantics. We can make the
> ext4-related documentation as minimal as you want (or drop ext4 from
> documentation entirely). I'm hoping this will satisfy you.
> 2) As I understand it, I do not think SOMC rules out the scenario in
> your example, because it does not require fsync to push un-related
> files to storage.
> 3) We are not documenting how fsync works internally, merely what the
> user-visible behavior is. I think this will actually free up file
> systems to optimize fsync aggressively while making sure they provide
> the required user-visible behavior.

As documented, the draft of the rules *I* saw specifically said that a
fsync() to inode B would guarantee that metadata changes for inode A,
which were made before the changes to inode B, would be persisted to
disk since the metadata changes for B happened after the changes to
inode A.  It used the fsync(2) *explicitly* as an example for how
ordering of unrelated files could be guaranteed.  And this would
invalidate Park and Shin's incremental journal for fsync.

If the guarantees are when fsync(2) is *not* being used, sure, then
the SOMC model is naturally what would happen with most common file
system.  But then fsync(2) needs to appear nowhere in the crash
consistency model description, and that is not the case today.

Best regards,

						- Ted
