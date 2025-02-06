Return-Path: <linux-fsdevel+bounces-41051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD911A2A567
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A7B166202
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF122619D;
	Thu,  6 Feb 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="Ujp/jdWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D42253F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836026; cv=none; b=Tf8cjHy3Y7bLEteg/+mrgw7qxtBni9ljy0rIpgDVEtrcSi5G/GmPRLHAsu+pUY20dOvmcd6MNslxHtzHiVeMYZevUrjtl2ozrPhEUemIXzFhHTd/ptumk4iR5KN8C2ZKRFf5Tsqz70mo5TgpUTBv/d3sTxuu5XhMANKXL1xbdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836026; c=relaxed/simple;
	bh=Of5A+G8sdWDfz+zrx7EDIxmehXI4NK589ZgoS/GMUDU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fWceVYeacfNC7E0H4yPnnE9Dyec9fcdThOCESEw8BwRtEMunlAgefF4mAoVy4OzLLPQ0iWApTCvuwg2OxHzQ2StMfvJJS0cxu2uDC3cl8Q9D+XPKaPrtNb69jcVP60rpP6ZV8Vj/iF1C3ZZTtslLFJJ2hObjJWay2JNynBMc6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=Ujp/jdWX; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1738835692; x=1739440492;
	i=jaltman@auristor.com; q=dns/txt; h=Content-Type:Mime-Version:
	Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:
	Message-Id:References:To; bh=dAf/Uezzq9o7A6VyZsf5tFZSMRcpAiuKGsc
	dI9VdD8c=; b=Ujp/jdWX1P9IXJD2xT73KD4Q6HrORtP/2W/EB2T4tbETy8CMwWk
	9UuFRs9Ka4VgWL16jHWZ+H+NeDwwHEHrtWpaROVNRA3JooqjPS5/5ON8Qztt+aOB
	1nfOpnyoYjmKC7O9QZGdFdR+N095oxCSS67ZT7sqM8DX0UlkRdWnoZvs=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 06 Feb 2025 04:54:52 -0500
Received: from smtpclient.apple by auristor.com (208.125.0.235) (MDaemon PRO v25.0.0d) 
	with ESMTPSA id md5001004467811.msg; Thu, 06 Feb 2025 04:54:52 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 06 Feb 2025 04:54:52 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:1e8:cc30:74b8:af7f
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Thu, 06 Feb 2025 04:54:52 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1132283e2d=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_E12BB6A8-0B65-4404-9637-08E1D4D9F4EE";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net 20/24] rxrpc: Add the security index for yfs-rxgk
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <20250203142343.248839-21-dhowells@redhat.com>
Date: Thu, 6 Feb 2025 04:54:43 -0500
Cc: netdev@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 linux-crypto@vger.kernel.org,
 linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EF4D194-76D8-4DDD-B977-2D0E4AA5D549@auristor.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
 <20250203142343.248839-21-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-MDCFSigsAdded: auristor.com


