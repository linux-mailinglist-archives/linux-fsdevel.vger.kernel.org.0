Return-Path: <linux-fsdevel+bounces-37970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250DF9F96DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95091883E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C621A44E;
	Fri, 20 Dec 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="b+im4K6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B8194080;
	Fri, 20 Dec 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713399; cv=none; b=qDcgWSP1wx9unkA81dZUo/Uq/PcFcFR1mq3c9QW+hNSp9BDfR47lidTQulUYBC4LdxPfeUpQnJBaLx3jJCGcrUqRHf58RiBt+P97VnoyIJ672oR8ow8O32jDXMLpHIPQhDyOofGQ8ER5CQn8iTP9f6sNB6ailfBs5BK/9dl5W7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713399; c=relaxed/simple;
	bh=ZoBAjDF4cljaOpM1ftlPD/c0I2NDI5UZONkvnHt3u8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rBGYo9lEvbyqewr71CiDT/UWuwZtds1FQ4TAXjl6FM3y/fNG8g7L/F5K+7OqXYfcTM7fbcTf1ISvG1TL86FLAg/TjNXKdLjI/AodkcFc6UvZ6G1gNTo4gTS/0Zgro/PsUNxzbjErXmORYGY4JlGl+AgJ+JaOB6+QftcAKzlyR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=b+im4K6c reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OKHrh5yg2BacFrX9YetqNZeaucfGNasvM4vSQmHvAGQ=; b=b
	+im4K6c2LtW+JRbIgkddEIqv5aSRywUn2j/mlchzzHW3LYMUerWHJgEc6SxO0pEs
	+FhUSWiq8dY79iFcoCrkygbxSIe1CHhzcwmqHJ4og0sXry9ee0qVJhhGNvBCFbE9
	3RCVIxIHlGkRu+NKaNVgUyAVjW/821E8lNOe9ujUcQ=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Sat, 21 Dec 2024 00:48:53 +0800
 (CST)
Date: Sat, 21 Dec 2024 00:48:53 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"Suren Baghdasaryan" <surenb@google.com>
Subject: Re: [PATCH v2] seq_file: copy as much as possible to user buffer in
 seq_read()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <4256c3d6-5769-444a-84d5-3b416015bc34@web.de>
References: <20241220041605.6050-1-00107082@163.com>
 <20241220140819.9887-1-00107082@163.com>
 <4256c3d6-5769-444a-84d5-3b416015bc34@web.de>
X-NTES-SC: AL_Qu2YBvuavEso5SSYZ+kXn0oTju85XMCzuv8j3YJeN500myXU+SQQbG57BX3v/Pm3IjmmoQmTXQVT++djdoBlZ4lV4d+6OqiO4B2yb6QXpnf/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1748fa92.b227.193e4f8d6a3.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgCXP5f2n2VndUxHAA--.64663W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQK7qmdlmOPzmgAAsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTEyLTIwIDIyOjM0OjEyLCAiTWFya3VzIEVsZnJpbmciIDxNYXJrdXMuRWxmcmlu
Z0B3ZWIuZGU+IHdyb3RlOgo+PiBzZXFfcmVhZCgpIHlpZWxkcyBhdCBtb3N0IHNlcV9maWxlLT5z
aXplIGJ5dGVzIHRvIHVzZXJzcGFjZSwgoa0KPgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVzZXIgc3BhY2U/Cj4KPgo+oa0KPj4gCSQgc3RyYWNl
IC1UIC1lIHJlYWQgY2F0IC9wcm9jL2ludGVycnVwdHMgID4gL2Rldi9udWxsCj6hrQo+PiAJIDQ1
IHJlYWQoMywgIiIsIDEzMTA3MikgICAgICAgICAgICAgICAgICAgICA9IDAgPDAuMDAwMDEwPgo+
PiBPbiBhIHN5c3RlbSB3aXRoIGh1bmRyZWRzIG9mIGNwdXMsIGl0IHdvdWxkIG5lZWQgoa0KPgo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVXM/Cj4KPgo+SXMgaXQgYSBiaXQgbmlj
ZXIgdG8gc2VwYXJhdGUgdGVzdCBvdXRwdXQgYW5kIHN1YnNlcXVlbnQgY29tbWVudHMgYnkgYmxh
bmsgbGluZXM/Cj4KPgo+oa0KPj4gRmlsbCB1cCB1c2VyIGJ1ZmZlciBhcyBtdWNoIGFzIHBvc3Np
YmxlIGluIHNlcV9yZWFkKCksIGV4dHJhIHJlYWQKPj4gY2FsbHMgY2FuIGJlIGF2b2lkZWQgd2l0
aCBhIGxhcmdlciB1c2VyIGJ1ZmZlciwgYW5kIDIlfjEwJSBwZXJmb3JtYW5jZQo+PiBpbXByb3Zl
bWVudCB3b3VsZCBiZSBvYnNlcnZlZDoKPldpbGwgaXQgaGVscCB0byBzcGxpdCBzdWNoIGEgcGFy
YWdyYXBoIGludG8gdGhyZWUgc2VudGVuY2VzCj4ob24gc2VwYXJhdGUgbGluZXMpPwo+Cj5SZWdh
cmRzLAo+TWFya3VzCgpUaGFua3MgZm9yIHRoZSBjb21tZW50cywgSSB3aWxsIGFkZHJlc3MgaXQg
bGF0ZXIuCkFueSBjb25jZXJuIGFib3V0IHRoZSBjb2RlPwoKRGF2aWQ=

