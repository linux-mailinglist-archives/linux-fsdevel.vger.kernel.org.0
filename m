Return-Path: <linux-fsdevel+bounces-58570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803CFB2ED67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 07:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE556807C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 05:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60822A7E2;
	Thu, 21 Aug 2025 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IZhEjeAs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vPN3FU6d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IZhEjeAs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vPN3FU6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD753C17
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755752690; cv=none; b=qv8qWkQ44Nr/X3IsjXplvfaLTFw8G4LAnopll0fr7jeTFfIWBgXoui83TW5g3/C7G1VHpa++29gpT6Zr+rtb2c1JalqLQbrHzdE5JNJh5zuZfdC6HsiwClf32sOT/zJrFJwLp8yTG7Zq+qs2PI6VInU6V3BlfnL6YXT4iJ/Jslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755752690; c=relaxed/simple;
	bh=34x1qdQH8P+r9MyBaDu1WiwJ13BCxG5ek5aWuksirF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV/LdT+vxnBkcolziHkU5HG+JNI4KNvLG74QnJH0dnGwyc+kRaVY5VpAnSPZYIRXDiMA0SiJjmtUdRHSNC4fNhqTP/pAPByXtF0ubqDy3OwCfCophLPE747BEZFrBMoyIwrCsl1nX+v3XIsv8HSmS62lINqC923rUTR2KbN3w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IZhEjeAs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vPN3FU6d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IZhEjeAs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vPN3FU6d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F42021288;
	Thu, 21 Aug 2025 05:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755752687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsGVJCXEBAq5aBbSQuh3KsHAn4nHmOhKYCwUt+Knp7E=;
	b=IZhEjeAscpTbz/3zFvOGadUQnugsv6qpstfvnOxLMxXJLk+odQOk2DvVJWrkQKoOW72KaJ
	OL8EpRRPRhyrfGADMm8lx4nnXyxvRB47fEJsdVO95zJMfYfLJUzr0SQhp45cb5oesWnvzG
	2g0BiT8ZqhVSllRG0/2jRNov+ATM6oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755752687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsGVJCXEBAq5aBbSQuh3KsHAn4nHmOhKYCwUt+Knp7E=;
	b=vPN3FU6dChOOEBcTk7gXZIDxbNP+YfckMyKaOXl/gIbVYmIv1aUCY/q9XP+Uoxr8lWjC88
	un/V6D82pM2EVCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755752687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsGVJCXEBAq5aBbSQuh3KsHAn4nHmOhKYCwUt+Knp7E=;
	b=IZhEjeAscpTbz/3zFvOGadUQnugsv6qpstfvnOxLMxXJLk+odQOk2DvVJWrkQKoOW72KaJ
	OL8EpRRPRhyrfGADMm8lx4nnXyxvRB47fEJsdVO95zJMfYfLJUzr0SQhp45cb5oesWnvzG
	2g0BiT8ZqhVSllRG0/2jRNov+ATM6oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755752687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsGVJCXEBAq5aBbSQuh3KsHAn4nHmOhKYCwUt+Knp7E=;
	b=vPN3FU6dChOOEBcTk7gXZIDxbNP+YfckMyKaOXl/gIbVYmIv1aUCY/q9XP+Uoxr8lWjC88
	un/V6D82pM2EVCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DFDF13867;
	Thu, 21 Aug 2025 05:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IdgdLuyopmiuXgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 21 Aug 2025 05:04:44 +0000
Date: Thu, 21 Aug 2025 15:04:26 +1000
From: David Disseldorp <ddiss@suse.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 linux-next@vger.kernel.org
Subject: Re: [PATCH v3 8/8] initramfs_test: add filename padding test case
Message-ID: <20250821150426.40f14b7f.ddiss@suse.de>
In-Reply-To: <aKY36YpNQTnd1d7Y@levanger>
References: <20250819032607.28727-9-ddiss@suse.de>
	<202508200304.wF1u78il-lkp@intel.com>
	<20250820111334.51e91938.ddiss@suse.de>
	<aKY36YpNQTnd1d7Y@levanger>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 20 Aug 2025 23:02:33 +0200, Nicolas Schier wrote:

> > >  > 415			.filesize = 0,    
> > ...  
> > >    425			.filesize = sizeof(fdata),
> > >    426		} };  
> > 
> > Thanks. I can send a v4 patchset to address this, or otherwise happy to
> > have line 415 removed by a maintainer when merged.  
> 
> With that change:
> 
> Acked-by: Nicolas Schier <nsc@kernel.org>

Thanks Nicolas!
Do you have any suggestions regarding how this patchset should proceed -
would git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
kbuild-next be suitable as a pre-merge-window staging area?

Cheers, David

