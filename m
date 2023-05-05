Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEC6F844C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjEENoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjEENoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 09:44:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C5D20776;
        Fri,  5 May 2023 06:44:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8461320081;
        Fri,  5 May 2023 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683294247;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vug7OuHHJxYhqTe/hchnDkSEzi3FMqu37uMJZ7/e8c0=;
        b=QvuWR7cqt+4DqYmk+yJmT5jpRejCoReqITGykA/KkMykVcKsCi3zcid4VLFgnN5+jYJoY6
        5AEuGn/Wmd/EPQFzYn+bejVr5XQIC0upy4OLrC1zmczNV2Uzr2gJcX7m0tKCihC5S5z+1i
        bcbD42TJv6Ylwom0yZOK0MXC0wa7LaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683294247;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vug7OuHHJxYhqTe/hchnDkSEzi3FMqu37uMJZ7/e8c0=;
        b=PYyGnY7qHC7A4ku9uRBFcjj2IunXpDCek4F+TxQuwK9NvYnqZ8XLorwe3dmbQZvsGUgD4Y
        JrON8eZ7ENultoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AB7F13488;
        Fri,  5 May 2023 13:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dAZ/DScIVWQ5XgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 13:44:07 +0000
Date:   Fri, 5 May 2023 15:38:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Message-ID: <20230505133810.GO6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 03:21:35PM +0800, Qu Wenruo wrote:
> On 2023/5/5 01:07, Guilherme G. Piccoli wrote:
> > Btrfs doesn't currently support to mount 2 different devices holding the
> > same filesystem - the fsid is used as a unique identifier in the driver.
> > This case is supported though in some other common filesystems, like
> > ext4; one of the reasons for which is not trivial supporting this case
> > on btrfs is due to its multi-device filesystem nature, native RAID, etc.
> 
> Exactly, the biggest problem is the multi-device support.
> 
> Btrfs needs to search and assemble all devices of a multi-device
> filesystem, which is normally handled by things like LVM/DMraid, thus
> other traditional fses won't need to bother that.
> 
> >
> > Supporting the same-fsid mounts has the advantage of allowing btrfs to
> > be used in A/B partitioned devices, like mobile phones or the Steam Deck
> > for example. Without this support, it's not safe for users to keep the
> > same "image version" in both A and B partitions, a setup that is quite
> > common for development, for example. Also, as a big bonus, it allows fs
> > integrity check based on block devices for RO devices (whereas currently
> > it is required that both have different fsid, breaking the block device
> > hash comparison).
> >
> > Such same-fsid mounting is hereby added through the usage of the
> > mount option "virtual_fsid" - when such option is used, btrfs generates
> > a random fsid for the filesystem and leverages the metadata_uuid
> > infrastructure (introduced by [0]) to enable the usage of this secondary
> > virtual fsid. But differently from the regular metadata_uuid flag, this
> > is not written into the disk superblock - effectively, this is a spoofed
> > fsid approach that enables the same filesystem in different devices to
> > appear as different filesystems to btrfs on runtime.
> 
> I would prefer a much simpler but more explicit method.
> 
> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
> 
> By this, we can avoid multiple meanings of the same super member, nor
> need any special mount option.
> Remember, mount option is never a good way to enable/disable a new feature.
> 
> The better method to enable/disable a feature should be mkfs and btrfstune.
> 
> Then go mostly the same of your patch, but maybe with something extra:
> 
> - Disbale multi-dev code
>    Include device add/replace/removal, this is already done in your
>    patch.
> 
> - Completely skip device scanning
>    I see no reason to keep btrfs with SINGLE_DEV feature to be added to
>    the device list at all.
>    It only needs to be scanned at mount time, and never be kept in the
>    in-memory device list.

This is actually a good point, we can do that already. As a conterpart
to 5f58d783fd7823 ("btrfs: free device in btrfs_close_devices for a
single device filesystem") that drops single device from the list,
single fs devices wouldn't be added to the list but some checks could be
still done like superblock validation for eventual error reporting.
