Return-Path: <linux-fsdevel+bounces-48101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC46AA9609
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652BA7AA489
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339024887A;
	Mon,  5 May 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="ZwfGc5pT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C01F4706
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456147; cv=none; b=favGgXoy4KC4KKZChyiBdw7UYk/TkXOQwWhJGmLzDHaznxYDgCh40dySzpELgW/YtYrwMuHFyt4qdztIxwGDW9qiBOJGpvf0YLJCwvSjYwHYCNm1iZ76R3W6yUMyPFOrR4BOxtjWzeySF+q+e1KPCWhIQlsopVCIidLESdsZOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456147; c=relaxed/simple;
	bh=3cT2+t6wD8O9J/wCFfRBfvOsImBO1RIpItJ+ZpIgp0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkGDz6Bpn0N/SE7/mlf1FCutPyDQD3ZI6wTAtzB5PiNbnJwAqaHlb3PCFrFYZljIORLOQWws4FQmr3DOm5Yyi+B0qdMwpQscKVR+JuFjDCk3cf2krNdPDnYQzcPfQFFPyrxfceMun+DL4O35PLcm4Cv3hhvl9Sx+ieoXhWgyrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=ZwfGc5pT; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=10953; t=1746456124;
	x=1747060924; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	00=3A73c=3Abb00=3Af4ef=3A3a0d=3A384=3A8540]=20by=20auristor.com=
	20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=20
	PRO=20v25.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md5001004679831.
	msg=3B=20Mon,=2005=20May=202025=2010=3A42=3A03=20-0400|Message-I
	D:=20<66c958db-0408-451d-b362-fed1f56d7c6d@auristor.com>|Date:=2
	0Mon,=205=20May=202025=2010=3A42=3A10=20-0400|MIME-Version:=201.
	0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PATCH]
	=20afs,=20bash=3A=20Fix=20open(O_CREAT)=20on=20an=20extant=20AFS
	=20file=20in=20a=0D=0A=20sticky=20dir|To:=20Etienne=20Champetier
	=20<champetier.etienne@gmail.com>,=0D=0A=20Christian=20Brauner=2
	0<brauner@kernel.org>|Cc:=20David=20Howells=20<dhowells@redhat.c
	om>,=0D=0A=20Alexander=20Viro=20<viro@zeniv.linux.org.uk>,=0D=0A
	=20Marc=20Dionne=20<marc.dionne@auristor.com>,=20Chet=20Ramey=20
	<chet.ramey@case.edu>,=0D=0A=20Steve=20French=20<sfrench@samba.o
	rg>,=20linux-fsdevel@vger.kernel.org,=0D=0A=20Linux=20AFS=20mail
	ing=20list=20<linux-afs@lists.infradead.org>,=0D=0A=20linux-kern
	el@vger.kernel.org,=20linux-cifs@vger.kernel.org,=0D=0A=20"opena
	fs-devel@openafs.org"=20<openafs-devel@openafs.org>|References:=
	20<433928.1745944651@warthog.procyon.org.uk>=0D=0A=20<20250505-e
	rproben-zeltlager-4c16f07b96ae@brauner>=0D=0A=20<CAOdf3grbDQ-Fh2
	bV7XfoYvVBhgBAh7-hZyyxTNt1RfGekrA-nA@mail.gmail.com>|Content-Lan
	guage:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@auristor.
	com>|Organization:=20AuriStor,=20Inc.|Disposition-Notification-T
	o:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|In-Reply-To:=
	20<CAOdf3grbDQ-Fh2bV7XfoYvVBhgBAh7-hZyyxTNt1RfGekrA-nA@mail.gmai
	l.com>|Content-Type:=20multipart/signed=3B=20protocol=3D"applica
	tion/pkcs7-signature"=3B=20micalg=3Dsha-256=3B=20boundary=3D"---
	---------ms030105080607080803080205"; bh=3cT2+t6wD8O9J/wCFfRBfvO
	sImBO1RIpItJ+ZpIgp0o=; b=ZwfGc5pTH0/ToB/jdfv7gWHBKn9vZPsZiDErN3j
	DqnAOKu8jv3KjkHTXnfPRlWLDC03YLmrH5QxGEfZat4BLVOkniqoyxhfMydY8ysE
	4sNoBAHsZtNRavr15uv8M32d6jVqi8kFoekJuJAnzwWahhckH5TcbB9EdeRMXqz1
	lcdg=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Mon, 05 May 2025 10:42:04 -0400
