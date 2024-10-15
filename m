Return-Path: <linux-fsdevel+bounces-31978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C3599ED35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAFD287420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4C227BA6;
	Tue, 15 Oct 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="KIXolSSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C39227B99;
	Tue, 15 Oct 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998482; cv=none; b=c5a7qwAQvufq9Mls9YIsU6R65hPfE1MqlKQP9p8IwUs7IxMEWNu4/CDf0vn5Fue9l1U1OA4WlRqujBD60GJsy0mcUhXM+axlo8hR8a7f9AXDTY1pP8dZi5lbz32YdT7VJu5s6MEmhjrRPaMiNs5LUDQAnGKxZZCXDgcSiWFJKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998482; c=relaxed/simple;
	bh=SXUiZI6sK5jeXdKGbJyo4LmI6N5glU7kUgkJxapNnaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BG97ft2JqsoKNtwomdd7wfv0bWNdpOFswUibroDm+J2pMvx/5jUrtJ2lm2XwE2KeyklkSYtCt+3KYCFPR/RO2Wy9e/ssGx1RSpu9HJBTHXTh8xrdkGR2G/ck26vButHBp0otUTV+qbET/T54xkni1zCMTztdwLyM3K712nd9/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=KIXolSSU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EC1B60015;
	Tue, 15 Oct 2024 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728998479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sImSw9B4ICMqgAhAeUbnH9m4Nhw5sQSlUjxcISehZgI=;
	b=KIXolSSUAoAa/dxj+mI3mdlcGQmhA+6+cAWyhWt/X4lK660Tvd+pszcMqWRtYALswqMak4
	eQqVv/u3bFC11r3qtJgjK/ShdHYdLMCET8jYdQ57fcCW/nli6BqYm11Tmp36/XNeB/xs++
	OFrm2tP0/vNpXP2euYTWaVDzEFvE2MoO/+1DwPlvnktCLX15uPjb4dBHtrRYGgSQR+7Y8u
	lM8lANku61M48EB04o70VgH4CfgcYPRAjzfMlMUXlpd4MNbsXKJftKudUSpx08Hf3fLEey
	JtFrGR00zpYm/ptlAaLEainKQb1fMHb3ls4ijZ0BzsZ6QCAjCT5JBjPP9k3Eng==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Brendan Higgins <brendanhiggins@google.com>,
  Rae Moar <rmoar@google.com>,  Kees Cook <kees@kernel.org>,
  linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com,
  linux-kernel@vger.kernel.org,  Stephen Rothwell <sfr@canb.auug.org.au>,
  Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
  linux-fsdevel@vger.kernel.org,  ~lkcamp/patches@lists.sr.ht,  Pedro
 Orlando <porlando@lkcamp.dev>,  Danilo Pereira <dpereira@lkcamp.dev>,
  Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH 6/6] unicode: kunit: change tests filename and path
In-Reply-To: <20241011072509.3068328-8-davidgow@google.com> (David Gow's
	message of "Fri, 11 Oct 2024 15:25:10 +0800")
References: <20241011072509.3068328-2-davidgow@google.com>
	<20241011072509.3068328-8-davidgow@google.com>
Date: Tue, 15 Oct 2024 09:21:16 -0400
Message-ID: <87sesxsdrn.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

David Gow <davidgow@google.com> writes:

> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>
> Change utf8 kunit test filename and path to follow the style
> convention on Documentation/dev-tools/kunit/style.rst
>
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> [Rebased, fixed module build (Gabriel Krisman Bertazi)]
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>

-- 
Gabriel Krisman Bertazi

