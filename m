Return-Path: <linux-fsdevel+bounces-28950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F6971C37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FBFB23311
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7E1BA26F;
	Mon,  9 Sep 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="LOi+rtgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EED11712;
	Mon,  9 Sep 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891347; cv=none; b=X76dp+hAUEiWs//Fv/DYcBTpT/OR6hFahYSW07ejBhCTDGHPuRUjVH9VyW3CJLyGHK0XSpqepaMh3LX1dw6mEW20aatw4Weqj07+gRvT4h6jwrFeRXQr0K1dc4WwJwEJvWs0P802fePD78x7EcU/apo8kVo060l9G5yAZ/Ft6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891347; c=relaxed/simple;
	bh=SueKp3n1Y013XO+0FQLVymY+507DmQkNubgBS6pfbAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1SlKstv2FI/n+Or45kuFWvBtYa78F9H34Z5eE4MI3yso2dkK4JbgooEfeKyiejI2BBlZUgruCpWc8n/PVJHV9kNzPA9O+koecm0UUtC1bt9X/uU8hiZ03oWiXZyNl0n81im9hlSxy1dCwHVTazXWssM2ArdO37kjUtnwjtFF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=LOi+rtgG; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9FC7C0004;
	Mon,  9 Sep 2024 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1725891342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWkQECCtCkYRpgRDI91m9jn0h/1pf2RieDIOritsh40=;
	b=LOi+rtgGnheOXae/d2UEPXvxLV8PMBlILKkTb/9SKlAO+PUk7ffDzbXYTBCrc8G1wl2xhJ
	4F5mWdSRfmBJrBPjd200i6xtBBcX+/Yx3xHfAZ5RGD47FvIhC4QrQPm8GDSS7L4fL5QGTU
	yIHPjVdYz/VDNvu42st3oXwqlg8ngAkMB14RSmneUcWH5f1f4KOUkxDLTAo8lNt0DqPrpF
	eQBSpjlLVj/wsW6rBwEhDbJEyBLkwKiqCT6bREUC0/SY2Kdh0kwdsJDLtHMjXB7EKAfxNA
	elfekdcP+i9CIjqKOPBQnLzNcIeay9Jxs9RYZvRQS/CV2hvcd/xAIdK8hx3bbw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Alexander
 Viro <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,
  Jan Kara <jack@suse.cz>,  krisman@kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  Daniel Rosenberg <drosen@google.com>,
  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,  Theodore Ts'o
 <tytso@mit.edu>
Subject: Re: [PATCH v3 6/9] tmpfs: Add casefold lookup support
In-Reply-To: <956192d3-5fb8-4ecc-8625-a34812df537b@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 6 Sep 2024 11:59:45 -0300")
References: <20240905190252.461639-1-andrealmeid@igalia.com>
	<20240905190252.461639-7-andrealmeid@igalia.com>
	<87zfoln622.fsf@mailhost.krisman.be>
	<956192d3-5fb8-4ecc-8625-a34812df537b@igalia.com>
Date: Mon, 09 Sep 2024 10:15:31 -0400
Message-ID: <87mskglxq4.fsf@mailhost.krisman.be>
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

>> The sole reason you are doing this custom function is to exclude negative
>> dentries from casefolded directories. I doubt we care about the extra
>> check being done.  Can we just do it in simple_lookup?
>
> So, in summary:
>
> * set d_ops at mount time to generic_ci_always_del_dentry_ops
> * use simple_lookup(), get rid of shmem_lookup()
> * inside of simple_lookup(), add (IS_CASEFOLDED(dir)) return NULL
>
> Right?

Yep, that's my suggestion.

--=20
Gabriel Krisman Bertazi

