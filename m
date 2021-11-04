Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C701744561F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKDPSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 11:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhKDPSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:18:08 -0400
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.secure-endpoints.com [IPv6:2001:470:1f07:f77:70f5:c082:a96a:5685])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B89C06127A
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
        d=auristor.com; s=MDaemon; r=y; t=1636038928; x=1636643728;
        i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
        MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
        References:From:Organization:In-Reply-To:Content-Type; bh=HwKjf7
        WHOX86SNs2/b/Tyq0nadJz8ke0RewmsmiZfRo=; b=xFy6Qe/E5PtpTSiBktrR0X
        HsObfvuryxU/GaG8yfzc2wEc3pWQNSv/9tJNOOBzlkUt7vclA/pJriWzu4t7cLR7
        SKfVdxeJj9WWrIZ7WEU85w6JrJhhWw6jig5jr27HXVgZPUhesU9YrUA5DNJNTFBV
        gUwHS9aUxkNYmPT2D8WgQ=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 04 Nov 2021 11:15:28 -0400
Received: by auristor.com (208.125.0.235) (MDaemon PRO v21.5.0) with ESMTPSA id md5001003025231.msg; 
        Thu, 04 Nov 2021 11:15:28 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 04 Nov 2021 11:15:28 -0400
        (not processed: message from trusted or authenticated source)
X-MDRemoteIP: 50.204.136.171
X-MDArrival-Date: Thu, 04 Nov 2021 11:15:28 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=194251a06c=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <9924e31b-9f31-bf81-7a10-c95b93e2999e@auristor.com>
Date:   Thu, 4 Nov 2021 08:15:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] afs: Fix ENOSPC, EDQUOT and other errors to fail a write
 rather than retrying
Content-Language: en-US
To:     "Matthew Wilcox (willy@infradead.org)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
References: <163598300034.1327800.8060660349996331911.stgit@warthog.procyon.org.uk>
 <YYNR2t+RmtFd+bT/@casper.infradead.org>
From:   Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <YYNR2t+RmtFd+bT/@casper.infradead.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050106020304020807070302"
X-MDCFSigsAdded: auristor.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050106020304020807070302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/2021 8:22 PM, Matthew Wilcox (willy@infradead.org) wrote:
> On Wed, Nov 03, 2021 at 11:43:20PM +0000, David Howells wrote:
>> Currently, at the completion of a storage RPC from writepages, the errors
>> ENOSPC, EDQUOT, ENOKEY, EACCES, EPERM, EKEYREJECTED and EKEYREVOKED cause
>> the pages involved to be redirtied and the write to be retried by the VM at
>> a future time.
>>
>> However, this is probably not the right thing to do, and, instead, the
>> writes should be discarded so that the system doesn't get blocked (though
>> unmounting will discard the uncommitted writes anyway).
> umm.  I'm not sure that throwing away the write is the best answer
> for some of these errors.  Our whole story around error handling in
> filesystems, the page cache and the VFS is pretty sad, but I don't think
> that this is the right approach.
>
> Ideally, we'd hold onto the writes in the page cache until (eg for ENOSPC
> / EDQUOT), the user has deleted some files, then retry the writes.

Hi Matthew,

I agree that it would be desirable to avoid discarding user data but in
practice that is hard to do.  The proposed behavior change is consistent
with other Unix AFS/AuriStorFS cache manager implementations.   There
are many situations which can result in an out of quota or out of space
error where the end user has absolutely no ability to do anything about it.

An EDQUOT error might occur because the AFS volume has reached its
quota.  However, the writer only has insert privilege and cannot
delete.  The user might not even be able to list the contents of the
volume.   

An ENOSPC error might be the result of the backing store for AFS vice
partitions filling due to data being written to other AFS volumes that
the writer has no ability to access or manage.

AFS cache managers frequently implement write-on-close semantics and
will flush dirty content to the fileserver only when the file is closed
or the local cache is out-of-space.   Holding onto dirty data that
cannot be flushed to the server on a multi-user timeshare system can
result on unwanted negative impacts on other users of the system.

Another risk is that if dirty data persists locally that the
EDQUOT/ENOSPC errors will be replaced by EACCES or EPERM errors when the
associated authentication credentials expire.

If a back-off strategy is to be implemented in the future, AFS does
provide RPCs that can be used to query the volume's online status, the
maximum quota in one KiB blocks, the blocks in use, the available blocks
in the partition, and the maximum number of blocks in the partition.  
Querying RXAFS_GetVolumeStatus or RXYFS_GetVolumeStatus can avoid the
overhead of issuing a StoreData operation that is likely to fail.

Jeffrey Altman



--------------ms050106020304020807070302
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEwNDE1MTUyNVow
LwYJKoZIhvcNAQkEMSIEIAwFhtC1kfgflF4VVmenOKyuW/dcmWTu2ChogjHZTQkZMF0GCSsG
AQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UE
AxMOVHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowXwYLKoZIhvcNAQkQAgsxUKBO
MDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQg
Q0EgQTEyAhBAAW0B1qVVQ32wvx2EXYU6MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAAfryAC4SQme+
fJtrxFCsYyHKVSDGqEYmruUk5HKH3Vqs4N7Y8Bz54IRAuALOqPpaKnPPtP4mLa4BqZkZY0v5
YlKrfERbRELVSQriZP1a02ydYvq9SXCDCE2kYuhSQo3kCxRkqI/6A0/dXaFsfoRxEmInMWAZ
IEx+iH9gTUM6IMcy2snxosoBPGHNUH9W5xrwMLOdiSEgJR2vNljs3ZvvDij3pSOMusJWQpfA
VgVD8y9ikLccffW2gMNlHK0zO6t+o0202q3CVXcV6mJl48YUOII1Pst0vUER3/wIH5ouzUID
rrFU3JNqyxlIRKPb4rhi/B0RNcdU8qOOZEIcFAZ04gAAAAAAAA==
--------------ms050106020304020807070302--

