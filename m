Return-Path: <linux-fsdevel+bounces-61048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F7B54BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52213B3875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996833054E9;
	Fri, 12 Sep 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy/lyLBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987B301479;
	Fri, 12 Sep 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677997; cv=none; b=soK2F1LGfFej1H1XJYZExJMiNz8eNDNU4pAVbU9dxTQE9E0Sxz5+pbBATN7+6Od0SH1v6Xl8FJ9xU2l/EPf1M4ScWLS8JS3CjxPWg9ibVTLgyFNOvcdSjhEXvoHy709t+T8LKQHLZqhU2UrF+D+9meusZR7YJK2fuuNoJAkquus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677997; c=relaxed/simple;
	bh=bpHiyS+5xC4YzDvagV0hyz6n4+V/wicp1a49CbMaOpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tty/W4dG6v2x52u3w/J4rkaKab1yYPf8eE+7R+0DTMJAxPIEd39Vi7QzafeDC5NsQAhb0LNumfHAYHlXNiv+cfcQ78s2ez4R97Nous7p1QZK4+eEu6dyL5CeIC1oyoq1N5gH4KZkDJ8rtYRiZS/bwgyh5Awps7qp3YkGZcK6koU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy/lyLBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC15AC4CEF4;
	Fri, 12 Sep 2025 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677997;
	bh=bpHiyS+5xC4YzDvagV0hyz6n4+V/wicp1a49CbMaOpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jy/lyLBT4KJ4Qtm8oq3503OT9hfcr0UZvAI1fzTUnNQGH5a6CDXHnre90qYxxME/i
	 vVzQtvulOvvMp1QdO/N98tTZ0C3dtPTkZcdTGqUxpslzv1mJQRJvk/f43r9epxbJRl
	 kF09XsGaXXNk/ByiruGnE4jJou6e5pm3U8thqEnT0VuDzjreTgVlZ8Ft1DVVkmz8yx
	 fvSBmOpH8IQNNexzS5ikFNP72+PVjdbqXo8IEarwhknpOYcS/AV8p8Qw5cRzZGQ4WF
	 rnrbdV5MDwc7TKgE96y3IbsWuu8F79LLm99yg1AT0Jn5KJAAjr5l3A0Z7VWwgscnFV
	 Mv0mgMuHiyThw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:26 +0200
Subject: [PATCH v2 03/33] nsfs: validate extensible ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-3-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bpHiyS+5xC4YzDvagV0hyz6n4+V/wicp1a49CbMaOpc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZyyR/3DA56ll5mds7rlig6/Uk76+/3vM4/Vcr8f9
 ++wcIht7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIzX9Gho4ZIZZVs2YFJpnf
 mmf/M0jJTe9W8Lrq9zNygn+o3oxJaWf4p5a9jSNtyW/Byoe7T4ZeNwxa/6V9amHoRr6zqy1rG0u
 ncQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Validate extensible ioctls stricter than we do now.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ce51041bb624..d016d36272d4 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -169,9 +169,11 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	/* Extensible ioctls require some extra handling. */
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(NS_MNT_GET_INFO):
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_INFO, MNT_NS_INFO_SIZE_VER0);
 	case _IOC_NR(NS_MNT_GET_NEXT):
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_NEXT, MNT_NS_INFO_SIZE_VER0);
 	case _IOC_NR(NS_MNT_GET_PREV):
-		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_PREV, MNT_NS_INFO_SIZE_VER0);
 	}
 
 	return false;

-- 
2.47.3


