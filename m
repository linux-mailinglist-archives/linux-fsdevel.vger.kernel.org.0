Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E946718DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjARKYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjARKWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:22:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7DA793D;
        Wed, 18 Jan 2023 01:28:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D114C3EC2F;
        Wed, 18 Jan 2023 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674034094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUsADbHHhbF3+iRirD38aung5TJEhF+NitEiQGxyElk=;
        b=WtBb5x68i+kgdj5rIe9oOMm3j2eFxHYFTKUce3+sSYZ+e05OKTheZ0sYDkj5WVP4Hwe/8K
        QAcieeizwYHpiP2a0INYRKv2PhqYrFheMTCsNFEDwdUSBYcWvQuJL/U03Xi9USxGvFRZwH
        3KKgeJxjavOZ7ZwU7w4JczgqVqElM5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674034094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUsADbHHhbF3+iRirD38aung5TJEhF+NitEiQGxyElk=;
        b=Fs8/sMuj8JJZsofEJTyRfdehftt6tZAP6OMz7klPmw9kb9C2wkDTvnpWKM+dUWaIC03mf8
        PpZ+6ivzv8lhBhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70469139D2;
        Wed, 18 Jan 2023 09:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jj1kG667x2MMOAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 18 Jan 2023 09:28:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F58DA06B2; Wed, 18 Jan 2023 10:28:12 +0100 (CET)
Date:   Wed, 18 Jan 2023 10:28:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
        p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC v3 03/24] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230118092812.2gl3cde6mocbngli@quack3>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-4-mcgrof@kernel.org>
 <Y8dYpOyR/jOsO267@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8dYpOyR/jOsO267@magnolia>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-01-23 18:25:40, Darrick J. Wong wrote:
> [add linux-xfs to cc on this one]
> 
> On Fri, Jan 13, 2023 at 04:33:48PM -0800, Luis Chamberlain wrote:
> > Userspace can initiate a freeze call using ioctls. If the kernel decides
> > to freeze a filesystem later it must be able to distinguish if userspace
> > had initiated the freeze, so that it does not unfreeze it later
> > automatically on resume.
> 
> Hm.  Zooming out a bit here, I want to think about how kernel freezes
> should behave...
> 
> > Likewise if the kernel is initiating a freeze on its own it should *not*
> > fail to freeze a filesystem if a user had already frozen it on our behalf.
> 
> ...because kernel freezes can absorb an existing userspace freeze.  Does
> that mean that userspace should be prevented from undoing a kernel
> freeze?  Even in that absorption case?
> 
> Also, should we permit multiple kernel freezes of the same fs at the
> same time?  And if we do allow that, would they nest like freeze used to
> do?
> 
> (My suggestions here are 'yes', 'yes', and '**** no'.)

Yeah, makes sense to me. So I think the mental model to make things safe
is that there are two flags - frozen_by_user, frozen_by_kernel - and the
superblock is kept frozen as long as either of these is set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
