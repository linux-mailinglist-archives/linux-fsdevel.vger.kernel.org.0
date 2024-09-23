Return-Path: <linux-fsdevel+bounces-29896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A176297F125
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6381F22B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE219F407;
	Mon, 23 Sep 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="whOCPy81";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsPrNOuM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="whOCPy81";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsPrNOuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E217BCC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118822; cv=none; b=Svgmg9787LH9ATtowwXI4V6pTuPKgEcOe53dImsB1Vz/zKGKMoVLNP+eN7Sp4C0V6L09SdusNVLnqTHV821ciqu7OTMJhQGX6aBYvLDpaT7UvVxLZmONVI9/uRvDgTaxgAnX4ipiMnfm9EdQmU2NhC9g82xgex8YHhU7OLJYb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118822; c=relaxed/simple;
	bh=QAuhvBmId4AhpD3JkqQ4o/8sVMOvkLzcQOItt3nXd5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJpOrxN+8oaUxMpcko2xXvaKB6YSEnX24mnj7LGmRMYnUVzoU3jo7tCR5Tjbk10knauwYE0v1Hj5ud2UJGA/bAD5FNCuV8RYkZEspXp3648z69p1nu3dS0Tl6RKodiwgF/wQ0U9E2aRshjft5mgMjP/JGnfRe0qqtOC5acQ+GCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=whOCPy81; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsPrNOuM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=whOCPy81; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsPrNOuM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EDF51F390;
	Mon, 23 Sep 2024 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727118818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kyRNi2+rqNZD3wa8cUJq5PMVcecbiSFwjuGeV4QkRo=;
	b=whOCPy81OuPQuLxyF8jmh1BZoVy6JcelIEZzxPPeELm6cIQASidm69O7Udbc0SLwN7EePf
	k1GXKxA8x+R8yF5pME1UOZllkppqWr7FT+krutyD7uklE9nhJ8OB38fpKL6tmPBKljr7I/
	A0J5hGcTsMAVFXDV6xq6lmbAGyjZzMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727118818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kyRNi2+rqNZD3wa8cUJq5PMVcecbiSFwjuGeV4QkRo=;
	b=wsPrNOuMwLx0tXeVxScBq+y/W5fNF3kyktCG3Pd1XGA8RucvdIwFePm59EPSzl8FO8dXBw
	f7E7WleHp5Z4EmBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727118818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kyRNi2+rqNZD3wa8cUJq5PMVcecbiSFwjuGeV4QkRo=;
	b=whOCPy81OuPQuLxyF8jmh1BZoVy6JcelIEZzxPPeELm6cIQASidm69O7Udbc0SLwN7EePf
	k1GXKxA8x+R8yF5pME1UOZllkppqWr7FT+krutyD7uklE9nhJ8OB38fpKL6tmPBKljr7I/
	A0J5hGcTsMAVFXDV6xq6lmbAGyjZzMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727118818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7kyRNi2+rqNZD3wa8cUJq5PMVcecbiSFwjuGeV4QkRo=;
	b=wsPrNOuMwLx0tXeVxScBq+y/W5fNF3kyktCG3Pd1XGA8RucvdIwFePm59EPSzl8FO8dXBw
	f7E7WleHp5Z4EmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE4B1347F;
	Mon, 23 Sep 2024 19:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qfFgF+K98WamMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 19:13:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F17E1A0656; Mon, 23 Sep 2024 21:13:22 +0200 (CEST)
Date: Mon, 23 Sep 2024 21:13:22 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
Message-ID: <20240923191322.3jbkvwqzxvopt3kb@quack3>
References: <20240923110348.tbwihs42dxxltabc@quack3>
 <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 23-09-24 11:35:00, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 04:03, Jan Kara <jack@suse.cz> wrote:
> >
> >   * The implementation of the pre-content fanotify events. T
> 
> I pulled this, and then I decided to unpull.
> 
> I don't see what the permissions for this thing are, and without
> explanations for why this isn't a huge security issue, I'm not pulling
> it.
> 
> Maybe those explanations exist elsewhere, but they sure aren't in the
> pull request.

Sure, the details are in some of the commit messages but you're right I
should have summarized them in the pull request as well:

Pre-content events are restricted to global CAP_SYS_ADMIN. This is achieved
by pre-content events being restricted to FAN_CLASSS_PRE_CONTENT
notification groups which are restricted to CAP_SYS_ADMIN in
fanotify_init() by this check:

        if (!capable(CAP_SYS_ADMIN)) {
                /*
                 * An unprivileged user can setup an fanotify group with
                 * limited functionality - an unprivileged group is limited to
                 * notification events with file handles and it cannot use
                 * unlimited queue/marks.
                 */
                if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
                        return -EPERM;
		...
	}


> IOW, I want to know where the code is that says "you can't block root
> processes doing accesses to your files" etc. Or things like "oh, the
> kernel took a page fault while holding some lock, what protects this
> from being misused"?
> 
> And if that code doesn't exist, there's no way in hell we're pulling
> this. Ever.

Sure, I understand that. That would have been a huge security hole.

> IOW, where is the "we don't allow unprivileged groups to do this" code?
> 
> Because:
> 
> >   These events are
> >  sent before read / write / page fault and the execution is paused until
> >  event listener replies similarly to current fanotify permission events.
> 
> Permission events aren't allowed for unprivileged users. I want to
> make sure people have thought about this, and I need to actually see
> this talked about in the pull request.

Should I update the pull request and resend or will you update it with
paragraph above?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

