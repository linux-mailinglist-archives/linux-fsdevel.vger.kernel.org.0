Return-Path: <linux-fsdevel+bounces-64434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC81BE7C10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5835C10A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111B31A042;
	Fri, 17 Oct 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oKFY8Vh8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3yWDbeVl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oKFY8Vh8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3yWDbeVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC932BD02A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693066; cv=none; b=HaJB039elRSBBWVMq6JQRDKOcXxUz0BsNF4XzOuaQ3+M81fExRGxbJrdzMAes3VQLHltRn5A0C5UFavPF0NM9l2Oia9cPpdrJ0REbnY6WZEREeYe1ewmn1PnMqrefis5R/pJxTXEk2zm7eQTx+EuyzRMZcYjMItGc3T7LhH8IHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693066; c=relaxed/simple;
	bh=CzRxUmZMpdqoJdJbYx8tsBe/1Zkx5cGL8TVZx6KKtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2d8PrKzJOp1PcBAhL61dHFbAmyi34kZ6lHkvSy4Op7JElmjUIgP7FJocTBz9qk/kiXs80zcRGe6Ujar+ZgDZfUNhSrb25S6xQy/fhB49wbxUq9M0V5uOwwFu/N1ctY6ef+lZMzSfKJ93nIstZ5YJu/YlWPySrdUP5Og/B51MNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oKFY8Vh8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3yWDbeVl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oKFY8Vh8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3yWDbeVl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8E6621ADB;
	Fri, 17 Oct 2025 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760693056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
	b=oKFY8Vh8HdrgJWICXdGPQ225mw6C6q5EbPtYZWcw4WC6fsesTzs5bqNpJ9f0oK0egLicXe
	cf60H9QPy5RjoTytk/ocqnmkyJDZzeD37cf6VJR1z2TIQDCqllTyC7ette2eEz6vK+LR/U
	64KWDhUkQvy7IPtW98HtETSdlA56TKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760693056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
	b=3yWDbeVll4eUeffk/SPEjI9XXhw0hebSLvu6Vz1D4Q0wn9dT7izbSvZ0u+f8QzRgF0NOih
	ZWTu2oTLZeJcH5Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760693056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
	b=oKFY8Vh8HdrgJWICXdGPQ225mw6C6q5EbPtYZWcw4WC6fsesTzs5bqNpJ9f0oK0egLicXe
	cf60H9QPy5RjoTytk/ocqnmkyJDZzeD37cf6VJR1z2TIQDCqllTyC7ette2eEz6vK+LR/U
	64KWDhUkQvy7IPtW98HtETSdlA56TKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760693056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
	b=3yWDbeVll4eUeffk/SPEjI9XXhw0hebSLvu6Vz1D4Q0wn9dT7izbSvZ0u+f8QzRgF0NOih
	ZWTu2oTLZeJcH5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 928D813A71;
	Fri, 17 Oct 2025 09:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GyMBI0AL8mjmKgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 17 Oct 2025 09:24:16 +0000
Date: Fri, 17 Oct 2025 11:25:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	LTP List <ltp@lists.linux.it>,
	Andrey Albershteyn <aalbersh@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Petr Vorel <pvorel@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
Message-ID: <aPILdh2XzsYgEg66@yuki.lan>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi!
> > The LTP syscalls ioctl_pidfd05 test failed due to following error on
> > the Linux mainline
> > kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.
> >
> > The Test case is expecting to fail with EINVAL but found ENOTTY.
> 
> [Not a kernel regression]
> 
> From the recent LTP upgrade we have newly added test cases,
> ioctl_pidfd()
> 
> The test case is meant to test,
> 
> Add ioctl_pidfd05 test
> Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO
>  is used.
>  This happens when:
>    - info parameter is NULL
>    - info parameter is providing the wrong size
> 
> However, we need to investigate the reason for failure.
> 
> Test case: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c

Already fixed in:

commit 00c3e947cece63ce81cdaf12b5a2071984aa7815
Author: Avinesh Kumar <akumar@suse.de>
Date:   Thu Sep 25 10:19:11 2025 +0200

    Introduce ioctl_pidfd_get_info_supported() function

    Check if ioctl(PIDFD_GET_INFO) is implemented or not
    before proceeding in ioctl_pidfd05 test.


-- 
Cyril Hrubis
chrubis@suse.cz

