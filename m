Return-Path: <linux-fsdevel+bounces-27205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3395F7B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0FD1F23173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA943B782;
	Mon, 26 Aug 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NRsw+253"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68E19409E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692469; cv=none; b=MhVxov/uLPRKTt9vkzbkzMDcQZAzAb2iaisH1+tzfGn7LNJ3uumX5wQF88HzaV/iDe94jurNztBaT91RY8mZzUUNwjuNFiJWRNJo62WpOG9FDdP46U/sr7lu7A7IwtNbfJP25LkMHSvj6sAlTRIP1gRslzkOCtwSyAnQKqxYStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692469; c=relaxed/simple;
	bh=AUoypyHv0/bPzK3CdgiN0SLBCA9RpFvaVPOxWvIMzwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WzCj2gSfccWVRDOxCja0+6x/o6vCUiTppn16IiyClSSZQFT4mjdBzmqVs9pEE4aDWkJgYJfOT3XkfSvy4/61OlS0+D65jBRQMpdiYzObl0nwqs1LA8cmnIdHYEGZVQkedxd0mvJ8L9zHvRRbYjLIWSISqlmwOz3eMGuju1LsjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NRsw+253; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240826171425epoutp04e96c18bb617a3ab5c8841a6b2793af7d~vVqjKKl_H0762207622epoutp04I
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240826171425epoutp04e96c18bb617a3ab5c8841a6b2793af7d~vVqjKKl_H0762207622epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724692465;
	bh=QlraUz7mWC5TpMsZSNLhl1IWSfYiPF9JCt4MhSxeqoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRsw+253QMVRB0m/LvwfxTc8ZOEb1ce7akJ5B0DUuK76F3H6yC4GTBvpABG7v54Gt
	 hB2+RIsvqxj/7QaHKwydtBjUhafZtJvyz2ZoFgRunRun0n6FITtrGlHv/395IfdG8/
	 yfIYeAUa9QotfgpKG3ZQlAS/ed9DnMptaUuaqTWk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240826171424epcas5p19fd9d13160492dad59fc62ede3ae8b40~vVqiicTjz0279002790epcas5p1B;
	Mon, 26 Aug 2024 17:14:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wsy2k6F6Dz4x9Pp; Mon, 26 Aug
	2024 17:14:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.A0.09640.EE7BCC66; Tue, 27 Aug 2024 02:14:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171422epcas5p2fa8f07dfee9395745f1833a17fd89ae0~vVqgJJQK20606606066epcas5p2b;
	Mon, 26 Aug 2024 17:14:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240826171422epsmtrp2c1f602264c43742010b82095caff9901~vVqgIV8sL3048030480epsmtrp2k;
	Mon, 26 Aug 2024 17:14:22 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-a3-66ccb7eef81b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2E.51.19367.DE7BCC66; Tue, 27 Aug 2024 02:14:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171417epsmtip2300cf238d11e054982f5ca67e497e4ab~vVqcWaisS0040200402epsmtip2e;
	Mon, 26 Aug 2024 17:14:17 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCH v4 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Date: Mon, 26 Aug 2024 22:36:04 +0530
