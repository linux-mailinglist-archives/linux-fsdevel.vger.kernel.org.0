Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B26E257E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDNOVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNOU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:20:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1AD3A84;
        Fri, 14 Apr 2023 07:20:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B82D1FD9D;
        Fri, 14 Apr 2023 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681482053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZkdt1gYLF7v3yMr48JgLmFQRizKTdgKhTurZyh+1ng=;
        b=vda8SM4e21JGahk64/0RzIKft+1YjY8j8i6coNntqQFTvwplaj8Cl1M0+bZTgYqeCDrRk7
        j3YJlWA2ynG7RCfb4dVY92yHbw0dF4MO3RCHFCfAn+El8na85/17QHIsg7TMOP1d3cIl4z
        qpcRBD16NOz4uynvKqurcODFXpfbbPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681482053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZkdt1gYLF7v3yMr48JgLmFQRizKTdgKhTurZyh+1ng=;
        b=Foqn863JnmLcwegMHkGCaWS9wRAJbInPzyqIR+3SmPOAprYqFwCgffLw7lMIpkT/vGAeCj
        FRxxDC+UovqpK5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AF9513498;
        Fri, 14 Apr 2023 14:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nkbmIUVhOWR2IwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Apr 2023 14:20:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19D28A0732; Fri, 14 Apr 2023 16:20:53 +0200 (CEST)
Date:   Fri, 14 Apr 2023 16:20:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock
 implementation
Message-ID: <20230414142053.gvekvcgxmkjfeht7@quack3>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <e65768eb0fe145c803ba4afdc869a1757d51d758.1681365596.git.ritesh.list@gmail.com>
 <ZDjrvCbCwxN+mRUS@infradead.org>
 <20230414125148.du7r6ljdyzckoysh@quack3>
 <ZDlRIEiEm+CRDJxG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDlRIEiEm+CRDJxG@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-04-23 06:12:00, Christoph Hellwig wrote:
> On Fri, Apr 14, 2023 at 02:51:48PM +0200, Jan Kara wrote:
> > On Thu 13-04-23 22:59:24, Christoph Hellwig wrote:
> > > Still no fan of the naming and placement here.  This is specific
> > > to the fs/buffer.c infrastructure.
> > 
> > I'm fine with moving generic_file_fsync() & friends to fs/buffer.c and
> > creating the new function there if it makes you happier. But I think
> > function names should be consistent (hence the new function would be named
> > __generic_file_fsync_nolock()). I agree the name is not ideal and would use
> > cleanup (along with transitioning everybody to not take i_rwsem) but I
> > don't want to complicate this series by touching 13+ callsites of
> > generic_file_fsync() and __generic_file_fsync(). That's for a separate
> > series.
> 
> I would not change the existing function.  Just do the right thing for
> the new helper and slowly migrate over without complicating this series.

OK, I can live with that temporary naming inconsistency I guess. So
the function will be __buffer_file_fsync()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
