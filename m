Return-Path: <linux-fsdevel+bounces-23735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C452C932115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806E7282122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84197376E0;
	Tue, 16 Jul 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnoohVBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0B33987;
	Tue, 16 Jul 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114362; cv=none; b=lzebHgL+P6wQSdp9sZ1HMDe2/NKD2GNhcJS0Soixlgfh+hbgttLfOFWuLJKQgKo7B92E15HBBsE79AheZZHgJs9pNL8n7+xiWC/aRgFF2Xt9j9b3J2E4E7PkuOZ7AcPFqgIszmPM/U/sVGJ7gpMt2M+OdRAxG4/u12JMtUMqpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114362; c=relaxed/simple;
	bh=IHbOlthUDde/1Qg4ACzZafpb7XBZ2FC+wr18+zf+5gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MS5NnWSbGR/mnork0O2X/uI5/veT/NczbaOt/n8lLpORQilw95hsO0/z5BEDPTwCxIS06CnGdLEs7IEz/hW09Cf9oloWojaBCyEu0IcTn0ROQFHRnb4xJ7OiIVD9J0Kp1EgEciGPGMSTcvINUNpUVMmVs9nYunXqmPxqUTZZL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnoohVBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA893C116B1;
	Tue, 16 Jul 2024 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721114361;
	bh=IHbOlthUDde/1Qg4ACzZafpb7XBZ2FC+wr18+zf+5gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnoohVBLpFeCsb16MupJzO5EHjMN/W0DrnUEFPB1KoJtFlLxu0A35XgLJvABwCESV
	 hw1R6Na5QXfQEMjMGbO1bcnhe/B1ivt1yigZlCG0S0+GBvgd8BWFkEkkFLalUshOcK
	 MF6+OeFGb7cnt+xTuuoRag/A09+Ldu1+YZRtkksLSsolEJBo9e9ViG1/Z/A7gd4J9k
	 73aGty2Nr3PRg8hwlM92B0sR/FSzzzKy0TiKQi6LcdcNVH3a++rgEWntTpUDMqIekC
	 IB0M8lpxjy1fh6ZrxkQmMaJhqyUQ4yuDiOvEbaoQkRzot0TfkmncWb33GUa2trh+/e
	 e4vLjeH7Qg2Fw==
From: Christian Brauner <brauner@kernel.org>
To: syzkaller-bugs@googlegroups.com,
	syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	akpm@linux-foundation.org,
	aleksandr.mikhalitsyn@canonical.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH] nsfs: use cleanup guard
Date: Tue, 16 Jul 2024 09:19:11 +0200
Message-ID: <20240716-elixier-fliesen-1ab342151a61@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715205140.c260410215836e753a44b5e9@linux-foundation.org>
References: <20240715205140.c260410215836e753a44b5e9@linux-foundation.org>, <00000000000069b4ee061d5334e4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=brauner@kernel.org; h=from:subject:message-id; bh=IHbOlthUDde/1Qg4ACzZafpb7XBZ2FC+wr18+zf+5gg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNk/tw7aG63qxQT29G+UTT4iCjfYfXP2xYwLdzU5ZGZ vjkRXb1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5+ozhf+j9i/IzBeT43KcE n4/K9j7yN/+ceTb//m9peifzdt5/WMDwv3j9vRmtWe7hGpx888XiowyTM3n0zPafPxh8cLvgnZ0 NTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Ensure that rcu read lock is given up before returning.

Reported-by: syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com
Fixes: ca567df74a28 ("nsfs: add pid translation ioctls")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
I have a few fixes pending I plan to send out asap.
---
 fs/nsfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a4a925dce331..97c37a9631e5 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -174,14 +174,14 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		fallthrough;
 	case NS_GET_PID_IN_PIDNS:
 		fallthrough;
-	case NS_GET_TGID_IN_PIDNS:
+	case NS_GET_TGID_IN_PIDNS: {
 		if (ns->ops->type != CLONE_NEWPID)
 			return -EINVAL;
 
 		ret = -ESRCH;
 		pid_ns = container_of(ns, struct pid_namespace, ns);
 
-		rcu_read_lock();
+		guard(rcu)();
 
 		if (ioctl == NS_GET_PID_IN_PIDNS ||
 		    ioctl == NS_GET_TGID_IN_PIDNS)
@@ -208,11 +208,11 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			ret = 0;
 			break;
 		}
-		rcu_read_unlock();
 
 		if (!ret)
 			ret = -ESRCH;
 		break;
+	}
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.43.0


