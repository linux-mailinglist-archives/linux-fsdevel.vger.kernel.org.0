Return-Path: <linux-fsdevel+bounces-45451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7AA77D70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA59818875FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E924204864;
	Tue,  1 Apr 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lab9yKVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA22CCDB;
	Tue,  1 Apr 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516856; cv=none; b=C7ZdQg62pK3CwPzcUcSsK6LEYvsWt1CVLaUYenXJw72O5MVKR23r5g8kj5oqAeunnjYKi4XeF/Y1k7dbZLTYooknRFcu1Sf1fe9Ada2s/o0pjBvki/l6AJRY/o08/g/8VY4vxU9p2t7lqYU661VeV4/gEb8t3XzmpCTgWrZbu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516856; c=relaxed/simple;
	bh=pfww1HNIhX2W5e2p8Rt3s+mhdpaIwMwHArsMA4l2kzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2Y0ggYytecIvHvQ6vlYK+esA7mzxmOuR1f9KXlmpl+RlhW14GXt3TqIiFkREI4rA2t/ykj3y65F/GU2toMnsxXj6bC26cWwCEO34aur/o2XK/H+5cE5wb+r9tEpRq7rzSSjHl+LybpDhdm9Zx+crmjMbEsmu8zCUmwlM26pRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lab9yKVN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z+1jhJsrt5pd24RiVBmd8llv61EuQXGt++6EKuQpt3Q=; b=lab9yKVNjzRTmzv2vqjTz/W4ou
	RSJoGookb++Txka+rMabWIU+DDuzyfSFkuhB9UeBF/drIStf0TD5eq0I9itGgqObtA52b1qnDecIb
	dVgerrkukiUuIcySdypgvCWkm3cHuJuSLRtZo2mABPrZxs0KpzDNER7LwRLlMuLvy0CmfUsU09xwA
	6U32skHrc0hCQdZroHC6nEY5+jwXHiGr+BV/dYT8qOwRdW/I+K/MDR1HUeqb4zUkGRv6rn/YM7H7d
	+RchJ7Jz0EcnzacUiOmta/Ub8QJytGTCdio1oQ9T4pyW2+b47cbxasA3Mqhf+PAvlqQeVSGbNE446
	AtIT8AFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzcNT-00000006pSO-373V;
	Tue, 01 Apr 2025 14:14:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31E9730049D; Tue,  1 Apr 2025 16:14:07 +0200 (CEST)
Date: Tue, 1 Apr 2025 16:14:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, rafael@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com,
	djwong@kernel.org, pavel@kernel.org, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250401141407.GE5880@noisy.programming.kicks-ass.net>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>

On Tue, Apr 01, 2025 at 02:32:45AM +0200, Christian Brauner wrote:
> The whole shebang can also be found at:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> 
> I know nothing about power or hibernation. I've tested it as best as I
> could. Works for me (TM).
> 
> I need to catch some actual sleep now...
> 
> ---
> 
> Now all the pieces are in place to actually allow the power subsystem to
> freeze/thaw filesystems during suspend/resume. Filesystems are only
> frozen and thawed if the power subsystem does actually own the freeze.

Urgh, I was relying on all kthreads to be freezable for live-patching:

  https://lkml.kernel.org/r/20250324134909.GA14718@noisy.programming.kicks-ass.net

So I understand the problem with freezing filesystems, but can't we
leave the TASK_FREEZABLE in the kthreads? The way I understand it, the
power subsystem will first freeze the filesystems before it goes freeze
threads anyway. So them remaining freezable should not affect anything,
right?


