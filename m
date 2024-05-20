Return-Path: <linux-fsdevel+bounces-19793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B08C9C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189801C21F6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE1763FC;
	Mon, 20 May 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OtDYruN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE476045
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205530; cv=none; b=eYHrH2JidBxfXbvHbcIALLdWkPgojSDmRQvZncQ9AMXMTef2NVRVq+2oAxEM7yRoJqRkuKvrnKry+KlMehW0WuZJJtfdsmo9a4sP0AMBRhzDyLWrfSm9fJz9jkHU7VPvmPZgw8JC6McNbpOhwxPw1PmwyL0WoouHO1qIKFq6+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205530; c=relaxed/simple;
	bh=WbpYhsR869XNt+4RG+0RSqan1Uuxl6RdgoojeeVxnzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Hk6gHkJIrJ/Fuzi1C8ErX2lHwgCFVFn5VSeiK6/rHAjrgMc6Hx6H+DHC4dFf+rKm7nfU9bTKyEq41ljywB/dm6WILoECFFrly8KvdBt53xxggAylUx+qJJ+/PWPaCp2Mu9TKThoag+NuX1EgjI7nZZVe0RvM/3rynxBc/I+NEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OtDYruN7; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240520114527epoutp029514ae2bb70b93e0f2017e013cf8df5b~RL9WF_9HH1003610036epoutp02H
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240520114527epoutp029514ae2bb70b93e0f2017e013cf8df5b~RL9WF_9HH1003610036epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205527;
	bh=0x72vxug1sX4QFwBsS/SRZ9PFW1UoWmnX4+Nx/d4D4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtDYruN7a+CXF1yrOw7nRlb/Znsu5nQpn9bKaQuqoGkWKgKpgJ/zoT5lwFFkEwQPT
	 Q8C6jrLqbrFE8g0HC3SrDJFvKXBYyg/j86kFNng86FgDYsUfPyDtAWB8yLWkhEhrug
	 2Qn4NypVNHh1LCthgLtFQ7BqnH4Ra6od6SMuRvgg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240520114526epcas5p4b6cc85b882bf26f20984f380972d0676~RL9Viu-MD2411824118epcas5p4X;
	Mon, 20 May 2024 11:45:26 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VjbNN63L9z4x9Pw; Mon, 20 May
	2024 11:45:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.80.19431.4D73B466; Mon, 20 May 2024 20:45:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef~RK7tKInxL0624906249epcas5p3_;
	Mon, 20 May 2024 10:30:16 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520103016epsmtrp16603da3cc6bfd283061b5195588c54c3~RK7tInXSj2227122271epsmtrp13;
	Mon, 20 May 2024 10:30:16 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-ad-664b37d4050f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.0E.09238.8362B466; Mon, 20 May 2024 19:30:16 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520103012epsmtip2bd5849ea7ca94911fcfed243fd15de18~RK7pfge6T2119121191epsmtip2V;
	Mon, 20 May 2024 10:30:12 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 10/12] dm: Enable copy offload for dm-linear target
