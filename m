Return-Path: <linux-fsdevel+bounces-20522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EC8D4C81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F2DB21F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88423183092;
	Thu, 30 May 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpyQXrLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB918308B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075330; cv=none; b=kbnqoLCwA5T8WJMqRXwruuQg37FYSf9Zh4pMBnteXDd6uCUAmFYtGmiCnK6Qw3PXko1u/QlqbtbYymW6uYXasRHFmaMKsR323CGOohvGcGOSIn1v+EAUxAGMJkU00NRhim3dubKE7tERqLIKpVxNvqAkCphyUiJW2vT+MuTPhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075330; c=relaxed/simple;
	bh=dSnHTHhiavrKbLWKxiWRFUL/2Y34aSsSllkkClAGpgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8Co2l3Byoag3p32VwaEXHIjw1+CkanSPFU/PZsYCmAuCkFfWWNAI461GSQeuo1R3qh8wSwnydkvr9XoDV9lLOMBR7ABKSZ+Al3TnK8P6xhpm66oMweIvYRPHqQQ0s9ZtRmNguLtXVjtFzNFG8QiVpZngIzfIwZjs+KW/TrHtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpyQXrLT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717075328; x=1748611328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dSnHTHhiavrKbLWKxiWRFUL/2Y34aSsSllkkClAGpgY=;
  b=WpyQXrLTAhyGhkkWvaMBQFHMPc5YJzn13dAtuJQAPznWmnjnVg//+zBK
   9YniOOdyPjDq0yELQJCqmi2S3PQSxjnw5M9bJLTl+Nyxex4eKnOiNRMzs
   1xlWyk05kR3wZbQwrzFmfTs9pIfQNWHqFHawESVdQ07/79CsiJfVrvuWA
   UIu5oCAJsA4ubH+WjBZDcaks+PyHzWzZ6BwSrcK4plwdteFS+V+3F3ROW
   3/KnUn2dBA9plSvf9Z7TFiuWzCsMmFUZ1n13Q5uDwWlqAEJH//yMHOZ9k
   McyOna3TMmYBCMWrkkQickT8PawyQUgnmNiJ7QtlHK1iGRcZUvkuF3UlL
   A==;
X-CSE-ConnectionGUID: 1LcAzr83S+uslSJzmPF4sA==
X-CSE-MsgGUID: N1ktmUbCTGKpzhqMC3eoFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24678242"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="p7s'346?scan'346,208,346";a="24678242"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 06:22:07 -0700
X-CSE-ConnectionGUID: v6ZzAsl3QX+99qR27AB4Hg==
X-CSE-MsgGUID: BZ4m1LZaSNu+0IRvHK6KKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="p7s'346?scan'346,208,346";a="35870717"
Received: from ibganev-desk.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.125.111.177])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 06:22:06 -0700
From: Thiago Macieira <thiago.macieira@intel.com>
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: statmount: requesting more information: statfs, devname, label
Date: Thu, 30 May 2024 10:21:58 -0300
Message-ID: <5199584.tpJ11cQ8QL@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To:
 <CAJfpegv_6K-tFtNjOnTBxc0KTSy7Horpu4OFAvkLBkPtv=CoRw@mail.gmail.com>
References:
 <11382958.Mp67QZiUf9@tjmaciei-mobl5>
 <20240530-hygiene-einkalkulieren-c190143e41d9@brauner>
 <CAJfpegv_6K-tFtNjOnTBxc0KTSy7Horpu4OFAvkLBkPtv=CoRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2486217.ovnAMPojKx";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart2486217.ovnAMPojKx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday 30 May 2024 05:25:39 GMT-3 Miklos Szeredi wrote:
> > > The second is the filesystem label. The workaround for this is opening
> > > the
> > > mount point and issuing ioctl(FS_IOC_GETFSLABEL), but that again
> > > introduces a minor race and also requires that the ability to open()
> > > the path in question. The second fallback to that is to scan
> > > /dev/disks/by-label, which is populated by udev/udisks/systemd.
> 
> FS_IOC_GETFSLABEL seems to be implemented only by a handful of
> filesystems.   I don't really undestand how this label thing works...

Nor I. It's one of the btrfs ioctl calls that became generic, like FICLONE, so 
it's not surprising that it isn't supported for all filesystems. For the rest, 
I guess udev/udisks knows the filesystem superblock header format and reads the 
label off it, because it seems to know the labels for FAT filesystems despite 
the system call not offering it.

openat(AT_FDCWD, "/boot/efi", O_RDONLY|O_CLOEXEC) = 4
statfs("/boot/efi", {f_type=MSDOS_SUPER_MAGIC, ...}) = 0
ioctl(4, FS_IOC_GETFSLABEL, 0x7ffe6f557110) = -1 ENOTTY

My code to decode this via /dev/disks/by-label is a best effort that seems to 
work for everything that doesn't support the ioctl. Fortunately, statmount() 
does give me the actual device's major/minor, no the anonymous IDs that some 
filesystems (like btrfs) use for subvolumes, so it's actually easier to scan 
with statmount() information.

> > I think that mnt_devname makes sense!
> > I don't like the other additions because they further blur the
> > distinction between mount and filesystem information.
> 
> mnt_devname is exactly that: filesystem information (don't let it fool
> you that it's in struct mount, that's just an historical accident).
> It's just a special option that customarily refers to a device path,
> but in general is very much filesystem specific.

Ah, good point. So here's even a stronger reason: if I had a remote FS, I'd 
probably want both the devname and the mount options, neither of which are in 
statmount() right now.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Principal Engineer - Intel DCAI Fleet Engineering and Quality

--nextPart2486217.ovnAMPojKx
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA1MzAxMzIxNThaMC8GCSqGSIb3DQEJBDEi
BCBK4OVr0ZixmNMk1NLJAj/a7TS0j3deoAg5PR/5wq5zuzA1BgkqhkiG9w0BCQ8xKDAmMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEBBQAEggEADqtVnB/M
p6OP66Af/r+749qHDrRoZy0qg6u8mceS6/hnxg0gy5o8iBlknMqFhwz+OJl02oLQ4ZJHHR4COrih
HOeza+/udayQx6Bu0NR/2gQPw8sEtA/aW1hcb+jvJ+LmlikY2jvnHXIeGW6YSUq5+Mj/PYJaqvEB
WaWUovrz7Y+ZD1RSz+99j7BbV95lexa5ebhuVaM2HY6pl00cVPVhmJ8Sd+r5ZIvRM06IrFg168OC
n0kY31JRri64MMnT55n9suW9S4R9UPHYns7kGIW3xejXRrmpio01G8y6yW8JQBcUJp4pcipZ4oEy
RLz0GwG1LHNhsuLG24xAAQFBhqWLAA==


--nextPart2486217.ovnAMPojKx--




