Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0956D4E4836
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiCVVVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiCVVVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:21:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A45623C;
        Tue, 22 Mar 2022 14:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10862B81D9E;
        Tue, 22 Mar 2022 21:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E3DC340EC;
        Tue, 22 Mar 2022 21:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647983975;
        bh=BClLBVXJXDQrONeWWkjyrM+5YCzTAIsYq7MKuOJByFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZCFzl5GQR0RxDc1lumV9e576O7Y+XVeaksTKrjQ8dUWzYovGvJUrCQAOqZcECeID
         Tj3QNlQzNRhcr88R/s73bvQHRy4HBQGGQR1s/R8KKysLJc/PbrGQC1tJ00aTi0NgVn
         N6brQrURjV7jRQppHri4uKvyQoIvMSkKsCkeVB/Xyh6LuwrnrOKnAg8Z+EU8IZfr3G
         /ua3GSGenvjVYxUhPSkv2s+szP+w4K8fjBuLJxUZQeOjKMtoP2HKWEaac8VLB0cHvX
         IE5q5MZrKKOxW+FQo4YrhpHakgkGdmSGwpmMTNQoFYBrKVFeUPNelexr/d7y6NJ2c4
         25onw+Gp2Yo/A==
Date:   Tue, 22 Mar 2022 14:19:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
Message-ID: <20220322211935.GC8182@magnolia>
References: <cover.1647894991.git.dsterba@suse.com>
 <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
 <Yjo3tQO+fNNlZ4/i@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjo3tQO+fNNlZ4/i@localhost.localdomain>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:55:17PM -0400, Josef Bacik wrote:
> On Tue, Mar 22, 2022 at 11:23:21AM -0700, Linus Torvalds wrote:
> > On Mon, Mar 21, 2022 at 2:37 PM David Sterba <dsterba@suse.com> wrote:
> > >
> > > - allow reflinks/deduplication from two different mounts of the same
> > >   filesystem
> > 
> > So I've pulled this, and it looks ok, but I'm not getting the warm and fuzzies.
> > 
> > In particular, I'm not seeing any commentary about different
> > filesystems for this.
> > 
> > There are several filesystems that use that ->remap_file_range()
> > operation, so these relaxed rules don't just affect btrfs.
> > 
> > Yes, yes, checking for i_sb matching does seem sensible, but I'd
> > *really* have liked some sign that people checked with other
> > filesystem maintainers and this is ok for all of them, and they didn't
> > make assumptions about "always same mount" rather than "always same
> > filesystem".
> > 
> 
> > This affects at least cifs, nfs, overlayfs and ocfs2.
> 
> I had a talk with Darrick Wong about this on IRC, and his Reviewed-by is on the
> patch.  This did surprise nfsd when xfstests started failing, but talking with
> Bruce he didn't complain once he understood what was going on.

FWIW, I remember talking about this with Bruce and (probably Anna too)
during a hallway BOF at the last LSFMMBPFBBQ that I went to, which was
2018(?)  At the time, I think we resolved that nfs42_remap_file_range
was capable of detecting and dealing with unsupported requests, so a
direct comparison of the ->remap_file_range or ->f_op wasn't necessary
for them.

> Believe me I
> have 0 interest in getting the other maintainers upset with me by sneaking
> something by them, I made sure to run it by people first, tho I probably should
> have checked with people directly other than Darrick.

I /am/ a little curious what Steve French has to say w.r.t CIFS.

AFAICT overlayfs passes the request down to the appropriate fs
under-layer, so its correctness mostly depends on the under-layer's
implementation.  But I'll let Amir or someone chime in on that. ;)

As for ocfs2, back when I added support for ->remap_file_range to ocfs2,
cross-mount reflink and dedupe worked fine, or at least as well as
anything works on ocfs2.

(XFS has always supported cross-mount remappings.)

> > 
> > Adding fsdevel, and pointing to that
> > 
> > -       if (src_file->f_path.mnt != dst_file->f_path.mnt)
> > +       if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
> > 
> > change in commit 9f5710bbfd30 ("fs: allow cross-vfsmount reflink/dedupe")
> > 
> > And yes, there was already a comment about "Practically, they only
> > need to be on the same file system" from before that matches the new
> > behavior, but hey, comments have been known to be wrong in the past
> > too.
> > 
> > And yes, I'm also aware that do_clone_file_range() already had that
> > exact same i_sb check and it's not new, but since ioctl_file_clone()
> > cheched for the mount path, I don't think you could actually reach it
> > without being on the same mount.
> > 
> > And while discussing these sanity checks: wouldn't it make sense to
> > check that *both* the source file and the destination file support
> > that remap_file_range() op, and it's the same op?
> > 
> > Yes, yes, it probably always is in practice, but I could imagine some
> > type confusion thing. So wouldn't it be nice to also have something
> > like
> > 
> >     if (dst_file->f_op != src_file->f_op)
> >           goto out_drop_write;
> > 
> > in there? I'm thinking "how about dedupe from a directory to a regular
> > file" kind of craziness...
> >
> 
> This more fine-grained checking is handled by generic_remap_file_range_prep() to
> make sure we don't try to dedup a directory or pipe or some other nonsense.

Yes.  The VFS only allows remapping between regular files.

--D

> Thanks,
> 
> Josef 
