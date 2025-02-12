Return-Path: <linux-fsdevel+bounces-41569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3858A32233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 10:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A6F18886C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272D2066FB;
	Wed, 12 Feb 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHbnSrkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D621F0E56
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352733; cv=none; b=N4BtnzVBLB350eBO4/oKkuzlW+xu05f3ChzMGGffAHT0qWzLapPcnUgFbNYm6RIg/PjWo04CL4Oz4kFSB9lG1OVqk1+YzLw2ZCaOfQlkB00RjnHENrs+SbXjUgP5YTLmjZM5mjZc8wgwHC1eU1dBYQZnz9tPniJByPT2+WJYSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352733; c=relaxed/simple;
	bh=+cJ/fkMPwbkCIrWs3rkgKiK7hcQV3H6QAu7coaz6CmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7+VZobzF9C+j+UZiDPRIhahtSdZ9q0gg2EJNoaulGmW7NxyHeXFabOjqVTxUdO/wip//DX3NoxO/kz0dH+LiwAo8ZbZgtLj1qpOVSTE9+Wjqo3p2LEZz2jpYeHYJNH5D+Y+0lpiv8WocFnDIncU0Y+arNy344K+4V7vwQnm6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHbnSrkI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e454a513a6so30200426d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 01:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739352731; x=1739957531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bj+BC4dNYutL50sI9l/9GUlvq2CE3xbIkTpQXr7oJA8=;
        b=CHbnSrkIhIkojQ/naBuPieT4NkaZjoay/QH7P6JG1gwtXfNWU2JK2rTyugxqIytXAe
         NfWzxjAexAM+2uwHkE/1pS57GO8Cf1ghtcsw2JYF2ho4ze5qJPNplCQ0UVkmoXOmQoFy
         rkvV0JQ28e8w2o6PrvOtLXZVKLrLzVTSg3Sr1s0HxJcYVs7c3+hnVrxWmpb1O/PZSPxC
         xMomF0jJDLhmag1W3thgs2JXzVGnJurZOOEDzaUjrMO08C4U2hpVvS1sxd47omGKPBNr
         REGNFEVllOaas0yU+0KD+koARF/XlH/UI7+rt/fKpVPRllQw8NHI5esblImmXZHHuuIf
         GvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352731; x=1739957531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bj+BC4dNYutL50sI9l/9GUlvq2CE3xbIkTpQXr7oJA8=;
        b=dNe0eVZjB06n7mhjzjqeJXJx8l2RL4euJpozc9fZZ54C8mcDYDTlQrIHvLt2fHFz1t
         t/3HNmCZD3wvP98+PD4c8NAV7Qn4C78jhvsAQ6RD32RSP6tE1zB0NW1WVnjYR7wQf7vP
         rDrUEWXCDRzGzza2IGlN2sgGJ//d4F3wX0Xr28w9PVRMqTwYjGM9M//xE2cgya1Nck7E
         5crkoniYz9pyot9I2GSMRNUvLVXJNAUgTXRkvQSCqPOiP+69n/+sJ0AIQ6C1trBuH7w1
         noY+3BOD2cxovS1g+ND1fWtOK0FBPm1sjMHgsYdYX+db5aTnycmEftI+xboEUth7su1L
         uZXw==
X-Forwarded-Encrypted: i=1; AJvYcCUZrukIR9OuX1+6bDwUy/lVisiPZ+P/icEv/NX9LUE5qpXaleqwkmWivHkMemIlh8e7aPcOC2w6DFjDbDSS@vger.kernel.org
X-Gm-Message-State: AOJu0YxVW1j2A3NDV7R6z+Ca/yK8ttcRjOoikIxlgtfXMy8ynUspqbqY
	2OWWgJah8fEu+nUVQC+TcFTT5ZpMX2WEadoGsoDAb5wgbkP3Mf+JDzTkWA9XDrQr6bMbKWUjHfN
	dM07GBQCysqPjWRF+wlXglgzC1axXEC2cnyM/x+NTmYfTDM2GCQ==
X-Gm-Gg: ASbGncvLRXWSaIJRbfGkhDpZ6G0WoMucLmauUbHwNp4xB+kW/q3ELcfN69HKIhoUAuv
	a3AOPrkBrRnIxKrY64m9oELHUhhi/R3f4imkELJHsCAS/y+P5DB1jbXNXIq4ohQe07pnRGapVwQ
	==
X-Google-Smtp-Source: AGHT+IHqnH56bEzm8NV2ZQyhVWM4msgDhH/69BKhdVG/QGZdCL5Ii2NjLfCLJU+Dv/rnHTmajdo+OnMTWb57Qg2zJXk=
X-Received: by 2002:ad4:5dec:0:b0:6d8:9a85:5b44 with SMTP id
 6a1803df08f44-6e46edacf68mr32690266d6.29.1739352730814; Wed, 12 Feb 2025
 01:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928235825.96961-1-porlando@lkcamp.dev> <20240928235825.96961-3-porlando@lkcamp.dev>
 <87iku7u211.fsf@mailhost.krisman.be> <2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info>
