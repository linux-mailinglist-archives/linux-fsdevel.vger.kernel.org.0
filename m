Return-Path: <linux-fsdevel+bounces-19973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21558CBA89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E3C1C2148B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DC5812B;
	Wed, 22 May 2024 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MP3Hg3pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FD33CF1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716354111; cv=none; b=nu3FymsFa/rxAlGXG8yJ/AtQNKwMM7MQNFtG6cF0HU1mt0E2EwNAKTT/Cpvj2gyFfzM2UPFhdUZ4+rWSWvyv5BKeVM8n/++X2ozxWSbbPApS7rtgPjbgZhJDyewmhlwgh8rkxXEryE6jwA596zBzpS7uKkwGC9ym2GA+Mg5dC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716354111; c=relaxed/simple;
	bh=Nilx3Nzpi8izkStwwd++vWv5hHGEdW5vn8oitgAv5jA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lFgCognjwt+gMn8ozNMQeZvJ3Id7a6kZ4GQrKZ1jVM6/5AxQCeHlbfhy+D3KS3px1NfOmiUii1iLPSqo39F4OTk/JwHl26KWXfVaNFBPegRh1521V2zprg1XhtBSvm4gWZhbc0E+0IORCEKHuV+yy576xHSVVQubxcd9AqbB9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MP3Hg3pG; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240522050142epoutp03566336d4e2917facd7b4f644c8f85c69~RtvZqyN0N0621206212epoutp03e
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240522050142epoutp03566336d4e2917facd7b4f644c8f85c69~RtvZqyN0N0621206212epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716354102;
	bh=RgBaMYVh1VFcU6qkULSATRa/euGD/1LEVOKhgYLD2Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MP3Hg3pG6da5xBYS/p1EYSefBXcsJfBzZ4vnxs0k/Q7TX7rNkUW4pK34054tSSDC4
	 U1f2QL51AwJcba4dQnB2h/dEjXoCmgbwDnxqKsSyQGtWOT4b2qZRyTT8Bvo8TgNMM8
	 MTAoIoyKThcQgkB7ViEP0UG3FxYXfUp0hFhrxmAU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240522050141epcas5p2060930fca5b5267ff7564473b75df5d6~RtvZFCv1o1273012730epcas5p2W;
	Wed, 22 May 2024 05:01:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VkfKc18Nkz4x9Px; Wed, 22 May
	2024 05:01:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.0C.09665.33C7D466; Wed, 22 May 2024 14:01:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240521141552epcas5p1813c0b3602f3ce742ff1723364defcae~Rhp9t3_7z2854028540epcas5p1Q;
	Tue, 21 May 2024 14:15:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521141552epsmtrp1acbad030caf92a646fb548532de9c2a6~Rhp9rn4WS3270632706epsmtrp1t;
	Tue, 21 May 2024 14:15:52 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-0a-664d7c33757d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.3F.09238.89CAC466; Tue, 21 May 2024 23:15:52 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521141548epsmtip2f58b6e5cc35ec5d7ca1ea58e8240411f~Rhp6JjRnO0658906589epsmtip2Q;
	Tue, 21 May 2024 14:15:48 +0000 (GMT)
