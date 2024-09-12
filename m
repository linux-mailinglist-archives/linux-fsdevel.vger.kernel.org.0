Return-Path: <linux-fsdevel+bounces-29207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3F97715E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813E9286B42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526FB1C5786;
	Thu, 12 Sep 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="H6ekai0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CB1C0DFB;
	Thu, 12 Sep 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168493; cv=none; b=jCdVnNWRyBADEMBMUXbfGWMizD4MrQC1Juqeo0P0khlVazBWRqUjhA2XU2i6xmmzu3gQBcqgMmk87FC66rO246+ugJwvJvI+L+xy9RH5gpDDXlSB/TdGPdtk/MxAEZaj8zOHE+7iMNa61gyQ666BZ5W2lmkQNP/7JNawgzGpQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168493; c=relaxed/simple;
	bh=wPY4AP8DwLB6OTSALMG4kFcvVAucDG8lugkbZ0LgPQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HRoPDfpCJMaf7FyM9NWa3hy4lhcHi4Jbui329H6LFM1FYPu44QWQZcs4yLEDkTb6HgWJ/rDO5h/XxEbh22/SvphMM8QShrmKNGsB+ipajIloGXc6nzP8gdmbkRv2BtpZ33D9QwQNaFxTV4oI38ojJi4ls33VEB2o1QcsdLWm0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=H6ekai0d; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6D1BE0003;
	Thu, 12 Sep 2024 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPY4AP8DwLB6OTSALMG4kFcvVAucDG8lugkbZ0LgPQs=;
	b=H6ekai0ddLoj8G/qRIlluOFjuB9XS+Rwj8m3t/rK3g3lOQ+c5QU+9ZBQioLkhX+RQyyta+
	vpOGxsrtAsZ+1VfjsuQL9Pvk6FQHpLnOPQNXNOZu+rgypvBz1XeyjxwAyZp2VUqZCGH3FX
	AfZDzBPh+I8b2wq0Tuw3ULihG6EhL6FG6byI+HayWr53+ep6V7GGytmt4ohrdSYxvdI46c
	fss5ZsUdYHa9xxoAX0ZYTqQZ3ZM/hJRaDZ1DRZ5hJtcWyV/387+UJqxcU67QNWl+i2fuf1
	rOhpwo7pOENPEim7ereSluWkjoKERM04QWRIhRU46iuGnjzhweIx6i/xWTjw2w==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 02/10] ext4: Use generic_ci_validate_strict_name helper
In-Reply-To: <20240911144502.115260-3-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:44:54 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-3-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:14:47 -0400
Message-ID: <87frq4k7ko.fsf@mailhost.krisman.be>
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

> Use the helper function to check the requirements for casefold
> directories using strict encoding.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

--=20
Gabriel Krisman Bertazi

