Return-Path: <linux-fsdevel+bounces-12255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3C85D693
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0D81C2289A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6383F8E2;
	Wed, 21 Feb 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ga1g4CJY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRcJa/ti";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ga1g4CJY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRcJa/ti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091273F8E0;
	Wed, 21 Feb 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514073; cv=none; b=JMrUKhOoWzhjdY7XK97T+w7PdrNRVbvgwl1PlXtQ5rPwlMYaSeLinbSVaFDPnGaCUdsRtdzC6nPYSLLhbjauv3+4dpFNa3oF9puNEekwwA347zDDHE4whIUo9wvTrmd8Yzo1eCb7P4CR3kXyckIfRecJM+xvyhfeUY/C+TZh/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514073; c=relaxed/simple;
	bh=X4PKlUGXGUBT6n4ZwlbiScUTkbbHPd6kRM2zdVKwFSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+ufod/G00MvMdC6MVlvAnF+um7aMHQpA9ds+V8LmrT/nplk49/OSdOUfuzQ+7OPDk5ftbtUvmBHjKciCBzsfxjggjyXiI0+xMDppXhAtBFphB2Fa8kpC2WyoeTM1P7HItOMSqt99+q8vTA1XybONHc7EHoQJF07WduSiAFT+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ga1g4CJY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRcJa/ti; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ga1g4CJY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRcJa/ti; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30AF621EC9;
	Wed, 21 Feb 2024 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708514070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqptqeC63/PQtZVEUM5DP4rj/btQZge0A7Gr5JvYGkA=;
	b=Ga1g4CJYiXXomuE05WOuqHhnjbhcVdBDeoH5K6B8VkAHddKgoOLrWs1XTCxUwNQQPwl2bj
	Vx8wMBnOJB9eOCe5M+X2WYcoG3RcjX9rC36ajDViSFpsP+RZ6kA+kVTXZDwWgibpbMuCBA
	ZEYcYA84xNxoe0mCBiImuAVoQUUbHX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708514070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqptqeC63/PQtZVEUM5DP4rj/btQZge0A7Gr5JvYGkA=;
	b=kRcJa/tiDAN/1qlRbQTAUIEOltL9Wn5W0tEf2/FUs0YwdWmBcK6EmMF6SP3WCKgmXDrXoS
	su2LLbcmuKW69JDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708514070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqptqeC63/PQtZVEUM5DP4rj/btQZge0A7Gr5JvYGkA=;
	b=Ga1g4CJYiXXomuE05WOuqHhnjbhcVdBDeoH5K6B8VkAHddKgoOLrWs1XTCxUwNQQPwl2bj
	Vx8wMBnOJB9eOCe5M+X2WYcoG3RcjX9rC36ajDViSFpsP+RZ6kA+kVTXZDwWgibpbMuCBA
	ZEYcYA84xNxoe0mCBiImuAVoQUUbHX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708514070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqptqeC63/PQtZVEUM5DP4rj/btQZge0A7Gr5JvYGkA=;
	b=kRcJa/tiDAN/1qlRbQTAUIEOltL9Wn5W0tEf2/FUs0YwdWmBcK6EmMF6SP3WCKgmXDrXoS
	su2LLbcmuKW69JDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BBFA13A25;
	Wed, 21 Feb 2024 11:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DCLBBhbb1WUDIAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 11:14:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9F41A0807; Wed, 21 Feb 2024 12:14:25 +0100 (CET)
Date: Wed, 21 Feb 2024 12:14:25 +0100
From: Jan Kara <jack@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Jan Kara <jack@suse.cz>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Guo Xuenan <guoxuenan@huawei.com>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [readahead]  ab4443fe3c:
 vm-scalability.throughput -21.4% regression
Message-ID: <20240221111425.ozdozcbl3konmkov@quack3>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402201642.c8d6bbc3-oliver.sang@intel.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.49%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Tue 20-02-24 16:25:37, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed a -21.4% regression of vm-scalability.throughput on:
> 
> 
> commit: ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ("readahead: avoid multiple marked readahead pages")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: vm-scalability
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> parameters:
> 
> 	runtime: 300s
> 	test: lru-file-readtwice
> 	cpufreq_governor: performance

JFYI I had a look into this. What the test seems to do is that it creates
image files on tmpfs, loopmounts XFS there, and does reads over file on
XFS. But I was not able to find what lru-file-readtwice exactly does,
neither I was able to reproduce it because I got stuck on some missing Ruby
dependencies on my test system yesterday.

Given the workload is over tmpfs, I'm not very concerned about what
readahead does and how it performs but still I'd like to investigate where
the regression is coming from because it is unexpected.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

