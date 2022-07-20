Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3957BE0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiGTSrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGTSrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:47:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572F72EC9;
        Wed, 20 Jul 2022 11:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C0D4CE22A4;
        Wed, 20 Jul 2022 18:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C25EC3411E;
        Wed, 20 Jul 2022 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658342828;
        bh=PlIbo8H1Ab1uXwXY1wcnm7n9gzZYSnHRZJGODP0YNY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o66qAVBC5fLAA275WUFTSoYdNV3xsbOjfjnv8xafsYkLYwJoaqOGqj8b+nmeduixW
         pK1AuoS0rvGrJ8i1SiIyxp8xyfJ23rCQvX/qr02/vwnuX/a+/rt8zFBGWRXUophedo
         GDoxK/YvhTKr7AWWwvmm3skl4NHVb40zGQ5Gk9mr9q6D8D5hwR66Oc5ZFOhsSHR5yX
         0NYKpDBqnHRdFOiO2dKgD45l3Enu+WPpvyrZuiz2qSy4A9sXlFIPhZ47TSiflLJ2AM
         ebkxdIU/Q1aagTBSfXD2m1wR7ryLVn8ajaHT4r3YWiD5VsGXI8r88Udt2tPXWDYzWv
         oF2ot3Ei41gjA==
Date:   Wed, 20 Jul 2022 11:47:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jeremy Bongio <bongiojp@gmail.com>,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YthNrO4PMR+5ao+6@magnolia>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia>
 <YtgNCfMcuX7DGg7z@casper.infradead.org>
 <YthCucuMk/SAL0qN@mit.edu>
 <YthI9qp+VeNbFQP3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthI9qp+VeNbFQP3@casper.infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 07:27:02PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 20, 2022 at 02:00:25PM -0400, Theodore Ts'o wrote:
> > On Wed, Jul 20, 2022 at 03:11:21PM +0100, Matthew Wilcox wrote:
> > > Uhhh.  So what are the semantics of len?  That is, on SET, what does
> > > a filesystem do if userspace says "Here's 8 bytes" but the filesystem
> > > usually uses 16 bytes?  What does the same filesystem do if userspace
> > > offers it 32 bytes?  If the answer is "returns -EINVAL", how does
> > > userspace discover what size of volume ID is acceptable to a particular
> > > filesystem?
> > > 
> > > And then, on GET, does 'len' just mean "here's the length of the buffer,
> > > put however much will fit into it"?  Should filesystems update it to
> > > inform userspace how much was transferred?
> > 
> > What I'd suggest is that for GET, the length field when called should
> > be the length of the buffer, and if the length is too small, we should
> > return some error --- probably EINVAL or ENOSPC.  If the buffer size
> > length is larger than what is needed, having the file system update it
> > with the size of the UUID that was returned.

I'd suggest something different -- calling the getfsuuid ioctl with a
null argument should return the filesystem's volid/uuid size as the
return value.  If userspace supplies a non-null argument, then fsu_len
has to match the filesystem's volid/uuid size or else you get EINVAL.

--D

> > And this would be how the userspace can discover size of the UUID.  In
> > practice, though, the human user is going to be suppliyng the UUID,
> > which means the *human* is going to have to understand that "oh, this
> > is a VFAT file system, so I need to give 32-bit UUID formatted as
> > DEAD-BEAF" or "oh, this is a ntfs file system, so I need to enter into
> > the command line a UUID formatted as the text string
> > A24E62F14E62BDA3".  (The user might also end up having to ntfs or vfat
> > specific uuid changing tool; that's unclear at this point.)
> 
> I think you covered all my questions there except for what happens
> if the user tried to set ext4 to 0xDEADBEEF; that should return
> -EINVAL?  They could specify 0xDEADBEEF'00000000'00000000'00000000 or
> 0x00000000'00000000'00000000'DEADBEEF, but it'd be up to them to choose
> which one they wanted rather than have the filesystem pad it out for them?
> 
> > As far as Jeremy's patch is concerned, I don't think we need to change
> > anything forthe SET ioctl, but for the GET util, it would be better in
> > the extremely unlikely case where the user pass in a length larger
> > than 16 bytes (say, 32), that we return the 16 byte UUID, and update
> > the length field to be 16 bytes.
> > 
> > I don't think it's strictly necessary, since in practice there is no
> > reason why a file system's volume identifier would ever be larger than
> > 16 bytes --- the chances that we might need an extra 240 bytes to
> > specify a multiverse identifier seems.... unlikely.  :-)
> 
> Yes, 128 bits is sufficiently unique for this use case.
