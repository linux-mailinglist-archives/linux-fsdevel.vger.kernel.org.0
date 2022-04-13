Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3D4FFE13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiDMSon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiDMSon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:44:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F3C3BBD4;
        Wed, 13 Apr 2022 11:42:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DBF5B64A6; Wed, 13 Apr 2022 14:42:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DBF5B64A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649875339;
        bh=j+zJYzvLlQcSHur0Ua3NNiqnXijq3TAWHUPrRuEEO+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E83G/kFUFyHHfWUo8iyR7O+hkKsCNtR5EECr0NkvryLlIJSl+ERc+MqNb+pOLgITJ
         Enx7lBfjTzbWnuh6hbS1Zdz8hLn3ry+sf0NHnKrZuou941DjXuMWlDZhTji8SFTPjn
         YaeIWHhUbQSqMWZjwz4W9jFkVzU0ETglk7OO+UzU=
Date:   Wed, 13 Apr 2022 14:42:19 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Message-ID: <20220413184219.GE29176@fieldses.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org>
 <a33fae1e-8991-cd5e-1fb7-cbc77165e55c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33fae1e-8991-cd5e-1fb7-cbc77165e55c@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:28:05AM -0700, dai.ngo@oracle.com wrote:
> 
> On 4/13/22 5:55 AM, Bruce Fields wrote:
> >On Fri, Apr 01, 2022 at 12:11:34PM -0700, dai.ngo@oracle.com wrote:
> >>On 4/1/22 8:57 AM, Chuck Lever III wrote:
> >>>>(And to be honest I'd still prefer the original approach where we expire
> >>>>clients from the posix locking code and then retry.  It handles an
> >>>>additional case (the one where reboot happens after a long network
> >>>>partition), and I don't think it requires adding these new client
> >>>>states....)
> >>>The locking of the earlier approach was unworkable.
> >>>
> >>>But, I'm happy to consider that again if you can come up with a way
> >>>of handling it properly and simply.
> >>I will wait for feedback from Bruce before sending v20 with the
> >>above change.
> >OK, I'd like to tweak the design in that direction.
> >
> >I'd like to handle the case where the network goes down for a while, and
> >the server gets power-cycled before the network comes back up.  I think
> >that could easily happen.  There's no reason clients couldn't reclaim
> >all their state in that case.  We should let them.
> >
> >To handle that case, we have to delay removing the client's stable
> >storage record until there's a lock conflict.  That means code that
> >checks for conflicts must be able to sleep.
> >
> >In each case (opens, locks, delegations), conflicts are first detected
> >while holding a spinlock.  So we need to unlock before waiting, and then
> >retry if necessary.
> >
> >We decided instead to remove the stable-storage record when first
> >converting a client to a courtesy client--then we can handle a conflict
> >by just setting a flag on the client that indicates it should no longer
> >be used, no need to drop any locks.
> >
> >That leaves the client in a state where it's still on a bunch of global
> >data structures, but has to be treated as if it no longer exists.  That
> >turns out to require more special handling than expected.  You've shown
> >admirable persistance in handling those cases, but I'm still not
> >completely convinced this is correct.
> >
> >We could avoid that complication, and also solve the
> >server-reboot-during-network-partition problem, if we went back to the
> >first plan and allowed ourselves to sleep at the time we detect a
> >conflict.  I don't think it's that complicated.
> >
> >We end up using a lot of the same logic regardless, so don't throw away
> >the existing patches.
> >
> >My basic plan is:
> >
> >Keep the client state, but with only three values: ACTIVE, COURTESY, and
> >EXPIRABLE.
> >
> >ACTIVE is the initial state, which we return to whenever we renew.  The
> >laundromat sets COURTESY whenever a client isn't renewed for a lease
> >period.  When we run into a conflict with a lock held by a client, we
> >call
> >
> >   static bool try_to_expire_client(struct nfs4_client *clp)
> >   {
> >	return COURTESY == cmpxchg(clp->cl_state, COURTESY, EXPIRABLE);
> >   }
> >
> >If it returns true, that tells us the client was a courtesy client.  We
> >then call queue_work(laundry_wq, &nn->laundromat_work) to tell the
> >laundromat to actually expire the client.  Then if needed we can drop
> >locks, wait for the laundromat to do the work with
> >flush_workqueue(laundry_wq), and retry.
> >
> >All the EXPIRABLE state does is tell the laundromat to expire this
> >client.  It does *not* prevent the client from being renewed and
> >acquiring new locks--if that happens before the laundromat gets to the
> >client, that's fine, we let it return to ACTIVE state and if someone
> >retries the conflicing lock they'll just get a denial.
> >
> >Here's a suggested a rough patch ordering.  If you want to go above and
> >beyond, I also suggest some tests that should pass after each step:
> >
> >
> >PATCH 1
> >-------
> >
> >Implement courtesy behavior *only* for clients that have
> >delegations, but no actual opens or locks:
> >
> >Define new cl_state field with values ACTIVE, COURTESY, and EXPIRABLE.
> >Set to ACTIVE on renewal.  Modify the laundromat so that instead of
> >expiring any client that's too old, it first checks if a client has
> >state consisting only of unconflicted delegations, and, if so, it sets
> >COURTESY.
> >
> >Define try_to_expire_client as above.  In nfsd_break_deleg_cb, call
> >try_to_expire_client and queue_work.  (But also continue scheduling the
> >recall as we do in the current code, there's no harm to that.)
> >
> >Modify the laundromat to try to expire old clients with EXPIRED set.
> >
> >TESTS:
> >	- Establish a client, open a file, get a delegation, close the
> >	  file, wait 2 lease periods, verify that you can still use the
> >	  delegation.
> >	- Establish a client, open a file, get a delegation, close the
> >	  file, wait 2 lease periods, establish a second client, request
> >	  a conflicting open, verify that the open succeeds and that the
> >	  first client is no longer able to use its delegation.
> >
> >
> >PATCH 2
> >-------
> >
> >Extend courtesy client behavior to clients that have opens or
> >delegations, but no locks:
> >
> >Modify the laundromat to set COURTESY on old clients with state
> >consisting only of opens or unconflicted delegations.
> >
> >Add in nfs4_resolve_deny_conflicts_locked and friends as in your patch
> >"Update nfs4_get_vfs_file()...", but in the case of a conflict, call
> >try_to_expire_client and queue_work(), then modify e.g.
> >nfs4_get_vfs_file to flush_workqueue() and then retry after unlocking
> >fi_lock.
> >
> >TESTS:
> >	- establish a client, open a file, wait 2 lease periods, verify
> >	  that you can still use the open stateid.
> >	- establish a client, open a file, wait 2 lease periods,
> >	  establish a second client, request an open with a share mode
> >	  conflicting with the first open, verify that the open succeeds
> >	  and that first client is no longer able to use its open.
> >
> >PATCH 3
> >-------
> >
> >Minor tweak to prevent the laundromat from being freed out from
> >under a thread processing a conflicting lock:
> >
> >Create and destroy the laundromat workqueue in init_nfsd/exit_nfsd
> >instead of where it's done currently.
> >
> >(That makes the laundromat's lifetime longer than strictly necessary.
> >We could do better with a little more work; I think this is OK for now.)
> >
> >TESTS:
> >	- just rerun any regression tests; this patch shouldn't change
> >	  behavior.
> >
> >PATCH 4
> >-------
> >
> >Extend courtesy client behavior to any client with state, including
> >locks:
> >
> >Modify the laundromat to set COURTESY on any old client with state.
> >
> >Add two new lock manager callbacks:
> >
> >	void * (*lm_lock_expirable)(struct file_lock *);
> >	bool (*lm_expire_lock)(void *);
> >
> >If lm_lock_expirable() is called and returns non-NULL, posix_lock_inode
> >should drop flc_lock, call lm_expire_lock() with the value returned from
> >lm_lock_expirable, and then restart the loop over flc_posix from the
> >beginning.
> >
> >For now, nfsd's lm_lock_expirable will basically just be
> >
> >	if (try_to_expire_client()) {
> >		queue_work()
> >		return get_net();
> >	}
> >	return NULL;
> >
> >and lm_expire_lock will:
> >
> >	flush_workqueue()
> >	put_net()
> >
> >One more subtlety: the moment we drop the flc_lock, it's possible
> >another task could race in and free it.  Worse, the nfsd module could be
> >removed entirely--so nfsd's lm_expire_lock code could disappear out from
> >under us.  To prevent this, I think we need to add a struct module
> >*owner field to struct lock_manager_operations, and use it like:
> >
> >	owner = fl->fl_lmops->owner;
> >	__get_module(owner);
> >	expire_lock = fl->fl_lmops->lm_expire_lock;
> >	spin_unlock(&ctx->flc_lock);
> >	expire_lock(...);
> >	module_put(owner);
> >
> >Maybe there's some simpler way, but I don't see it.
> >
> >TESTS:
> >	- retest courtesy client behavior using file locks this time.
> >
> >--
> >
> >That's the basic idea.  I think it should work--though I may have
> >overlooked something.
> >
> >This has us flush the laundromat workqueue while holding mutexes in a
> >couple cases.  We could avoid that with a little more work, I think.
> >But those mutexes should only be associated with the client requesting a
> >new open/lock, and such a client shouldn't be touched by the laundromat,
> >so I think we're OK.
> >
> >It'd also be helpful to update the info file with courtesy client
> >information, as you do in your current patches.
> >
> >Does this make sense?
> 
> I think most of the complications in the current patches is due to the
> handling of race conditions when courtesy client reconnects as well as
> creating and removing client record (which I already addressed in v21).
> The new approach here does not cover these race conditions,

That's the thing, there *is* no reconnection with this approach.  A
"courtesy" client still has a stable storage record and is treated in
every way exactly like a normal active client that just hasn't been
renewed in a long time.  I'm suggesting this approach exactly to avoid
the complications you're talking about.

> I guess
> these are the details that will show up in the implementation.
> 
> I feel like we're going around in the circle but I will implement this
> new approach then we can compare to see if it's simpler than the current
> one.

Thanks for giving it a look.

--b.
