Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63624413CBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhIUVm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:42:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhIUVmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:42:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60AD11FF24;
        Tue, 21 Sep 2021 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632260470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0GqJYRTLtj5brv4Bac0gTMm/xYvL7+Yx0c3tiayK/k=;
        b=vMIuuQA6sKKov3GBq6bp3HF6ImlswNZ8QL88oU7KwnEnDh4vSRf7bjMaAGoAn42aeQnLUc
        WdeeswDTbEseAAr6RJdEbqnwfwIz/8Rr1b6J9rU7mzMznBgjowrwApazbpIswb9gwT5yDP
        ElAFdF9oLF7WKJV3L/sl0qg5DMPeAWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632260470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0GqJYRTLtj5brv4Bac0gTMm/xYvL7+Yx0c3tiayK/k=;
        b=v45T6WfDNNIpJAkeEid0sdThJriTirP9PcSXknSMnBWz+DqFKWZxQgYk730mh93tmRf6FX
        V3/uWkZDGihpibDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C7A413BF7;
        Tue, 21 Sep 2021 21:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5PsjN3FRSmELIwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 21 Sep 2021 21:41:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Linux-MM" <linux-mm@kvack.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
In-reply-to: <20210921105831.GO3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>,
 <20210920085436.20939-2-mgorman@techsingularity.net>,
 <163218319798.3992.1165186037496786892@noble.neil.brown.name>,
 <20210921105831.GO3959@techsingularity.net>
Date:   Wed, 22 Sep 2021 07:40:59 +1000
Message-id: <163226045956.21861.7998898955979000139@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Sep 2021, Mel Gorman wrote:
> On Tue, Sep 21, 2021 at 10:13:17AM +1000, NeilBrown wrote:
> > On Mon, 20 Sep 2021, Mel Gorman wrote:
> > > -long wait_iff_congested(int sync, long timeout)
> > > -{
> > > -	long ret;
> > > -	unsigned long start =3D jiffies;
> > > -	DEFINE_WAIT(wait);
> > > -	wait_queue_head_t *wqh =3D &congestion_wqh[sync];
> > > -
> > > -	/*
> > > -	 * If there is no congestion, yield if necessary instead
> > > -	 * of sleeping on the congestion queue
> > > -	 */
> > > -	if (atomic_read(&nr_wb_congested[sync]) =3D=3D 0) {
> > > -		cond_resched();
> > > -
> > > -		/* In case we scheduled, work out time remaining */
> > > -		ret =3D timeout - (jiffies - start);
> > > -		if (ret < 0)
> > > -			ret =3D 0;
> > > -
> > > -		goto out;
> > > -	}
> > > -
> > > -	/* Sleep until uncongested or a write happens */
> > > -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> >=20
> > Uninterruptible wait.
> >=20
> > ....
> > > +static void
> > > +reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> > > +							long timeout)
> > > +{
> > > +	wait_queue_head_t *wqh =3D &pgdat->reclaim_wait;
> > > +	unsigned long start =3D jiffies;
> > > +	long ret;
> > > +	DEFINE_WAIT(wait);
> > > +
> > > +	atomic_inc(&pgdat->nr_reclaim_throttled);
> > > +	WRITE_ONCE(pgdat->nr_reclaim_start,
> > > +		 node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> > > +
> > > +	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
> >=20
> > Interruptible wait.
> >=20
> > Why the change?  I think these waits really need to be TASK_UNINTERRUPTIB=
LE.
> >=20
>=20
> Because from mm/ context, I saw no reason why the task *should* be
> uninterruptible. It's waiting on other tasks to complete IO and it is not
> protecting device state, filesystem state or anything else. If it gets
> a signal, it's safe to wake up, particularly if that signal is KILL and
> the context is a direct reclaimer.

I disagree.  An Interruptible sleep only makes sense if the "was
interrupted" status can propagate up to user-space (or to some in-kernel
handler that will clear the signal).
In particular, if reclaim_throttle() is called in a loop (which it is),
and if that loop doesn't check for signal_pending (which it doesn't),
then the next time around the loop after receiving a signal, it won't
sleep at all.  That would be bad.

In general, if you don't return an error, then you probably shouldn't
sleep Interruptible.

I notice that tasks sleep on kswapd_wait as TASK_INTERRUPTIBLE, but they
don't have any signal handling.  I suspect this isn't actually a defect
because I suspect that is it not even possible to SIGKILL kswapd.  But
the code seems misleading.  I guess I should write a patch.

Unless reclaim knows to abort completely on a signal (__GFP_KILLABLE
???) this must be an UNINTERRUPTIBLE wait.

Thanks,
NeilBrown

>=20
> The original TASK_UNINTERRUPTIBLE is almost certainly a copy&paste from
> congestion_wait which may be called because a filesystem operation must
> complete before it can return to userspace so a signal waking it up is
> pointless.
>=20
> --=20
> Mel Gorman
> SUSE Labs
>=20
>=20
