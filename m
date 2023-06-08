Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD3727ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjFHJLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjFHJLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:11:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D40E7;
        Thu,  8 Jun 2023 02:11:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E7AB21A0C;
        Thu,  8 Jun 2023 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686215491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Od9uQp8BPquVZWVULhzN4uIvhtmuiD3iT/Esw6XDZfE=;
        b=zI/R2a7qogDApLYGMtJPQPsAFnhtCjWN36ew59aELXtTTukycHqmVhEI/O+N7Em0YLW6yL
        tXNQH19K+VT3iSoUb6dFMVDP1kRqek2NS1qcyjAIryR72QSnnqITI6HaGOB3KuVdWBJTbA
        3m1wkJmzDt/ZvYggvusEW1Q4eMauE8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686215491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Od9uQp8BPquVZWVULhzN4uIvhtmuiD3iT/Esw6XDZfE=;
        b=aQS/z1F/B0PhcL7Le5/KreM7Fiaot+tUlAF4L1yNx5rf3nvK1niRiGlng+olEpfqtK6P/8
        ZqjVRLD0SVJKEfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A5F713480;
        Thu,  8 Jun 2023 09:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oIvpGUObgWSsZgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Jun 2023 09:11:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0210BA0749; Thu,  8 Jun 2023 11:11:30 +0200 (CEST)
Date:   Thu, 8 Jun 2023 11:11:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jikos@kernel.org, bvanassche@acm.org,
        ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230608091130.bthttzsmdeeiagof@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <ZIFnID9ZNpd7zrNa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFnID9ZNpd7zrNa@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-06-23 22:29:04, Christoph Hellwig wrote:
> On Thu, May 25, 2023 at 04:14:30PM +0200, Jan Kara wrote:
> > Yes, this is exactly how I'd imagine it. Thanks for writing the patch!
> > 
> > I'd just note that this would need rebasing on top of Luis' patches 1 and
> > 2. Also:
> 
> I'd not do that for now.  1 needs a lot more work, and 2 seems rather
> questionable.

OK, I agree the wrappers could be confusing (they didn't confuse me but
when you spelled it out, I agree).

> > Now the only remaining issue with the code is that the two different
> > holders can be attempting to freeze the filesystem at once and in that case
> > one of them has to wait for the other one instead of returning -EBUSY as
> > would happen currently. This can happen because we temporarily drop
> > s_umount in freeze_super() due to lock ordering issues. I think we could
> > do something like:
> > 
> > 	if (!sb_unfrozen(sb)) {
> > 		up_write(&sb->s_umount);
> > 		wait_var_event(&sb->s_writers.frozen,
> > 			       sb_unfrozen(sb) || sb_frozen(sb));
> > 		down_write(&sb->s_umount);
> > 		goto retry;
> > 	}
> > 
> > and then sprinkle wake_up_var(&sb->s_writers.frozen) at appropriate places
> > in freeze_super().
> 
> Let's do that separately as a follow on..

Well, we need to somehow settle on how to deal with a race when both kernel
& userspace race to freeze the filesystem and make the result consistent
with the situation when the fs is already frozen by someone.

> > BTW, when reading this code, I've spotted attached cleanup opportunity but
> > I'll queue that separately so that is JFYI.
> > 
> > > +#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
> > > +#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */
> > 
> > Why not start from 1U << 0? And bonus points for using BIT() macro :).
> 
> BIT() is a nasty thing and actually makes code harder to read. And it
> doesn't interact very well with the __bitwise annotation that might
> actually be useful here.

OK. I'm not too hung up on BIT() macro.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
