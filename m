Return-Path: <linux-fsdevel+bounces-53276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67069AED2A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F9F165723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786A1A0B0E;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nx57QHFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AF1D63E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251983; cv=none; b=OXqfukDRY9ZEf0pvsSaFzoW7l5es+HwWHaufF7Hw3OvWbS2gK38SRmZYqRR7Hfus7M8GhrmCI7M+jMFk8NRU+ojZa16b9M1JqRXasjlh65wUTnu83cvec7SOHKdXgk29pA/bpIjLlypYq2/1rK69yiglQqbGpnKiUTwx3n12Bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251983; c=relaxed/simple;
	bh=r257DliHfUYNBMk7EM4vvUW00QQ6705yjJpGziNJPEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgW72Bv3LulJisL7Ii93Dji9JRyqVo2Sx2BpWxqSgPbIuJNYT0Kvqtc4nLGgAaHq9NVjiRnJoI/CGpbKou9h3npbaHA65pZT5RTC6b5u3R9wyE8G2WMcZCQk2aX1axUxjDNLhpEVQGO1kSEp5q7tgBGSlo3dnLhyFOI1KSZUlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nx57QHFI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5iI4Ojkf9EwCVwud+KwF4BY8OvCX2RI3VaappP8X9CQ=; b=nx57QHFIpyV63yypcbEr5PyVsv
	Dlu/7iT+iTD3n1G0LmPgTZeoTNaWNrVgdqBR2oV0ZreqfrK9Z5Bmaw6XGkhiwPxxB04eHohrBVuIH
	YZf5Sn8Qf3gaHrDFrrMug+DVTp86uEd65KDMFd0Rh2UeHu9YhuI//Q2bFxWE78dLG8WOKU/FkUN6b
	zYKobcFXo4woDmtqFG13Ftc+3ijjJpIZoU/s6t7OSVZfh9yQ8PEIIrQjrEQPurzR8dtQOdYSa6d0J
	aWvI3b2jwV51VbQuF81EZWJs1nF0/M1yYhBh1xbzfGSvdI/HF38kVnDFwpUk++rPoj8Rlm5HoKzyS
	h5LFRzcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p2S-0ABb;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 39/48] change_mnt_propagation(): do_make_slave() is a no-op unless IS_MNT_SHARED()
Date: Mon, 30 Jun 2025 03:52:46 +0100
Message-ID: <20250630025255.1387419-39-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... since mnt->mnt_share and mnt->mnt_slave_list are guaranteed to be empty unless
IS_MNT_SHARED(mnt).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 14618eac2025..9723f05cda5f 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -70,10 +70,8 @@ static int do_make_slave(struct mount *mnt)
 	struct mount *master, *slave_mnt;
 
 	if (list_empty(&mnt->mnt_share)) {
-		if (IS_MNT_SHARED(mnt)) {
-			mnt_release_group_id(mnt);
-			CLEAR_MNT_SHARED(mnt);
-		}
+		mnt_release_group_id(mnt);
+		CLEAR_MNT_SHARED(mnt);
 		master = mnt->mnt_master;
 		if (!master) {
 			struct list_head *p = &mnt->mnt_slave_list;
@@ -119,7 +117,8 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		set_mnt_shared(mnt);
 		return;
 	}
-	do_make_slave(mnt);
+	if (IS_MNT_SHARED(mnt))
+		do_make_slave(mnt);
 	list_del_init(&mnt->mnt_slave);
 	if (type == MS_SLAVE) {
 		if (mnt->mnt_master)
-- 
2.39.5


