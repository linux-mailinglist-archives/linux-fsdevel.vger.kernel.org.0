Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6271C635AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 11:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiKWK5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 05:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiKWK4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:56:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31547D08A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 02:49:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 969AA1F88C;
        Wed, 23 Nov 2022 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669200560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GiGwSjWmDF9S+XtM1PwDRmMp71ERc9BBxlgRScjQKY=;
        b=S2DGuyR9C+be9sI5ag/Q2/owpNM4sMp+E5Z3jty3Jbv3qWVVmW2pV7Mm1kL5Zt6dnFrTus
        dpD4WC5+XgvMmaQRpHOm4G/rDCHY9+S/eik6pUnCym2cUP+YyGbA4KQaf+86QYSsU+C1qo
        J5gaBeWEq6rzIw2NjF5idLPuxaXbAU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669200560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GiGwSjWmDF9S+XtM1PwDRmMp71ERc9BBxlgRScjQKY=;
        b=FzRg7DDmxsthdxx7PT806oWntqMb54IDGB/60oTlCtZtWE6kg/HpFP4oHMN9O86y6ZuJtl
        OKG2jAvH2moolWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 887CD13A37;
        Wed, 23 Nov 2022 10:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aXZLIbD6fWPINgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Nov 2022 10:49:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 205FBA0709; Wed, 23 Nov 2022 11:49:20 +0100 (CET)
Date:   Wed, 23 Nov 2022 11:49:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221123104920.g72y2ny533p2eo7w@quack3>
References: <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3>
 <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3>
 <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3>
 <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3>
 <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
 <CAOQ4uxiuyYdN9PK4XN+Vd7+XO56OcW_GrSU-U62srxLGQbx3JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiuyYdN9PK4XN+Vd7+XO56OcW_GrSU-U62srxLGQbx3JQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-11-22 14:38:51, Amir Goldstein wrote:
> > > > > The checkpoint would then do:
> > > > > start gathering changes for both T and T+1
> > > > > clear ignore marks
> > > > > synchronize_srcu()
> > > > > stop gathering changes for T and report them
> > > > >
> > > > > And in this case we would not need POST_WRITE as an event.
> > > > >
> > > >
> > > > Why then give up on the POST_WRITE events idea?
> > > > Don't you think it could work?
> > >
> > > So as we are discussing, the POST_WRITE event is not useful when we want to
> > > handle crash safety. And if we have some other mechanism (like SRCU) which
> > > is able to guarantee crash safety, then what is the benefit of POST_WRITE?
> > > I'm not against POST_WRITE, I just don't see much value in it if we have
> > > another mechanism to deal with events straddling checkpoint.
> > >
> >
> > Not sure I follow.
> >
> > I think that crash safety can be achieved also with PRE/POST_WRITE:
> > - PRE_WRITE records an intent to write in persistent snapshot T
> >   and add to in-memory map of in-progress writes of period T
> > - When "checkpoint T" starts, new PRE_WRITES are recorded in both
> >   T and T+1 persistent snapshots, but event is added only to
> >   in-memory map of in-progress writes of period T+1
> > - "checkpoint T" ends when all in-progress writes of T are completed
> >
> > The trick with alternating snapshots "handover" is this
> > (perhaps I never explained it and I need to elaborate on the wiki [1]):
> >
> > [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Modified_files_query
> >
> > The changed files query results need to include recorded changes in both
> > "finalizing" snapshot T and the new snapshot T+1 that was started in
> > the beginning of the query.
> >
> > Snapshot T MUST NOT be discarded until checkpoint/handover
> > is complete AND the query results that contain changes recorded
> > in T and T+1 snapshots have been consumed.
> >
> > When the consumer ACKs that the query results have been safely stored
> > or acted upon (I called this operation "bless" snapshot T+1) then and
> > only then can snapshot T be discarded.
> >
> > After snapshot T is discarded a new query will start snapshot T+2.
> > A changed files query result includes the id of the last blessed snapshot.
> >
> > I think this is more or less equivalent to the SRCU that you suggested,
> > but all the work is done in userspace at application level.
> >
> > If you see any problem with this scheme or don't understand it
> > please let me know and I will try to explain better.
> >
> 
> Hmm I guess "crash safety" is not well defined.
> You and I were talking about "system crash" and indeed, this was
> my only concern with kernel implementation of overlayfs watch.
> 
> But with userspace HSM service, how can we guarantee that
> modifications did not happen while the service is down?
> 
> I don't really have a good answer for this.

Very good point!
 
> Thinking out loud, we would somehow need to make the default
> permission deny for all modifications, maybe through some mount
> property (e.g. MOUNT_ATTR_PROT_READ), causing the pre-write
> hooks to default to EROFS if there is no "vfs filter" mount mark.
> 
> Then it will be possible to expose a "safe" mount to users, where
> modifications can never go unnoticed even when HSM service
> crashes.

Yeah, something like this. Although the bootstrap of this during mount may
be a bit challenging. But maybe not.

Also I'm thinking about other usecases - for HSM I agree we essentially
need to take the FS down if the userspace counterpart is not working. What
about other persistent change log usecases? Do we mandate that there is
only one "persistent change log" daemon in the system (or per filesystem?)
and that must be running or we take the filesystem down? And anybody who
wants reliable notifications needs to consume service of this daemon?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
