Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66F277F887
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351720AbjHQORF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351781AbjHQOQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:16:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B919A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:16:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 362761F37E;
        Thu, 17 Aug 2023 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692281810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OodtyI2RGG5T55PuVr2J9JognnGKpe/J/EdqyEgOU4=;
        b=fs1RrKm6iOAcNm6kDdXxguKDNSwuIEUOjSmjCCECMq1ozUb+0pS5Py9o7WjTHMnV2+BvTU
        OtWrSbdyuUV2a5d1HeQ4rxFhA/vkr8ryent0/NLFKBFSmukqFGGz+9zDG9ulXnMmoP2wAm
        rmny9hZw5uF9+P3/SZvqv4QyP+Nrh1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692281810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OodtyI2RGG5T55PuVr2J9JognnGKpe/J/EdqyEgOU4=;
        b=l3fsKKRySadtQTB7yoyrclicRuNi7tuBzs7KVF4eGmAodT++1ZX66Q0oq4FAvI2CU9q/EX
        hrU4LeLZD1i7SJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 273221358B;
        Thu, 17 Aug 2023 14:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /jaNCdIr3mRYHgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 17 Aug 2023 14:16:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AF893A0769; Thu, 17 Aug 2023 16:16:49 +0200 (CEST)
Date:   Thu, 17 Aug 2023 16:16:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] super: wait for nascent superblocks
Message-ID: <20230817141649.wkpjl72fdmq3772h@quack3>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
 <20230817125021.l6h4ipibfuzd3xdx@quack3>
 <20230817-tortur-wallung-3512b32d8dd5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817-tortur-wallung-3512b32d8dd5@brauner>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-08-23 15:24:54, Christian Brauner wrote:
> On Thu, Aug 17, 2023 at 02:50:21PM +0200, Jan Kara wrote:
> > On Thu 17-08-23 12:47:43, Christian Brauner wrote:
> > > Recent patches experiment with making it possible to allocate a new
> > > superblock before opening the relevant block device. Naturally this has
> > > intricate side-effects that we get to learn about while developing this.
> > > 
> > > Superblock allocators such as sget{_fc}() return with s_umount of the
> > > new superblock held and ock ordering currently requires that block level
> > > locks such as bdev_lock and open_mutex rank above s_umount.
> > > 
> > > Before aca740cecbe5 ("fs: open block device after superblock creation")
> > > ordering was guaranteed to be correct as block devices were opened prior
> > > to superblock allocation and thus s_umount wasn't held. But now s_umount
> > > must be dropped before opening block devices to avoid locking
> > > violations.
> > > 
> > > This has consequences. The main one being that iterators over
> > > @super_blocks and @fs_supers that grab a temporary reference to the
> > > superblock can now also grab s_umount before the caller has managed to
> > > open block devices and called fill_super(). So whereas before such
> > > iterators or concurrent mounts would have simply slept on s_umount until
> > > SB_BORN was set or the superblock was discard due to initalization
> > > failure they can now needlessly spin through sget{_fc}().
> > > 
> > > If the caller is sleeping on bdev_lock or open_mutex one caller waiting
> > > on SB_BORN will always spin somewhere potentially this can go on for
> > 					^^ and potentially?
> > > quite a while.
> > > 
> > > It should be possible to drop s_umount while allowing iterators to wait
> > > on a nascent superblock to either be born or discarded. This patch
> > > implements a wait_var_event() mechanism allowing iterators to sleep
> > > until they are woken when the superblock is born or discarded.
> > > 
> > > This should also allows us to avoid relooping through @fs_supers and
> >        ^^^ superfluous "should"
> > 
> > > @super_blocks if a superblock isn't yet born or dying.
> > > 
> > > Link: aca740cecbe5 ("fs: open block device after superblock creation")
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>

<snip>

