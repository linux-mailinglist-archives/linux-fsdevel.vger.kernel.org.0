Return-Path: <linux-fsdevel+bounces-25067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94B948863
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 06:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31D8283362
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 04:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F74176242;
	Tue,  6 Aug 2024 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqF9i57V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A1320C;
	Tue,  6 Aug 2024 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918799; cv=none; b=ab2tR+uO1B5YtVI09jFcKSi3auqQRrk4mrd38hwC8/67L7wcw4EXxHn0NwHAwI8u3Vb1zAn5j4e92ivHALxF2ynWiMenLZZjRBXM+V4WBwgZ2gxjk0NpkVOpViiha8CLsntvxvJmy8oIPeU50VFREdLUUKTa7/zv0jtn6J4eemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918799; c=relaxed/simple;
	bh=PZE4W39piTsyZVfoVSWQ2vHqB0rE9Is6oBhIkDMistg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiWmCmFlAH7gmU+VfJ2wyWcdPLfMJJj0v9SikpE6wxC1UmmNERuxITlD8iVuI0UQo6CZQMgMstXRdOxoEQtCc5Sza2XqDZSrl5z/SQiXkNMlwQJQ6AD10zp4ErMm1sm7MsG/2sxHD9UujqWWNuLyfk0lg5YX9MyOeQNGpjNYpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqF9i57V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA93C32786;
	Tue,  6 Aug 2024 04:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722918798;
	bh=PZE4W39piTsyZVfoVSWQ2vHqB0rE9Is6oBhIkDMistg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqF9i57V1jsYqOnohLIJnBnD8ZgukQjV8UYOGrRzsTxQfxnuGn6e8YCqOnELvAuiZ
	 CRpJupqXWN3rDT1422ttFvKyx1sWGZwwKMYX3GgBYYpJPxVJ0icIDpE+G95AUdxJmU
	 lPiwy3FKJw6palFUroaMLEMNhhNFShfBKWLNtF4BWrN6FuJQ/QgHh8jdiHDI5UC56D
	 oTGWeAB4sdmttK4jc5qcJouxdDWG1BVm/2F+wMQWlkUimulOgJ44ackKXDwivxdJor
	 mEJ5mTMLQI2zMnLaPaBMzzsGBa0s/k9By9899kPaErZyzCWRGVwUntkgHmLnjnXDjw
	 +37XDPKLvFPYg==
From: Kees Cook <kees@kernel.org>
To: akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nagvijay@microsoft.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	vincent.whitchurch@axis.com,
	viro@zeniv.linux.org.uk,
	Kees Cook <kees@kernel.org>,
	Roman Kisel <romank@linux.microsoft.com>
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: Re: [PATCH v3 0/2] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Mon,  5 Aug 2024 21:33:12 -0700
Message-Id: <172291878808.3394314.1409314003306906435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718182743.1959160-1-romank@linux.microsoft.com>
References: <20240718182743.1959160-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 11:27:23 -0700, Roman Kisel wrote:
> A powerful way to diagnose crashes is to analyze the core dump produced upon
> the failure. Missing or malformed core dump files hinder these investigations.
> I'd like to propose changes that add logging as to why the kernel would not
> finish writing out the core dump file.
> 
> To help in diagnosing the user mode helper not writing out the entire coredump
> contents, the changes also log short statistics on the dump collection. I'd
> advocate for keeping this at the info level on these grounds.
> 
> [...]

Applied to for-next/execve, thanks!

[1/2] coredump: Standartize and fix logging
      https://git.kernel.org/kees/c/c114e9948c2b
[2/2] binfmt_elf, coredump: Log the reason of the failed core dumps
      https://git.kernel.org/kees/c/fb97d2eb542f

Take care,

-- 
Kees Cook