Date: Mon, 20 May 2024 15:50:23 +0530
Message-Id: <20240520102033.9361-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe1BUZRSf797l7kKgdxbUL6qFWUsFBXaTxwdJGJreghp6wcA0wA5cAYHd
	nX1I7lQuS2CAgEBQ8pCXlbLCEgvy3HUHWDCMgeJRbkGRMIEmGE46SkC77FL//c7vnN/5ne98
	c1g4e51wZaUIZbREKEjjEg6Ma/0e+7wmAsJO8Nr/9kSa4UEcqc6v4Ug9XUSgu/0rAJXff4yj
	OcNZgFZHRnHUNjgDUG19NQPdMnRhqLe+BENX1EYMVX6ehSHjxj0ClfRNATQ/WYEhnWk/qsu5
	xEC9um8ZaLy7ikA1X80z0ddD6xgq/nQSQ51zmQBdW63BUfPdZQa6YXoGja4N2R1+lhqfCKOG
	6yHVVTHNpEZnvmFQ4yNyqrUxl6C0l85QC9oLgOq5pSSohsJSO6oga4mgurJ/taP+mjcxqGX9
	JEEVtjUC6rvaAWaEc0zqoWRakEhL3GlhgigxRZgUzA17J+5InJ8/j+/FD0QBXHehIJ0O5h4N
	j/A6lpJm3hDX/ZQgTW6mIgRSKdfn5UMSkVxGuyeLpLJgLi1OTBP7ir2lgnSpXJjkLaRlQXwe
	70U/c2F8avLKdC8hvmj3wcONIkwJWhh5wJ4FSV+oW69k5gEHFpvsBbC0/k/MGqwAWNabT1iD
	hwA+yKrDtiRN5UqmBbNJHYD9F4TWomwMzjwascsDLBZB7oc3N1gW3oVU4zBfW8ywBDipxWFm
	v2GzkzN5HM4va3ELZpAvQPXA2OZQTmQQVBp/Ylrd3KC6xbBZY2/mDe33gaURJNX2sKCx0zbS
	UaiZ19te5AzvDLXZxK5wsSjHhjPglc8uE1bxJwBW/FgBrIkQmD1chFvGxkkPqOn2sdLPwbLh
	5s3+OLkNFqzO2bycYOfFLbwbXtXUElb8NJx6lGnDFFSpxmyLLACwvayHOA84Ff9b1ALQCFxp
	sTQ9iU7wE/O9hHTGfx+XIEpvBZuH4BnRCdQta959AGOBPgBZONfFqbXttRNsp0TBaQUtEcVJ
	5Gm0tA/4mVdYjLvuSBCZL0koi+P7BvJ8/f39fQMP+vO5u5zuZlcnsskkgYxOpWkxLdnSYSx7
	VyXG4jSrHGs4DkfWyonoaNW9DmSadtRXZT52K/jCVCbXd/iYDsYvrSTM5oJQYPwh6P3rHhk/
	P+92jmO8XbW9bOG2bncUu2pv24GoV31AR8+eur7p4IkQQ0yeQfFxQ6xSn+8YcyyUrYiPPRlw
	vdQY2f7UEyLnw6bjydzs2OruhtxtjlJhqcZh3yu1JRxF5R9Tql2ePYdnlG+3V78RvpM/c6aQ
	84uqZPa3yyHRAxHq4g4x/1TUu4oDuqSTD7ThbxV1fO8y+9Ge02fr/1krf2+wGpe9PlSsSFcs
	Nj1ZL3Gv3BlgdLwaGb1j++96zmJ87kt7/aril6JvDt8IYdyJHFv4khflrXkzlMuQJgv4nrhE
	KvgXJ30+SZEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf0yMcRzHfZ/n6bmnm8vjMj2ptJ2xVhwJ+4aZH5mv3RhtamPDqcdpupy7
	TpQfl+jI1AkhUlKZrri60HHldl0uKUVFpTsbneRHd2GmpUs/5r/X3p/35/N+bx8K51cQs6i4
	hERWniCOF5Bc4mGdIHABnCfau+jvFx683/gMhyc1IzjU2rJI+LXuB4A5riEc9prUAA43t+Cw
	6pkdwILCPAJ2mQwYNBZmY/Cuth6D16+kYbB+9DsJs81vAHR05GKwpjsE3kovIqCx5jkB2x7f
	IGF+iYMD71jdGLxwpgOD1b2pAD4czsfhva9OAjZ0+8GWEavHan/U1i5CjYUMMuTaOKjFXkGg
	tmYlqiw9SyJ90Qn0WX8NoCddKhLdzrzogc6nDZDIcPq9Bxp0dBPIWdtBosyqUoCaCiycLd7b
	uStj2fi4Q6x84ard3H0/bEZSdtPj8O/RLEwFdEQG8KQYeglTnqPijDOffgKYHsueSd2XKRmx
	4JPszdx19415uGOeNIz59scIMgBFkXQI82KUGtdn0I9wZjDtHDa+gNP1ONNaBsfZm97AOJz6
	iUMEPZfRWlongnn0ckZV38mZDAhktDrThMdzTDc9cIHJQuGM7a2L1ACvAjClFPiyMoVUIo0J
	lYUmsElChViqUCZIhDEHpJVg4qvBQdXAnu8WmgFGATNgKFwwg1dZtXEvnxcrPpLMyg/skivj
	WYUZ+FGEwIcXevV6LJ+WiBPZ/SwrY+X/pxjlOUuFyWTBAT/bp+W5+iusW2vDkoTla2yasgXJ
	kbr5r/xGg6KUznWPwaaPyqU9pssPyPWqkEIfNJQS3nWDn14wzzKc8fzYGihVD9jDNhsNYfaf
	0RpHlKusc/HFaMtiw0zieLGuP+XOnKR3L0dq4i75XliemrtSKJ3u/3Gt1dyX7KmPvhp4qke3
	o1wToIzcMySqeEH37vLKiEzUVzc221Wl5D02NfjlXHXTsk+ZFkm69YgzXHv+VH+ITvRhxTYv
	fYSgoTb+ZnaT+7c979fOQa5w062Bg6+1U9Ut2a/Uziz37JiGlC9LWger/Tc+Lfa5ciZiVcmQ
	NegpKD68pabxxFFJX+rJOgGh2CcODcblCvE/Zzp3o0QDAAA=
X-CMS-MailID: 20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Setting copy_offload_supported flag to enable offload.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 2d3e186ca87e..cfec2fac28e1 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.17.1


