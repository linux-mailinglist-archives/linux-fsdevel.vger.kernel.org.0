Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B861847B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiKCQbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKCQa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:30:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBAB1CB1F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 09:30:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F53E219D0;
        Thu,  3 Nov 2022 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667493046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sduwskvy+AGlg8DVBW/Jqpan3GAuTFvJDKrUpmL5xHA=;
        b=nphhkdi+XOkSmGMScDAgpSUGfQOmfLnyz8VooWP+bMBHO3kDCjezTQAmanlhIFcSb7SrvP
        dqL7d2k2S/rYzllOUycjVqYxZAR1Z/7FHM3xNHPgb4G48IrBlaNcQU+J3ZzbJaqEG3Qnx9
        Q8uzqi0IcWtwKR0ntBWV3oMnpzjzQa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667493046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sduwskvy+AGlg8DVBW/Jqpan3GAuTFvJDKrUpmL5xHA=;
        b=pG3SPGRZaUpuomGXS9FgIiOc+qcR8QzCCd+WEUFUCjQRnyYDneLTbvf0xt2u+3q2q/FR3N
        Jp/W4Kdyqmmag/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12B2213480;
        Thu,  3 Nov 2022 16:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jV2DBLbsY2NLRQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Nov 2022 16:30:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 99B62A0700; Thu,  3 Nov 2022 17:30:45 +0100 (CET)
Date:   Thu, 3 Nov 2022 17:30:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221103163045.fzl6netcffk23sxw@quack3>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3>
 <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 28-10-22 15:50:04, Amir Goldstein wrote:
> On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
> >
> > > Questions:
> > > - What do you think about the direction this POC has taken so far?
> > > - Is there anything specific that you would like to see in the POC
> > >   to be convinced that this API will be useful?
> >
> > I think your POC is taking a good direction and your discussion with Dave
> > had made me more confident that this is all workable :). I liked your idea
> > of the wiki (or whatever form of documentation) that summarizes what we've
> > discussed in this thread. That would be actually pretty nice for future
> > reference.
> >
> 
> The current state of POC is that "populate of access" of both files
> and directories is working and "race free evict of file content" is also
> implemented (safely AFAIK).
> 
> The technique involving exclusive write lease is discussed at [1].
> In a nutshell, populate and evict synchronize on atomic i_writecount
> and this technique can be implemented with upstream UAPIs.

Not so much i_writecount AFAIU but the generic lease mechanism overall. But
yes, the currently existing APIs should be enough for your purposes.

> I did use persistent xattr marks for the POC, but this is not a must.
> Evictable inode marks would have worked just as well.

OK.

> Now I have started to work on persistent change tracking.
> For this, I have only kernel code, only lightly tested, but I did not
> prove yet that the technique is working.
> 
> The idea that I started to sketch at [2] is to alternate between two groups.
> 
> When a change is recorded, an evictable ignore mark will be added on the
> object.  To start recording changes from a new point in time
> (checkpoint), a new group will be created (with no ignore marks) and the
> old group will be closed.

So what I dislike about the scheme with handover between two groups is that
it is somewhat complex and furthermore requiring fs freezing for checkpoint
is going to be rather expensive (and may be problematic if persistent
change tracking is used by potentially many unpriviledged applications).

As a side note I think it will be quite useful to be able to request
checkpoint only for a subtree (e.g. some app may be interested only in a
particular subtree) and the scheme with two groups will make any
optimizations to benefit from such fact more difficult - either we create
new group without ignore marks and then have to re-record changes nobody
actually needs or we have to duplicate ignore marks which is potentially
expensive as well.

Let's think about the race:

> To clarify, the race that I am trying to avoid is:
> 1. group B got a pre modify event and recorded the change before time T
> 2. The actual modification is performed after time T
> 3. group A does not get a pre modify event, so does not record the change
>     in the checkpoint since T

AFAIU you are worried about:

Task T				Change journal		App

write(file)
  generate pre_modify event
				record 'file' as modified
							Request changes
							Records 'file' contents
  modify 'file' data

...
							Request changes
							Nothing changed but
App's view of 'file' is obsolete.

Can't we solve this by creating POST_WRITE async event and then use it like:

1) Set state to CHECKPOINT_PENDING
2) In state CHECKPOINT_PENDING we record all received modify events into a
   separate 'transition' stream.
3) Remove ignore marks we need to remove.
4) Switch to new period & clear CHECKPOINT_PENDING, all events are now
   recorded to the new period.
5) Merge all events from 'transition' stream to both old and new period
   event streams.
6) Events get removed from the 'transition' stream only once we receive
   POST_WRITE event corresponding to the PRE_WRITE event recorded there (or
   on crash recovery). This way some events from 'transition' stream may
   get merged to multiple period event streams if the checkpoints are
   frequent and writes take long.

This should avoid the above race, should be relatively lightweight, and
does not require major API extensions.

BTW, while thinking about this I was wondering: How are the applications
using persistent change journal going to deal with buffered vs direct IO? I
currently don't see a scheme that would not loose modifications for some
combinations...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
