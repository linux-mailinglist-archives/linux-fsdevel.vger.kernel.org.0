Return-Path: <linux-fsdevel+bounces-23096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65F92704A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 09:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB101C22794
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601F1A08DE;
	Thu,  4 Jul 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciKmWs7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F31849C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077032; cv=none; b=HPsW5kzYlq1ul60LwrLqzuLWQ4mVDsV6FPflcmArZmkDyJrw4njw9kc/tP0Tkzs5vpTKanALN4R32YDcjVvYGODY1dd+hyRYbd+Ieumc5gUuRa320TfKtTdoipVf+HkpcbTwhm0BRNfTk1muJ8C8bThKuNDVBV4/oH7bPwK2BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077032; c=relaxed/simple;
	bh=2zQsqKKHwyg3tVnX+uA+AE5qWsCoXyOGOLT4L/CNqQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3UgCh0Cl9jDEfUBZQunx0BzbETY8f9KEQvfCkJVz7K10rLOuCnvbDukuzJ3ZMCjjLeSYcO2cB4kGZ7LLTdSHalIIGMNQMr2J7dzRA1gjtnQVsl3D3nEku8xwHF6lrRFhzju9TXOuEDCyrde6VFCD/w/kCfuZ/CWPcQM103j1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciKmWs7f; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447bee1aef5so180611cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720077030; x=1720681830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPgzd7qnVRvHEz3Nwrz1ABDkJtro5Xl4ghZ0zsFe0PQ=;
        b=ciKmWs7f1xzNzpYduo0mZ4dmk8bcMXjLRJWvHNlGV7cCFaMmPW9d5xMwfUdNvW/gDm
         pMewlf3OyiS/wfEeCaOncjcNEFMLI6X13C97PEbfhsmrtbCKgdyudL8Ao0cd49Bzmdfg
         zHcvWssNW29WmansdgxJ4YYNFBq2en72ICB+UyndC4QHmTnfCnzteGqZ9TlGPd0uWkq8
         h8zE4i0FvrZCM9duC7ir0SKQ7NKdh3/ZUlAFAnLI3xgQ5jfEx37HyT6av7G6hXFVhQH7
         Sn1UAGvAagCN2c1VHFGjZ8UITYXympkWv1h6BAPEMQACC9bmNAAv49YAp1W0w0VOZAt3
         lYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720077030; x=1720681830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPgzd7qnVRvHEz3Nwrz1ABDkJtro5Xl4ghZ0zsFe0PQ=;
        b=CiCSclHNccwfzfO9KE0LPMTyk11/e/+Bf2WFw9sufYuBvhSOlZx8fYmhzOvXvBcQkQ
         O3lomPgcEabNM3POIdSycCEzTjisqk1wYljicSfFGfsRiAhebNZjkDJE06YcrBlKQgbM
         aXq5hx3AgManI9+GEsa0GG5mjEuUVg/338iqbp7dBu/JgMOKOcW44hOSqyXv6Qsc6aD4
         4i0HQ7eq3G/V2pRWkqIbmrglzB24tCmMnnypJgbno0jNjid1Arjx/rn5LXCVWYM/JXs5
         Fz5CQi/qW1S2qzWi9gImIr4N4Jb/SBUXIsliY9h+RNMbst0+XAkrp7jVUpYxvzBQ4HW+
         Lx1A==
X-Forwarded-Encrypted: i=1; AJvYcCUCKgFcvqDVb7F41jM8UXUrLUPo7HBRRoS9k5LqN4NvEa/Z/V48jk8TH2ABpg9um62mC9n/QZm3Z75ISLiiw8+skjUSzm3NSzUciCaVbw==
X-Gm-Message-State: AOJu0Yy620K3ez5SHOBVHJ5psL4lwnQmS8PJsgc/qp19c4j7bRNA8YEH
	voMXegTJLpkK03YsryEz+qlZ9jlrD02kieNN1S3ybvFjrFjkdFH34B4lLLq4W2Jgbqf4re2qTrQ
	S3EIBNP5AFh19Rgviq0rCrYs07Uvf7Hm7NzCG
X-Google-Smtp-Source: AGHT+IFvuRzd63Pu6wp4YjsjI4rrjnpAGKl7fdaYiicdv0lxlQM8WTpWdWOgF4fksHss6qgvj8OcH9/AJ3AK6OWFCoA=
X-Received: by 2002:a05:622a:448b:b0:444:f66a:c199 with SMTP id
 d75a77b69052e-447c9044f60mr1830111cf.26.1720077029463; Thu, 04 Jul 2024
 00:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local> <20240703225636.90190-1-sj@kernel.org>
In-Reply-To: <20240703225636.90190-1-sj@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 4 Jul 2024 15:10:16 +0800
Message-ID: <CABVgOSk9XTM2kHbTF-Su8fXxCcNzu=8vF4iUbC=2x-+O_MNUWg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
To: SeongJae Park <sj@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005cd4ce061c66a405"

--0000000000005cd4ce061c66a405
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, SJ.

