Return-Path: <linux-fsdevel+bounces-29810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798E97E31C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 22:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6885B20FDD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CC43AAB;
	Sun, 22 Sep 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="AyETdCnu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jnRdO3Vq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52209B64A
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727035971; cv=none; b=TszvUmHH4tWY7UESCG9Yp20NvfNjyZT4nNfWv9h5Y+HYAHeVbRqf0C0gke/iDV4z+Pg7dJQtW7oQNV8/lT8hOLEjqgWBnCGUHoKnJAxDXT8C0A8ulnLJlCcb2eZcIpYGBYumKjlKu/X7DYAZPDaWFGpgw4pBd2A+xUjlbeDktUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727035971; c=relaxed/simple;
	bh=06bBpVceJC+2eb5nt5N/6lPgqT4KiLpA9pk/faKwamI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7NT0MfitzGoO6FA+Mlu+wQk3DQ946wBTlBmP7HT8tqo9MbF9YKG8RiFPD/Yadr+HtlEaazWKpr1L9pS+Ae9ibnGCynlO53qpW3+VIEAqfvTNAHkRP6RdoVj8FCbSvsMwYrr2SHpAkB2w7yf/nxeQ+b1zcyGs+WVDJmfaH6LUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=AyETdCnu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jnRdO3Vq; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=AyETdCnu4yvg747a8frP0+jAbBucGxH75A+kX8egnlISqBazVI4WUsGDzVyNY9+MeREtk2t8bdqy3mKWPyNS3Y+OIzYSe5mNQKx5U9iBQNY35Klf1ZW7ukTGAQTEvS+rT8g46L7V/6Ixg7u4yylZG2QkrEKBMcpvlGFBhbuSURSMfmmgpv6VbR5w0DDdAJwpgf1zycEgwObKjhfbqBsa4HFs1x3ekIuEW4gnAAwshdoOBfEDBVel87IqsqxxyPh8fpWpeJPPZ1+t+bXvXtGY91oiNQgZp6fdY9fhtK0bLCadrIIz7tck5CgNuQtKHE8kZf/9BL3Ni6pa+Pp0/NOI4w==; s=purelymail3; d=lkcamp.dev; v=1; bh=06bBpVceJC+2eb5nt5N/6lPgqT4KiLpA9pk/faKwamI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jnRdO3Vq/M7br2qCyQ4b7jD1RfCR9NbpvHSZ5lgR9fppNLwrQBMBhHAm2Fkr0pe7Q3RUMa0XhLvxUuVXIE6eKFCGKIAM8BxbjVhtCdYc1pgbdJw/7ExQAI6QNVoK5df9+agAC6cvom5Cxe89W5tIPX1kKJwkApJEhAV2ZIyCV1ghlEjR8SfBbAfAf/ojhfDUy8pIYQFCNb+rsM0CyT8rRWVVdxdpRHslQaHvAwAHcl/s5PNWDTeiYLU8U5vMj1WAP0Q8vxeJk77hvMzKG8QsFOqKJb6WRpxxk5cpmtPDtD+qQo02JuEK+ZaKcmLwtHM1kMFX8YUgbLkV+ZubM550iw==; s=purelymail3; d=purelymail.com; v=1; bh=06bBpVceJC+2eb5nt5N/6lPgqT4KiLpA9pk/faKwamI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 40598:7130:null:purelymail
X-Pm-Original-To: linux-fsdevel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1095037770;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 22 Sep 2024 20:12:39 +0000 (UTC)
From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
To: Gabriel Krisman Bertazi <krisman@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Cc: porlando@lkcamp.dev,
	dpereira@lkcamp.dev
Subject: [PATCH 0/2] unicode: kunit: refactor selftest to kunit tests
Date: Sun, 22 Sep 2024 17:16:29 -0300
Message-ID: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hey all,

We are making these changes as part of a KUnit Hackathon at LKCamp [1].

This patch sets out to refactor fs/unicode/utf8-selftest.c to KUnit tests.

The first commit is the refactoring itself from self test into KUnit, while
the second one applies the naming style conventions.

We appreciate any feedback and suggestions. :)

[1] https://lkcamp.dev/about/

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Gabriela Bittencourt (2):
  unicode: kunit: refactor selftest to kunit tests
  unicode: kunit: change tests filename and path

 fs/unicode/Kconfig                            |   5 +-
 fs/unicode/Makefile                           |   2 +-
 fs/unicode/tests/.kunitconfig                 |   3 +
 .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 152 ++++++++----------
 4 files changed, 76 insertions(+), 86 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (63%)

--=20
2.46.1


