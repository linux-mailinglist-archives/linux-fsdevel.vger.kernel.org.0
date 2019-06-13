Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2A43F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfFMPzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:55:24 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40483 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbfFMPzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:55:24 -0400
Received: by mail-yb1-f193.google.com with SMTP id g62so8034483ybg.7;
        Thu, 13 Jun 2019 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdr53aHyHjSvDHADpgbpltDhzujbfQKxlRMp+8ySyoM=;
        b=Clnuqr9Ff26txeSkVv7cRgw4KYrTQZ1cWpAeN9JOgfWJ3pPjfZoicShEnJqRjLI1yZ
         OmVzdb/eVNccL1j01pIkND/Vo5TgIuA9tUyaUl+NExqGz/oiESBb2B6lf/X7K+1lYLa3
         ojdvNlH+sxbKJJ5VEEgU4g+YOr8JLdmghTkjxWUfvHhHTTJWnBxn2GyxX4RFrffu4toH
         9J1HHSWozPYawinaj58mQkEPihhIRcDBV2SMn2mGyaYzDBMiFE0F67Mj5ldglV0G9JV+
         ewVHI54pr6qasbr4P+hc69VgP7aGZgVVW6cpu9lRq5LSZ31twgdTeEheW3B2Gp1yqJ8I
         MvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdr53aHyHjSvDHADpgbpltDhzujbfQKxlRMp+8ySyoM=;
        b=P9uxiDWAPwF7KI/PuApeuMVaBWgnS+8Ki7+RoYA7Jy29qXY03/f1dIyf1cpNjmT4J/
         Ao9Y1PvHqf/EPZtrDA2ovaz5VT7r8hxh8yPmJNyBkA1m6zdu72S352XKKFVtVZLxgcV2
         G8Vqne7gnXQeC5I7K1xI3P5VkM5gpDYFxSmOCKbU/47VNxezemtObfJCm4pXc6r4Kfnq
         5GS27zxRxmhD6XdsGPUWmhXaKoFWUi+tOXQ89wnDraQlclvNhpi2Di4YW8UJ9uR+o+JT
         BMuGzPrnNb8s3dW45AzBv9+MfJxdtBpKMND+dVvr9XBG5K9kTZLMIbest00S9tRBe38X
         kTlA==
X-Gm-Message-State: APjAAAVe+lqpZ/sIca5g2lEkj5q8kMgX6XEysNeLDBG0SfAMalrrSMVl
        L+xeKjsvkxSTtB5tDxn3tQ8PUJ5Uo73+21JutYY=
X-Google-Smtp-Source: APXvYqxnEJpjzbzAvUiB03xDHPZ7BdZN4CaTcDE4nvK6yKYCncvL36cSPvJUuVdhsBc8qAAJq062gLp5z5BmtTiOrmI=
X-Received: by 2002:a25:b202:: with SMTP id i2mr42426600ybj.439.1560441322212;
 Thu, 13 Jun 2019 08:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190612172408.22671-1-amir73il@gmail.com> <20190612183156.GA27576@fieldses.org>
 <CAJfpegvj0NHQrPcHFd=b47M-uz2CY6Hnamk_dJvcrUtwW65xBw@mail.gmail.com>
 <20190613143151.GC2145@fieldses.org> <CAOQ4uxhXjuqMDbUq_4=oL8QETuUF3bs0V5qE9bNDJDind6F2pQ@mail.gmail.com>
 <e1d60ba87b311da9fbca9cfd291b48f4798f9462.camel@kernel.org>
In-Reply-To: <e1d60ba87b311da9fbca9cfd291b48f4798f9462.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Jun 2019 18:55:10 +0300
Message-ID: <CAOQ4uxhs7R-q-p+dUcrWOSfTBvd5UGYvDzyRYQhMnFwNDOM0gA@mail.gmail.com>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write lease
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b43a0b058b368e30"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b43a0b058b368e30
Content-Type: text/plain; charset="UTF-8"

