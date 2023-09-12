Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE079D7E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbjILRte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 13:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbjILRtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:49:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197810FF;
        Tue, 12 Sep 2023 10:49:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C02F216DA;
        Tue, 12 Sep 2023 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694540960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIOECpgEAnqgxa9qsehre9AP3+VmQSdFWrInaEHQDXE=;
        b=Iws/tWDkAkGR9jB9V1dH4uxynhncIMU1eWfpHFVr0JL4Cle55dzFLcgNMcGX8Qyw7NDg/O
        oYaCf38oNWPsIGcA3BswteP+z35li5x+cETjFACcHoJh9uJH8BqH966lIr8QuRXjFo8vrF
        +DK+VMxi4XOM3vyGLfIdirFD8JqWueo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694540960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIOECpgEAnqgxa9qsehre9AP3+VmQSdFWrInaEHQDXE=;
        b=tp+Tmfz3o0tokg/EHovOimYd1NK0XnSPDS0gVgpKoF4haRy57iFsM6dEBzipMT/U945Xb1
        aSgheKLl7Gq7ZdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CD5213A39;
        Tue, 12 Sep 2023 17:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id olkNCqCkAGUVPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Sep 2023 17:49:20 +0000
Date:   Tue, 12 Sep 2023 19:42:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Subject: Re: remove get_super
Message-ID: <20230912174245.GC20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:11PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series against the VFS vfs.super branch finishes off the work to remove
> get_super and move (almost) all upcalls to use the holder ops.
> 
> The first part is the missing btrfs bits so that all file systems use the
> super_block as holder.
> 
> The second part is various block driver cleanups so that we use proper
> interfaces instead of raw calls to __invalidate_device and fsync_bdev.
> 
> The last part than replaces __invalidate_device and fsync_bdev with upcalls
> to the file system through the holder ops, and finally removes get_super.
> 
> It leaves user_get_super and get_active_super around.  The former is not
> used for upcalls in the traditional sense, but for legacy UAPI that for
> some weird reason take a dev_t argument (ustat) or a block device path
> (quotactl).  get_active_super is only used for calling into the file system
> on freeze and should get a similar treatment, but given that Darrick has
> changes to that code queued up already this will be handled in the next
> merge window.
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/misc.git remove-get_super

FYI, I've added patches 2-5 as a topic branch to btrfs for-next.