In-Reply-To: <2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info>
From: David Gow <davidgow@google.com>
Date: Wed, 12 Feb 2025 17:31:59 +0800
X-Gm-Features: AWEUYZn7RdReqmwmjJQTGuXVDd9NksDyWUUjhxWNmLfC3iYnfp3ctJ2NpBh2Xxo
Message-ID: <CABVgOS=36iRrpb+ND4M2awbZzgCKwudYxx5XNvEBEkgss+C-bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>, Pedro Orlando <porlando@lkcamp.dev>, 
	Kees Cook <keescook@chromium.org>, Danilo Pereira <dpereira@lkcamp.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b0f94b062dee9dd7"

--000000000000b0f94b062dee9dd7
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 14:45, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 04.10.24 21:00, Gabriel Krisman Bertazi wrote:
> > Pedro Orlando <porlando@lkcamp.dev> writes:
> >> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> >>
> >> Change utf8 kunit test filename and path to follow the style
> >> convention on Documentation/dev-tools/kunit/style.rst
> >>
> >> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> >> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> >> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> >> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> >> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> >> ---
> >>  fs/unicode/Makefile                                | 2 +-
> >>  fs/unicode/{ => tests}/.kunitconfig                | 0
> >>  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
> >>  3 files changed, 1 insertion(+), 1 deletion(-)
> >>  rename fs/unicode/{ => tests}/.kunitconfig (100%)
> >>  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
> >>
> >> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> >> index 37bbcbc628a1..d95be7fb9f6b 100644
> >> --- a/fs/unicode/Makefile
> >> +++ b/fs/unicode/Makefile
> >> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
> >>  obj-y                       += unicode.o
> >>  endif
> >>  obj-$(CONFIG_UNICODE)       += utf8data.o
> >> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> >> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
> >
> > This breaks compilation for me.
> >
> > fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
> >    11 | #include "utf8n.h"
> >       |          ^~~~~~~~~
>
> I encountered the same error when building -next using the Fedora
> rawhide config today. Given that this patch landed in -next today I
> suspect it might be due to this change, but I'm on the road and unable
> to verify that right now.
>
> Log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/08642966-next-next-all/builder-live.log.gz
>
> Cioa, Thorsten
>

Hmm... this definitely seems like a problem, but I haven't been able
to reproduce it here (either under x86_64 or UML, both as a module and
built-in). The suggested fix of changing the path to "../utf8n.h"
doesn't seem to have broken it, though.

Cheers,
-- David

--000000000000b0f94b062dee9dd7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAHAzCnLVtRkCgyqhFEoeKYw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTAxMTAxODI1
MTFaFw0yNTA3MDkxODI1MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoH0MspP58MiGTPha+mn1WzCI23OgX5wLB
sXU0Br/FkQPM9EXOhArvxMOyFi0Sfz0HX20qlaIHxviaVNYpVMgmQO8x3Ww9zBVF9wpTnF6HSZ8s
ZK7KHZhg43rwOEmRoA+3JXcgbmZqmZvLQwkGMld+HnQzJrvuFwXPlQt38yzNtRjWR2JmNn19OnEH
uBaFE7b0Pl93kJE60o561TAoFS8AoP4rZFUSqtCL7LD2JseW1+SaJcUhJzLxStodIIc6hQbzOQ/f
EvWDWbXF7nZWcQ5RDe7KgHIqwT8/8zsdCNiB2WW7SyjRRVL1CuoqCbhtervvgZmB3EXbLpXyNsoW
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgbcLcf0jX2zh/A+dk8t6kNSBOTOop
awlid5ShBd/XnrMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjEyMDkzMjExWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAHvW6Nr0pOwZxY7o+wo6aOeMspi9sLX0nkAaUNS0ZY3jtpzd
QKoNcLOmrOto9U3CT4/ILQhVQ4Lp5X9Sh9UVMRLiqYZ3HbA6/OsuydROZFhG8/Zu8+EetX3/aUAQ
ibyzlcYz0claIpGFbha0bo8xbqvjQRM/cYYhwuIsyW1r2Y9dYKBWlnoX3aMvBYI15lfY3t25Y1aS
g/8q6ebKWyVrh3xE1hK6Cc6k7iQBmJdGk5AEp6qeRn++w2iiSnh6vPM5nqv+KV2k4UNPXNLoJ0rE
uDkpBQsvZoJgFoKwx+xbE8L8Deq0HUwvje+QBi8xSblaMpCquYYKz+OvV6de3UkSBXE=
--000000000000b0f94b062dee9dd7--

