Return-Path: <linux-fsdevel+bounces-50676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E2DACE5D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 22:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9510E1702A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE320E005;
	Wed,  4 Jun 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XL4tkwiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C731FFC74;
	Wed,  4 Jun 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069565; cv=none; b=Woqniq0m6eaHkxUEOD+RjkPOo+B0zdq0LuK5cx/jt4J/CGGvGfNNjTvMQCZRCvlqcMPdxH2zJpVa7qIfGgO/IgICDcFjtiditOdFxOZ1mQHkqPzEoKCmZsrllBTg5PO/AUZRVyO1mKs0zkQofGCOqXeARnCRt6JRZt+1VG8wZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069565; c=relaxed/simple;
	bh=FbrYkLwgHVon8bzZJisughgF/cDCMmUtkf222nnCiGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb9j2izbHikPar884N3HFwzEe0PFh1C1vrLPJ5CHYqWxk3xZwA6wvo0cWrHPNDSmtneDC9d0ijsAdzF4zxaKJTPOAhLUTQG6yft/+z5E5eVpGrlsZ/KvT9ypDJ/tuo16IQvkFWn50zPkQa8APt9azmjuCaOueZQD8Rgx9BZSJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XL4tkwiM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4MbGuvgTwlDQfIgTLxj57C+fxyl5EheXg1vFGfAxpY=; b=XL4tkwiM4DtsrXF7INLuQW4ify
	jJ2+aAMFv49vDIyNqLduuIy710fVtr7l8nsziZSrPX+TCKm1drToW7rkSf9E1XOK0LUauYgHBHzzx
	d33lmcRUSUAOijCOYNqhPoY/gNbYKN8VNG5egX4VCmo456zgxnGiY5ZtfofI0+YnmC6VHBx1gdom2
	cnHt5ZWEy576j47TsI/Jm2jUrMJh0WLWFvbl2zI1Sa4HB7b9OB5RG8n8LDOp+Fj38kAIkpyHhTuAd
	4yQ05cuur+YREIGDtglpXt0Bmoi6wdiWMv6uElqICFgd1KDDS8w6sIZgXaRl4P64oVMoSgCnWE8Tb
	ta6BE+hg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMutM-00000003U4L-15op;
	Wed, 04 Jun 2025 20:39:20 +0000
Date: Wed, 4 Jun 2025 21:39:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luka <luka.2016.cs@gmail.com>
Subject: Re: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
Message-ID: <aECu-D3Df28hYI9L@casper.infradead.org>
References: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
 <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
 <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>
 <20250604-quark-gastprofessor-9ac119a48aa1@brauner>
 <20250604-alluring-resourceful-salamander-6561ff@lemur>
 <bfyuxaa7cantq2fvrgizsawyclaciifxub3lortq5oox44vlsd@rxwrvg2avew7>
 <20250604-daft-nondescript-junglefowl-0abd5a@lemur>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604-daft-nondescript-junglefowl-0abd5a@lemur>

On Wed, Jun 04, 2025 at 04:11:21PM -0400, Konstantin Ryabitsev wrote:
> Yes, hence my question. I think it's just a bad medium. It's actually the kind
> of thing that bugzilla is okay to use for -- create a bug with attachments and
> report it to the list, so maybe the original author can use that instead of
> pastebin sites?

The "author" looks to be a bot, frankly.  At best yet-another-incompetent
user of "my modified version of syzkaller".  There's no signal here,
would recommend just banning.

