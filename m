Return-Path: <linux-fsdevel+bounces-75697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ChWJ3iXeWnSxgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 05:58:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC79D1DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 05:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28BD3014113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DDB33291A;
	Wed, 28 Jan 2026 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PKJoiaAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A72144D7;
	Wed, 28 Jan 2026 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769576292; cv=none; b=SUfviBpWro2a8QNRL50Wig6XK8Q1IXe7qu2CYwT1Lzt3eUDJdfXksvZMtvvfc3chHjpchJNmqaL1oS52QnGy7RUsv02qvVLeVmWl0Svq9RTzQ1Qa47Dvtm97EgPn+ljajNRDc2FWg3VmrX4gpXSs6phSGiAO+nfs/gzr1wqezl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769576292; c=relaxed/simple;
	bh=HPTDEhsdkkZGj61ILgUyYDUIsm4tG50xsMeSLWhJykw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE4b0m0lVKQPg/bCSd1Gzx5EB3eigSx89jAzFBNFfv8dHF/lR2OI8GBOJju4QLQsmvaNtz4iukb3F3gvE2i2fcIcmpm7OGvCipY4v03S09jelZqaJG4M3urF0BhUYK9goJi8gTW9Omz8g5KySB7n0JcSNxADp9Gya1L2vDx3008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PKJoiaAI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=daXjtGTfmlVfqWEsV/tKRDwuwZG19vc4O33UsaVuyC4=; b=PKJoiaAIeJUIezjpIUvwLfhLOU
	ljSMzyiy8niSruUOPj8Yhae/1tEMXXOfdDkBPWvk228fa+x3gT5ziOetsoIlPS6qPOcomc49/VYEg
	TXRw9lJUhkDbPABnmZAwnrgsKAmLUH7AQ4AnGZOBwiLlkTJITaGg5cRexxsqxsIPyy0pfvevgI10V
	EkVCPliHzrpbNBjpdQZtf8BtLMu9Kcsy7J4hQT6WtNuW7LYoAAzyuI/C3HY4Xp5Pm7lL1/zj5aQ3N
	KpLYJej9U/8afrfofjKQFQuivnbtyPIWzjnE64luVJY6SlrAo9HkNbF8Ew4ypXGp7RUjQj7TvDxC5
	7aSVGjaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vkxek-00000007aLd-3OJ0;
	Wed, 28 Jan 2026 04:59:54 +0000
Date: Wed, 28 Jan 2026 04:59:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Samuel Wu <wusamuel@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <20260128045954.GS3183987@ZenIV>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-75697-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8BC79D1DD
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 06:02:25PM -0800, Samuel Wu wrote:

> Thanks for the suggestion. I tried a few different setups, and now I'm
> fairly confident e5bf5ee26663 ("functionfs: fix the open/removal
> races") is the culprit. I did have to revert 6ca67378d0e7 ("convert
> functionfs") and c7747fafaba0 ("functionfs: switch to
> simple_remove_by_name()") to successfully build, but reverting only
> those two in isolation did not fix the issue.

Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
demonstrate that behaviour?