> > I'm fine with targeting 5.3 and I'm fine with all suggested changes
> > and adding some of my own. At this point we no longer need wcount
> > variable and code becomes more readable without it.
> > See attached patch (also tested).
> >
> > Thanks,
> > Amir.
>
> Thanks Amir. In that case, I'll go ahead and pick this up for v5.3, and
> will get it into linux-next soon.
>

While we are polishing the patch to perfection, could also get rid of
ret variable...
Not a must.

Thanks,
Amir.

--000000000000b43a0b058b368e30
Content-Type: text/plain; charset="US-ASCII"; 
	name="v4-0001-locks-eliminate-false-positive-conflicts-for-writ.patch.txt"
Content-Disposition: attachment; 
	filename="v4-0001-locks-eliminate-false-positive-conflicts-for-writ.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jwuugmeg0>
X-Attachment-Id: f_jwuugmeg0

RnJvbSAxY2ViZTg2MmZhYjRiNGVhYjA1MzUzYjIwY2VhMjQ0MWZlMTc4N2NhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDcgSnVuIDIwMTkgMTc6MjQ6MzggKzAzMDAKU3ViamVjdDogW1BBVENIIHY0XSBs
b2NrczogZWxpbWluYXRlIGZhbHNlIHBvc2l0aXZlIGNvbmZsaWN0cyBmb3Igd3JpdGUgbGVhc2UK
CmNoZWNrX2NvbmZsaWN0aW5nX29wZW4oKSBpcyBjaGVja2luZyBmb3IgZXhpc3RpbmcgZmQncyBv
cGVuIGZvciByZWFkIG9yCmZvciB3cml0ZSBiZWZvcmUgYWxsb3dpbmcgdG8gdGFrZSBhIHdyaXRl
IGxlYXNlLiAgVGhlIGNoZWNrIHRoYXQgd2FzCmltcGxlbWVudGVkIHVzaW5nIGlfY291bnQgYW5k
IGRfY291bnQgaXMgYW4gYXBwcm94aW1hdGlvbiB0aGF0IGhhcwpzZXZlcmFsIGZhbHNlIHBvc2l0
aXZlcy4gIEZvciBleGFtcGxlLCBvdmVybGF5ZnMgc2luY2UgdjQuMTksIHRha2VzIGFuCmV4dHJh
IHJlZmVyZW5jZSBvbiB0aGUgZGVudHJ5OyBBbiBvcGVuIHdpdGggT19QQVRIIHRha2VzIGEgcmVm
ZXJlbmNlIG9uCnRoZSBkZW50cnkgYWx0aG91Z2ggdGhlIGZpbGUgY2Fubm90IGJlIHJlYWQgbm9y
IHdyaXR0ZW4uCgpDaGFuZ2UgdGhlIGltcGxlbWVudGF0aW9uIHRvIHVzZSBpX3JlYWRjb3VudCBh
bmQgaV93cml0ZWNvdW50IHRvCmVsaW1pbmF0ZSB0aGUgZmFsc2UgcG9zaXRpdmUgY29uZmxpY3Rz
IGFuZCBhbGxvdyBhIHdyaXRlIGxlYXNlIHRvIGJlCnRha2VuIG9uIGFuIG92ZXJsYXlmcyBmaWxl
LgoKVGhlIGNoYW5nZSBvZiBiZWhhdmlvciB3aXRoIGV4aXN0aW5nIGZkJ3Mgb3BlbiB3aXRoIE9f
UEFUSCBpcyBzeW1tZXRyaWMKdy5yLnQuIGN1cnJlbnQgYmVoYXZpb3Igb2YgbGVhc2UgYnJlYWtl
cnMgLSBhbiBvcGVuIHdpdGggT19QQVRIIGN1cnJlbnRseQpkb2VzIG5vdCBicmVhayBhIHdyaXRl
IGxlYXNlLgoKVGhpcyBpbmNyZWFzZXMgdGhlIHNpemUgb2Ygc3RydWN0IGlub2RlIGJ5IDQgYnl0
ZXMgb24gMzJiaXQgYXJjaHMgd2hlbgpDT05GSUdfRklMRV9MT0NLSU5HIGlzIGRlZmluZWQgYW5k
IENPTkZJR19JTUEgd2FzIG5vdCBhbHJlYWR5CmRlZmluZWQuCgpTaWduZWQtb2ZmLWJ5OiBBbWly
IEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL2xvY2tzLmMgICAgICAgICB8
IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9s
aW51eC9mcy5oIHwgIDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAx
NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9sb2Nrcy5jIGIvZnMvbG9ja3MuYwppbmRl
eCBlYzFlNGE1ZGY2MjkuLjJlODZkZmY3MWYzYSAxMDA2NDQKLS0tIGEvZnMvbG9ja3MuYworKysg
Yi9mcy9sb2Nrcy5jCkBAIC0xNzUzLDEwICsxNzUzLDEwIEBAIGludCBmY250bF9nZXRsZWFzZShz
dHJ1Y3QgZmlsZSAqZmlscCkKIH0KIAogLyoqCi0gKiBjaGVja19jb25mbGljdGluZ19vcGVuIC0g
c2VlIGlmIHRoZSBnaXZlbiBkZW50cnkgcG9pbnRzIHRvIGEgZmlsZSB0aGF0IGhhcworICogY2hl
Y2tfY29uZmxpY3Rpbmdfb3BlbiAtIHNlZSBpZiB0aGUgZ2l2ZW4gZmlsZSBwb2ludHMgdG8gYW4g
aW5vZGUgdGhhdCBoYXMKICAqCQkJICAgIGFuIGV4aXN0aW5nIG9wZW4gdGhhdCB3b3VsZCBjb25m
bGljdCB3aXRoIHRoZQogICoJCQkgICAgZGVzaXJlZCBsZWFzZS4KLSAqIEBkZW50cnk6CWRlbnRy
eSB0byBjaGVjaworICogQGZpbHA6CWZpbGUgdG8gY2hlY2sKICAqIEBhcmc6CXR5cGUgb2YgbGVh
c2UgdGhhdCB3ZSdyZSB0cnlpbmcgdG8gYWNxdWlyZQogICogQGZsYWdzOgljdXJyZW50IGxvY2sg
ZmxhZ3MKICAqCkBAIC0xNzY0LDMwICsxNzY0LDQyIEBAIGludCBmY250bF9nZXRsZWFzZShzdHJ1
Y3QgZmlsZSAqZmlscCkKICAqIGNvbmZsaWN0IHdpdGggdGhlIGxlYXNlIHdlJ3JlIHRyeWluZyB0
byBzZXQuCiAgKi8KIHN0YXRpYyBpbnQKLWNoZWNrX2NvbmZsaWN0aW5nX29wZW4oY29uc3Qgc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LCBjb25zdCBsb25nIGFyZywgaW50IGZsYWdzKQorY2hlY2tfY29u
ZmxpY3Rpbmdfb3BlbihzdHJ1Y3QgZmlsZSAqZmlscCwgY29uc3QgbG9uZyBhcmcsIGludCBmbGFn
cykKIHsKLQlpbnQgcmV0ID0gMDsKLQlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZGVudHJ5LT5kX2lu
b2RlOworCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBsb2Nrc19pbm9kZShmaWxwKTsKKwlpbnQgc2Vs
Zl93Y291bnQgPSAwLCBzZWxmX3Jjb3VudCA9IDA7CiAKIAlpZiAoZmxhZ3MgJiBGTF9MQVlPVVQp
CiAJCXJldHVybiAwOwogCi0JaWYgKChhcmcgPT0gRl9SRExDSykgJiYgaW5vZGVfaXNfb3Blbl9m
b3Jfd3JpdGUoaW5vZGUpKQotCQlyZXR1cm4gLUVBR0FJTjsKKwlpZiAoYXJnID09IEZfUkRMQ0sp
CisJCXJldHVybiBpbm9kZV9pc19vcGVuX2Zvcl93cml0ZShpbm9kZSkgPyAtRUFHQUlOIDogMDsK
KwllbHNlIGlmIChhcmcgIT0gRl9XUkxDSykKKwkJcmV0dXJuIDA7CisKKwkvKgorCSAqIE1ha2Ug
c3VyZSB0aGF0IG9ubHkgcmVhZC93cml0ZSBjb3VudCBpcyBmcm9tIGxlYXNlIHJlcXVlc3Rvci4K
KwkgKiBOb3RlIHRoYXQgdGhpcyB3aWxsIHJlc3VsdCBpbiBkZW55aW5nIHdyaXRlIGxlYXNlcyB3
aGVuIGlfd3JpdGVjb3VudAorCSAqIGlzIG5lZ2F0aXZlLCB3aGljaCBpcyB3aGF0IHdlIHdhbnQu
ICAoV2Ugc2hvdWxkbid0IGdyYW50IHdyaXRlIGxlYXNlcworCSAqIG9uIGZpbGVzIG9wZW4gZm9y
IGV4ZWN1dGlvbi4pCisJICovCisJaWYgKGZpbHAtPmZfbW9kZSAmIEZNT0RFX1dSSVRFKQorCQlz
ZWxmX3djb3VudCA9IDE7CisJZWxzZSBpZiAoZmlscC0+Zl9tb2RlICYgRk1PREVfUkVBRCkKKwkJ
c2VsZl9yY291bnQgPSAxOwogCi0JaWYgKChhcmcgPT0gRl9XUkxDSykgJiYgKChkX2NvdW50KGRl
bnRyeSkgPiAxKSB8fAotCSAgICAoYXRvbWljX3JlYWQoJmlub2RlLT5pX2NvdW50KSA+IDEpKSkK
LQkJcmV0ID0gLUVBR0FJTjsKKwlpZiAoYXRvbWljX3JlYWQoJmlub2RlLT5pX3dyaXRlY291bnQp
ICE9IHNlbGZfd2NvdW50IHx8CisJICAgIGF0b21pY19yZWFkKCZpbm9kZS0+aV9yZWFkY291bnQp
ICE9IHNlbGZfcmNvdW50KQorCQlyZXR1cm4gLUVBR0FJTjsKIAotCXJldHVybiByZXQ7CisJcmV0
dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQKIGdlbmVyaWNfYWRkX2xlYXNlKHN0cnVjdCBmaWxlICpm
aWxwLCBsb25nIGFyZywgc3RydWN0IGZpbGVfbG9jayAqKmZscCwgdm9pZCAqKnByaXYpCiB7CiAJ
c3RydWN0IGZpbGVfbG9jayAqZmwsICpteV9mbCA9IE5VTEwsICpsZWFzZTsKLQlzdHJ1Y3QgZGVu
dHJ5ICpkZW50cnkgPSBmaWxwLT5mX3BhdGguZGVudHJ5OwotCXN0cnVjdCBpbm9kZSAqaW5vZGUg
PSBkZW50cnktPmRfaW5vZGU7CisJc3RydWN0IGlub2RlICppbm9kZSA9IGxvY2tzX2lub2RlKGZp
bHApOwogCXN0cnVjdCBmaWxlX2xvY2tfY29udGV4dCAqY3R4OwogCWJvb2wgaXNfZGVsZWcgPSAo
KmZscCktPmZsX2ZsYWdzICYgRkxfREVMRUc7CiAJaW50IGVycm9yOwpAQCAtMTgyMiw3ICsxODM0
LDcgQEAgZ2VuZXJpY19hZGRfbGVhc2Uoc3RydWN0IGZpbGUgKmZpbHAsIGxvbmcgYXJnLCBzdHJ1
Y3QgZmlsZV9sb2NrICoqZmxwLCB2b2lkICoqcHIKIAlwZXJjcHVfZG93bl9yZWFkKCZmaWxlX3J3
c2VtKTsKIAlzcGluX2xvY2soJmN0eC0+ZmxjX2xvY2spOwogCXRpbWVfb3V0X2xlYXNlcyhpbm9k
ZSwgJmRpc3Bvc2UpOwotCWVycm9yID0gY2hlY2tfY29uZmxpY3Rpbmdfb3BlbihkZW50cnksIGFy
ZywgbGVhc2UtPmZsX2ZsYWdzKTsKKwllcnJvciA9IGNoZWNrX2NvbmZsaWN0aW5nX29wZW4oZmls
cCwgYXJnLCBsZWFzZS0+ZmxfZmxhZ3MpOwogCWlmIChlcnJvcikKIAkJZ290byBvdXQ7CiAKQEAg
LTE4NzksNyArMTg5MSw3IEBAIGdlbmVyaWNfYWRkX2xlYXNlKHN0cnVjdCBmaWxlICpmaWxwLCBs
b25nIGFyZywgc3RydWN0IGZpbGVfbG9jayAqKmZscCwgdm9pZCAqKnByCiAJICogcHJlY2VkZXMg
dGhlc2UgY2hlY2tzLgogCSAqLwogCXNtcF9tYigpOwotCWVycm9yID0gY2hlY2tfY29uZmxpY3Rp
bmdfb3BlbihkZW50cnksIGFyZywgbGVhc2UtPmZsX2ZsYWdzKTsKKwllcnJvciA9IGNoZWNrX2Nv
bmZsaWN0aW5nX29wZW4oZmlscCwgYXJnLCBsZWFzZS0+ZmxfZmxhZ3MpOwogCWlmIChlcnJvcikg
ewogCQlsb2Nrc191bmxpbmtfbG9ja19jdHgobGVhc2UpOwogCQlnb3RvIG91dDsKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaAppbmRleCA3OWZmYTI5
NThiZDguLjJkNTVmMWI2NDAxNCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oCisrKyBi
L2luY2x1ZGUvbGludXgvZnMuaApAQCAtNjk0LDcgKzY5NCw3IEBAIHN0cnVjdCBpbm9kZSB7CiAJ
YXRvbWljX3QJCWlfY291bnQ7CiAJYXRvbWljX3QJCWlfZGlvX2NvdW50OwogCWF0b21pY190CQlp
X3dyaXRlY291bnQ7Ci0jaWZkZWYgQ09ORklHX0lNQQorI2lmIGRlZmluZWQoQ09ORklHX0lNQSkg
fHwgZGVmaW5lZChDT05GSUdfRklMRV9MT0NLSU5HKQogCWF0b21pY190CQlpX3JlYWRjb3VudDsg
Lyogc3RydWN0IGZpbGVzIG9wZW4gUk8gKi8KICNlbmRpZgogCXVuaW9uIHsKQEAgLTI4OTUsNyAr
Mjg5NSw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpbm9kZV9pc19vcGVuX2Zvcl93cml0ZShjb25z
dCBzdHJ1Y3QgaW5vZGUgKmlub2RlKQogCXJldHVybiBhdG9taWNfcmVhZCgmaW5vZGUtPmlfd3Jp
dGVjb3VudCkgPiAwOwogfQogCi0jaWZkZWYgQ09ORklHX0lNQQorI2lmIGRlZmluZWQoQ09ORklH
X0lNQSkgfHwgZGVmaW5lZChDT05GSUdfRklMRV9MT0NLSU5HKQogc3RhdGljIGlubGluZSB2b2lk
IGlfcmVhZGNvdW50X2RlYyhzdHJ1Y3QgaW5vZGUgKmlub2RlKQogewogCUJVR19PTighYXRvbWlj
X3JlYWQoJmlub2RlLT5pX3JlYWRjb3VudCkpOwotLSAKMi4xNy4xCgo=
--000000000000b43a0b058b368e30--
