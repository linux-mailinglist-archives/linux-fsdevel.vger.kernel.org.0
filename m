Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE4077F7C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjHQNbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351492AbjHQNbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:31:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F225211E;
        Thu, 17 Aug 2023 06:31:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA45921838;
        Thu, 17 Aug 2023 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692279068;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxHsVahN+II7L6QdwHgwa3dykGnq3oewSCrsfH/KRNs=;
        b=pHNe7my7estC1s/b6vNW11izgXmUg8eLSmwUlnvrKjW45L2s+O3jB8frT5bERp44nW9BFf
        oxFCapVFDSxEzySP1Lq1l6jfELzBVUh15T6d3FJa1ZFtKyzP5PsN2w5msAKzUcn2aM1xMG
        iUzTD5mH+tGbv6b5/MH0uDUtd61l+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692279068;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxHsVahN+II7L6QdwHgwa3dykGnq3oewSCrsfH/KRNs=;
        b=ZrIkejyby1h+sgyUZ9stf6CAWIOutsF7wcK+5OakVnNnUR9eSPlgD0dCnK7CEY4g4rPXpz
        YA5vuiECt2DwOpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AEBC1392B;
        Thu, 17 Aug 2023 13:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ycUOIRwh3mR0AwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 13:31:08 +0000
Date:   Thu, 17 Aug 2023 15:24:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/17] btrfs: open block devices after superblock creation
Message-ID: <20230817132439.GS2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-6-hch@lst.de>
 <20230811-wildpark-bronzen-5e30a56de1a1@brauner>
 <20230811131131.GN2420@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811131131.GN2420@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:11:31PM +0200, David Sterba wrote:
> On Fri, Aug 11, 2023 at 02:44:50PM +0200, Christian Brauner wrote:
> > On Fri, Aug 11, 2023 at 12:08:16PM +0200, Christoph Hellwig wrote:
> > > Currently btrfs_mount_root opens the block devices before committing to
> > > allocating a super block. That creates problems for restricting the
> > > number of writers to a device, and also leads to a unusual and not very
> > > helpful holder (the fs_type).
> > > 
> > > Reorganize the code to first check whether the superblock for a
> > > particular fsid does already exist and open the block devices only if it
> > > doesn't, mirroring the recent changes to the VFS mount helpers.  To do
> > > this the increment of the in_use counter moves out of btrfs_open_devices
> > > and into the only caller in btrfs_mount_root so that it happens before
> > > dropping uuid_mutex around the call to sget.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > 
> > Looks good to me,
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > 
> > And ofc, would be great to get btrfs reviews.
> 
> I'll take a look but there are some performance regressions to deal with
> and pre-merge window freeze so it won't be soon.

I'd rather take the btrfs patches via my tree and get them tested for a
longer time.  This patch in particular changes locking, mount, device
management, that's beyond what I'd consider safe to get merged outside
of btrfs.
