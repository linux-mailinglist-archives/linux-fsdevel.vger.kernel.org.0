Return-Path: <linux-fsdevel+bounces-26214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D2956047
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 02:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416B0B2184C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 00:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746E38DE0;
	Mon, 19 Aug 2024 00:01:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3F22315
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025677; cv=none; b=nlPIdV4a450xN0tP+RTYTMUVEcHyZxoYvl1Yyand22tRmfePZQfoRafto8c28+M2NG1j4/FAF3B4hVLKUOX/t7+5dLnXCwdUZ8lyEFjEtLNxuxq8INDGypshtgfwV9xauHv48Wytfo1cFA41Y5Ju5hcxOLebp5YzvtyaXj7GTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025677; c=relaxed/simple;
	bh=dwsL5vQcvSNxCO2ciPwN1PsqrgulHRmYJDQGIjuijvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8LNgOzJD0xLC7uyKBCChmMrFjn2iXNGuJFYe4RU0HlR2nK/5bNtCZHuQJeat5btLF2pIFXXJuxpYOE6j9kP05frJ0Q+Gw/VEAAv7QfjwreymH9MqIhsyRIH0Iutfbwmpn2PYHnhr2L2HRWfYFvJwX6KdoxX3WJctKNOoWxWLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id fpn7sTYC0QGHUfpnJsxSIP; Sun, 18 Aug 2024 16:58:46 -0700
X-CMAE-Analysis: v=2.4 cv=LJ6tQ4W9 c=1 sm=1 tr=0 ts=66c28ab6
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=i0EeH86SAAAA:8 a=IvgdkJwC17PkWtJ-Yj0A:9
 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	lizetao1@huawei.com,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 0/4] Squashfs: Update code to not use page->index
Date: Mon, 19 Aug 2024 00:58:43 +0100
Message-Id: <20240818235847.170468-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAlTthPJvxGiNpsrWt7dw7QjinrpE+QrHwvNyMPzZIoDnHRE4mKJN7KhiDA/Bq3dJ36aFr7bcex+jJ49Re3P+5vIcHXXHSQayeDo5OpQYyyklHME1/UA
 g9iB7ihZ9UqmOx/AcBEu4Udyhpla0peRPs1Iv8uuMkQbcW3taMz3UVJTnqWh1RcJtk1SGMQvhToiSV0zwRK09WCkxJh3C8tR1URSYWQaiq5VJmj/RtqDbmOd
 PVnH9EpbNIb+7KAWLKwmpPCZVDc/iUG/cmzzitIO8Z6g8HanK8FOXulW+qBa/+qPAObMd9KRML6fjlG2KZnVaugzXbrAY+7Q6I2Mkja13Fi4JwrxdfSnMLsg
 JmoyAIhOjh6DtDXkfCzU2yxYE6zR1p74QItEeL1GmRcQ+0wjUes=

In the near future page->index will be removed [1].  Any code which
still uses page->index needs to be updated.

This patch-set contains 4 patches which updates most of the code in
Squashfs.  The exceptions are functions which have been fixed in
recent patches [2] & [3].

Thanks

Phillip

[1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
[2]: https://lore.kernel.org/all/20240817101146.2347378-1-lizetao1@huawei.com/
[3]: https://lore.kernel.org/all/20240817101146.2347378-2-lizetao1@huawei.com/

