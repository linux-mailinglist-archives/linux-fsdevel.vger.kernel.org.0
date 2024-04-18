Return-Path: <linux-fsdevel+bounces-17232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6CA8A95CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C13283150
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B715AD95;
	Thu, 18 Apr 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYhmEVhy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pjd5L9qW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BB15AAC0;
	Thu, 18 Apr 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431879; cv=none; b=n2a67KqRxFzpY51iaI/NBhWbCXYWLyK/CNx8aNXuPPJxWIBZOICuiygOJdQF4dzEP0cwp9FYCWtIgROhIyPaPg1Hj8mleoPNX+LTZlIooB2bvAUzgAPXeLeOE+nKuipjce3NAoH64ufL+WadOymPiNneivxtgJIrFGy5RGIamTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431879; c=relaxed/simple;
	bh=YxaYhJG2YQxWNDuqETRxUhxSQmmg06Q1LDv1Ima5z6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhi7tDEMn4qj6/3kpGtUPgw7WlQBIp509VwqazbCvCfMEM2qzkfZdPkStmJ/FHCVw9MCqs5cTrZQ+MST6EMTuQw9fMNgviskMwRQbsLZIvMy9fgWgiW+9r3kOipVYgtAi7qyaEC11wRu6qYgjrQfHz1SZox/20YTuDOmRZHUURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYhmEVhy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pjd5L9qW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 11:17:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713431876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oueb3ytqZ96zkn2QKrFrNWUZdLKfS4yQ3a5dkMeXex4=;
	b=kYhmEVhyg3DkkbnTYmIlxS/bFKU84wNu8BpFe4KuGjFRC45Ju9pdzyjfTIiEg9+oAknHqK
	chFRwQ33lTb9Hp9QE54aDK1i9iliWAq4BzCL6P3dVD2wtIn/b/Vezhmi2/S5JMp8Vtm/qf
	PwiUnqvezDYFBv5OAzF3OKQE1kN+JQUnqUkjfMmHCiB7VHEAAxL37u8txbRbfqLmOzUKsK
	JN67eqLCJTC8j3uBGTLQZ3SRw4MLkH5/FER5cSATmZu2Gbxs4THKcExo6fGUzO8a4fmtN8
	tDiauRnpC0R2PkfZDLbrxdR1Aki8epCDaqVjKOuXqsaamIQUeONwF4BvKGDGBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713431876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oueb3ytqZ96zkn2QKrFrNWUZdLKfS4yQ3a5dkMeXex4=;
	b=Pjd5L9qWrP4A+6OlCBgjPk/bKfRDPSbEyBQGI8KS/tK/1yQbRHFlQx2CK1cL5UpXoDRFRc
	YqcsqTsBuFMHmWAQ==
From: Nam Cao <namcao@linutronix.de>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Mike Rapoport <rppt@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Alexandre
 Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240418111753.1c485974@namcao>
In-Reply-To: <1F07FFF3-663B-43D4-A9DA-C89856F2962A@dilger.ca>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
	<8734rlo9j7.fsf@all.your.base.are.belong.to.us>
	<Zh6KNglOu8mpTPHE@kernel.org>
	<20240416171713.7d76fe7d@namcao>
	<20240416173030.257f0807@namcao>
	<87v84h2tee.fsf@all.your.base.are.belong.to.us>
	<20240416181944.23af44ee@namcao>
	<Zh6n-nvnQbL-0xss@kernel.org>
	<Zh6urRin2-wVxNeq@casper.infradead.org>
	<Zh7Ey507KXIak8NW@kernel.org>
	<20240417003639.13bfd801@namcao>
	<1F07FFF3-663B-43D4-A9DA-C89856F2962A@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-17 Andreas Dilger wrote:
> On Apr 16, 2024, at 4:36 PM, Nam Cao <namcao@linutronix.de> wrote:
> > However, I am confused about one thing: doesn't this make one page of
> > physical memory inaccessible?
> > 
> > Is it better to solve this by setting max_low_pfn instead? Then at
> > least the page is still accessible as high memory.  
> 
> Is that one page of memory really worthwhile to preserve?  Better to
> have a simple solution that works,

Good point.

> maybe even mapping that page
> read-only so that any code which tries to dereference an ERR_PTR
> address immediately gets a fault?

Not sure about this part: it doesn't really fix the problem, just
changes from subtle crashes into page faults.

Let me send a patch to reserve the page: simple and works for all
architectures.

Best regards,
Nam

