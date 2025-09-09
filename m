Return-Path: <linux-fsdevel+bounces-60618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1CB4A281
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 08:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F3B7AD261
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D5303C81;
	Tue,  9 Sep 2025 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i6eCdJim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE22303A01;
	Tue,  9 Sep 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400120; cv=none; b=m4rYRohc10RQRQqyYqkIun+HiPv+dyRvSf7d6/pKfMNsEtHIZDuC/zHL2m7iECgJ+P28O0nMavkdCG/Yi7naf0ASO0FaePDB9ZAfYmc7n67ohr1LOO8BxnEjppx/gwW5nxMZfXXkutgFZzrWpUzOqBQxZJVrh5qlTDvbi7NTej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400120; c=relaxed/simple;
	bh=z9USPhHY+9Jdat5kLEGPJra+nU71S84ypnUOyEpudyU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BGAyj295o2T9jArpQoXxsNLzDyjFAx2qVCk7/zw8Ahvsg0ZD/rNU4ntnVfJz16ZHr+TEXIF36yzV/UFUaLMl8j8CA73tqqIieFvSVmeNyvoZ7PbBAzhETWIbrPVoyeuKg96JbKzWqJkilso+YNtUIPvN72XTOwrKD+hB+QiWquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i6eCdJim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D94C4CEF4;
	Tue,  9 Sep 2025 06:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757400120;
	bh=z9USPhHY+9Jdat5kLEGPJra+nU71S84ypnUOyEpudyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i6eCdJimsH7UduTxeneMp12UCWtoA686ChRmjfa2V41DB9KViGwygBjNs2mPN4gYd
	 xFa6ux6/vPlFwRaAyjcA+Jo20+xRxOkFhdkTj3m1+/GCa77hnN+t7tQCdMNkkyQGrl
	 dZK0O1Irshrlw0ro5kpeFROad4MAdnzpVg9iTf+Y=
Date: Mon, 8 Sep 2025 23:41:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chizhiling@163.com, Youling Tang
 <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-Id: <20250908234159.01dcceb3be97d4db541cf686@linux-foundation.org>
In-Reply-To: <953544be-1be5-4745-a027-e8c0be7b027d@linux.dev>
References: <20250711055509.91587-1-youling.tang@linux.dev>
	<jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
	<afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
	<20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
	<bv4t7a6boxh4dmjl7zsmhd74wm5hyfpdivypmrqerlpn23betz@tw52mlf4xf3s>
	<953544be-1be5-4745-a027-e8c0be7b027d@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 14:15:12 +0800 Youling Tang <youling.tang@linux.dev> wrote:

> I see there are two fix patches for my patch in the mm-unstable
> branch, should I send a v2 that incorporates these fixes, or is
> it not necessary?

That's OK, thanks.  Before sending upstream those -fix patches will be
folded into the base patch and appropriate changelog updates will be
made.  So the end result is as clean as we can make it and the various
updates are shown.

