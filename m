Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69C566E7B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 21:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjAQUg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjAQUdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:33:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FA64FC1A;
        Tue, 17 Jan 2023 11:18:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2C5938B62;
        Tue, 17 Jan 2023 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673983080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NUMZE7OKBCtzp5cu21KyTnqs4N7aNDQxkPbTsK45gk=;
        b=RNkO3byPOwONDpc06rH6GgFnDF4z6VgyUp72K53NZmy20fJjvAqn0i1m3V+Nnot2ibSZJZ
        9X2Z5zr7eMh86SAUyzC6ogz8kZm9uHxVPCb19MwgQtyTJP20jsLPVo0Zi4ZYvg01FNGsiP
        ZqnHY9bXiN75Jl/mvyfEQ3+PVTmjMYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673983080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NUMZE7OKBCtzp5cu21KyTnqs4N7aNDQxkPbTsK45gk=;
        b=T0BII8y6Ua8UVFdPsGu7hf8EHaVI8KLoUtZAAUManxN6ugIoMUb8Benz2IRyEbabXMD+JW
        v1zZKRoT1gZlVhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93B621390C;
        Tue, 17 Jan 2023 19:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eff8Imj0xmN2QQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Jan 2023 19:18:00 +0000
Date:   Tue, 17 Jan 2023 20:12:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] btrfs: handle checksum validation and repair at
 the storage layer
Message-ID: <20230117191222.GC11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230112090532.1212225-1-hch@lst.de>
 <20230112090532.1212225-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112090532.1212225-3-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:05:14AM +0100, Christoph Hellwig wrote:
> Currently btrfs handles checksum validation and repair in the end I/O
> handler for the btrfs_bio.  This leads to a lot of duplicate code
> plus issues with variying semantics or bugs, e.g.
> 
>  - the until recently broken repair for compressed extents
>  - the fact that encoded reads validate the checksums but do not kick
>    of read repair
>  - the inconsistent checking of the BTRFS_FS_STATE_NO_CSUMS flag
> 
> This commit revamps the checksum validation and repair code to instead
> work below the btrfs_submit_bio interfaces.  For this to work we need
> to make sure an inode is available, so that is added as a parameter
> to btrfs_bio_alloc.  With that btrfs_submit_bio can preload
> btrfs_bio.csum from the csum tree without help from the upper layers,
> and the low-level I/O completion can iterate over the bio and verify
> the checksums.
> 
> In case of a checksum failure (or a plain old I/O error), the repair
> is now kicked off before the upper level ->end_io handler is invoked.
> Tracking of the repair status is massively simplified by just keeping
> a small failed_bio structure per bio with failed sectors and otherwise
> using the information in the repair bio.  The per-inode I/O failure
> tree can be entirely removed.
> 
> The saved bvec_iter in the btrfs_bio is now competely managed by
> btrfs_submit_bio and must not be accessed by the callers.
> 
> There is one significant behavior change here:  If repair fails or
> is impossible to start with, the whole bio will be failed to the
> upper layer.  This is the behavior that all I/O submitters execept
> for buffered I/O already emulated in their end_io handler.  For
> buffered I/O this now means that a large readahead request can
> fail due to a single bad sector, but as readahead errors are igored
> the following readpage if the sector is actually accessed will
> still be able to read.  This also matches the I/O failure handling
> in other file systems.

I've tried several times to convince myself that this patch could be
merged as-is despite it's going against principles and standards I apply
to other patches.

The patch size itself is an instant red flag for a change that tries to
turn upside down some fundamental functionality like checksumming time.

The changelog sounds like a good cover letter for a series, overall
description but lacks more details.

The patch got 2 reviews, but this is a developer review, the code does
what's advertised and the reviewers were hopefully able to understand
it. While I do such review too, I also do a pass that applies criteria
like long term maintainability, potential risk of introducing hidden
bugs and the cost of resolving them later at a much higher cost.

From your reply to v2 you do have some idea what can be split
(direct/buffered/ compressed IO) but don't see the value doing it.

How to split further:

- preparatory changes that only extend some interface (function,
  structure) and can take NULL or unused values before the actual switch
  happens, the logic of that is described separately

- code that does not need to be deleted in that same patch can be moved
  to a separate one, like with some other patches in the series

- the core change builds on the previous patches and describes how
  it's used, new logic, etc

- if the new repair io logic can live in parallel with the old
  io_failure_tree then remove the old logic separately, temporarily
  leaving unused structures eg. io_failure_tree

- use of mempool must be mentioned in the changelog with explanation
  that it's the safe usage pattern and why it cannot lead to lockups

I would feel bad about myself if I really have to close both my eyes,
turn around and do 'git apply' just to move forward with this patchset,
because your and Johannes' work depends on that. This would only
backfire.

So _please_ try to split the patch where the core logic that cannot be
split further is in a patch that is minimal in its size and does not
carry distracting changes.
