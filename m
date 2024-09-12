Return-Path: <linux-fsdevel+bounces-29206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF097715C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1B7286C99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A901C4624;
	Thu, 12 Sep 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="BQzoQeHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD01C460F;
	Thu, 12 Sep 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168469; cv=none; b=PCERDp7F/6R6TmV9wDmXkGlMeRAve2Pv+qN9IL4hKrqsv0Pp6sSGLjAdJwWVjXk+teA4hbGwyfh1GJgBiaMkJb1Ku2X5bs+ruWsRTlVI3YrbYbEMpMeUJvZQ7FNBEEN2WpRQNbt8z40ew48MON/D2gXMHYW5NDrFElEE20xeQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168469; c=relaxed/simple;
	bh=vSVsd1ipLG5kAvEk9fO6iGUDenmuNJ64JmQfkNg+UBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DuUXlHl2s55ldXUHFz375PofHpAj5GqaQH6SL1N/2nZdOoBig+2b1P9pgFfXZnOiJz9U2KKfXuT+K4ArrGmhPE4tcjTC0R0d4HbO0ooe0obMy5TwbInHUwNLBtyrgI/jiheaV2NTOLqaMrhy8+RN/QtdI44kDqx2RkbZI7Kz0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=BQzoQeHx; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC384E0003;
	Thu, 12 Sep 2024 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSVsd1ipLG5kAvEk9fO6iGUDenmuNJ64JmQfkNg+UBo=;
	b=BQzoQeHx9rmoTVFVntHehyBOQIw13MKRj/3ldPfjhO2Ql+IzRFGr4yIaiThDmcyOx2gE3I
	Ri/WhswE9UqPN2VpmOcfnVh6eF+erVoCHjXBD17u5pCYQqinm5n6nU2m4XXA2ZJUGJ0Tjm
	a8PypnpyIYBnvoyfLw3QvPt++aL2BrFVAGdOFDlCklf2hqFQP81iBbFKeZdmKZvNarkjx7
	b3JLatnPxCYVAlBma4QdvCHWppNl/D7HaScrODjTDh0Sckn42IQh34fmQGfmu8PQ4bs8Yr
	xEjZNsC9sfwXk/5GbmVy5PoHN9pPBuO8zoaf3i8PLFq96oI+f70qyDHotl3HPw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 03/10] unicode: Recreate utf8_parse_version()
In-Reply-To: <20240911144502.115260-4-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:44:55 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-4-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:14:16 -0400
Message-ID: <87ldzwk7lj.fsf@mailhost.krisman.be>
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

> All filesystems that currently support UTF-8 casefold can fetch the
> UTF-8 version from the filesystem metadata stored on disk. They can get
> the data stored and directly match it to a integer, so they can skip the
> string parsing step, which motivated the removal of this function in the
> first place.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

--=20
Gabriel Krisman Bertazi

