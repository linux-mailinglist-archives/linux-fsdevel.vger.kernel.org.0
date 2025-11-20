Return-Path: <linux-fsdevel+bounces-69169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE42C71A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 02:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60DE64E309B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8523E334;
	Thu, 20 Nov 2025 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyKfH2IW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBB23504B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601027; cv=none; b=FZSjWAaAtq+T/X2TmZ6+4cmzSLNFbe4b+cZ4asWvsqr7HBi7EPBVDUJ/kp/0N6wJXfImcJazmIE+rPYarLM7EXYd1OFG1esxWxSFjTAwcXQkVIJn37YUNm66xY8Bajg+sWq4EHx4E6PU3Nzp2F78oOGrd7UBSvsmKE+1NC4Ibic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601027; c=relaxed/simple;
	bh=AagjkzoAXk8/NgFgBGBdDQ6FH6q/TjeFv07vIObom44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX5msUL90q2DTxiJEWZK2tgn+MPJXWGKB+tKLXGG2uLxkCFjlidaoOSQ89GJOi+CzXUXporDuEfP812aSB2X/XS/ymce8eRb86lSWdagCjThF9IHtChPSkwpiZw1sQ6FBRfm2PUcZh9wwzMt/YUkmb3R2pRIA84034PvmsR3fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyKfH2IW; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63fc72db706so260924d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 17:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763601025; x=1764205825; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4TN9WlxM7bEYhdovOZdXK5qjiJkEcDO7wUY7EQtQg7s=;
        b=ZyKfH2IWYoGtZ6E0/iCtKW+BgsZhjAeTqQ6Pf1df4Jl87zcA0YVI4RuPH59nqgngub
         XwaGqeJ9btfkSCbHvcXUiHVYogXmaG15Gp9fRJfwY4SrRO23eBrZjoFkDvRDrBKxacPa
         EkYqluiqBw01P31Mh82OPhf3VywsZy9x+FC5yaZsGynk2/A1BsawIpg9n0m0feNrDGx7
         oWPrrD508p+OGWbtaEQ0eouLu49c68iZQHWKgdqkr4z3nbGt38j8yR8atZWsUWImiiuH
         0aTIwfiErofhgTgMKD9vo/V0Qg1HtEMkWRXEhEquNENIyoG8mXT8HNTRFZIXA5Lj260z
         w13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763601025; x=1764205825;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TN9WlxM7bEYhdovOZdXK5qjiJkEcDO7wUY7EQtQg7s=;
        b=G640I6nH6x5AKMTeIqXtnVc4YM33lgYbvPAEmTOivYRlfUp9WkoinW2A61y7qeHawR
         GNhhf3YNr5vIWyIh3FUgjZjJv2c3hQhomWfU0zUE3h4GWarrNmeQOG4H6RMw462A2fRw
         r0212WDMzBLM1IjeWIXi8v0ENZ9tDcvtNwKrSnOs2lde4N/bQuE0kIUTop8c5Ow+LB81
         Z9T2yFk+mNpVS9HFny795sfpEuWtxaKhsCzRqpC0ozD8aYXaJgpDz+Cclg1hLQajMoWd
         L1/8s6iJ2PFpXIlGyw92A9skreP1oV4NTAcLA4ygQeqMVOih9Bj0GGhuxTJMJLwyAb9C
         SA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWyOyc7yR/8ub1BF337w63UVEZegnf/EZU0ih/aED+fEJsY4By/+Oe2goxg7jB3U7nJsIqKhPTiis0j4Vu7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g6uuHcHIoVd2IWI4sxiTXoAWJFlGDg3uwmZO8Cpcy/9Sg/Px
	QDAXg0pPpii9N1LtMardXIPvm53YRjQWMlD/z+eFkwXEW5vAIKOReG35
