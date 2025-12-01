Return-Path: <linux-fsdevel+bounces-70327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D524AC96C7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ED23A1882
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71C305E0C;
	Mon,  1 Dec 2025 10:59:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441A3054EF;
	Mon,  1 Dec 2025 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586748; cv=none; b=geCdngnO6zn/TdjFztYTRDo8vTbqMsdExnAQsp8FaRrgwb9RjD1jOtW4/iCb6Uxh6PlwqEd/ziCdt/urvGCmwBMjGH39+ugWiEGvnO2kOi5zLboyhnsZD4wDicyZ/qsiSAi7rTio/EloQwHvh5Sh04yEEVLacrmTANVZKeXID/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586748; c=relaxed/simple;
	bh=9gSSQRzgV6m3cs0drLOlYZjsCa29WNiA32t0+SKvewM=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=YKXgWJ8cOmZn+oNsXvE/8wQUway7Q+tH5g4xOqimnFgfiNmv5dm95JAB/kScogndfo9wFpkTAw1ZP/0Vv4hXAHlNK9xUTaORy473ZbS/YQXRTpHb/dfNmMR4951J0QQ4+iuIUOqt7MMqiw5SP/H65ko77hr4sR0GAb7T51/+qEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from xujiakai2025$iscas.ac.cn ( [210.73.43.101] ) by
 ajax-webmail-APP-10 (Coremail) ; Mon, 1 Dec 2025 18:51:44 +0800 (GMT+08:00)
Date: Mon, 1 Dec 2025 18:51:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jiakai Xu" <xujiakai2025@iscas.ac.cn>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Yangtao Li" <frank.li@vivo.com>, 
	"John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, 
	"Viacheslav Dubeyko" <slava@dubeyko.com>, 2200013188@stu.pku.edu.cn
Subject: [BUG] Recursive locking deadlock in hfsplus
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <40aee9ba.3b455.19ad98a3245.Coremail.xujiakai2025@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowADnz+dBcy1p2eUFAA--.51864W
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiCQ8DCWktN6TZaAAAsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksCgpJIGRpc2NvdmVyZWQgYSByZWN1cnNpdmUgbG9ja2luZyBidWcgaW4gdGhlIGhmc3BsdXMg
ZmlsZXN5c3RlbSB0aHJvdWdoIGZ1enppbmcgCmFuZCBzdWNjZXNzZnVsbHkgcmVwcm9kdWNlZCBp
dCBvbiBMaW51eCBtYWlubGluZSAodjYuMTgpLgoKVGhlIGlzc3VlIG9jY3VycyB3aGVuIGhmc3Bs
dXNfZmlsZV9leHRlbmQoKSBob2xkcyBleHRlbnRzX2xvY2sgd2hpbGUgY2FsbGluZwpoZnNwbHVz
X2Jsb2NrX2FsbG9jYXRlKCksIHdoaWNoIG1heSB0cmlnZ2VyIEkvTyB0aGF0IHJlY3Vyc2l2ZWx5
IGNhbGxzCmhmc3BsdXNfZ2V0X2Jsb2NrKCksIHdoaWNoIHRoZW4gdHJpZXMgdG8gYWNxdWlyZSB0
aGUgc2FtZSBleHRlbnRzX2xvY2sgYWdhaW4uCgpDYWxsIGNoYWluOgogIGhmc3BsdXNfZmlsZV9l
eHRlbmQoKQogICAg4pSU4pSAIG11dGV4X2xvY2soJmFtcDtoaXAtJmd0O2V4dGVudHNfbG9jaykK
ICAgICAgIGhmc3BsdXNfYmxvY2tfYWxsb2NhdGUoKQogICAgICAgICAg4pSU4pSAIC4uLgogICAg
ICAgICAgICAg4pSU4pSAIGhmc3BsdXNfZ2V0X2Jsb2NrKCkKICAgICAgICAgICAgICAgIOKUlOKU
gCBtdXRleF9sb2NrKCZhbXA7aGlwLSZndDtleHRlbnRzX2xvY2spIOKGkCByZWN1cnNpdmUgbG9j
a2luZwoKRGV0YWlsczogaHR0cHM6Ly9naXRodWIuY29tL2oxYWthaS90ZW1wL3RyZWUvbWFpbi8y
MDI1MTIwMQoKQmVzdCByZWdhcmRzLApKaWFrYWkgWHU=

