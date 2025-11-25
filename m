Return-Path: <linux-fsdevel+bounces-69764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C89C84891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681273AC270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295073101B1;
	Tue, 25 Nov 2025 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1MYRb2Q8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zo+Nxijz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n4VAP5kn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgIxgk3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFB2E265A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067490; cv=none; b=mH188effmFJxjnPZNl1ya1Tv9Cvie6rzKnOmXJIgc1B4rjnmouSXexqHGq4gJBmh3+1pZ2USA+tH/MebEDvCVh6JYWsKljiBL+z5j+NGMUcB/CxJFzEfpIbu0dXG74OtjL+fJzcHXzo3Bn1kOtmROHD8hMg55jS8tRMYlVdurpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067490; c=relaxed/simple;
	bh=d7Zfa963Cx3xso3qYq6yuDnlXYaWQICIM0jFcbbeBSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRdNapaSe3+9zWJiyNJ8nhah/FkQ6gMLH/IEkwwq2Jjn4XPyGgaEVZ31j83alqzor8d2vJD2pHEhW6NUMO+e8equDs6MPFbY7KQz6lrratvkg92XStqn+PKjBEkEwzDqX4HfIYDwz6mLJbRMvIYAWIp3w66R7ncug7wUPjEtFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1MYRb2Q8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zo+Nxijz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n4VAP5kn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgIxgk3h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AAFC5BD10;
	Tue, 25 Nov 2025 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764067487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
	b=1MYRb2Q8vuxX7BofH4S1MAf1v0Rg4jKB2db0utipczFDHPn9q1T9HiMSS+4RwaAFB0hG2J
	B/7oirTyJ8dQGHbuw6gYJYxzI9w6HGbKxJ7cMIYzy0pu+Bvx7Se2tynbpl/J6XFtYWFzwQ
	Z/pFex7XG8F/RDy0e6AP5tylzbVqm9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764067487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
	b=zo+Nxijzra4tATm4UVWr/GN7/xUjNXwgjxJKfQV66lCsC4I3rv0rwTwPRCktgVSUdK/5hT
	UBzzDD7VSTgceRDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764067486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
	b=n4VAP5knA2p75ItQxzsZ7UjgFEMxgqEovAcZsi8S6B5OfIxIRS2jSZYENBzLbXXgSlGNzN
	miDLv17BsrKmmI1kZbInAOZFCN+y1cyD84D904lhBf0hYAdLVR/jG4SDnOG2/StqSYuhwe
	cGp5EbQ0+HS2xPToR3/GnlNfeqANmjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764067486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
	b=mgIxgk3hIeRsmgwlI7laXuAa6CgRRRwV09/5Nd/5o4riPeX1ycdsX/hoNa5wdJmkMvZXjk
	ZwWUvpC1fcK9F/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED4F33EA65;
	Tue, 25 Nov 2025 10:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xq6COZ2IJWmHCwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 25 Nov 2025 10:44:45 +0000
Date: Tue, 25 Nov 2025 11:45:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Joel Granados <joel.granados@kernel.org>, lkp@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	oe-lkp@lists.linux.dev, ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <aSWI07xSK9zGsivq@yuki.lan>
References: <202511251654.9c415e9b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511251654.9c415e9b-lkp@intel.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi!
> PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
> 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=2
> 2025-11-25 05:37:33 export LTPROOT=/lkp/benchmarks/ltp
> 2025-11-25 05:37:33 kirk -U ltp -f fs-00

Oliver can you please record the test logs with '-o results.json' and
include that file in the download directory?

-- 
Cyril Hrubis
chrubis@suse.cz