--Apple-Mail=_E12BB6A8-0B65-4404-9637-08E1D4D9F4EE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Feb 3, 2025, at 9:23=E2=80=AFAM, David Howells =
<dhowells@redhat.com> wrote:
>=20
> Add the security index and abort codes for the YFS variant of rxgk.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> fs/afs/misc.c              | 13 +++++++++++++
> include/uapi/linux/rxrpc.h | 17 +++++++++++++++++
> 2 files changed, 30 insertions(+)
>=20
> diff --git a/fs/afs/misc.c b/fs/afs/misc.c
> index b8180bf2281f..57f779804d50 100644
...
> diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
> index eac460d37598..cdf97c3f8637 100644
> --- a/include/uapi/linux/rxrpc.h
> +++ b/include/uapi/linux/rxrpc.h
> @@ -80,6 +80,7 @@ enum rxrpc_cmsg_type {
> #define RXRPC_SECURITY_RXKAD 2 /* kaserver or kerberos 4 */
> #define RXRPC_SECURITY_RXGK 4 /* gssapi-based */
> #define RXRPC_SECURITY_RXK5 5 /* kerberos 5 */
> +#define RXRPC_SECURITY_YFS_RXGK 6 /* YFS gssapi-based */
>=20
> /*
>  * RxRPC-level abort codes
> @@ -125,6 +126,22 @@ enum rxrpc_cmsg_type {
> #define RXKADDATALEN 19270411 /* user data too long */
> #define RXKADILLEGALLEVEL 19270412 /* caller not authorised to use =
encrypted conns */
>=20
> +/*
> + * RxGK GSSAPI security abort codes.
> + */
> +#define RXGK_INCONSISTENCY 1233242880 /* Security module structure =
inconsistent */
> +#define RXGK_PACKETSHORT 1233242881 /* Packet too short for security =
challenge */
> +#define RXGK_BADCHALLENGE 1233242882 /* Invalid security challenge */
> +#define RXGK_BADETYPE 1233242883 /* Invalid or impermissible =
encryption type */
> +#define RXGK_BADLEVEL 1233242884 /* Invalid or impermissible security =
level */
> +#define RXGK_BADKEYNO 1233242885 /* Key version number not found */
> +#define RXGK_EXPIRED 1233242886 /* Token has expired */
> +#define RXGK_NOTAUTH 1233242887 /* Caller not authorized */
> +#define RXGK_BAD_TOKEN 1233242888 /* Security object was passed a bad =
token */
> +#define RXGK_SEALED_INCON 1233242889 /* Sealed data inconsistent */
> +#define RXGK_DATA_LEN 1233242890 /* User data too long */
> +#define RXGK_BAD_QOP 1233242891 /* Inadequate quality of protection =
available */
> +
> /*
>  * Challenge information in the RXRPC_CHALLENGED control message.
>  */

David,

Unfortunately these are not the RXGK error code assignments used by =
YFS_RXGK.  =20
The correct assignments are documented at

  https://registrar.central.org/et/RXGK_auristorfs.html

RXGKINCONSISTENCY (1233242880L) Security module structure inconsistent
RXGKPACKETSHORT (1233242881L) Packet too short for security challenge
RXGKBADCHALLENGE (1233242882L) Security challenge/response failed
RXGKSEALEDINCON (1233242883L) Sealed data is inconsistent
RXGKNOTAUTH (1233242884L) Caller not authorised
RXGKEXPIRED (1233242885L) Authentication expired
RXGKBADLEVEL (1233242886L) Unsupported or not permitted security level
RXGKBADKEYNO (1233242887L) Bad transport key number
RXGKNOTRXGK (1233242888L) Security layer is not rxgk
RXGKUNSUPPORTED (1233242889L) Endpoint does not support rxgk
RXGKGSSERROR (1233242890L) GSSAPI mechanism error

The YFS_RXGK variant of the RXGK error table conflicts with the error =
table=20
documented in rxgk: GSSAPI based security class for RX.=20

  https://datatracker.ietf.org/doc/draft-wilkinson-afs3-rxgk/

The RXGK error table used in conjunction with the yfs-rxgk security =
class=20
predates the error table in the Internet-Draft by more than two years.

A request that OpenAFS renumber was submitted in June 2023 but has yet =
to be acted upon.

  https://gerrit.openafs.org/#/c/15467/

Sorry for the inconvenience.

Jeffrey Altman






--Apple-Mail=_E12BB6A8-0B65-4404-9637-08E1D4D9F4EE
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDHEw
ggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMB4XDTIyMDgw
NDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0EwMTQxMEQwMDAwMDE4
MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRtYW4xFTATBgNVBAoTDEF1
cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk
C7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3xHZRtv179LHKAOcsY2jIctzieMxf
82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyNfO/wJ0rX7G+ges22Dd7goZul8rPaTJBI
xbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kIEEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq
4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6
W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjGIcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAw
gYQGCCsGAQUFBwEBBHgwdjAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEIGCCsGAQUFBzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2Nl
cnRzL3RydXN0aWRjYWExMy5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYD
VR0TBAIwADCCASsGA1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIB
Fj5odHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5k
ZXguaHRtbDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJl
ZW4gaXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmlj
YXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vdmFsaWRh
dGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQYMBaBFGphbHRt
YW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2sgjAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwVeycprp8Ox1npiTyfwc5Q
aVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4cWLeQfaMrnyNeEuvHx/2CT44c
dLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYqutYF4Chkxu4KzIpq90eDMw5ajkex
w+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJoQle4wDxrdXdnIhCP7g87InXKefWgZBF4
VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXta8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRk
gIGb319a7FjslV8wggaXMIIEf6ADAgECAhBAAXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBD
b21tZXJjaWFsIFJvb3QgQ0EgMTAeFw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6i
xaNP0JKSjTd+SG5LwqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6i
qgB63OdHxBN/15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxl
g+m1Vjgno1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi
2un03bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsG
AQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3Qu
Y29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2Nv
bW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djCCASQG
A1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0dHBzOi8vc2VjdXJlLmlk
ZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMIG6BggrBgEFBQcC
AjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMgYmVlbiBpc3N1ZWQgaW4gYWNjb3Jk
YW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2VydGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0
IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20v
Y3JsL2NvbW1lcmNpYWxyb290Y2ExLmNybDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX
6Nl4a03cDHt7TLdPxCzFvDF2bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN
95jUXLdLPRToNxyaoB5s0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24
GBqqVudvPRLyMJ7u6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azN
BkfnbRq+0e88QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8Hvgn
LCBFK2s4Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXF
C9budb9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4dUsZy
Tk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJnp/BscizY
dNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eAMDGCAqYwggKi
AgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJ
RCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCgggEpMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNjA5NTQ0M1owLwYJKoZIhvcNAQkE
MSIEINpPSRSQlcIfsyMoAqOSyhZGoIPXIUgrHfLpdIR8lc/WMF0GCSsGAQQBgjcQBDFQME4wOjEL
MAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMC
EEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQAgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYD
VQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzM
MA0GCSqGSIb3DQEBCwUABIIBAEFiLcM2RpTq8Jd7tGeFzzRybqjKMcFuIinUvF1wgtY260aL91zZ
0hpvTxcER+LGsE9FF24gr5V/4sWDjt0CAX5+ga9mmeGUR9bAZ1kR1ZR0TbpN0+ne3lzOCMZND0We
vc5UufW83eDz2kKvuWaw73PWFaH50DQFK7M1VuIV4GtPZz4C26dcnJve2XOoc+mO3YQbKO7Zf/T+
E5YsoXWdlWKbFz2iBE7BRlQR7FsDMbAspcmBBwbiacN7x8NTBOMGyVPRKX6GElO7fDvI0DhodTtb
oxrWPtp4ZAmmMBuGoSic8OeY/uOI/8eKvH9+oj6z9p85C05hscBCQCbMxR2Uf7cAAAAAAAA=
--Apple-Mail=_E12BB6A8-0B65-4404-9637-08E1D4D9F4EE--


