Return-Path: <linux-fsdevel+bounces-29030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E3973B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A489281338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D854619B3E3;
	Tue, 10 Sep 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XWuaHULK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16519AA4E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981060; cv=none; b=h4sdjX3c49Fl14Ni1H6vxAmrltGKMy1whtuhXCLKaECbgWFpX0Mj+6BpwPoZ2VTTat2p3eXs8w5dIa1ySoJxEoHzhnkpE0Qfl08qWTmi9djvOgzQM42ooQJ/MvKWyXQxsRaP8qPTb5qjf6jO0jAW3gdA9N1FImotJnwZBrRu4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981060; c=relaxed/simple;
	bh=PdlMtVh3kA8cEiEfQP5dtFdZxpBxO1u8rVqwOT+VdYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=s9QavqfG3buM3tl0Vp5rDJlnR8+MEh9DJFSn4G4wRnfifZFcgoGlcCB7DDRUh21qObXfC07sqBRCnips1fQGG8JZlc4R+kMvB8iK43JB5DrBUbyhT0hM7UjxJLhU2Oe9swGrNxmOB9jsGBzIVWEk/9sRbhdFmMn4fW02XD8epm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XWuaHULK; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240910151056epoutp01ccca41591efe28cb7cfe642e9ea20227~z6qBdlEeV0316003160epoutp01H
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240910151056epoutp01ccca41591efe28cb7cfe642e9ea20227~z6qBdlEeV0316003160epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725981056;
	bh=7ZDBUnzd4Ndq1SXpxq73aCV6Tou4ScFnpQdbc8edz+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWuaHULK8u5CEz/yAfGPiGBuillrBcfPeDozBn+Sl5pARgjKOWWzsVPa9dOgkmOqn
	 lngRazMdCbEb4WtBkaOMOcZuIDL46b3D5RzOmXFYFlTnJcrr4l5uKDRw6dBUzspp/Z
	 yVEYj89i66SUadcbE+WoH53YOg/QtIfgEyp8kFPI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240910151055epcas5p322e74b1ad79c7d50fe80f02223ad85cf~z6qAMvLXq0202102021epcas5p3b;
	Tue, 10 Sep 2024 15:10:55 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X36bK4LRSz4x9Ps; Tue, 10 Sep
	2024 15:10:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.3A.09642.D7160E66; Wed, 11 Sep 2024 00:10:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af~z6p93-Ma70472804728epcas5p4E;
	Tue, 10 Sep 2024 15:10:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240910151052epsmtrp23a0eca1b0398a1db4744b42444571d43~z6p92Cuow0449204492epsmtrp2i;
	Tue, 10 Sep 2024 15:10:52 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-8a-66e0617d468b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.6C.08456.C7160E66; Wed, 11 Sep 2024 00:10:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910151048epsmtip27e0cdbfdc338abc336e324f187c4a686~z6p53LRxJ1712417124epsmtip2u;
	Tue, 10 Sep 2024 15:10:48 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Date: Tue, 10 Sep 2024 20:31:58 +0530
