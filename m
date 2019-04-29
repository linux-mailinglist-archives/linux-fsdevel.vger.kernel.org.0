Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAEE76F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfD2QPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 12:15:43 -0400
Received: from mail.nwra.com ([72.52.192.72]:40750 "EHLO mail.nwra.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfD2QPm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:15:42 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Apr 2019 12:15:41 EDT
Received: from barry.cora.nwra.com (inferno.cora.nwra.com [204.134.157.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.nwra.com (Postfix) with ESMTPS id A275C3405ED;
        Mon, 29 Apr 2019 09:05:59 -0700 (PDT)
Subject: Re: [PATCH] fanotify: Make wait for permission events interruptible
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     Vivek Trivedi <t.vivek@samsung.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20190321151142.17104-1-jack@suse.cz>
 <20190415095907.GA14466@quack2.suse.cz>
From:   Orion Poplawski <orion@nwra.com>
Organization: NWRA
Message-ID: <77d23991-48c0-7b87-ad49-41e505909dd7@nwra.com>
Date:   Mon, 29 Apr 2019 10:05:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415095907.GA14466@quack2.suse.cz>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060802050609060701070202"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060802050609060701070202
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/15/19 3:59 AM, Jan Kara wrote:
> On Thu 21-03-19 16:11:42, Jan Kara wrote:
>> Switch waiting for response to fanotify permission events interruptibl=
e.
>> This allows e.g. the system to be suspended while there are some
>> fanotify permission events pending (which is reportedly pretty common
>> when for example AV solution is in use). However just making the wait
>> interruptible can result in e.g. open(2) returning -EINTR where
>> previously such error code never happened in practice. To avoid
>> confusion of userspace due to this error code, return -ERESTARTNOINTR
>> instead.
>>
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>  fs/notify/fanotify/fanotify.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> Orion, can you give this patch some testing with your usecase? Also if=
 anybody
>> sees any issue with returning -ERESTARTNOINTR I have missed, please sp=
eak up.
>=20
> Ping Orion? Did you have any chance to give this patch a try? Does it f=
ix
> hibernation issues you observe without causing issues with bash and oth=
er
> programs? I'd like to queue this patch for the coming merge window but
> I'd like to see some testing results showing that it actually helps
> anything... Thanks!
>=20
> 								Honza


I've been running it for a while with mostly promising results but one
concern.  Notably, when running in conjuction with BitDefender Anti-Virus=
 I
have noticed issues when cloning large git projects (seems to be a good s=
tress
test on open()).  I believe the problems go away when BD is stopped.  At =
this
point I'm not sure if the issue lies more with BD or with the kernel patc=
h.


--=20
Orion Poplawski
Manager of NWRA Technical Systems          720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms060802050609060701070202
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CjYwggTpMIID0aADAgECAgRMDow4MA0GCSqGSIb3DQEBBQUAMIG0MRQwEgYDVQQKEwtFbnRy
dXN0Lm5ldDFAMD4GA1UECxQ3d3d3LmVudHJ1c3QubmV0L0NQU18yMDQ4IGluY29ycC4gYnkg
cmVmLiAobGltaXRzIGxpYWIuKTElMCMGA1UECxMcKGMpIDE5OTkgRW50cnVzdC5uZXQgTGlt
aXRlZDEzMDEGA1UEAxMqRW50cnVzdC5uZXQgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgKDIw
NDgpMB4XDTExMTExMTE1MzgzNFoXDTIxMTExMjAwMTczNFowgaUxCzAJBgNVBAYTAlVTMRYw
FAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlz
IGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3Qs
IEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0EwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDEMo1C0J4ZnVuQWhBMtRAAIbkHSN6uboDW/xRQBuh1r2tG
juelT63DjLD6e+AZkf3wY61xSfOoHB+rNBkgTktU6QCTvnAIMd6JU6xXvCTvKo9C1PfqlSVd
FHbSzacS+huytFxhQL1f3VebRFXYxYkZPGU9uejUpS3CLNPqgzGiCDxeWa4SLioKjF7zszGu
Cq1+7LBJCfynLiIeaGQ0nRbjpj0DMUAW95T2Sxk0yZfmIpxI3mSggwtYBZjEIkaJBf2jvvZJ
TGEDFqT4Cpkc4sDGfmkCMleQA68AlKG53M6v7/R8GM4wC8qH+NVfH1lR2IsLuTjGWMJTfNom
1NvyvZDNAgMBAAGjggEOMIIBCjAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIB
ADAzBggrBgEFBQcBAQQnMCUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLmVudHJ1c3QubmV0
MDIGA1UdHwQrMCkwJ6AloCOGIWh0dHA6Ly9jcmwuZW50cnVzdC5uZXQvMjA0OGNhLmNybDA7
BgNVHSAENDAyMDAGBFUdIAAwKDAmBggrBgEFBQcCARYaaHR0cDovL3d3dy5lbnRydXN0Lm5l
dC9ycGEwHQYDVR0OBBYEFAmRpbrp8i4qdd/Nfv53yvLea5skMB8GA1UdIwQYMBaAFFXkgdER
gL7YibkIozH5oSQJFrlwMA0GCSqGSIb3DQEBBQUAA4IBAQAKibWxMzkQsSwJee7zG22odkq0
w3jj5/8nYTTMSuzYgu4fY0rhfUV6REaqVsaATN/IdQmcYSHZPk3LoBr0kYolpXptG7lnGT8l
M9RBH2E/GCKTyD73w+kP51j0nh9O45/h1d83uvyx7YA2ZmaFJlditeJusIJq0KwjE9EXFUYJ
WXbOp3CniB5xJz4d3tnqnQiKfyuW8oubFH/KRXJPCi1bv865e+iMiEyP114JkKDnyPmAPq3B
MrJGw/3NDAzlwv1PCbeCIJK802SfBzFN9s81aTek70c/JSt7Dt+bO7JxPSfOlC57Jq1InwR/
nxuHzHodsSCQFQiuAhHTwwA9qOtHMIIFRTCCBC2gAwIBAgIQF5XJg+ffrZoAAAAATDX/LTAN
BgkqhkiG9w0BAQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4x
OTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVy
ZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVz
dCBDbGFzcyAyIENsaWVudCBDQTAeFw0xNzEyMTUxNzE3MTBaFw0yMDEyMTUxNzQ3MDBaMIGT
MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEm
MCQGA1UEChMdTm9ydGhXZXN0IFJlc2VhcmNoIEFzc29jaWF0ZXMxNTAWBgNVBAMTD09yaW9u
IFBvcGxhd3NraTAbBgkqhkiG9w0BCQEWDm9yaW9uQG53cmEuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAop24yyNf/vYlUdWtgHFHWcittcBFeMIWS5GJxcDDYSjYfHUY
hiEq8D4eMrktwirxZqnGTwMdN+RCqrnNZSR/YOsHSwpsW+9eOtAAlHMPCbaPsS+X0xxZX3VR
SdxXulwELCE6Saik1UMQ0MWHts1TwNuDrAXlvmoxCHgXSgcs4ukfNSOAs49Ol09tOt5xI5NA
Cz2sDjAiwonIm2ccuqbc5zJZiL2YOVTzOq9Aa/i38tRldTYkJH80WgnpmMZTSgGLua8kwA/u
4Lmax2VEcoRMw9zzmJav8gFNpQDbVnO3Ik2nlreJ/FX9+JmUa7zDn4FS0rT37ZJ7rOA3N968
CwBHAwIDAQABo4IBfzCCAXswDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMC
BggrBgEFBQcDBDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0
dHA6Ly93d3cuZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYX
aHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVz
dC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwu
ZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkGA1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8G
A1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLea5skMB0GA1UdDgQWBBSU5GXZh96BMn8UDBnI
wT0CYlbijTAJBgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQAj5E9g5NtdnH5bR1qKtyUG
L9Rd6BIZBrVIMoEkpXi6rRwhfeAV2cU5T/Te94+pv5JkBQfJQAakeQM+VRvSHtODHTPot12I
pX/Dm9oxhKXpWIveNjC/6Qbx+/E6iNvUGTtTTtCfwwpmyzVpUnJUN0B9XSHy78+fjJkDUIv6
byrBSC/zW0MxSd0HKtr2Do3FYZgEmFiEchDzwJeTmpJiJN/IVk/gtfJXSYQFOA0QawovCSvG
gZy/0fRY5y8h1MDWmVBRrHBRoL+ot9Q6nbhMyszvEGIVYVvWleE3Zcpu0teQ5WDv7WYs6ZZe
xIkGhIIW65NWIa1rG+UYok993UqK2FGnMYIEXzCCBFsCAQEwgbowgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEBeVyYPn362a
AAAAAEw1/y0wDQYJYIZIAWUDBAIBBQCgggJ1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTE5MDQyOTE2MDU1OFowLwYJKoZIhvcNAQkEMSIEIP6MYtuWRqGT
IOIFD2asPAZodrDoR8yq/SK0yEGfOZzkMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgcsGCSsGAQQBgjcQBDGBvTCBujCBpTELMAkG
A1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0
Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIw
MTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQ
F5XJg+ffrZoAAAAATDX/LTCBzQYLKoZIhvcNAQkQAgsxgb2ggbowgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEBeVyYPn362a
AAAAAEw1/y0wDQYJKoZIhvcNAQEBBQAEggEAO74bNtqG+QvcovOm63ccO4T9j1QHOjyr6+oA
rKyipCQeTpOOEQB+q+SNhng8pU1GvupQV/hCz2U5y7VKZ0rXAyfwZ5T5Dg1wHLEOwhzTwc9e
SOTurRZzd76Qgb1NT2lKwvea7kTQl0aL0CZZ7V5rtjrpyZ1cheRgwOkSi1rLiYC3IdpgU8jH
w0pbiZOBlVQuM7HQS2JQG6izkADTH1aLbsFKbAIEWR3fn1arKpZxc3wDeWnlsxujRGArGUVt
1rY96OQAl7uWJnnMJQwvhc5nvcyHolFxfRqFxy+MFcLuK4rwADpI0tflke+6QWuGBqgH634a
lvllpI3olUQTUjsqbAAAAAAAAA==
--------------ms060802050609060701070202--
