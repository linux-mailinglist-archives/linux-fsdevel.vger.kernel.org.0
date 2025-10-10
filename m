Return-Path: <linux-fsdevel+bounces-63805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C0BCE748
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5224425F87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D299302152;
	Fri, 10 Oct 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sdel+SBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5E302147
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127179; cv=none; b=W9m6/V5NGdPDc7ArQB4WWOVrRg0SXw1/b288IuzFXGO1LHZ9+F/oqO/t0Rek2KOjlHlH+UEilKu8E7xNECJnw+sEE75fYCgchMLjA7Uqk83GPE5BsflsxpU5YYfOvKscHuVDNrrb+rOJjdYvRDhhVwDeXZsSP5mMjyByjdcEo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127179; c=relaxed/simple;
	bh=GQcx+TU7fuLzoGdeHsL8ko0iP8KkW40Ytzb/2PJCuk4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Bh5VFlF+2Ez9ZWL5zGnln5JsOw9MzVJbsghfqxi6h1wS0DmMvnyB9wEC0Z08xbqjVqBP0FsbGDd5I/TrPwsb2OHVbsk/PPhlrRWWZQlW2IX8/svdX/jIOZqyMZrF0ZDpph4JulFrkAyiioDG8eAQGMzv1d5teCwblBjEVk96suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sdel+SBC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760127176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=n4DohHvjih3CWxn3/UWAUfLYr89Vly2sg7awSARwMDo=;
	b=Sdel+SBC8sUxqmiE3kpNSRclTKQafS1wnFiHgYMM5oCxaYh64m0o72SJTXbGzqOcTJEOIp
	ocJvpqCgz2WbFJS1XaU/t9aa/V7Bjz73zSQMAXAa2fNEKv3HxrpNVXYFa/DQ+gwHR4QxVz
	8OCTYP2UPzSlYN9raUNK+mViElY9Krw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-fpesjRtDOUWfqUw5iRIu6Q-1; Fri,
 10 Oct 2025 16:12:53 -0400
X-MC-Unique: fpesjRtDOUWfqUw5iRIu6Q-1
X-Mimecast-MFC-AGG-ID: fpesjRtDOUWfqUw5iRIu6Q_1760127172
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 022F11800350;
	Fri, 10 Oct 2025 20:12:52 +0000 (UTC)
Received: from [10.45.224.32] (unknown [10.45.224.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 162321800447;
	Fri, 10 Oct 2025 20:12:49 +0000 (UTC)
Date: Fri, 10 Oct 2025 22:12:43 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Su Hui <suhui@nfschina.com>, 
    Yikang Yue <yikangy2@illinois.edu>, linux-fsdevel@vger.kernel.org
Subject: [git pull] HPFS changes for 6.18
Message-ID: <fc8d9173-2586-cb80-b70a-bba7c8be02f5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Linus

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.18/hpfs-changes

for you to fetch changes up to 32058c38d3b79a28963a59ac0353644dc24775cd:

  fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink (2025-09-08 17:26:05 +0200)

Please, pull, thanks
Mikulas

----------------------------------------------------------------
- Avoid -Wflex-array-member-not-at-end warnings

- Replace simple_strtoul with kstrtoint

- Fix error code for new_inode() failure
-----BEGIN PGP SIGNATURE-----

iIoEABYIADIWIQRnH8MwLyZDhyYfesYTAyx9YGnhbQUCaOlnMBQcbXBhdG9ja2FA
cmVkaGF0LmNvbQAKCRATAyx9YGnhbWiLAQDOJdFzQxSdrX7KPmi+yMBqnrtL7TYD
cazx/3zORdP2kAEA16PUvT7uEdrblf3ZmOfHGe6RDhCzff56ebRc2Y1HqA4=
=pwvh
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      fs: hpfs: Avoid multiple -Wflex-array-member-not-at-end warnings

Su Hui (1):
      hpfs: Replace simple_strtoul with kstrtoint in hpfs_parse_param

Yikang Yue (1):
      fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink

 fs/hpfs/anode.c | 43 ++++++++++++++++++++++---------------------
 fs/hpfs/ea.c    |  2 +-
 fs/hpfs/file.c  |  4 +++-
 fs/hpfs/hpfs.h  | 44 +++++++++++++++++++++++++++++++-------------
 fs/hpfs/map.c   |  8 ++++----
 fs/hpfs/namei.c | 18 ++++++++++++------
 fs/hpfs/super.c |  8 ++------
 7 files changed, 75 insertions(+), 52 deletions(-)


