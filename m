Return-Path: <linux-fsdevel+bounces-40484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32409A23BE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 11:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E16188A3F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95619D074;
	Fri, 31 Jan 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aoxIDljj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D1136A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317973; cv=none; b=g31YYbiV6/WUjYXuw0Gd1VNM9UZ03XPwjZKwA3oMFI/gXPzSS6AsqjxmVS3R/DBCdGLxaC4n0qib+I1xBNfeKm1fYGTrkdLk7VM8NnGFXqiB6PZGDoLZFZL5jp7aFathNNIzQvUUX4df7whqstqNVtNqyS3S5L2EdP2ff34hAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317973; c=relaxed/simple;
	bh=H7Tdl85TaobSFC9t2Iiwh+6BL3o2Va32SZ+VPztsozg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=j+hDJZ0RPQPSatQjHgzGY7Lq+p2Poij0/teSnZki1Zodwt318uSwjPTm1Guy3eXFo1X6UYGnMM/phZ9CJMeRdfoyCFoKqHKFTFTo1AVlLGDIyX4CbbWFVuD3Z/ADIcTpHHb5SSEclVpb+FMaW/2SQ1PODR+jPyS5IE3DOKDwALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aoxIDljj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250131100603epoutp03b5ca1a978e353ce7df15088c262553e1~fvvo7RgpD0165901659epoutp03O
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 10:06:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250131100603epoutp03b5ca1a978e353ce7df15088c262553e1~fvvo7RgpD0165901659epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738317963;
	bh=cQepeKl+8YlVpw6OQGydduien6eQ3GxZHfs/tjhTYx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aoxIDljjHb7/8BThyXVAvxrKKizLqhXPbSdUDnF3xmwLKBBfXVQzfyW7kdxEy8CT1
	 +JnIwbsyPOCHjcQTDQgdpw2Qj3zKdYeLBT4SMI7ZwuPip8T9Qeo1Fv67OnEMA0nCXN
	 al4TMo5rvM+D6ISDZlOhNzg+KmMMWC6V9oRzEuZk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250131100602epcas5p23ba8a8fa9af6fca662fccbfd490c0b0a~fvvoh7NKJ2867928679epcas5p2M;
	Fri, 31 Jan 2025 10:06:02 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yks3Y0Jf6z4x9Py; Fri, 31 Jan
	2025 10:06:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.E0.19956.880AC976; Fri, 31 Jan 2025 19:06:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250131100513epcas5p2fbb42195d73364ed65f187b65f5a4083~fvu6TYVea2230022300epcas5p2O;
	Fri, 31 Jan 2025 10:05:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131100513epsmtrp20571ad527fbc2c3c7436c965b288f746~fvu6SrXjx2696926969epsmtrp2U;
	Fri, 31 Jan 2025 10:05:13 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-66-679ca088444c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.26.33707.850AC976; Fri, 31 Jan 2025 19:05:12 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250131100511epsmtip1af8267a51a86be83f935514cd33ff46a~fvu4ukezw2758427584epsmtip1N;
	Fri, 31 Jan 2025 10:05:11 +0000 (GMT)
