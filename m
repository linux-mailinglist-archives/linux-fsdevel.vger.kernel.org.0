Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFE2DDA2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgLQUgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQUgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:36:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CF7C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 12:35:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y5so28814225iow.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N74wD+NAXV2ZG+vAEpGZoSARePNjDUr/eY5AxWtIB/s=;
        b=Pl/tYeZzu/zu1O3+yWLBl47js82FseO3AhUvP4ovzERbdPQNO+RPvlOywzxGmduNyc
         tUa7/tYA+AK9hm3rSMGzw2g4TuaKtGHG6yZGmTKJVvKjaHynS2B8MrlzGrlH4WQ1MAUQ
         7mKhm7iZPMfMG0hifEW9DH1QHr9bMg1MTRyEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N74wD+NAXV2ZG+vAEpGZoSARePNjDUr/eY5AxWtIB/s=;
        b=ex5IkbqnuhF0zKn+6TbLY3F5cXF/DYkwtcx1qv93l9yCbvLdN4QwZQPs+v9nRPaV/n
         NIh3Lhr75pnz5y8xgQSvptkdOJgiuxP8aqGaJ/mWkSY5o7BApIDClIuv9CtOGUODyJDe
         fhN/tVcBTiu2BCZs2jOUcX5Ze6nIFivEjknxRW56CulTIGu2ysBKOOyh776PberUcTOX
         efnFJ0xDxC+W8dPz9oIE+ecRkrc8wAE8GdiMM6A7EtR3ljIKBVoTaROC4pf07MZG4cv2
         m8fMu8BRlAbzpwUAV3DP0TxnGgdDEv8Q9AJObyjfMBvrQMfkc+3ArXqdRqeSGbUhKo47
         CFVg==
X-Gm-Message-State: AOAM531KKQEWuuARGM0xQUvs3P2KjV57Jo78ToIa2vkjseRCQxZViShK
        WtVAHH6sob0SA4nGWno03rW31A==
X-Google-Smtp-Source: ABdhPJwEpL7HHZdgCMltlxI0vk5Hgm+ZRDrfPRFc1JLfAQ8cuUEh6RwvUqigo4IuUuTs5T8H+OGXtg==
X-Received: by 2002:a02:bb99:: with SMTP id g25mr680235jan.11.1608237326859;
        Thu, 17 Dec 2020 12:35:26 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z8sm5931302iod.25.2020.12.17.12.35.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Dec 2020 12:35:26 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:35:24 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
Message-ID: <20201217203523.GB28177@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201217150037.468787-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217150037.468787-1-jlayton@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> Overlayfs's volatile mounts want to be able to sample an error for their
> own purposes, without preventing a later opener from potentially seeing
> the error.
> 
> The original reason for the ERRSEQ_SEEN flag was to make it so that we
> didn't need to increment the counter if nothing had observed the latest
> value and the error was the same. Eventually, a regression was reported
> in the errseq_t conversion, and we fixed that by using the ERRSEQ_SEEN
> flag to also mean that the error had been reported to userland at least
> once somewhere.
> 
> Those are two different states, however. If we instead take a second
> flag bit from the counter, we can track these two things separately, and
> accomodate the overlayfs volatile mount use-case.
> 
> Rename the ERRSEQ_SEEN flag to ERRSEQ_OBSERVED and use that to indicate
> that the counter must be incremented the next time an error is set.
> Also, add a new ERRSEQ_REPORTED flag that indicates whether the current
> error was returned to userland (and thus doesn't need to be reported on
> newly open file descriptions).
> 
> Test only for the OBSERVED bit when deciding whether to increment the
> counter and only for the REPORTED bit when deciding what to return in
> errseq_sample.
> 
> Add a new errseq_peek function to allow for the overlayfs use-case.
> This just grabs the latest counter and sets the OBSERVED bit, leaving the
> REPORTED bit untouched.
> 
> errseq_check_and_advance must now handle a single special case where
> it races against a "peek" of an as of yet unseen value. The do/while
> loop looks scary, but shouldn't loop more than once.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/core-api/errseq.rst |  22 +++--
>  include/linux/errseq.h            |   1 +
>  lib/errseq.c                      | 139 ++++++++++++++++++++++--------
>  3 files changed, 118 insertions(+), 44 deletions(-)
> 
> v3: rename SEEN/MUSTINC flags to REPORTED/OBSERVED
> 
> Hopefully the new flag names will make this a bit more clear. We could
> also rename some of the functions if that helps too. We could consider
> moving from errseq_sample/_check_and_advance to
> errseq_observe/errseq_report?  I'm not sure that helps anything though.
> 
> I know that Vivek and Sargun are working on syncfs() for overlayfs, so
> we probably don't want to merge this until that work is ready. I think

