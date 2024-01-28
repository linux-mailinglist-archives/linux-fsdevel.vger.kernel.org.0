Return-Path: <linux-fsdevel+bounces-9234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911F83F4A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 09:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09D3284923
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90295DF49;
	Sun, 28 Jan 2024 08:52:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39FDDC5;
	Sun, 28 Jan 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706431962; cv=none; b=VvQtYQN3gLRe7AYj9ssn86Ge5lK2UafLjG3BuKPSv+5mobWAe4Y+y0jeV410g2658IJ1jGpeHN3ghShLPFaB22IZgJEGcZg+G8In45ohIfXUJ98w5F2F0ybHMlY3Jbl5UO8jO9W/lL2ZnYGbI6NiMoX8loM++r3oa8mrm92MzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706431962; c=relaxed/simple;
	bh=0l9Gv2KClL1PK/HXZ8poSenceSjDMvX3gYNrU+Hzmcg=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=gbnS2Q4nYl+pwrzYaea4s6gNrlqq/RIUPKL06U8KuO7uKpBUOhd3FYkPGbTp8P+rIOj8k6nZYi/+GZAPk0Pnh64PqSSe/ubVozcABZrJvzPBWrNwNRzxie67iOAzmJHVFNitbdqmZC0F2UbEgC9C/o6fb56Kh1MO0NR8ImAmzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [219.141.235.82] ) by
 ajax-webmail-APP-12 (Coremail) ; Sun, 28 Jan 2024 16:45:59 +0800
 (GMT+08:00)
Date: Sun, 28 Jan 2024 16:45:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Identified Redundant Capability Check in File Access under
 /proc/sys
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <30b59a4.19708.18d4f3f3620.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tgCowAAHf89HFLZlHkQIAA--.23563W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiBwoJE2W0X22TVAACsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gZGV2ZWxvcGVycywKCkkgaG9wZSB0aGlzIG1lc3NhZ2UgZmluZHMgeW91IHdlbGwuIEkg
d2FudGVkIHRvIGJyaW5nIHRvIHlvdXIgYXR0ZW50aW9uIGFuIG9ic2VydmF0aW9uIHJlZ2FyZGlu
ZyBmaWxlIGFjY2VzcyB1bmRlciAvcHJvYy9zeXMgaW4gdGhlIGtlcm5lbCBzb3VyY2UgY29kZS4K
ClVwb24gcmV2aWV3LCBpdCBhcHBlYXJzIHRoYXQgY2VydGFpbiBmaWxlcyBhcmUgcHJvdGVjdGVk
IGJ5IGNhcGFiaWxpdGllcyBpbiB0aGUga2VybmVsIHNvdXJjZSBjb2RlOyBob3dldmVyLCB0aGUg
Y2FwYWJpbGl0eSBjaGVjayBkb2VzIG5vdCBzZWVtIHRvIGJlIGVmZmVjdGl2ZWx5IGVuZm9yY2Vk
IGR1cmluZyBmaWxlIGFjY2Vzcy4KCkZvciBleGFtcGxlLCBJIG5vdGljZWQgdGhpcyBpbmNvbnNp
c3RlbmN5IGluIHRoZSBhY2Nlc3MgZnVuY3Rpb25zIG9mIHNvbWUgc3BlY2lhbCBmaWxlczoKMS4g
VGhlIGFjY2VzcyBmdW5jdGlvbiBtbWFwX21pbl9hZGRyX2hhbmRsZXIoKSBpbiAvcHJvYy9zeXMv
dm0vbW1hcF9taW5fYWRkciB1dGlsaXplcyB0aGUgQ0FQX1NZU19SQVdJTyBjaGVjay4KMi4gVGhl
IGFjY2VzcyBmdW5jdGlvbiBwcm9jX2RvaW50dmVjX21pbm1heF9zeXNhZG1pbigpIGluIC9wcm9j
L3N5cy9rZXJuZWwva3B0cl9yZXN0cmljdCByZXF1aXJlcyB0aGUgQ0FQX1NZU19BRE1JTiBjaGVj
ay4KCkRlc3BpdGUgdGhlc2UgY2FwYWJpbGl0eSBjaGVja3MgaW4gdGhlIHNvdXJjZSBjb2RlLCB3
aGVuIGFjY2Vzc2luZyBhIGZpbGUsIGl0IHVuZGVyZ29lcyBhIFVHTyBwZXJtaXNzaW9uIGNoZWNr
IGJlZm9yZSB0cmlnZ2VyaW5nIHRoZXNlIHNwZWNpYWxpemVkIGZpbGUgYWNjZXNzIGZ1bmN0aW9u
cy4gVGhlIFVHTyBwZXJtaXNzaW9ucyBmb3IgdGhlc2UgZmlsZXMgYXJlIGNvbmZpZ3VyZWQgYXMg
cm9vdDpyb290IHJ3LSByLS0gci0tLCBtZWFuaW5nIG9ubHkgdGhlIHJvb3QgdXNlciBjYW4gcGFz
cyB0aGUgVUdPIGNoZWNrLgoKQXMgYSByZXN1bHQsIHRvIGFjY2VzcyB0aGVzZSBmaWxlcywgb25l
IG11c3QgYmUgdGhlIHJvb3QgdXNlciwgd2hvIGluaGVyZW50bHkgcG9zc2Vzc2VzIGFsbCBjYXBh
YmlsaXRpZXMuIENvbnNlcXVlbnRseSwgdGhlIGNhcGFiaWxpdGllcyBjaGVjayBpbiB0aGUgZmls
ZSBhY2Nlc3MgZnVuY3Rpb24gc2VlbXMgcmVkdW5kYW50LgoKUGxlYXNlIGNvbnNpZGVyIHJldmll
d2luZyBhbmQgYWRqdXN0aW5nIHRoZSBjYXBhYmlsaXR5IGNoZWNrcyBpbiB0aGUgbWVudGlvbmVk
IGFjY2VzcyBmdW5jdGlvbnMgZm9yIGJldHRlciBhbGlnbm1lbnQgd2l0aCB0aGUgVUdPIHBlcm1p
c3Npb25zLgoKVGhhbmsgeW91IGZvciB5b3VyIGF0dGVudGlvbiB0byB0aGlzIG1hdHRlci4KCkJl
c3QgcmVnYXJkcywKSmluZ3ppIE1lbmc=