Message-Id: <20240910150200.6589-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910150200.6589-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHuY/elpnqXYfjrHEOq2K6Skel7Q4bMNxQrrJEnDNm4gINvVCk
	L/oQhpoxmYZBBgpkSBkPzQKOKYy2Q1jHtrQCghhwvAkQZGXokIHUMNhDbLmo++/7O/l8z+98
	f+ccDsbzEHxOmtZEG7QKtYDYhDe7hMKQjxVTKaG99wLhhYkiAs65lhB4ZnEVg2sTsygcvd6K
	wvMX2lFYUZaLQnejBYNNRRx4c9zDhqu19WzYvjZPwGLnEALbxkTwxtex8EpbFw6ra2fYsGC4
	hYB1nX+jsPl+NQYb5hZw2PuwkwV7LWfZ0YFU/0Ac1TvZhFNnirsJqv9nM2WtP0VQtnPHKUeN
	B6UcozkE9efMGE4V2usRqqfmBzblsT5NWd3zaDz33fQIFa1Q0oYgWpusU6ZpUyMFcW8lHkiU
	yUMlIZJwuFsQpFVo6EhBzMH4kFfT1N7ggqAPFGqzdyleYTQKdkVFGHRmEx2k0hlNkQJar1Tr
	pXqxUaExmrWpYi1t2iMJDX1J5gWT0lXnXTZUPynKqhvKZeUg7c/mI/4cQEpBqeUkko9s4vBI
	BwJOnOhhMcUSApbyrChTLCOgpvWyF+OsWxbvbEBtCLBX+Bz+3sKDgIEelY8hSCHoKzH7mACy
	CgUdfe3rLTDSgYKa/DXMZ9hChoN+dxXbp3HyedA1fHd9Iy65G9xacmDM+XaA8ht31xl/EoLZ
	um9RhtkMusrduE9jXib3UsUGX+YPFvveY3QM6L5UhTB6C7jdaWczmg88d9oIRqeDqekpnNEf
	gRZbIYvR+0DOgxGWLwzmDdN4eRfT6nFw+r4bZebABXmf8Rj6GTBZPLPhDAS/fnluQ1NgrHSA
	YMZTgICZK9mfIzssjwSwPBLA8n+zGgSrR7bReqMmlTbK9GFaOvO/a03WaazI+uvfGdeCTE8t
	ip0IykGcCOBgggBuUdRkCo+rVBzLpg26RINZTRudiMw74S8w/pPJOu/30ZoSJdLwUKlcLpeG
	h8klgkDu3KeVSh6ZqjDR6TStpw3/+lCOPz8HFYlELus3fBuxP6bs7VjdvdXMw67g566t/pUT
	xRfKnko4WfXOoeqOwaSBEfnwUu5R++j7x8Urp/CM6rCE7RZ7daZTJFZf3WuvnXeXrsor2xpC
	al8cXL7V3Z9UT1ycaNIULLc+sfJV7sP8hZIMdkJspXAhr/vBSMDQY64Dv/Tuv+a0ydyF36d8
	FwxZpt/7UgZUx9ZaDtryz45HN+ONV/0S8GD7h6pD0lHC8/Lt7D37ClXj9Dbl1tTZyJXsN7YG
	vX7kTelhNS/sx4am2qyRlmgNUk78NC0kO458sua3V0RyJsFvfoKMxNmLr1lLwgb14ixHOnvh
	ld6bfyxEBLxw9PrU9s1cAW5UKSQ7MYNR8Q9JYCoMhgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvG5N4oM0g7uH1C1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvF0f9v2Swm
	HbrGaLH3lrbFpUXuFnv2nmSxmL/sKbtF9/UdbBbLj/9jstj2ez6zxbrX71kszv89zmpxftYc
	dgdxj8tXvD3O39vI4jFt0ik2j8tnSz02repk89i8pN5j94LPTB67bzaweXx8eovFo2/LKkaP
	MwuOsHt83iTnsenJW6YA3igum5TUnMyy1CJ9uwSujJWHNzMV3NOuWH6tmbWB8ahyFyMHh4SA
	icSHd6xdjFwcQgK7GSXe/d7E1sXICRQXl2i+9oMdwhaWWPnvOTtE0UdGiTON61lBmtkENCUu
	TC4FqRERWMcksWKaD0gNs8BRJomtM/exgiSEBSwlLj+ZBzaIRUBV4uT172BxXgFziWefdjND
	LJCXmHnpO1gNp4CFxPPla5hAbCGgmg/9C6DqBSVOznzCAmIzA9U3b53NPIFRYBaS1CwkqQWM
	TKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjV0trB+OeVR/0DjEycTAeYpTgYFYS
	4e23u5cmxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA5ME
	45qlXHoGa2d+U3h4wutQ7/39Cd6lfEy8804KBNxfJ27R731dNy8mc/GVauHll7i8L3L+TIjP
	ath/40vnz4dWi9fcZr06MX3pwSmarTsdTxqkB5Z3/57T/Ozw3407l69VUrwQnfDi/NmH8ow3
	D84vbFh1l+v1i42CYlNl+xdGr3AxmL2ila9PIfMcq7XhlVXRRY26hmvP3Z10R9J29eGoSXnH
	BLY/umo3oTZd43vBgpRwuxsfon7u0frYL/q55r3sp/RGxgXmVa71qze2ZRg/+HJw0TL7vmdT
	RX2nem4r9l6rolWofHv141kPGWsEApV6Ur5WLdl4/DHPG0EXzcb+nVyZYSG85/y+iUQ6NKoq
	sRRnJBpqMRcVJwIACku/w0sDAAA=
X-CMS-MailID: 20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>

This is similar to existing F_{SET/GET}_RW_HINT but more
generic/extensible.

F_SET/GET_RW_HINT_EX take a pointer to a struct rw_hint_ex as argument:

struct rw_hint_ex {
        __u8    type;
        __u8    pad[7];
        __u64   val;
};

With F_SET_RW_HINT_EX, the user passes the hint type and its value.
Hint type can be either lifetime hint (TYPE_RW_LIFETIME_HINT) or
placement hint (TYPE_RW_PLACEMENT_HINT). The interface allows to add
more hint add more hint types in future.

Valid values for life hints are same as values supported by existing
fcntl(F_SET_RW_HINT).
Valid values for placement hints are between 0 to 126, both inclusive.

The inode retains either the lifetime hint or the placement hint, whichever
is set later. The set hint type and its value can be queried by
F_GET_RW_HINT_EX.

The i_write_hint field of the inode is a 1-byte field. Use the most
significant bit as the hint type. This bit is set for placement hint.
For lifetime hint, this bit remains zero.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/fcntl.c                 | 67 ++++++++++++++++++++++++++++++++++++++
 include/linux/rw_hint.h    | 13 ++++++++
 include/uapi/linux/fcntl.h | 14 ++++++++
 3 files changed, 94 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9df35e7ff754..b35aec56981a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -291,6 +291,14 @@ static bool rw_lifetime_hint_valid(u64 hint)
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
 static long fcntl_get_rw_lifetime_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -327,6 +335,59 @@ static long fcntl_set_rw_lifetime_hint(struct file *file, unsigned int cmd,
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
+	case TYPE_RW_LIFETIME_HINT:
+		if (!rw_lifetime_hint_valid(rwh.val))
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
 		err = fcntl_set_rw_lifetime_hint(filp, cmd, arg);
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
index b9942f5f13d3..ff708a75e2f6 100644
--- a/include/linux/rw_hint.h
+++ b/include/linux/rw_hint.h
@@ -21,4 +21,17 @@ enum rw_lifetime_hint {
 static_assert(sizeof(enum rw_lifetime_hint) == 1);
 #endif
 
+#define WRITE_HINT_TYPE_BIT	BIT(7)
+#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
+#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
+				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
+#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
+
+#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
+				 WRITE_HINT_VAL(h) : 0)
+#define WRITE_LIFETIME_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
+				 0 : WRITE_HINT_VAL(h))
+
+#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
+#define MAX_PLACEMENT_HINT_VAL	(WRITE_HINT_VAL_MASK - 1)
 #endif /* _LINUX_RW_HINT_H */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..f758a7230419 100644
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
+	TYPE_RW_LIFETIME_HINT = 1,
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


