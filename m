Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7554B635C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 13:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiKWMMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 07:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiKWMLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:11:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E2BF61
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:11:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E35D21BE8;
        Wed, 23 Nov 2022 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669205511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IheVXzhygUIT+OQDY0Y8ya9dI9l2cA+FuipdHUdaVuM=;
        b=ApNlTsfzcdVwUWIElkaFNMSaK04Yt5fPWQbl2Bd3eMmUoPSelT5C9nLvQVO13RlEkruCvp
        YqI3BqMHCQmqP2XSvGhAwjaWKpy+jrLPdiCoLxOfhGfHSmQQ1pjzyUWjfuUFnRUAjNI3GU
        tKubTWg7Qhr9chvb5uGzl4dw8wVmGgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669205511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IheVXzhygUIT+OQDY0Y8ya9dI9l2cA+FuipdHUdaVuM=;
        b=VOsvAGt9TUT4m5xU/ankl04U+t9mzyi30w3ngRPQnwcruFCKMCelxW/StjS3nYO/B68Xw9
        2QaTastKO0nuCcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68B3513AE7;
        Wed, 23 Nov 2022 12:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d5jsGAcOfmOrXgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Nov 2022 12:11:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C8E01A0709; Wed, 23 Nov 2022 13:11:50 +0100 (CET)
Date:   Wed, 23 Nov 2022 13:11:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221123121150.chowzv37syhr6dkt@quack3>
References: <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3>
 <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3>
 <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3>
 <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3>
 <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
 <CAOQ4uxi-42EQrE55_km=NYiTiEaiheVZq7WN=6UQ9rrBqg7C+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi-42EQrE55_km=NYiTiEaiheVZq7WN=6UQ9rrBqg7C+w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-11-22 18:40:06, Amir Goldstein wrote:
> On Wed, Nov 16, 2022 at 6:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > > Can't we introduce some SRCU lock / unlock into
> > > > > file_start_write() / file_end_write() and then invoke synchronize_srcu()
> > > > > during checkpoint after removing ignore marks? It will be much cheaper as
> > > > > we don't have to flush all dirty data to disk and also writes can keep
> > > > > flowing while we wait for outstanding writes straddling checkpoint to
> > > > > complete. What do you think?
> > > >
> > > > Maybe, but this is not enough.
> > > > Note that my patches [1] are overlapping fsnotify_mark_srcu with
> > > > file_start_write(), so we would need to overlay fsnotify_mark_srcu
> > > > with this new "modify SRCU".
> > > >
> > > > [1] https://github.com/amir73il/linux/commits/fanotify_pre_content
> > >
> > > Yes, I know that and frankly, that is what I find somewhat ugly :) I'd rather
> > > have the "modify SRCU" cover the whole region we need - which means
> > > including the generation of PRE_MODIFY event.
> > >
> >
> > Yeh, it would be great if we can pull this off.
> 
> OK. I decided to give this a shot, see:
> 
> https://github.com/amir73il/linux/commits/sb_write_barrier
> 
> It is just a sketch to show the idea, very lightly tested.
> What I did is, instead of converting all the sb_start,end_write()
> call sites, which would be a huge change, only callers of
> sb_start,end_write_srcu() participate in the "modify SRCU".
> 
> I then converted all the dir modify call sites and some other
> call sites to use helpers that take SRCU and call pre-modify hooks.
> 
> [...]

I've glanced over the changes and yes, that's what I was imagining :).

> > > > > The technical problem I see is how to deal with AIO / io_uring because
> > > > > SRCU needs to be released in the same context as it is acquired - that
> > > > > would need to be consulted with Paul McKenney if we can make it work. And
> > > > > another problem I see is that it might not be great to have this
> > > > > system-wide as e.g. on networking filesystems or pipes writes can block for
> > > > > really long.
> > > > >
> 
> I averted this problem for now - file data writes are not covered by
> s_write_srcu with my POC branch.

Since you've made the SRCU per sb there is no problem with writes blocking
too long on some filesystems. I've asked RCU guys about the problem with
SRCU being acquired / released from different contexts. Logically, it seems
it should be possible to make this work but maybe I miss some technical
detail.
 
> The rationale is that with file data write, HSM would anyway need to
> use fsfreeze() to get any guarantee, so maybe s_write_srcu is not really
> useful here??
> 
> It might be useful to use s_write_srcu to cover the pre-modify event
> up to after sb_start_write() in file write/aio/io_uring, but not byond it,
> so that sb_write_barrier()+fsfreeze() will provide full coverage for
> in-progress writes.
> 
> Please let me know if this plan sounds reasonable.

Let's see what RCU guys reply. I'd prefer to cover the whole write for
simplicity if it is reasonably possible.

> > > > > Final question is how to expose this to userspace because this
> > > > > functionality would seem useful outside of filesystem notification space so
> > > > > probably do not need to tie it to that.
> 
> In the current POC branch, nothing calls sb_write_barrier() yet.
> I was thinking of using it when flushing marks, maybe with the
> FAN_MARK_SYNC flag that I proposed.

Yes, that's what I'd imagine as well.

> For general purpose API, the semantics would need to be better
> defined, as with this "opt-in" implementation, only some of the
> modification operations are covered by the 'sb write barrier'.

Yes, for now we can keep things internal to fsnotify.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
