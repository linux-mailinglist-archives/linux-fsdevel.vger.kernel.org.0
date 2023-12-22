Return-Path: <linux-fsdevel+bounces-6780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255181C5CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F04F1F2256F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26350224FC;
	Fri, 22 Dec 2023 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q21mH9Zm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1942233A
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231222073246epoutp01ad4180e847086631587454a539dcc533~jFv6GmxoM3052030520epoutp01c
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231222073246epoutp01ad4180e847086631587454a539dcc533~jFv6GmxoM3052030520epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230366;
	bh=ve1xdmhje+5EA/lKMdfQIcdO/aY9KnYalMJf/3V4ggw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q21mH9Zm9xMHWN1RohqpyRB/kDqKo80T9NL+ATnKx4Tw5i9a8GaEhAiBgZ4QgAKNs
	 qce2pKdwswSXK1VZ6ZRttNyLGg8V0tNpExZQj2BI4HOtAWp9E9qd33KCq28BlW+VRk
	 sCHrEN+mZZeX3qdh92eXhnUHX1UMCgbYmjTjK4Mg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231222073245epcas5p1b3c6e576644a2b573d2d065012ce9e43~jFv5ghx-m2925829258epcas5p1O;
	Fri, 22 Dec 2023 07:32:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SxJt40yHnz4x9Py; Fri, 22 Dec
	2023 07:32:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.23.09634.B9B35856; Fri, 22 Dec 2023 16:32:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231222062227epcas5p34a8e2395fc03b456b5fdb4b858e01d15~jEygs7JbK0954409544epcas5p3_;
	Fri, 22 Dec 2023 06:22:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062227epsmtrp14c1dc293656af35d18e50f68a873c1d4~jEygr3APY1655116551epsmtrp1C;
	Fri, 22 Dec 2023 06:22:27 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-ca-65853b9ba4cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.A3.08755.32B25856; Fri, 22 Dec 2023 15:22:27 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062223epsmtip2fb23343255634a8809e53ce3053828e7~jEydWR4t50300703007epsmtip2R;
	Fri, 22 Dec 2023 06:22:23 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 10/12] dm: Enable copy offload for dm-linear target
