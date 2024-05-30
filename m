Return-Path: <linux-fsdevel+bounces-20552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344168D510A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BDD1F24786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C52A46B83;
	Thu, 30 May 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="cDXlyP5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A217F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090224; cv=none; b=oAxoDiQmF+VGDtKhnnj2RdlgEIKTaExzAPJuS4pxrRHJwrhzPfdgGnQureLy/sHChFfTVGknZ9uM7BZ+HCvQtw7Ga2NpGUT1FAJGigvQGgKOE7G9f5M3+c3/AKCHRpXko4AKWFgcx6B3jBabC6qGySTG++/sT1Btvdo8fb0lfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090224; c=relaxed/simple;
	bh=L9K6veD7sKVPaAzL5uqK+M8UugYM152h0JzR0PVzd4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiyDoyeL3A/UyAIE8CmhWGNzEYa45+xYmFqyBXBfU59azLU1GrnyJ9XpP1+04Vlw4Ab2ueKK3S33WajExMJA7vDmp5DfZUtLa4jjj2HI1zN7ZiMqU1utzC5x7ZOPpTXNkSZ8QjMjh6mw7BAWn2CfOrriOdX+KlAQxSFcW6vfYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=cDXlyP5P; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1717089933; x=1717694733;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:In-Reply-To:Content-Type;
	bh=Xj4Iug1vkfR3+QoksH5AW5hQCk9zUTOzuD9+R2S9AO4=; b=cDXlyP5P8QOzk
	j13OvoZTLJ25aHbhCqMWnkS67dXq860MC7DMXpRuN+ppowTg0lVU/13dZLBLX3g6
	5d1wvuv0qFLHec6YhBfvq+HpgtqLRYLuDJfGLIA/uWyDHzkxW5QBLQe3k+hBdFSS
	3wNJrce62cSpFLRbiIs9SGDCIllEHE=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 30 May 2024 13:25:33 -0400
Received: from [IPV6:2603:7000:73c:bb00:15fd:52c:fc39:4205] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v24.0.0) 
	with ESMTPSA id md5001003957175.msg; Thu, 30 May 2024 13:25:33 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 30 May 2024 13:25:33 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:15fd:52c:fc39:4205
X-MDHelo: [IPV6:2603:7000:73c:bb00:15fd:52c:fc39:4205]
X-MDArrival-Date: Thu, 30 May 2024 13:25:33 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=18808d123f=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <0609c7e9-4584-4496-9a13-09660dc16d1c@auristor.com>
Date: Thu, 30 May 2024 13:25:26 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Don't cross .backup mountpoint from backup volume
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>,
 Markus Suvanto <markus.suvanto@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stable <stable@vger.kernel.org>, David Howells <dhowells@redhat.com>
References: <768760.1716567475@warthog.procyon.org.uk>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <768760.1716567475@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080403070502040608020200"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms080403070502040608020200
Content-Type: multipart/alternative;
 boundary="------------gp08dXTAHN2AWPMDvTLVgi0A"

