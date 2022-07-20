Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA75E57AF82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 05:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiGTDbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 23:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiGTDbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE430F47;
        Tue, 19 Jul 2022 20:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5EED60E0B;
        Wed, 20 Jul 2022 03:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32011C3411E;
        Wed, 20 Jul 2022 03:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658287858;
        bh=Dd8fAebfgxxrDOM4VzeKg0A1VKWf6xpdr0h9G1Ss/Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/QFhKjhoZPAC093arh07LfATB0WDm25TAMgffPOb4aTM7klQhTYJ26Y6tzDtHTBD
         yxbEfXrkXdvTfmlMnJfGJaeYdVSrGc74E7tT35ZZxrHcpSzInavVkDxMwD9loYeKo+
         lANjOJezOO8hVnFkQ18JrLqhAKvbQAeHCu1oc/BhskrIaCG4WWkhYi30SwGvmFbHwv
         32BInM8B2zgBQfyMLoPrRKl0O8RoHsbXVHGy2WKy1IOnd43sPWYZhXmIEuMl6vgfYL
         W+of5e4OoSNBg92X2YfDAP/5qbhX/iau4ZEHluSSrOxYSpaPFGY39KnXjIfTD/HFHM
         7bJFt2mOseltw==
Date:   Tue, 19 Jul 2022 20:30:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <Ytd28d36kwdYWkVZ@magnolia>
References: <20220719234131.235187-1-bongiojp@gmail.com>
 <Ytd0G0glVWdv+iaD@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytd0G0glVWdv+iaD@casper.infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:18:51AM +0100, Matthew Wilcox wrote:
> On Tue, Jul 19, 2022 at 04:41:31PM -0700, Jeremy Bongio wrote:
> > +/*
> > + * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
> > + */
> > +struct fsuuid {
> > +	__u32       fsu_len;
> > +	__u32       fsu_flags;
> > +	__u8        fsu_uuid[];
> > +};
> 
> A UUID has a defined size (128 bits):
> https://en.wikipedia.org/wiki/Universally_unique_identifier
> 
> Why are we defining flags and len?

@flags because XFS actually need to add a superblock feature bit
(meta_uuid) to change the UUID while the fs is mounted.  That kind of
change can break backwards compatiblity, so we might want to make
*absolutely sure* that the sysadmin is aware of this:

# xfs_io -c 'setfsuuid 42f3d4d6-d5bb-4e91-a187-2ed0f3c080b2 --to-hell-with-backwards-compatibility' /mnt

@len because some filesystems like vfat have volume identifiers that
aren't actually UUIDs (they're u32); some day someone might want to port
vfat to implement at least the GETFSUUID part (they already have
FAT_IOCTL_GET_VOLUME_ID); and given the amount of confusion that results
when buffer lengths are implied (see [GS]ETFSLABEL) I'd rather this pair
of ioctls be explicit about the buffer length now rather than deal with
the fallout of omitting it now and regretting it later.

--D
