Return-Path: <linux-fsdevel+bounces-54880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4CB0484B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695971740C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69625F97D;
	Mon, 14 Jul 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="PVPhXg6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D51CD1F;
	Mon, 14 Jul 2025 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523962; cv=none; b=HQunf43YzbexpZ2atHtuiKe1+Y6wOA+dJpzAEjRFVxafn8ApBk6FCL70O3HpO3zTQzHRqfYd9D2Z7KvRgMWa4rxCmEoukd4Hh5gzxbTNbJw4+XatFbRO11Ej2o2I11Ch5ZSA0L60smYuYiZG2OpowK9ceGWqP+92x4yKsi5+LUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523962; c=relaxed/simple;
	bh=VjT9tRf3fvLxYsxK8B0jNCqN7fcZ/L8iqnChL4E+J94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DR0L1UzZUlis4ydAt68evDLbuoiYDnyie235Wa9yZvIAeyTeQz1sAw7/xa42Gf8cuBG/v1pFeN/ntlVNEY9ELbiXNvtL3Re8HV0JDMcQJ3ZEKm6+K9kuRQPgyJ21j6KVDfJ2I2YZo/Sr9wIUzEMPGOo0XygLOB+RACh3GQCLK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=PVPhXg6o; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CD8D44A56;
	Mon, 14 Jul 2025 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1752523955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWGoO/P0YLr5DR85lYVPJUrQEZAiIPT1zhifVey+uf0=;
	b=PVPhXg6oJxtP0VuHnHuAR1TVxO6KjoCmYnjsC62F6+YZ6b7K5DSrRV6Y962J25SC8BZZkw
	XLSsUD4j6JHhCK8Lk7OJa81jd0SviXz5dlpWhsDrHOaUG4IjAnTkH87ZbVgz5BPaVy9Evt
	BWUvrn4NhcjaAfvWxnX0iigzhNBOZ5yLsN2ZP/5dyq03BGwrqLtFlb+BazKzHnYh6AldGe
	FXWiKE8/20vrlRSl0ysP2L5o1YvaP+Ur22iOHDtodYQd2JZBCNtiE2X0fVPwzp9fgvGm86
	l/+h72shxRnNNZeVXSA/e1GyQj8uaJMzKdPIFdY5aa/XSfknP81vY0Jedza5QA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] ovl: Make ovl_cache_entry_find support casefold
In-Reply-To: <CAOQ4uxjv199LB4XhgeSbTc9VkPB16S86vwcz9tq4GHVX4eVx-w@mail.gmail.com>
	(Amir Goldstein's message of "Fri, 11 Jul 2025 11:46:30 +0200")
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
	<20250409-tonyk-overlayfs-v1-1-3991616fe9a3@igalia.com>
	<CAOQ4uxjv199LB4XhgeSbTc9VkPB16S86vwcz9tq4GHVX4eVx-w@mail.gmail.com>
Date: Mon, 14 Jul 2025 16:12:31 -0400
Message-ID: <87seiycz0w.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtqhertddtreejnecuhfhrohhmpefirggsrhhivghlucfmrhhishhmrghnuceuvghrthgriihiuceoghgrsghrihgvlheskhhrihhsmhgrnhdrsggvqeenucggtffrrghtthgvrhhnpeeftddvheffvedtudejffffjeduueeugfdvueejudehtdfgheekfeehgeejgfeukeenucfkphepjedtrdekvddrudekvddrieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjedtrdekvddrudekvddrieekpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehgrggsrhhivghlsehkrhhishhmrghnrdgsvgdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrlhhmvghiugesihhgrghlihgrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtoheplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Apr 9, 2025 at 5:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>>
>> To add overlayfs support casefold filesystems, make
>> ovl_cache_entry_find() support casefold dentries.
>>
>> For the casefold support, just comparing the strings does not work
>> because we need the dentry enconding, so make this function find the
>> equivalent dentry for a giving directory, if any.
>>
>> Also, if two strings are not equal, strncmp() return value sign can be
>> either positive or negative and this information can be used to optimize
>> the walk in the rb tree. utf8_strncmp(), in the other hand, just return
>> true or false, so replace the rb walk with a normal rb_next() function.
>
> You cannot just replace a more performance implementation with a
> less performant one for everyone else just for your niche use case.
> Also it is the wrong approach.
>
> This code needs to use utf8_normalize() to store the normalized
> name in the rbtree instead of doing lookup and d_same_name().
> and you need to do ovl_cache_entry_add_rb() with the normalized
> name anotherwise you break the logic of ovl_dir_read_merged().
>
> Gabriel,
>
> Do you think it makes sense to use utf8_normalize() from this code
> directly to generate a key for "is this name found in another layer"
> search tree?

utf8_normalize is on its way out of the kernel and I don't think it
would help here, since it doesn't handle case-insensitive equivalent
names either, bug is just as expensive.

utf8_casefold might do what you want, but it is expensive as well.  With
it, you can store the folded version and be sure it is a byte-per-byte
match.

Alternatively, you can keep the existing name and open code something
similar to what generic_ci_match does: check with strncmp first and only
if the mountpoint must consider case-insensitive, do a
utf8_strncasecmp_folded if the first check wasn't a match.


--=20
Gabriel Krisman Bertazi

