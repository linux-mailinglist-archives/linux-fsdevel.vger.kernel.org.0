Return-Path: <linux-fsdevel+bounces-37931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F589F93E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07862189B350
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FBF21885E;
	Fri, 20 Dec 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jzTfSpJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB552381AA;
	Fri, 20 Dec 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702908; cv=none; b=gbWRAZIXiC3LPYxRzisQliPALl6i9xF3FwXoov/i5G+gZLEpVjA8Nk7//a2VvybL7/siS+BRPPJNdt0lg2HglfWoFv5sNrWCqUpdEMGUaLTmU2dZpGfU3t/AqV8FV0l085TPAmzRPkpn0P9w8nPgcTN/iOWVSpph0wWH/p2ScIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702908; c=relaxed/simple;
	bh=ZmqAE//vO8O6BzMeTO4ZipltFH47Njcq8fjYjdLSIDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HkRE1gfDiyLpQImuqP8rehLmf/Y87zZ2MQeiqmT2t1m48Q/XKRaAqU6A//7dQVTIUJpAOJ+dSMXIDzU8yVw4mpwNm3jDlE1j+C8q4WNHJUrnnMv1ZyJl8mLj6V8o729mtAZh62+EqjvPXjVc9fEGG7pRTU/sdnLXTYkEEM9iWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=jzTfSpJS reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=lvLa3iOpbkaH5nzynkRPi3H2CDvhGWT9ofUPM85k1lU=; b=j
	zTfSpJSuztlpnDYdk5aCzH8y3d6Ak1iYS/0MlCY7DiTwPaYzhBqLe4Dn8zLKBBEn
	MlAttOmkkU6uBYp31sHmjTN490Y4M3EInyqDOVnbIEBCdwEGDvQGJopA+Wv4rUbl
	meR+XKNZi6RC4drungyzelkqC+AQHCu8tazFEgnYws=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-146 (Coremail) ; Fri, 20 Dec 2024 21:54:23 +0800
 (CST)
Date: Fri, 20 Dec 2024 21:54:23 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, 
	"Suren Baghdasaryan" <surenb@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] seq_file: copy as much as possible to user buffer in
 seq_read()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <18a1ba96-86d5-4c89-85f5-d816808e7735@web.de>
References: <20241220041605.6050-1-00107082@163.com>
 <18a1ba96-86d5-4c89-85f5-d816808e7735@web.de>
X-NTES-SC: AL_Qu2YBvubvUAt5SmdY+kXn0oTju85XMCzuv8j3YJeN500tCbvxhANcnBdO3/91cOVBS6SvxeUcSRA+MJlXoVYdaQCgWUgI+P2lEs1c0nk5vn2
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <43a31f63.a9c5.193e459165a.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kigvCgC3nwwQd2VnTW1EAA--.34802W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQS7qmdlX20AzAABsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTEyLTIwIDIwOjEzOjIwLCAiTWFya3VzIEVsZnJpbmciIDxNYXJrdXMuRWxmcmlu
Z0B3ZWIuZGU+IHdyb3RlOgo+oa0KPj4gVGhpcyBwYXRjaCB0cnkgdG8gZmlsbCB1cCB1c2VyIGJ1
ZmZlciBhcyBtdWNoIGFzIHBvc3NpYmxlLCChrQo+Cj5TZWUgYWxzbzoKPmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVl
L0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9djYuMTMtcmMz
I245NAoKVGhhbmtzIGZvciB0aGUgdGlwcywgd2lsbCBtYWtlIHRoZSBjaGFuZ2UuCgo+Cj5SZWdh
cmRzLAo+TWFya3VzCgoKRGF2aWQ=

