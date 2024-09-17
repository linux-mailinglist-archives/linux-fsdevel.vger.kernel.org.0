Return-Path: <linux-fsdevel+bounces-29591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42197B297
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D9D1F20F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE6A17DFE2;
	Tue, 17 Sep 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F+b4OMp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D18174EEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589042; cv=none; b=isgBqaD46gMKiF8oTfDhEHlCVxZtxSncaj/XTnpTmyl2+94nsBKTn9GW+r0TJ+tRJTPL0DZHxthRvWNOLm98NHpg2pPERFhYTOekBvGH6VvZGletPSHA1Vtc5O2HDCbsOYq2enGp+FJAVcQeBsV3NdUkTd/8OhcbkerYf0sWP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589042; c=relaxed/simple;
	bh=ofIwzWZBIxHp8aEN2XPggJp0WvMZx25ikzo9kz1JKHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mOHZm318fdBhr6gcffttA8XpzvYEvLJiTs2rTEkja6dEjz4lQ9GaNvOJkO22XvbnL9zkqr4OTfN3FFP4GE8PUtZkZtCqvoyceHlqRuMgECmtxoGpqOmM8Ft19h+e/qkMGRSaruQlmOxy0yHwEe0YMU2FaRM2gMV0Wtj68EAyS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F+b4OMp9; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240917160351epoutp0380445581fd6e0fdbbf6f00fbcf4e92d2~2E5OH9_6Z2906729067epoutp03h
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 16:03:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240917160351epoutp0380445581fd6e0fdbbf6f00fbcf4e92d2~2E5OH9_6Z2906729067epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726589031;
	bh=mAml1X6HT3e7FU7pesdwYAX9xeoU1P3zVE+HFV3zmWs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F+b4OMp9Hbld3gjdBIuOOOOlX2KqXkYvYovgCGAVUfjStAk++iAbnmZ9TG53rh9rw
	 Bzv6T9wtZxi57h+0TXKInqCptGOBSBrdp5FDt/Tk5qLBFOlKveyNa18c01fGj8SV0r
	 o6CKA2Dp4JWOxC/0YYzUNYxmawOGX1OupgdYTuv4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240917160350epcas5p19ac5b03318f61a18f1e437688e861e24~2E5NZ5Amg1870218702epcas5p1C;
	Tue, 17 Sep 2024 16:03:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X7RR86TvRz4x9Pv; Tue, 17 Sep
	2024 16:03:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BE.3C.09640.468A9E66; Wed, 18 Sep 2024 01:03:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240917160348epcas5p275248c54b014ee3ef6a8c8b88d573b60~2E5LOQS310635606356epcas5p2I;
	Tue, 17 Sep 2024 16:03:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240917160348epsmtrp17d9cff39847ab607f04770e729b0d9a8~2E5LNSXYq2050620506epsmtrp1P;
	Tue, 17 Sep 2024 16:03:48 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-92-66e9a864de87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.51.08456.468A9E66; Wed, 18 Sep 2024 01:03:48 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240917160345epsmtip2b30f62e2429ded43a6fccfb44a28f882~2E5IQERBm0267602676epsmtip2U;
	Tue, 17 Sep 2024 16:03:45 +0000 (GMT)
