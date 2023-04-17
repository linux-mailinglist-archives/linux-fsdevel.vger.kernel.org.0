Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755496E411F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDQHfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 03:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDQHer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:34:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012359FA;
        Mon, 17 Apr 2023 00:33:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D30351F381;
        Mon, 17 Apr 2023 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681716775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1axJXJTrCrdB9QZslQSPdRgRQtIBzg09tPZ/jwDGYD8=;
        b=BQhQP/NiwLQ9VGUs/EI3MGuR40+QJo7BhDJ/ViTDuayUDtr1vC51NRBklIh+URgtO5O5CQ
        rO023UDu/XRwZB1p4OHjqs756loDhkv2cuebSdLoOQX8J7ULkY+YXgSdBP/BQOe1WqNrPP
        2DtVFNW+98vffHwjuwo13LWxGWVc2LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681716775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1axJXJTrCrdB9QZslQSPdRgRQtIBzg09tPZ/jwDGYD8=;
        b=6LoPigRWInhHVaw1fJVtkTSzfqk9Jg9DmuST6Zmt2yFvGm6nD0DqOdqHLbKj6V6hPfQY0m
        WxP1xKQ47K3PktAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B51A11390E;
        Mon, 17 Apr 2023 07:32:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CWU0LCf2PGTjIgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 07:32:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F241A0744; Mon, 17 Apr 2023 09:32:55 +0200 (CEST)
Date:   Mon, 17 Apr 2023 09:32:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock
 implementation
Message-ID: <20230417073255.kzauk5qwu5bjcsmh@quack3>
References: <20230414142053.gvekvcgxmkjfeht7@quack3>
 <871qkmzgdl.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qkmzgdl.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-04-23 19:59:42, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Fri 14-04-23 06:12:00, Christoph Hellwig wrote:
> >> On Fri, Apr 14, 2023 at 02:51:48PM +0200, Jan Kara wrote:
> >> > On Thu 13-04-23 22:59:24, Christoph Hellwig wrote:
> >> > > Still no fan of the naming and placement here.  This is specific
> >> > > to the fs/buffer.c infrastructure.
> >> >
> >> > I'm fine with moving generic_file_fsync() & friends to fs/buffer.c and
> >> > creating the new function there if it makes you happier. But I think
> >> > function names should be consistent (hence the new function would be named
> >> > __generic_file_fsync_nolock()). I agree the name is not ideal and would use
> >> > cleanup (along with transitioning everybody to not take i_rwsem) but I
> >> > don't want to complicate this series by touching 13+ callsites of
> >> > generic_file_fsync() and __generic_file_fsync(). That's for a separate
> >> > series.
> >>
> >> I would not change the existing function.  Just do the right thing for
> >> the new helper and slowly migrate over without complicating this series.
> >
> > OK, I can live with that temporary naming inconsistency I guess. So
> > the function will be __buffer_file_fsync()?
> 
> This name was suggested before, so if that's ok I will go with this -
> "generic_buffer_fsync()". It's definition will lie in fs/buffer.c and
> it's declaration in include/linux/buffer_head.h
> 
> Is that ok?

Yes, that is fine by me. And I suppose this variant will also issue the
cache flush, won't it? But then we also need __generic_buffer_fsync()
without issuing the cache flush for ext4 (we need to sync parent before
issuing a cache flush) and FAT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
