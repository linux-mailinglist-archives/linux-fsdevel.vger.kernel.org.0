Return-Path: <linux-fsdevel+bounces-19761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B988C99F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB61F219F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE91CA85;
	Mon, 20 May 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ebsu/ASE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CxenKFac";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ebsu/ASE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CxenKFac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBFA2D;
	Mon, 20 May 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194950; cv=none; b=TJkCguxq1+20v6HpOurytyuu9w60KiWDc3q5cht+We8f4ZsUbUtQFcVubEJ9768nIi62/NFDO5QwENcKy9zsnMS610PiOtivzur6F8Bl3yYWfmAsDbEPodmgZHEG7fvNuD8arVJ1VWXWow7T0jLgK/vm19Xcve73jo0UvJL2kmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194950; c=relaxed/simple;
	bh=2m8/0Wpgypww/qVvVssQsZJ3ugL36NGsxAEznLE8o6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwnQehlH1wtcas6v3XPYmsgoEU3tTDWFpoQ37L2KzKv2uzxz+iGiwRE3XGzQDMkypOKBg0lVnAABuK0LwSw8fTXpFGG56KK13ZjMC4YVhCBPYMvo6S83MGxShum6gE11iaTC9hDM5mK4RqllH/S2YijcbUZd8FhQGcUP7pl8AyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ebsu/ASE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CxenKFac; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ebsu/ASE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CxenKFac; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88F4620396;
	Mon, 20 May 2024 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716194946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmN+qMxf6btR4ij7xXK5Fa3M1JEpt2XRh4mZOWfFXOw=;
	b=Ebsu/ASE8JIhICjFkD6q9253i4A2t9ZNhIyWW3JuWbBKKKSlgL8EmmJ/3vzafglqe30eAZ
	PWbLVQW8MKA/P8xyG2Nu47PMOIUfI1Ej2SYpdbtusDu4HnXNZtw0c/mn/tvKYzBfqGn4L4
	j61C72ELZcQSVvvx+kZ82TO6XrAVMcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716194946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmN+qMxf6btR4ij7xXK5Fa3M1JEpt2XRh4mZOWfFXOw=;
	b=CxenKFacN8a9bLYZBO4ZhrYcBIc+iqsWZWwix31LIvZr75XMK+MC0SeLMBpCYMX/ZIjDYD
	vHTuqv1XKif4EaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716194946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmN+qMxf6btR4ij7xXK5Fa3M1JEpt2XRh4mZOWfFXOw=;
	b=Ebsu/ASE8JIhICjFkD6q9253i4A2t9ZNhIyWW3JuWbBKKKSlgL8EmmJ/3vzafglqe30eAZ
	PWbLVQW8MKA/P8xyG2Nu47PMOIUfI1Ej2SYpdbtusDu4HnXNZtw0c/mn/tvKYzBfqGn4L4
	j61C72ELZcQSVvvx+kZ82TO6XrAVMcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716194946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmN+qMxf6btR4ij7xXK5Fa3M1JEpt2XRh4mZOWfFXOw=;
	b=CxenKFacN8a9bLYZBO4ZhrYcBIc+iqsWZWwix31LIvZr75XMK+MC0SeLMBpCYMX/ZIjDYD
	vHTuqv1XKif4EaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF1E13A21;
	Mon, 20 May 2024 08:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P4P2HYIOS2Y+AQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 08:49:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 251A2A0888; Mon, 20 May 2024 10:49:06 +0200 (CEST)
Date: Mon, 20 May 2024 10:49:06 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()
Message-ID: <20240520084906.ejykv3xwn7l36jbg@quack3>
References: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
 <20240515002513.yaglghza4i4ldmr5@quack3>
 <f0eb115d-dd10-e156-9aed-65b7f479f008@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0eb115d-dd10-e156-9aed-65b7f479f008@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Thu 16-05-24 16:27:25, Zhang Yi wrote:
> On 2024/5/15 8:25, Jan Kara wrote:
> > On Mon 13-05-24 15:21:19, Zhang Yi wrote:
> > Also accessing j_commit_sequence without any
> > lock is theoretically problematic wrt compiler optimization. You should have
> > READ_ONCE() there and the places modifying j_commit_sequence need to use
> > WRITE_ONCE().
> > 
> 
> Thanks for pointing this out, but I'm not sure if we have to need READ_ONCE()
> here. IIUC, if we add READ_ONCE(), we could make sure to get the latest
> j_commit_sequence, if not, there is a window (it might becomes larger) that
> we could get the old value and jbd2_transaction_committed() could return false
> even if the given transaction was just committed, but I think the window is
> always there, so it looks like it is not a big problem, is that right?

Well, all accesses to any memory should use READ_ONCE(), be protected by a
lock, or use types that handle atomicity on assembly level (like atomic_t,
or atomic bit operations and similar). Otherwise the compiler is free to
assume the underlying memory cannot change and generate potentionally
invalid code. In this case, I don't think realistically any compiler will
do it but still it is a good practice and also it saves us from KCSAN
warnings. If you want to know more details about possible problems, see

  tools/memory-model/Documentation/explanation.txt

chapter "PLAIN ACCESSES AND DATA RACES".

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

