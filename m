Return-Path: <linux-fsdevel+bounces-31557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC8998658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E2E1C22BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0E1C9B65;
	Thu, 10 Oct 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="E6wOqTfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD31C4611;
	Thu, 10 Oct 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564089; cv=none; b=WA5hLIF4xp+tTlprg13obBMAbytx/oW37UNu65J7ZxLf392iA+nyeMFgaYb6P5s/bK9OqwyUI6IUjeErZNEFkA4PhDlfpGCAufgj0UWMeAoO+8S37t3+K5kKNotXUjFA/sO0UrbqZqlQslEDpHllkdCRlSP1SuxkeihqzM91eoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564089; c=relaxed/simple;
	bh=ypDIvwcATtiSO7VRxsF1nhH5/6Dp1JyUkF68kc22vD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSPu0pMPFCqZQrGQT4YKTDNEmP3rZx6BMUGdfY4NctiUPHdKiG9IWw/Yid1q6A4HvyZ2V9wFc260ypD6dl9DF8lyJMqPgxKC9Z8KRM4ZwhEuz+WGt4Rv7hRbYWz3mFbRF8yYDn8KrtDod8kjcDOjb0C6jUsg52RVVxQ4MhBuLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=E6wOqTfC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2B0242BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728564086; bh=ypDIvwcATtiSO7VRxsF1nhH5/6Dp1JyUkF68kc22vD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E6wOqTfCoi42biH81tadWDgjqW04FttF/LLTEtVY+qln3cCgDt4knu2K9qG63Ldt5
	 8OarMPoXfcDYVp02EH2zv+wBeClrScrcCiL4Fu4LGNZ0vSgblKqkmesKpSghIiFZWA
	 iKlQGJk5PD4NB/PovaVTvhey2aUWcwnfQ+vATgCmGcypd7n2xYMN+z6A5FSvjOkLYo
	 9sFe8s+A7DKKDQ94eSfVLEm6HrAGwtdWRUjReRN90rVnzbR3jH5g05z5EKHzSY7g3H
	 sJY1VYArLDl8CAH52PsBhboCgpAhqWZ21sjFDCLQbSKdbrVw+XDwEJD8MO5rRB0DTp
	 yTXUaKQskm92w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C2B0242BFE;
	Thu, 10 Oct 2024 12:41:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
In-Reply-To: <20241010-bewilligen-wortkarg-3c1195a5fb70@brauner>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
 <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
 <20241010-bewilligen-wortkarg-3c1195a5fb70@brauner>
Date: Thu, 10 Oct 2024 06:41:25 -0600
Message-ID: <87h69k870q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> pidfd_info overwrites the request_mask with what is supported by the
> kernel. I don't think userspace setting random stuff in the request_mask
> is a problem. It would already be a problem with statx() and we haven't
> seen that so far.
>
> If userspace happens to set a some random bit in the request_mask and
> that bit ends up being used a few kernel releases later to e.g.,
> retrieve additional information then all that happens is that userspace
> would now receive information they didn't need. That's not a problem.

That, of course, assumes that there will never be a request_mask bit
that affects the information gathering in some other way -- say looking
in the parent namespace or such (a random example that just popped into
my undercaffeinated brain and is unlikely to be anything we actually
do).

But then, as I said, I'm bad at this :)

jon

