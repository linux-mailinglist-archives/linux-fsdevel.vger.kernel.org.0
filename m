Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433FA6F251A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjD2OpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjD2OpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B1171B;
        Sat, 29 Apr 2023 07:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5814C60B88;
        Sat, 29 Apr 2023 14:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C1C433EF;
        Sat, 29 Apr 2023 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682779517;
        bh=mF8d7P+Q4t5U+pNZXsUVOqHPGIKb0mpLg9o9u/1wQfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGhFgtwir8bS7+ebXlrQIQTvLZ3VhhaW+k2NPXmYS8VEncAhRLrf5JW78KTNBEgjk
         ffg7xWHRxYv3R3JzTE5o5TNzU671aPixEGtYdAbKGqCzkTOIEHme/2Ay5Ad0KrVIGu
         IRpTm+j0tDaJOonsBqQ7iYcbsEElOnRRnA+IhAx23Za8uDmZQPbyU3FE7FUBytw8O1
         5iKzcrOkq1c6Fnr6v2n2airc/5wEAPMfH2zOu0spvRwHJUpQhgDq5JkOF0+7QFMFti
         2XdY3e5INt8lgDs7qrAjbbc/nSbMxm+cDEFDn/gf1uAhVR4ADBCdEgWqZtdZMIpuRe
         iwFPBLIld5LuA==
Date:   Sat, 29 Apr 2023 10:45:14 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
Message-ID: <ZE0teudDjXJFz+1b@manet.1015granger.net>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:13:33AM -0400, Jeff Layton wrote:
> On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > Jan,
> > 
> > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot at an
> > alternative proposal to seamlessly support more filesystems.
> > 
> > While fanotify relaxes the requirements for filesystems to support
> > reporting fid to require only the ->encode_fh() operation, there are
> > currently no new filesystems that meet the relaxed requirements.
> > 
> > I will shortly post patches that allow overlayfs to meet the new
> > requirements with default overlay configurations.
> > 
> > The overlay and vfs/fanotify patch sets are completely independent.
> > The are both available on my github branch [2] and there is a simple
> > LTP test variant that tests reporting fid from overlayfs [3], which
> > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > requesting a non-decodeable file handle by userspace.
> > 
> > Thanks,
> > Amir.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vtft@quack3/
> > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> > 
> > Amir Goldstein (4):
> >   exportfs: change connectable argument to bit flags
> >   exportfs: add explicit flag to request non-decodeable file handles
> >   exportfs: allow exporting non-decodeable file handles to userspace
> >   fanotify: support reporting non-decodeable file handles
> > 
> >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> >  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++---
> >  fs/fhandle.c                                | 20 ++++++++------
> >  fs/nfsd/nfsfh.c                             |  5 ++--
> >  fs/notify/fanotify/fanotify.c               |  4 +--
> >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> >  fs/notify/fdinfo.c                          |  2 +-
> >  include/linux/exportfs.h                    | 18 ++++++++++---
> >  include/uapi/linux/fcntl.h                  |  5 ++++
> >  9 files changed, 67 insertions(+), 26 deletions(-)
> > 
> 
> This set looks fairly benign to me, so ACK on the general concept.

Me also (modulo previous review comments), so

  Acked-by: Chuck Lever <chuck.lever@oracle.com>

I assume either Amir or Jeff will take these when they are ready.
If I'm wrong, please do let me know and I can take them via the
NFSD tree.


> I am starting to dislike how the AT_* flags are turning into a bunch of
> flags that only have meanings on certain syscalls. I don't see a cleaner
> way to handle it though.
> -- 
> Jeff Layton <jlayton@kernel.org>
