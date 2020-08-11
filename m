Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91873241E73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgHKQjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 12:39:33 -0400
Received: from LLMX2.LL.MIT.EDU ([129.55.12.48]:50316 "EHLO llmx2.ll.mit.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgHKQjc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:39:32 -0400
Received: from LLE2K16-MBX04.mitll.ad.local (LLE2K16-MBX04.mitll.ad.local) by llmx2.ll.mit.edu (unknown) with ESMTPS id 07BGdGUE027627; Tue, 11 Aug 2020 12:39:22 -0400
From:   "Burrow, Ryan - 0553 - MITLL" <Ryan.Burrow@ll.mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Bug fix to ELF Loader which rejects valid ELFs
Thread-Topic: [PATCH] Bug fix to ELF Loader which rejects valid ELFs
Thread-Index: AdZv7VoCntoFb81nSwCB63C55Cc9WgAJP+mAAAb2XbA=
Date:   Tue, 11 Aug 2020 16:39:20 +0000
Message-ID: <a71dc0e54ef741dfa4d5599093cb26d1@ll.mit.edu>
References: <c51feef9afbd4b82a3c718a072433a20@ll.mit.edu>
 <20200811150517.GR17456@casper.infradead.org>
In-Reply-To: <20200811150517.GR17456@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.1.84]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_06BC_01D66FDC.6E28BC60"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2006250000 definitions=main-2008110115
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------=_NextPart_000_06BC_01D66FDC.6E28BC60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Matthew Wilcox <willy@infradead.org>
> Sent: Tuesday, August 11, 2020 11:05 AM
> To: Burrow, Ryan - 0553 - MITLL <Ryan.Burrow@ll.mit.edu>
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Bug fix to ELF Loader which rejects valid ELFs
> 
> On Tue, Aug 11, 2020 at 02:44:08PM +0000, Burrow, Ryan - 0553 - MITLL
wrote:
> >  	/* Sanity check the number of program headers... */
> > -	/* ...and their total size. */
> > -	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
> > -	if (size == 0 || size > 65536 || size > ELF_MIN_ALIGN)
> > +	if (elf_ex->e_phnum == 0 || elf_ex->phnum > 65535)
> 
> umm, did you compile-test this?
> 

My apologies, I had made these edits in the context of other changes which I
didn't want to include in this patch - I replicated these changes
individually and (mistakenly) assumed I had done so correctly.

> assuming you meant e_phnum, it's a 16-bit quantity, so it can't be bigger
> than 65535.
> 
> >  		goto out;
> >
> > +	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
> 
> use array_size() here?
> 

That's a good catch - I had really just moved the previous allocation of
size down to after the check, but I'll use array_size instead. Just to
confirm the correct process, should I do an inline response with the updated
commit, or submit a new patch email?


