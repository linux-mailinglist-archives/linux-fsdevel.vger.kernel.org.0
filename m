Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB38716211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjE3NfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjE3NfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 09:35:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0939C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 06:35:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FFD921AC0;
        Tue, 30 May 2023 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685453700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wPq3IxPQgBipdqiivSafkMOXcbmOsPsYzEKYXGeITi8=;
        b=CFettYO1+nIlcYyil0z4q+Kk+DBKjQdlGroWJq0YOzyTsszsixPS/EuKlXYrU/FE/XL8gU
        UqFux3o0J2BQtwJm4q/r0rPyyOrAyvSBsNlVz8odKEmIqcdDytGaadtQP4Vj+gF88FVfEk
        WWa/1YN0KUqBWYxquiCmh+nGsWVxS2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685453700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wPq3IxPQgBipdqiivSafkMOXcbmOsPsYzEKYXGeITi8=;
        b=h9mJrcgBXi4xqGDHH1PBSU/O4vYpHvnsbCxlRN9X4aGhtd7IC1reLgcDcWAL8fPa1QSvqe
        x2l5RmBA15bXPsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64D5D13597;
        Tue, 30 May 2023 13:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uXSSGIT7dWRuRQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 13:35:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0068FA0754; Tue, 30 May 2023 15:34:59 +0200 (CEST)
Date:   Tue, 30 May 2023 15:34:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] fs: Drop wait_unfrozen wait queue
Message-ID: <20230530133459.auuiqnbcmdv6srhf@quack3>
References: <20230525141710.7595-1-jack@suse.cz>
 <20230525-vorenthalten-drama-aafc614c20df@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525-vorenthalten-drama-aafc614c20df@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-05-23 20:16:04, Christian Brauner wrote:
> On Thu, May 25, 2023 at 04:17:10PM +0200, Jan Kara wrote:
> > wait_unfrozen waitqueue is used only in quota code to wait for
> > filesystem to become unfrozen. In that place we can just use
> > sb_start_write() - sb_end_write() pair to achieve the same. So just
> > remove the waitqueue.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> Removing code. I'm all here for it...
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> >  fs/quota/quota.c   | 5 +++--
> >  fs/super.c         | 4 ----
> >  include/linux/fs.h | 1 -
> >  3 files changed, 3 insertions(+), 7 deletions(-)
> > 
> > Guys, I can merge this cleanup through my tree since I don't expect any
> > conflicts and the generic part is pure removal of unused code.
> 
> There'll likely be another set of fixes I'll take next week but I
> honestly don't care. But seems that this isn't really urgent so why not
> just wait for the merge window?

Sure, I'll queue the patch for the next merge window. Thanks for review!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
