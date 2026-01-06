Return-Path: <linux-fsdevel+bounces-72472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C4CF7E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA718301DC3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E232695F;
	Tue,  6 Jan 2026 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC6/9CJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DE313551
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696672; cv=none; b=YIruKiDzoMMn3SqL0YN/8HJskU8ypubvsihmdNiPipDMY2LW/l7yIa8NxfT9dZ85b1ly0UIZ3clpWkN3XCp3ZVpY5ZUu0+GGRvsgC4WWPdyb2zaIc7E3YPsqgmO7BBx2JD2pBu0ZK3IUTfrE8QqXXAN/3jzgHcYkAlpRnCdj5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696672; c=relaxed/simple;
	bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKWBu8WgUwPg4KQBkg3/4EWlG5LG9gX5++4THaaq/1IdD4i8Rp7qTm/SMh5FaMFmt7auCVTJiDq33ZfQRTe4lxPhCe/reIKyuCrC8s59e3Ikvn5DGf0BmAgQ+t2bKY1+bPJeCBwXZwRW9cmmKXsVb0CXQ3rbQkBCRy0Ypr8YLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC6/9CJg; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5e19e72c2a7so234151137.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696668; x=1768301468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
        b=HC6/9CJgEmFxZevNnWYNt9ZvzsZ5QpyvzKlcKyl9Bn0lnalzIeY+h+gW8Oxy2KxX1W
         VZaEUYZkXuuYYisoKu51dNhXvQCu+S1jtPxjSXCxFbz14EmHxsALgfOYQ8BYh08geqpR
         RkQq5PJDdEqkdnM0Jq2Fb8TgIDqk8Zr/dWmEMyBXmP4GFdJVClc9jxDkrW1+d/cVmgxx
         buahBBoWZFuN0F/87mdl12lxF2vy94Yt77XuoUGZv/UE9StVeMS0jaozN94xOS7ViJmQ
         gUepWhM2fvsH5ra0vmOl8fx2PahjoHuXe5isx2aIVKCBult0BU+dDqSx8ntoT4dJde9+
         HMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696668; x=1768301468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
        b=LLbs2dUmy9zr+jdtJNq8kJUXCreegpHMVQFnggRf85KDk4xLE79H1noqNuD9YMgKLm
         5UCe7vh9Vz0LB7rCPai/VL1U5RVLcPoXOqUe7BWQmCStzDj6ihzEXUaMjcOgVbkqeb2J
         pR0+CiY8PZiz0gifWrI8bk08IANTHR2FZumKvFCPoLLRy4FTYu1FbiUw0Tb2z7EEUCvo
         RkInKruDWyidfxLMQ5lxyLqVptXPLY3QWr2NCiiyJaKhr7om/bcZAU/4VtJ2824klnkn
         hU5p50MOeilDCsVhr15sMteEseU3W0BGsn7sSLOzsAKdlZB81XquxCOcWrE2R8KAzQk2
         gLgw==
X-Forwarded-Encrypted: i=1; AJvYcCW8/H2xMurzCpVGS0m8MSuoF2WpprgkdoabHZf/CLE34CCtw+wH7F6YVyyXQFmIItgsZY2wkYRAT00N3Iki@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8f9eoJXXhwkRDxdTDgpWtet8o6H+LOlNCho/cp2GA7dcpHkV
	hMu6wfi9re0/EFuRXWmxdPitDpZfmU0NhKhKtRSUmQNoLdornfMARup9ZBHLnxJgDKcHErBS0PQ
	KrVioEtDtk8lmdr37JfLvYL7CYXfnNSo=
X-Gm-Gg: AY/fxX64p+0knrbMAwtJunJxh+lznRpq43b2HWYILLmQEukoUg2SSMfXVa6QflsLp7b
	leKT/Qxgfb/Mr2Ya/9L17XV/EFDSN+s0m01i9AttIpcu6vKSQFq4wbLrFaA5qR0kv4PVxgVbzwE
	O8y00CbwD/9t2FKkfcroeYiAOq858QIb3Q4UqlNyENhGtWFm+iqG+uKaM54I+Fg66tTjkM1KjJQ
	eR7mRaQk5f/w1wWV/brUbjTVDcpp5sI7ZKHKJrKA1atlbbECCHUlzeWqjrRdMIB12q0Dc9hyr4e
	Ol6ZyJUyg+Hi2TaAy3Fy4NB/WPydB/oFHrXMMpU=
X-Google-Smtp-Source: AGHT+IG2uv1i3e9VAkX7WrpVZpEjcXmJcgLs40z5E6+u/p3r0x0uDL2AqAtu2qxiDLvSn4yhY/B10wpKS49o44BJQhw=
X-Received: by 2002:a05:6102:3ec6:b0:5db:ca19:f02f with SMTP id
 ada2fe7eead31-5ec74329ce6mr659777137.9.1767696668543; Tue, 06 Jan 2026
 02:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
In-Reply-To: <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 13:50:57 +0300
X-Gm-Features: AQt7F2pteEDNo2W4ylDnO8TsfR4yxOikMZf8XxLHSY1WQzegoJEkL84ArTG5zIU
Message-ID: <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If a user follows the current rules, they will not get a write which
> spans multiple extents and hence no -EINVAL. That is how it works for
> ext4, anyway.

What if he makes a sparse file by writing at random 64 kb aligned
offsets and then trying to overwrite 128 KB atomically? He'll still
get EINVAL as I understand.

