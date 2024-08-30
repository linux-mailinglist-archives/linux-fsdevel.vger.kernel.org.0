Return-Path: <linux-fsdevel+bounces-27969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5496558D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F251F23B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3B13777E;
	Fri, 30 Aug 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="kKyaOBzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F95481AB;
	Fri, 30 Aug 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987306; cv=none; b=AuCE6C94DLlTJzFctEchmx+kmC4dcg0plStIQLjt/6+h6LlpUC1Sb3Qk20W48y/BGCD9bj4Jxbg9nznK5c+3jY/5tPxHaoKC+7x+Uhl6Ldsn8F4oVbyeYC7XkgepzxN9fSI7/zFry9pxTIJy10ildjBfLnlGe8dMKAwbMSwaojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987306; c=relaxed/simple;
	bh=5ixJunBE8y+Kj6i0hhw2cohe7nD9zRu7+vWcZYif9aE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Olm5WSlpu22w3lFAZ/ljPFiwNYkCUdEFocAYqNKga0ufEpJH4z1gSCakYse/Yx2K9Pl2hwzpaSprT8J1F26j0g7SEwVfzuMMR52CmKLtf8W/0TvUhWGLW/MPefsGKXPNF5HTh0mJXB7/ePuWSgLOtpTM8iMoYEjY09XWTinxB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=kKyaOBzY reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9MmQwQUdKpfDgkcA2ZVUpT1iPlD+2kyrSpDicx4p2XY=; b=k
	KyaOBzYjECnaq5WD6UFIriD46uoAz7pwBXhNRy/qu6Fvz06AcaYtbGlQlGUOV7eH
	19t/SSBbWaO7Y3BO5w2OYApiB52kkAc3R3Kx5T5m/t0NnBfJioHOWbB2mhNl6ZTa
	oqbYETBHosmFy9Lw/XmTTZzpRB/yBmA880eenFPhyQ=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Fri, 30 Aug 2024 11:08:10 +0800
 (CST)
Date: Fri, 30 Aug 2024 11:08:10 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re:Re: [BUG?] bcachefs: keep writing to device when there is no
 high-level I/O activity.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <y336p7vehwl6rpi5lfht6znaosnaqk3tvigzxcda7oi6ukk3o4@p4imj4wzcxjb>
References: <20240827094933.6363-1-00107082@163.com>
 <y336p7vehwl6rpi5lfht6znaosnaqk3tvigzxcda7oi6ukk3o4@p4imj4wzcxjb>
