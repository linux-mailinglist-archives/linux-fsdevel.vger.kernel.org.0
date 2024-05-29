Return-Path: <linux-fsdevel+bounces-20474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0648D3E71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C10228399D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F21C0DCF;
	Wed, 29 May 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbGPxVNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF6156F38
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007810; cv=none; b=vGNkVDiydXXZU7XS5jihiGCaLybytSjCwO7+5lquObfCIZq5iICy5oUHNPIKNoejyivPb2MQOjHM6cvJGlK9Lu2Gr5G2fqV09rsHqxKcgr6ixbuujLarFFZwB9SP8DQe7oRvo45Jp6Bjt7EfktUBxDsbVWRlcXxQr1NtVZvjlAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007810; c=relaxed/simple;
	bh=qjZBStCy2g2TGFG6UfwnJBujhy/xo5nmD2DHB/eqfRA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rc8/98/ZCiw3uincd0DgvNTLAkrnlIdJbl3R4sRb5pZH3AmAw7+4OoJMa7wBNtb5TQ6kwI8MF/T4ldSxXHQ9ZyQDKNii+bCLaVqZX4qABKaeyk0WCswYGInISXuPyQYLNHIteDJA3tAZsLr6Zxou1wineWZ7QK6SWSVt5/DcaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbGPxVNz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717007809; x=1748543809;
  h=from:to:subject:date:message-id:mime-version;
  bh=qjZBStCy2g2TGFG6UfwnJBujhy/xo5nmD2DHB/eqfRA=;
  b=GbGPxVNz9zOpTtM247b9OG4d7HxnkbYVDwXkvmvoR5x61O/jNSCFJpBE
   dFbaKhiSRkKo0qLilmt6JdoYZHOkTRVR7EG2alFyNgpNUoW6NE+35vCAH
   xZvIIye2wweBM5+Z35A+g5RsxBR1U6bZHYttMM5GV5I5AQd04j43w+U4N
   19OjzVU9AfBNSLs2cYMjJ9YpkNbSCUq2zG57O0U8y9j8nvBfwgaZ+Punn
   MfwLRHCPVAPuTcxGYmUg4Nb4V5CepMzSiHxH1bwJDKIEy3IFEmu/O99Cz
   o5PeYNIKXjbwl/jEI0kyEOKHLXjxLiT8LnV9iKItRnTcNbY3ypoFoecM1
   w==;
X-CSE-ConnectionGUID: CkQ82DtZS+iordd9Wj7+gg==
X-CSE-MsgGUID: hUpix6y9RoSmlMBKFRA4cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13664949"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="p7s'346?scan'346,208,346";a="13664949"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 11:36:48 -0700
X-CSE-ConnectionGUID: DpM47OIBTfuDWgpnNIN7nA==
X-CSE-MsgGUID: /m0yPGHVQ0GcTybQeMYjTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="p7s'346?scan'346,208,346";a="36007114"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.111.114])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 11:36:47 -0700
From: Thiago Macieira <thiago.macieira@intel.com>
To: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: statmount: requesting more information: statfs, devname, label
Date: Wed, 29 May 2024 15:36:39 -0300
Message-ID: <11382958.Mp67QZiUf9@tjmaciei-mobl5>
Organization: Intel Corporation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10418153.FP6jjVeTY9";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart10418153.FP6jjVeTY9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello Miklos & others

Thank you for the listmount() & statmount() API. I found it very easy to use 
and definitely easier than parsing of /proc/self/mountinfo. I am missing three 
pieces of information from statmount(), two of which I can get from elsewhere 
but the third is a showstopper.

The showstopper is the lack of mnt_devname anywhere in the output. It is 
present in mountinfo and even in the older /etc/mtab and I couldn't find a way 
to convert back from the device's major/minor to a string form. Scanning /dev 
will not work because the process in question may not have a populated /dev 
and even if it does, it would be wasteful to scan /dev for all devices. 
Moreover, given symlinks for device-mapper, /dev/dm-1 isn't as descriptive as 
/dev/mapper/system-root or /dev/system/root.

Is there a chance of getting this in a new version of the kernel?

Of the two others, we can get via other system calls, but would be nice if 
statmount() also provided it.

First, the information provided by statfs(), which is the workaround. It's 
easy to call statfs() with the returned mount point path, though that causes a 
minor race.

The second is the filesystem label. The workaround for this is opening the 
mount point and issuing ioctl(FS_IOC_GETFSLABEL), but that again introduces a 
minor race and also requires that the ability to open() the path in question. 
The second fallback to that is to scan /dev/disks/by-label, which is populated 
by udev/udisks/systemd.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCAI Fleet Engineering and Quality

