Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88AC444D53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 03:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKDChQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhKDChP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 22:37:15 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Nov 2021 19:34:38 PDT
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.secure-endpoints.com [IPv6:2001:470:1f07:f77:70f5:c082:a96a:5685])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D072C061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Nov 2021 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
        d=auristor.com; s=MDaemon; r=y; t=1635992962; x=1636597762;
        i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
        MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
        References:From:Organization:In-Reply-To:Content-Type; bh=87CEdR
        98Ghu4QblVfwvhG6g4XPGsU3H6UYandi0+O5M=; b=MEZrg1FNp9QqiAwKUfZIyW
        ToFtQ/x6OJsDUs3Z7L1AbGa/xotfxUB3Lp/bGmCXwXfeC/+sbB5cxMO2EOVRrTiB
        SC34WdhAni8mLewV4UvcIPsN8lEmMxUJeXGBQFVo6BpSSRk17/qTx3vxP2B84ge6
        +2Nfgn8H2P9rE3fT026j0=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 03 Nov 2021 22:29:22 -0400
Received: by auristor.com (208.125.0.235) (MDaemon PRO v21.5.0) with ESMTPSA id md5001003025058.msg; 
        Wed, 03 Nov 2021 22:29:21 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 03 Nov 2021 22:29:21 -0400
        (not processed: message from trusted or authenticated source)
X-MDRemoteIP: 50.204.136.171
X-MDArrival-Date: Wed, 03 Nov 2021 22:29:21 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=194251a06c=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <d65fda27-dd0c-a538-046b-6a599315879c@auristor.com>
Date:   Wed, 3 Nov 2021 19:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] afs: Fix ENOSPC, EDQUOT and other errors to fail a write
 rather than retrying
Content-Language: en-US
To:     "David Howells (dhowells@redhat.com)" <dhowells@redhat.com>,
        marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <163598300034.1327800.8060660349996331911.stgit@warthog.procyon.org.uk>
From:   Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <163598300034.1327800.8060660349996331911.stgit@warthog.procyon.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090301090205030704020002"
X-MDCFSigsAdded: auristor.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090301090205030704020002
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks good to me.

Reviewed-by Jeffrey Altman

