Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AED154654
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgBFOgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:36:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbgBFOgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580999808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6ywBgEyecB7i6tCl7rBaaIJ1nlHocqQsOpoi6h5WDY=;
        b=CsgB7eUduvu0+ISkBlSObKgsrbx0gNcxysKb/vV4a6t1dBzWBYmBPsw30DfaeqDRClsuGU
        MMYR3pEN+24Q0wU3NoI5eLYOeEEPbYdI+hlDx2w7NBTahOZ5K2T1NUfDIyg9/a461hKzLY
        Ih6qwMB4nhwd4y0i/0DRvNehM6NdfFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-acILuq70MVCP-rDbn0K-rg-1; Thu, 06 Feb 2020 09:36:46 -0500
X-MC-Unique: acILuq70MVCP-rDbn0K-rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA275800D54;
        Thu,  6 Feb 2020 14:36:44 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4302B790EE;
        Thu,  6 Feb 2020 14:36:44 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 0/3] fstests: fixes for 64k pages and dax
References: <20200205224818.18707-1-jmoyer@redhat.com>
        <20200205230626.GO20628@dread.disaster.area>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Feb 2020 09:36:43 -0500
In-Reply-To: <20200205230626.GO20628@dread.disaster.area> (Dave Chinner's
        message of "Thu, 6 Feb 2020 10:06:26 +1100")
Message-ID: <x49lfpflr44.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:

> [cc fstests@vger.kernel.org]
>
> On Wed, Feb 05, 2020 at 05:48:15PM -0500, Jeff Moyer wrote:
>> This set of patches fixes a few false positives I encountered when
>> testing DAX on ppc64le (which has a 64k page size).
>> 
>> Patch 1 is actually not specific to non-4k page sizes.  Right now we
>> only test for dax incompatibility in the dm flakey target.  This means
>> that tests that use dm-thin or the snapshot target will still try to
>> run.  Moving the check to _require_dm_target fixes that problem.
>> 
>> Patches 2 and 3 get rid of hard coded block/page sizes in the tests.
>> They run just fine on 64k pages and 64k block sizes.
>> 
>> Even after these patches, there are many more tests that fail in the
>> following configuration:
>> 
>> MKFS_OPTIONS="-b size=65536 -m reflink=0" MOUNT_OPTIONS="-o dax"
>> 
>> One class of failures is tests that create a really small file system
>> size.  Some of those tests seem to require the very small size, but
>> others seem like they could live with a slightly bigger size that
>> would then fit the log (the typical failure is a mkfs failure due to
>> not enough blocks for the log).  For the former case, I'm tempted to
>> send patches to _notrun those tests, and for the latter, I'd like to
>> bump the file system sizes up.  300MB seems to be large enough to
>> accommodate the log.  Would folks be opposed to those approaches?
>> 
>> Another class of failure is tests that either hard-code a block size
>> to trigger a specific error case, or that test a multitude of block
>> sizes.  I'd like to send a patch to _notrun those tests if there is
>> a user-specified block size.  That will require parsing the MKFS_OPTIONS
>> based on the fs type, of course.  Is that something that seems
>> reasonable?
>> 
>> I will follow up with a series of patches to implement those changes
>> if there is consensus on the approach.  These first three seemed
>> straight-forward to me, so that's where I'm starting.
>> 
>> Thanks!
>> Jeff
>> 
>> [PATCH 1/3] dax/dm: disable testing on devices that don't support dax
>> [PATCH 2/3] t_mmap_collision: fix hard-coded page size
>> [PATCH 3/3] xfs/300: modify test to work on any fs block size
>
> Hi Jeff,
>
> You probably should be sending fstests patches to
> fstests@vger.kernel.org, otherwise they probably won't get noticed
> by the fstests maintainer...

Hm, somehow I didn't know about that list.  I'll send v2 there, thanks!

-Jeff

