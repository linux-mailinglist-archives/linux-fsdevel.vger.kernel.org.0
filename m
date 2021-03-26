Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA17634B239
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 23:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCZWfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 18:35:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51528 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230512AbhCZWel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:34:41 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12QMYJsS010426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 18:34:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C21F315C39CD; Fri, 26 Mar 2021 18:34:19 -0400 (EDT)
Date:   Fri, 26 Mar 2021 18:34:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
Message-ID: <YF5ha6TZlVocDpSY@mit.edu>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area>
 <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area>
 <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
 <20210325225305.GM63242@dread.disaster.area>
 <CAOQ4uxgAxUORpUJezg+oWKXEafn0o33+bP5EN+VKnoQA_KurOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgAxUORpUJezg+oWKXEafn0o33+bP5EN+VKnoQA_KurOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been reading through this whole thread, and it appears to me that
the only real, long-term solution is to rely on file system UUID's
(for those file systems that support real 128-bit UUID's), and
optionally, for those file systems which support it, a new, "snapshot"
or "fs-instance" UUID.

The FS UUID is pretty simple; we just need an ioctl (or similar
interface) which returns the UUID for a particular file system.

The Snapshot UUID is the one which is bit trickier.  If the underlying
block device can supply something unique --- for example, the WWN or
WWID which is defined by FC, ATA, SATA, SCSI, NVMe, etc. then that
plus a partition identifier could be hashed to form a Snapshot UUID.
LVM volumes have a LV UUID that could be used for a similar purpose.

If you have a block device which doesn't relibly provide a WWN or
WWID, or we could could imagine that a file system has a field in the
superblock, and a file system specific program could get used to set
that field to a random UUID, and that becomes part of the snapshot
process.  This may be problematic for remote/network file systems
which don't have such a concept, but life's a bitch....

With that, then userspace can fetch the st_dev, st_ino, the FS UUID,
and the Snapshot UUID, and use some combination of those fields (as
available) to try determine whether two objects are unique or not.

Is this perfect?  Heck, no.  But ultimately, this is a hard problem,
and trying to wave our hands and create something that works given one
set of assumptions --- and completely breaks in a diferent operating
environment --- is going lead to angry users blaming the fs
developers.  It's a messy problem, and I think all we can do is expose
the entire mess to userspace, and make it be a userspace problem.
That way, the angry users can blame the userspace developers instead.  :-)

     	      	    	      	    - Ted
