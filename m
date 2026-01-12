Return-Path: <linux-fsdevel+bounces-73304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F7D14B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970EB301B49D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF38387572;
	Mon, 12 Jan 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Hc71wD0l";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="qPZTKaVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D473815C1;
	Mon, 12 Jan 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241820; cv=none; b=GQ1Bq/40wvKH+Uzi4LllJ1CM+i7CyPgGtOwHhXlKuWYP08gQ5i2x92Qh53nH7V6B1TPAHWUJqGyMA55FWcVlbtLQ+UshBYDNsmn8sWZVgBUz+GynhYi1DFNfINoiklptx1GQ7hRShO7zjxuH9iVEhtXXouQCcanoW1LnZqoGuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241820; c=relaxed/simple;
	bh=rY6hX2OPCGrnEiZTpR06Bck+qOpxYYcK1zokRuah334=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/9mdbuQ/oL5C3Nc/mXKQTyQNzytYTmlU3HoVAjejiWUw1DF7PZkdxNx8Vu7uDcxmQKd6Qn8XB7/IQdB7CB3qi1qcYCN4KRbk4sYEYHiZmc+J4xSiF8M5tDKnO9+kpQnbKHPnnc/m3DxVmZJ3l96Cv0mdOhjgtT2qaTKcqlctFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Hc71wD0l; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=qPZTKaVk; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7ABBD26F765C;
	Tue, 13 Jan 2026 03:16:56 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1768241816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4bB770wPaXYRGxsA0obh4lTWrdhl7e8r2fWpxCnCW8=;
	b=Hc71wD0lX1aSsEIXoKMpqUhnWpyhkHvMVoeP+0XFxIac28ngVa7D9da6UWGHLGJQXDk0kY
	8Y0IBrLOprMvDp8NOw5Ahbar+ipOTb+zCGHNxK+56JyycW8aQmXtXAgqnPGs7z/Nipt+KD
	auefq3br/Fnk98mnucNYYYGevGE+bxw+L6QXTaJ5GN+gZLoM95rv+5RTBubA/gDTTO4g1Y
	WmBjN5LvYAYnKZ53BOZnCmj4cwlUfLU7qnjiiz67CQQkqPFY3D2qKpBrJJv+6+QRjfrQCp
	mUC1FDxXac9J7a9M8CEgp9okuHVZ0SxN6lYsgpCVI/B5GavJfxqXmcNPyduIWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1768241816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4bB770wPaXYRGxsA0obh4lTWrdhl7e8r2fWpxCnCW8=;
	b=qPZTKaVkDqsS4SISBI7Klwj9P3M050ozun/KJJ6RzScBxfM3CLv1F1+1zWpT/eDMKhHxcP
	CkPQdimPZg2HdrCA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60CIGteS016730
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 03:16:56 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60CIGtNL028949
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 03:16:55 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 60CIGsaO028947;
	Tue, 13 Jan 2026 03:16:54 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhiyu Zhang <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
In-Reply-To: <20260112095230.167359094e9c48577b387e18@linux-foundation.org>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
	<87secph8yi.fsf@mail.parknet.co.jp>
	<87ms2idcph.fsf@mail.parknet.co.jp>
	<CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
	<20260112095230.167359094e9c48577b387e18@linux-foundation.org>
Date: Tue, 13 Jan 2026 03:16:54 +0900
Message-ID: <87cy3ed7c9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 13 Jan 2026 01:45:18 +0800 Zhiyu Zhang <zhiyuzhang999@gmail.com> wrote:
>
>> Hi OGAWA,
>> 
>> Sorry, I thought the further merge request would be done by the maintainers.
>> 
>> What should I do then?
>
> That's OK - I have now taken a copy of the patch mainly to keep track
> of it.  It won't get lost.
>
> I thought Christian was handling fat patches now, but perhaps that's a
> miscommunication?

Hm, I was thinking Andrew is still handling the fat specific patch, and
Christian is only handling patches when vfs related.

Let me know if I need to do something.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

