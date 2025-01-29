Return-Path: <linux-fsdevel+bounces-40302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDCA2204D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000FF3A84BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8391DE4FB;
	Wed, 29 Jan 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UwEWM46q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9181CB9EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164520; cv=none; b=cB324TL5LULaRJR1nz5x75OlHqTFOCRRv9ELrQxTx4Yz5yFbAnQ61/2URso7YHoT95Ln/R6hm+LQExsgMPdnE0mxWQhh0o8rLt6RC0+bs4yYHBGkBxIyYXrzK91We343iSqMMJUTWP9kenQxM/qPqXSL73TOXhjVqHk+30P4cQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164520; c=relaxed/simple;
	bh=Zr40eT1ksq5Y2TVdl7uhzzALIG6fcXmCEM2Ip+Wai/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=RZs8sBRBet+tko6NyqnzLp8BkVf25v9V+e/GojTK1FWai185mwelIid5+WKcHqzpmzdaPt/1ruoFAfin0W+jzkt2FpYrUoVov3PthyZtv/Y+iQL8ExJxfZfCBWhNlZgvjldSflT05iWW28xUFkSPXmrvULxbBoq+MC6hwhB3tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UwEWM46q; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250129152835epoutp029384e9783170fc80db61eb41c9e5b855~fM2ra4unF0458104581epoutp025
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 15:28:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250129152835epoutp029384e9783170fc80db61eb41c9e5b855~fM2ra4unF0458104581epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738164515;
	bh=v/3fnOi767XmeNf57Gu8YfbDm3I1TZtnpF44zFVHu+k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UwEWM46qYzXkVrLAALmaD4Of/K54bIyW/F0IlELrhq7oemY1ZqHNUiChskKmutlWg
	 sESmRFV5izH07SrQHSkqfxyhkFe57prUhEQnkTpl137nQajyd+M6aoDiDf51byRU+q
	 BYZgBH8QqK21T+GlbQiFdxAd5JtcpnL6rQucdU7U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250129152834epcas5p26f1608b3db8feb4767aa5b28c7780c2e~fM2q9ahgb2434924349epcas5p22;
	Wed, 29 Jan 2025 15:28:34 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YjmJc6B02z4x9Pr; Wed, 29 Jan
	2025 15:28:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D9.53.29212.0294A976; Thu, 30 Jan 2025 00:28:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749~fI2LBAPa40403004030epcas5p1R;
	Wed, 29 Jan 2025 10:34:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250129103448epsmtrp1bf30a9eab7d29301e21760a7ec5594e1~fI2K_pSZl0972209722epsmtrp13;
	Wed, 29 Jan 2025 10:34:48 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-90-679a492053d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.9D.33707.8440A976; Wed, 29 Jan 2025 19:34:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250129103446epsmtip10027df99e966d9acdf9d91d1527562cc~fI2JQ1tfO3059430594epsmtip1T;
	Wed, 29 Jan 2025 10:34:46 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, anuj20.g@samsung.com, mcgrof@kernel.org,
	joshi.k@samsung.com, david@fromorbit.com, axboe@kernel.dk, clm@meta.com,
	hch@lst.de, willy@infradead.org, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Date: Wed, 29 Jan 2025 15:56:27 +0530
