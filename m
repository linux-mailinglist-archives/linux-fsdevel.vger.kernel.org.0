Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821A59CC3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiHVXck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiHVXci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:32:38 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12D6E5007D;
        Mon, 22 Aug 2022 16:32:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A96D610E8D1E;
        Tue, 23 Aug 2022 09:32:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oQGuF-00GLi4-GX; Tue, 23 Aug 2022 09:32:31 +1000
Date:   Tue, 23 Aug 2022 09:32:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
Message-ID: <20220822233231.GJ3600936@dread.disaster.area>
References: <20220822133309.86005-1-jlayton@kernel.org>
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=63041213
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=ibcKH8McQ3gcoEwbJu8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:22:20PM -0400, Jeff Layton wrote:
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 3bfebde5a1a6..524abd372100 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -9,8 +9,8 @@
>   * ---------------------------
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> - * appear different to observers if there was a change to the inode's data or
> - * metadata since it was last queried.
> + * appear different to observers if there was an explicit change to the inode's
> + * data or metadata since it was last queried.
>   *
>   * Observers see the i_version as a 64-bit number that never decreases. If it
>   * remains the same since it was last checked, then nothing has changed in the
> @@ -18,6 +18,13 @@
>   * anything about the nature or magnitude of the changes from the value, only
>   * that the inode has changed in some fashion.
>   *
> + * Note that atime updates due to reads or similar activity do not represent

What does "or similar activity" mean?

This whole atime vs iversion issue is arising because "or any
metadata change" was interpretted literally by filesystems to mean
"any metadata change" without caveats or exclusions. Now you're both
changing that definition and making things *worse* by adding
explicit wiggle-room for future changes in behaviour to persistent
change counter behaviour.

iversion is going to be exposed to userspace, so we *can't change
the definition in future* because behaviour is bound by "changes may
break userspace apps" constraints. IOWs, we cannot justify changes
in behaviour with "but there are only in-kernel users" like is being
done for this change.

It's only a matter of time before someone is going to complain about
the fact that filesystems bump the change counter for internal
metadata modifications as they make changes to the persistent state
of data and metadata. These existing behaviours will almost
certainly causes visible NFS quirks due to unexpected
iversion bumps.

In case you didn't realise, XFS can bump iversion 500+ times for a
single 1MB write() on a 4kB block size filesytem, and only one of
them is initial write() system call that copies the data into the
page cache. The other 500+ are all the extent allocation and
manipulation transactions that we might run when persisting the data
to disk tens of seconds later. This is how iversion on XFS has
behaved for the past decade.

Right now, both ext4 and XFS conform to the exact definition that is
in this file. Trond has outlines that NFS wants iversion to behave
exactly like c/mtime changes, but that is fundamentally different to
how both ext4 and XFS have implemented the persistent change
counters.

IOWs, if we are going to start randomly excluding specific metadata
from the iversion API, then we need a full definition of exactly
what operations are supposed to trigger an iversion bump.
API-design-by-application-deficiency-whack-a-mole is not appropriate
for persistent structures, nor is it appropriate for information
that is going to be exposed to userspace via the kernel ABI.

Therefore, before we change behaviour in the filesystems or expose
it to userspace, we need to define *exactly* what changes are
covered by iversion. Once we have that definition, then we can
modify the filesytems appropriately to follow the required
definition and only change the persistent iversion counter when the
definition says we should change it.

While Trond's description is a useful definition from the
application perspective - and I'm not opposed to making it behave
like that (i.e. iversion only bumped with c/mtime changes) - it
requires a fundamentally different implementation in filesystems.

We must no longer capture *every metadata change* as we are
currently doing as per the current specification, and instead only
capture *application metadata changes* only.  i.e.  we are going to
need an on-disk format change of some kind because the two
behaviours are not compatible.

Further, if iversion is going to be extended to userspace, we most
definitely need to decouple it from our internal "change on every
metadata change" behaviour. We change how we persist metadata to
disk over time and if we don't abstract that away from the
persistent change counter we expose to userspace then this will lead
to random user visible changes in iversion behaviour in future.

Any way I look at it, we're at the point where filesystems now need
a real, fixed definition of what changes require an iversion bump
and which don't. The other option is that move the iversion bumping
completely up into the VFS where it happens consistently for every
filesystem whether they persist it or not. We also need a set of
test code for fstests that check that iversion performs as expected
and to the specification that the VFS defines for statx.

Either way we chose, one of these options are the only way that we
will end up with a consistent implementation of a change counter
across all the filesystems. And, quite frankly, that's exactly is
needed if we are going to present this information to userspace
forever more.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
