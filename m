Return-Path: <linux-fsdevel+bounces-20524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B552B8D4CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CD01C21930
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D617C9F2;
	Thu, 30 May 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmfzWYSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513917C23E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076018; cv=none; b=llDDNIhO8z+T+Z0ocRrEqSkS8NVG8OblemNZ9jqZJJiSjyC+XIgzkI0NLgIY1i9g9LFNOTzec+sQsmtF14iaCxSdKVnH1aicWNCa/oQVKZrCAbmT3a1AoZc8RQlU1y4heltMQ7lAvzMjJk1g3S53yZcusVirpK9KJqig+98e9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076018; c=relaxed/simple;
	bh=cT/MnTRL8Fs9kbWXVOTv8p5FJDm873OmhjxpiptTl/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRbJctXvxTlf/KMeGYFW8AyyrL6D7QvRTjYi2L5Puz2rd2djexLB9PhGTWNIa56z5KbVzbPfZ6tvNx8Lcn/6xhxDEBZP02Tz/pzVi1Mh0zMjs1JZmXuOHzES+e9oeCH8mdWz9SABhFN4VXkXdmEo8o4bNFqAe8aCATuLUuseb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmfzWYSv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717076017; x=1748612017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cT/MnTRL8Fs9kbWXVOTv8p5FJDm873OmhjxpiptTl/M=;
  b=NmfzWYSv6mBHUVxV5t7ohQXPu22NYaYXYWfb8umu8Cd7NV3hgBONznEQ
   0mQEGj/RTbXdHmBgdv6andQp8qloVzHUtKnkvbb7KfMTjAfQ1DEDXg1al
   Tjvo0DxWTVYVaRRVbwX6KJq0RV4rVO+yTR736gXXYkOJLGFuCUOFbCA/p
   r7lpIIZsoDUl+Rucz8nuIYSLW/pVIB9wPQwM9IjtT5Nj75A8k5CWeuzOF
   ogqIR8D3TLFjlv2l3CZ1kYySRdwulS8bIJMvSBTtroNtdTOmGX9KTrusZ
   AIsM3GpWDyGvt5pagLn3s6YkgbkRe9zlEZf7dwv9+n2tjUOZb+VbS+vXZ
   w==;
X-CSE-ConnectionGUID: T1S/u6Y1TmyV4MwRmUE0Aw==
X-CSE-MsgGUID: M0YcV2wQQZSyEODmVNogcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13435587"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="p7s'346?scan'346,208,346";a="13435587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 06:33:36 -0700
X-CSE-ConnectionGUID: HyZ50pkuRp6yFIPc9OburQ==
X-CSE-MsgGUID: DJCaxPrpTPCcm0PqaADiDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="p7s'346?scan'346,208,346";a="35853348"
Received: from ibganev-desk.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.111.177])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 06:33:35 -0700
From: Thiago Macieira <thiago.macieira@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: statmount: requesting more information: statfs, devname, label
Date: Thu, 30 May 2024 10:33:27 -0300
Message-ID: <35784462.WqB4rESCP9@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <20240530-heilen-haftpflicht-c696306f5287@brauner>
References:
 <11382958.Mp67QZiUf9@tjmaciei-mobl5>
 <CAJfpegv_6K-tFtNjOnTBxc0KTSy7Horpu4OFAvkLBkPtv=CoRw@mail.gmail.com>
 <20240530-heilen-haftpflicht-c696306f5287@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2204991.ucGe3eQFbh";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart2204991.ucGe3eQFbh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday 30 May 2024 07:42:09 GMT-3 Christian Brauner wrote:
> Let me rephrase what I mean as I probably wasn't clear enough in my
> first mail. My objection is mostly that I don't want us to start putting
> stuff in there that's not generic. And yes, some statfs() fields might
> make sense to put in statmount(). But I think stuff like "f_files" or
> "f_ffree" is really something that's misplaced in statmount().

I'll take what I can get. My class's API exposes the total size of the 
filesystem (f_blocks), the bytes available and free (f_bfree and f_bavail), the 
block size and whether the filesystem is read-only. For the latter, I don't 
know if it's the same as MOUNT_ATTR_RDONLY.

Keeping statfs() is not a problem. My biggest problem is matching the mounted 
filesystems from either mountinfo or listmounts() with what is actually visible 
in the system. For example, what happens if you mount something that makes a 
mountpoint invisible? Both df and the Qt class hide the entry too, but it was 
guess work until the mount IDs were exposed in statx().

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCAI Fleet Engineering and Quality

--nextPart2204991.ucGe3eQFbh
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA1MzAxMzMzMjdaMC8GCSqGSIb3DQEJBDEi
BCDlAxkcoCaMaovVNV1TSDxZvek3Kg04hBSIIOKVOyGQGjA1BgkqhkiG9w0BCQ8xKDAmMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEBBQAEggEAvT94bMTZ
mjQs2mhKMU0y7YbyyQQOq/BaO5iLD3qEmg5G9OvCiWn7LytXVHpfKZ4daNzpDJkTv8uvtv4GPiq7
SGAVC4dt/Bzg5/KVmAleI9TJyAiwQexHFZUON+xs6Ib9iFw6HPwgjyznC8KB0+DUXfB+49As8qGu
mq+84u759MquSaQeDGg16Us/VSzsczuUXTbLSWRbMZUq1Lypnq9TqCU4UWIFC24rXBjgSeZ7Yz5Q
zqzEIE7XIc4yW8w1WNOf1awWES+MIxE7zPSq8TxdTvtiOT+aKE7jDyePhwppGqbCUFQe4z6mYiIN
G1v5yjPCDpv/lvo0cHmay0pYRzv7pw==


--nextPart2204991.ucGe3eQFbh--