X-NTES-SC: AL_Qu2ZBvWTuEoi5iGcZekXn0oTju85XMCzuv8j3YJeN500oyTy/xAkZW9eNkPH+ceVNiCjoAiXQClr+vR3Z7lHQq1UOAHQbzjInozLXdfo8g3o
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51c30c17.3440.191a141321f.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD33yabN9FmVrdOAA--.58957W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQxKqmVOCh0U0wAGs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIApBdCAyMDI0LTA4LTI4IDAwOjE3OjEyLCAiS2VudCBPdmVyc3RyZWV0IiA8a2VudC5vdmVy
c3RyZWV0QGxpbnV4LmRldj4gd3JvdGU6Cj5PbiBUdWUsIEF1ZyAyNywgMjAyNCBhdCAwNTo0OToz
M1BNIEdNVCwgRGF2aWQgV2FuZyB3cm90ZToKPj4gSGksCj4+IAo+PiBJIHdhcyB1c2luZyB0d28g
cGFydGl0aW9ucyBvbiBzYW1lIG52bWUgZGV2aWNlIHRvIGNvbXBhcmUgZmlsZXN5c3RlbSBwZXJm
b3JtYW5jZSwKPj4gYW5kIEkgY29uc2lzdGFudGx5IG9ic2VydmVkIGEgc3RyYW5nZSBiZWhhdmlv
cjoKPj4gCj4+IEFmdGVyIDEwIG1pbnV0ZXMgZmlvIHRlc3Qgd2l0aCBiY2FjaGVmcyBvbiBvbmUg
cGFydGl0aW9uLCBwZXJmb3JtYW5jZSBkZWdyYWRlCj4+IHNpZ25pZmljYW50bHkgZm9yIG90aGVy
IGZpbGVzeXN0ZW1zIG9uIG90aGVyIHBhcnRpdGlvbiAoc2FtZSBkZXZpY2UpLgo+PiAKPj4gCWV4
dDQgIDE1ME0vcyAtLT4gMTQzTS9zCj4+IAl4ZnMgICAxNTBNL3MgLS0+IDEzNE0vcwo+PiAJYnRy
ZnMgMTI3TS9zIC0tPiAxMDhNL3MKPj4gCj4+IFNldmVyYWwgcm91bmQgdGVzdHMgc2hvdyB0aGUg
c2FtZSBwYXR0ZXJuIHRoYXQgYmNhY2hlZnMgc2VlbXMgb2NjdXB5IHNvbWUgZGV2aWNlIHJlc291
cmNlCj4+IGV2ZW4gd2hlbiB0aGVyZSBpcyBubyBoaWdoLWxldmVsIEkvTy4KPgo+VGhpcyBpcyBp
cyBhIGtub3duIGlzc3VlLCBpdCBzaG91bGQgYmUgZWl0aGVyIGpvdXJuYWwgcmVjbGFpbSBvcgo+
cmViYWxhbmNlLgo+Cj4oV2UgY291bGQgdXNlIHNvbWUgYmV0dGVyIHN0YXRzIHRvIHNlZSBleGFj
dGx5IHdoaWNoIGl0IGlzKQo+CgoKSSBrcHJvYmUgYmNoMl9zdWJtaXRfd2Jpb19yZXBsaWNhcyBh
bmQgdGhlbiBiY2gyX2J0cmVlX25vZGVfd3JpdGUsIGNvbmZpcm1lZCB0aGF0CnRoZSBiYWNrZ3Jv
dW5kIHdyaXRlcyB3ZXJlIGZyb20gYmNoMl9qb3VybmFsX3JlY2xhaW1fdGhyZWFkLgooQW5kIHRo
ZW4sIGJ5IHNraW1taW5nIHRoZSBjb2RlIGluIF9fYmNoMl9qb3VybmFsX3JlY2xhaW0sIEkgbm90
aWNlZCB0aG9zZSB0cmFjZV9hbmRfY291bnQgc3RhdHMpCgoKCj5UaGUgYWxnb3JpdGhtIGZvciBo
b3cgd2UgZG8gYmFja2dyb3VuZCB3b3JrIG5lZWRzIHRvIGNoYW5nZTsgSSd2ZQo+d3JpdHRlbiB1
cCBhIG5ldyBvbmUgYnV0IEknbSBhIHdheXMgb2ZmIGZyb20gaGF2aW5nIHRpbWUgdG8gaW1wbGVt
ZW50IGl0Cj4KPmh0dHBzOi8vZXZpbHBpZXBpcmF0ZS5vcmcvZ2l0L2JjYWNoZWZzLmdpdC9jb21t
aXQvP2g9YmNhY2hlZnMtZ2FyYmFnZSZpZD00N2E0YjU3NGZiNDIwYWE4MjRhYWQyMjI0MzZmNGMy
OTRkYWY2NmFlCj4KPkNvdWxkIGJlIGEgZnVuIG9uZSBmb3Igc29tZW9uZSBuZXcgdG8gdGFrZSBv
bi4KPgo+PiAKCkEgRnVuIGFuZCBzY2FyeSBvbmUuLi4uCkZvciB0aGUgaXNzdWUgaW4gdGhpcyB0
aHJlYWQsIApJIHRoaW5rICppZGxlKiBzaG91bGQgYmUgZGVmaW5lZCB0byBiZSBkZXZpY2Ugd2lk
ZToKd2hlbiBiY2FjaGVmcyBpcyBpZGxlIHdoaWxlIG90aGVyIEZTIG9uIHRoZSBzYW1lIGJsb2Nr
IGRldmljZSBpcyBidXN5LCB0aG9zZSBiYWNrZ3JvdW5kIHRocmVhZHMgc2hvdWxkIGJlIHRocm90
dGxlZCB0byBzb21lIGRlZ3JlZS4KCgpUaGFua3MKRGF2aWQKCgoK

