Return-Path: <linux-fsdevel+bounces-894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157CE7D286D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 04:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC48B20D54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 02:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9415C6;
	Mon, 23 Oct 2023 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="AGP4QGqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F61390
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 02:16:30 +0000 (UTC)
Received: from m1345.mail.163.com (m1345.mail.163.com [220.181.13.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A1693;
	Sun, 22 Oct 2023 19:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1HW0ANDOOB5ziqCL5xX6+HVEBIq+Al/PA87Yd2ajnVI=; b=A
	GP4QGqkmQRFWOiUBBdSHwzAZQrYkAW3ZcPm+B+TMEM/oGpE5BcdxgM3Ekp3qf0hu
	CZjMk2fKBUlocUmSGtLMQ6J49Ep2HdoSp7gBJezDMn6GjebaXS21OLllOi/ESP7P
	7nZlAxmlYYshn8/FCdglDcFJzQ+cuW15V3j+Zf8wmQ=
Received: from 00107082$163.com ( [111.35.186.243] ) by ajax-webmail-wmsvr45
 (Coremail) ; Mon, 23 Oct 2023 10:16:14 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date: Mon, 23 Oct 2023 10:16:14 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Dave Chinner" <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PERFORMANCE]fs: sendfile suffer performance degradation when
 buffer size have performance impact on underling IO
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZTWn3QtTggmMHWxS@dread.disaster.area>
References: <28de01eb.208.18b4f9a0051.Coremail.00107082@163.com>
 <ZTWn3QtTggmMHWxS@dread.disaster.area>
X-NTES-SC: AL_QuySCvyZuEss4iKaZOkXn0oTju85XMCzuv8j3YJeN500hynS8DIxUkJzEFTo/d2tCQKqjSWybhFu6OVLUY53XZ09oMdV4q4C066prKtq5lz4
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <61f74c43.16f9.18b5a51868f.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:LcGowAD3vzRv1zVl0uYWAA--.56189W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiOwYRqmC5oBhZ1wAEst
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKQXQgMjAyMy0xMC0yMyAwNjo1MzoxNywgIkRhdmUgQ2hpbm5lciIgPGRhdmlkQGZyb21vcmJp
dC5jb20+IHdyb3RlOgoKPgo+T19EU1lOQyBpcyB0aGUgcHJvYmxlbSBoZXJlLgo+Cj5UaGlzIGZv
cmNlcyBhbiBJTyB0byBkaXNrIGZvciBldmVyeSB3cml0ZSBJTyBzdWJtaXNzaW9uIGZyb20KPnNl
bmRmaWxlIHRvIHRoZSBmaWxlc3lzdGVtLiBGb3Igc3luY2hyb25vdXMgSU8gKGFzIGluICJ3YWl0
aW5nIGZvcgo+Y29tcGxldGlvbiBiZWZvcmUgc2VuZGluZyB0aGUgbmV4dCBJTyksIGEgbGFyZ2Vy
IElPIHNpemUgd2lsbAo+KmFsd2F5cyogbW92ZSBkYXRhIGZhc3RlciB0byBzdG9yYWdlLgo+Cj5G
V0lXLCB5b3UnbGwgZ2V0IHRoZSBzYW1lIGJlaGF2aW91ciBpZiB5b3UgdXNlIE9fRElSRUNUIGZv
ciBlaXRoZXIKPnNvdXJjZSBvciBkZXN0aW5hdGlvbiBmaWxlIHdpdGggc2VuZGZpbGUgLSBzeW5j
aHJvbm91cyA2NGtCIElPcyBhcmUKPmEgbWFzc2l2ZSBwZXJmb3JtYW5jZSBsaW1pdGF0aW9uIGV2
ZW4gd2l0aG91dCBPX0RTWU5DLgo+Cj5JT1dzLCBkb24ndCB1c2Ugc2VuZGZpbGUgbGlrZSB0aGlz
LiBVc2UgYnVmZmVyZWQgSU8gYW5kCj5zZW5kZmlsZShmZCk7IGZkYXRhc3luYyhmZCk7IGlmIHlv
dSBuZWVkIGRhdGEgaW50ZWdyaXR5IGd1YXJhbnRlZXMKPmFuZCB5b3Ugd29uJ3Qgc2VlIGFueSBw
ZXJmIHByb2JsZW1zIHJlc3VsdGluZyBmcm9tIHRoZSBzaXplIG9mIHRoZQo+aW50ZXJuYWwgc2Vu
ZGZpbGUgYnVmZmVyLi4uLgo+Cj4tRGF2ZS4KPi0tIAo+RGF2ZSBDaGlubmVyCj5kYXZpZEBmcm9t
b3JiaXQuY29tCgpUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbiwgYW5kIFllcywgYnVmZmVyZWQg
SU8gc2hvd3Mgbm8gc2lnbmlmaWNhbnQgCnBlcmZvcm1hbmNlIGRpZmZlcmVuY2UuCkZlZWwgdGhh
dCB0aGlzIHVzYWdlIGNhdmVhdCBzaG91bGQgYmUgcmVjb3JkZWQgaW4gdGhlICJOT1RFIiBzZWN0
aW9uIG9mIG1hbiBwYWdlIGZvciBzZW5kZmlsZS4KClRoYW5rcwpEYXZpZAoKIAo=

