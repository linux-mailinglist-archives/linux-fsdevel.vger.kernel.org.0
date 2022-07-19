Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3E579FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiGSNg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiGSNgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:36:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4A659258;
        Tue, 19 Jul 2022 05:51:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26JCoxkA026760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 08:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658235060; bh=GYUat2R3yPsKAwD3MsZ21EEQ34Qz8Au2by9MurkA7ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PLRkMVjqwkoWFTm133zDvtIVBqWVOYV4UaWYxvQgoXaGBoWsLmDOQigtbCdr+EoqP
         Uxq2XnUIUtOPnlvojjR+V5zEiX2KxvtHXqNUy8m229654By36Awiim4FPH5Q+N5ono
         nsJRfuH/7SulBrAfuDi47NjEt8Pc5Ahf5tlWHQvfRSkh3WUqntVabgrNN5PEx4OqSw
         AbRupZMEgbV8cFRJcu2knodKUTLugoOJO/5jeQGO0mo8Z63sEonMB3kteAxDenks7H
         9zUuh4vId9ylQ4Cb76vHKAb+Ool2g7njEUG/kUouCcx1aOcnVRvXzf9IFkaTOUoydu
         /VxsaisIclSQw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C2DDC15C00E4; Tue, 19 Jul 2022 08:50:58 -0400 (EDT)
Date:   Tue, 19 Jul 2022 08:50:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jeremy Bongio <bongiojp@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YtaosutXNdSvgwvP@mit.edu>
References: <20220719065551.154132-1-bongiojp@gmail.com>
 <CAK8P3a17LZNXDW9r3ixfMg_c-vtqqT51MCLEsyF4Loh8VfDw7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a17LZNXDW9r3ixfMg_c-vtqqT51MCLEsyF4Loh8VfDw7w@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:30:23AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 8:55 AM Jeremy Bongio <bongiojp@gmail.com> wrote:
> > This pair of ioctls may be implemented in more filesystems in the future,
> > namely XFS.
> >
> 
> > +++ b/fs/ext4/ext4.h
> > @@ -724,6 +724,8 @@ enum {
> > +#define EXT4_IOC_GETFSUUID             _IOR('f', 44, struct fsuuid)
> > +#define EXT4_IOC_SETFSUUID             _IOW('f', 44, struct fsuuid)
> 
> The implementation looks good to me, but maybe it should be defined in
> the UAPI headers in a filesystem-independent way? Having it in a private
> header means it will not be available to portable user programs, and will
> be hidden from tools like strace that parse the uapi headers to find
> ioctl definitions.

The plan is that when another file system implements it, we'll promote
this to be a include/uapi/linux/fs.h.  For e2fsprogs, we've always
hard-coded the ioctl definitions as a default, because we don't want
to be tied to having the correct version for the kernel header files
--- I consider it important that there aren't variences in what kind
of functionality you get if you build e2fsprogs on RHEL vs Fedora vs
Debian Stable.  And at least initially, the primary consumer of the
ioctl will be tune2fs.

As to why we define things first in the file system header, part of
this is due to some interesting dynamics around bike-shedding.  It is
perceived that there are times when the bike-shed brigade comes up in
full force, giving conflicting demands, and generally preventing
forward progress, and so one of the reasons why file system developers
often want to define things first a file-system dependent way is as a
safety value so that we can blow past "unreasonable" demands.  This
recently came up in a LSF/MM discussion where Kent Overstreet proposed
a new "ioctl" mechanism which promised that all ioctls would go
through the full strict syscall ABI review and that there be no way to
bypass it --- and in his view, this was considered a feature, and not
a bug.  Interestingly, after this LSF/MM discussion, a certain major
file system maintainer (not myself) stated in a hallway coversation
that due to unreasonable bike-sheeding, he was planning on bypassing
the whole review process and just defining in an fs-dependent ioctl in
an fs-specific header file because he was so f***** frustrated by the
process.

Of course, for every unreasonable bike-shedding, there are cases like
the dedup ioctl which has recently observed that the interface was
terrible, and it *should* have gone through more careful review before
making it be a user-visible interface that multiple file systems now
have to deal with.

At this point, my personal "Via Media" approach to this is to send the
patches for full review to all of the usual places, so we *can* get
the benefits of interfave review.  However, if things go pear-shaped,
since the ioctl's are defined as fs-specific I can pull the "I'm the
XXX fs maintainer" card, and just include it in my next pull request
to Linus.

If ioctl has a reasonable interface, then other file system
maintainers can choose to adopt it, at which point we promote it to be
an fs-independent ioctl.  Or maybe they'll define their own
fs-depedent ioctl, and we iterate in that way, using a market-forces
dynamics ala how we have independent Linux distributions which compete
with one another to provide a better use experience, as opposed to a
single One True Userspace under the authority of the NetBSD or FreeBSD
core team.

It's not a perfect mechanism, but given that we don't have something
like an Architectural Review Board with appeals up to some management
chain if said ARB becomes obstructive (which is how things might work
in a corporate environment), it's the best approach I've been able to
come up with.

						- Ted

P.S.  BTW, this isn't a problem which is unique to system calls, but
new file system icotls seem to be defined much more often than system
calls.  Whether that's because we naturally need many more of these
interfaces, many of which are used by primarily by the XXX-fsprogs
utilities, or because it's an escape hatch when the system call review
process is perceived, correctly, or incorrectly, in too heavy-weight
and prone to bike-shedding, is certainly a debatable point.  But
perhaps this is more of a Maintainer's Summit topic, although I don't
think there really is a good solution other than "sometimes, someone
in a position of power, whether it's Linus or a fs maintainer, has to
be able to use an escape hatch when the process goes sideways.