Date: Fri, 22 Dec 2023 11:43:04 +0530
Message-Id: <20231222061313.12260-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxTufe/l5cEQfIC2F9CWSaedAdnSAl42i1XjE5yBqaXj2FqahlfC
	AEnIItT+KAi4YAWJtcWwiEgtokNGgpS1ZbHG4AKtxUDaKJ2yUwSxyiiLTQi0/vvOOd93z/nO
	nUPhrqe4HlSyVMUqpKJUPulINHR5e/uVhuexgUd6caTrvoajh4/nCXTRUkiiya5ZgIbaDwNU
	UVlGoIH2Jgy1VmowdOHizxjSdN4FaLhPi6E280Z09lAVgVrbjAS601xKojPnh7nomKmRRN8b
	ljDUf2IYoKIjfRhqHMoGqGH+DI5qJ6cJdN3siXoWDZwod6ZJa+EyPfcuE8ydW2qmruYoyeir
	vmTG9KcB0zKQRTLnCk5ymOM5D0jm4bCZYKZ/7COZgvoawOhvfME8qnuVqRuawuLW7E2JkLCi
	RFbhxUrFssRkaVIkP2Z3wtaE4JBAgZ8gFG3ie0lFaWwkf9uuOD9hcqp1G3yv/aJUtTUVJ1Iq
	+QGbIxQytYr1ksiUqkg+K09MlQfJ/ZWiNKVamuQvZVVhgsDAt4KtxE9SJFf+ngPyWk7mzZJe
	LAu0E/nAgYJ0EDTf7+XkA0fKlW4B8KzJRNiDWQDLWg7iNpYr/QRAfY9iVVEyWo7ZSW0AdpZU
	cu1BHga7RopBPqAokt4IbzynbIK19CUcNl0W2Dg4/RSDOdXXga3gRu+ADwaNy3MQ9Btw/OQ1
	jk3Lo8Nh+69ONgjpAFh438XGcLBmR5+d49gwj3aBxtNDy0qcfg3mXCnBbc9DWu8AqweGV6xt
	g3WDs5gdu8EJQz3Xjj3geOGhFZwBL3xdTdrFuQBqTVpgL7wD87oLcdsQOO0Ndc0B9vQGeKq7
	FrM3dobH54dW3ufBxvJV/Dq8pKsg7dgd3p3LJu1eGLj00yb7qgoAtPxzlXsCeGlf8KN9wY/2
	/84VAK8B7qxcmZbEKoPlAimb8d8fi2VpdWD5Pnx2NgLL4Ix/J8Ao0AkghfPX8mS+uawrL1H0
	+QFWIUtQqFNZZScItq67CPdYJ5ZZD0yqShAEhQYGhYSEBIW+HSLgv8KbzCtLdKWTRCo2hWXl
	rGJVh1EOHllYRk2p4eixz7bs2qOJcvEdnOnfp3s2uWessMNTL4zJ0/vuVU50hGaraXejOHYp
	YHE9YT6ginmU8m40d/ds5kLKc4Mb0zgu+eZ9STZwiK6PyB3bnLFjlJyomEvasD1cq4tUnHc3
	Oq3R/iKf8i/3XJ++D9uyP+Vx0QiveMqxQNh6802fvg7pknHih5GYYL8Pbs9MObff+ktoStc8
	eSktPcCUm29u+Ej7tFn46R+ZPoZ7/Rr2Y9PC7Q/FyG06uvrl3sMap+LYeOuFrjvw3Vwy2/yb
	ZZEnuKqgJWL5e18thLX8rqvodo7606xXTNUKd1Kx8WbLwa3ZXVQYVBTFz4RWmeXf8gmlRCTw
	wRVK0b/TbozHqAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+c45Ho+r2Wka+7QwWwW12cqK+jLtQrcTGERB0PojRzvMyuna
	NLOgtKVW5h0ip2VpKM4y27osXbLmLbOa5aUysqjNebdlXkq6uEnQfw/P73ne94WXwnkvCH/q
	cHQsq4qWRglIDvGgVjB/2UJRMruitMsL3XnWgCPn6CSByj9kkqi/9htANnMqQNeLrhLonfkR
	hkxFORgqK6/HUI6lAyB7uxZDjztF6EbKTQKZHjcRqLWqgESFJXZPlPbGSKLSxt8YeptlByj7
	fDuGjLYkgB5MFuKoon+YQE875yLrr0aPTX7MI+0HT8badZdgWl/EMXrdBZIx3DzD9BjyAFP9
	LpFkijNyPZh0zRDJOO2dBDNc004yGfd0gDE0n2JG9AGM3jaI7Z4l4YTK2KjDx1nV8g0RnMj7
	A+NAWeFx4nl+C5YIzMRF4EVBejXMd1zDLgIOxaOrAfw+NOQxDfxgya86fFr7wLLfDs/pkAaD
	d7pHpkIURdIi2PyHcvm+tBGHP25r3JNwOhWHzX39mKvtQ++AQ5+a3OsIejHszW1wl7n0emh+
	PdMlIb0cZn6c7Up4TbmOn8XuG3h0CGxyGEiX5tKzYVOezT0Fp+dDzf18PAvQ2v+Q9j90HWA6
	4Mcq1Qq5Qh2sDI5m48VqqUIdFy0XH4pR6IH748KlRvBQ91VsARgFLABSuMCXGxN0juVxZdKE
	k6wq5qAqLopVW8BcihDwufyedBmPlktj2aMsq2RV/yhGefknYlsiLO3hsWCgtsqkkdXw7ZaE
	/vjLgdr0NTmSzRmvjn9NNQVcCZL1eYvG/7zn7MdC7o6LOdsWLsjuEYYIjUWx6/3ZSyMrxwxP
	kiKb1YrTzlVp3qPyL0G5xS9jJgaz94V2eY8EbE2ZIR38UVWnb5ME7d0i26iT9JisOxaFcm7J
	C3ZfDVsdMm/O25yNkjFtmiqwt7Jk9HOt1TL8zHqsvHPySVty3dqiiUM+4c6KvbvOruOV/Twy
	UNnavWd7zeDZrdTOvnpz4IH0UkLcfS+FdYSrRLeXNnYXdPguuTY5lpmh3JxkG5i1LksUrE+s
	Tn7asJiN4IskQn5LfGXhJ7/whjBvZ72AUEdKg4W4Si39C4HaAd1gAwAA
X-CMS-MailID: 20231222062227epcas5p34a8e2395fc03b456b5fdb4b858e01d15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062227epcas5p34a8e2395fc03b456b5fdb4b858e01d15
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062227epcas5p34a8e2395fc03b456b5fdb4b858e01d15@epcas5p3.samsung.com>

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
2.35.1.500.gb896f729e2


