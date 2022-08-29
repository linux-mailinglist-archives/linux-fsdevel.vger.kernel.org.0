Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8515A445B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiH2H5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiH2H5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:57:30 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AA735071A;
        Mon, 29 Aug 2022 00:57:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2931C10E8EF7;
        Mon, 29 Aug 2022 17:56:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oSZdb-001FoP-Kj; Mon, 29 Aug 2022 17:56:51 +1000
Date:   Mon, 29 Aug 2022 17:56:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Message-ID: <20220829075651.GS3600936@dread.disaster.area>
References: <20220826214703.134870-1-jlayton@kernel.org>
 <20220826214703.134870-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826214703.134870-2-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=630c7149
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=zVjiu_gZAAAA:8 a=SEtKQCMJAAAA:8
        a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8 a=UtIFyLbYhr23VuY2CJMA:9
        a=CjuIK1q_8ugA:10 a=DXoJjCrjhysRDS3qLJti:22 a=kyTSok1ft720jgMXX5-3:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 05:46:57PM -0400, Jeff Layton wrote:
> The i_version field in the kernel has had different semantics over
> the decades, but we're now proposing to expose it to userland via
> statx. This means that we need a clear, consistent definition of
> what it means and when it should change.
> 
> Update the comments in iversion.h to describe how a conformant
> i_version implementation is expected to behave. This definition
> suits the current users of i_version (NFSv4 and IMA), but is
> loose enough to allow for a wide range of possible implementations.
> 
> Cc: Colin Walters <walters@verbum.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/iversion.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 3bfebde5a1a6..45e93e1b4edc 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -9,8 +9,19 @@
>   * ---------------------------
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> - * appear different to observers if there was a change to the inode's data or
> - * metadata since it was last queried.
> + * appear different to observers if there was an explicit change to the inode's
> + * data or metadata since it was last queried.
> + *
> + * An explicit change is one that would ordinarily result in a change to the
> + * inode status change time (aka ctime). The version must appear to change, even
> + * if the ctime does not (since the whole point is to avoid missing updates due
> + * to timestamp granularity). If POSIX mandates that the ctime must change due
> + * to an operation, then the i_version counter must be incremented as well.
> + *
> + * A conformant implementation is allowed to increment the counter in other
> + * cases, but this is not optimal. NFSv4 and IMA both use this value to determine
> + * whether caches are up to date. Spurious increments can cause false cache
> + * invalidations.

"not optimal", but never-the-less allowed - that's "unspecified
behaviour" if I've ever seen it. How is userspace supposed to
know/deal with this?

Indeed, this loophole clause doesn't exist in the man pages that
define what statx.stx_ino_version means. The man pages explicitly
define that stx_ino_version only ever changes when stx_ctime
changes.

IOWs, the behaviour userspace developers are going to expect *does
not include* stx_ino_version changing it more often than ctime is
changed. Hence a kernel iversion implementation that bumps the
counter more often than ctime changes *is not conformant with the
statx version counter specification*. IOWs, we can't export such
behaviour to userspace *ever* - it is a non-conformant
implementation.

Hence I think anything that bumps iversion outside the bounds of the
statx definition should be declared as such:

"Non-conformant iversion implementations:
	- MUST NOT be exported by statx() to userspace
	- MUST be -tolerated- by kernel internal applications that
	  use iversion for their own purposes."

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
