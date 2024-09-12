Return-Path: <linux-fsdevel+bounces-29202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD831977115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766B1282DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7311C0DEB;
	Thu, 12 Sep 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="UG8C/xMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE01B1509;
	Thu, 12 Sep 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168087; cv=none; b=Tb9TMb348I+rgCCnNi/M5JQa8pR9Tq2ppvIMEEDbEJ1uyiFPfHk6HKx3NGsFDR3JbV6FVZt61CHTJYQhHsHdVi+BslIEMdt2jx8oYgJbP72JYcDone/7Pd4QCGC+cGcHwa7NQl1COe8WwWraqtBHLh7O1jACvTZ80kURcKmGeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168087; c=relaxed/simple;
	bh=QQt3a/HsNI3AJLSUmO+bL+s+UapWiHFhcP0NQEK4LLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6WHzaTnGcMoQPUfVEVyVOnmMZ38BpgM64yCLDTrj4cvzGPRf1mt1rHYkpeEO41emDt0BI1BCh4kANuNaEW3waUw9RYiNTPeWCAIbjCZUOcyO6+pFRtuWLv3Jt2ae0WcK/5XoUgz1mQN3ysc1iKhXu+W0Xa75v92EvCpFNQCcsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=UG8C/xMr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C8591BF203;
	Thu, 12 Sep 2024 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQt3a/HsNI3AJLSUmO+bL+s+UapWiHFhcP0NQEK4LLM=;
	b=UG8C/xMrAZjHT5fL0cnhrCyBNLqbuv3CQScW6CbkGOwMv1niBnLnMI+Fww6KMJZ1YK/IQw
	cpaypnqKd2T6d5V4hu7rXnVQuaHL/2BiXZpvQhQKvqJcs2OKIt0OdRj6x5vi1vukAS4hhd
	qfrOOAptxttozALs59y9HL1U/BCgCesOAbePnoreOoVA1V+GImCdzfNwBl+smBCZKoDOEv
	Skm/NLVKOqTV/fnvStG7mcFh1HaNfjOyUnYN4kweQLvKpupEjDutVTPSqVUPjBHFeovuKo
	6TflL3ZYCx7AZF2r5ncGMyZIp5K32sGKgoFrdibJutReQ2wGMuSbfc0AiDb75w==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 09/10] tmpfs: Expose filesystem features via sysfs
In-Reply-To: <20240911144502.115260-10-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:45:01 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-10-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:07:58 -0400
Message-ID: <8734m4lmgh.fsf@mailhost.krisman.be>
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

> Expose filesystem features through sysfs, so userspace can query if
> tmpfs support casefold.
>
> This follows the same setup as defined by ext4 and f2fs to expose
> casefold support to userspace.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

--=20
Gabriel Krisman Bertazi