Message-ID: <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
Date: Tue, 17 Sep 2024 21:33:44 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240917062007.GA4170@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxz23NsXbl2uBceBua27yTKQ8aij5cAANZBxF3yQuQW3wFilV6iF
	tutthzLNqguoEGACES3IwyBgiRAeQ5CRGB6rEBgOBaUMhqOdCEN5KIyB21qKG/99v+98X77f
	I4eHC9K57jy5UktrlNIkkrOZ1dTh6eEtq3p02K+tcQeqHs3hoOmOeYDOzy7j6J/RhxgavtmC
	oavVXRgqLPgWQ5ZaA47qcnho4pcFLlquMHJRbvsQQG1mLzRwOQL90NbNQiUVVi7KvNfMQZWm
	vzHUtFKCo5rpJyzU/9zERv2GIu6uV6k7dyOp/rE6FnU+t4dD3enTUfXGsxyqofwbqrV0AaNa
	h/Ucas5qZlHZjUZA9ZZ2cqmF+jeoessMFsX/TBGcSEtltEZIK+NVMrkyIYSMPBAXFieW+Im8
	RYEogBQqpcl0CBm+J8r7A3mSbWZS+JU0SWejoqQMQ/qGBmtUOi0tTFQx2hCSVsuS1P5qH0aa
	zOiUCT5KWhsk8vPbIbYJv1AkztydAeqTLkfPLcXoQTaRAZx4kPCHE+UZHDsWEK0ADvTsyQCb
	bXgewKXZEbajWATQ0JGNvXDkD3WuP7QBOKqv5DqKGQCLW0qAXcUnQuHVkdo1zCLehrcbhnEH
	vwV2X7Sw7HgrcQj+NVi0pnEmQmBm1r01HidcodlSspbmQpDQOtUH7AE4UcGCV+b6bc3yeBzC
	E97O09k1ToQX7NcPcx3eN+H1mSLcrodEtRNcznrAdrQdDmsKq1gO7AynTI1cB3aHj3LS17EC
	jv82vq45Dpsbste9O6F+9T7bnovbcmtv+DqyXoFZKxbMTkOCD8+kCxzqt+BYrnXd6QofXChn
	OyQU7Drp5lhVOg5vGc+A74DQsGErhg3TGzZMY/g/uBSwjMCNVjPJCTQjVouUdMp/545XJdeD
	tQ+x/cNmMDo+69MOMB5oB5CHky78kBXrYQFfJj2WSmtUcRpdEs20A7HtPOdw963xKtuPUmrj
	RP6Bfv4SicQ/8D2JiHTlT6ddkgmIBKmWVtC0mta88GE8J3c9VnDLHLH6Z3eEJ3csaGJQ3jf7
	U9HHB/a634+4GXVMXdksTPPa5DV40fh7tN8uZh842nOhOPZlcKLg0sGv+z/J0A89Fndu2xKj
	avv+ISF/zO6u2t9rqetKLvP9o8ENku2v8fJ7Q50n3/c5m/vSwOfJaHd4i8nqSjs/FUxdHveK
	OVRR2j1RUTPX/GPZjSNo/sjO04zpSup+D+figNCyE4vij3KjgxU/TwVlTGYuFU3uS3lamG+d
	DBugsONeT55tctlmeV0mjq7VjsSG4SXPpogvD6auhkY6tZ1ul7jnOPFjze/sNiuuy58H7O3r
	Gz1lCqp890TYqXS9T57HtbzFaylpn7I9mn4lWUyiVLQd1zDSfwEbiVe8mQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSvG7KipdpBru28VmsvtvPZvH68CdG
	i2kffjJb/L/7nMni5oGdTBYrVx9lspg9vZnJ4sn6WcwWG/s5LB7f+cxu8XPZKnaLSYeuMVrs
	vaVtcWmRu8WevSdZLOYve8pu0X19B5vF8uP/mCy2/Z7PbLHu9XsWi/N/j7NanJ81h91BzOPy
	FW+P8/c2snhMm3SKzePy2VKPTas62Tw2L6n32L3gM5PH7psNbB4fn95i8ejbsorR48yCI+we
	nzfJeWx68pYpgDeKyyYlNSezLLVI3y6BK+PtlbeMBY0iFRO/xzQw9gl0MXJySAiYSEy5doQV
	xBYS2M0ocf9MAURcXKL52g92CFtYYuW/50A2F1DNa0aJ/rnXWEASvAJ2Eitvr2cEsVkEVCUu
	bL7JDBEXlDg58wlYjahAksSe+41MILawgK1Ed+91sDgz0IJbT+aDxUUElCSevjrLCLKAWWAZ
	i8TBKW+ZILa1MUvM2tYINJWDg01AU+LC5FKQBk4BbYnzDTfZIQaZSXRt7WKEsOUltr+dwzyB
	UWgWkjtmIdk3C0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBKcDLa0d
	jHtWfdA7xMjEwXiIUYKDWUmE1/b30zQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQn
	lqRmp6YWpBbBZJk4OKUamNQ/fJmRnNS56GBQ4NHNN2RONCrprmQ6k6fsH/bf4d1cjlvr2fnS
	vNIvhL//sW52Hos+B9+q//xtB7zUzd5yq296PvN21/Q77+aukpta/Huv/5Oua71+LUI9m/e9
	WhE4Qy6zYa1r4ryXu2uqD8RYvL9wT8GxZcaTb3weT+u0WiW2V7LO8bB8NKf99uKOFcaJZTvX
	FhUz+YpF267z32jIVdG252U1R/K+1J1BRyWu376jzV5lnONxz+eEzUSrvtbFd/VawqeWrzaa
	bhj6qG2NZ/O+W6bvXuTY5t2u8PGTMU9vOXfY7Fjf3YueC0rtrI+L6t9ef7053nKPs8UURq5p
	Z+wnSqxZfWpK0qGHNpkML5RYijMSDbWYi4oTAeJ4hJd2AwAA
