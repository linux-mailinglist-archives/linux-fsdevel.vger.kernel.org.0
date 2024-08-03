Return-Path: <linux-fsdevel+bounces-24911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABA94678A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 07:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B5B1F21957
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784C140E23;
	Sat,  3 Aug 2024 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jpkm0g9F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC842A82;
	Sat,  3 Aug 2024 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722663262; cv=none; b=TEa9hIVSiYZEs0vURGxyUCk9nMjwoB761lSq4sidygBUH1KvAhpPEp3kXMdDstSZjE2fUoqW0C/tMXFKAcFkd/sxNjGrc4J+EGd4V/XQblF0LQl9V8N3/t02KkxtTSbA6Yk4VGf9nhfEZ3WqzLDp4870U97DhRrHigZmgAcH2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722663262; c=relaxed/simple;
	bh=RTJ/1pk/bPsfauTST9+1WLafvUgR5Hy16K0lM1NDVsY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VJ5YbtxlNxy61kaDxk9wE/lvnZf6gXIK3kdNWdylWRT41ySMKDsejSjAEC1anlHXo2sD38HRZGMWgPxdjk8ZvdjAzzhhoMdUSKTQP8vzXPANvHh+SnCnoJxtbTsNi8T1SHfm226o/vdvOMgkNNsO4eMlaYu4QGDqyY9lKZbXKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jpkm0g9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E46C116B1;
	Sat,  3 Aug 2024 05:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722663261;
	bh=RTJ/1pk/bPsfauTST9+1WLafvUgR5Hy16K0lM1NDVsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jpkm0g9Fk6mUPgW4atphwEFKNbJ3kozqtJqzpkHeDgnjJkba28Yqq5im0/vyICX42
	 7eqHuDyLQBC0t0Lm5QbSbcTtTT4ej0b3AUejH17rXXb0wqqkP8TLHQ3Q7Lzs4aFb4X
	 FPu2P/QmQedPwqEyg2Dw28J4Yl46o+F1plTix2PM=
Date: Fri, 2 Aug 2024 22:34:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v1 00/11] mm: replace follow_page() by folio_walk
Message-Id: <20240802223419.3c189525b50f45d36afdbae3@linux-foundation.org>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 17:55:13 +0200 David Hildenbrand <david@redhat.com> wrote:

> I am not able to test the s390x Secure Execution changes, unfortunately.

I'll add it to -next.  Could the s390 developers please check this?

