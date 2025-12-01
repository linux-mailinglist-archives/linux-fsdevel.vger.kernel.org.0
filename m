Return-Path: <linux-fsdevel+bounces-70365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDDBC98BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC17C343F17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2062236E5;
	Mon,  1 Dec 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kc1WiYEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA086211290
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614468; cv=none; b=jzKTctz8prG+7zmr5idv/yV1ZDovNKVLeph3fbFy0KU5X1DYDSH6wVcAZFva/3E3NETrovXys1oTCoseRQ+ZPX0BW5gWUMjxSv8kkroHSrkkvjl4ja9mZwfBY+XWPSLhbgn2H40LR+sg5k00bBG5V/mcxN/0kCQKzAlx65Slj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614468; c=relaxed/simple;
	bh=DuTPv9w7IAEWC0VimD5SxTseN4bCXCYxUcVcpotFjBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cjT5VXWOFHXBGDlSad28zZ4+HW1G97ZnjJwM2uJw1+jrdtKeDS5u6KlpKrPqHn3mTWxNXzeYr9X9INwu8ondSUOWvETxI1NY4a3fKYf77ZvV8WnjpIvUv88/zMwSVs7IOFblI/vgrFziqgchutiLb73DoCclgVNLzkLGL2bAaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kc1WiYEy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29557f43d56so49317645ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 10:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764614466; x=1765219266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIswF9CMvnraK8e7L4/o0qadvBef2Ftje9TVH+1eYRg=;
        b=Kc1WiYEyYyK6JWiOglL4PGt0cE1AiKubJ8wX8gMYmVRmdgGOyDVrkJUE/IwaZbrzYH
         ZF2XdoCHKCf5PuvOu+shOVUr5S3WRQTHSwqncIGkpRs0SJxmPwqjeeD02eeeMW19mDW9
         QFEV3EDqO/seBx57OAZyl+6NO4DOegm/ues1Vw6kHsVJsHjrd+7d+sOTV0dc3dl9TLe3
         Vc5oScHD7MwDEnEUE6riVLTOk8UJsuQ+A5yc4FZfWRkC/jDRqJb5BtlkEIMy9KcsT/4q
         rpXypJh4+CR5bR1kimjKeWtkmN3/fATibxS3z+5DWCyNy59sT/yv9QjNZAquQ8jGq6x8
         AJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764614466; x=1765219266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIswF9CMvnraK8e7L4/o0qadvBef2Ftje9TVH+1eYRg=;
        b=PSvdjeQRW8GeWzX06CsTahPtEcEPlnLl8UxIKEyK6EzXtEbPPTfe+ob/IjRsH4WgDU
         MCkLRTQ97KqvAw5KuRunU9EQ9SlzaIcgePZKckZrzivqsACW1yGKnbFLvi7rnOJV/TyR
         eYOdf3C8FQyx0e0cyjb7trm+qXT8egLfw8en+0vW12Ahd2jLNvAyk6lB2EoI7GsSQf/K
         NBYQOMNqBt0SHh5myEkax1ZaW1APWf2x+rVe9b1SLSM7BSysH/dr+nWqoun3GO3Ra1JX
         V4+LSQkiJnTuuWNRMDi/NWFNvQ7kfHPGWPb5r5qOfmcwG7U+S7xO6tvprS0VDvIlXvnk
         EoGA==
X-Forwarded-Encrypted: i=1; AJvYcCVxjNrrf0nK1yDpAN6jOBoPjhPPSFUl4SiAEKMsqriiI5tSc07G8T9Pps2o8EQEjsH0g2UA+EFXJVZpuxEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzXF88BVNP1pbf+idhZg0pqqu0o2//UmpMgvklMUIq+Js9WZ1ue
	36PQKiqY2OVSTZr7oOHlX1JSFrj0wEGzTsM3u6/nbb1gci5CQnwTssLfGP8yPpDUUj4zNuPOIs9
	2+am+SA==
X-Google-Smtp-Source: AGHT+IGXdEd9mdo5t6fFzrNJLEWOsjqqyHF+rT0I0RHXmvgXzC6pomZxFHRezlDsWy8wgEpE3q3L9Ag5pi0=
X-Received: from plj12.prod.google.com ([2002:a17:902:c14c:b0:295:64f4:dde2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f4f:b0:295:7453:b58b
 with SMTP id d9443c01a7336-29baae4569fmr291488755ad.4.1764614466141; Mon, 01
 Dec 2025 10:41:06 -0800 (PST)
Date: Mon, 1 Dec 2025 10:41:04 -0800
In-Reply-To: <20251201141556.GG3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-fd-prepare-v619-e23be0b7a0c5@brauner>
 <20251201141556.GG3538@ZenIV>
Message-ID: <aS3hQDmuQQsdq7tL@google.com>
Subject: Re: [GIT PULL 16/17 for v6.19] vfs fd prepare
From: Sean Christopherson <seanjc@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 01, 2025, Al Viro wrote:
> On Fri, Nov 28, 2025 at 05:48:27PM +0100, Christian Brauner wrote:
> > Hey Linus,
> > 
> > /* Summary */
> > Note: This work came late in the cycle but the series is quite nice and
> > worth doing. It removes roughly double the code that it adds and
> > eliminates a lot of convoluted cleanup logic across the kernel.
> > 
> > An alternative pull request (vfs-6.19-rc1.fd_prepare.fs) is available
> > that contains only the more simple filesystem-focused conversions in
> > case you'd like to pull something more conservative.
> > 
> > Note this branch also contains two reverts for the KVM FD_PREPARE()
> > conversions as the KVM maintainers have indicated they would like to
> > take those changes through the KVM tree in the next cycle. Also gets rid
> > of a merge conflict. I chose a revert to not rebase the branch
> > unnecessarily so close to the merge window.
> 
> Frankly, that hadn't gotten anywhere near enough exposure in -next and
> it's far too large and invasive.

+1.  Saying that I want to take the KVM changes through the KVM tree is
technically true, but glosses over why I objected (or even noticed) in the first
place.

https://lore.kernel.org/all/20251125155455.31c53cf9@canb.auug.org.au

