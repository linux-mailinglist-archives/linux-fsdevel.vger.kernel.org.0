Return-Path: <linux-fsdevel+bounces-68436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE2C5C214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4F554F3041
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589562FFDE2;
	Fri, 14 Nov 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lvqgDMe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68A2F6569
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110524; cv=none; b=kKDriO7AFyA4rdGPCGWK5plCpS8PKV5cXCxypQAPujt3gjIt5VzPjtZHGPVP/xWIzFTp3T4QtcF7J53RuvBrF0wWfwlWK8UMRD1Qyv5dEDQPHLQuGXPOfK0D+eSOWB+YpEdGdcPbPoXFXXhuvI6H6V37LEF7EdY7ntY7DtcBHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110524; c=relaxed/simple;
	bh=7QWyEaWPUG/dP82AsIRFxyl4HGCEfS7+WMTPWWej19w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfC0fnfWAV7kwanz8X8Ud9lhpRAFOpHAnWkYJMp14giZpQZJ5ccxU1D0G05G2fYs3F+HfXg8pGVrOBKUDzm0xPJO6dfewbl5HXOmSKNPcGNiqTfDYaNy912KmJ23HQnTmTuvXjCIVHGFFZ3hZDKQlWITVCneROiDfoc/TAZOWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lvqgDMe+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88e51cf965dso205570985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 00:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763110522; x=1763715322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QWyEaWPUG/dP82AsIRFxyl4HGCEfS7+WMTPWWej19w=;
        b=lvqgDMe+4ALyHXRYirCDOIiThCH5UKgjsiAgqVVIPcc52CVLOfJD79ppT2YVrdp9Yo
         24RTWShWi8X6F8RIyzI68XVljErIEKgSlwzv0VKSFOo8FpHSauqv6EzWLaI0YjDb7KPh
         cJk1LR7T/3C0qR/MVRoSBVQIERzQXTY4IwSkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763110522; x=1763715322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QWyEaWPUG/dP82AsIRFxyl4HGCEfS7+WMTPWWej19w=;
        b=tPXhJPJ4ykVl7lNpct9dszdkMV4/ZIV+8TgR5Wiyf+ZQQ9KlDTAhz30NMAxG5c8b9k
         +O69uDvUNJJIkSGu1KPbUdVGmBT+igcfwESPhU/f1eDck7fdQBBXzTu6ZMRR1sIsBPVW
         eNVG1gQeLKwjvj/ZWjpvyshdjgqItDZCBF0kIzgWKGDWp7tOkLeza2mWcoiGI1bG7Prw
         dOsd3pb1CHG+8GHBXDMkek5ZvX6A+es1UZ6nNX5BduZ04pQRa/FTzEMq9xlEryvU05AY
         kwMcuwP+0FmiUGDEeo8S4r1vOVFMU9+3MPlLEOe/m27VWOMs+JOgdhfLMSaSk/ZmhePk
         QPcg==
X-Forwarded-Encrypted: i=1; AJvYcCV/JuaGuS0avlcwBJyVdu3/2AWeyTzcff2E/uGs4f6x+b8TDD5RljFIJqIag0LcBiapmhxZh8VpuThFBwLs@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEd0NUS+J+AbdDrRcJFVnNATe+OeA+qDeNI+r67FeTVqiU3Hn
	PA9oim1PTcRunJ5T8SWIOPX5wsdUcJnrAhlI6UnZ9Uzixax0rNgnr/c0tDyKrrtl3X431s4Vt+k
	KxCedjSdSqSuDKl6+gTV6WPwTkQ0KxQ6+GtljFsf1Dg==
X-Gm-Gg: ASbGncuF+6JGDdJnGqO52KitATDJzmWCR04+LOfgPjL4HSC72Asev8ba5vZMPXDi4uN
	jJZCTvrr8rwyTnrCwTmV6gT5DG2+mYqynoTXsqIuXFmBSPXEPzR6uMKP2u20Y4d91eal+/dSUmC
	ZYXEVMIUfeC5Q1lsd6QkQE15CoKtI1rQZiLyGBmTt0UJxdJpaWN4tXiNVZZF551TMKhM4lgbc/J
	UjYae2MPeKLBvBU5n9FOG42kXdgamujHrXAFHwGYshbXClwGt9fCcKSWlPIUstn+JV6A4jdtbYJ
	C/NTp7GK7Ryrf80y5Q==
X-Google-Smtp-Source: AGHT+IHFOnYN8Yb+30eRqq4OIG/XqDhxG47QkCyDhPhoPo+n9+yo2rSsEgKlid6IjLr5km5pwKQxSfx3pTNFESrelRw=
X-Received: by 2002:ad4:5bab:0:b0:882:3759:9155 with SMTP id
 6a1803df08f44-882925b3364mr27129646d6.21.1763110522067; Fri, 14 Nov 2025
 00:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-3-b35ec983efc1@kernel.org>
 <CAJfpegtLkj_+W_rZxoMQ3zO_ZYrcKstWHPaRd6BmD4j80+SCdA@mail.gmail.com> <20251114-tyrannisieren-esstisch-9a596bcdeb7c@brauner>
In-Reply-To: <20251114-tyrannisieren-esstisch-9a596bcdeb7c@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 09:55:10 +0100
X-Gm-Features: AWmQ_bmR62PzN-GIUHUeulqHbWxi5iB-_xxM8bQk7cBq0kWzSZBAuSsjjpdtUqw
Message-ID: <CAJfpeguuzPB0O2suV4F_KDCMY3n8n27ct1gT27fepmG5-GDu8Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/42] ovl: port ovl_create_or_link() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 09:53, Christian Brauner <brauner@kernel.org> wrote:

> The function doesn't but the cleanup macro (as is customary) does:
> DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))

Ah, missed that.

Thanks,
Miklos