X-CMS-MailID: 20240917160348epcas5p275248c54b014ee3ef6a8c8b88d573b60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com>
	<20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de>
	<e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
	<20240913080659.GA30525@lst.de>
	<4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
	<20240917062007.GA4170@lst.de>

On 9/17/2024 11:50 AM, Christoph Hellwig wrote:
>>> But if we increase this to a variable number of hints that don't have
>>> any meaning (and even if that is just the rough order of the temperature
>>> hints assigned to them), that doesn't really work.  We'll need an API
>>> to check if these stream hints are supported and how many of them,
>>> otherwise the applications can't make any sensible use of them.
>> - Since writes are backward compatible, nothing bad happens if the
>> passed placement-hint value is not supported. Maybe desired outcome (in
>> terms of WAF reduction) may not come but that's not a kernel problem
>> anyway. It's rather about how well application is segregating and how
>> well device is doing its job.
> What do you mean with "writes are backward compatible" ?
> 

Writes are not going to fail even if you don't pass the placement-id or 
pass a placement-id that is not valid. FDP-enabled SSD will not shout 
and complete writes fine even with FDP-unaware software.

I think that part is same as how Linux write hints behave ATM. Writes 
don't have to carry the lifetime hint always. And when they do, the hint 
value never becomes the reason of failure (e.g. life hints on NVMe 
vanish in the thin air rather than causing any failure).

>> - Device is perfectly happy to work with numbers (0 to 256 in current
>> spec) to produce some value (i.e., WAF reduction). Any extra
>> semantics/abstraction on these numbers only adds to the work without
>> increasing that value. If any application needs that, it's free to
>> attach any meaning/semantics to these numbers.
> If the device (or file system, which really needs to be in control
> for actual files vs just block devices) does not support all 256
> we need to reduce them to less than that.  The kernel can help with
> that a bit if the streams have meanings (collapsing temperature levels
> that are close), but not at all if they don't have meanings. 

Current patch (nvme) does what you mentioned above.
Pasting the fragment that maps potentially large placement-hints to the 
last valid placement-id.

+static inline void nvme_assign_placement_id(struct nvme_ns *ns,
+					struct request *req,
+					struct nvme_command *cmd)
+{
+	u8 h = umin(ns->head->nr_plids - 1,
+				WRITE_PLACEMENT_HINT(req->write_hint));
+
+	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
+	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
+}

But this was just an implementation choice (and not a failure avoidance 
fallback).

