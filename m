Return-Path: <linux-fsdevel+bounces-50130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23AAC8652
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BDE179631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730E019D897;
	Fri, 30 May 2025 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="Vn9OUzu9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623519ADBA
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572967; cv=none; b=DrsDkfTl3XtsSW3SGEah90NeFyzZqi1+7LoxSIiPKJ9QurLmYTTQdUZlpVOmROx/h+R+owOl9x0e4wRVERoTGVYF4tRVu1MOnHyQPU147K9TSMXnYj9f22ucdomw03T41FU+J2mkFBKIxxTmbpQ5VVmkwTZCz1BoZM5txLQ6FeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572967; c=relaxed/simple;
	bh=dStwTTo/B8Zw8mRYPBDWEYe5vIRddj8W9kPoeccsU+E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NKTWth8dGneJ09QD1zX1aDMFq+QabK/9hE+5e18BrZB8oT+0LBDjdY54xPcy90V+VfJV7hXQOX8AR07+u1U2LBG0Dn3/84yPSJ2munpYc2nxlIOvp+xrnEjdmcGsWzzoIVr6YQsVYIoPnkozrUk95OsgIcFW7x1pa1fWPmcPRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=Vn9OUzu9; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=10347; t=1748572948;
	x=1749177748; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	Content-Language:Organization:In-Reply-To:Content-Type; z=Receiv
	ed:=20from=20[IPV6=3A2603=3A7000=3A73c=3Abb00=3A8d11=3A8793=3Ae5
	5a=3A9811]=20by=20auristor.com=20(IPv6=3A2001=3A470=3A1f07=3Af77
	=3Affff=3A=3A312)=20(MDaemon=20PRO=20v25.0.3a)=20=0D=0A=09with=2
	0ESMTPSA=20id=20md5001004736583.msg=3B=20Thu,=2029=20May=202025=
	2022=3A42=3A26=20-0400|Message-ID:=20<4c5227e8-fdf7-47e1-8d42-4e
	41cf2512b2@auristor.com>|Date:=20Thu,=2029=20May=202025=2022=3A4
	2=3A34=20-0400|MIME-Version:=201.0|User-Agent:=20Mozilla=20Thund
	erbird|Subject:=20Re=3A=20[PATCH=201/2]=20afs,=20bash=3A=20Fix=2
	0open(O_CREAT)=20on=20an=20extant=20AFS=20file=20in=0D=0A=20a=20
	sticky=20dir|From:=20Jeffrey=20E=20Altman=20<jaltman@auristor.co
	m>|To:=20David=20Howells=20<dhowells@redhat.com>,=0D=0A=20Christ
	ian=20Brauner=20<christian@brauner.io>|Cc:=20Marc=20Dionne=20<ma
	rc.dionne@auristor.com>,=20linux-afs@lists.infradead.org,=0D=0A=
	20linux-fsdevel@vger.kernel.org,=20linux-kernel@vger.kernel.org,
	=0D=0A=20Etienne=20Champetier=20<champetier.etienne@gmail.com>,=
	0D=0A=20Chet=20Ramey=20<chet.ramey@case.edu>,=20Cheyenne=20Wills
	=20<cwills@sinenomine.net>,=0D=0A=20Alexander=20Viro=20<viro@zen
	iv.linux.org.uk>,=0D=0A=20Christian=20Brauner=20<brauner@kernel.
	org>,=20Steve=20French=20<sfrench@samba.org>,=0D=0A=20openafs-de
	vel@openafs.org,=20linux-cifs@vger.kernel.org|References:=20<202
	50519161125.2981681-1-dhowells@redhat.com>=0D=0A=20<202505191611
	25.2981681-2-dhowells@redhat.com>=0D=0A=20<07b7e70b-29e3-46bd-91
	e3-f19eabb915c8@auristor.com>|Content-Language:=20en-US|Organiza
	tion:=20AuriStor,=20Inc.|In-Reply-To:=20<07b7e70b-29e3-46bd-91e3
	-f19eabb915c8@auristor.com>|Content-Type:=20multipart/signed=3B=
	20protocol=3D"application/pkcs7-signature"=3B=20micalg=3Dsha-256
	=3B=20boundary=3D"------------ms080401080602020600020005"; bh=dS
	twTTo/B8Zw8mRYPBDWEYe5vIRddj8W9kPoeccsU+E=; b=Vn9OUzu9KAOhBUsB5D
	uwWym188V4Hbbvu6weP0wbBqJRhiJ1rXmQhIrWPuNdZF8vGKmqwOzqI7vnbRHJRh
	od9a15puykgSsIuAcyXGbmt2QQby+hXUiiXz4O/Q/eUsvdPyuqCgErpzEkTRqX/E
	O7VyoEx0zlBhRAqK6MsLJHsSc=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Thu, 29 May 2025 22:42:28 -0400
