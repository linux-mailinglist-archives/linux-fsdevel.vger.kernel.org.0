Return-Path: <linux-fsdevel+bounces-33799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFAD9BF068
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC701F219B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77482022C1;
	Wed,  6 Nov 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S3Dt5grQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGySzyAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF891917FF;
	Wed,  6 Nov 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903550; cv=none; b=ejLhmg8ZchaaEF+BA1FDOHyekdC3hV07/nmD392bY4Xmuq2TMPbCO944ssvmS48IBDOH5cEZ6YTzt71GFCuDjAtHnvm2V86u3cOOzwvnazydsVJaElKaBQdYEc1WEdJ4qKgVYScWJTIKRyxJ8bnz7k4gnf3r9Uf/cn7Av6NYq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903550; c=relaxed/simple;
	bh=P8h5oDz9fnH0URFEQE7KPe+OypR1nRSTtAEtQ2gRETk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYzj36NWZsDL8CZ2imwQ6IS+wDqoCOQLdv1GOXafOWZW6jxw/rZ+/EsPyjh0NPgzrwJfAxJJ4mEQbCI5Ep6OjiY6Xc6DmaTPRzX/ybQU1WBTyZ/JvrVYOYmqDEvQq2lAKhLjDqFlYkFtnwfJwJBco9abjSXJThz08hZo+tV6TvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S3Dt5grQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGySzyAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730903546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8h5oDz9fnH0URFEQE7KPe+OypR1nRSTtAEtQ2gRETk=;
	b=S3Dt5grQvG76Zz9A5N5xrwkVB0V+5RCrQbsnGwGju2niNiM4i9r8wFvK7Zi2tPeIJysU6k
	Tqj0GMxAe7/zIFyCrEklezpljO+WKgAlTvDvg2SRrFD4VDcEHH2VuQcVyz4HwNyNfcdf3Y
	AB7jbfna1nlbbQowPgwZ+L4XfbctOaC2PnVohtNwVesQp4h0GAdS5d0b88O44YArHakX2c
	xoYeeNEg49sbhcSQLAgGgQ/8Ra/ypggX5ZsdMbGZh3c2QKIhVZQq6YPi2S6w5GJHIAG4Uy
	88A5YVD8xHxmqFAVXp2aPucpEpYeRTXCI8Y+vpguH/uwa8r+xl2CkE82/5XqaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730903546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8h5oDz9fnH0URFEQE7KPe+OypR1nRSTtAEtQ2gRETk=;
	b=zGySzyAFI3/hPcXFEHROpmpuhLceTdNuNTMyBZHCvTC0tIp/nOnIiwrekiObeaGIZftpJM
	NavCdCF7t6erxbBQ==
To: Nam Cao <namcao@linutronix.de>, Shuah Khan <shuah@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Dylan
 Hatch <dylanbhatch@google.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 2/2] selftests: coredump: Add stackdump test
In-Reply-To: <66d3fbd62cc1a658ce4f77eb907f8737c467fdbf.1730883229.git.namcao@linutronix.de>
References: <cover.1730883229.git.namcao@linutronix.de>
 <66d3fbd62cc1a658ce4f77eb907f8737c467fdbf.1730883229.git.namcao@linutronix.de>
Date: Wed, 06 Nov 2024 15:38:25 +0106
Message-ID: <845xp0fn5y.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-06, Nam Cao <namcao@linutronix.de> wrote:
> Add a test which checks that the kstkesp field in /proc/pid/stat can be
> read for all threads of a coredumping process.
>
> For full details including the motivation for this test and how it works,
> see the README file added by this commit.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