Message-Id: <20240826170606.255718-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmpu677WfSDL7/0rRYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWR/+/ZbOY
	dOgao8XeW9oWlxa5W+zZe5LFYv6yp+wW3dd3sFksP/6PyWLb7/nMFutev2exOD9rDruDmMfl
	K94e5+9tZPGYNukUm8fls6Uem1Z1snlsXlLvsXvBZyaP3Tcb2Dw+Pr3F4tG3ZRWjx5kFR9g9
	Pm+SC+CJyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
	AXpXSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBg
	ZApUmJCdMefBNOaCv1oV7aseMjYwvlHqYuTkkBAwkdhzaQtzFyMXh5DAbkaJ0x3HWSGcT4wS
	jRNfMsE5b1Z8Y4VpeTX7LlTVTkaJqb3tbBDOZ0aJc6eaGLsYOTjYBDQlLkwuBYmLCDQzSWxc
	+wusiFlgN5PEgq7/zCBFwgKWEnseWIJMZRFQlTj/dTY7iM0LFG6fvZwJYpu8xMxL38HinAJW
	Ev8/vIeqEZQ4OfMJC4jNDFTTvHU22BMSAj84JF5suQB1qovEvs7bLBC2sMSr41vYIWwpic/v
	9rJB2NkSDx49gKqpkdixuQ+q116i4c8NVpA7mYGeWb9LH2IXn0Tv7ydMIGEJAV6JjjYhiGpF
	iXuTnkJ1iks8nLEEyvaQuPv3CzSwehkl5h9/wzKBUX4WkhdmIXlhFsK2BYzMqxglUwuKc9NT
	i00LDPNSy+Exm5yfu4kRnOy1PHcw3n3wQe8QIxMH4yFGCQ5mJRFeucsn04R4UxIrq1KL8uOL
	SnNSiw8xmgLDeCKzlGhyPjDf5JXEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE
	08fEwSnVwKSau+vF5vCFhwqDZ+xtEFvmXm0p9qyzK0/VUGNvwLugNIVs/b33/vM6hve4scz6
	mrfgDmNk+9RjnveaZ6s7HJaOf/Wq2+OZisu3OUu+KjTLLutawfzqOytXosyEpY++NDwQuFyT
	q3Ot3kdYQ1z88iTJv+cm9M0NvSrhu/+IoHL1rwrmW/m/NX4cnH3S8mmMQ5WRrOyeX2823Dct
	r1ofcPg4x7l15xu5hGYzCl9VmRRZt/0f2zs5U+Vsv5T56edK1hceW97A8HO+S8nWYwILfcOq
	88+H12jUWF/YvzHprceeV4ohP6tbNG/nvHd1UGwJTCnVju7MPlTV/ij5tOyBz1vOBlSvs/xk
	t4JdjctpqhJLcUaioRZzUXEiAMWP8nd/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvO7b7WfSDC5uN7VYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWR/+/ZbOY
	dOgao8XeW9oWlxa5W+zZe5LFYv6yp+wW3dd3sFksP/6PyWLb7/nMFutev2exOD9rDruDmMfl
	K94e5+9tZPGYNukUm8fls6Uem1Z1snlsXlLvsXvBZyaP3Tcb2Dw+Pr3F4tG3ZRWjx5kFR9g9
	Pm+SC+CJ4rJJSc3JLEst0rdL4MqY82Aac8FfrYr2VQ8ZGxjfKHUxcnJICJhIvJp9l7WLkYtD
	SGA7o8Tb47uZIBLiEs3XfrBD2MISK/89Z4co+sgoMa+tG6iIg4NNQFPiwuRSkLiIwGQmiaaH
	W1hAHGaBo0wSW2fuYwUpEhawlNjzwBJkEIuAqsT5r7PBhvIChdtnL4daJi8x89J3sDingJXE
	/w/vwWwhoJqVZ5ZD1QtKnJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMYqmFhTnpucmFxjq
	FSfmFpfmpesl5+duYgTHp1bQDsZl6//qHWJk4mA8xCjBwawkwit3+WSaEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5NwpdW8GdZbF6cERizt02P/Xx5j
	s+M8l3SYaErctgkG4R7rvUqUXU1cn4TJdrYu1l/3ZNGr83cC211mP44qNAqeeIThr7meRFzW
	1PnRUwpqJ1Ws+1/V+O+P4HHLa7Ud/q0TfExbt/K0FB5dZxD8TXiHbWiftb/2J0Zz59D71ysa
	5n93lq8tnZW0VUnndY/U3vDl+532KhvN/8WWFLueuyxp02KZe+K3tslvkn3Md3fZq7m50tHB
	bp7Zf0+/2J8pe/rYtHjnPT8vyHFMEVm84qlxfrXSUoc76ltC10Ve3im5JMkjoiox/dWt6AmH
	a0V1NQQvx2U47XxZlzOL5/WRGVcqXWZ9brD63/qOK2jtCSWW4oxEQy3mouJEAD2lDs0+AwAA
X-CMS-MailID: 20240826171422epcas5p2fa8f07dfee9395745f1833a17fd89ae0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171422epcas5p2fa8f07dfee9395745f1833a17fd89ae0
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171422epcas5p2fa8f07dfee9395745f1833a17fd89ae0@epcas5p2.samsung.com>

This is similar to existing F_{SET/GET}_RW_HINT but more
generic/extensible.

F_SET/GET_RW_HINT_EX take a pointer to a struct rw_hint_ex as argument:

struct rw_hint_ex {
        __u8    type;
        __u8    pad[7];
        __u64   val;
};

With F_SET_RW_HINT_EX, the user passes the hint type and its value.
Hint type can be either life hint (TYPE_RW_LIFE_HINT) or placement hint
(TYPE_RW_PLACEMENT_HINT). The interface allows to add more hint types in
future.

Valid values for life hints are same as enforced by existing
fcntl(F_SET_RW_HINT).
Valid values for placement hints are between 0 to 127, both inclusive.

