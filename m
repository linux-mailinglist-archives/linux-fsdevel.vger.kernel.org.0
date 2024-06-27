Return-Path: <linux-fsdevel+bounces-22647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEC91AD52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973212893E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A719A28A;
	Thu, 27 Jun 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYtDAnXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1179199E95;
	Thu, 27 Jun 2024 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507490; cv=none; b=pLq5zQye5rAtYPZCNA3MqWknO3iJ+Eu4n3yjo7lBSaabWwSX+lNS9mrgIk2pi2jQnNAGjBP9TfEe3fRt8m4eoL29o30ccpUDxdHFjjBMzOfbU5vIhV+dEWhT2qCKde2BsqjVP2HAAmfGAiQUvQJ9XOkqht7JJGtF64SnBKrvVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507490; c=relaxed/simple;
	bh=I8ppiniqXqp4jaz3xIiwGQVWKxxp90g1G72xDqOJGb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrxECuRpI3OQKLzwcm3wdDS+N1NibRL4+IrOMKJQ4c69vA5S4l9ixB74xY4fjyUTJEQJhMRl79UoL7rzCidZfMgHw6eOxNnEtC18TGjwA+pzmkRBfiWnnRyb5uyvi310s9AQsFhBSK8qKH8bcieIC6IiPps0cFkkmAuZK83mmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYtDAnXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC81C2BBFC;
	Thu, 27 Jun 2024 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719507489;
	bh=I8ppiniqXqp4jaz3xIiwGQVWKxxp90g1G72xDqOJGb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYtDAnXTl5sb4XG9Y48nUs+xRJMg1Gr9sQgKhA7piJf3b3Lhq7mkqSvNldEjqAJqK
	 YH9pxFUvwNZtHRtjzedOUHT0++nSMVlx6QO/vcZnwc85tKMWpjPrHmF6boCGrjGmb3
	 HxqCZ7zIqlgncRHAJU+Lt+3StOIfs8HuS0oLG+GhpZ5zurojABaQ784u77XTrcMOIh
	 BgtHhvspVTYkagYwgl1YjIJFycOlNRHERdwhbKCUKCMF/on5peEzT0hk+RRtcNsYy1
	 8395n3pDBqqj7WvWN5q2ey1OpOZ6fcz3WSxNRZGze9OUv9fwJayOpqoAUVZKjgLZoz
	 rK+W/lCY27Mfg==
Date: Thu, 27 Jun 2024 09:58:08 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <202406270957.C0E5E8057@keescook>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>

On Thu, Jun 27, 2024 at 11:39:32AM +0100, Lorenzo Stoakes wrote:
> Establish a new userland VMA unit testing implementation under
> tools/testing which utilises existing logic providing maple tree support in
> userland utilising the now-shared code previously exclusive to radix tree
> testing.
> 
> This provides fundamental VMA operations whose API is defined in mm/vma.h,
> while stubbing out superfluous functionality.
> 
> This exists as a proof-of-concept, with the test implementation functional
> and sufficient to allow userland compilation of vma.c, but containing only
> cursory tests to demonstrate basic functionality.

Interesting! Why do you want to have this in userspace instead of just
wiring up what you have here to KUnit so testing can be performed by
existing CI systems that are running all the KUnit tests?

-Kees

-- 
Kees Cook

