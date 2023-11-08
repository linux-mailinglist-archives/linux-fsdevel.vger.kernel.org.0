Return-Path: <linux-fsdevel+bounces-2351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C892B7E4FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 05:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D705B20EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 04:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51E79DB;
	Wed,  8 Nov 2023 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dttLBX6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1563DF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 04:35:24 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19910EB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 20:35:23 -0800 (PST)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231108043521epoutp028273ce432fa79bda9444407d5f7ed04f~Vi8b6lkzv2942829428epoutp02H
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 04:35:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231108043521epoutp028273ce432fa79bda9444407d5f7ed04f~Vi8b6lkzv2942829428epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699418121;
	bh=s0Biqx9Jw6VPb1yWBxvOukq5Us6aNYRDoDhBAPxwESw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=dttLBX6aag2iWJjf3zjZtqng/cxMVZxbCex6OsG7iNH/HvGNPlW9uk7MbZqnb1sQz
	 0A1qwYDeoEonLBWx90FmmYL+WqifMf/TNs9sX3Os3UxVqkIKzKo0KCaeve0gKcrb14
	 qRjX9BhmbeDTX0x7z2peObQStHxqYAs/mTyON1to=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231108043520epcas1p243910831cf2630404436a315cb6bf034~Vi8bnCbSF0530705307epcas1p2q;
	Wed,  8 Nov 2023 04:35:20 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.250]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SQC1h0XmLz4x9Q9; Wed,  8 Nov
	2023 04:35:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.51.08572.6001B456; Wed,  8 Nov 2023 13:35:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20231108043518epcas1p4ca3b2570230803c5beb826ba15124730~Vi8ZJoMUV0920409204epcas1p4R;
	Wed,  8 Nov 2023 04:35:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231108043518epsmtrp224454e810f0523c2ef38ff43aa083811~Vi8ZJEKVr1613716137epsmtrp2E;
	Wed,  8 Nov 2023 04:35:18 +0000 (GMT)
X-AuditID: b6c32a33-55c16a800000217c-bf-654b100675e7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.8D.08755.6001B456; Wed,  8 Nov 2023 13:35:18 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231108043517epsmtip2dacad6e8bc1e64d9170afca2f451b216~Vi8Y_gx5V2071620716epsmtip2-;
	Wed,  8 Nov 2023 04:35:17 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Shigeru Yoshida'" <syoshida@redhat.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sj1557.seo@samsung.com>
