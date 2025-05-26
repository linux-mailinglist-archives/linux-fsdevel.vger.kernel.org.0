Return-Path: <linux-fsdevel+bounces-49838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0792BAC3B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 10:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE73B6899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AB019539F;
	Mon, 26 May 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfSJCpnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81D2566
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246434; cv=none; b=CkXVIJV/NcSHBHi4r2rN4jZSn7dLIwkKx7ftucMTt3Xhap5AxWs936wPeQI11I5mugcfQ/W24XxfZNTjN0lEJjX/eP379YC8/ZC5GVgIXnH1zXSOUQacEdJciNyjX5e9i+dB6E7w9A4qhnIE+ZYp0v8a1NJURg6MyZoD/0eiG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246434; c=relaxed/simple;
	bh=X5TYA8d22YOHKiIoLTaLuAkHD6tCsKuDWYDAsg7T82w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKgOlvgyt1QGjNEbowhG/wS9SZY+X3Bgn5FstABSYzyU1k77cHvZua/ACDBLIIUSRm+5Rkx61s5G58c5tPpnMbV2ZGwzADP1R9JPcEf0n6JZlp8Jq8NLsA8/+pcu/zvTBLtZmeXY5/Yr/lRj1uPFCG5RZgximW+VP6w3opW5pkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfSJCpnp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748246431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5TYA8d22YOHKiIoLTaLuAkHD6tCsKuDWYDAsg7T82w=;
	b=MfSJCpnpdYGfgDKl4YjNHsfJqf/KTAaS7QshyPoLni++gqBMRnpE9ODY3cFiks6XaE+/3k
	s1eBLt6hQEz5x8aHvONuSGYCMNEm9oUGjkV/t4XCbJOTkE1VDkS6aGuWvijzuYWfFY4BYw
	ZQvE/aenZgfyMtcCnsqZFCrvJY+4YnQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-2VBE5KrFONikDlwK76k64A-1; Mon, 26 May 2025 04:00:29 -0400
X-MC-Unique: 2VBE5KrFONikDlwK76k64A-1
X-Mimecast-MFC-AGG-ID: 2VBE5KrFONikDlwK76k64A_1748246428
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-60601184d87so1561917eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 01:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748246428; x=1748851228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5TYA8d22YOHKiIoLTaLuAkHD6tCsKuDWYDAsg7T82w=;
        b=DryvJGMA28K/Nrpa/JTBPD5bH7+K/lFZGvgg8iQVbXwwZQGX+OPImlUdUV2aPKE27K
         aI4TAm7nbzzHiSnlEwNBSl0VPZLRkOyPrO/4t4EX0/7Kf0eSUPwlmkKVWn/5RNl+IMC5
         rOrrxeKogTjP3Z0ou2P9qrCwksmHXcUFqXjIsi+ImkAvdav3iwb5sGTWYKTWc9CWiz8x
         nNMTL7AwHBQcKMVh8OFti7/63ZJLjumN1CxtVcbmVJQ20n4pCUvyl4+EIzlAlFkampjT
         YG6ayjCn9U/hJst9YDb8DBUNYFad51iQg4Zyt7uF/xQTH5K9A2UMAdqu+lvPwnPZoyZc
         pGuA==
X-Forwarded-Encrypted: i=1; AJvYcCVt500ebhAujf3lTDtZ0fAO9JrBBj9FFY0yIR4pukaZddaevfkVDeH7jHcKTaxsO7C3oK2oNZCpGqFPGsSU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XzpVvoSFXsTW3+Bj0Pz57yhb5sIO3Ts5fAJtLSBncEFnTDDO
	UpvNHjI23kKfHMWUXYSlH70PuFWioXVEnqrQfAfMeW2P4LOzdZMq0hQcD5/ZRFQ8p7hG1tlOwCt
	K5UTYz8e9fOZvVPXbZWuNV1ArIvp7mZExGVW5Q4gzE6A2MZPKvYB48r4SLrPcFq2Kl63Cdskq3z
	FoW/WD1HOiO3WulV5FGOKjN5EvpzR1AbPBQcUq7uk85A==
X-Gm-Gg: ASbGncsrLPjaTbs3J4iDyafCKiQTcdaAC2JwGX2bqh7tyzSJUufxA1NManeK0x7zlPu
	BC5oEXs9oYJHUjdhOxaDQSWAKM7tipNCbO59DG5ljM+a2fH1vvqLgH364fIofiXIKrOOwBRet5W
	lL0GGH3rQys09rl5/EBc4M0bU=
X-Received: by 2002:a05:6820:1048:b0:60b:a73d:b782 with SMTP id 006d021491bc7-60ba73db7e4mr2565353eaf.7.1748246428451;
        Mon, 26 May 2025 01:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3Jz5Tvgy3YuJRKbkW2WXBz5yyZ8fQBZUJ/sHaCol1rFXvL8/XyiuY3sd31PjBqzWrrdbPz+tJDKZnLfgEik=
X-Received: by 2002:a05:6820:1048:b0:60b:a73d:b782 with SMTP id
 006d021491bc7-60ba73db7e4mr2565340eaf.7.1748246428188; Mon, 26 May 2025
 01:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner> <20250523063238.GI2023217@ZenIV>
 <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner> <20250523212958.GJ2023217@ZenIV>
 <20250523213735.GK2023217@ZenIV> <20250523232213.GL2023217@ZenIV> <CAOYeF9VepEnQJjjC4Ch1HTe8ahuTTcb_RJ-B56b+KHVzSULqGw@mail.gmail.com>
In-Reply-To: <CAOYeF9VepEnQJjjC4Ch1HTe8ahuTTcb_RJ-B56b+KHVzSULqGw@mail.gmail.com>
From: Allison Karlitskaya <lis@redhat.com>
Date: Mon, 26 May 2025 10:00:17 +0200
X-Gm-Features: AX0GCFtmCBNMW7smUjM5Ekl4DHAO-J-LfCZgfMCAK5j_wsYxZxezHaiI9VuDtSg
Message-ID: <CAOYeF9UzK=oHCH6UcLgx5g5a_pQhMbnpnwd90oxAjN7LrmDytA@mail.gmail.com>
Subject: Re: Apparent mount behaviour change in 6.15
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 09:18, Allison Karlitskaya <lis@redhat.com> wrote:
> I've tested the commit (and its parent) against my original usecase
> that found the bug, along with the latest kernel in Fedora rawhide.
> Here's the results:
>
>
> broken:
> Linux fedora 6.15.0-0.rc7.58.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> May 20 14:10:49 UTC 2025 x86_64 GNU/Linux
> (current kernel in rawhide)
>
> broken:
> d1ddc6f1d9f0 ("fix IS_MNT_PROPAGATING uses")
> Linux fedora 6.15.0-rc5+ #8 SMP PREEMPT_DYNAMIC Mon May 26 09:14:09
> CEST 2025 x86_64 GNU/Linux
> (parent commit of the fix)
>
> working:
> 63e90fcc1807 ("Don't propagate mounts into detached trees")
> Linux fedora 6.15.0-rc5+ #7 SMP PREEMPT_DYNAMIC Mon May 26 09:12:43
> CEST 2025 x86_64 GNU/Linux

...and worryingly:
broken:
0ff41df1cb26 ("Linux 6.15")
Linux fedora 6.15.0 #9 SMP PREEMPT_DYNAMIC Mon May 26 09:51:47 CEST
2025 x86_64 GNU/Linux


ie: the release went out with the regression :(

lis