Received: from [IPV6:2603:7000:73c:bb00:8d11:8793:e55a:9811] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v25.0.3a) 
	with ESMTPSA id md5001004736583.msg; Thu, 29 May 2025 22:42:26 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Thu, 29 May 2025 22:42:26 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:8d11:8793:e55a:9811
X-MDHelo: [IPV6:2603:7000:73c:bb00:8d11:8793:e55a:9811]
X-MDArrival-Date: Thu, 29 May 2025 22:42:26 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1245565365=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <4c5227e8-fdf7-47e1-8d42-4e41cf2512b2@auristor.com>
Date: Thu, 29 May 2025 22:42:34 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] afs, bash: Fix open(O_CREAT) on an extant AFS file in
 a sticky dir
From: Jeffrey E Altman <jaltman@auristor.com>
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Etienne Champetier <champetier.etienne@gmail.com>,
 Chet Ramey <chet.ramey@case.edu>, Cheyenne Wills <cwills@sinenomine.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Steve French <sfrench@samba.org>,
 openafs-devel@openafs.org, linux-cifs@vger.kernel.org
References: <20250519161125.2981681-1-dhowells@redhat.com>
 <20250519161125.2981681-2-dhowells@redhat.com>
 <07b7e70b-29e3-46bd-91e3-f19eabb915c8@auristor.com>
