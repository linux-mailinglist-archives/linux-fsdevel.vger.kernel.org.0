Return-Path: <linux-fsdevel+bounces-11882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C648584FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90999284760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156181350FA;
	Fri, 16 Feb 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M2MUx59/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC512F377;
	Fri, 16 Feb 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107545; cv=none; b=BVH8RlfJF3nCd+oFNO1fECwPZ4Xe3CUqPT5vLWDIYF4bfoj4czitD6ZGQ708zcQExJlcaS1/lRPESnC0LVAndf2I4+DU2v38PmZSFrUfzOvsJnkbQvzMgmI705gE0FB8Ym1lGoCAtv2tfDxQV5fqFcdFmN4VqXobw4oAhh1rTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107545; c=relaxed/simple;
	bh=zjCh7H6HubQX8KzPAFDoxH9P+22DL5xW8DRn4TWQHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKq+JuI1xHsz7p1Lu4w71rYu9eQZpYInhLKMdrfe9VzFpUQU0X9qtC2wt6RWh6XIfzCf7t6dVeL5MATbFIF6lFAxaYgBfIsu1nF74iG0qvv/a65WlNSXODKuXUXhLTzlzB+okgne5lV5SDVr+sGnAM6k7/RomCpQr2+bsta91+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M2MUx59/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LB98ump9h5Ql70grOrlteUMjlrKbcgSz0auQG0GpFF8=; b=M2MUx59/UqT2hMTVtW8koEXNG8
	mJoIkTwHPXJz1lRiuYAYUzikLGoe1n+PZ2VlAJ8tdWJg0jwmrMaVnt7xNRJOy2n5uMp+YuzCpDG4z
	SYa61vK6P6TAcCbMBIGcP3/kV0f35x0BZZ1U7S7B3LjMAQgyaahsU1eXAq+YMUO42GK1Tsjwljrax
	MjCiaOI71Ty/G10luhbHnv1Zoh0hyu9PH80mu12nP6p3vnicdFtyhNPekxLpPEo923DUcpFPKu24Z
	dS2Lsm5uf87MjI58pIa76xl0edyS/nosFlv7bovJNTOj1tLU3ytbFsbfQGLiOsf/HUdiqjsx6X5qd
	pW1SMpTg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb2nd-00000003J8C-3Cal;
	Fri, 16 Feb 2024 18:19:01 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org,
	anand.jain@oracle.com,
	aalbersh@redhat.com,
	djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH fstests 0/3] few enhancements
Date: Fri, 16 Feb 2024 10:18:56 -0800
Message-ID: <20240216181859.788521-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

This adds a couple of enhancements picked up over experiences with
kdevops. The first one is to augment the set of tests which are part of
the soak group. That required careful review of all of our tests, so
might as well update the tests with this information.

To allow us to verify this, we add an option to let us list the tests
which are part of a group with --list-group-tests. This came out of
recent discussions where Darrick proposed perhaps it might be possible
to query this [0], this is an attempt to help with that. The goal here
is to ensure that any test which does use SOAK_DURATION will be
agumented properly in the future as part of the soak group.

The last patch is a simple fstest watchdog enhacement which lets
applications monitoring only a guest's kernel buffer to know when
the show has started and ended. It is completely optional to use, but
kdevops has been using this in its own wrapper oscheck.sh for years now.

[0] https://lkml.kernel.org/r/20240125222956.GD6188@frogsfrogsfrogs

Luis Chamberlain (3):
  tests: augment soak test group
  check: add support for --list-group-tests
  check: add --print-start-done to enhance watchdogs

 check             | 32 +++++++++++++++++++++++++++++++-
 tests/generic/019 |  2 +-
 tests/generic/388 |  2 +-
 tests/generic/475 |  2 +-
 tests/generic/642 |  2 +-
 tests/generic/648 |  2 +-
 tests/xfs/285     |  2 +-
 tests/xfs/517     |  2 +-
 tests/xfs/560     |  2 +-
 tests/xfs/561     |  2 +-
 tests/xfs/562     |  2 +-
 tests/xfs/565     |  2 +-
 tests/xfs/570     |  2 +-
 tests/xfs/571     |  2 +-
 tests/xfs/572     |  2 +-
 tests/xfs/573     |  2 +-
 tests/xfs/574     |  2 +-
 tests/xfs/575     |  2 +-
 tests/xfs/576     |  2 +-
 tests/xfs/577     |  2 +-
 tests/xfs/578     |  2 +-
 tests/xfs/579     |  2 +-
 tests/xfs/580     |  2 +-
 tests/xfs/581     |  2 +-
 tests/xfs/582     |  2 +-
 tests/xfs/583     |  2 +-
 tests/xfs/584     |  2 +-
 tests/xfs/585     |  2 +-
 tests/xfs/586     |  2 +-
 tests/xfs/587     |  2 +-
 tests/xfs/588     |  2 +-
 tests/xfs/589     |  2 +-
 tests/xfs/590     |  2 +-
 tests/xfs/591     |  2 +-
 tests/xfs/592     |  2 +-
 tests/xfs/593     |  2 +-
 tests/xfs/594     |  2 +-
 tests/xfs/595     |  2 +-
 tests/xfs/727     |  2 +-
 tests/xfs/729     |  2 +-
 tests/xfs/800     |  2 +-
 41 files changed, 71 insertions(+), 41 deletions(-)

-- 
2.42.0


