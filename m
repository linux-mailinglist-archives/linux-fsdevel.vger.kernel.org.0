Return-Path: <linux-fsdevel+bounces-23072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B718C926989
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 22:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C010B23634
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB718FDB5;
	Wed,  3 Jul 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GvoV2t2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1A136678;
	Wed,  3 Jul 2024 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038415; cv=none; b=ib9C0rqYBO1wwzQhIsWkOLz/BmQr2cRVSzbpqCGrmScJoY3n95phDR1kfowL+iYyUgikdJ1j4qGhSLUP/QrL1y6WOfRT17tT2itZGh7QHV1xpnVykxYnT3fvjNZ8MuMGlZ5NIy27+ggmtFlxRjcN3zyYsq6JnAkBSxDB5Uo1ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038415; c=relaxed/simple;
	bh=s6DsFyZn/wW3Wj6FhmgTr6w6StdImQV4cUTcdZC4Htk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TTO96H3LRweJoDA3oKWxCOzFkchnnzOqjjiYDHtLJsRHJr4g5uURj0TVRuwXS1kxWJAI8f1hFL62CKVOnNby5DVArZJ7Pofaw96pBIl7w2dQbdjHZh8MDiD5YlBuMXcYxNWrJTAz2ny/jXjKu3PmkmDaf4bBXGIXrQ6x2uI3+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GvoV2t2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A5EC2BD10;
	Wed,  3 Jul 2024 20:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720038415;
	bh=s6DsFyZn/wW3Wj6FhmgTr6w6StdImQV4cUTcdZC4Htk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvoV2t2YT98ecQnFA6y4k1+dwQvEQ8iWrM0rR/NBRFpElWfmHhCPHCfzZ8EbKar+W
	 RgQGtLo0xqk31pieNZboOLUWdI9heRReCSxpWjtOQJEW5EMyjA49VBStVsBvGtSX5O
	 lKug6BZs4YXVKJ3MwiR7o8Yozb8le21YXkWHpQT0=
Date: Wed, 3 Jul 2024 13:26:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Message-Id: <20240703132653.3cb26750f5ff160d6b698cae@linux-foundation.org>
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
> which contains a fully functional userland vma_internal.h file and which
> imports mm/vma.c and mm/vma.h to be directly tested from userland.

Cool stuff.

Now we need to make sure that anyone who messes with vma code has run
the tests.  And has added more testcases, if appropriate.

Does it make sense to execute this test under selftests/ in some
fashion?  Quite a few people appear to be running the selftest code
regularly and it would be good to make them run this as well.

>  51 files changed, 3914 insertions(+), 2453 deletions(-)

eep.  The best time for me to merge this is late in the -rc cycle so
the large skew between mainline and mm.git doesn't spend months
hampering ongoing development.  But that merge time is right now.