Content-Language: en-US
Organization: AuriStor, Inc.
In-Reply-To: <07b7e70b-29e3-46bd-91e3-f19eabb915c8@auristor.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080401080602020600020005"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms080401080602020600020005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8yOS8yMDI1IDg6MTEgUE0sIEplZmZyZXkgRSBBbHRtYW4gd3JvdGU6DQo+DQo+IE9u
IDUvMTkvMjAyNSAxMjoxMSBQTSwgRGF2aWQgSG93ZWxscyB3cm90ZToNCj4+ICtpbnQgYWZz
X2lzX293bmVkX2J5X21lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUg
Kmlub2RlKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IGFmc192bm9kZSAqdm5vZGUgPSBB
RlNfRlNfSShpbm9kZSk7DQo+PiArwqDCoMKgIGFmc19hY2Nlc3NfdCBhY2Nlc3M7DQo+PiAr
wqDCoMKgIHN0cnVjdCBrZXkgKmtleTsNCj4+ICvCoMKgwqAgaW50IHJldDsNCj4+ICsNCj4+
ICvCoMKgwqAga2V5ID0gYWZzX3JlcXVlc3Rfa2V5KHZub2RlLT52b2x1bWUtPmNlbGwpOw0K
Pj4gK8KgwqDCoCBpZiAoSVNfRVJSKGtleSkpDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IFBUUl9FUlIoa2V5KTsNCj4+ICsNCj4+ICvCoMKgwqAgLyogR2V0IHRoZSBhY2Nlc3Mgcmln
aHRzIGZvciB0aGUga2V5IG9uIHRoaXMgZmlsZS4gKi8NCj4+ICvCoMKgwqAgcmV0ID0gYWZz
X2NoZWNrX3Blcm1pdCh2bm9kZSwga2V5LCAmYWNjZXNzKTsNCj4+ICvCoMKgwqAgaWYgKHJl
dCA8IDApDQo+PiArwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcjsNCj4+ICsNCj4+ICvCoMKg
wqAgLyogV2UgZ2V0IHRoZSBBRE1JTklTVEVSIGJpdCBpZiB3ZSBvd24gdGhlIGZpbGUuICov
DQo+PiArwqDCoMKgIHJldCA9IChhY2Nlc3MgJiBBRlNfQUNFX0FETUlOSVNURVIpID8gMCA6
IDE7DQo+DQo+IEFGU19BQ0VfQURNSU5JU1RFUiBvbmx5IG1lYW5zIG93bmVyc2hpcCBpZiB0
aGUgaW5vZGUgaXMgYSANCj4gbm9uLWRpcmVjdG9yeS7CoCBTaG91bGQNCj4gd2UgYWRkIGFu
IGV4cGxpY2l0IGNoZWNrIGZvciBpbm9kZSB0eXBlPw0KSSB0aGluayB0aGUgYW5zd2VyIGlz
ICd5ZXMnLsKgIFRoZSBhYm92ZSBjaGVjayBkb2VzIG5vdCB3b3JrIGZvciANCmRpcmVjdG9y
eSBpbm9kZXMgc28NCndlIG5lZWQgYW5vdGhlciBtZXRob2Qgb2YgYW5zd2VyaW5nIHRoZSBx
dWVzdGlvbiBvciBpbmZvcm1pbmcgdGhlIGNhbGxlciANCnRoYXQgdGhlDQphbnN3ZXIgaXMg
dW5rbm93bi7CoCBJbiBzb21lIGNhc2VzLCBzdWNoIGFzIGNob3duKCkgYW5kIGNoZ3JwKCkg
aXRzIHNhZmUgDQp0byBzYXkgdGhlDQpjYWxsZXIgaXMgdGhlIG93bmVyIGFuZCBkZWZlciB0
aGUgZXZlbnR1YWzCoCBhY2Nlc3MgY2hlY2sgdG8gdGhlIHNlcnZlciANCndoZW4gdGhlIGlu
b2RlDQppcyBhIGRpcmVjdG9yeS7CoCDCoEhvd2V2ZXIsIHRoZXJlIGFyZSBvdGhlciBjYXNl
cyBzdWNoIGFzIGNoZWNrX3N0aWNreSgpIA0Kd2hlcmUgdGhlIHZmcw0KY2Fubm90IGRlZmVy
IHRoZSBkZWNpc2lvbiB0byB0aGUgc2VydmVyIGJlY2F1c2UgdGhlcmUgaXNuJ3QgYW4gUlBD
IHRoYXQgDQppcyBhIG9uZS10by1vbmUNCm1hdGNoIGZvciB0aGUgZGVjaXNpb24gYmVpbmcg
bWFkZS4NCg0KSW4gYWRkaXRpb24gdG8gb3duZXJzaGlwLCBvcGVyYXRpb25zIHN1Y2ggYXMg
Y2hvd24gYW5kIGNoZ3JwIG9yIGNobW9kIG1pZ2h0DQpiZSBwZXJtaXR0ZWQgaWYgdGhlIGNh
bGxlciBpcyBhIG1lbWJlciBvZiB0aGUgc3lzdGVtOmFkbWluaXN0cmF0b3JzIA0KZ3JvdXAu
wqAgVGhlDQpzZXJ2ZXIgaGFzIG5vIG1ldGhvZCBvZiBpbmZvcm1pbmcgdGhlIGNsaWVudCB0
aGF0IHRoZSB1c2VyIGlzIHNwZWNpYWwgb3IgDQp3aGF0IHJpZ2h0cw0KYXJlIGdyYW50ZWQg
ZHVlIHRvIHRoYXQgc3RhdHVzLg0KDQpJbiB0aGUgYWJzZW5jZSBvZiBleHBsaWNpdCBrbm93
bGVkZ2UsIHRoZSBvbmx5IG1ldGhvZCBieSB3aGljaCB0aGUgDQpjbGllbnQgY2FuDQphbnN3
ZXIgdGhlIHF1ZXN0aW9uIHRvZGF5IHdvdWxkIGJlIHRvIGlzc3VlIGEgUFJfV2hvQW1JIFJQ
QyB0byB0aGUgY2VsbCdzDQpQcm90ZWN0aW9uIFNlcnZpY2UgdG8gb2J0YWluIHRoZSBBRlMg
SUQgb2YgdGhlIHRhc2sncyB0b2tlbi7CoCBUaGUgQUZTIElEIA0KY291bGQgdGhlbg0KYmUg
Y29tcGFyZWQgdG8gdGhlIHN0cnVjdCBhZnNfdm5vZGUtPnN0YXR1cy5vd25lciBmaWVsZC4g
SG93ZXZlciwgDQpjbGllbnRzIG1pZ2h0DQpub3QgYmUgcGVybWl0dGVkIHRvIGNvbW11bmlj
YXRlIHdpdGggdGhlIFByb3RlY3Rpb24gU2VydmljZSBhbmQgUFJfV2hvQW1JIGlzDQpjdXJy
ZW50bHkgb25seSBhdmFpbGFibGUgZnJvbSB0aGUgQXVyaVN0b3JGUyBQcm90ZWN0aW9uIFNl
cnZpY2UuIA0KIMKgUFJfV2hvQW1JIGlzDQpzdGFuZGFyZGl6ZWQgZm9yIGltcGxlbWVudGF0
aW9uIGJ5IE9wZW5BRlMgYnV0IGF0IHByZXNlbnQgbmVpdGhlciBPcGVuQUZTDQoxLjgueCBu
b3IgMS45LnggaW5jbHVkZSBhbiBpbXBsZW1lbnRhdGlvbi4NCg0KSXQgc2hvdWxkIGJlIG5v
dGVkIHRoYXQgYWx0aG91Z2ggYW4gQUZTIElEIGlzIHByb3ZpZGVkIHRvIHRoZSBhZnMgY2xp
ZW50IA0Kd2hlbiBhbg0KcnhrYWQgdG9rZW4gaXMgaW5zZXJ0ZWQgaW50byB0aGUga2VybmVs
LCB0aGUgcHJvdmlkZWQgdmFsdWUgY2Fubm90IGJlIA0KdHJ1c3RlZCBhbmQNCm11c3Qgbm90
IGJlIHVzZWQgZm9yIHRoaXMgcHVycG9zZS4NCg0KPg0KPj4gK2Vycm9yOg0KPj4gK8KgwqDC
oCBrZXlfcHV0KGtleSk7DQo+PiArwqDCoMKgIHJldHVybiByZXQ7DQo+PiArfQ0KVG8gYWRk
cmVzcyB0aGUgbW9zdCB1cmdlbnQgbmVlZCB3aGljaCBpcyB0aGUgbWF5X2NyZWF0ZV9pbl9z
dGlja3koKSANCmNhbGwsIHBlcmhhcHMNCmludHJvZHVjZSBhIG5vbi1kaXJlY3Rvcnkgc3Bl
Y2lmaWMgaXNfZmlsZV9pbm9kZV9vd25lZF9ieV9tZSgpIGFzIHBhcnQgDQpvZiB0aGlzDQpj
aGFuZ2UgYW5kIHRoZW4gYWRkcmVzcyB0aGUgZGlyZWN0b3J5IGNhc2Ugb25jZSB3ZSBmaWd1
cmUgb3V0IGhvdyB0byANCmltcGxlbWVudA0KaXQuDQoNCkplZmZyZXkgQWx0bWFuDQo=

