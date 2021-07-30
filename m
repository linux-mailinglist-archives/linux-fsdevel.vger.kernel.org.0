Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137DB3DB2CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhG3F2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:28:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhG3F2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:28:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8B1F22368;
        Fri, 30 Jul 2021 05:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627622906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZGoysChlqf56fkEulT2btB4o3HFRAz+c0KxGwKfmmo=;
        b=xh4IR/oRcaKOX1jG988aIRqZgH1sH4Ni1xVVuga5cqj/qdEbS7q3UEnc2qMiew+Jwzkpxo
        dYKWkUDsv1+KXBgfhTVlB3cxcTBOMHcU5USScy7ypuTeqXb16jAMCE637tBs8Q75HxdrB4
        /UjYz4vYF+seeUSlBM/Kzim4L9ERid8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627622906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZGoysChlqf56fkEulT2btB4o3HFRAz+c0KxGwKfmmo=;
        b=mskfS9zRUYtMaYA9ZTvS10i/r2So7Sj7myrz2BmxULg/UCxRa2SQfwuVZRACzM4ejYha2S
        Wk35zLAvSQnR9zCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E94AA13BFB;
        Fri, 30 Jul 2021 05:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CaYIKfeNA2F4eAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 05:28:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
In-reply-to: <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546548.32498.10889023150565429936.stgit@noble.brown>,
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
Date:   Fri, 30 Jul 2021 15:28:20 +1000
Message-id: <162762290067.21659.4783063641244045179@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Al Viro wrote:
> On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > /proc/$PID/mountinfo contains a field for the device number of the
> > filesystem at each mount.
> > 
> > This is taken from the superblock ->s_dev field, which is correct for
> > every filesystem except btrfs.  A btrfs filesystem can contain multiple
> > subvols which each have a different device number.  If (a directory
> > within) one of these subvols is mounted, the device number reported in
> > mountinfo will be different from the device number reported by stat().
> > 
> > This confuses some libraries and tools such as, historically, findmnt.
> > Current findmnt seems to cope with the strangeness.
> > 
> > So instead of using ->s_dev, call vfs_getattr_nosec() and use the ->dev
> > provided.  As there is no STATX flag to ask for the device number, we
> > pass a request mask for zero, and also ask the filesystem to avoid
> > syncing with any remote service.
> 
> Hard NAK.  You are putting IO (potentially - network IO, with no upper
> limit on the completion time) under namespace_sem.

Why would IO be generated? The inode must already be in cache because it
is mounted, and STATX_DONT_SYNC is passed.  If a filesystem did IO in
those circumstances, it would be broken.

Thanks for the review,
NeilBrown

