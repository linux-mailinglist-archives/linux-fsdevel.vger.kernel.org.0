Return-Path: <linux-fsdevel+bounces-77040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FZLI90UjmmZ/AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:58:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A54511301B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EB49308A9FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503EE1A23B1;
	Thu, 12 Feb 2026 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqGM4AIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716422770A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919128; cv=none; b=uGeuSVOWxMHxeqNf82CF8yaOXkzw6ikG2LYoOVcpXbDK2O85oiFQeYMWsgRQpwCYh8DYuRpgdgGsgWE45s5yLNLaSzGyt8f99eqshJofpbLUcRaP65B/Zmjg+7+ms1bDA10k2waXSC2szTXD2w6PjD42A4ST24Iv1xPFeXloutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919128; c=relaxed/simple;
	bh=czniD9eVXu63A1Dr04VMk1rvEhfshkPs6aT8Ct2ynTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9uMQtN7xxXMBfKwHHdsQ5cEi15JoDfShU8wrv3kJjkHK00wB55ARXcggODqRH3hySszHPxBVdI2/S/GjoLgyiT9+v+KYoJYw9gQdTqufEOiB3xig11YJ6QPYSM5moQtT0+1l/g3iqBudecbejmwa9eb1LkkJEFtqBpWVCNtBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqGM4AIn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770919126; x=1802455126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=czniD9eVXu63A1Dr04VMk1rvEhfshkPs6aT8Ct2ynTw=;
  b=MqGM4AIn0EpKiTlOU0YUPvzQku8Nw5E4yTSCOfP+OlFIf7em3DDMtG4e
   yQoszM427jNVqPVlw6kaadMqG0NPLazRiCHlwLTk/ughBLcWdXfqYk3Nx
   2UEUNikfQ3ldEEnvS7VwHIFom9o4yMbWPZk9iN1w8h/ERHxLEcOhPlyQd
   Z2EEl+UXdYzk9znuSiQ5bbWe4Shq1wGbkeHm8+YHxO7XjPj9KPtFW2Nhv
   rMFUUedhgnyH+pHgW8YwGfyyzl2azGFThMVvuJZ1GNmYJmEP++WQKr0Lj
   BD5Q0cO5WrhirsuAwTOFoQzDnv1Qp71o/mIfLbfPweb+clwExZ7NL2jSB
   Q==;
X-CSE-ConnectionGUID: /tJcxAPURXioPXQq8sFUqw==
X-CSE-MsgGUID: INZfFL6yQIuVDBN3uVA0Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75944815"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="75944815"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 09:58:40 -0800
X-CSE-ConnectionGUID: zlg0fuHlTWOAJGxgt4BuRw==
X-CSE-MsgGUID: fcsycVijST2k8+6BxLyHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216836119"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 09:58:38 -0800
Date: Thu, 12 Feb 2026 09:58:36 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] smaps: Report correct page sizes with THP
Message-ID: <aY4UzC-X4a39wbG3@tassilo>
References: <20260209201731.231667-1-ak@linux.intel.com>
 <94a21bda-5677-4949-a1df-3f0d90348021@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a21bda-5677-4949-a1df-3f0d90348021@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77040-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A54511301B5
X-Rspamd-Action: no action

> We have AnonHugePages:, ShmemPmdMapped: and FilePmdMapped: that tell you
> exactly what you want to know.

.... if you know about it. I personally wasted a lot of time on it
because we trusted a lie.

> 
> Especially the mixed thing is just nasty.
> 
> Once we go into cont-pte territory (or automatic pte coalescing by hardware)
> it all gets confusing.

In this case it can be extended to more.

> 
> Sorry, NAK.

Okay then just remove the page size if it's fictional outside hugetlb anyways? 

I can send that patch too, but it would seem inferior.

-Andi


