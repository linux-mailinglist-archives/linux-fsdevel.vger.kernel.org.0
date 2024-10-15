Return-Path: <linux-fsdevel+bounces-31991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522699EE0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16511F25573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DEA1D5173;
	Tue, 15 Oct 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Sr0LYTIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD571AF0B2;
	Tue, 15 Oct 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999637; cv=none; b=Cd4dUNaMM2YjTQeRYhd9mqUUSNOXfHI//KxoQgAIy3KqI9uuhEEwemBjjff1K+y/Zw7Eiwy3VjCZM00OTMK5dMQKna6oHEgCeD+ITYNsvBiDSKCJ335+UHzad4kGyn0YC1W8AMBIq5v6et5MnJ7Q+CSOdKJm2jHs3wb8w13m9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999637; c=relaxed/simple;
	bh=hWsnXqzWUVbS/LFkW+4v8ACd0XaCqMw01lVnIK0YzH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hD/aPi2GKHs4iBTkl2EwESZCYA288Y5m5PurPV7w6l9IM0voneqxlg5bdLiji4k6jmNlwWt3saaFSdOhFTM47JiE1QoTvZilK1BBEwo+CujgC2iD/ek+7ABQVyEBD8O15nSZS/Yu9jnAKg/ViEk8U424cHAni3UfvwLUhy38vEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Sr0LYTIG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7042120011;
	Tue, 15 Oct 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728999627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFLmJEq84/4RSf31UFW/K0HnFE3ckCo/P5dpzh8CF5M=;
	b=Sr0LYTIGO6411b3ukyZwFgc6ppUe4er18qohZzBB0p+hCXn1ltg+9xq5LMJ+sr0G37Dn/4
	wAYFJ8NOvvS/+Y9E0NYXTqP1YIZNqn8h5+kXbPlrjX1XU0LHp6P8/cVyY+bO2s7Q320xkg
	bC1ZkeQho1T6MfgxXKusejSY53Jx7uqZ3oqM5p9KjfUOKCqfsP7zt8A9zHQK3wKF80SWzh
	hXBw7Pdo27zw5KquEeUdtV8l8/PaEeCIJ+AHIqq8kbsIhRTSkxhwFLt9eO3vywozEGq2sf
	xvYjpRHeEqhHLxv12w5W0MQ9eAm+Csm4Lyr2uf1qFIjcsBz+utrJY8scDns45g==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc:  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 03/10] unicode: Export latest available UTF-8 version
 number
In-Reply-To: <20241010-tonyk-tmpfs-v6-3-79f0ae02e4c8@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 10 Oct 2024 16:39:38 -0300")
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
	<20241010-tonyk-tmpfs-v6-3-79f0ae02e4c8@igalia.com>
Date: Tue, 15 Oct 2024 09:40:22 -0400
Message-ID: <87o73lscvt.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Export latest available UTF-8 version number so filesystems can easily
> load the newest one.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>

This will clash with another change sent to fs/unicode[1].

This is just a FYI.  No need to resend. It should be handled during the
merge. That is, unless it reaches mainline before your patchset is
merged.

See [1] 20241011072509.3068328-8-davidgow@google.com

--=20
Gabriel Krisman Bertazi