> > > @@ -841,15 +942,14 @@ struct super_block *get_active_super(struct block_device *bdev)
> > >  	if (!bdev)
> > >  		return NULL;
> > >  
> > > -restart:
> > >  	spin_lock(&sb_lock);
> > >  	list_for_each_entry(sb, &super_blocks, s_list) {
> > >  		if (hlist_unhashed(&sb->s_instances))
> > >  			continue;
> > >  		if (sb->s_bdev == bdev) {
> > >  			if (!grab_super(sb))
> > > -				goto restart;
> > > -			super_unlock_write(sb);
> > > +				return NULL;
> >   Let me check whether I understand the rationale of this change: We found
> > a matching sb and it's SB_DYING. Instead of waiting for it to die and retry
> > the search (to likely not find anything) we just return NULL right away to
> > save us some trouble.
> 
> Thanks for that question! I was missing something. Before these changes,
> when a superblock was unmounted and it hit deactivate_super() it could do:
> 
> P1                                                      P2
> deactivate_locked_super()                               grab_super()
> -> if (!atomic_add_unless(&s->s_active, -1, 1))
>                                                         -> super_lock_write()
>                                                            SB_BORN && !atomic_inc_add_unless(s->s_active)
>                                                            // fails, loop until it goes away
>    -> super_lock_write()
>       // remove sb from fs_supers

I don't think this can happen as you describe it. deactivate_super() +
deactivate_locked_super() are written in a way so that the last s_active
reference is dropped while sb->s_umount is held for writing. And
grab_super() tries the increment under sb->s_umount as well. So either
grab_super() wins the race and deactivate_locked_super() just drops one
refcount and exits, or deactivate_locked_super() wins the race and
grab_super() can come only after the sb is shutdown. Then the increment
will fail and we'll loop as you describe. Perhaps that's what you meant,
just you've ordered things wrongly...

> That can still happen in the new scheme so my patch needs a fix to wait
> for SB_DYING to be broadcast when no active reference can be acquired
> anymore because then we know that we're about to shut this down. Either
> that or spinning but I think we should just wait as we can now do that
> with my proposal.

... But in that case by the time grab_super() is able to get sb->s_umount
semaphore, SB_DYING is already set.

> > >  {
> > > -	super_lock_read(sb);
> > > -	if (!sb->s_root ||
> > > -	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
> > > +	bool born = super_wait_read(sb);
> > > +
> > > +	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> > >  		super_unlock_read(sb);
> > >  		return false;
> > >  	}
> > > @@ -1572,7 +1674,7 @@ int vfs_get_tree(struct fs_context *fc)
> > >  	 * flag.
> > >  	 */
> > >  	smp_wmb();
> > 
> > Is the barrier still needed here when super_wake() has smp_store_release()?
> 
> I wasn't sure. The barrier tries to ensure that everything before
> SB_BORN is seen by super_cache_count(). Whereas the smp_store_release()
> really is about the flag. Maybe the smp_wmb() would be sufficient for
> that but since I wasn't sure the additional smp_store_release() is way
> more obvious imho.

I was looking into memory-barriers.txt and it has:

(6) RELEASE operations.

     This also acts as a one-way permeable barrier.  It guarantees that all
     memory operations before the RELEASE operation will appear to happen
     before the RELEASE operation with respect to the other components of the
     system.

Which sounds like smp_store_release() of SB_BORN should be enough to make
super_cache_count() see all the stores before it if it sees SB_BORN set...

> > > -	sb->s_flags |= SB_BORN;
> > > +	super_wake(sb, SB_BORN);
> > 
> > I'm also kind of wondering whether when we have SB_BORN and SB_DYING isn't
> > the SB_ACTIVE flag redundant. SB_BORN is set practically at the same moment
> > as SB_ACTIVE. SB_ACTIVE gets cleared somewhat earlier than SB_DYING is set
> > but I believe SB_DYING can be set earlier (after all by the time SB_ACTIVE
> > is cleared we have sb->s_root == NULL which basically stops most of the
> > places looking at superblocks. As I'm grepping we've grown a lot of
> > SB_ACTIVE handling all over the place so this would be a bit non-trivial
> > but I belive it will make it easier for filesystem developers to decide
> > which flag they should be using... Also we could then drop sb->s_root
> > checks from many places because the locking helpers will return false if
> > SB_DYING is set.
> 
> Certainly something to explore but no promises. Would you be open to
> doig this as a follow-up patch? If you have a clearer idea here then I
> wouldn't mind you piling this on top of this series even.

Sure, the cleanup of SB_ACTIVE probably deserves a separate patchset
because it's going to involve a lot of individual filesystem changes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