X-Gm-Gg: ASbGncslRSzlJiYvc2qYIfuYyXqpAmsKhq7qqSEFIZs8Oa9E//nXN+s9XoM5pMCM6Uh
	wZPxYlU1KnBmN6a4M7Aq38qo2oJxKIeHZElCV797M6jgRAYB71xjkaY/RiDpnNIJpf5QgBOONtp
	wTjfO6WH/08+9K1ImzZV6xwmsSVn08pOPu8tKknv4NG9qIS98/DC2Bfkhn+VGQ4dr8Lw/o9OvOc
	SkJiyZiwqRgo+QRttmagYUiY9lDETKeYh3HsgTlR7hKS6hAsLl2b9GRq9Z9eeJN1zIHEhtkMOM6
	twCpECq255MkAgtnn/9f8SZOvcFjpTn6o1GOPj2hLHNGSi1oYGfQ0Dif2AVpU0LPri9/GjsxrH/
	2pwLHKagjCxqScYypz+xAVXLMJ9UM9ID1NHANyiCjPl+zjL4ofe+WQvzAYlk6ZCSvaZc7PKcflm
	CbZ+g/KTnzWCjNumXNO8ews4+p2xSVPUzX5NZsBCl978J5IdMGMRlXVstQhJpTBrjWc3aDMbQim
	RthqE74E51354oNrqEfEuGAUciiQ5yUhGByxQ==
X-Google-Smtp-Source: AGHT+IGQ8ljlFgaIQ8fqCKhYqANuvQVeoGitfzglNxi5dCSgv+OYhOYNNFR1D71mL+SWjWaT3VejIQ==
X-Received: by 2002:a05:690e:16a1:b0:63f:ad90:ad45 with SMTP id 956f58d0204a3-642f778d6femr1012066d50.1.1763601024388;
        Wed, 19 Nov 2025 17:10:24 -0800 (PST)
Received: from [10.138.34.110] (h96-60-249-169.cncrtn.broadband.dynamic.tds.net. [96.60.249.169])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f7048d7esm375063d50.4.2025.11.19.17.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 17:10:23 -0800 (PST)
Message-ID: <aaf98238-e8f6-472d-bfb9-7f8ddbab8e02@gmail.com>
Date: Wed, 19 Nov 2025 20:10:19 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
 <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------u4y7Z4Hxdq0nvazIG660CKHU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------u4y7Z4Hxdq0nvazIG660CKHU
Content-Type: multipart/mixed; boundary="------------4bo0nskHQ08B9HKd7s0YguKR";
 protected-headers="v1"
From: Demi Marie Obenour <demiobenour@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, joannelkoong@gmail.com, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 zfs-devel@list.zfsonlinux.org
Message-ID: <aaf98238-e8f6-472d-bfb9-7f8ddbab8e02@gmail.com>
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <d0a122b8-3b25-44e6-8c60-538c81b35228@gmail.com>
 <20251119180449.GS196358@frogsfrogsfrogs>
 <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>
In-Reply-To: <af9a8030-cd19-457c-8c15-cb63e8140dfc@linux.alibaba.com>

--------------4bo0nskHQ08B9HKd7s0YguKR
Content-Type: multipart/mixed; boundary="------------ryUl7YI5BrtmXg85hUqSfXT0"

--------------ryUl7YI5BrtmXg85hUqSfXT0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/19/25 16:00, Gao Xiang wrote:
>=20
>=20
> On 2025/11/20 02:04, Darrick J. Wong wrote:
>> On Wed, Nov 19, 2025 at 04:19:36AM -0500, Demi Marie Obenour wrote:
>>>> By keeping the I/O path mostly within the kernel, we can dramaticall=
y
>>>> increase the speed of disk-based filesystems.
>>>
>>> ZFS, BTRFS, and bcachefs all support compression, checksumming,
>>> and RAID.  ZFS and bcachefs also support encryption, and f2fs and
>>> ext4 support fscrypt.
>>>
>>> Will this patchset be able to improve FUSE implementations of these
>>> filesystems?  I'd rather not be in the situation where one can have
>>> a FUSE filesystem that is fast, but only if it doesn't support modern=

