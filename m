Return-Path: <linux-fsdevel+bounces-72222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805DCE8640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 01:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AEA23018F67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D0EEC0;
	Tue, 30 Dec 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRcbwSdP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7494C97
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767053585; cv=none; b=Vo4bLc1zXSLCNnIuo23e5qcGPu4jbr7OG4BltGoIO7alAFA/YYRPPpVPOrUCFpfo2HRAgcYkyQuNWcNO2buGjGuMFaZF/v3pETarw05Gqewt1kt35ryF+6Ayu3dSjPo7n1WHDgq2wCjlvsLtFrv/NC6g1cp/s4w8Oe3u3mEIrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767053585; c=relaxed/simple;
	bh=l2/y++FhT5Ul6wi+FVOupfw96H+zMmKHRzQGGKr8AyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6L0Lv10wl8uqtTWbVLRb7ya2CCJNft+jtb8GFMVY1l3QnjqbIlRHzPEhN7jvkb+xGrpUUHqRl3pLUWXol0ic9EPwz5eX2/5liPVXrJ1Ge6TVQPPdDNgimOFmd3qi7JMloIhNyWB3lt4iZDZUVBAwzE7LWb3m37+vcErXsSDMNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRcbwSdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FB1C19422
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767053585;
	bh=l2/y++FhT5Ul6wi+FVOupfw96H+zMmKHRzQGGKr8AyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FRcbwSdPZuX3Nm2aTJEFj5LW/4Cq0ckak1WDqXbcMqrfIHEFWB0T3ZyHNlQMqWfrN
	 7L1sbjjjmHLd7ZIoMSlEoJerbEpUPZ/GJ/zufDImLOUyjsyY7aw+N/98UJveEVyxBS
	 7VjvVaormpzTT0VZR8JuP29s3wwhykfzyTPkg1j9hIzyhtMTV/QQLzWhV2DbMcQ461
	 m92MqUnivMYj1X0yPFULV96NrWIHr4O7WPEwIwGYgippdK8qtORiuX0Fy/4SQfevog
	 401HUdmek3KUkB+Gkesu+EpgLPwcD39dmekClgqjMbcqws6fpR4NEr+8Yl6eayzfGh
	 gubgfbzVBLvHw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b725ead5800so1332981966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 16:13:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHKD1IZR1ueP3ESr33b6RVWS3czZJ0TozU3mK6x0qKuK8KbN29D/U9OAfCN0a1AF7mpzKthfkF/74dLspW@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQvqLez3D0XpoAW7nRF3FWxkTHJ1SRv+pg5NEspNQH8NTu2Nq
	f2TAdzCNe+1xbuuGMNkNDP6nq4p6XCh4Ozebwbt6cslFGsK4F6WlM6ila6C9ccW2CabGPN5E/Xl
	PQYUld35zcxJ3mP0eMEsLycw75vbAHHI=
X-Google-Smtp-Source: AGHT+IGSVinagx6JCyZTTISE6kh7mULLCHf8zev8PvnDgjH1pmFcHnLT4Jxfh9nhqdttuBGwNEnwMeHTtLeEzwUn+Kk=
X-Received: by 2002:a17:907:d07:b0:b83:73ee:993b with SMTP id
 a640c23a62f3a-b8373eea4f2mr622675066b.57.1767053583647; Mon, 29 Dec 2025
 16:13:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-13-linkinjeon@kernel.org>
 <aVKvIENB3ihYo6dJ@casper.infradead.org> <CAKYAXd8wTuU4whPLDN9_vd5Fhv-7gZ0gCLF8w_ry8tqM1Nn_+Q@mail.gmail.com>
In-Reply-To: <CAKYAXd8wTuU4whPLDN9_vd5Fhv-7gZ0gCLF8w_ry8tqM1Nn_+Q@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 09:12:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd979DqSVOFzMA8H_LSs+xjd67cVofFbKn98WupKW-K5jg@mail.gmail.com>
X-Gm-Features: AQt7F2okrhGXCwu_I8DH480gOINyVn7x_OoevoCOgPlQg9lbdZ6-G9kqh04apaM
Message-ID: <CAKYAXd979DqSVOFzMA8H_LSs+xjd67cVofFbKn98WupKW-K5jg@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] Revert: ntfs3: serve as alias for the legacy
 ntfs driver
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 9:03=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Tue, Dec 30, 2025 at 1:41=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Mon, Dec 29, 2025 at 07:59:30PM +0900, Namjae Jeon wrote:
> > > ntfs filesystem has been remade and is returning as a new implementat=
ion.
> > > ntfs3 no longer needs to be an alias for ntfs.
> >
> > I don't think this is right.  If one has selected ntfs3 as built-in
> > then one still needs pieces of this to handle classic ntfs
> > configurations, no?
> ntfsplus has been renamed to ntfs as you requested. Wouldn't it be
> confusing for users if they probably expect the new read-write
> implementation to be used, but instead the read-only path from ntfs3
> could be triggered ?
And, if ntfs3 is built-in or already insmoded, they can not be used
simultaneously because ntfs.ko cannot be insmoded.