Received: from [IPV6:2603:7000:73c:bb00:f4ef:3a0d:384:8540] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v25.0.2) 
	with ESMTPSA id md5001004679831.msg; Mon, 05 May 2025 10:42:03 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Mon, 05 May 2025 10:42:03 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:f4ef:3a0d:384:8540
X-MDHelo: [IPV6:2603:7000:73c:bb00:f4ef:3a0d:384:8540]
X-MDArrival-Date: Mon, 05 May 2025 10:42:03 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1220e88656=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <66c958db-0408-451d-b362-fed1f56d7c6d@auristor.com>
Date: Mon, 5 May 2025 10:42:10 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
To: Etienne Champetier <champetier.etienne@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Marc Dionne <marc.dionne@auristor.com>, Chet Ramey <chet.ramey@case.edu>,
 Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org,
 Linux AFS mailing list <linux-afs@lists.infradead.org>,
 linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
 "openafs-devel@openafs.org" <openafs-devel@openafs.org>
References: <433928.1745944651@warthog.procyon.org.uk>
 <20250505-erproben-zeltlager-4c16f07b96ae@brauner>
 <CAOdf3grbDQ-Fh2bV7XfoYvVBhgBAh7-hZyyxTNt1RfGekrA-nA@mail.gmail.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <CAOdf3grbDQ-Fh2bV7XfoYvVBhgBAh7-hZyyxTNt1RfGekrA-nA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030105080607080803080205"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms030105080607080803080205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS81LzIwMjUgMTA6MDIgQU0sIEV0aWVubmUgQ2hhbXBldGllciB3cm90ZToNCj4gSGVs