Date: Fri, 31 Jan 2025 15:27:03 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	david@fromorbit.com, axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250131095656.gzn7hwynq7hqq5ok@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250129154218.GA7369@lst.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmhm7HgjnpBhdfW1k0TfjLbLH6bj+b
	xZZL9hZbjt1jtLh5YCeTxcrVR5ksjv5/y2axZ+9JFot9r/cyW9yY8JTR4vePOWwO3B6nFkl4
	bF6h5XH5bKnHplWdbB6Tbyxn9Nh9s4HN49zFCo++LasYPT5vkgvgjMq2yUhNTEktUkjNS85P
	ycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6VEmhLDGnFCgUkFhcrKRvZ1OU
	X1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQndG57SNrwUb2io07utka
	GNexdTFyckgImEhMbd7L1MXIxSEksJtRYk3zPCjnE6NEw/tnrCBVYM7f1XAdE6ZeZIYo2sko
	0dY6iRXCecYo0dTZBdTOwcEioCpxqDsFxGQT0JX40RQK0isioCTx9NVZRpByZoHnjBKTjj9i
	BEkICzhJTF2wgAXE5hUwk9h4cjU7hC0ocXLmE7A4p4C2xNPty8EOEhWQkZix9CvYERICOzgk
	jsz4zwhxnYvErZUPWSFsYYlXx7ewQ9hSEp/f7YX6IFviUOMGJgi7RGLnkQaoGnuJ1lP9zCA2
	s0CGxL32r1AzZSWmnlrHBBHnk+j9/QSql1dixzwYW01izrupLBC2jMTCSzOg4h4SF1acgobW
	ZmAAPbvAPoFRfhaS52Yh2QdhW0l0fmhihbDlJZq3zmaeBQxIZgFpieX/OCBMTYn1u/QXMLKt
	YpRMLSjOTU8tNi0wzksth0d+cn7uJkZwotby3sH46MEHvUOMTByMhxglOJiVRHhjz81IF+JN
	SaysSi3Kjy8qzUktPsRoCoy3icxSosn5wFyRVxJvaGJpYGJmZmZiaWxmqCTO27yzJV1IID2x
	JDU7NbUgtQimj4mDU6qByVdxwsP+GbkP2fxCOYqe2uf61xmcKFVdfE/79b9nSSq39ucYejOd
	e/HixpsX8yP2862Zdj4/cX/Ogy2vftY9F2P8tGPZ+Y2BM/afvr2KKY6nUUf9p1td6Woe031z
	vvFMkS1LvSqdvft6qMQZiZj5977MzUp0fVlzda5/TzbzvUtCWyQ7xVU3/LL8cGnhTZamCR+P
	GmpZcDZ8Sj2T/feZf+NE6QMT3lR1LtL4vPS06qtEiZPLZT9nv5ies4h7zvKPbELVRvcqfVVX
	5fEJGDZu2ee6YcrxL3Gdfjenu/OcOru74mxr66qQ5RtuLr52PKtiU8ZZ1bykzwcN713l3Ld5
	fptok7PAmrsBPu0r1ubqNSspsRRnJBpqMRcVJwIAcjSODV0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnG7EgjnpBps+2Fg0TfjLbLH6bj+b
	xZZL9hZbjt1jtLh5YCeTxcrVR5ksjv5/y2axZ+9JFot9r/cyW9yY8JTR4vePOWwO3B6nFkl4
	bF6h5XH5bKnHplWdbB6Tbyxn9Nh9s4HN49zFCo++LasYPT5vkgvgjOKySUnNySxLLdK3S+DK
	2PiNv+AQS0XLnq+MDYx3mLsYOTkkBEwkJky9CGRzcQgJbGeUuP+6hxEiISOx++5OVghbWGLl
	v+fsEEVPGCXebpsK1MHBwSKgKnGoOwXEZBPQlfjRFApSLiKgJPH01VlGkHJmgeeMEv0HprCA
	JIQFnCSmLlgAZvMKmElsPLkaauZmRonZj/tZIRKCEidnPgErYgYqmrf5IdguZgFpieX/OCDC
	8hLNW2eDPcApoC3xdPtysFZRoJtnLP3KPIFRaBaSSbOQTJqFMGkWkkkLGFlWMYqmFhTnpucm
	FxjqFSfmFpfmpesl5+duYgTHm1bQDsZl6//qHWJk4mA8xCjBwawkwht7bka6EG9KYmVValF+
	fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA9PiYo2AhwEzos+4vFgslzeP
	/bfZi1mCn9u/vLiycr5ge4V45PeQoIU3onhKv6zfuKlR87TOpmWGqb8jwlisYso1V3BN6hf7
	8X65/YZ5u+SneDgsU1kptXDbw3tLNn5Ztr1lcX7nBdFLCeeXtF/dtVfN8n3hjv5tIv5nRBfU
	5K2SUlsR+WXaC3npM7l2c9f08xUZOm7j9X75WueWQZLrlLZHD49O29YtpFhuHKQ1xeVc6p0v
	J+91S55OUtkgFezIVLjNxPi6dahWpr/j36wVC9K73I4cDdmmtvYCx9XzsTnJPzIZT5lwzvki
	9MchTW1X4wuNB7Fnuox37bO/aXmCxy3R796O/Y4BN47IHsuYyvNUiaU4I9FQi7moOBEAW7NT
	ZyYDAAA=
X-CMS-MailID: 20250131100513epcas5p2fbb42195d73364ed65f187b65f5a4083
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_1a345_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
	<20250129102627.161448-1-kundan.kumar@samsung.com>
	<20250129154218.GA7369@lst.de>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_1a345_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 29/01/25 04:42PM, Christoph Hellwig wrote:
>I don't think per-cpu is the right shard here.  You want to write
>related data together.  A fіrst approximation might be inodes.
>
We have plan to affine inode to a particular writeback thread, like on
first encounter of inode we select one writeback context, and use the same
context when inode tries to issue IO again. 

The number of writeback contexts can be changed from per-cpu and can be
decided using other factors as in this discussion.
https://lore.kernel.org/all/20250131093209.6luwm4ny5kj34jqc@green245/


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_1a345_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_1a345_--

