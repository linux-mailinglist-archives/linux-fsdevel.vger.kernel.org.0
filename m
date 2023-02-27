Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC586A40D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 12:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB0Lj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 06:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0Lj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:39:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0EAB74C;
        Mon, 27 Feb 2023 03:39:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99A0A1FD66;
        Mon, 27 Feb 2023 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677497966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVS14n0GDTqfvhRA+DP8X9hCVpdLZuTQ0R/ZHuFyhHk=;
        b=n9aLASAR6XYYsnsQl4uCk6uFdI2Poqw6c2vZmNpT94ZZ3Ln0hMBldkdmHWMF1J7/1FVso0
        g+w1W0l0C5YNVkU4T1Z6ee8e/rW50WLsvIhGHOHMgEzKRkjyNM/IRzer+GSEaHvBz+wfGA
        tRViFUZE+/1DuVDjvx4JOriqVmg4XyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677497966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVS14n0GDTqfvhRA+DP8X9hCVpdLZuTQ0R/ZHuFyhHk=;
        b=iIiM1+yCY3dv21mDMtCWRBzWY2xBiCqOKRsOmmehFtO2idcscrGzhzOISjySgjDwXpNrwd
        J6xeyFSdtAiw7NCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AFEF13912;
        Mon, 27 Feb 2023 11:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TezkIW6W/GM4IQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 11:39:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 178C0A06F2; Mon, 27 Feb 2023 12:39:26 +0100 (CET)
Date:   Mon, 27 Feb 2023 12:39:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <20230227113926.jr7wuhmiul7346as@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
 <20230215045952.GF2825702@dread.disaster.area>
 <Y+x6oQkLex8PbfgL@infradead.org>
 <20230216123316.vkmtucazg33vidzg@quack3>
 <Y/MRqLbA2g7I0xgp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/MRqLbA2g7I0xgp@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 19-02-23 22:22:32, Christoph Hellwig wrote:
> On Thu, Feb 16, 2023 at 01:33:16PM +0100, Jan Kara wrote:
> > I'm a bit skeptical we can reasonably assess that (as much as I would love
> > to just not write these pages and be done with it) because a lot of
> > FOLL_LONGTERM users just pin passed userspace address range, then allow
> > userspace to manipulate it with other operations, and finally unpin it with
> > another call. Who knows whether shared pagecache pages are passed in and
> > what userspace is doing with them while they are pinned? 
> 
> True.
> 
> So what other sensible thing could we do at a higher level?
> 
> Treat MAP_SHARED buffers that are long term registered as MAP_PRIVATE
> while registered, and just do writeback using in-kernel O_DIRECT on
> fsync?

Do you mean to copy these pages on fsync(2) to newly allocated buffer and
then submit it via direct IO? That looks sensible to me. We could then make
writeback path just completely ignore these long term pinned pages and just
add this copying logic into filemap_fdatawrite() or something like that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
