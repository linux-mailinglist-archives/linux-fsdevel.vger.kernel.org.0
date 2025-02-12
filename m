Return-Path: <linux-fsdevel+bounces-41578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1EA32591
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065E91889DAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824B020B7F0;
	Wed, 12 Feb 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="alNKQk4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E442B9BC;
	Wed, 12 Feb 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361907; cv=none; b=d7oka9I0wwkKEVK0L9DsyJINaPQO5+IS+fEBTdpXf5U77K1ShfHQhp8iQi8uhVsWy1R85SoRyzhB5DuVtqgoL+XL1nbk45fEDLFkTTKa0pB5grL0HMGYgFfNipfB4pEjrm3lMSTA/E+5XQiMqYpAWBFcYBf3ErcBa3XScB/qVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361907; c=relaxed/simple;
	bh=XGhA7ATTKTn2MI6J3q5zmjDzFLGnOtyqBJHip6KokaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ6sxnJyH2LBbeyG/zPAneeRggToqNrGFLpBQo3NQmv30Qhus4KHH1Dg7rMRKTcBP+77XtsUlzeuz1qeEw3j0BC2L5rZDkyYOR94V5kLLBw7qU8vTaGno2sa3G+SBBCMfT65rGW6XJULMbe7FeW0CgP73dFL5UYpW+VEHse2KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=alNKQk4T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lc6YTD7pcTYKpPT5lM/vEVBDGdiQ39oWsR1rgPSjnH0=; b=alNKQk4TsVKg4AtCiFsEdcsFow
	hpqX5cbqfuWLIHoAiCdgqMJLACSNOGWMkomt+wDO35OWju/sbW3KLpJVnnN7OK48Xcc5ygE7IXruP
	LuAJx60vIH8620zKMCei/Jfklsc5cdnUmziBQaavNliwhH6uLeLZiL9n9GHIW56EgQhioef/kiO6x
	tVKaSDJ+rNREFenk5lnrR2VFljNvB9dy93e+Qu4ErhRXOx3okmN1uNSncagOoUAMIvIZDWXy0yrpd
	PX0VowD6ljTdHaOPRots7sW3yZqCX9sd9XXgLAlsSK1buZesVPHntKUSijCg/mZn+Xooy8NnNc5YA
	0EwYUafQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiBU3-0000000Bc07-3biR;
	Wed, 12 Feb 2025 12:04:51 +0000
Date: Wed, 12 Feb 2025 12:04:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Use str_yes_no() helper in proc_pid_ksm_stat()
Message-ID: <20250212120451.GO1977892@ZenIV>
References: <20250212115954.111652-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212115954.111652-2-thorsten.blum@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 12:59:52PM +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.

>  		seq_printf(m, "ksm_merge_any: %s\n",
> -				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
> +				str_yes_no(test_bit(MMF_VM_MERGE_ANY, &mm->flags)));
>  		ret = mmap_read_lock_killable(mm);
>  		if (ret) {
>  			mmput(mm);
>  			return ret;
>  		}
>  		seq_printf(m, "ksm_mergeable: %s\n",
> -				ksm_process_mergeable(mm) ? "yes" : "no");
> +				str_yes_no(ksm_process_mergeable(mm)));

Is that any more readable?  If anything, that might be better off with something
like a printf modifier...