--------------ms080401080602020600020005
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DHEwggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEz
MB4XDTIyMDgwNDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEQwMDAwMDE4MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCkC7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3
xHZRtv179LHKAOcsY2jIctzieMxf82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyN
fO/wJ0rX7G+ges22Dd7goZul8rPaTJBIxbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kI
EEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg
9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjG
IcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
My5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2s
gjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwV
eycprp8Ox1npiTyfwc5QaVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4c
WLeQfaMrnyNeEuvHx/2CT44cdLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYq
utYF4Chkxu4KzIpq90eDMw5ajkexw+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJo
Qle4wDxrdXdnIhCP7g87InXKefWgZBF4VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXt
a8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRkgIGb319a7FjslV8wggaXMIIEf6ADAgECAhBA
AXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUAMEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBDb21tZXJjaWFsIFJvb3QgQ0EgMTAe
Fw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6ixaNP0JKSjTd+SG5L
wqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6iqgB63OdHxBN/
15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxlg+m1Vjgn
o1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi2un0
3bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkG
CCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29t
L3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djCCASQGA1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0
dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMIG6BggrBgEFBQcCAjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMg
YmVlbiBpc3N1ZWQgaW4gYWNjb3JkYW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2Vy
dGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20v
Y2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0
dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY3JsL2NvbW1lcmNpYWxyb290Y2ExLmNy
bDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX6Nl4a03cDHt7TLdPxCzFvDF2
bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN95jUXLdLPRToNxyaoB5s
0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24GBqqVudvPRLyMJ7u
6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azNBkfnbRq+0e88
QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8HvgnLCBFK2s4
Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXFC9bu
db9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4d
UsZyTk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJn
p/BscizYdNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eA
MDGCBAEwggP9AgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggKEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUzMDAy
NDIzNVowLwYJKoZIhvcNAQkEMSIEIO81bcExSk0n7IWW6Cz7Z5y+JdvlLmjkysEeL1Syg2O0
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMIIBVwYJKoZIhvcNAQkPMYIBSDCCAUQw
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBggqhkiG9w0DAgIBBTAN
BggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAHBgUrDgMCGjALBglghkgB
ZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgQwCwYJYIZIAWUD
BAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQMEAgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3DQEB
ATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgGBiuBBAELATAIBgYrgQQBCwIwCAYGK4EEAQsD
MAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYGK4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMw
DQYJKoZIhvcNAQEBBQAEggEAKlcmHrVCTax/+AeF9IpiAg8tqhTjMeGZB5VqnGCLE/GZXBpl
AQECAVYInECkZLldPL0dNAE+H2ZCDNc6yfwUFVP9TNUTZkHIENVWqumuCr6VvCdyF4lfZinO
+l58jhxNP/wDV9CdN0MJJkEn8N/Z5YngFhDom2XUfP6No6q58o0eNFbiejpqe3j0fGUhotaQ
D/ZfVORwZJ/o1N6nl9g1IAGNuDE0mGbr7MtN26jPoRlwdl4+l3j6+AcSjeXlJcI3GZvx8sRo
P4fXjGQ/w9fbyV2aHwOyGkHhtaxOdpjIJ5bhWVRgZoum4+9tp0gsXiIoOlxGozcZ5ynzzsdl
jTvJnAAAAAAAAA==
--------------ms080401080602020600020005--


