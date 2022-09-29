Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59BB5EF2ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiI2KBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiI2KBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:01:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CDF1182D
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 03:01:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2620221E12;
        Thu, 29 Sep 2022 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664445706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gI13/DIVt7/qVIsgrGWwpkXLKynGB3x5b9M+XDGmJNw=;
        b=0UhesytFAXk5c8JkzS5WURb8cfn/+utf0ItHRIxCapxpY+KSG5REmxPGhMCkIdLA5KFd1o
        TZA9TO4FY4yo52/KRQHd8mHLX3SX6JKnobGIMdIw5oIoZrSyzRRKzypuKR+BYYqhNy+iKr
        JzpdQGJOkNW4HG7hUEzQbtALksRtJJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664445706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gI13/DIVt7/qVIsgrGWwpkXLKynGB3x5b9M+XDGmJNw=;
        b=ayf+o+E3CaAFYVbGfxcJ8SxyM2iF1dMrlnr8cRFBC3puLGS4gud6oG8FVLb1Ef26b2cZCF
        hZjDNgEgHavw2RBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A37D13A71;
        Thu, 29 Sep 2022 10:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7I/ZAQptNWPBRgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 10:01:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 64011A0681; Thu, 29 Sep 2022 12:01:45 +0200 (CEST)
Date:   Thu, 29 Sep 2022 12:01:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Fufu Fang <fangfufu2003@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220929100145.wruxmbwapjn6dapy@quack3>
References: <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3>
 <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3>
 <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-09-22 15:29:13, Amir Goldstein wrote:
> On Mon, Sep 26, 2022 at 6:27 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 22-09-22 16:03:41, Amir Goldstein wrote:
> > > On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Tue 20-09-22 21:19:25, Amir Goldstein wrote:
> > > > > For the next steps of POC, I could do:
> > > > > - Report FAN_ACCESS_PERM range info to implement random read
> > > > >   patterns (e.g. unzip -l)
> > > > > - Introduce FAN_MODIFY_PERM, so file content could be downloaded
> > > > >   before modifying a read-write HSM cache
> > > > > - Demo conversion of a read-write FUSE HSM implementation
> > > > >   (e.g. https://github.com/volga629/davfs2)
> > > > > - Demo HSM with filesystem mark [*] and a hardcoded test filter
> > > > >
> > > > > [*] Note that unlike the case with recursive inotify, this POC HSM
> > > > > implementation is not racy, because of the lookup permission events.
> > > > > A filesystem mark is still needed to avoid pinning all the unpopulated
> > > > > cache tree leaf entries to inode cache, so that this HSM could work on
> > > > > a very large scale tree, the same as my original use case for implementing
> > > > > filesystem mark.
> > > >
> > > > Sounds good! Just with your concern about pinning - can't you use evictable
> > > > marks added on lookup for files / dirs you want to track? Maybe it isn't
> > > > great design for other reasons but it would save you some event
> > > > filtering...
> > > >
> > >
> > > With the current POC, there is no trigger to re-establish the evicted mark,
> > > because the parent is already populated and has no mark.
> >
> > So my original thinking was that you'd place FAN_LOOKUP_PERM mark on top of
> > the directory tree and then you'd add evictable marks to all the subdirs
> > that are looked up from the FAN_LOOKUP_PERM event handler. That way I'd
> > imagine you can place evictable marks on all directories that are used in a
> > race-free manner.
> >
> 
> Maybe I am missing something.
> I don't see how that can scale up to provide penalty free fast path lookup
> for fully populated subtrees.

No, you are right that this scheme would have non-trivial overhead in
processing the lookup events even when the tree is fully populated.

> > > A hook on instantiate of inode in inode cache could fill that gap.
> > > It could still be useful to filter FAN_INSTANTIATE_PERM events in the
> > > kernel but it is not a must because instantiate is more rare than (say) lookup
> > > and then the fast lookup path (RCU walk) on populated trees suffers almost
> > > no overhead when the filesystem is watched.
> > >
> > > Please think about this and let me know if you think that this is a direction
> > > worth pursuing, now, or as a later optimization.
> >
> > I think an event on instantiate seems to be depending too much on kernel
> > internals instead of obvious filesystem operations. Also it might be a bit
> > challenging during startup when you don't know what is cached and what not
> > so you cannot rely on instantiate events for placing marks. So I'd leave
> > this for future optimization.
> >
> 
> Perhaps a user FAN_INSTANTIATE_PERM is too much, but I was
> trying to figure out a way to make automatic inode marks work.
> If we can define reasonable use cases for automatic inode marks that
> kernel can implement (e.g. inheriting from parent on dentry instantiate)
> then this could possibly get us something useful.
> Maybe that is what you meant with the suggestion above?

Well, my suggestion was pondering if we can implement something like
automatic inode marks in userspace using FAN_LOOKUP_PERM event. But you are
right the overhead in the fast path does not make this very attractive. So
we'll have to look more into the in-kernel solution.

> The other use case of automatic inode marks I was thinking about,
> which are even more relevant for $SUBJECT is this:
> When instantiating a dentry with an inode that has xattr
> "security.fanotify.mask" (a.k.a. persistent inode mark), an inode
> mark could be auto created and attached to a group with a special sb
> mark (we can limit a single special mark per sb).
> This could be implemented similar to get_acl(), where i_fsnotify_mask
> is always initialized with a special value (i.e. FS_UNINITIALIZED)
> which is set to either 0 or non-zero if "security.fanotify.mask" exists.
> 
> The details of how such an API would look like are very unclear to me,
> so I will try to focus on the recursive auto inode mark idea.

Yeah, although initializing fanotify marks based on xattrs does not look
completely crazy I can see a lot of open questions there so I think
automatic inode mark idea has more chances for success at this point :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
