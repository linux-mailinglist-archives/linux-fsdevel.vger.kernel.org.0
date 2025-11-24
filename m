Return-Path: <linux-fsdevel+bounces-69698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C476DC816CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0581B3AA3A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F67314A9D;
	Mon, 24 Nov 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX3IZj7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAADD31355D;
	Mon, 24 Nov 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999395; cv=none; b=kRACPYpFxmaq7rsabO4HFpNWz5nVqZyxDcarOnkDy3viRCICHmrmacIn5bv0Rvi3kaGYVWCx4A/vnswXXof39XMHha4qMKw0r8vWU3piNpkVc76ABeCC8UdluYsAvzPcui+q6NLwHYIsTzS7HOYIoIwDGU9+eLyPDelxrLp/BHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999395; c=relaxed/simple;
	bh=Fc7xoFZ935GiHhrQjcCq85XhwHgbVkMldMDphDsctag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJKu0KfiDJRttyETGOjm1TQdy511ddUwXHg/vuojHgLW3i/H+o9GqZbDo3DnWdt4PWdlHImfMAdt6pVVD/mKe9pmOj/ckfGr2B8qzhpHCxQzpB4SlGqN1kSxWe/UIWFTh4Qm69/X4sHclBMq62HpF4gO33KJ8rADxvyLDtu7qZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX3IZj7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E236C116C6;
	Mon, 24 Nov 2025 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763999395;
	bh=Fc7xoFZ935GiHhrQjcCq85XhwHgbVkMldMDphDsctag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rX3IZj7YWOEnIZo2QGOlGW/P/6jr+LOEA+NM/bQR4xyIb9enNc7yPs1zgJi/94oCj
	 oPC+fEun122uYfvq2PgA1Eafgycrd7W5JeHko6QGdZJcvE2qa6LhuzaLb4yBCgHbKJ
	 7vf6KFCZS9rfCXIxOIRZhEMqRd+LkUHWGpp5JqK7HNO+9V5clMZmvP7sb+Q891Kfzs
	 YVsy0jJqRp0q6tDV0Qrapq8AvlkqojX7XfH4auBq7+tyAvXLAU7kvfNw65rXpiKQ01
	 3wfKmg18V6Z1coXrOn32d/oik74h3gv5zjD+jxEFuKQYTxLErVPlToxoPwIJdtwWRU
	 cYaJap70lRwOw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v7 08/22] docs: add luo documentation
In-Reply-To: <20251122222351.1059049-9-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 22 Nov 2025 17:23:35 -0500")
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
	<20251122222351.1059049-9-pasha.tatashin@soleen.com>
Date: Mon, 24 Nov 2025 16:49:45 +0100
Message-ID: <mafs0ldjvxwfa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 22 2025, Pasha Tatashin wrote:

> Add the documentation files for the Live Update Orchestrator
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

