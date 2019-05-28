Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73F12D038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 22:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfE1U1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 16:27:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34760 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726481AbfE1U1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 16:27:21 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4SKQxOl030998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 16:27:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 61580420481; Tue, 28 May 2019 16:26:59 -0400 (EDT)
Date:   Tue, 28 May 2019 16:26:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190528202659.GA12412@mit.edu>
References: <20190527172655.9287-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527172655.9287-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 08:26:55PM +0300, Amir Goldstein wrote:
> 
> Following our discussions on LSF/MM and beyond [1][2], here is
> an RFC documentation patch.
> 
> Ted, I know we discussed limiting the API for linking an O_TMPFILE
> to avert the hardlinks issue, but I decided it would be better to
> document the hardlinks non-guaranty instead. This will allow me to
> replicate the same semantics and documentation to renameat(2).
> Let me know how that works out for you.
> 
> I also decided to try out two separate flags for data and metadata.
> I do not find any of those flags very useful without the other, but
> documenting them seprately was easier, because of the fsync/fdatasync
> reference.  In the end, we are trying to solve a social engineering
> problem, so this is the least confusing way I could think of to describe
> the new API.

The way you have stated thigs is very confusing, and prone to be
misunderstood.  I think it would be helpful to state things in the
positive, instead of the negative.

Let's review what you had wanted:

	*If* the filename is visible in the directory after the crash,
	*then* all of the metadata/data that had been written to the file
	before the linkat(2) would be visible.

	HOWEVER, you did not want to necessarily force an fsync(2) in
	order to provide that guarantee.  That is, the filename would
	not necessarily be guaranteed to be visible after a crash when
	linkat(2) returns, but if the existence of the filename is
	persisted, then the data would be too.

	Also, at least initially we talked about this only making
	sense for O_TMPFILE file desacriptors.  I believe you were
	trying to generalize things so it wouldn't necessarily have to
	be a file created using O_TMPFILE.  Is that correct?

So instead of saying "A filesystem that accepts this flag will
guaranty, that old inode data will not be exposed in the new linked
name."  It's much clearer to state this in the affirmative:

	A filesystem which accepts this flag will guarantee that if
	the new pathname exists after a crash, all of the data written
	to the file at the time of the linkat(2) call will be visible.

I would think it's much simpler to say what *will* happen, instead of
what will not be visible.  (After all, technically speaking, returning
all zeros or random garbage data fufills the requirement "old data
will not be exposed", but that's probably not what you had in mind.  :-)

Also please note that it's spelled "guarantee".

Cheers,

						- Ted
