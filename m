Return-Path: <linux-fsdevel+bounces-57261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06727B20089
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FC8163F15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA112D9EE7;
	Mon, 11 Aug 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qTgp3xon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37520B812;
	Mon, 11 Aug 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898206; cv=none; b=U5kzM2AGeo9r2GzN9fp+5d74zwQRrE1xdWdnjEx+APAm87KMXZoLd5g3qa4sj+mUui8k4/txsksddqQoIdKdxglZqPEjIKlrQfVY9qCftDJQXwWXha7tXng8clCtVeWDtf5eBJpeBbpM69TSXiuk7JskFEbKYM8e18dUSUPcTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898206; c=relaxed/simple;
	bh=sr14k7YJFFXWl/2wn7YOnt+vqu6jKV7QyaK6o7oXevc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLBMO0cPgGRsvRpg7k+afTMkLApAeUbnd5tv9UJAzqUxkJEHTpjEbReFoT8/bgUUm/UNHpLh6akKkRWgZ7fQ0M+L5Yybqo+mNW+7kjiUHB7ojksA/XcSpHfeOVCeDwerjkCXjD3TRVl23bYH1ChjC9tcY/ch4PLK/C2b7rhWbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qTgp3xon; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 77AF514C2D3;
	Mon, 11 Aug 2025 09:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1754898203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzERkUETDBBGA2ETmuUH0JhyJyLgXNeY+djGZol+o1I=;
	b=qTgp3xontPexWALYl/mFt7pAjsHlucQTloBc0zv+6VQBjdAvAhUljOagTAYAJrgFJ+cLtc
	kusS7twLzcDBUvDBj+tHf5Kr6ePHjmCcqzGBIAAaTI84ml4Nl59oYUOuNCDZQQ9baclyJT
	aNgdgptvIK8ftpg5WA3Fdun4ohXQQg63Q28jDY1fUb0t3DhXN7MUuNueHmEut0fVHfi5tI
	cIbU+rnG4yeHhII26HTRn28TUwF9E2xQiLs2EPmzXlt3VA+Bdm51FDm03R43LU/rsceyRM
	aXrcnG7Ks0d5xdHrohrPs3+n0/w3rvZXf9rh67LKww9CECpqIKvIcLZOtrj4xw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id dd3250c2;
	Mon, 11 Aug 2025 07:43:16 +0000 (UTC)
Date: Mon, 11 Aug 2025 16:43:01 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnout Engelen <arnout@bzzt.net>
Cc: ryan@lahfa.xyz, antony.antony@secunet.com, antony@phenome.org,
	brauner@kernel.org, ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, maximilian@mbosch.me,
	netfs@lists.linux.dev, regressions@lists.linux.dev,
	sedat.dilek@gmail.com, v9fs@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <aJmfBTflGvAI6sBs@codewreck.org>
References: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
 <20250810175712.3588005-1-arnout@bzzt.net>
 <aJlAD0nPcR2kvAtS@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJlAD0nPcR2kvAtS@codewreck.org>

asmadeus@codewreck.org wrote on Mon, Aug 11, 2025 at 09:57:51AM +0900:
> Also I haven't been able to reproduce it with a kernel I built myself/my
> environment, but it reproduces reliably 99% of the times in the nixos
> VM, so we're missing a last piece for a "simple" (non-nix) reproducer,
> but I think it's good enough for me to dig into this;

(okay, I got this to work wedging my kernel into the nixos initrd; this
requires the iov to be built off non-contiguous pages and so having
systemd thrash around was apparently a required step...)

So that wasn't a 9p bug, I'm not sure if I should be happy or not?

I've sent "proper-ish" patches at [1] which most concerned people should
be in Cc; I'm fairly confident this will make the bug go away but any
testing is appreciated, please reply to the patches with a Tested-by if
you have time.

[1] https://lkml.kernel.org/r/20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org


Thank you all again, and sorry I haven't had the time to look further
into this without a clean reproducer, this really shouldn't have taken
that long...
-- 
Dominique Martinet | Asmadeus