------=_NextPart_000_06BC_01D66FDC.6E28BC60
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISUTCCA4ow
ggJyoAMCAQICAQEwDQYJKoZIhvcNAQELBQAwVjELMAkGA1UEBhMCVVMxHzAdBgNVBAoTFk1JVCBM
aW5jb2xuIExhYm9yYXRvcnkxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPTUlUTEwgUm9vdCBDQS0y
MB4XDTE2MDQyMDEyMDAwMFoXDTM1MDQxOTIzNTk1OVowVjELMAkGA1UEBhMCVVMxHzAdBgNVBAoT
Fk1JVCBMaW5jb2xuIExhYm9yYXRvcnkxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPTUlUTEwgUm9v
dCBDQS0yMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv3WoBEGOOJtm4ucvaf6vKIFP
s8watCd6Smwq/XeRNo7P3jPIxNPwF398RGDUmPJIXA7idzD6j0opFIW+kLqYye9e788PV0dqaJlX
8818fNDbSE+8B6hieqKTR7VfOI74UVQEUKVRFuRFw6uVYuvgew2Tj/C2dEee37eruQl5nHkbV2Os
WnZ7O+yt+etd6HRcaXLlP9q8WKgA3B7vkOVIMCKoAuaWj+BFq7K+WNkiyi/KdOH9JmOpbyRK4jcA
7xbLnF8JFUSNg5c4Y1BJrFaZtkCeG6Nm9p524GllkRFzPgpj8VicV+AK+9rY07dTx02kYotTnKuy
0YxBAwsUXxAQEwIDAQABo2MwYTAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBT/ycllTFOA8akM
PCGugirH7vgy+zAfBgNVHSMEGDAWgBT/ycllTFOA8akMPCGugirH7vgy+zAOBgNVHQ8BAf8EBAMC
AYYwDQYJKoZIhvcNAQELBQADggEBAHqYfEf/3J5aMKhlYQ0PnUAbMB8jZSr9/HvjfOF00crFUCfS
rqG8JQwo+S/iq66gcp62FEgJ0fQkDgVg6m+C2ETo1LoWiSxhYCfcSIQECljlXwR8wFSayF822S69
IqvHhdq4d58jU6gYi6ssjU4vwsvsVLRJKk/m/Cg/w8gW6YHM5ahBD6/5Ccel2fI7oSmskO991+ot
rC11YfDwCFvz7Am0r+K9iVhSWta4hmIuV0YBia07eZKSO02LPgQ8YOz3ku0Yt+mh8VWRKux2CcYj
Mpk+WDV0BMp75tqb6pqBFkcKvEBXqxg+8+G/umjii4H0c5kvJhaQyykbmOKmxO9IcJIwggTAMIID
qKADAgECAgEGMA0GCSqGSIb3DQEBCwUAMFYxCzAJBgNVBAYTAlVTMR8wHQYDVQQKExZNSVQgTGlu
Y29sbiBMYWJvcmF0b3J5MQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD01JVExMIFJvb3QgQ0EtMjAe
Fw0xNzAzMDIxMjAwMDBaFw0yNjAzMDIyMzU5NTlaMFExCzAJBgNVBAYTAlVTMR8wHQYDVQQKDBZN
SVQgTGluY29sbiBMYWJvcmF0b3J5MQwwCgYDVQQLDANQS0kxEzARBgNVBAMMCk1JVExMIENBLTUw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnmoMOvTkfw7nq19mrWazGaa+Q83Uv0+AT
XT3q6kr+WExIMIZ87C74WCcRXpvO7uvx7HvMsYWAFHW93wQwhjytxHIOZgKNJ4VnGVDUl+KI7g0n
9+Zjt3hB3HhHbcvbe9+Y4jz+XzCiLl2OaYvICKbxvbBSCLtPEeZQ6x6Tb6EK0ym0gvYeHO3kuuY+
SJHJMltbrLnIVLxjZrNVS77zXKvu6Q3hSdkRIB7kJgEXfL+p/z/2p94bEEZ2TnQz0TkOjG+Jq7Ul
XlFRtvsYcDPEQD3UNkZsWcXgC1hXG8TGknUcAhlGxVhlKlFLmNd7342seGy2s9YxNDnSE+eXTtb0
I5LLAgMBAAGjggGcMIIBmDASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBQv77vGDR276Wr+
rGfzBzsIdvZLWTAfBgNVHSMEGDAWgBT/ycllTFOA8akMPCGugirH7vgy+zAOBgNVHQ8BAf8EBAMC
AYYwZwYIKwYBBQUHAQEEWzBZMC4GCCsGAQUFBzAChiJodHRwOi8vY3JsLmxsLm1pdC5lZHUvZ2V0
dG8vTExSQ0EyMCcGCCsGAQUFBzABhhtodHRwOi8vb2NzcC5sbC5taXQuZWR1L29jc3AwNAYDVR0f
BC0wKzApoCegJYYjaHR0cDovL2NybC5sbC5taXQuZWR1L2dldGNybC9MTFJDQTIwgZIGA1UdIASB
ijCBhzANBgsqhkiG9xICAQMBBjANBgsqhkiG9xICAQMBCDANBgsqhkiG9xICAQMBBzANBgsqhkiG
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
ExZNSVQgTGluY29sbiBMYWJvcmF0b3J5MQ8wDQYDVQQLEwZQZW9wbGUxHzAdBgNVBAMTFkJ1cnJv
dy5SeWFuLkQuNTAwMTg4MjMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCYCXG0wovh
RV3TzscKvTrHZRkdx+GKND/IGKfhFyIf5INb2Xp02vOjQahECWcRE9DiamtP46rz4iM8qosiD1Qn
ef/JPkFI2OamVDEJiXW5qlttZTAuJvrm7uGfmsu4FRKW/7h2MkiKtxAOZqEuS3ooTJRjYxKG3Yry
g6pIr+BbTK5h1CDlOW3MGfd0asgyJP0EcAJ+G42Pkf2IDkUe+IqzUNQzCbLEDcbq6612e7W5rzm0
r0uAwgUK3g4KaORLKBzzTBnpuHzgiu8CcEagZsn/Yyj7rtcLp3Aa4BbBWCnur/MJaJB0SKR0Jdds
tIre2ndfa17VaIMdbsdROyCUCGwxAgMBAAGjggG9MIIBuTAdBgNVHQ4EFgQUrBpm5oX7JpJOeCIZ
Vwr37B0FiJUwDgYDVR0PAQH/BAQDAgUgMB8GA1UdIwQYMBaAFC/vu8YNHbvpav6sZ/MHOwh29ktZ
MDMGA1UdHwQsMCowKKAmoCSGImh0dHA6Ly9jcmwubGwubWl0LmVkdS9nZXRjcmwvbGxjYTUwZgYI
KwYBBQUHAQEEWjBYMC0GCCsGAQUFBzAChiFodHRwOi8vY3JsLmxsLm1pdC5lZHUvZ2V0dG8vbGxj
YTUwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLmxsLm1pdC5lZHUvb2NzcDA9BgkrBgEEAYI3FQcE
MDAuBiYrBgEEAYI3FQiDg+Udh+ynZoathxWD6vBFhbahHx2F69Bwg+vtIAIBZAIBCzAlBgNVHSUE
HjAcBgRVHSUABggrBgEFBQcDBAYKKwYBBAGCNwoDBDAhBgNVHREEGjAYgRZSeWFuLkJ1cnJvd0Bs
bC5taXQuZWR1MBgGA1UdIAQRMA8wDQYLKoZIhvcSAgEDAQgwJwYJKwYBBAGCNxQCBBoeGABMAEwA
VQBzAGUAcgBFAG4AYwAtAFMAVzANBgkqhkiG9w0BAQsFAAOCAQEAMBJUVnSdRA1bG5Par4EhE+p/
4t3khZTfNCA1dUA8XFS2N01q7kzAgeUMk3x2NQ7Hz0hheB/YISY0bwM07NkwfchEd/bs7ji/RvCw
n/ZMpsKSC0l9iviX++EfuDG1at/9zrXu7gQBuyuCk95P7gp33Z/AgffLVb8sqi8AUgPNqOH2EPAA
qNZzDke1zAg+eIpig+2aorVIutxTPH/JTiSZaj75NAlYCaUZ7VHL8IQpnSqRqrJPqwI9Bdd4jUIW
qmwvB6wZMqpwzO8qZn0z3WeDwd/l79nEanDsyOabK8V4Q4bzIQ2dFD0rfrxGb0TGSFqi5ENFYcnM
jnMFoRHPdytrwTGCAwowggMGAgEBMGgwUTELMAkGA1UEBhMCVVMxHzAdBgNVBAoMFk1JVCBMaW5j
b2xuIExhYm9yYXRvcnkxDDAKBgNVBAsMA1BLSTETMBEGA1UEAwwKTUlUTEwgQ0EtNQITWQAEjcvg
akRETRAewQAAAASNyzAJBgUrDgMCGgUAoIIBdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMDA4MTExNjM5MThaMCMGCSqGSIb3DQEJBDEWBBQRR2JFr7TBpgzCoUlv
DszIHcAmwTAkBgkqhkiG9w0BCQ8xFzAVMAoGCCqGSIb3DQMHMAcGBSsOAwIaMHcGCSsGAQQBgjcQ
BDFqMGgwUTELMAkGA1UEBhMCVVMxHzAdBgNVBAoMFk1JVCBMaW5jb2xuIExhYm9yYXRvcnkxDDAK
BgNVBAsMA1BLSTETMBEGA1UEAwwKTUlUTEwgQ0EtNQITWQAEbsf741RncBA/+AAAAARuxzB5Bgsq
hkiG9w0BCRACCzFqoGgwUTELMAkGA1UEBhMCVVMxHzAdBgNVBAoMFk1JVCBMaW5jb2xuIExhYm9y
YXRvcnkxDDAKBgNVBAsMA1BLSTETMBEGA1UEAwwKTUlUTEwgQ0EtNQITWQAEbsf741RncBA/+AAA
AARuxzANBgkqhkiG9w0BAQEFAASCAQCKfY4TB/2ZFMamIXy+JEMJRnxgot24bQaVvfAqSLzlPNZs
wj+N90zLn9d264j+9qARTCepYxOFgvw5QtdsNTQGaF204qdLWxKn9B4dHIRKqm7+otl0oDrAYLjJ
rqoQSpGasAe3Tkcbx+yJzDEJWUbEkqpj4ch+3GgnJLTl/ISia2Xd6Sz0hm6UMosa39HzBdpH7Ftw
HJDCc5CG+fnndB/PLnfc7csVjgy8BKHKAi3/2wlYFLDtjCYBlcSLmTOjbVCA44YY0+7prq2JOMys
3bm34j6pZGcomrEC7u3vKf5aCyIOQTVDAqzo+XzTiRhbxAOXREJSVwkTjKpLAhw6jz4oAAAAAAAA

------=_NextPart_000_06BC_01D66FDC.6E28BC60--
