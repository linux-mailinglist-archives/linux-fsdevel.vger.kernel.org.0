Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE26D7A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 13:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbjDELES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbjDELEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:04:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F02691
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 04:04:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C08362065A;
        Wed,  5 Apr 2023 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680692648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmHkOWmWhOHTZTTCd0u2ToA8BmSfOcNQfCli10b6Z0M=;
        b=RdFyvhutzFzcOMEGCctT+IsMUhB3T1n0nyhFtmkZJDYGyUE6/SAsO/2VBNH9PKMV77E+0j
        7ueXmNafykcoRF3zAIIMMK/0RRZCGmoDIpeIXed7li1EFPizwBuNC1BMYW6M0UAwODZv3x
        XezmHIazOn1H7NwE+GPDtIBth4+7hnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680692648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmHkOWmWhOHTZTTCd0u2ToA8BmSfOcNQfCli10b6Z0M=;
        b=c4XKQ2pSeCTVW48CnHH26ywWCxnyAQ30+KMSvf3jjOAd7SAjrX/OFC6qXSe1esJvoOAyGY
        VqmMXqvUFwvRE1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B335413A10;
        Wed,  5 Apr 2023 11:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /W+gK6hVLWRqFwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Apr 2023 11:04:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 48121A0729; Wed,  5 Apr 2023 13:04:08 +0200 (CEST)
Date:   Wed, 5 Apr 2023 13:04:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Message-ID: <20230405110408.dvbxnvpubowwih7n@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-5-cem@kernel.org>
 <4sn9HjMu80MnoBrnTf2T-G0QFQc9QOwiM7e6ahvv7dZ0N6lpoMY-NTul3DgbNZF08r69V6BuAQI1QcdSzdAFKQ==@protonmail.internalid>
 <20230404123442.kettrnpmumpzc2da@quack3>
 <20230404134836.blwy3mfhl3n2bfyj@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134836.blwy3mfhl3n2bfyj@andromeda>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Carlos!

On Tue 04-04-23 15:48:36, Carlos Maiolino wrote:
> > > +	if (!dquot->dq_dqb.dqb_bhardlimit &&
> > > +	    !dquot->dq_dqb.dqb_bsoftlimit &&
> > > +	    !dquot->dq_dqb.dqb_ihardlimit &&
> > > +	    !dquot->dq_dqb.dqb_isoftlimit)
> > > +		set_bit(DQ_FAKE_B, &dquot->dq_flags);
> > > +	spin_unlock(&dquot->dq_dqb_lock);
> > > +
> > > +	/* Make sure flags update is visible after dquot has been filled */
> > > +	smp_mb__before_atomic();
> > > +	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
> > 
> > I'm slightly wondering whether we shouldn't have a dquot_mark_active()
> > helper for this to hide the barrier details...
> 
> This sounds good to me, would be ok for you if I simply add this to my todo
> list, and do it once this series is merged? I'd rather avoid to add more patches
> to the series now adding more review overhead.
> I can send a new patch later creating a new helper and replacing all
> set_bit(DQ_ACTIVE_B, ...) calls with the new helper.

Yes, sounds fine to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
