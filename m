Return-Path: <linux-fsdevel+bounces-12511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0538601BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DDE288468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5914B82F;
	Thu, 22 Feb 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N+pn9yTb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgvBuxX7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N+pn9yTb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgvBuxX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73714B827;
	Thu, 22 Feb 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627085; cv=none; b=PrCXR4+ESDoyKti1YHs7+WET49VZHmMsNWwhLXeAzKKuCccx597h8eoh44k8SF8CYBeN65/sw+QN2jT7pPjSkrCzNw4sVjlFY2e9gWPx6Xo2ctUQaaPXSvvTTk2MGYl0XiWtkkrXKtZxbJxW4+A6x44idxthjSUG7PDVgG3DgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627085; c=relaxed/simple;
	bh=8vYNCqNNX89BjSsPSWBHrVLZtTK9S9blY5nV8P91NOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWJQTWQGB8d0yaByhVqjlVj9ERMVWrEUvo2mEL49sdFZI3uY+wG2U0zctKO1vQuStFLyvZWYicp+qhUXLv0MhftByenr+1voYtoOD+YwEFGbm+hmjtVdSoq5dg3TO02zCtLB9MQl+3Q0p5ZTP1eHp+Fh/DdLWrypFvT9P36HAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N+pn9yTb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgvBuxX7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N+pn9yTb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgvBuxX7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24AA51F78D;
	Thu, 22 Feb 2024 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708627081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCBA+iiqNypvt9FIAH32F6GqtCLU6aMV152Z2G6fwkA=;
	b=N+pn9yTbIexOSNFKOOlEUDM0nUL3NCTHnNbebCxq5fOyfc+yPYgOoCxV6KW6OEYfXLx2Xh
	PbCl65G5UW8ImgLhCf/lfCH02mpKKIvDVoDC2wvsj8O1CVSSBx9DC3P/n/R58IzzWBIqlb
	3zKlUhaAo5s8ijOxN4PeR3vCjgbqhjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708627081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCBA+iiqNypvt9FIAH32F6GqtCLU6aMV152Z2G6fwkA=;
	b=VgvBuxX7qt8PJeUdvuYXjjyW31WowyfMW1Jgw31+H9DYlRDJe4WSjse3FFBFl8AxXry0Wx
	/AKVjSpevgQJdCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708627081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCBA+iiqNypvt9FIAH32F6GqtCLU6aMV152Z2G6fwkA=;
	b=N+pn9yTbIexOSNFKOOlEUDM0nUL3NCTHnNbebCxq5fOyfc+yPYgOoCxV6KW6OEYfXLx2Xh
	PbCl65G5UW8ImgLhCf/lfCH02mpKKIvDVoDC2wvsj8O1CVSSBx9DC3P/n/R58IzzWBIqlb
	3zKlUhaAo5s8ijOxN4PeR3vCjgbqhjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708627081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCBA+iiqNypvt9FIAH32F6GqtCLU6aMV152Z2G6fwkA=;
	b=VgvBuxX7qt8PJeUdvuYXjjyW31WowyfMW1Jgw31+H9DYlRDJe4WSjse3FFBFl8AxXry0Wx
	/AKVjSpevgQJdCDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1376D13419;
	Thu, 22 Feb 2024 18:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yW14BImU12WrGgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 18:38:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C61DA0807; Thu, 22 Feb 2024 19:37:56 +0100 (CET)
Date: Thu, 22 Feb 2024 19:37:56 +0100
From: Jan Kara <jack@suse.cz>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jan Kara <jack@suse.cz>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Guo Xuenan <guoxuenan@huawei.com>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [readahead]  ab4443fe3c:
 vm-scalability.throughput -21.4% regression
Message-ID: <20240222183756.td7avnk2srg4tydu@quack3>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
 <20240222115032.u5h2phfxpn77lu5a@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222115032.u5h2phfxpn77lu5a@quack3>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 12:50:32, Jan Kara wrote:
> On Thu 22-02-24 09:32:52, Oliver Sang wrote:
> > On Wed, Feb 21, 2024 at 12:14:25PM +0100, Jan Kara wrote:
> > > On Tue 20-02-24 16:25:37, kernel test robot wrote:
> > > > kernel test robot noticed a -21.4% regression of vm-scalability.throughput on:
> > > > 
> > > > commit: ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ("readahead: avoid multiple marked readahead pages")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > testcase: vm-scalability
> > > > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> > > > parameters:
> > > > 
> > > > 	runtime: 300s
> > > > 	test: lru-file-readtwice
> > > > 	cpufreq_governor: performance
> > > 
> > > JFYI I had a look into this. What the test seems to do is that it creates
> > > image files on tmpfs, loopmounts XFS there, and does reads over file on
> > > XFS. But I was not able to find what lru-file-readtwice exactly does,
> > > neither I was able to reproduce it because I got stuck on some missing Ruby
> > > dependencies on my test system yesterday.
> > 
> > what's your OS?
> 
> I have SLES15-SP4 installed in my VM. What was missing was 'git' rubygem
> which apparently is not packaged at all and when I manually installed it, I
> was still hitting other problems so I rather went ahead and checked the
> vm-scalability source and wrote my own reproducer based on that.
> 
> I'm now able to reproduce the regression in my VM so I'm investigating...

So I was experimenting with this. What the test does is it creates as many
files as there are CPUs, files are sized so that their total size is 8x the
amount of available RAM. For each file two tasks are started which
sequentially read the file from start to end. Trivial repro from my VM with
8 CPUs and 64GB of RAM is like:

truncate -s 60000000000 /dev/shm/xfsimg
mkfs.xfs /dev/shm/xfsimg
mount -t xfs -o loop /dev/shm/xfsimg /mnt
for (( i = 0; i < 8; i++ )); do truncate -s 60000000000 /mnt/sparse-file-$i; done
echo "Ready..."
sleep 3
echo "Running..."
for (( i = 0; i < 8; i++ )); do
	dd bs=4k if=/mnt/sparse-file-$i of=/dev/null &
	dd bs=4k if=/mnt/sparse-file-$i of=/dev/null &
done 2>&1 | grep "copied"
wait
umount /mnt

The difference between slow and fast runs seems to be in the amount of
pages reclaimed with direct reclaim - after commit ab4443fe3c we reclaim
about 10% of pages with direct reclaim, before commit ab4443fe3c only about
1% of pages is reclaimed with direct reclaim. In both cases we reclaim the
same amount of pages corresponding to the total size of files so it isn't
the case that we would be rereading one page twice.

I suspect the reclaim difference is because after commit ab4443fe3c we
trigger readahead somewhat earlier so our effective workingset is somewhat
larger. This apparently gives harder time to kswapd and we end up with
direct reclaim more often.

Since this is a case of heavy overload on the system, I don't think the
throughput here matters that much and AFAICT the readahead code does
nothing wrong here. So I don't think we need to do anything here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

