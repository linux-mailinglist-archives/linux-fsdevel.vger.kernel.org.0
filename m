Return-Path: <linux-fsdevel+bounces-14300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E387AA59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 16:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73061C2278C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9874654F;
	Wed, 13 Mar 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="fg3L4yud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5244C89
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343524; cv=none; b=YsfLFR6r1y7mtzsA2v5yct9OIae/J4DREymbxM7CvySk7sGrKrtIuQ8TYC0xHbm4ir62y2S8cGVAQCys5vuw0CIaeKv0ieIpTAMXcs0+hMPApWS6HRARbWCLPhzr3AxmyXG5BSYjt/hj8fIrd10S3QvtNgK5cr3s1wJp3djXJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343524; c=relaxed/simple;
	bh=u2UiTUNzRzzN+tDhfV0Ch39txOty+byM6JMOcKapi24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lr8yER9URc9VVuUck0L2FaeRVJ6+kAJU57Fy1PBgrgiQicHk/Dyg17eAWEGBKpyn7smxKbHc0GIDq1SnxWeAL6qIuFjMhGKecsKPdQrc/9mM0QAyHoUFgJNeIdG9R09aHbUaDS1vm8dzm7RMi66y2BOaAlP8YU6xv3tTJaK/yrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=fg3L4yud; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1710343267; x=1710948067;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:In-Reply-To:Content-Type;
	bh=F4Axnaki44w3H6nj7+hMRbaVtStbg/R7TWTnR0wNnhk=; b=fg3L4yudfB6gD
	KflGpB917xyt3XrT7A4H0LoH7lZj27MWH4c5H+tZh4elPS0phvC8Xw0JBhsJgeyn
	AlUWDCKk5QcYfCnygKlFYbcHR09UAFO/DiWYBgehS/FC2WTFSUB4CLWw+KhqG9Gx
	X7BFpuZfuepWfoAEY9PxV4O2zWCfYE=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 13 Mar 2024 11:21:07 -0400
Received: from [IPV6:2603:7000:73c:bb00:b062:5568:3637:7b7c] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.3) 
	with ESMTPSA id md5001003825496.msg; Wed, 13 Mar 2024 11:21:05 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 13 Mar 2024 11:21:05 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:b062:5568:3637:7b7c
X-MDHelo: [IPV6:2603:7000:73c:bb00:b062:5568:3637:7b7c]
X-MDArrival-Date: Wed, 13 Mar 2024 11:21:05 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=180268576e=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <2c15fb50-85ed-44fd-a93e-2083bea93ac5@auristor.com>
Date: Wed, 13 Mar 2024 11:20:59 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
To: Randy Dunlap <rdunlap@infradead.org>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Markus Suvanto <markus.suvanto@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3085695.1710328121@warthog.procyon.org.uk>
 <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040506040602050404040605"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms040506040602050404040605
Content-Type: multipart/alternative;
 boundary="------------q9dKyk0AdsOVZQc5k7AhoZah"

--------------q9dKyk0AdsOVZQc5k7AhoZah
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/2024 11:16 AM, Randy Dunlap wrote:
> On 3/13/24 04:08, David Howells wrote:
>>      
>> This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.
>>
>> This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
>> hiding them is that rm can't then manually delete them.
>>
>> This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: Fix
>> endless loop in directory parsing") as that's a bugfix for the above.
>>
>> Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
>> Reported-by: Markus Suvanto<markus.suvanto@gmail.com>
>> Link:https://lists.infradead.org/pipermail/linux-afs/2024-February/008102html
> Not Found
>
> The requested URL was not found on this server.

The dot before the "html" extension is missing.

--------------q9dKyk0AdsOVZQc5k7AhoZah
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 3/13/2024 11:16 AM, Randy Dunlap
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org">
      <pre class="moz-quote-pre" wrap="">On 3/13/24 04:08, David Howells wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">    
This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.

This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
hiding them is that rm can't then manually delete them.

This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: Fix
endless loop in directory parsing") as that's a bugfix for the above.

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Reported-by: Markus Suvanto <a class="moz-txt-link-rfc2396E" href="mailto:markus.suvanto@gmail.com">&lt;markus.suvanto@gmail.com&gt;</a>
Link: <a class="moz-txt-link-freetext" href="https://lists.infradead.org/pipermail/linux-afs/2024-February/008102html">https://lists.infradead.org/pipermail/linux-afs/2024-February/008102html</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Not Found

The requested URL was not found on this server.</pre>
    </blockquote>
    <p>The dot before the "html" extension is missing.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------q9dKyk0AdsOVZQc5k7AhoZah--

--------------ms040506040602050404040605
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
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMzE1
MjA1OVowLwYJKoZIhvcNAQkEMSIEIMEG7LOAjGZ5Oir+VRbiFpq8Rfd3viIXmVIAl4MfSUoQ
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAhHYb
QbAjDVIEADMVPkzq0gi05yb7+6lWFfn4bgQ3YLF6EA0oZhU5mvirNyMCDqRX8l2PlfXCiR9O
fCONTgdiMYLKA4kPGIln3T/Ti2KsSHDqrOAwqlw9rLA3pzI6fDM2JrHZ2LwLjFZJRStBeddG
virnp3HaaMrZNgWWVtgtrm85/RlexpzEG+32LIBX+FqCaDq5XW2q45p+VvI5eEcyGKMR6EuK
oSu89juC470M16iNsm8y3D6jWsU15/kaTh6NDjDMJjWLGM1z53Da6ple/VRV1UE6wpAfAO97
PV3UhDQdA3EYjuMIfhY9EG+bGdDoSKznQdzcv0vDZjHzaJhzVQAAAAAAAA==
--------------ms040506040602050404040605--


