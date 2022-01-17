Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FB490A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiAQOiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:38:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48694 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbiAQOiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:38:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 14CE21F385;
        Mon, 17 Jan 2022 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642430289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvUap+DwKBiunMat6fSEU/DhZVQmc4GhjOocn0eF9F0=;
        b=zAarisL5NN5+v9qyJxFdGX7etOauLFTpfdV5yQVvoXbBIkxO1W/kTNELbDmujo2xOxdHg4
        u2w1xT4rMAgmXEkqiKEYVsvCDR4qdEcTYe5Iql4SHKhYHFHGY+sme4T+J1G5q8i8+lALej
        xNCytpw4HjuY2tKCjIhLkcEtDsI/0lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642430289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvUap+DwKBiunMat6fSEU/DhZVQmc4GhjOocn0eF9F0=;
        b=oC1GEgl2WZAvCkL8tz8vZQn/WUd0qxBZeCixIX8Ay9CGDGI+E+0Ge4w9fMnI4O1GMSWgJU
        aqJbtMr7iy0vW7Bw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC5E8A3B88;
        Mon, 17 Jan 2022 14:38:08 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8E87DA05E4; Mon, 17 Jan 2022 15:38:07 +0100 (CET)
Date:   Mon, 17 Jan 2022 15:38:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 6/6] jbd2: No need to use t_handle_lock in
 jbd2_journal_wait_updates
Message-ID: <20220117143807.6fil45qvutvswa7z@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <e7e0f8c54306591a3a9c8fead1e0e54358052ab6.1642044249.git.riteshh@linux.ibm.com>
 <20220113112749.d5tfszcksvxvshnn@quack3.lan>
 <20220113123842.3rpfcyecylt5n3wo@riteshh-domain>
 <20220117125527.ienv3drg5whiryrr@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117125527.ienv3drg5whiryrr@riteshh-domain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-01-22 18:25:27, Ritesh Harjani wrote:
> On 22/01/13 06:08PM, Ritesh Harjani wrote:
> > On 22/01/13 12:27PM, Jan Kara wrote:
> > > On Thu 13-01-22 08:56:29, Ritesh Harjani wrote:
> > > > Since jbd2_journal_wait_updates() uses waitq based on t_updates atomic_t
> > > > variable. So from code review it looks like we don't need to use
> > > > t_handle_lock spinlock for checking t_updates value.
> > > > Hence this patch gets rid of the spinlock protection in
> > > > jbd2_journal_wait_updates()
> > > >
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > >
> > > This patch looks good. Feel free to add:
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > >
> > > Actually looking at it, t_handle_lock seems to be very much unused. I agree
> 
> Thanks Jan for your help in this.
> I have dropped this patch from v2 in order to discuss few more things and I felt
> killing t_handle_lock completely can be sent in a seperate patch series.

Yes, probably a good choice.

> > I too had this thought in mind. Thanks for taking a deeper look into it :)
> >
> > >
> > > we don't need it when waiting for outstanding handles but the only
> > > remaining uses are:
> > >
> > > 1) jbd2_journal_extend() where it is not needed either - we use
> > > atomic_add_return() to manipulate t_outstanding_credits and hold
> > > j_state_lock for reading which provides us enough exclusion.
> 
> I looked into jbd2_journal_extend and yes, we don't need t_handle_lock
> for updating transaction->t_outstanding_credits, since it already happens with
> atomic API calls.
> 
> Now I do see we update handle->h_**_credits in that function.
> But I think this is per process (based on task_struct, current->journal_info)
> and doesn't need a lock protection right?

Yes, handle is per process so no lock is needed there.

> > > 2) update_t_max_wait() - this is the only valid use of t_handle_lock but we
> > > can just switch it to cmpxchg loop with a bit of care. Something like:
> > >
> > > 	unsigned long old;
> > >
> > > 	ts = jbd2_time_diff(ts, transaction->t_start);
> > > 	old = transaction->t_max_wait;
> > > 	while (old < ts)
> > > 		old = cmpxchg(&transaction->t_max_wait, old, ts);
> 
> I think there might be a simpler and more straight forward way for updating
> t_max_wait.
> 
> I did look into the t_max_wait logic and where all we are updating it.
> 
> t_max_wait is the max wait time in starting (&attaching) a _new_ running
> transaction by a handle. Is this understaning correct?

Correct. It is the maximum time we had to wait for a new transaction to be
created.

> From code I don't see t_max_wait getting updated for the time taken in order
> to start the handle by a existing running transaction.
> 
> Here is how -
> update_t_max_wait() will only update t_max_wait if the
> transaction->t_start is after ts
> (ts is nothing but when start_this_handle() was called).
> 
> 1. This means that for transaction->t_start to be greater than ts, it has to be
>    the new transaction that gets started right (in start_this_handle() func)?
>
> 2. Second place where transaction->t_start is updated is just after the start of
>    commit phase 7. But this only means that this transaction has become the
>    commit transaction. That means someone has to alloc a new running transaction
>    which again is case-1.
> 
> Now I think this spinlock was added since multiple processes can start a handle
> in parallel and attach a running transaction.
> 
> Also this was then moved within CONFIG_JBD2_DEBUG since to avoid spinlock
> contention on a SMP system in starting multiple handles by different processes.
> 
> Now looking at all of above, I think we can move update_t_max_wait()
> inside jbd2_get_transaction() in start_this_handle(). Because that is where
> a new transaction will be started and transaction->t_start will be greater then
> ts. This also is protected within j_state_lock write_lock, so we don't need
> spinlock.

All above is correct upto this point. The catch is there can be (and often
are) more processes in start_this_handle() waiting in
wait_transaction_switching() and then racing to create the new transaction.
The process calling jbd2_get_transaction() is not necessarily the one which
entered start_this_handle() first and thus t_max_wait would not be really
the maximum time someone had to wait.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