bG8sDQo+DQo+IFJlbW92aW5nIGxpc3RzLCBmZWVsIGZyZWUgdG8gYWRkIHRoZW0gYmFjaw0K
Pg0KPiBMZSBsdW4uIDUgbWFpIDIwMjUgw6AgMDk6MTQsIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IGEgw6ljcml0IDoNCj4+IFdoeSBpcyBpdCByZW1vdmVkPyBU
aGF0J3MgYSB2ZXJ5IHN0cmFuZ2UgY29tbWVudDoNCj4+DQo+PiAjaWYgMCAgIC8qIHJlcG9y
dGVkbHkgbm8gbG9uZ2VyIG5lZWRlZCAqLw0KPj4NCj4+IFNvIHRoZW4ganVzdCBkb24ndCBy
ZW1vdmUgaXQuIEkgZG9uJ3Qgc2VlIGEgcmVhc29uIGZvciB1cyB0byB3b3JrYXJvdW5kDQo+
PiB1c2Vyc3BhY2UgY3JlYXRpbmcgYSBidWcgZm9yIGl0c2VsZiBhbmQgZm9yY2luZyB1cyB0
byBhZGQgdHdvIG5ldyBpbm9kZQ0KPj4gb3BlcmF0aW9ucyB0byB3b3JrIGFyb3VuZCBpdC4N
Cj4gVGhpcyBiYXNoIHdvcmthcm91bmQgaW50cm9kdWNlZCBhZ2VzIGFnbyBmb3IgQUZTIGJ5
cGFzcyBmcy5wcm90ZWN0ZWRfcmVndWxhcg0KDQpDaGV0LCBJIGRvbid0IHRoaW5rIHRoaXMg
aGlzdG9yeSBpcyBjb3JyZWN0LsKgIFRoZSBiYXNoIHdvcmthcm91bmQgd2FzIA0KaW50cm9k
dWNlZCBpbiAxOTkyIHRvIHdvcmthcm91bmQgYSBiZWhhdmlvciB3aGVuIGFwcGVuZGluZyB0
byByZXN0cmljdGVkIA0KYWNjZXNzIGRpcmVjdG9yaWVzIHN0b3JlZCBpbiBJQk0gQUZTIDMu
MVsxXSBhbmQgdGhlIExpbnV4IGtlcm5lbCdzIA0KMzBhYmE2NjU2ZjYxZWQ0NGNiYTQ0NWEz
YzBkMzhiMjk2ZmE5ZThmNSB3YXNuJ3QgYWRkZWQgdW50aWwgMjAxOC4NCg0KSUJNIEFGUyAz
LjIgYWRkcmVzc2VkIHRoZSBuYXJyb3cgdXNlIGNhc2UgZGVzY3JpYmVkIGJ5IHRoZSBidWcg
cmVwb3J0IGJ5IA0KaW1wbGVtZW50aW5nIGEgcG90ZW50aWFsbHkgcmFjeSBjaGFuZ2UgdG8g
dGhlIEFGUyBjYWNoZSBtYW5hZ2VyIGFuZCANCmZhaWxpbmcgdG8gYWRkcmVzcyB0aGUgc2Vy
dmVyIHNpZGUuwqAgSG93ZXZlciwgdGhhdCBpcyBvdXQgb2Ygc2NvcGUgZm9yIA0KdGhpcyBk
aXNjdXNzaW9uLsKgIFRvIHRoZSBleHRlbnQgdGhhdCB0aGVyZSBpcyBhIGJ1ZyBpbiBvbmUg
b3IgbW9yZSBvZiANCnRoZSBBRlMgc2VydmVyIGltcGxlbWVudGF0aW9ucyBpdCBzaG91bGQg
YmUgZml4ZWQgdGhlcmUuDQoNClRoZSBiYXNoIGZhbGxiYWNrIGxvZ2ljIHRvIHJldHJ5IHRo
ZSBvcGVuIHdpdGhvdXQgT19DUkVBVCBpbnRyb2R1Y2VzIGEgDQpieXBhc3MgZm9yIHRoZSBr
ZXJuZWwgbW9kZSBwcm90ZWN0aW9uIHByb3ZpZGVkIGJ5IDMwYWJhNjY1NmY2MSBhbmQgDQpz
aG91bGQgYmUgcmVtb3ZlZC4NCg0KDQpDaHJpc3RpYW4sDQoNCkl0IGp1c3Qgc28gaGFwcGVu
cyB0aGF0IHRoZSB3b3JrYXJvdW5kIGFkZGVkIHRvIGJhc2ggaW4gMTk5MiBtYXNrcyBhbiAN
CmluY29tcGF0aWJpbGl0eSBpbnRyb2R1Y2VkIGJ5IDMwYWJhNjY1NmY2MSB3aGVuIHRoZSBi
YWNraW5nIGZpbGVzeXN0ZW0gDQppcyAiYWZzIiBiZWNhdXNlIHRoZSBvd25lcnNoaXAgY2hl
Y2tzIHJlcXVpcmVkIGJ5IG1heV9jcmVhdGVfaW5fc3RpY2t5KCkgDQpjYW5ub3QgYmUgcmVs
aWFibHkgcGVyZm9ybWVkIGJhc2VkIHVwb24gdGhlIGtlcm5lbCdzIGxvY2FsIGtub3dsZWRn
ZSBvZiANCnRoZSB1aWRzLsKgIE93bmVyc2hpcCBjaGVja3MgaW4gImFmcyIgYXJlIHBlcmZv
cm1lZCBieSB0aGUgZmlsZXNlcnZlcidzIA0KZXZhbHVhdGlvbiBvZiB0aGUgY2FsbGVyJ3Mg
cnhnayBvciByeGthZCBzZWN1cml0eSB0b2tlbnMgYW5kIG5vdCBieSB1c2UgDQpvZiB1aWRz
LsKgIFRoaXMgaW5jb21wYXRpYmlsaXR5IHdhcyBvbmx5IG5vdGljZWQgYWZ0ZXIgUmVkIEhh
dCBiZWdhbiANCmVuYWJsaW5nIGZzLnByb3RlY3RlZF9yZWd1bGFyIGJ5IGRlZmF1bHQgYW5k
IGJhc2ggcmVtb3ZlZCB0aGUgZmFsbGJhY2sgDQpsb2dpYyBpbiB0aGUgcHJvcG9zZWQgNS4z
IHJlbGVhc2UgY2FuZGlkYXRlcy4NCg0KVGhlIHByb3Bvc2VkIGlub2RlIG9wZXJhdGlvbnMg
YXJlIHRvIHBlcm1pdCBmaWxlc3lzdGVtcyBzdWNoIGFzIEFGUyANCndoaWNoIGNhbm5vdCBy
ZWx5IHVwb24gdGhlIGtlcm5lbCdzIGxvY2FsIHVpZCBrbm93bGVkZ2UgdG8gcGVyZm9ybSB0
aGUgDQpyZXF1aXJlZCB0aGUgb3duZXJzaGlwIGNoZWNrcyB0byBwZXJmb3JtIHRob3NlIGNo
ZWNrcyB2aWEgYW5vdGhlciANCm1lY2hhbmlzbS7CoCBJbiB0aGUgY2FzZSBvZiBBRlMsIHRo
ZSBmaWxlc2VydmVyIGFscmVhZHkgY29udmV5cyB0aGUgDQphbnN3ZXIgdG8gdGhlICJpcyBp
bm9kZSBvd25lZCBieSBtZT8iIHF1ZXN0aW9uIGFzIHBhcnQgb2YgaXRzIGRlbGl2ZXJ5IA0K
b2YgY2FsbGVyIGFjY2VzcyByaWdodHMgKEFGU0ZldGNoU3RhdHVzLkNhbGxlckFjY2Vzcyku
wqDCoCBUaGUgYW5zd2VyIHRvIA0KdGhlICJkbyB0aGVzZSB0d28gaW5vZGVzIGhhdmUgdGhl
IHNhbWUgb3duZXI/IiBxdWVzdGlvbiBjYW4gYmUgDQpkZXRlcm1pbmVkIHZpYSBjb21wYXJp
c29uIG9mIHRoZSBBRlNGZXRjaFN0YXR1cy5Pd25lciBmaWVsZHMgZm9yIGVhY2ggDQppbm9k
ZSB3aGljaCBiZWxvbmcgdG8gYSB1aWQgbmFtZXNwYWNlIHRoYXQgaXMgc3BlY2lmaWMgdGhl
IHRoZSBBRlMgY2VsbCANCmluIHdoaWNoIHRoZSBpbm9kZXMgYXJlIHN0b3JlZC7CoCBXaGVu
IHBlcmZvcm1pbmcgdGhpcyBvd25lcnNoaXAgY2hlY2sgDQpmb3IgbmV0d29yayBmaWxlc3lz
dGVtcyBJIGRvIG5vdCBiZWxpZXZlIGl0IGlzIHNhZmUgdG8gYXNzdW1lIHRoYXQgdGhlIA0K
dWlkIG5hbWVzcGFjZSBvZiB0aGUgbmV0d29yayBmaWxlc3lzdGVtIGlzIGlkZW50aWNhbCB0
byB0aGUgbG9jYWwgDQptYWNoaW5lJ3MgdWlkIG5hbWVzcGFjZS7CoCBJIHRoaW5rIGl0IHdv
dWxkIGJlIHNhZmVyIGZvciBhbGwgbmV0d29yayANCmZpbGVzeXN0ZW1zIHRvIGFuc3dlciB0
aGUgb3duZXJzaGlwIHF1ZXN0aW9ucyB1c2luZyBuZXR3b3JrIHVpZCB2YWx1ZXMgDQppbnN0
ZWFkIG9mIGxvY2FsIHVpZCB2YWx1ZXMgd2hlbiBhdmFpbGFibGUuDQoNCkknbSBhbHNvIGNv
bmNlcm5lZCBhYm91dCB1c2luZyBpZC1tYXBwZWQgdmFsdWVzIGZvciB0aGlzIGNvbXBhcmlz
b24gDQpiZWNhdXNlIHRoZXJlIGlzIG5vIHJlc3RyaWN0aW9uIHByZXZlbnRpbmcgdHdvIGRp
c3RpbmN0IGlkIHZhbHVlcyBmcm9tIA0KYmVpbmcgbWFwcGVkIHRvIHRoZSBzYW1lIGlkLg0K
DQpTaW5jZXJlbHksDQoNCkplZmZyZXkgQWx0bWFuDQoNClsxXSBodHRwczovL2dyb3Vwcy5n
b29nbGUuY29tL2cvZ251LmJhc2guYnVnL2MvNlBQVGZPZ0ZkTDQvbS8yQVFVLVMxTjc2VUoN
Cg0KDQo=

--------------ms030105080607080803080205
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
ggKEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwNTE0
NDIxMFowLwYJKoZIhvcNAQkEMSIEIHAA5mZva4vdAV/MGLJLnse2UESnQcBa6CG+1NpTB4PQ
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
DQYJKoZIhvcNAQEBBQAEggEAJO51FE9bPqnHwTGpPHOfcsrdEnPAKgrOCEhhtpUy3nzkD1UB
vGi87pLUE/quaMja5NEPBLiR7MCPZckemsaEXx7LBuT1uHEwyfX2VVbAukoJwLPeZgNdXYi8
lmg1ZQ6+YDOYXGhV/N12oWqhvBVgwyR/xyQzo4/rgTebKI+uY66riHXwAx84b2XUgDykIJL/
+8v/FLbWEfGbo4eTmOqfdgkZQwNbEklP4r6eY3w184rXXSqB2akMl9Yu9z5DEi3q34Rd5wFP
pcZcBGdkHBZHXYrbTO8pUAuFfFJ1cNgNDnkyDVBOVkl136y0PQUfTBI1VQ2BbBPA42ezPtfU
nvNkUwAAAAAAAA==
--------------ms030105080607080803080205--