I disagree. I think that this work can land ahead of that, given that I think 
this is probably backportable to v5.10 without much risk, with the addition of 
your RFC v2 Overlay patch. I think the work proper long-term repair Vivek is 
embarking upon seems like it may be far more invasive.

> the errseq_peek call will need to be part of their solution for volatile
> mounts, however, so I'm fine with merging this via the overlayfs tree,
> once that work is complete.
> 
> diff --git a/Documentation/core-api/errseq.rst b/Documentation/core-api/errseq.rst
> index ff332e272405..ce46ddcc1487 100644
> --- a/Documentation/core-api/errseq.rst
> +++ b/Documentation/core-api/errseq.rst
> @@ -18,18 +18,22 @@ these functions can be called from any context.
>  Note that there is a risk of collisions if new errors are being recorded
>  frequently, since we have so few bits to use as a counter.
>  
> -To mitigate this, the bit between the error value and counter is used as
> -a flag to tell whether the value has been sampled since a new value was
> -recorded.  That allows us to avoid bumping the counter if no one has
> -sampled it since the last time an error was recorded.
> +To mitigate this, the bits between the error value and counter are used
> +as flags to tell whether the value has been sampled since a new value
> +was recorded, and whether the latest error has been seen by userland.
> +That allows us to avoid bumping the counter if no one has sampled it
> +since the last time an error was recorded, and also ensures that any
> +recorded error will be seen at least once.
>  
>  Thus we end up with a value that looks something like this:
>  
> -+--------------------------------------+----+------------------------+
> -| 31..13                               | 12 | 11..0                  |
> -+--------------------------------------+----+------------------------+
> -| counter                              | SF | errno                  |
> -+--------------------------------------+----+------------------------+
> ++---------------------------------+----+----+------------------------+
> +| 31..14                          | 13 | 12 | 11..0                  |
> ++---------------------------------+----+----+------------------------+
> +| counter                         | OF | RF | errno                  |
> ++---------------------------------+----+----+------------------------+
> +OF = ERRSEQ_OBSERVED flag
> +RF = ERRSEQ_REPORTED flag
>  
>  The general idea is for "watchers" to sample an errseq_t value and keep
>  it as a running cursor.  That value can later be used to tell whether
> diff --git a/include/linux/errseq.h b/include/linux/errseq.h
> index fc2777770768..7e3634269c95 100644
> --- a/include/linux/errseq.h
> +++ b/include/linux/errseq.h
> @@ -9,6 +9,7 @@ typedef u32	errseq_t;
>  
>  errseq_t errseq_set(errseq_t *eseq, int err);
>  errseq_t errseq_sample(errseq_t *eseq);
> +errseq_t errseq_peek(errseq_t *eseq);
>  int errseq_check(errseq_t *eseq, errseq_t since);
>  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
>  #endif
> diff --git a/lib/errseq.c b/lib/errseq.c
> index 81f9e33aa7e7..8fd6be134dcc 100644
> --- a/lib/errseq.c
> +++ b/lib/errseq.c
> @@ -21,10 +21,14 @@
>   * Note that there is a risk of collisions if new errors are being recorded
>   * frequently, since we have so few bits to use as a counter.
>   *
> - * To mitigate this, one bit is used as a flag to tell whether the value has
> - * been sampled since a new value was recorded. That allows us to avoid bumping
> - * the counter if no one has sampled it since the last time an error was
> - * recorded.
> + * To mitigate this, one bit is used as a flag to tell whether the value has been
> + * observed in some fashion. That allows us to avoid bumping the counter if no
> + * one has sampled it since the last time an error was recorded.
> + *
> + * A second flag bit is used to indicate whether the latest error that has been
> + * recorded has been reported to userland. If the REPORTED bit is not set when the
> + * file is opened, then we ensure that the opener will see the error by setting
> + * its sample to 0.

Since there are only a few places that report to userland (as far as I can tell, 
a bit of usage in ceph), does it make sense to maintain this specific flag that
indicates it's reported to userspace? Instead can userspace keep a snapshot
of the last errseq it reported (say on the superblock), and use that to drive
reports to userspace?

