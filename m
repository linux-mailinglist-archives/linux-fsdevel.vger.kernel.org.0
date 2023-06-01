Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358B67197F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjFAJ6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjFAJ6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:58:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C88FC;
        Thu,  1 Jun 2023 02:58:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50ECD2195F;
        Thu,  1 Jun 2023 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685613514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDsyFBeXQbC/1D222Hf6R8KVGa7uZdAOGxoAw0743Nc=;
        b=1qJz0f0jfps3GDUrMZXnpklVnuUt1kk9y32Imzhc93nObTo5JrDGyENX+0eUuJJvJtlNy6
        6is+zhz3I7pZYPt/0gGYxck7diLCMW8OkoGqHE9mPRTZOZ8sLKM4N+DqprE77A0o2/dpux
        NZoKGBrhWc0yEmmtgkqFy6r1h1Vbv6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685613514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDsyFBeXQbC/1D222Hf6R8KVGa7uZdAOGxoAw0743Nc=;
        b=FawsNXR1x8fq6cFZ0sd9ja08hccc5PB/xO4OtRBX2nmVJCjFS6DeLj+Vvx933NircztxPP
        YRNxEE/v/ZDNYvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4121E139B7;
        Thu,  1 Jun 2023 09:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v4DLD8preGT0NgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 09:58:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CA6D2A0754; Thu,  1 Jun 2023 11:58:33 +0200 (CEST)
Date:   Thu, 1 Jun 2023 11:58:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] block: refactor bd_may_claim
Message-ID: <20230601095833.xd65rrzfkhkxuf6s@quack3>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-3-hch@lst.de>
 <20230530114148.zobtxdurit24pqev@quack3>
 <20230601081105.GA31903@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601081105.GA31903@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-06-23 10:11:05, Christoph Hellwig wrote:
> On Tue, May 30, 2023 at 01:41:48PM +0200, Jan Kara wrote:
> > > +	if (bdev->bd_holder) {
> > > +		/*
> > > +		 * The same holder can always re-claim.
> > > +		 */
> > > +		if (bdev->bd_holder == holder)
> > > +			return true;
> > > +		return false;
> > 
> > With this simple condition I'd just do:
> > 		/* The same holder can always re-claim. */
> > 		return bdev->bd_holder == holder;
> 
> As of this patch this makes sense, and I did in fact did it that
> way first.  But once we start checking the holder ops we need
> the eplcicit conditional, so I decided to start out with this more
> verbose option to avoid churn later.

Ah, OK.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
