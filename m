Return-Path: <linux-fsdevel+bounces-31134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547829920A6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DEE282C13
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892A18A937;
	Sun,  6 Oct 2024 19:19:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC299EAF9
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728242381; cv=none; b=Qo06LwZyEtmpIG66gEzCrE+LOu0IouBPTBTk0vgUsPYH8egC/RktUJ8qGTfodvtgW1S+Fh2gAwR8Fm5op4Faw0a+RJkxUiPejmOZEKesiEf6mIxLttbhvfk1JW76qQnVdi0g/QzXW8SLUot+5tA8kYcgwqHcb8m8Dh2QG+jLT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728242381; c=relaxed/simple;
	bh=P0pxgW7SJKSz3W9fO2eMyfpSJHxQoXy43rEN9S/zPBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Sc9Vj2bEVUV//LXyh6iIOWDNC7WuJF3gper84j24DSMZLfLa/7nYQb8drf94X2qx/LRZ7ZFXjVgxTk3qGbVNo8se4cLKOtqlXKRC7EA25HxG7W/MUlSY8szHZ884iZcB9bW5zNOlZFqfIIFV7DhOQuRY/UPT/mbCpqYfwzyckqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-234-N-eIZQ3GPKmV6aYR93tjng-1; Sun, 06 Oct 2024 20:19:36 +0100
X-MC-Unique: N-eIZQ3GPKmV6aYR93tjng-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Oct
 2024 20:18:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 6 Oct 2024 20:18:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christian Brauner' <brauner@kernel.org>, "luca.boccassi@gmail.com"
	<luca.boccassi@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	"Oleg Nesterov" <oleg@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paul@paul-moore.com" <paul@paul-moore.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] pidfd: add ioctl to retrieve pid info
Thread-Topic: [PATCH] pidfd: add ioctl to retrieve pid info
Thread-Index: AQHbFj/jg8R7YZIU5k+eh/HDOlpP2LJ6Gr4g
Date: Sun, 6 Oct 2024 19:18:43 +0000
Message-ID: <02b8bcbc23b94b249855a24059fc965f@AcuMS.aculab.com>
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <20241004-signal-erfolg-c76d6fdeee1c@brauner>
In-Reply-To: <20241004-signal-erfolg-c76d6fdeee1c@brauner>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+IEl0IHdvdWxkIG1ha2Ugc2Vuc2UgZm9yIHNlY3VyaXR5IGluZm9ybWF0aW9uIHRvIGdl
dCBhIHNlcGFyYXRlIGlvY3RsIHNvDQo+IHRoYXQgc3RydWN0IHBpZGZkX2luZm8ganVzdCByZXR1
cm4gc2ltcGxlIGFuZCBmYXN0IGluZm9ybWF0aW9uIGFuZCB0aGUNCj4gc2VjdXJpdHkgc3R1ZmYg
Y2FuIGluY2x1ZGUgdGhpbmdzIHN1Y2ggYXMgc2VjY29tcCwgY2FwcyBldGMgcHAuDQoNCldoaWNo
IGFsc28gbWVhbnMgaXQgaXMgcG9pbnRsZXNzIGhhdmluZyB0aGUgdHdvIGJpdG1hc2tzLg0KVGhl
eSBqdXN0IGNvbXBsaWNhdGUgdGhpbmdzIHVubmVjZXNzYXJpbHkuDQoNCldoYXQgeW91IG1pZ2h0
IHdhbnQgdG8gZG8gaXMgaGF2ZSB0aGUga2VybmVsIHJldHVybiB0aGUgc2l6ZQ0Kb2YgdGhlIHN0
cnVjdHVyZSBpdCB3b3VsZCBmaWxsIGluIChwcm9iYWJseSBhcyB0aGUgZmlyc3QgZmllbGQpLg0K
QWxzbyBoYXZlIHRoZSBrZXJuZWwgZmlsbCAocHJvYmFibHkgd2l0aCB6ZXJvcykgdGhlIGVuZCBv
ZiB0aGUNCnVzZXIgYnVmZmVyIGl0IGRpZG4ndCB3cml0ZSB0by4NClRoZSBpb2N0bCBpcyB0aGVu
IGFuIElPUigpIG9uZS4NCg0KTWluZCB5b3UsIGlmIHlvdSBkaWcgaW50byB0aGUgaGlzdG9yeSAo
cG9zc2libHkgb2YgU1lTViBhbmQvb3IgQlNEKQ0KeW91J2xsIGZpbmQgYSBzdHJ1Y3R1cmUgdGhl
IGtlcm5lbCBmaWxsZWQgd2l0aCB0aGUgaW5mbyAncHMnIG5lZWRzLg0KVGhlIHRleHQgYmFzZWQg
Y29kZSB0aGF0IExpbnV4IHVzZXMgaXMgcHJvYmFibHkgbW9yZSBleHRlbnNpYmxlLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K


