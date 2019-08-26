Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2579CC58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfHZJOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 05:14:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfHZJOX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:14:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 215D1AC7F;
        Mon, 26 Aug 2019 09:14:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E4971E3FE3; Mon, 26 Aug 2019 11:14:21 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:14:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udf: reduce leakage of blocks related to named streams
Message-ID: <20190826091421.GB10614@quack2.suse.cz>
References: <20190814125002.10869-1-steve@digidescorp.com>
 <20190815124218.GE14313@quack2.suse.cz>
 <4169b326-a8ff-5fc4-0e5e-393569273267@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4169b326-a8ff-5fc4-0e5e-393569273267@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-08-19 07:10:24, Steve Magnani wrote:
> Jan -
> 
> 
> On 8/15/19 7:42 AM, Jan Kara wrote:
> > On Wed 14-08-19 07:50:02,  Steven J. Magnani  wrote:
> > > Windows is capable of creating UDF files having named streams.
> > > One example is the "Zone.Identifier" stream attached automatically
> > > to files downloaded from a network. See:
> > >    https://msdn.microsoft.com/en-us/library/dn392609.aspx
> > > 
> > > Modification of a file having one or more named streams in Linux causes
> > > the stream directory to become detached from the file, essentially leaking
> > > all blocks pertaining to the file's streams.
> > > 
> > > Fix by saving off information about an inode's streams when reading it,
> > > for later use when its on-disk data is updated.
> > > <snip>
> > >   	} else {
> > >   		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
> > >   		    (inode->i_sb->s_blocksize_bits - 9);
> > > @@ -1498,6 +1502,16 @@ reread:
> > >   		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
> > >   		iinfo->i_lenAlloc = le32_to_cpu(efe->lengthAllocDescs);
> > >   		iinfo->i_checkpoint = le32_to_cpu(efe->checkpoint);
> > > +
> > > +		/* Named streams */
> > > +		iinfo->i_streamdir = (efe->streamDirectoryICB.extLength != 0);
> > > +		iinfo->i_locStreamdir =
> > > +			lelb_to_cpu(efe->streamDirectoryICB.extLocation);
> > > +		iinfo->i_lenStreams = le64_to_cpu(efe->objectSize);
> > > +		if (iinfo->i_lenStreams >= inode->i_size)
> > > +			iinfo->i_lenStreams -= inode->i_size;
> > > +		else
> > > +			iinfo->i_lenStreams = 0;
> > Hum, maybe you could just have i_objectSize instead of i_lenStreams? You
> > use the field just to preserve objectSize anyway so there's no point in
> > complicating it.
> > 
> 
> I started making this change and found that it actually complicates things more,
> by forcing the driver to update i_objectSize everywhere that i_size is changed.
> Are you sure this is what you want?

Aha, that's a good point! No, in that case what you did was better. I'll
just take your v2 patch then, I can make the other minor adjustments I was
suggesting when applying the patch. Thanks for looking into this!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
