Return-Path: <linux-fsdevel+bounces-60168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0ACB425DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B62B5481B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1236286417;
	Wed,  3 Sep 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iCuIIelW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1728469D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914541; cv=none; b=mg6p7mrXc6ILOrlrzedDTVXzHF0nmqdE0NfpFQ5OhyDRgsBcGUkj/pEWnGMpyJ6NRd/rExYjA8ucBKr0A5BcZvt5txc5RW70Sb4YuZTsGoVAlJlAuAiQ0IgFGtHX0up4D+PjJIJnLJp0sVYNwUo5Fu/Msn4Fr1LvpZ0MUUOS32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914541; c=relaxed/simple;
	bh=ieAo5Qk1lv7OZfmuLAF8/leyFnhuwbg6+KIrHUJF/ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6TuJu+wR0lktIhOyOzwrMsUCoQ9jUhJ68VeZ3wgovR9asy6c1y27Ev1rkqJqc3Phx296I1hLKXneOaNrjnkKa8WV4RHxLtZpcmEypbipJtp+1yXIb8RrKhPCAv4v78I98XMVNgcIFzVynaInONrUO9BQ5PXYBxLHCqcedi40V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iCuIIelW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b33032b899so432691cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756914538; x=1757519338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HQIiNN02DsbldEOzOjoBCgseAA3l3sPAQynhF20rTLY=;
        b=iCuIIelWzTd44R+pbtH41A7ujl10b0RY3D7ykBGn+01yxF9U259wqx88Ym3u6jKLnR
         7NPbCD8N3IgaBbZGNxzrZaEcjAur2HRiMeayWaegXpUhIoYIcKy7W8jZ0vPJlxQV3O5p
         L2zIcmzkpYDWeYdwcr2j/VBvkVD2tzBVpROKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914538; x=1757519338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQIiNN02DsbldEOzOjoBCgseAA3l3sPAQynhF20rTLY=;
        b=qZBjq1SwhhI5Z7F+9jADHlBQXWnPASggFq7dxJdzS556/DhqpHA28hbAkOgMvSgsFl
         yQX4LUKvQk6TlKqlRsg8sN+OeZs2k3bVeNksNAF+F+hPXPVBRlpS+cQiMH1uwTjF8GT8
         BdHkM/A9SpPEprjN1jM3TiZctdZ1fuarAsh2TzhC9252O6jmSHTm+3abQvhdv2SJYQqd
         AcyKTPT6c+/omQDoy0oUCHqvkdhAfyup3+rGnHVb5Wi4ceLU6hjEDUsv6zV/YY0ZXtFY
         SORGVL6wVIV9rxow5nUiAYOAweTL7+X9HMhDYMlzUMz++6Bj4utgFlSRB5R5/8Ze2PIn
         nSJw==
X-Forwarded-Encrypted: i=1; AJvYcCVfO4/6wMrTUv3jeaXoh1ZDPpL/9KvbD5LqEHQOadv/n/H4oTR4NuhFPyU41LDCEy00WZdVG7il+2SzpumF@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrFrPeGpKYWmyrbSJluaeLanc7XawiIiGoch//CCAJ8X3YJ39
	QSout7TdHVUOMWbplMnbSEYfs8OYy9Al/KtIfFXdqa/M5xch0tIl9NJdEXeOZszGBJhTvbZcfa2
	ppeURbWeTLWv4p0KPRcpbbIgmgCKfXhDZxq4V/pG4Pg==
X-Gm-Gg: ASbGncuB7zAQU0TgmQ0urgM394OY4EREM5gpRW0NEkFa0W8ACgjJ/obs4bebpIrGpbU
	FwDiQCMsRLxe0/LibaLOASghC3MF0FTgSqYFH8sCS1OiX0vqXzCA/Wz56gTOlfyjozowBXi31nq
	c3npeN4Szi93iBPizYfDdHEFjnHm23d2afFozSUS562N6WSWdYKrFVgJAr9SIEOm5B2qTxWE+Dj
	/87JMho+t9DJRZExh7grewoVNT5w5o=
X-Google-Smtp-Source: AGHT+IEWQeyPb/coyR8msUs8+RQmeRVFk+kiHneGR5aYb2cgUYfzEnFwX1+4PQDSgqXz/kVt3dd8JCIrNsxl/2c5PTA=
X-Received: by 2002:a05:622a:5443:b0:4b0:701c:9435 with SMTP id
 d75a77b69052e-4b3291f41d1mr91052181cf.60.1756914538549; Wed, 03 Sep 2025
 08:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com> <20250826185201.GA19809@frogsfrogsfrogs>
In-Reply-To: <20250826185201.GA19809@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 17:48:46 +0200
X-Gm-Features: Ac12FXx3DFoxLZIiuUZIKwB8BXGdWppf3xDn0KACaY_D2rtfPAVEWc7VYYduezQ
Message-ID: <CAJfpegs-89B2_Y-=+i=E7iSJ38AgGUM2-9mCfeQ9UKA2gYEzxQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being sent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com, neal@gompa.dev, 
	John@groves.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 20:52, Darrick J. Wong <djwong@kernel.org> wrote:

> Hrmm.  I was thinking that it would be very nice to have
> fuse_request_{send,end} bracket the start and end of a fuse request,
> even if we kill it immediately.

I'm fine with that, and would possibly simplify some code that checks
for an error and calls ->end manually.  But that makes it a
non-trivial change unfortunately.

Thanks,
Miklos

