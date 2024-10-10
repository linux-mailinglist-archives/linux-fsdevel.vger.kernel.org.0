Return-Path: <linux-fsdevel+bounces-31560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD52998759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31451B24F7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C61C3316;
	Thu, 10 Oct 2024 13:16:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA119E7D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566185; cv=none; b=ddn6GnZnt7oR5SkiraNybwl5PzwWT44K7AzO1OB02dUqxkgZM2wHJrjiOnv+oKLuP3u5f9JUo5AMIWAk/7k8jSPqFhS9KEz1hCjd48bngu9JC3HrqjHFCbXFRouLEe6FQOf1+ymUd1tBygNrBQfk5f1Ur8O1/GHk7W8JqYxn/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566185; c=relaxed/simple;
	bh=E6uacqeixF45ugdAtEZs4daBmux+J2KkjiO1aT6eHNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nodudeJY+J8c8JgsMHns8q+DvcKkSibN8BB+a9QPyqY8qXHGhuAxqnsTiIIFDDqGh3OT9yL7/sbSy1gvto8ijWSuV8bWoJbfuEy4NOZ/XnS6HTzC7i9OEM73d8S9eRhamHW9Dt6UkKJlVgd3f3DqZyX9gfldWRMe84f4uHNxraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-fnxVz_etOa6u0sBWrM1T3Q-1; Thu, 10 Oct 2024 14:16:21 +0100
X-MC-Unique: fnxVz_etOa6u0sBWrM1T3Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 10 Oct
 2024 14:16:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 10 Oct 2024 14:16:20 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christian Brauner' <brauner@kernel.org>, Aleksa Sarai
	<cyphar@cyphar.com>, Jonathan Corbet <corbet@lwn.net>
CC: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"christian@brauner.io" <christian@brauner.io>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "oleg@redhat.com" <oleg@redhat.com>
Subject: RE: [PATCH v9] pidfd: add ioctl to retrieve pid info
Thread-Topic: [PATCH v9] pidfd: add ioctl to retrieve pid info
Thread-Index: AQHbGvgfBXWpIVKuzEWs5ASg60jgibJ/9Svg
Date: Thu, 10 Oct 2024 13:16:20 +0000
Message-ID: <f25c1e8cbad04c4fbc5b2f5e41ea6a59@AcuMS.aculab.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
 <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
 <20241010-bewilligen-wortkarg-3c1195a5fb70@brauner>
In-Reply-To: <20241010-bewilligen-wortkarg-3c1195a5fb70@brauner>
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

Li4uDQo+IHBpZGZkX2luZm8gb3ZlcndyaXRlcyB0aGUgcmVxdWVzdF9tYXNrIHdpdGggd2hhdCBp
cyBzdXBwb3J0ZWQgYnkgdGhlDQo+IGtlcm5lbC4gSSBkb24ndCB0aGluayB1c2Vyc3BhY2Ugc2V0
dGluZyByYW5kb20gc3R1ZmYgaW4gdGhlIHJlcXVlc3RfbWFzaw0KPiBpcyBhIHByb2JsZW0uIEl0
IHdvdWxkIGFscmVhZHkgYmUgYSBwcm9ibGVtIHdpdGggc3RhdHgoKSBhbmQgd2UgaGF2ZW4ndA0K
PiBzZWVuIHRoYXQgc28gZmFyLg0KDQpJIGRvbid0IHRoaW5rIGl0IGlzIHdpc2UvbmVjZXNzYXJ5
IGZvciB0aGUga2VybmVsIHRvIHNldCBiaXRzIHRoYXQNCndlcmVuJ3Qgc2V0IGluIHRoZSByZXF1
ZXN0IChmb3IgdmFsdWVzIHRoYXQgYXJlbid0IGJlaW5nIHJldHVybmVkKS4NCg0KVGhhdCB3b3Vs
ZCBsZXQgeW91IGFkZCBzb21lIG11dHVhbGx5IGV4Y2x1c2l2ZSBvcHRpb25zIHRoYXQgdXNlDQp0
aGUgc2FtZSBwYXJ0IG9mIHRoZSBidWZmZXIgYXJlYS4NCg0KPiBJZiB1c2Vyc3BhY2UgaGFwcGVu
cyB0byBzZXQgYSBzb21lIHJhbmRvbSBiaXQgaW4gdGhlIHJlcXVlc3RfbWFzayBhbmQNCj4gdGhh
dCBiaXQgZW5kcyB1cCBiZWluZyB1c2VkIGEgZmV3IGtlcm5lbCByZWxlYXNlcyBsYXRlciB0byBl
LmcuLA0KPiByZXRyaWV2ZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIHRoZW4gYWxsIHRoYXQgaGFw
cGVucyBpcyB0aGF0IHVzZXJzcGFjZQ0KPiB3b3VsZCBub3cgcmVjZWl2ZSBpbmZvcm1hdGlvbiB0
aGV5IGRpZG4ndCBuZWVkLiBUaGF0J3Mgbm90IGEgcHJvYmxlbS4NCg0KRXNwZWNpYWxseSBzaW5j
ZSB0aGUgYnVmZmVyIGlzIHVubGlrZWx5IHRvIGJlIGxhcmdlIGVub3VnaC4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==