While I'd love to have the VMA tests be KUnit tests (and there are
several advantages, particularly for tooling and automation), I do
think the more self-contained userspace tests are great in
circumstances like this where the code is self-contained enough to
make it possible. Ideally, we'd have some standards and helpers to
make these consistent =E2=80=94 kselftest and KUnit are both not quite perf=
ect
for this case =E2=80=94 but I don't think we should hold up a useful set of
changes so we can write a whole new framework.

(Personally, I think a userspace implementation of a subset of KUnit
or a KUnit-like API would be useful, see below.)

On Thu, 4 Jul 2024 at 06:56, SeongJae Park <sj@kernel.org> wrote:
>
> On Wed, 3 Jul 2024 21:33:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle=
.com> wrote:
>
> > On Wed, Jul 03, 2024 at 01:26:53PM GMT, Andrew Morton wrote:
> > > On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@o=
racle.com> wrote:
> > >

[... snip ...]

> Also, I haven't had enough time to read the patches in detail but just th=
e
> cover letter a little bit.  My humble impression from that is that this m=
ight
> better to eventually be kunit tests.  I know there was a discussion with =
Kees
> on RFC v1 [1] which you kindly explained why you decide to implement this=
 in
> user space.  To my understanding, at least some of the problems are not r=
eal
> problems.  For two things as examples,
>
> 1. I understand that you concern the test speed [2].  I think Kunit could=
 be
> slower than the dedicated user space tests, but to my experience, it's no=
t that
> bad when using the default UML-based execution.

KUnit/UML can be quite fast, but I do agree that a totally isolated
test will be faster.


> 2. My next humble undrestanding is that you want to test functions that y=
ou
> don't want to export [2,3] to kernel modules.  To my understanding it's n=
ot
> limited on Kunit.  I'm testing such DAMON functions using KUnit by includ=
ing
> test code in the c file but protecting it via a config.  For an example, =
please
> refer to DAMON_KUNIT_TEST.
>
> I understand above are only small parts of the reason for your decision, =
and
> some of those would really unsupported by Kunit.  In the case, I think ad=
ding
> this user space tests as is is good.  Nonetheless, I think it would be go=
od to
> hear some comments from Kunit developers.  IMHO, letting them know the
> limitations will hopefully help setting their future TODO items.  Cc-ing
> Brendan, David and Rae for that.

There are a few different ways of working around this, including the
'#include the source' method, and conditionally exporting symbols to a
separate namespace (e.g., using VISIBLE_IF_KUNIT and
EXPORT_SYMBOL_IF_KUNIT()).

Obviously, it's always going to be slightly nasty, but I don't think
KUnit will fundamentally be uglier than any other similar hack.

>
> To recap, I have no strong opinions about this patch, but I think knowing=
 how
> Selftests and KUnit developers think could be helpful.
>
>

More generally, we've seen quite a few cases where we want to compile
a small chunk of kernel code and some tests as a userspace binary, for
a few different reasons, including:
- Improved speed/debuggability from being a "normal" userspace binary
- The desire to test userspace code which lives in the kernel tree
(e.g., the perf tool)
- Smaller reproducable test cases to give to other parties (e.g.,
compiler developers)

So I think there's definitely a case for having these sorts of tests,
it'd just be nice to be as consistent as we can. There are a few
existing patches out there (most recently [1]) which implement a
subset of the KUnit API in userspace, which has the twin advantages of
making test code more consistent overall, and allowing some tests to
be available both as KUnit tests and separate userspace tests (so we
get the best of both worlds). Having a standard 'userspace kunit'
implementation is definitely something I've thought about before, so
I'll probably play around with that when I get some time.

Otherwise, if Shuah's okay with it, having these userspace tests be
selftests seems at the very least an appropriate stopgap measure,
which gets us some tooling and CI. I've always thought of selftests as
"testing the running kernel", rather than the tree under test, but as
long as it's clear that this is happening, there's no technical reason
to avoid it,.

Cheers,
-- David

[1]: https://lore.kernel.org/all/20240625211803.2750563-5-willy@infradead.o=
rg/

--0000000000005cd4ce061c66a405
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEILO2dCVvPVz+qtILjt7+iN79ZxGVUffilaCbP4x4tYPgMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcwNDA3MTAzMFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMavB4
1h5njIvmCiQ3Klrc3pzEWAIPuuUs+zmjwqdFDNeOKmlaswHb4/b5E88QEM21YtWdRgKFTMfB1ZVn
wWFaeBrx69k70IxFhHz4Z7PogmAaRdjwSVsUWkxr9vObaKy7s62qMAbJZR+7jxDwNVAtOHkrluDB
NzbRFijy3//EjDdyk2akuvhZWy4jTBOC2elMr27Fyq57Fcw7AkD/rKxMjLjTF+2MBoryx6byZQfy
r6fcEg6qKbFYZInyNRkbSrOWFcjXbJng98wpDkf9T4K6Gbh0Uo6S1WwW6j/t/oIVPuWNBAGGJYQD
ccsFmY4Ha6Q5uezGZ7bg2mGEuBBituGA
--0000000000005cd4ce061c66a405--