In-Reply-To: <20231107143002.1342295-1-syoshida@redhat.com>
Subject: RE: [PATCH] exfat: Fix uninit-value access in __exfat_write_inode()
Date: Wed, 8 Nov 2023 13:35:17 +0900
Message-ID: <9e8201da11fc$f9b461b0$ed1d2510$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJOaZq6ct92fJmTri3GvEJT5c0Z2gJKbj4Or3TOx0A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmvi6bgHeqwbZTChYTpy1lttiz9ySL
	xeVdc9gstvw7wmoxZ9ZUFgdWj02rOtk83u+7yubRt2UVo8fnTXIBLFENjDaJRckZmWWpCql5
	yfkpmXnptkqhIW66FkoKGfnFJbZK0YaGRnqGBuZ6RkZGeqZGsVZGpkoKeYm5qbZKFbpQvUoK
	RckFQLW5lcVAA3JS9aDiesWpeSkOWfmlIMfqFSfmFpfmpesl5+cqKZQl5pQCjVDST/jGmHH3
	wXnWgnnKFd3LHrA2MH6V7WLk5JAQMJE4c/0CcxcjF4eQwA5GiZ9/5rNAOJ8YJS73r2CFcL4x
	Srxc/YQZpuXu/c1MEIm9jBJ91z6xQTgvGSUePXwMVsUmoCvx5MZPMFtEwE1iS9tpVhCbWSBe
	YvGO40ANHBycAtYSLV8iQMLCAj4SL95OZgexWQRUJFo+b2UEsXkFLCUOrGhkgrAFJU7OfMIC
	MUZeYvvbOVAHKUjs/nSUFWKVlcTCs/egakQkZne2gf0mIdDIIfFo4SNGiAYXiZ5b81khbGGJ
	V8e3sEPYUhKf3+1lg2joZpQ4/vEdC0RiBqPEkg4HCNteorm1GewBZgFNifW79CHCihI7f89l
	hFjMJ/Huaw/UfEGJ09e6mUHKJQR4JTrahCDCKhLfP+xkmcCoPAvJa7OQvDYLyQuzEJYtYGRZ
	xSiWWlCcm56abFhgiBzhmxjBSVXLeAfj5fn/9A4xMnEwHmKU4GBWEuH9a++RKsSbklhZlVqU
	H19UmpNafIgxGRjYE5mlRJPzgWk9ryTe0MzM0sLSyMTQ2MzQkLCwiaWBiZmRiYWxpbGZkjiv
	4oTZKUIC6YklqdmpqQWpRTBbmDg4pRqYqha6Xfw478zpQ4baSx4ck7hVq/k8Y/eralO553Yf
	Hjxq6Px7ysrTS1RrZ+wj01+iv8KfX1jP9ftl41R33+7ZSn81dd/9D9kYurDB4YVcVPn5s/vr
	ZoRv+LuMvWHxut31Br8/Htif+e81e6nBzqlWLwqeeXY+/Gtwf199uld8Z4C7cdnroJwTApLd
	VU+uyJ6VWDjvZ6azg9Qjv+C/8Z3hR16uOj0/9Kx5WSzrc++N17fPfnD+n3v3mQOT1Kz9PKtf
	vtp5Q/ncy6/e8wKz/796+nm3zN9J7nnPImcGJJ0875z3soaRK2ED756tP9z3WPULqPGH9/me
	PMup4HbMddGfhpafzL3O/P0hJXb6u3NZ3yixFGckGmoxFxUnAgC4rQ6iYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvC6bgHeqwdGHzBYTpy1lttiz9ySL
	xeVdc9gstvw7wmoxZ9ZUFgdWj02rOtk83u+7yubRt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
	GXcfnGctmKdc0b3sAWsD41fZLkZODgkBE4m79zczdTFycQgJ7GaUOLO1lbWLkQMoISVxcJ8m
	hCkscfhwMUTJc0aJ/uMXWEB62QR0JZ7c+MkMYosIeEj0/ljBBmIzCyRKnFnSxgrR0MMo8eLS
	ZRaQQZwC1hItXyJAaoQFfCRevJ3MDmKzCKhItHzeyghi8wpYShxY0cgEYQtKnJz5BKyVWUBP
	om0jI8R4eYntb+cwQ5yvILH701FWiBOsJBaevccCUSMiMbuzjXkCo/AsJJNmIUyahWTSLCQd
	CxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeKluYOxu2rPugdYmTiYDzEKMHB
	rCTC+9feI1WINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD
	03SucH5G91OFJVO5/p5bozwzKG6fiv7hzA+/4pLsNeYohvEJWE81SvFdyH1aOcJtt/nWj92/
	Jzdy1/Ml/N50vbn4zOm+w//bHzw3tWuROPB0++t38dPyXz3o2e3y7o72Ao+zom2Lolcf8zY7
	sTzpZBfn1satcXyPss/zRHe/1wiOnuRa+2WTtHicW138g7hLwiKL3nHvrfgdfchXzqIzJ/f8
	Un63fVoheW6v2K592jHt35a84D7PC5l5xT8MnizRtJXfyLB/Yewxf//isKxvh+/4Nv5derPL
	WWXhpFe/I2d2vZGb63A6deN1pb1O926+Ltr7wowl8+9ds2dv/UybHRo/cE7vffV2+zouEZOg
	r0osxRmJhlrMRcWJAI5ifpMDAwAA
X-CMS-MailID: 20231108043518epcas1p4ca3b2570230803c5beb826ba15124730
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231107143021epcas1p304b8b94862a8f28d264714f06a624674
References: <CGME20231107143021epcas1p304b8b94862a8f28d264714f06a624674@epcas1p3.samsung.com>
	<20231107143002.1342295-1-syoshida@redhat.com>

Hello,

A similar fix has already been queued in the dev branch.
Please refer to below commit.

