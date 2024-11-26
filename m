Return-Path: <linux-fsdevel+bounces-35869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247D9D91E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 07:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3107B2454C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441F18858E;
	Tue, 26 Nov 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="KrJZHpH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3741917FB;
	Tue, 26 Nov 2024 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603528; cv=none; b=bwTTBr+Uz128D3yCM1ojUSvxM88kgaF9nkBmD6CQ4Nz2w7dROJO20pmCly8vpwsV7AQ+fCrW0kiK7eYqz6DtXYQVJbrJ2JVdkIAsQ14Q8r4BFnD+QRfIY+98TaVmz57g6jGL0ZLJESijXAs2+jAH/SrlppmUx6bJmyeTpAXBXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603528; c=relaxed/simple;
	bh=GlmaecMtzF5B6glEExZ++UTpLtGB4mL15efGLcv+9k0=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=f+R+42cCjDJeARnGCLgf19FePFmdhmMGGkxrMizgy3Wi2zce61Vgw/2CWjtMNBPOwItu5BxoJXhHubMjIRjKXSUloT4GdKN1MmdF5H88LUSGpf3kx4WQyBLfeYrG6tFKhOSU2zjTiVqb1x4e+4269RVi6XzLBekCULVEmE0yln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=KrJZHpH0 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=R2iaO5paQXkgJxCmCqiSqSvlFqF90j3KJ2Ra0z+ibCY=; b=KrJZHpH05DtLz
	fN/s+7JBl9SnoZVOOc9DLk1jjS0d3l+R6HvNoAPqBqBDu69ByoVHsUhSR5HD0x6L
	qRB3V3vpJLOuzs+nPiyJd7cu0kCQc+es4WCCegef1z2qILpBkUYP/DXJylnrBgyp
	EU2xUh5s421jDvjLlozTX1lpFN9mdI=
Received: from zhenghaoran$buaa.edu.cn ( [211.90.238.32] ) by
 ajax-webmail-coremail-app1 (Coremail) ; Tue, 26 Nov 2024 14:44:52 +0800
 (GMT+08:00)
Date: Tue, 26 Nov 2024 14:44:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6YOR5rWp54S2?= <zhenghaoran@buaa.edu.cn>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, mjguzik@gmail.com, willy@infradead.org,
	linux@treblig.org, djwong@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 21371365@buaa.edu.cn, baijiaju1990@gmail.com, zhenghaoran@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20240305(0ac2fdd1) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-63b7ebb9-fa87-40c1-9aec-818ec5a006d9-buaa.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7ed332aa.d50.193673739e3.Coremail.zhenghaoran@buaa.edu.cn>
X-Coremail-Locale: zh_TW
X-CM-TRANSID:OCz+CgB3_ONlbkVnCL4HAA--.1461W
X-CM-SenderInfo: 1v1sjjazstiqpexdthxhgxhubq/1tbiAgQNA2dEcUNJxAABsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

U29ycnkgZm9yIHRoZSBwcmV2aW91cyBlbWFpbCBpbiBodG1sIGZvcm1hdCwgaGVyZSBpcyB0aGUg
cmVzZW50IAplbWFpbCBpbiBwbGFpbiBBU0NJSSB0ZXh0IGZvcm1hdC4KClRoYW5rcyBmb3IgeW91
ciByZXBsaWVzLiBEdXJpbmcgZnVydGhlciB0ZXN0aW5nLCBJIGZvdW5kIHRoYXQgdGhlIApzYW1l
IHByb2JsZW0gYWxzbyBvY2N1cnJlZCB3aXRoIGBtdGltZWAgYW5kIGBhdGltZWAuIEkgYWxyZWFk
eSAKdW5kZXJzdGFuZCB0aGF0IHRoaXMgYnVnIG1heSBoYXZlIGxpbWl0ZWQgaW1wYWN0LCBidXQg
c2hvdWxkIEkgZG8gCnNvbWV0aGluZyBlbHNlIHRvIGRlYWwgd2l0aCB0aGlzIHNlcmllcyBvZiB0
aW1lc3RhbXAtcmVsYXRlZCBpc3N1ZXM/CgpUaGUgbmV3IGNhbGwgc3RhY2sgaXMgYXMgZm9sbG93
cwo9PT09PT09PT09PT1EQVRBX1JBQ0U9PT09PT09PT09PT0KIGJ0cmZzX3dyaXRlX2NoZWNrKzB4
ODQxLzB4MTNmMCBbYnRyZnNdCiBidHJmc19idWZmZXJlZF93cml0ZSsweDZhOS8weDJjOTAgW2J0
cmZzXQogYnRyZnNfZG9fd3JpdGVfaXRlcisweDRiNy8weDE2ZDAgW2J0cmZzXQogYnRyZnNfZmls
ZV93cml0ZV9pdGVyKzB4NDEvMHg2MCBbYnRyZnNdCiBhaW9fd3JpdGUrMHg0NDUvMHg2MDAKIGlv
X3N1Ym1pdF9vbmUrMHhkNjgvMHgxY2YwCiBfX3NlX3N5c19pb19zdWJtaXQrMHhjNC8weDI3MAog
ZG9fc3lzY2FsbF82NCsweGM5LzB4MWEwCiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUr
MHg3Ny8weDdmCiAweDAKPT09PT09PT09PT09T1RIRVJfSU5GTz09PT09PT09PT09PQogYnRyZnNf
ZGVsYXllZF91cGRhdGVfaW5vZGUrMHgxZTI0LzB4ODBlMCBbYnRyZnNdCiBidHJmc191cGRhdGVf
aW5vZGUrMHg0NzgvMHhiYzAgW2J0cmZzXQogYnRyZnNfZmluaXNoX29uZV9vcmRlcmVkKzB4MjRk
Ni8weDM2YTAgW2J0cmZzXQogYnRyZnNfZmluaXNoX29yZGVyZWRfaW8rMHgzNy8weDYwIFtidHJm
c10KIGZpbmlzaF9vcmRlcmVkX2ZuKzB4M2UvMHg1MCBbYnRyZnNdCiBidHJmc193b3JrX2hlbHBl
cisweDljOS8weDI3YTAgW2J0cmZzXQogcHJvY2Vzc19zY2hlZHVsZWRfd29ya3MrMHg3MTYvMHhm
MTAKIHdvcmtlcl90aHJlYWQrMHhiNmEvMHgxMTkwCiBrdGhyZWFkKzB4MjkyLzB4MzMwCiByZXRf
ZnJvbV9mb3JrKzB4NGQvMHg4MAogcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ==

