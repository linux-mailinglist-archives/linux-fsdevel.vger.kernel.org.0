Return-Path: <linux-fsdevel+bounces-68718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54732C63ED9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18A634EFA67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44D32D7F7;
	Mon, 17 Nov 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="OER8VvtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108E32B9AE;
	Mon, 17 Nov 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380036; cv=none; b=rf5bzaKX71raR0x7fYUM64t9uaw3DKYKeN5+/NjDd6eAGhugBM/tc0L9gpgvt336FsBf3dNnbEf8dDqsNKsSApXexbyzIJPK3bWHmpSk9Znfgt36c0DHNTnkFRqfsHY8RJ6DtZ/sItN0o09Y/njoczSME3OIwlW1dy8ToTz9J94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380036; c=relaxed/simple;
	bh=18AThoJ1F5XQlVvAYjRYKKUnjnNDdRj8jhe5/a7p0Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fihHClnSu06lbwCCo62Xbt7+OoD3hFTTQQ4IH+bL2cCx4bpESFf/+pz7KtIOHyDNKGPnXwpXHHQM/+U2N9TvX+L8pi48mBLRnwGi+m/W0w3bR7AJnVZgOJ0CM9W/sKP5OfbZUONM9VCprJH3eJUuh1OarZKtHTcWBMG7XOcrWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=OER8VvtA; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763380031; bh=18AThoJ1F5XQlVvAYjRYKKUnjnNDdRj8jhe5/a7p0Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OER8VvtAWTP0L0fklHIXgvMbFN6jQ42q7ikGcR7PT1lfcpE+sk1vaFPlgwmYfxh2u
	 Pq0y/kJUlVETtENUzSDWBD29nZ2oAwTrefvL8GaBT/YWNG1U5Mjq4+u8N2zaMvWGEW
	 D0+efZ3KilUrlzGa4RTfgyZqCWS8ZZBaKN5UMhTzrzKUnNddCaSBPAq9WMvcT+Ds69
	 3092p0XYV87EDLK8QwERXg2JcshEZMZcTB0vts1w1Xkp4t6mwezRfsELFuLCBJODqY
	 ihba2OAwwWb9Fs/T1FQnHaijPFLuUVe/E+WYicL9bzWdCRfMuTnCXAFDCbIwAZWgF0
	 sOcUAGdTe3FmA==
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org,
 tony.luck@intel.com, jani.nikula@linux.intel.com, ap420073@gmail.com,
 jv@jvosburgh.net, freude@linux.ibm.com, bcrl@kvack.org,
 trondmy@kernel.org, longman@redhat.com, kees@kernel.org
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org, pengdonglin
 <dolinux.peng@gmail.com>, Jakub Kicinski <kuba@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 14/14] wifi: ath9k: Remove redundant
 rcu_read_lock/unlock() in spin_lock
In-Reply-To: <20250916044735.2316171-15-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-15-dolinux.peng@gmail.com>
Date: Mon, 17 Nov 2025 12:47:07 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fracop8k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

pengdonglin <dolinux.peng@gmail.com> writes:

> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side funct=
ion definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
>
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
>
> Simplify the code and remove the inner rcu_read_lock() invocation.
>
> Cc: "Toke" <toke@toke.dk>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


