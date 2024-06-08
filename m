Return-Path: <linux-fsdevel+bounces-21285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA6D901236
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CC01C20BE2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F67179652;
	Sat,  8 Jun 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="avRfbVYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088015699D;
	Sat,  8 Jun 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859337; cv=none; b=ftyZUCCTiu7uvd/56gEXmDNBrPk1U3QeANtumF2n6QexvI71Hvj1/c6ZzGQ6pFZE8Q9Jil4BHO3AaXPWc4r1d19c1gzODTIBUK3XOIR/0agakhS1e1ToIqGRq0U/6he8rBr99vtvDbqa+erkrQW8r4inbDBKnS0z9OJfN66ahT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859337; c=relaxed/simple;
	bh=/8Eaz0dOzW2Y/Aqj56RjuuuZa7c4BBPmMKiet5G1VG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myOjKu0KnGEoJptDoOE2RqXtTgQw4BRQ4zuc5XINRbE1w6f4SyoU3ZiCkZltWM5faOtFizgKDYPxk6qHoLvzBEfiBzeDWxaxxWVZ1EhbLcGNYy6aqeBKd9KzISOGmHZqaaGQtRYQuWlYtl4OuQj+VDlHCTBDblHDM9avZUPICd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=avRfbVYm; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Fx9Rs04TztVxQFx9RsAXo1; Sat, 08 Jun 2024 16:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717857283;
	bh=wdE+q4tYw0Mtn7ZcN10lEjC0L3+XOPxEbNZhXe9vMQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=avRfbVYm3oI+Q1ijAAVS0vX3w7ecGwso5Kk+KnoGVjGFiOgMHOmeMl+H45CKj5MJA
	 wPwRR3hnQuYrKqj0XLnQ126JXk4THpYfhecCwfl8JoACIbS8CSob86RnSb10mha9LL
	 uw7b8Fy+G4mdAkVlwtgBVD/RmDClZhQFcUuS4UtDGcQcutA0WdY49E04fGO49UJaWE
	 UzhYWymT1ajfeTKTYlO7LLDuKUUKRfSRrWU77MJMCHwiQisRUblrjUADHGmES8dZHQ
	 wk8pP7xVeXJr0B2FVyafuyidHZEQdZuB4UV1T9xhVETDzvSk+AWX0r+4zt5hpUrbFH
	 H4K0D2jll+SlQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jun 2024 16:34:43 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jk@ozlabs.org,
	joel@jms.id.au,
	alistair@popple.id.au,
	eajames@linux.ibm.com,
	parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsi@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND 0/3] Remove usage of the deprecated ida_simple_xx() API
Date: Sat,  8 Jun 2024 16:34:17 +0200
Message-ID: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The small serie removes the *last* usages of the deprecated
ida_simple_xx() API.

The 3 patches have received either a R-b or A-b tag but never reached
-next in the last 2 months.

So, I've added the tags and I'm now adding Andrew Morton in To:, in
order to help in the merge process.


2 other patches related to this API are still pending somewhere and are
not reposted here.

[1] is related to tools/testing/ and will be re-sent as part of the
final removal, as suggested by Matthew.
It is A-b, but the name of the function used in the test should be
updated as well (s/ida_simple_get_remove_test/ida_alloc_remove_test)

[2] is a tiny clean-up of a comment. I'll resend it to the corresponding
maintainer (Srinivas Kandagatla) later, but won't fight for it.


Obviously, you can also pick up one or both of these patches as well :)

CJ

[1]: https://lore.kernel.org/all/81f44a41b7ccceb26a802af473f931799445821a.1705683269.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/032b8035bd1f2dcc13ffc781c8348d9fbdf9e3b2.1713606957.git.christophe.jaillet@wanadoo.fr/

Christophe JAILLET (3):
  fsi: occ: Remove usage of the deprecated ida_simple_xx() API
  most: Remove usage of the deprecated ida_simple_xx() API
  proc: Remove usage of the deprecated ida_simple_xx() API

 drivers/fsi/fsi-occ.c    | 17 ++++++++---------
 drivers/most/core.c      | 10 +++++-----
 drivers/most/most_cdev.c |  6 +++---
 fs/proc/generic.c        |  6 +++---
 4 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.45.2


