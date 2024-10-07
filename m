Return-Path: <linux-fsdevel+bounces-31177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCBD992CD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE1828399F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B11D4169;
	Mon,  7 Oct 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VNG3Ewy8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C01D3629;
	Mon,  7 Oct 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306859; cv=none; b=K6UmDS2M4/yeWRfuK1fcJT+37RNb25KlolRuDYvbWdpjmETHvFxB4qZ8pbhfy7RoFWRyJkOkJhFnVExm+b04X6GEHYiTKbamA8DYG0T6yWwRL8rthlBwmuKCQZW5F0V8ga/eyvGUGJ78U47hUYM5z4o/CAYI+A/y1C+lrltqKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306859; c=relaxed/simple;
	bh=NYc8GAjTu9F6DiVdK8eJC36y7F//hihFgSMNmUQsvvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qt/Q8OJ+zp3Nd0nQDwUGdvpesNUSx2u+9rxjSCAmKNi8A8yGfED3FYLpSxJE5MU6l46cpFzuuZDKOZU+U03LsQx63zRmpVKIYtbQ/zymIOyprN1G5zly8V0FVlFUE0Xy2AkrAyfS1DK90L1Gv47V1Rv8h5VgxeduLGMpGAUuG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=VNG3Ewy8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1728306522;
	bh=lrKGIRf2F9bRmM3xJUTak84RRDbsg04jWzFdaqnj5LA=;
	h=From:To:Cc:Subject:Date:From;
	b=VNG3Ewy8n65C/nm4nIvO3WQt6OlLu+KtFGSOnym65kQ9qeVFk52jFTu5Osa3V8Yli
	 mDhwlAVrce2m6FMKqd92Ny6v6QiluTKdf7pYTA8M4c2pxbgAoble1c7J44tTb9MZhh
	 IO8WX3uRD0xvlfJ7OFlmSaGVj/6iqo1HiYgzqZ/8=
Received: from stargazer.. (unknown [113.200.174.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3BBF21A41FD;
	Mon,  7 Oct 2024 09:08:41 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Miao Wang <shankerwangmiao@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] vfs: fstatat, statx: Consistently accept AT_EMPTY_PATH and NULL path
Date: Mon,  7 Oct 2024 21:08:21 +0800
Message-ID: <20241007130825.10326-1-xry111@xry111.site>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Linux 6.11 we support AT_EMPTY_PATH and NULL path for fstatat and
statx in "some circumstances" mostly for performance and allowing
seccomp audition.  But to make the API easier to be documented and used,
we should just treat AT_EMPTY_PATH and NULL as is AT_EMPTY_PATH and
empty string even if there are no performance or seccomp benefits.

Cc: Miao Wang <shankerwangmiao@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

Xi Ruoyao (2):
  vfs: support fstatat(..., NULL, AT_EMPTY_PATH | AT_NO_AUTOMOUNT, ...)
  vfs: Make sure {statx,fstatat}(..., AT_EMPTY_PATH | ..., NULL, ...)
    behave as (..., AT_EMPTY_PATH | ..., "", ...)

 fs/stat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.46.2