--nextPart10418153.FP6jjVeTY9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIUHAYJKoZIhvcNAQcCoIIUDTCCFAkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghFlMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYD
VQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRow
GAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZp
Y2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU
UlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9y
aXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00yt
UINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfji
b9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+
fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcS
Ok2uTIq3XJq0tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97E
xwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkT
rNN9N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4
Z+LoE53MW4LTTLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlE
RPSZ51eHnlAfV1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4P
Y9bpYrrWX1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAW
gBSgEQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYD
VR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8
MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29t
MA0GCSqGSIb3DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+c
li3vA0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czS
AaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ
7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7o
BmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIGEDCCA/ig
AwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzAR
BgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNF
UlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZ
BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2Vj
dGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQK
Qf/e+Ua56NY75tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6n
BEibivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHd
JDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC
0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2
ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rP
VIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMC
AYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYD
VR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgw
PwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVz
dENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0B
AQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFTvSB5PelcLGnC
LwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/X
fdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQS
qXh3TbjugGnG+d9yZX3lB8bwc/Tn2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6l
DFqkXVsp+3KyLTZGXq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhA
mtMGquITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE1
9GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5
ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14AC
HuVvJsmzNicwggXIMIIEsKADAgECAhEAmNKe/GMzrd42++mphuFrQTANBgkqhkiG9w0BAQsFADCB
ljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yNDAyMDYwMDAwMDBaFw0y
NTAyMDUyMzU5NTlaMIHBMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xGTAXBgNVBGETEE5UUlVTK0RFLTIxODkwNzQxKDAmBgkqhkiG
9w0BCQEWGXRoaWFnby5tYWNpZWlyYUBpbnRlbC5jb20xETAPBgNVBAQTCE1hY2llaXJhMQ8wDQYD
VQQqEwZUaGlhZ28xGDAWBgNVBAMTD1RoaWFnbyBNYWNpZWlyYTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMo12vQHELQBeRYa1TFMGDXaEfa9hvHsrHbdw3bRlsLOlBkilqmWoNIY8Eg+
aKfsX1R8j4TBfZL4O8Kbj9zuTyOjxMoZ0sy9aqLESyvCndTxLkXTuD9ucRpzyaONTVDpkcPvmzCn
Pfu/wrjVgCjJgSGhP2UcftOtJMpxVq1h2xLxL+PIK6vu1QcUC+KGsAJksJwpohxSXQRXnySXEkAY
xOOqjPu5aD84dSkkjm+WiLxYn7b3kpIM+cKYXHed8VazQj3fgNoetpAd8xbxomb58Eb0xETFle+H
iVCEZlyb4WQXXvPJLQvOcG2GyRlD0lA4wQXtBumI/FniVI+dRl40hHkCAwEAAaOCAeIwggHeMB8G
A1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBRWBSSvvmYM9fi+EyssysN/
bREXwDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYI
KwYBBQUHAwIwUAYDVR0gBEkwRzA6BgwrBgEEAbIxAQIBCgQwKjAoBggrBgEFBQcCARYcaHR0cHM6
Ly9zZWN0aWdvLmNvbS9TTUlNRUNQUzAJBgdngQwBBQMCMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6
Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJl
RW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0
aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNy
dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wJAYDVR0RBB0wG4EZdGhpYWdv
Lm1hY2llaXJhQGludGVsLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAKzjHXLQRIbYpew1ssPD4R1zv
Nbf/fUtowwlsLQnR1E/c8vcKbAmbQBVPvt/i8FdkM9mgYWXFnuWXaOu07GkfFOdrPSm+Pxy/gSoM
e/sXe1FcB4Nrjh+RK8+RYjBFcLKVFCtVuwBjhPOZ1x9aNiFkEul/bVkhA6is3hXwcLWfNcIVXjUP
0cyCIR0dDzfitsclSminJv3exg1U+gitix4MZ4bfxqCN880VW5ZXJjgam24yzx+ShP14wsKLmqSh
fxLHGrH4YlL0QikD1t2w858ya1UXMJKZM/0jNUKD4SsT1ck6Jm/E0F5+8TdgShty93FkUXGPFIqK
S12rg80RKka+pTGCAnswggJ3AgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQx
PjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAmNKe/GMzrd42++mphuFrQTANBglghkgBZQMEAgEFAKCBoDAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA1MjkxODM2MzlaMC8GCSqGSIb3DQEJBDEi
BCAF5WC6dt1r9g3qPg+QRNtDyhHKJAa+Z8cdwgE453VxGDA1BgkqhkiG9w0BCQ8xKDAmMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEBBQAEggEALWOyoejC
fMlvvr8AZgcJSgYUlltPoPBs+1YRG/mZGUh68NrMNpwr/lZwjVMDAMmiWz3za5fz6ZpthvjRSkIX
BHa1/QzzPgzy3UpgtB7CoZD+n9ABJrWsvRBUiVafKClRo6f/u0+BlUUJ1fecilO1Hqd0OxfYqpAs
+z1FLkmxi1NGLNIU3LGI533drXbpKb0eDsUhSAQjk4DOGaHWJZigz+v4VnIY8NjFlnRt5cXk8WoB
zhQ0NDIepQ2lsubqDnJLmS1hWBXyGcD9n4Kuv5ToYadHOLDnCpv/icx9emSNxBPm64xDU+nWhsjV
UCwmtCknSp73cTv4M94bAQt+ljGmAw==


--nextPart10418153.FP6jjVeTY9--




