Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59221B7E45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgDXSuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgDXSuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:50:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F24C09B048
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:50:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m67so11194217qke.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZM+LG1Zez5y941FbW4WumbqzFtcCcrimhVxSm9FjHc=;
        b=qtTLXdVuAjvHuqsB5iprNLaXSWUQtFe9YTb8l8f42Gn5TtZxQrB2WNvJRgTVK9iVMD
         tctiDV+ddRRSgiu+8tLWw3fISu4CWdxTj8WnXZSa6C9rVEOFv6+4YisGLbI18ZHD0cMB
         bdAH6c+ZyaZ9q0f6WTOck9Bbr+k/AQhxqohln+MTofhdsXF0Y/+dqHG/j8Eon06utDTs
         Y03jVVzsAtOdZBWiw8eb9CGPGr7XQdFrVq94NRU1RpsHqqOMVjT2Qh5p2HTpLWuTBqR1
         RLnKZdUmk84UoiotTI0jbJwvw9gO0PQCuU7zy/Ub1Y0imU3KhAXHeLqJ0zw25F4+rtvI
         xlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZM+LG1Zez5y941FbW4WumbqzFtcCcrimhVxSm9FjHc=;
        b=avxA0MAfqLMDDq42gCmec3kC8COeh/MRo5F7/Avqn6kLv/GZoErKxWHbnok1Aa+vUk
         OiCGZnKdpiS4X7dmumJyFvuaKWmRDCHFnkEOjf53/J6OmYf8G+SKhLoHz4/A0LGAC7ZE
         uQkdbkOtTX1csRIPOTn6lJ3LU6j4xQDyhC2tKt4PXuePIO+gGEqOuLCWHaEblpfn3mF1
         okbeyyLNeRikiQ0OAx/cap55IvFP5C+GzK18HXUD1AN8gnNTY8fw7ckZepzh9+oxg2FX
         eTpvqfm4dd9QKrRnK/4KW3A8AAsnaaaauBl2c0ASx4ql7BBgq44rYpNSuV6fbyDeyApB
         CApQ==
X-Gm-Message-State: AGi0PubTqnDmqw9l91Idfrj7A74U+AmztkwAkkDxchimTwmIhQH20xrT
        w0lm20xbgk8i0AHxbo9fqiXBpI9KW2MhyDlKQwdoxg==
X-Google-Smtp-Source: APiQypIYlU+6+bTrKH4r+RgjJdj2JxSLnhU7xPkbFN7R2hDe83+76Xa3VkNLhazas1r3GxIRP7P0Bt2wTUSGs9FLf5M=
X-Received: by 2002:a05:620a:41a:: with SMTP id 26mr10065764qkp.421.1587754212911;
 Fri, 24 Apr 2020 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200424025057.118641-1-khazhy@google.com> <2bd5fcb37337dd7248a5cb245bf8dde9@suse.de>
In-Reply-To: <2bd5fcb37337dd7248a5cb245bf8dde9@suse.de>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Fri, 24 Apr 2020 11:50:01 -0700
Message-ID: <CACGdZYK7MHJT5qgGWA+3HNquLx=on2hdSVbsj9knvdpx29+C7g@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: fix missing wakeup for ovflist in ep_poll_callback
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, r@hev.cc,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e3f1f705a40dd593"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000e3f1f705a40dd593
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 24, 2020 at 3:11 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> Hi Khazhismel,
>
> That seems to be correct. The patch you refer 339ddb53d373
> relies on callback path, which *should* wake up, not the path
> which harvests events (thus unnecessary wakeups).  When we add
> a new event to the ->ovflist nobody wakes up the waiters,
> thus missing wakeup. You are right.
>
> May I suggest a small change in order to avoid one new goto?
> We can add a new event in either ->ovflist or ->rdllist and
> then wakeup should happen. So simple 'else if' branch should
> do things right, something like the following:
>

Thanks for the review! I agree, I'll send a v2 without new goto

--000000000000e3f1f705a40dd593
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPBgYJKoZIhvcNAQcCoIIO9zCCDvMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxpMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEE
RTBDMEEGCCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3Nt
aW1lY2EyMDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2
MDSgMqAwhi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0G
CSqGSIb3DQEBCwUAA4IBAQCM37MMrUvgKBlbkfClP3kSaljmhqmtbhA855Dxg0ExJEaXMLDnSEod
BZm4+79Rcp/gCP67jOVlkJHRSTPco73qpOMg8Q9aXMbcysY/rm3bul1wpALN1dQh8STLYiDdNBXJ
LJZxf7nC3+xcLEb0+RTU05lUVCzmixKU665YZspUCQttLL7LxY8k7vpLtXeX7+OP6mxVsEOca9CI
fEybv+pk4+vHfIg3XiUK2Qs4qTHSFZ09OuPSRqkO1CY/AET8DPwXkO2ByN/gdUYo1po23haQT7kB
qhSVsP/BmQ7F6qER6f8mDR3F0uH26W4ZFxa/htst/Pb0qoQnkyDXLPSLJa9UMYICYTCCAl0CAQEw
XzBLMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xv
YmFsU2lnbiBTTUlNRSBDQSAyMDE4AhABiQs/r7YF6iuE/NQrZF28MA0GCWCGSAFlAwQCAQUAoIHU
MC8GCSqGSIb3DQEJBDEiBCD3an30+TjbH7EtlKmzIIeTT+B2JR+9+ee/pRvaJg6YNDAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA0MjQxODUwMTNaMGkGCSqGSIb3
DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAE
ggEAP6zj7FoNFteQTVRtRngQmo7yhfDYgZNqLuDET/+qFcMPvskgz+Q3KZ1E0sjHXqiSwc59x03b
b2R4wojbYiE65iblSXd/+9MroDGwCCwT3OOnVRyzuuLifvBgrimbZ9CjeyazOBxExSkZQs2lmLfP
ZP4LZ2W0Yn1sZKSFy4YCKNMBr02ZyVAof1fNpggyoK3j/ElbhcHyhH+s+zGi4t+8KO+pwbUq9aFk
m2BXs72DzEXyc8utGGnXVjcMk+OitIUKqkfj07OZM/v6F9sMxHTM6Qis1cLdvaWpzWGzC1DiKMa3
A47m37wRAfrcUN1J7w9/zL5I+vNqov2onE8UybcRhA==
--000000000000e3f1f705a40dd593--
