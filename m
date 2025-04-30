Return-Path: <linux-fsdevel+bounces-47738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F7AA529A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C54C72BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED8264637;
	Wed, 30 Apr 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="sK7CSBLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1A25F980
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034015; cv=none; b=mOEdKnLWXKPBgMJAHDp7iKiQxTmwNrxn/SfyxIC2Z2Z7NJlCQWb1Y8BIunscuXVw5K1RCrdMQIRyqq0jN/Dti4pO6zjjaLjcHanTzykr+ctgYaF744T7oe/GT2qFubn14egw46epOJU/rEW2Iv9UH1uzFZoWTa14D7itzcdjtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034015; c=relaxed/simple;
	bh=JO7Dr0xzehIYZ0m9FwuBuTE91x+BobVJq3DXzbnAZIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=modIZolFxnVqszwkxVG0JiD7zYQZCPnaZiRSI/xvDoGqM2Ht/qnzPcowWx2248Wf6dwzu3JuWS9UZ/R8eau3KRO7gL33VGmDSU+7Kq1sHMT0b1mDVQosVJ64w5SrtVwvhtWN4ZnqSRqaYVOfpSF54sR40njyGOh+Wtn3lykvXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=sK7CSBLd; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=6813; t=1746033998;
	x=1746638798; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	00=3A73c=3Abb00=3Afcd9=3Ace91=3A29c5=3A5ab0]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v25.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md5001004671966
	.msg=3B=20Wed,=2030=20Apr=202025=2013=3A26=3A37=20-0400|Message-
	ID:=20<8f6bd09c-c3d8-4142-938a-3fab5df7bd64@auristor.com>|Date:=
	20Wed,=2030=20Apr=202025=2013=3A26=3A47=20-0400|MIME-Version:=20
	1.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PATC
	H]=20afs,=20bash=3A=20Fix=20open(O_CREAT)=20on=20an=20extant=20A
	FS=20file=20in=20a=0D=0A=20sticky=20dir|To:=20David=20Howells=20
	<dhowells@redhat.com>,=20chet.ramey@case.edu|Cc:=20Alexander=20V
	iro=20<viro@zeniv.linux.org.uk>,=0D=0A=20Christian=20Brauner=20<
	brauner@kernel.org>,=0D=0A=20Etienne=20Champetier=20<champetier.
	etienne@gmail.com>,=0D=0A=20Marc=20Dionne=20<marc.dionne@auristo
	r.com>,=20Steve=20French=20<sfrench@samba.org>,=0D=0A=20linux-af
	s@lists.infradead.org,=20openafs-devel@openafs.org,=0D=0A=20linu
	x-cifs@vger.kernel.org,=20linux-fsdevel@vger.kernel.org,=0D=0A=2
	0linux-kernel@vger.kernel.org|References:=20<473bad0c-9e38-4f8b-
	9939-c70c52890cd2@case.edu>=0D=0A=20<433928.1745944651@warthog.p
	rocyon.org.uk>=0D=0A=20<3d19dc03-72aa-46de-a6cc-4426cc84eb51@aur
	istor.com>=0D=0A=20<666533.1746029681@warthog.procyon.org.uk>|Co
	ntent-Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@
	auristor.com>|Organization:=20AuriStor,=20Inc.|Disposition-Notif
	ication-To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|In-R
	eply-To:=20<666533.1746029681@warthog.procyon.org.uk>|Content-Ty
	pe:=20multipart/signed=3B=20protocol=3D"application/pkcs7-signat
	ure"=3B=20micalg=3Dsha-256=3B=20boundary=3D"------------ms090706
	090601060104000504"; bh=JO7Dr0xzehIYZ0m9FwuBuTE91x+BobVJq3DXzbnA
	ZIg=; b=sK7CSBLd2c9Ov7qo8GAOsPm6baey/kn2rUEUVwDz0r0Hj3Kcllws0TWs
	C2kBJ4i4PmtT1EEAp+1yiiSmQ3RvVj0XBqCDvIlc686ZaA20vRMiyTKqArqfoIdl
	4pDbKh7xgfNEy399ieJ0jTbqG+d03xcCx32/hrYcZNhuCSptAJw=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Wed, 30 Apr 2025 13:26:38 -0400
Received: from [IPV6:2603:7000:73c:bb00:fcd9:ce91:29c5:5ab0] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v25.0.2) 
	with ESMTPSA id md5001004671966.msg; Wed, 30 Apr 2025 13:26:37 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Wed, 30 Apr 2025 13:26:37 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:fcd9:ce91:29c5:5ab0
X-MDHelo: [IPV6:2603:7000:73c:bb00:fcd9:ce91:29c5:5ab0]
X-MDArrival-Date: Wed, 30 Apr 2025 13:26:37 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1215cec780=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <8f6bd09c-c3d8-4142-938a-3fab5df7bd64@auristor.com>
Date: Wed, 30 Apr 2025 13:26:47 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a
 sticky dir
To: David Howells <dhowells@redhat.com>, chet.ramey@case.edu
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>,
 linux-afs@lists.infradead.org, openafs-devel@openafs.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <473bad0c-9e38-4f8b-9939-c70c52890cd2@case.edu>
 <433928.1745944651@warthog.procyon.org.uk>
 <3d19dc03-72aa-46de-a6cc-4426cc84eb51@auristor.com>
 <666533.1746029681@warthog.procyon.org.uk>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <666533.1746029681@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090706090601060104000504"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms090706090601060104000504
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8zMC8yMDI1IDEyOjE0IFBNLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0KPiBDaGV0IFJh
bWV5IDxjaGV0LnJhbWV5QGNhc2UuZWR1PiB3cm90ZToNCj4NCj4+IFdlbGwsIGV4Y2VwdCBm
b3IgQ01VJ3MgcmVwb3J0Lg0KPiBEbyB5b3Uga25vdyBvZiBhbnkgbGluayBmb3IgdGhhdD8g
IEknbSBndWVzc2luZyB0aGF0IGlzIGl0IHdhcyAxOTkyLCB0aGVyZSBtYXkNCj4gYmUgbm8g
b25saW5lIHJlY29yZCBvZiBpdC4NCj4NCj4gRGF2aWQNCg0KaHR0cHM6Ly9ncm91cHMuZ29v
Z2xlLmNvbS9nL2dudS5iYXNoLmJ1Zy9jLzZQUFRmT2dGZEw0L20vMkFRVS1TMU43NlVKP2hs
PWVuDQoNCg==

--------------ms090706090601060104000504
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
ggKEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQzMDE3
MjY0N1owLwYJKoZIhvcNAQkEMSIEIKgmrradZddLKUuBIQq3Xq2MxawmrOmLguxcY8hIEPgn
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
DQYJKoZIhvcNAQEBBQAEggEAhDeL20ykT0y4q2gFX9jr4F3r2S8Wx3x8dYQBPgrneguZAUem
xHsWstArk+nkY3MF9KI6qINnAOjxpHAQqzFwzXfrJmYt0ItSJHwozF0Tr1mKRzvOt2VjQcFp
DjnnLU9EyAkDaWmV3ttW+X+4AZgS8A+3/FFacaEv0I9fyvaSQ6AtDQffD56nOTy119PGlayU
b01Nl/h/8fUouPimsZfeDNjxW0KW/Wr7wri6xrag0FsyIivb8aX2Jpt15o3UhXJzmZ3ahpxQ
mW0Z/qk0aw/oOesiBB5iqNaX7OaI4j32h1z2YHE9TC9i/N7/uMOG82Gblnbs5lf3ewBn8FZd
8Xu6EgAAAAAAAA==
--------------ms090706090601060104000504--