It's a 32-bit sacrifice per SB though, but it means we can get rid of 
errseq_check_and_advance and potentially remove any need for locking and just
rely on cmpxchg.

>   *
>   * A new errseq_t should always be zeroed out.  A errseq_t value of all zeroes
>   * is the special (but common) case where there has never been an error. An all
> @@ -35,11 +39,33 @@
>  /* The low bits are designated for error code (max of MAX_ERRNO) */
>  #define ERRSEQ_SHIFT		ilog2(MAX_ERRNO + 1)
>  
> -/* This bit is used as a flag to indicate whether the value has been seen */
> -#define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
> +/* Flag to indicate whether the value will be or has been reported */
> +#define ERRSEQ_REPORTED		BIT(ERRSEQ_SHIFT)
> +
> +/* Flag to ndicate that error must be recorded */
> +#define ERRSEQ_OBSERVED		BIT(ERRSEQ_SHIFT + 1)
>  
>  /* The lowest bit of the counter */
> -#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
> +#define ERRSEQ_CTR_INC		BIT(ERRSEQ_SHIFT + 2)
> +
> +/* Mask that just contains the counter bits */
> +#define ERRSEQ_CTR_MASK		~(ERRSEQ_CTR_INC - 1)
> +
> +/* Mask that just contains flags */
> +#define ERRSEQ_FLAG_MASK	(ERRSEQ_REPORTED|ERRSEQ_OBSERVED)
> +
> +/**
> + * errseq_same - return true if the errseq counters and values are the same
> + * @a: first errseq
> + * @b: second errseq
> + *
> + * Compare two errseqs and return true if they are the same, ignoring their
> + * flag bits.
> + */
> +static inline bool errseq_same(errseq_t a, errseq_t b)
> +{
> +	return (a & ~ERRSEQ_FLAG_MASK) == (b & ~ERRSEQ_FLAG_MASK);
> +}
>  
>  /**
>   * errseq_set - set a errseq_t for later reporting
> @@ -53,7 +79,7 @@
>   *
>   * Return: The previous value, primarily for debugging purposes. The
>   * return value should not be used as a previously sampled value in later
> - * calls as it will not have the SEEN flag set.
> + * calls as it will not have the OBSERVED flag set.
>   */
>  errseq_t errseq_set(errseq_t *eseq, int err)
>  {
> @@ -77,11 +103,11 @@ errseq_t errseq_set(errseq_t *eseq, int err)
>  	for (;;) {
>  		errseq_t new;
>  
> -		/* Clear out error bits and set new error */
> -		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
> +		/* Clear out flag bits and old errors, and set new error */
> +		new = (old & ERRSEQ_CTR_MASK) | -err;
>  
> -		/* Only increment if someone has looked at it */
> -		if (old & ERRSEQ_SEEN)
> +		/* Only increment if we have to */
> +		if (old & ERRSEQ_OBSERVED)
>  			new += ERRSEQ_CTR_INC;
>  
>  		/* If there would be no change, then call it done */
> @@ -108,11 +134,38 @@ errseq_t errseq_set(errseq_t *eseq, int err)
>  EXPORT_SYMBOL(errseq_set);
>  
>  /**
> - * errseq_sample() - Grab current errseq_t value.
> + * errseq_peek - Grab current errseq_t value
> + * @eseq: Pointer to errseq_t to be sampled.
> + *
> + * In some cases, we need to be able to sample the errseq_t, but we're not
> + * in a situation where we can report the value to userland. Use this
> + * function to do that. This ensures that later errors will be recorded,
> + * and that any current errors are reported at least once when it is
> + * next sampled.
I would add that this function has side effects, and mutates errseq_t,
so callers understand they're mutating data.


> + *
> + * Context: Any context.
> + * Return: The current errseq value.
> + */
> +errseq_t errseq_peek(errseq_t *eseq)
> +{
> +	errseq_t old = READ_ONCE(*eseq);
> +	errseq_t new = old;
> +
> +	if (old != 0) {
> +		new |= ERRSEQ_OBSERVED;
> +		if (old != new)
> +			cmpxchg(eseq, old, new);
> +	}
> +	return new;
> +}
> +EXPORT_SYMBOL(errseq_peek);
> +
> +/**
> + * errseq_sample() - Sample errseq_t value, and ensure that unseen errors are reported
>   * @eseq: Pointer to errseq_t to be sampled.
>   *
>   * This function allows callers to initialise their errseq_t variable.
> - * If the error has been "seen", new callers will not see an old error.
> + * If the latest error has been "seen", new callers will not see an old error.
>   * If there is an unseen error in @eseq, the caller of this function will
>   * see it the next time it checks for an error.
>   *
> @@ -121,12 +174,11 @@ EXPORT_SYMBOL(errseq_set);
>   */
>  errseq_t errseq_sample(errseq_t *eseq)
>  {
> -	errseq_t old = READ_ONCE(*eseq);
> +	errseq_t new = errseq_peek(eseq);
>  
> -	/* If nobody has seen this error yet, then we can be the first. */
> -	if (!(old & ERRSEQ_SEEN))
> -		old = 0;
> -	return old;
> +	if (!(new & ERRSEQ_REPORTED))
> +		return 0;
> +	return new;
>  }
>  EXPORT_SYMBOL(errseq_sample);
>  
> @@ -145,7 +197,7 @@ int errseq_check(errseq_t *eseq, errseq_t since)
>  {
>  	errseq_t cur = READ_ONCE(*eseq);
>  
> -	if (likely(cur == since))
> +	if (errseq_same(cur, since))
>  		return 0;
>  	return -(cur & MAX_ERRNO);
>  }
> @@ -159,9 +211,9 @@ EXPORT_SYMBOL(errseq_check);
>   * Grab the eseq value, and see whether it matches the value that @since
>   * points to. If it does, then just return 0.
>   *
> - * If it doesn't, then the value has changed. Set the "seen" flag, and try to
> - * swap it into place as the new eseq value. Then, set that value as the new
> - * "since" value, and return whatever the error portion is set to.
> + * If it doesn't, then the value has changed. Set the REPORTED+OBSERVED flags, and
> + * try to swap it into place as the new eseq value. Then, set that value as
> + * the new "since" value, and return whatever the error portion is set to.
>   *
>   * Note that no locking is provided here for concurrent updates to the "since"
>   * value. The caller must provide that if necessary. Because of this, callers
> @@ -183,21 +235,38 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
>  	 */
>  	old = READ_ONCE(*eseq);
>  	if (old != *since) {
> +		int loops = 0;
> +
>  		/*
> -		 * Set the flag and try to swap it into place if it has
> -		 * changed.
> +		 * Set the flag and try to swap it into place if it has changed.
> +		 *
> +		 * If the swap doesn't occur, then it has either been updated by a
> +		 * writer who is setting a new error and/or bumping the counter, or
> +		 * another reader who is setting flags.
>  		 *
> -		 * We don't care about the outcome of the swap here. If the
> -		 * swap doesn't occur, then it has either been updated by a
> -		 * writer who is altering the value in some way (updating
> -		 * counter or resetting the error), or another reader who is
> -		 * just setting the "seen" flag. Either outcome is OK, and we
> -		 * can advance "since" and return an error based on what we
> -		 * have.
> +		 * We only need to retry in one case -- if we raced with another
> +		 * reader that is only setting the OBSERVED flag. We need the
> +		 * current value to have the REPORTED bit set if the other fields
> +		 * didn't change, or we might report the same error on newly opened
> +		 * files.
>  		 */
> -		new = old | ERRSEQ_SEEN;
> -		if (new != old)
> -			cmpxchg(eseq, old, new);
> +		do {
> +			if (unlikely(loops >= 2)) {
Any reason not to just make this:

if (WARN_ON_ONCE(loops >= 2))
	break

Given WARN_ON_ONCE already does the unlikely.

> +				/*
> +				 * This should never loop more than once, as any
> +				 * change not involving the REPORTED bit would also
> +				 * involve non-flag bits. WARN and just go with
> +				 * what we have in that case.
Couldn't we get a race of errors were being incremented faster than this loop runs?
> +				 */
> +				WARN_ON_ONCE(true);
> +				break;
> +			}
> +			loops++;
> +			new = old | ERRSEQ_REPORTED | ERRSEQ_OBSERVED;
> +			if (new == old)
> +				break;
> +			old = cmpxchg(eseq, old, new);
> +		} while (old == (new & ~ERRSEQ_REPORTED));
>  		*since = new;
>  		err = -(new & MAX_ERRNO);
>  	}
> -- 
> 2.29.2
> 

Thanks,

I'd like to see if we can get this in, and a janky version of the ovl_syncfs 
changes for volatile in stable, and then close the loop on the work that Vivek 
is doing to fix this for all of VFS in a later release.

Do you think that's reasonable?
