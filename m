Return-Path: <linux-fsdevel+bounces-28790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84FF96E391
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA48B1C227C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44819007F;
	Thu,  5 Sep 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="gIlGp+xX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB343AD7;
	Thu,  5 Sep 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566284; cv=none; b=F0wiMOrsHJ9IRWnxM6RBrfJSgZg5VU1W6BVPx2GjXYapEBJdYVRhr3Hd8TgvEYT/uL0Vpk8ZXdggcW11KMB7mxH4coqSVMJgZs41Y/LsrhBzwgi5CONPGi1e1UuE1gakDaTQZH+TXLdahLL5GZtqSVlAaK1E7S3v43l2zP5rljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566284; c=relaxed/simple;
	bh=uEWuHStiwdJiMQ6RIuH8fXo5EJOuK/FBAH3xcmLzihU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hrTMZtvHac4BxKnpCKWJIMFQahTAY2DnblmlX72PwctCPwFUN3HYQyLKsRDPsfw1aycdrsaTbSO1RS6QAKMNujYFBZUsc4Fid9b0tixG+Q0I4b2wR7Pw3N3Btp5L6W9HJ6ZqkB7WQ8TrswXsS4lNoXQY6mB9Oy4onR37Hj+JYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=gIlGp+xX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74A751C0003;
	Thu,  5 Sep 2024 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1725566280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEWuHStiwdJiMQ6RIuH8fXo5EJOuK/FBAH3xcmLzihU=;
	b=gIlGp+xX889blHM+Bq9R5Os/vg0UKY1Z6DPqflBrW4wG5UCvn2XVBma8k2P7qjCknxgov8
	Ul/Xws0fEmZI9C48xkvQU2pcU5JaoBdH0LfBCKDcGnwOKEVYNt0Az3gzFomhtzYcMvvllX
	fIoSv52BsfEF9esCfaP7BKtw3I8ukh8mbA1azUKerFyQIQ8QfuMU+CeeY2WG7osAKO6eXK
	mvjIkFh7EEswDxl4B82tpWzrGO+Uf5KS6OGO2Fv95ZEgciBf+rRaAod5OcNKvwiBUN93WK
	cW02gS0IAYHz4EejehV0EjxXayLYhwUccNCmXFTdrRb03e7jle329i1z6E3tWQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 4/9] unicode: Export latest available UTF-8 version
 number
In-Reply-To: <20240905190252.461639-5-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 5 Sep 2024 16:02:47 -0300")
References: <20240905190252.461639-1-andrealmeid@igalia.com>
	<20240905190252.461639-5-andrealmeid@igalia.com>
Date: Thu, 05 Sep 2024 15:57:51 -0400
Message-ID: <87o751oou8.fsf@mailhost.krisman.be>
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
> ---
>
> If this is the accepted way of doing that, I will also add something to
> checkpatch to warn that modifications at fs/unicode/utf8data.c likely
> need to change this define.

I'd do it by special casing version =3D=3D 0 or -1 to utf8_load. But the
way you've done is just fine.

Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>

--=20
Gabriel Krisman Bertazi

