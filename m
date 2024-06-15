Return-Path: <linux-fsdevel+bounces-21731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE590950C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 02:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E6F28269C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 00:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC701524C;
	Sat, 15 Jun 2024 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQQroqgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA234139D;
	Sat, 15 Jun 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718411381; cv=none; b=kkzqypFR4HW9VLYfJ8XjQjkEMJhTgAqwXqAlqAp8XZPfHfNm6Hirn4q5ChK0JWHlwRQiiXhujJzyNgHDgUDAFSu1MnJjJsfZlsykbHvdDlWoveSurdezYE/W8r4dJjch9FhDywDJIHGkDV0tGgjCxY50tPYPzq4ztfo1mXIx9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718411381; c=relaxed/simple;
	bh=LzR4xBIKFgw30BDJnPo+hLkxRjT06zyi3GD1pJgn8HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frVOOQoVXRm9K4P40SypDB23GDwnZ6dGGTzxiQy1KWbsN8BjO0xHfqwiH24j0Bq2VBtjZAlEp+RVz/1dt+21fS5Z5zasTJnjl5OasKr19PRkp2mx8H8edKTnKCSdby5D3aThaTRFirCmTulEdMAcRN3HZCvzj6p29NmUUVcwhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQQroqgX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N5wlEbcwTNotl6BI6h68OGk4bntX7UNNJ7n+lTWI9O0=; b=sQQroqgXiXfa/w7n73MO9X1bIh
	Xndg6p5VnAvGUWJpgnZghDl5ruJZV8Sq6LWVYX+eDhakAxG7xkalLeEdyG5lb/k3un30/7EGGnK1S
	Jst6fB/me/2r2XtIttl7reG3MwSIW7z+LrgRxG67HxCiOgSAd61bEwUApV4/lK6nLrGplPh+/oudM
	IvvKWcdoFcxoqAguQNbBwNY7wlVj7fNaxrxI8xdXIBfyVMr7SrU1EAmOh2mkCQNMzdRQm0gCjZ/CJ
	nZJ6F7zEYNnuNl6ELTvDxZrkpcZLGhucB2hdtM873cerRDkGks7hOkOg0IMyysHzWXM7og9ZXUzEv
	EaY90eRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIHIW-00000004KkO-00RZ;
	Sat, 15 Jun 2024 00:29:36 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@suse.cz,
	seanjc@google.com,
	willy@infradead.org,
	david@redhat.com,
	hughd@google.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	mcgrof@kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 4/5] _require_debugfs(): simplify and fix for debian
Date: Fri, 14 Jun 2024 17:29:33 -0700
Message-ID: <20240615002935.1033031-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240615002935.1033031-1-mcgrof@kernel.org>
References: <20240615002935.1033031-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Using findmnt -S debugfs arguments does not really output anything on
debian, and is not needed, fix that.

Fixes: 8e8fb3da709e ("fstests: fix _require_debugfs and call it properly")
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 18ad25662d5c..30beef4e5c02 100644
--- a/common/rc
+++ b/common/rc
@@ -3025,7 +3025,7 @@ _require_debugfs()
 	local type
 
 	if [ -d "$DEBUGFS_MNT" ];then
-		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
+		type=$(findmnt -rncv -T $DEBUGFS_MNT -o FSTYPE)
 		[ "$type" = "debugfs" ] && return 0
 	fi
 
-- 
2.43.0


