Return-Path: <linux-fsdevel+bounces-50919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E672BAD1054
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 00:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402CE188BFA3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566720D4E7;
	Sat,  7 Jun 2025 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ruGeQyzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049952CA6;
	Sat,  7 Jun 2025 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749333880; cv=none; b=t2eHtLVLCYlpdP8Ln87DZHfODRHWN0yniOgEMXgIr00/fGhJOzw2+Uz7Hzt/noliV03q+W++MdyVtZZ6ZQMIhCt8ZdXjOEpg6+QeK3Y/qUp6DltsFwttiZadf+mE8pTz/8fF6zQAha/frlgnPUYC8HjXkclJi0TEvMQY9wz/Fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749333880; c=relaxed/simple;
	bh=G2MnUUs0U0Le3lcVdNFBvTiIpbN1wuNWqN27lqPTBjQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GXn4H1ay29F/3xV2Lsk7qNpjnatmM1xnY90fA+l28QbsddXFErVk7D4CFRlYhdfSSD8HOmstYnGK8f3E7B7INaqkYjlivZs/BA0BMxN3i7QZPlxnzthz6dyjnshPpEzOoWB//AglS4p+/pbSAI0oYMoe1PZLmZ5lA6QBPJciRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ruGeQyzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17520C4CEE4;
	Sat,  7 Jun 2025 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749333879;
	bh=G2MnUUs0U0Le3lcVdNFBvTiIpbN1wuNWqN27lqPTBjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ruGeQyzHsQaq+X78VMgpY1ZDQhm6RtkyZ/6OzWx+SzJLHT7TGoSti4hTJhed5JsZW
	 NgZ1cktkluKeCfwXe20k5km8AtpJAfUia4b7p5DuphZl6gOedbeEzTuv1jSXDDErR+
	 K+MI3jkdS9ZFCTdiTXDTfe71bXKkP3iBxegHhizA=
Date: Sat, 7 Jun 2025 15:04:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Peter Xu <peterx@redhat.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 David Hildenbrand <david@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Message-Id: <20250607150438.4439e19f74693445212d93df@linux-foundation.org>
In-Reply-To: <20250607-uffd-fixes-v2-1-339dafe9a2fe@columbia.edu>
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
	<20250607-uffd-fixes-v2-1-339dafe9a2fe@columbia.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 07 Jun 2025 02:40:00 -0400 Tal Zussman <tz2294@columbia.edu> wrote:

> vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
> The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
> allowing VM_DROPPABLE regions to be registered with userfaultfd.
> 
> Additionally, vm_flags is not guaranteed to correspond to the actual
> VMA's flags. Fix this test by checking the VMA's flags directly.

Wondering if we should backport this.  afaict we don't know the
userspace impact of this because nobody has tried it!