Commit fc12a722e6b7 ("exfat: fix setting uninitialized time to
ctime/atime"):
https://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git/commit/
?h=dev&id=fc12a722e6b799d1d3c1520dc9ba9aab4fda04bf

Thanks.

B.R.
Sungjong Seo

> KMSAN reported the following uninit-value access issue:
> 
> =====================================================
> BUG: KMSAN: uninit-value in exfat_set_entry_time+0x309/0x360
> fs/exfat/misc.c:99
>  exfat_set_entry_time+0x309/0x360 fs/exfat/misc.c:99
>  __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
>  __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
>  exfat_truncate+0x121/0x540 fs/exfat/file.c:211
>  exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
>  notify_change+0x1934/0x1a30 fs/attr.c:499
>  do_truncate+0x224/0x2a0 fs/open.c:66
>  handle_truncate fs/namei.c:3280 [inline]  do_open fs/namei.c:3626
[inline]
>  path_openat+0x56c6/0x5f20 fs/namei.c:3779
>  do_filp_open+0x21c/0x5a0 fs/namei.c:3809
>  do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440  do_sys_open fs/open.c:1455
> [inline]  __do_sys_creat fs/open.c:1531 [inline]  __se_sys_creat
> fs/open.c:1525 [inline]
>  __x64_sys_creat+0xe3/0x140 fs/open.c:1525
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was stored to memory at:
>  exfat_set_entry_time+0x302/0x360 fs/exfat/misc.c:99
>  __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
>  __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
>  exfat_truncate+0x121/0x540 fs/exfat/file.c:211
>  exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
>  notify_change+0x1934/0x1a30 fs/attr.c:499
>  do_truncate+0x224/0x2a0 fs/open.c:66
>  handle_truncate fs/namei.c:3280 [inline]  do_open fs/namei.c:3626
[inline]
>  path_openat+0x56c6/0x5f20 fs/namei.c:3779
>  do_filp_open+0x21c/0x5a0 fs/namei.c:3809
>  do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440  do_sys_open fs/open.c:1455
> [inline]  __do_sys_creat fs/open.c:1531 [inline]  __se_sys_creat
> fs/open.c:1525 [inline]
>  __x64_sys_creat+0xe3/0x140 fs/open.c:1525
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Local variable ts created at:
>  __exfat_write_inode+0x102/0xdb0 fs/exfat/inode.c:29
>  __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
> 
> CPU: 0 PID: 13839 Comm: syz-executor.7 Not tainted 6.6.0-14500-
> g1c41041124bd #10 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.2-1.fc38 04/01/2014
> =====================================================
> 
> Commit 4c72a36edd54 ("exfat: convert to new timestamp accessors") changed
> __exfat_write_inode() to use new timestamp accessor functions.
> 
> As for mtime, inode_set_mtime_to_ts() is called after
> exfat_set_entry_time(). This causes the above issue because `ts` is not
> initialized when exfat_set_entry_time() is called. The same issue can
> occur for atime.
> 
> This patch resolves this issue by calling inode_get_mtime() and
> inode_get_atime() before exfat_set_entry_time() to initialize `ts`.
> 
> Fixes: 4c72a36edd54 ("exfat: convert to new timestamp accessors")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  fs/exfat/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> 875234179d1f..e7ff58b8e68c 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -56,18 +56,18 @@ int __exfat_write_inode(struct inode *inode, int sync)
>  			&ep->dentry.file.create_time,
>  			&ep->dentry.file.create_date,
>  			&ep->dentry.file.create_time_cs);
> +	ts = inode_get_mtime(inode);
>  	exfat_set_entry_time(sbi, &ts,
>  			     &ep->dentry.file.modify_tz,
>  			     &ep->dentry.file.modify_time,
>  			     &ep->dentry.file.modify_date,
>  			     &ep->dentry.file.modify_time_cs);
> -	inode_set_mtime_to_ts(inode, ts);
> +	ts = inode_get_atime(inode);
>  	exfat_set_entry_time(sbi, &ts,
>  			     &ep->dentry.file.access_tz,
>  			     &ep->dentry.file.access_time,
>  			     &ep->dentry.file.access_date,
>  			     NULL);
> -	inode_set_atime_to_ts(inode, ts);
> 
>  	/* File size should be zero if there is no cluster allocated */
>  	on_disk_size = i_size_read(inode);
> --
> 2.41.0



