Return-Path: <linux-fsdevel+bounces-40365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FB7A22A55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6D93A1ECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482D1B425F;
	Thu, 30 Jan 2025 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UkxQk9ba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8YQr3t8s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UkxQk9ba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8YQr3t8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0FC18F2DD;
	Thu, 30 Jan 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229377; cv=none; b=CT7aZVjdUeECFSC8CUK+UUTCdUqc3/jHMy6AfqjDV9lTc8okOYJA9KACi2IBTAq6sKrLD/gtKfuWnkNf8Pe5SuzXDSiZhqVhaJH+uFm/TCICBe8+xVcNx0zEXN7Xc72Rdx2YmojQkjzxKwomaf9v7TfjD4JyIBxJEbOz6y7Xwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229377; c=relaxed/simple;
	bh=yw81m/gOi9gC3Cqxh7jC1AG4C3HHcs10g7pPamweUyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAP4Oh74ybrpLc9LSl1PSGkX/4xdE0xSKrtsUCO8hFv5Du5rQod0okdG3B70o9pUdNkfn4DhdAzMo3XzgdStUDPIUd0HX4bsQMws+kNM/UQmoZodjoSI2pTqNIRKhlXuTcB3tFU40hnPJEqajRyF0Zoh8+FpLpQ6OHo0CAVcs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UkxQk9ba; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8YQr3t8s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UkxQk9ba; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8YQr3t8s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4DD6920D93;
	Thu, 30 Jan 2025 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738229374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA9EIQPA3LlcVtB+tMezspGE+fONF9lDmcS9FOPkdmo=;
	b=UkxQk9bacpOhOwz8sAB4aQyluRJpDgdZP+NRzPJcAotWbzoQaZXSJS+ls9RZlLDF0BD2TS
	kbGPzgl8UBTCFieY0d+mFbKXkRZ0whGJNU/jDM7j9iO1B/H5qGUV3bBQe+Nsv3bmUvkEoe
	+hXDbRmuyv7HcPwgkp+KY3179mjv990=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738229374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA9EIQPA3LlcVtB+tMezspGE+fONF9lDmcS9FOPkdmo=;
	b=8YQr3t8sgBwk3x3rLY+1xQabuwyXCwp4z43GG0+ZkcjvJ8p6zXIZ7WjAVB3S/UDGwRze5c
	vLPAjPZx4WelWgCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738229374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA9EIQPA3LlcVtB+tMezspGE+fONF9lDmcS9FOPkdmo=;
	b=UkxQk9bacpOhOwz8sAB4aQyluRJpDgdZP+NRzPJcAotWbzoQaZXSJS+ls9RZlLDF0BD2TS
	kbGPzgl8UBTCFieY0d+mFbKXkRZ0whGJNU/jDM7j9iO1B/H5qGUV3bBQe+Nsv3bmUvkEoe
	+hXDbRmuyv7HcPwgkp+KY3179mjv990=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738229374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA9EIQPA3LlcVtB+tMezspGE+fONF9lDmcS9FOPkdmo=;
	b=8YQr3t8sgBwk3x3rLY+1xQabuwyXCwp4z43GG0+ZkcjvJ8p6zXIZ7WjAVB3S/UDGwRze5c
	vLPAjPZx4WelWgCA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 3E72C4A056A; Thu, 30 Jan 2025 10:29:34 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: Multigrain timestamps do not work on RISC-V
In-Reply-To: <fe719cdf52e9fc48955f116ea2e23ea8136e4d87.camel@kernel.org> (Jeff
	Layton's message of "Wed, 29 Jan 2025 18:28:36 -0500")
References: <mvmv7ty3pd8.fsf@suse.de> <mvmikpx4jw4.fsf@suse.de>
	<f704b0c40c393d1c326f13d043505960924f879a.camel@kernel.org>
	<fe719cdf52e9fc48955f116ea2e23ea8136e4d87.camel@kernel.org>
Date: Thu, 30 Jan 2025 10:29:34 +0100
Message-ID: <mvma5b84pkx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.20
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

On Jan 29 2025, Jeff Layton wrote:

> Obviously, fixing the macro seems like the better solution, but if
> fixing this efficiently is a problem, then moving I_CTIME_QUERIED to
> bit 30 is also an option.

There is no need to change it, the fix for arch_cmpxchg is pretty
straight forward, see
<https://lore.kernel.org/all/mvmed0k4prh.fsf@suse.de/>.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