Date: Tue, 21 May 2024 19:38:50 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 09/12] dm: Add support for copy offload
Message-ID: <20240521140850.m6ppy2sxv457gxgs@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <41228a01-9d0c-415d-9fef-a3d2600b1dfa@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVATVxzH5+0mm4Q2dgUtD2gLs7Q4wHAEQvpAUKZauoWWYbR/aA8wkjUg
	JGSS0NSj04ANKFMOaS0SpCKHyFFRoJa7CApylToUHBhBpFCoTMuhQh2ENGGh43+f3/F973fM
	j49bV/Ps+bFKLaNWSuMpwopzo93V1UN88sMj3rl5GKrq7sBRctYqjipGMwk0274I0Pfzz3A0
	2ZoK0EpfP45qO8YAKijM56Dh1noMNRVmY6is4jaG8nJOYei26W8CZbcNATQ1aMRQ84g7upRS
	zEFNzV0cNNBwgUAXL0/xUGnnGobOnh7EUN1kEkBXZ+c46M6IA+pf7eQGO9ADv4fR3YWQrjeO
	8uj+sesceqAvka4uP0PQNcVf0TM1uYBuHNYTdFHGt1w6/dQ/BF1veMClF6ZGOPRcyyBBZ9SW
	A7q34BYvwubjuMAYRipj1E6MMjpBFquUB1Fh+6P2RPlJvEUeIn/0NuWklCqYIGrvBxEeIbHx
	5uFQTp9L4xPNrgipRkN57QpUJyRqGaeYBI02iGJUsniVWOWpkSo0iUq5p5LRBoi8vX38zImH
	4mIqZ1xURcIv1u676kH6S2lAwIekGE4U38XSgBXfmmwEMKNrmcMaiwC26B9uRJYAzO0rwTcl
	qRUrXDbQDOCdhx0Ea/wJ4HD/MLBkcci3zG81m+V8PkG6wx4T3+LeRlJwIbWNZ8nHyVICPjeN
	ci0BG3I3XB09g1lYSEpg42QfwfJW2JU7ybGwgNwJSxrOr/N28jV4vuQpbnkIkmMC+M3TeYIt
	by9svfsHl2Ub+KizlseyPfwrM2WDdbDsuysEK/4aQOM9I2ADu6GhO3O9T5yMgTl5eRuC1+G5
	7qsY698C01cmMdYvhHU/bLIzrKwq2CjCDg4tJ20wDQeTa3B2RHMA5uufEFnA0fhCd8YX/mM5
	AJ6ZT+YazdPDSQdYusZn0RVWNXgVAG45sGNUGoWc0fipfJWM7v+NRycoqsH68biF1YGJ8XnP
	NoDxQRuAfJzaJqyuff+ItVAmPXacUSdEqRPjGU0b8DNv6yxuvz06wXx9Sm2USOzvLZZIJGJ/
	X4mIshXOGvJl1qRcqmXiGEbFqDd1GF9gr8cInxDHipseny2cQ5im3RDcM6QrPn2tJ8CkOFlB
	3Sv2oNNCDaHGbF2Gi+FL34u8OXrqYOT0lfzyanl7KxyBzpS4s2O/Lt3rxonWTyrH7eNO9IoX
	Wh4XjcZcuFZt92740Vfke1KSvJL3he2L1j7SMTt7y/US29EQwkVw+EBzmU7/ZEameFkeaCoK
	FU4fbaR21f7kk32Advyl9j2H0vBf/ZsOpimfHwv/0efQvz7qeirnt/HLcZ3Tx+vt37QRLxc6
	f/qzS0CQ4KPFhvjD0+Ad6JbymLG9fl/ftzQR2egiV14S92pu3Yx0n3qQ/Ezi0JSx9OrEjrys
	LflveG4N1oqnrUw7dBRHEyMVueFqjfQ/BJ0gn8UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7bCSvO6MNT5pBsufc1isP3WM2aJpwl9m
	i9V3+9ksXh/+xGgx7cNPZosnB9oZLX6fPc9sseXYPUaLBYvmsljcPLCTyWLPoklMFitXH2Wy
	mD29mcni6P+3bBaTDl1jtHh6dRaTxd5b2hYL25awWOzZe5LF4vKuOWwW85c9ZbdYfvwfk8XE
	jqtMFjueNDJarHv9nsXixC1pi/N/j7M6SHtcvuLtcWqRhMfOWXfZPc7f28jicflsqcemVZ1s
	HpuX1Hu82DyT0WP3zQY2j8V9k1k9epvfsXnsbL3P6vHx6S0Wj/f7rrJ59G1ZxehxZsER9gDh
	KC6blNSczLLUIn27BK6MQ1OOMhZc5apYsOgMWwPjTY4uRk4OCQETifbVv1lBbCGB3YwSpydW
	QcQlJZb9PcIMYQtLrPz3nL2LkQuo5gmjxNL3m9hBEiwCqhJ9J/cydTFycLAJaEuc/g82U0RA
	SeJj+yGwemaB1WwSuw4tZgRJCAvYS/y928kEYvMKmEnsfnKWDWLoe0aJf4f3MEIkBCVOznzC
	AmIzAxXN2/yQGWQBs4C0xPJ/YAs4Bawllu6aAVYiKiAjMWPpV+YJjIKzkHTPQtI9C6F7ASPz
	KkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4HShpbGD8d78f3qHGJk4GA8xSnAwK4nw
	btrimSbEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QD08wD
	/hEs2/r2+pnverfh8FNxkbLXNg9b7GVb1e+zsB0OfzPZac42+U21ygLORz5wbs1g3rjuuoKM
	k2W12MEDVy3Sv8/oZLu38VrhzAeZR+dsv8xzNYZn0Y3if9pGb045KlgZG4cEm37/71BS5tH/
	ai5DbFVkU6zlwRe+LEFcSjWT9FQfey6r4b271OL97wctp1/O5bQ0ksh23cUVaFzU9KDwwlqm
	6lAbP6stOv2PbT+uOPNd/8vaC5kHbq/tNZmteEZVYvbNs9vjp+gK6ZvV2CnXBEan1fncP+5U
	GabvuFotkDlYzZ8/cPkEg6IdT/+ZrVJ7L/f0fMGpe3vmnf1k+Gm6v86lNf1Fq9KcD95VUWIp
	zkg01GIuKk4EADajPPKGAwAA
X-CMS-MailID: 20240521141552epcas5p1813c0b3602f3ce742ff1723364defcae
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_16037_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103004epcas5p4a18f3f6ba0f218d57b0ab4bb84c6ff18@epcas5p4.samsung.com>
	<20240520102033.9361-10-nj.shetty@samsung.com>
	<41228a01-9d0c-415d-9fef-a3d2600b1dfa@suse.de>

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_16037_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/05/24 09:11AM, Hannes Reinecke wrote:
>On 5/20/24 12:20, Nitesh Shetty wrote:
>>Before enabling copy for dm target, check if underlying devices and
>>dm target support copy. Avoid split happening inside dm target.
>>Fail early if the request needs split, currently splitting copy
>>request is not supported.
>>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>---
>>@@ -397,6 +397,9 @@ struct dm_target {
>>  	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
>>  	 */
>>  	bool needs_bio_set_dev:1;
>>+
>>+	/* copy offload is supported */
>>+	bool copy_offload_supported:1;
>>  };
>>  void *dm_per_bio_data(struct bio *bio, size_t data_size);
>
>Errm. Not sure this will work. DM tables might be arbitrarily, 
>requiring us to _split_ the copy offload request according to the 
>underlying component devices. But we explicitly disallowed a split in 
>one of the earlier patches.
>Or am I wrong?
>
Yes you are right w.r.to split, we disallow split.
But this flag indicates whether we support copy offload in dm-target or
not. At present we support copy offload only in dm-linear.
For other dm-target, eventhough underlaying device supports copy
offload, dm-target based on it wont support copy offload.
If the present series get merged, we can test and integrate more
targets.

Regards,
Nitesh Shetty

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_16037_
Content-Type: text/plain; charset="utf-8"


------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_16037_--