On 11/3/2021 4:43 PM, David Howells (dhowells@redhat.com) wrote:
> Currently, at the completion of a storage RPC from writepages, the errors
> ENOSPC, EDQUOT, ENOKEY, EACCES, EPERM, EKEYREJECTED and EKEYREVOKED cause
> the pages involved to be redirtied and the write to be retried by the VM at
> a future time.
>
> However, this is probably not the right thing to do, and, instead, the
> writes should be discarded so that the system doesn't get blocked (though
> unmounting will discard the uncommitted writes anyway).
>
> Fix this by making afs_write_back_from_locked_page() call afs_kill_pages()
> instead of afs_redirty_pages() in those cases.
>
> EKEYEXPIRED is left to redirty the pages on the assumption that the caller
> just needs to renew their key.  Unknown errors also do that, though it
> might be better to squelch those too.
>
> This can be triggered by the generic/285 xfstest.  The writes can be
> observed in the server logs.  If a write fails with ENOSPC (ie. CODE
> 49733403, UAENOSPC) because a file is made really large, e.g.:
>
> Wed Nov 03 23:21:35.794133 2021 [1589] EVENT YFS_SRX_StData CODE 49733403 NAME --UnAuth-- HOST [192.168.1.2]:7001 ID 32766 FID 1048664:0.172306:30364251 UINT64 17592187027456 UINT64 65536 UINT64 17592187092992 UINT64 0
>
> this should be seen once and not repeated.
>
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeffrey E Altman <jaltman@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/write.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 8b1d9c2f6bec..04f3f87b15cb 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -620,22 +620,18 @@ static ssize_t afs_write_back_from_locked_page(struct address_space *mapping,
>  	default:
>  		pr_notice("kAFS: Unexpected error from FS.StoreData %d\n", ret);
>  		fallthrough;
> -	case -EACCES:
> -	case -EPERM:
> -	case -ENOKEY:
>  	case -EKEYEXPIRED:
> -	case -EKEYREJECTED:
> -	case -EKEYREVOKED:
>  		afs_redirty_pages(wbc, mapping, start, len);
>  		mapping_set_error(mapping, ret);
>  		break;
>  
> +	case -EACCES:
> +	case -EPERM:
> +	case -ENOKEY:
> +	case -EKEYREJECTED:
> +	case -EKEYREVOKED:
>  	case -EDQUOT:
>  	case -ENOSPC:
> -		afs_redirty_pages(wbc, mapping, start, len);
> -		mapping_set_error(mapping, -ENOSPC);
> -		break;
> -
>  	case -EROFS:
>  	case -EIO:
>  	case -EREMOTEIO:
>
>

--------------ms090301090205030704020002
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DGswggXSMIIEuqADAgECAhBAAW0B1qVVQ32wvx2EXYU6MA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEy
MB4XDTE5MDkwNTE0MzE0N1oXDTIyMTEwMTE0MzE0N1owcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEMwMDAwMDE2RDAxRDZBNTQwMDAwMDQ0NDcxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCY1TC9QeWnUgEoJ81FcAVnhGn/AWuzvkYRUG5/ZyXDdaM212e8
ybCklgSmZweqNdrfaaHXk9vwjpvpD4YWgb07nJ1QBwlvRV/VPAaDdneIygJJWBCzaMVLttKO
0VimH/I/HUwFBQT2mrktucCEf2qogdi2P+p5nuhnhIUiyZ71Fo43gF6cuXIMV/1rBNIJDuwM
Q3H8zi6GL0p4mZFZDDKtbYq2l8+MNxFvMrYcLaJqejQNQRBuZVfv0Fq9pOGwNLAk19baIw3U
xdwx+bGpTtS63Py1/57MQ0W/ZXE/Ocnt1qoDLpJeZIuEBKgMcn5/iN9+Ro5zAuOBEKg34wBS
8QCTAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
Mi5wN2MwHwYDVR0jBBgwFoAUpHPa72k1inXMoBl7CDL4a4nkQuwwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTIuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBR7pHsvL4H5GdzNToI9e5BuzV19
bzAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAFlm
JYk4Ff1v/n0foZkv661W4LCRtroBaVykOXetrDDOQNK2N6JdTa146uIZVgBeU+S/0DLvJBKY
tkUHQ9ovjXJTsuCBmhIIw3YlHoFxbku0wHEpXMdFUHV3tUodFJJKF3MbC8j7dOMkag59/Mdz
Sjszdvit0av9nTxWs/tRKKtSQQlxtH34TouIke2UgP/Nn901QLOrJYJmtjzVz8DW3IYVxfci
SBHhbhJTdley5cuEzphELo5NR4gFjBNlxH7G57Hno9+EWILpx302FJMwTgodIBJbXLbPMHou
xQbOL2anOTUMKO8oH0QdQHCtC7hpgoQa7UJYJxDBI+PRaQ/HObkwggaRMIIEeaADAgECAhEA
+d5Wf8lNDHdw+WAbUtoVOzANBgkqhkiG9w0BAQsFADBKMQswCQYDVQQGEwJVUzESMBAGA1UE
ChMJSWRlblRydXN0MScwJQYDVQQDEx5JZGVuVHJ1c3QgQ29tbWVyY2lhbCBSb290IENBIDEw
HhcNMTUwMjE4MjIyNTE5WhcNMjMwMjE4MjIyNTE5WjA6MQswCQYDVQQGEwJVUzESMBAGA1UE
ChMJSWRlblRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExMjCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANGRTTzPCic0kq5L6ZrUJWt5LE/n6tbPXPhGt2Egv7plJMoEpvVJ
JDqGqDYymaAsd8Hn9ZMAuKUEFdlx5PgCkfu7jL5zgiMNnAFVD9PyrsuF+poqmlxhlQ06sFY2
hbhQkVVQ00KCNgUzKcBUIvjv04w+fhNPkwGW5M7Ae5K5OGFGwOoRck9GG6MUVKvTNkBw2/vN
MOd29VGVTtR0tjH5PS5yDXss48Yl1P4hDStO2L4wTsW2P37QGD27//XGN8K6amWB6F2XOgff
/PmlQjQOORT95PmLkwwvma5nj0AS0CVp8kv0K2RHV7GonllKpFDMT0CkxMQKwoj+tWEWJTiD
KSsCAwEAAaOCAoAwggJ8MIGJBggrBgEFBQcBAQR9MHswMAYIKwYBBQUHMAGGJGh0dHA6Ly9j
b21tZXJjaWFsLm9jc3AuaWRlbnRydXN0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDovL3ZhbGlk
YXRpb24uaWRlbnRydXN0LmNvbS9yb290cy9jb21tZXJjaWFscm9vdGNhMS5wN2MwHwYDVR0j
BBgwFoAU7UQZwNPwBovupHu+QucmVMiONnYwDwYDVR0TAQH/BAUwAwEB/zCCASAGA1UdIASC
ARcwggETMIIBDwYEVR0gADCCAQUwggEBBggrBgEFBQcCAjCB9DBFFj5odHRwczovL3NlY3Vy
ZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDADAgEB
GoGqVGhpcyBUcnVzdElEIENlcnRpZmljYXRlIGhhcyBiZWVuIGlzc3VlZCBpbiBhY2NvcmRh
bmNlIHdpdGggSWRlblRydXN0J3MgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBQb2xpY3kgZm91bmQg
YXQgaHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3Rz
L2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRy
dXN0LmNvbS9jcmwvY29tbWVyY2lhbHJvb3RjYTEuY3JsMB0GA1UdJQQWMBQGCCsGAQUFBwMC
BggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFKRz2u9pNYp1zKAZewgy+GuJ
5ELsMA0GCSqGSIb3DQEBCwUAA4ICAQAN4YKu0vv062MZfg+xMSNUXYKvHwvZIk+6H1pUmivy
DI4I6A3wWzxlr83ZJm0oGIF6PBsbgKJ/fhyyIzb+vAYFJmyI8I/0mGlc+nIQNuV2XY8cypPo
VJKgpnzp/7cECXkX8R4NyPtEn8KecbNdGBdEaG4a7AkZ3ujlJofZqYdHxN29tZPdDlZ8fR36
/mAFeCEq0wOtOOc0Eyhs29+9MIZYjyxaPoTS+l8xLcuYX3RWlirRyH6RPfeAi5kySOEhG1qu
NHe06QIwpigjyFT6v/vRqoIBr7WpDOSt1VzXPVbSj1PcWBgkwyGKHlQUOuSbHbHcjOD8w8wH
SDbL+L2he8hNN54doy1e1wJHKmnfb0uBAeISoxRbJnMMWvgAlH5FVrQWlgajeH/6NbYbBSRx
ALuEOqEQepmJM6qz4oD2sxdq4GMN5adAdYEswkY/o0bRKyFXTD3mdqeRXce0jYQbWm7oapqS
ZBccFvUgYOrB78tB6c1bxIgaQKRShtWR1zMM0JfqUfD9u8Fg7G5SVO0IG/GcxkSvZeRjhYcb
TfqF2eAgprpyzLWmdr0mou3bv1Sq4OuBhmTQCnqxAXr4yVTRYHkp5lCvRgeJAme1OTVpVPth
/O7HJ7VuEP9GOr6kCXCXmjB4P3UJ2oU0NqfoQdcSSSt9hliALnExTEjii20B2nSDojGCAxQw
ggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMO
VHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowDQYJYIZIAWUDBAIBBQCgggGXMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEwNDAyMjkxMlow
LwYJKoZIhvcNAQkEMSIEIHmkgIXMpsuuOLU/zxuTJXLFzaDtkThCLyv91xRR/i4WMF0GCSsG
AQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UE
AxMOVHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowXwYLKoZIhvcNAQkQAgsxUKBO
MDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQg
Q0EgQTEyAhBAAW0B1qVVQ32wvx2EXYU6MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAXxf+IGKCk/Bq
oSfxpz24atSF5+0Oi+La9dD/Mbl1XOuZpeevyHEB89+xq6FdzbpZj4T1NoGqkNMcxWuO7Kem
2CZfa9S0y6FNTNafKVTSaUfgGzmDLpvZ7ykjIDuMCpr3t3kOvAf61OmKnXXWvbjKaF6ruU8G
JUVntmiPzV9blwgimYQgdHPVpptPQ8WGTH1FHQCHDdCXaRUYBUsxN37m8AtcEv9CfpVH/rSe
Uy6osJXhsmcEX9zPLZ9NXxBBSbtkI39m5E/M4t1IwlXRGKlOcE/LvkBvthQRFlsFHfxo8eo4
4RLubvV/ZLweR+ksvlx44gSvHt3k2wyvEHAuPOsfKAAAAAAAAA==
--------------ms090301090205030704020002--