--------------gp08dXTAHN2AWPMDvTLVgi0A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8yNC8yMDI0IDEyOjE3IFBNLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0KPiBIaSBDaHJp
c3RpYW4sDQo+DQo+IENhbiB5b3UgcGljayB0aGlzIHVwLCBwbGVhc2U/DQo+DQo+IFRoYW5r
cywNCj4gRGF2aWQNCj4gLS0tDQo+IEZyb206IE1hcmMgRGlvbm5lPG1hcmMuZGlvbm5lQGF1
cmlzdG9yLmNvbT4NCj4NCj4gYWZzOiBEb24ndCBjcm9zcyAuYmFja3VwIG1vdW50cG9pbnQg
ZnJvbSBiYWNrdXAgdm9sdW1lDQo+DQo+IERvbid0IGNyb3NzIGEgbW91bnRwb2ludCB0aGF0
IGV4cGxpY2l0bHkgc3BlY2lmaWVzIGEgYmFja3VwIHZvbHVtZQ0KPiAodGFyZ2V0IGlzIDx2
b2w+LmJhY2t1cCkgd2hlbiBzdGFydGluZyBmcm9tIGEgYmFja3VwIHZvbHVtZS4NCj4NCj4g
SXQgaXQgbm90IHVuY29tbW9uIHRvIG1vdW50IGEgdm9sdW1lJ3MgYmFja3VwIGRpcmVjdGx5
IGluIHRoZSB2b2x1bWUNCj4gaXRzZWxmLiAgVGhpcyBjYW4gY2F1c2UgdG9vbHMgdGhhdCBh
cmUgbm90IHBheWluZyBhdHRlbnRpb24gdG8gZ2V0DQo+IGludG8gYSBsb29wIG1vdW50aW5n
IHRoZSB2b2x1bWUgb250byBpdHNlbGYgYXMgdGhleSBhdHRlbXB0IHRvDQo+IHRyYXZlcnNl
IHRoZSB0cmVlLCBsZWFkaW5nIHRvIGEgdmFyaWV0eSBvZiBwcm9ibGVtcy4NCj4NCj4gVGhp
cyBkb2Vzbid0IHByZXZlbnQgdGhlIGdlbmVyYWwgY2FzZSBvZiBsb29wcyBpbiBhIHNlcXVl
bmNlIG9mDQo+IG1vdW50cG9pbnRzLCBidXQgYWRkcmVzc2VzIGEgY29tbW9uIHNwZWNpYWwg
Y2FzZSBpbiB0aGUgc2FtZSB3YXkNCj4gYXMgb3RoZXIgYWZzIGNsaWVudHMuDQo+DQo+IFJl
cG9ydGVkLWJ5OiBKYW4gSGVucmlrIFN5bHZlc3RlcjxqYW4uaGVucmlrLnN5bHZlc3RlckB1
bmktaGFtYnVyZy5kZT4NCj4gTGluazpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBl
cm1haWwvbGludXgtYWZzLzIwMjQtTWF5LzAwODQ1NC5odG1sDQo+IFJlcG9ydGVkLWJ5OiBN
YXJrdXMgU3V2YW50bzxtYXJrdXMuc3V2YW50b0BnbWFpbC5jb20+DQo+IExpbms6aHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LWFmcy8yMDI0LUZlYnJ1YXJ5
LzAwODA3NC5odG1sDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMgRGlvbm5lPG1hcmMuZGlvbm5l
QGF1cmlzdG9yLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxsczxkaG93ZWxs
c0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogSmVmZnJleSBBbHRtYW48amFsdG1hbkBh
dXJpc3Rvci5jb20+DQo+IGNjOmxpbnV4LWFmc0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IC0t
LQ0KPiAgIGZzL2Fmcy9tbnRwdC5jIHwgICAgNSArKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL2Fmcy9tbnRwdC5jIGIv
ZnMvYWZzL21udHB0LmMNCj4gaW5kZXggOTdmNTBlOWZkOWViLi4yOTc0ODdlZTgzMjMgMTAw
NjQ0DQo+IC0tLSBhL2ZzL2Fmcy9tbnRwdC5jDQo+ICsrKyBiL2ZzL2Fmcy9tbnRwdC5jDQo+
IEBAIC0xNDAsNiArMTQwLDExIEBAIHN0YXRpYyBpbnQgYWZzX21udHB0X3NldF9wYXJhbXMo
c3RydWN0IGZzX2NvbnRleHQgKmZjLCBzdHJ1Y3QgZGVudHJ5ICptbnRwdCkNCj4gICAJCXB1
dF9wYWdlKHBhZ2UpOw0KPiAgIAkJaWYgKHJldCA8IDApDQo+ICAgCQkJcmV0dXJuIHJldDsN
Cj4gKw0KPiArCQkvKiBEb24ndCBjcm9zcyBhIGJhY2t1cCB2b2x1bWUgbW91bnRwb2ludCBm
cm9tIGEgYmFja3VwIHZvbHVtZSAqLw0KPiArCQlpZiAoc3JjX2FzLT52b2x1bWUgJiYgc3Jj
X2FzLT52b2x1bWUtPnR5cGUgPT0gQUZTVkxfQkFDS1ZPTCAmJg0KPiArCQkgICAgY3R4LT50
eXBlID09IEFGU1ZMX0JBQ0tWT0wpDQo+ICsJCQlyZXR1cm4gLUVOT0RFVjsNCj4gICAJfQ0K
PiAgIA0KPiAgIAlyZXR1cm4gMDsNCg0KUGxlYXNlIGFkZA0KDQogwqAgY2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCg0Kd2hlbiBpdCBpcyBhcHBsaWVkIHRvIHZmcy1maXhlcy4NCg0K
VGhhbmsgeW91Lg0KDQpKZWZmcmV5IEFsdG1hbg0KDQoNCg==
--------------gp08dXTAHN2AWPMDvTLVgi0A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    On 5/24/2024 12:17 PM, David Howells wrote:<br>
    <blockquote type=3D"cite"
      cite=3D"mid:768760.1716567475@warthog.procyon.org.uk">
      <pre class=3D"moz-quote-pre" wrap=3D"">Hi Christian,

Can you pick this up, please?

