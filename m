Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A44C11F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 12:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiBWLxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 06:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiBWLxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:53:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3E57B1A;
        Wed, 23 Feb 2022 03:53:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 40A3F1F43D;
        Wed, 23 Feb 2022 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645617199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHKLDcXaApTqsl2KQS4V+/Sm+LIozq5sgKx8GXifXUE=;
        b=egv/jm8RvovquqsfWcuJRwBtKBVUu7OVZoV08A97BI/bojJrZKRGrPOawsaSoFdwUgRrJ1
        Y8yOK1HZXCJlxhkg+3ItPW4f4Y7L7OGxC1fDYlJbmwORfiSY2i+owYRWiMkGiTWKBIJNSz
        GYOIjG7+B3d4gYXjP41jiRgKBHjUWo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645617199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHKLDcXaApTqsl2KQS4V+/Sm+LIozq5sgKx8GXifXUE=;
        b=DjQTeQ5j1zEB52lzsMsHmvZJjvTFizTsSZHs11jPamrSA1NDxfM+1XbJwJl372CHKtWIq6
        AgOLK5j3rK2xnAAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 308D7A3B81;
        Wed, 23 Feb 2022 11:53:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67980A0605; Wed, 23 Feb 2022 12:53:13 +0100 (CET)
Date:   Wed, 23 Feb 2022 12:53:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/9] ext4: Add couple of more fast_commit tracepoints
Message-ID: <20220223115313.3s73bu7p454bodvl@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <90608d31b7ad8500c33d875d3a7fa50e3456dc1a.1645558375.git.riteshh@linux.ibm.com>
 <20220223094057.53zcovnazrqwbngw@quack3.lan>
 <20220223101159.ekwbylvbmec5v35q@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223101159.ekwbylvbmec5v35q@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 15:41:59, Ritesh Harjani wrote:
> On 22/02/23 10:40AM, Jan Kara wrote:
> > On Wed 23-02-22 02:04:11, Ritesh Harjani wrote:
> > > This adds two more tracepoints for ext4_fc_track_template() &
> > > ext4_fc_cleanup() which are helpful in debugging some fast_commit issues.
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> >
> > So why is this more useful than trace_ext4_fc_track_range() and other
> > tracepoints? I don't think it provides any more information? What am I
> > missing?
> 
> Thanks Jan for all the reviews.
> 
> So ext4_fc_track_template() adds almost all required information
> (including the caller info) in this one trace point along with transaction tid
> which is useful for tracking issue similar to what is mentioned in Patch-9.
> 
> (race with if inode is part of two transactions tid where jbd2 full commit
> may begin for txn n-1 while inode is still in sbi->s_fc_q[MAIN])
 
I understand commit tid is interesting but cannot we just add it to
tracepoints like trace_ext4_fc_track_range() directly? It would seem useful
to have it there and when it is there, the need for
ext4_fc_track_template() is not really big. I don't care too much but
this tracepoint looked a bit superfluous to me.

> And similarly ext4_fc_cleanup() helps with that information about which tid
> completed and whether it was called from jbd2 full commit or from fast_commit.

Yeah, that one is clear.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