>>> data integrity or security features.
>>
>> Not on its own, no.
>>
>>> I'm not a filesystem developer, but here are some ideas (that you
>>> can take or leave):
>>>
>>> 1. Keep the compression, checksumming, and/or encryption in-kernel,
>>>     and have userspace tell the kernel what algorithm and/or encrypti=
on
>>>     key to use.  These algorithms are generally well-known and secure=

>>>     against malicious input.  It might be necessary to make an extra
>>>     data copy, but ideally that copy could just stay within the
>>>     CPU caches.
>>
>> I think this is easily doable for fscrypt and compression since (IIRC)=

>> the kernel filesystems already know how to transform data for I/O, and=

>> nowadays iomap allows hooking of bios before submission and/or after
>> endio.  Obviously you'd have to store encryption keys in the kernel
>> somewhere.
>=20
> I think it depends, since (this way) it tries to reuse some of the
> existing kernel filesystem implementations (and assuming the code is
> safe), so at least it still needs to load a dedicated kernel module
> for such usage at least.

My hope is that these modules could be generic library code.
Compression, checksumming, and encryption algorithms aren't specific
to any particular filesystem, and the kernel might well be using them
already for other purposes.

Of course, it's still the host admin's job to make sure the relevant
modules are loaded, unless they are autoloaded.

> I think it's not an issue for userspace ext4 of course (because ext4
> and fscrypt is almost builtin for all kernels), but for out-of-tree
> fses even pure userspace fses, I'm not sure it's doable to load the
> module in a container context.
>=20
> Maybe eBPF is useful for this area, but it's still not quite
> flexible compared to native kernel filesystems.
>=20
> Thanks,
> Gao Xiang
Thank you for the feedback!
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------ryUl7YI5BrtmXg85hUqSfXT0
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------ryUl7YI5BrtmXg85hUqSfXT0--

--------------4bo0nskHQ08B9HKd7s0YguKR--

--------------u4y7Z4Hxdq0nvazIG660CKHU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmkeanwACgkQszaHOrMp
8lPrOQ/+P9fdog3wM9BEc4VYbEhDjEmiXEN034RUt2jTN5HPfqISR2/hgIgppcb2
dYcKjcB1Wp0vqPYouLMrt0J5f6XCJ8PkcLLwsr7sQ9gwJKZyr4r+yPmEnHZnQpB+
9sgH5Q/SDPkUxTpaeYi8aBwDn6mgc6GDg3/8XqOz24He6sFaGXd0mUHrg+zXhVbh
H8YFTCrBWNTFt1uXaQWJkhZ8mISV6jZkbwAIjVz29mhZlnKtHJuT7Lc5k0t1XG8P
WXvQl1xds58l2MjunuGCbTPtBRDJOilXEqVj1ZshtscT3+jTjWTj5UzOLsdofl7q
RNgCIZkSVsXIFSqeMVriC3hl47z9+DpdJglgTEJrLNo8whqPq0l4IsnzhHSAD01m
gx8vk3ZCNnAHVnM9VsPzFtGvwNdBj9l1BfF1HrQI3ZvTdHHu4ABEdO1jDeQ6xJN7
Y67BQXYVbkL4KPRthJssygIjBpgJ8Fytfa1uos+Q7gXsul4eMOrVqBxG392xZ4TB
aYEtqwzTQ2V6ZowQyMMXxX6eLxs1ENopTNEHS0dkdyeQF8iV5V1e5L92x+DDZU7D
C1VI/amVcoGS3L5Zr3pR/Uz9Jsm9BncAU6T1vRH2LC6ft04wnsgQTYySFFQkX2fk
qqhUlTPBGTK8UJB3m9i05DJhUAph+tbbESuQVSMZYXZc5O5KAEE=
=iARO
-----END PGP SIGNATURE-----

--------------u4y7Z4Hxdq0nvazIG660CKHU--