Thanks,
David
---
From: Marc Dionne <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:marc.=
dionne@auristor.com">&lt;marc.dionne@auristor.com&gt;</a>

afs: Don't cross .backup mountpoint from backup volume

Don't cross a mountpoint that explicitly specifies a backup volume
(target is &lt;vol&gt;.backup) when starting from a backup volume.

It it not uncommon to mount a volume's backup directly in the volume
itself.  This can cause tools that are not paying attention to get
into a loop mounting the volume onto itself as they attempt to
traverse the tree, leading to a variety of problems.

This doesn't prevent the general case of loops in a sequence of
mountpoints, but addresses a common special case in the same way
as other afs clients.

Reported-by: Jan Henrik Sylvester <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:jan.henrik.sylvester@uni-hamburg.de">&lt;jan.henrik.sylvester@=
uni-hamburg.de&gt;</a>
Link: <a class=3D"moz-txt-link-freetext" href=3D"http://lists.infradead.o=
rg/pipermail/linux-afs/2024-May/008454.html">http://lists.infradead.org/p=
ipermail/linux-afs/2024-May/008454.html</a>
Reported-by: Markus Suvanto <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:markus.suvanto@gmail.com">&lt;markus.suvanto@gmail.com&gt;</a>
Link: <a class=3D"moz-txt-link-freetext" href=3D"http://lists.infradead.o=
rg/pipermail/linux-afs/2024-February/008074.html">http://lists.infradead.=
org/pipermail/linux-afs/2024-February/008074.html</a>
Signed-off-by: Marc Dionne <a class=3D"moz-txt-link-rfc2396E" href=3D"mai=
lto:marc.dionne@auristor.com">&lt;marc.dionne@auristor.com&gt;</a>
Signed-off-by: David Howells <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:dhowells@redhat.com">&lt;dhowells@redhat.com&gt;</a>
Reviewed-by: Jeffrey Altman <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:jaltman@auristor.com">&lt;jaltman@auristor.com&gt;</a>
cc: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:linux-afs@lists.=
infradead.org">linux-afs@lists.infradead.org</a>
---
 fs/afs/mntpt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 97f50e9fd9eb..297487ee8323 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -140,6 +140,11 @@ static int afs_mntpt_set_params(struct fs_context *f=
c, struct dentry *mntpt)
 		put_page(page);
 		if (ret &lt; 0)
 			return ret;
+
+		/* Don't cross a backup volume mountpoint from a backup volume */
+		if (src_as-&gt;volume &amp;&amp; src_as-&gt;volume-&gt;type =3D=3D AFS=
VL_BACKVOL &amp;&amp;
+		    ctx-&gt;type =3D=3D AFSVL_BACKVOL)
+			return -ENODEV;
 	}
=20
 	return 0;
</pre>
    </blockquote>
    <p><font face=3D"Gill Sans MT">Please add <br>
      </font></p>
    <p><font face=3D"Gill Sans MT">=C2=A0 cc: <a class=3D"moz-txt-link-ab=
breviated" href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.org<=
/a></font></p>
    <p><font face=3D"Gill Sans MT">when it is applied to vfs-fixes.</font=
></p>
    <p><font face=3D"Gill Sans MT">Thank you.</font></p>
    <p><font face=3D"Gill Sans MT">Jeffrey Altman</font></p>
    <p><font face=3D"Gill Sans MT"><br>
      </font></p>
    <span style=3D"white-space: pre-wrap">
</span>
  </body>
</html>

--------------gp08dXTAHN2AWPMDvTLVgi0A--

--------------ms080403070502040608020200
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
MDGCAxQwggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUzMDE3
MjUyNlowLwYJKoZIhvcNAQkEMSIEIAadGvTEppigZIPnUtZptSkr2TnmCAqQkMHivL1JrqQi
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAUq7n
uq7juyjSpjKBLrR9IBFJAPTIAxFWv4Kl86FuGG0AMSQ1foWwGxyFVrBEfjpePrv1pjmZbYgR
R8ap82Fl2gUY5cqcNcOxFCnB+hAKHvsptntm0DLIKe5uvL8jT1fdS49nin14NG7dQ83dxYUI
UsGFPNpBo07px3XIrOkRfaeAWyE3h26KwsYvtSgSktAU8xdM2e2q/f39SuieZtUzbcPa85p8
6UB1BJPl3q2WiCgs6ZxgDRy7YjyQ0jZPBokwSqeleNwrdjI77hz3gpkurvogFaSSa7WJAnQt
/IbvJxhAvjR+JYt0TISCxGAvO7NsfptbZUbIt1JRh6Puu+6uYAAAAAAAAA==
--------------ms080403070502040608020200--