Message-Id: <20250129102627.161448-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmlq6C56x0g8UzDSyaJvxltlh9t5/N
	Yssle4stx+4xWtw8sJPJYuXqo0wWR/+/ZbPY+uUrq8WevSdZLPa93stscWPCU0aL3z/msDnw
	eJxaJOGxeYWWx+WzpR6bVnWyeUy+sZzRY/fNBjaPcxcrPPq2rGL0+LxJLoAzKtsmIzUxJbVI
	ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hcJYWyxJxSoFBAYnGx
	kr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xpP9agVLhCq2
	n9vM2MA4lb+LkZNDQsBEYubNhexdjFwcQgJ7GCXe3WtnBUkICXxilJh6kBEiAWTP3r6GFabj
	d/dtZojETkaJB6+3MUN0fGaU+P0WqIODg01AV+JHUyhIWERAVeLv+iMsIPXMAj8ZJS6cvcwC
	khAWsJO49X4lO4jNAlT0suEBmM0LFF93/RUzxDJ5iZmXvkPFBSVOznwC1ssMFG/eOhvsCAmB
	Rg6JhqYXjBANLhJPZi9gh7CFJV4d3wJlS0m87G+DsrMlDjVuYIKwSyR2HmmAittLtJ7qZwZ5
	gFlAU2L9Ln2IsKzE1FPrmCD28kn0/n4C1corsWMejK0mMefdVBYIW0Zi4aUZUHEPiQsrToGN
	FBKIlbjxXmwCo/wsJN/MQvLNLITFCxiZVzFKpRYU56anJpsWGOrmpZbDozU5P3cTIzjNagXs
	YFy94a/eIUYmDsZDjBIczEoivLHnZqQL8aYkVlalFuXHF5XmpBYfYjQFhvFEZinR5Hxgos8r
	iTc0sTQwMTMzM7E0NjNUEudt3tmSLiSQnliSmp2aWpBaBNPHxMEp1cDkPevkzHXZ82yaf8wM
	zeS6sMOpl2X2H/VU9XPX2T90Gly7kpx25eM1u5V7FPYbvKxo7K3bs2ybWIfMujL2F7ezTwTd
	07Zfkcjw20fZryLykcPGQnevLZ4Zz9aK9yl1rlrDV38o4b6ebyO/gJSQvs9lYYvr7DM3LveK
	ljBgnR7zMNkmRXx38pE1BUaT3taZRy+Kbvykc+bC4ZJZ13y+/bhicJXZVd2ofP/C98uPqmT/
	6+v9v4vfX39zsKr2bFuna+tcf/dXNu8+qhIoYCmZOPPJzfXKnrLeTrGZKjregWsPXOVKebje
	q9K1qppzwv7z3xdOEDT9d39uJPPkZWxLPG9Yfp4VGeVz2Lm8fr+s6w0lluKMREMt5qLiRABm
	OAS6PAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnK4Hy6x0g2udrBZNE/4yW6y+289m
	seWSvcWWY/cYLW4e2MlksXL1USaLo//fslls/fKV1WLP3pMsFvte72W2uDHhKaPF7x9z2Bx4
	PE4tkvDYvELL4/LZUo9NqzrZPCbfWM7osftmA5vHuYsVHn1bVjF6fN4kF8AZxWWTkpqTWZZa
	pG+XwJXxZL9awRKhiu3nNjM2ME7l72Lk5JAQMJH43X2buYuRi0NIYDujxL9HF9ghEjISu+/u
	ZIWwhSVW/nvODlH0kVFi3r8VjF2MHBxsAroSP5pCQWpEBFQl/q4/wgJiMwu0M0lcmC8KYgsL
	2Encer8SbCYLUM3LhgdgNi9QfN31V8wQ8+UlZl76DhUXlDg58wnUHHmJ5q2zmScw8s1CkpqF
	JLWAkWkVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnCoawXtYFy2/q/eIUYmDsZDjBIczEoi
	vLHnZqQL8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MImV
	qno+tY9iO5/zbPvSzLqZD8/W6gR/Vgtj++JvILqc5d6f/n2Zf4sPdT1dO7X5hVzo3K/SCQY/
	HAwmXvBLcQz+XdAofSVQ7bIfh7unzY/SaWYmL4/wMfmn5d5hfF3ZK379tr6tUol/8Q3jt0VM
	O50ma6RePfshhff4iROXxbknbOH+eybznL2Rwb6zXza+6Pq2Vmtn/bpLizl3v29+6RZ5QHin
	1PcVb9eGxTnr/3+8qv1K8sPIRXIddfMefXi86oJnXsDWP+6lXU9fz36evX4/i91Tlu+LC80M
	jQsf/rVY8zCYU/fuiy9HWiNUXpx5mDXT7bR6qIrFhN3q+3+U5i4Q1JW5e9n7hvjDN3u3TWlW
	YinOSDTUYi4qTgQAJCsB+eQCAAA=
X-CMS-MailID: 20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>

Greetings everyone,

Anuj and I would like to present our proposal for implementing parallel
writeback at LSF/MM. This approach could address the writeback performance
issue discussed by Luis last year [1].

Currently, the pagecache writeback is executed in a single-threaded manner.
Inodes are added to the dirty list, and the delayed writeback is scheduled.
The single-threaded writeback then iterates through the dirty list and performs
the writeback operations.

We have developed a prototype implementation of parallel writeback, where we
have made the writeback process per-CPU-based. The b_io, b_dirty, b_dirty_time,
and b_more_io lists have also been modified to be per-CPU. When an inode needs
to be added to the b_dirty list, we select the next CPU (in a round-robin
fashion) and schedule the per-CPU writeback work on the selected CPU.

With the per-CPU threads handling the writeback, we have observed a significant
increase in IOPS. Here is a test and comparison between the older writeback and
the newer parallel writeback, using XFS filesystem:
https://github.com/kundanthebest/parallel_writeback/blob/main/README.md

In our tests, we have found that with this implementation the buffered I/O
IOPS surpasses the DIRECT I/O. We have done very limited testing with NVMe
(Optane) and PMEM.

There are a few items that we would like to discuss:

During the implementation, we noticed several ways in which the writeback IOs
are throttled:
A) balance_dirty_pages
B) writeback_chunk_size
C) wb_over_bg_thresh
Additionally, there are delayed writeback executions in the form of
dirty_writeback_centisecs and dirty_expire_centisecs.

With the introduction of per-CPU writeback, we need to determine the
appropriate way to adjust the throttling and delayed writeback settings.

Lock contention:
We have observed that the writeback list_lock and the inode->i_lock are the
locks that are most likely to cause contention when we make the thread per-CPU.
Our next task will be to convert the writeback list_lock to a per-CPU lock.
Another potential improvement could be to assign a specific CPU to an inode.

We are preparing the RFC to depict the changes and planning to submit the same
soon.

[1] https://lore.kernel.org/linux-mm/Zd5lORiOCUsARPWq@dread.disaster.area/T/

-- 
2.25.1