The inode retains either the life hint or the placement hint, whichever
is set later. The set hint type and its value can be queried by
F_GET_RW_HINT_EX.

The i_write_hint field of the inode is a 1-byte field. Use the most
significant bit as the hint type. This bit is set for placement hint.
For life hint, this bit remains zero.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/fcntl.c                 | 67 ++++++++++++++++++++++++++++++++++++++
 include/linux/rw_hint.h    | 13 ++++++++
 include/uapi/linux/fcntl.h | 14 ++++++++
 3 files changed, 94 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 46cf08f67278..d82fd4142104 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -291,6 +291,14 @@ static bool rw_life_hint_valid(u64 hint)
 	}
 }
 
+static inline bool rw_placement_hint_valid(u64 val)
+{
+	if (val <= MAX_PLACEMENT_HINT_VAL)
+		return true;
+
+	return false;
+}
+
 static long fcntl_get_rw_life_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -327,6 +335,59 @@ static long fcntl_set_rw_life_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static long fcntl_get_rw_hint_ex(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct rw_hint_ex __user *rw_hint_ex_p = (void __user *)arg;
+	struct rw_hint_ex rwh = {};
+	struct inode *inode = file_inode(file);
+	u8 hint = READ_ONCE(inode->i_write_hint);
+
+	rwh.type = WRITE_HINT_TYPE(hint);
+	rwh.val = WRITE_HINT_VAL(hint);
+
+	if (copy_to_user(rw_hint_ex_p, &rwh, sizeof(rwh)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long fcntl_set_rw_hint_ex(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct rw_hint_ex __user *rw_hint_ex_p = (void __user *)arg;
+	struct rw_hint_ex rwh;
+	struct inode *inode = file_inode(file);
+	u64 hint;
+	int i;
+
+	if (copy_from_user(&rwh, rw_hint_ex_p, sizeof(rwh)))
+		return -EFAULT;
+	for (i = 0; i < ARRAY_SIZE(rwh.pad); i++)
+		if (rwh.pad[i])
+			return -EINVAL;
+	switch (rwh.type) {
+	case TYPE_RW_LIFE_HINT:
+		if (!rw_life_hint_valid(rwh.val))
+			return -EINVAL;
+		hint = rwh.val;
+		break;
+	case TYPE_RW_PLACEMENT_HINT:
+		if (!rw_placement_hint_valid(rwh.val))
+			return -EINVAL;
+		hint = PLACEMENT_HINT_TYPE | rwh.val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(inode->i_write_hint, hint);
+	if (file->f_mapping->host != inode)
+		WRITE_ONCE(file->f_mapping->host->i_write_hint, hint);
+
+	return 0;
+}
+
 /* Is the file descriptor a dup of the file? */
 static long f_dupfd_query(int fd, struct file *filp)
 {
@@ -454,6 +515,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_life_hint(filp, cmd, arg);
 		break;
+	case F_GET_RW_HINT_EX:
+		err = fcntl_get_rw_hint_ex(filp, cmd, arg);
+		break;
+	case F_SET_RW_HINT_EX:
+		err = fcntl_set_rw_hint_ex(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
index e17fd9fa65d4..611c51d23d96 100644
--- a/include/linux/rw_hint.h
+++ b/include/linux/rw_hint.h
@@ -16,4 +16,17 @@ enum rw_life_hint {
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
 };
 
+#define WRITE_HINT_TYPE_BIT	BIT(7)
+#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
+#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
+				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFE_HINT)
+#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
+
+#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
+				 WRITE_HINT_VAL(h) : 0)
+#define WRITE_LIFE_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
+				 0 : WRITE_HINT_VAL(h))
+
+#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
+#define MAX_PLACEMENT_HINT_VAL	WRITE_HINT_VAL_MASK
 #endif /* _LINUX_RW_HINT_H */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..dfe77fa86776 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -57,6 +57,8 @@
 #define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
+#define F_GET_RW_HINT_EX	(F_LINUX_SPECIFIC_BASE + 15)
+#define F_SET_RW_HINT_EX	(F_LINUX_SPECIFIC_BASE + 16)
 
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
@@ -76,6 +78,18 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+enum rw_hint_type {
+	TYPE_RW_LIFE_HINT,
+	TYPE_RW_PLACEMENT_HINT
+};
+
+/* Exchange information with F_{GET/SET}_RW_HINT fcntl */
+struct rw_hint_ex {
+	__u8	type;
+	__u8	pad[7];
+	__u64	val;
+};
+
 /*
  * Types of directory notifications that may be requested.
  */
-- 
2.25.1


