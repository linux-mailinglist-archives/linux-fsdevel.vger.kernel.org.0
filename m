Return-Path: <linux-fsdevel+bounces-27428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7E96171D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169C61F22872
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8D1D2F4D;
	Tue, 27 Aug 2024 18:38:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E41D27A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783927; cv=none; b=c4noCmLV1GmN1ljZAbArkys6Tuirzeh3IZ9Pr+ZfKoVq6ZHsxa3+COV2eJ+X89eutLbIKR2hSxYHI2/kTjWaTr4X8HDmG0NqDY7JHrS4OAMPjh82hiK8yGdKFDciQ1aDzY7yNxCQ0l/DGLlTK/3b9JJ/AJXUrniX0ghmD8UOX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783927; c=relaxed/simple;
	bh=+F/anzSI4Fm5wVv2mzl2/R6RHwj4iXQ42Tr/l3oEugU=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Y+Nr+FxcdyxY8LvlY7kj9M13IYxfTh2ptRXrsRY2yK4Edgkf6fUmD6nKwi8HGYjem0E7x4wNgRU6Bi7h7zFyE5WQH73cGpCqa4+vMXRM9227q9jaxwoR/9CbEcZCeqQI6NNJYtaF7mvfZR79jej7JcRuijo4DEquh0KdhxYf/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-190-79.static.sonic.net (192-184-190-79.static.sonic.net [192.184.190.79])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 47RIcc0W004765;
	Tue, 27 Aug 2024 11:38:38 -0700
From: Forest <forestix@nom.one>
To: Forest <forestix@nom.one>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] cifs: triggers bad flatpak & ostree signatures, corrupts ffmpeg & mkvmerge outputs
Date: Tue, 27 Aug 2024 11:38:38 -0700
Message-ID: <g87scjlif3eaff02i2u2kstullto3erb95@sonic.net>
References: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
In-Reply-To: <pv2lcjhveti4sfua95o0u6r4i73r39srra@sonic.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVaWlo+voc/tb5rtMHTPlFeVb+Ex/T+O8qBjdZaly11Tri5gdVa32opJXwwx5hukqQtYx/GVNc5a9fKyBck4Lg2k
X-Sonic-ID: C;cARUk6Nk7xGDt65Sr7edkQ== M;VhFck6Nk7xGDt65Sr7edkQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Sat, 24 Aug 2024 18:50:40 -0700, Forest wrote:

>I was unable to determine whether 6.11.0-rc4 fixes it, due to another cifs bug
>in that version (which I hope to report soon).

That bug is now reported:

https://lore.kernel.org/linux-cifs/37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net/T/#u

A pair of patches considered in that bug's discussion allowed me to test
this regression on 3e9bff3bbe13, which is one commit ahead of v6.11-rc5.
The mkvmerge output corruption is still present.

