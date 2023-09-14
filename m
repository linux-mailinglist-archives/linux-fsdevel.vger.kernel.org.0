Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7579FEE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbjINIsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjINIsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:48:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5006698;
        Thu, 14 Sep 2023 01:48:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E00E61F459;
        Thu, 14 Sep 2023 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694681289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5UDwGteLFhh2/0nMPx8cref2hipYMXRtcBto7gypmo=;
        b=ohc5QJ47nEM1DELrLcNDtDJuBjJ52kpjAX1BCcO+w95Az6n602h5w9TLPjIYiOWjHNWhM3
        uaYXjMqLw0cK8zU3MyigcnHuTCYuufLliv2BXyQcLz17z1iJKqZDubzY17j+FyjV9y0uTA
        K4YlkoIgoc7mmW5dJosjmOH5ZjWfrAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694681289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5UDwGteLFhh2/0nMPx8cref2hipYMXRtcBto7gypmo=;
        b=n+WVMWLOD1EYrdaY0Timu7z7Wrfr1A9IAp4nA5sBLbCV9YCprCs1JXDcnnUtC858zfeuP6
        PctuSy4uNLPnL3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC89B13580;
        Thu, 14 Sep 2023 08:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6dfrMcnIAmVQNwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 14 Sep 2023 08:48:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66DB9A07C2; Thu, 14 Sep 2023 10:48:09 +0200 (CEST)
Date:   Thu, 14 Sep 2023 10:48:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20230914084809.arzw34svsvvkwivm@quack3>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230912174245.GC20408@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912174245.GC20408@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-09-23 19:42:45, David Sterba wrote:
> On Fri, Aug 11, 2023 at 12:08:11PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series against the VFS vfs.super branch finishes off the work to remove
> > get_super and move (almost) all upcalls to use the holder ops.
> > 
> > The first part is the missing btrfs bits so that all file systems use the
> > super_block as holder.
> > 
> > The second part is various block driver cleanups so that we use proper
> > interfaces instead of raw calls to __invalidate_device and fsync_bdev.
> > 
> > The last part than replaces __invalidate_device and fsync_bdev with upcalls
> > to the file system through the holder ops, and finally removes get_super.
> > 
> > It leaves user_get_super and get_active_super around.  The former is not
> > used for upcalls in the traditional sense, but for legacy UAPI that for
> > some weird reason take a dev_t argument (ustat) or a block device path
> > (quotactl).  get_active_super is only used for calling into the file system
> > on freeze and should get a similar treatment, but given that Darrick has
> > changes to that code queued up already this will be handled in the next
> > merge window.
> > 
> > A git tree is available here:
> > 
> >     git://git.infradead.org/users/hch/misc.git remove-get_super
> 
> FYI, I've added patches 2-5 as a topic branch to btrfs for-next.

Hum, I don't see them there. Some glitch somewhere?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
