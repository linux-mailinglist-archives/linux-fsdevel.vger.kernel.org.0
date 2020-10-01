Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0E280703
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgJASjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbgJASiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B0C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 11:38:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a22so5500202ljp.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DC/JZdHA7VFPn3kJbz8B8j6l5xIuNA69Y7a5B2HGZ0g=;
        b=I/PKDe/NpcjUeyzvC7XSNcr8drDkU4Q4Ht9hAApdjdQ1MVVQs+tUGMwNluKNcRrA44
         SQQqDDhllaImFCSdGL9v4LMFwPQ2VywlK5SVppTG1CpsuyoA6bYptWkLbm1KkeJl96nj
         Nt9dR5pd7IvJVvCcW1OvS58YEP9kcs9T2bnng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DC/JZdHA7VFPn3kJbz8B8j6l5xIuNA69Y7a5B2HGZ0g=;
        b=AP3t9AbTkSUgWd9WwIU5wTqaE8B1340GttreJIRQG+l81ICW6EDDhJWAP7K+S9DkXI
         pXK5aju2OGECDJ6//xOWlct58Zu/fWkBSJ6XB2OYJRSkSkNWl6+xuNGN4jH+VYxOEnsn
         ZYo5eL3qZJ8lHaBe0vE38fDF8cqaPlqOKsd5GJZq1hOYxZzYU0rAiPMKOx8rC+2uBWJB
         0BbrLphOElaOo8Oqy5G9f3zcTU/lX9mxzpQDcmgvkbF3dQrnr56eE7pY+rRkuz1jP/AU
         3nGKecnyrqu42e/f4JdeuwJXHOV4d//jg9TEH+BTy3lX93keZyqGYg9a8S9HEzSXXdfX
         CQdg==
X-Gm-Message-State: AOAM533J2CYRb1HBHTuUDjHX4ZiKaT5C+EDbihRnPJz0QT+BrB7nfSNU
        gZYvTjT3vCAPLdIZnYJezsDkH8iX1pEf9Q==
X-Google-Smtp-Source: ABdhPJygo8RRZNWLv3DMPiZ9PTh60e3mBvzYFd4hl1+HTPC6/B5wb+j3mbyI7N26fFY+rGYy/sOGRQ==
X-Received: by 2002:a2e:7e10:: with SMTP id z16mr2804473ljc.439.1601577527513;
        Thu, 01 Oct 2020 11:38:47 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id h11sm647367lfd.21.2020.10.01.11.38.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 11:38:46 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z19so7841792lfr.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 11:38:45 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr2788235lfr.352.1601577525362;
 Thu, 01 Oct 2020 11:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <bfa88b5ad6f069b2b679316b9e495a970130416c.1601567868.git.josef@toxicpanda.com>
 <CAHk-=wj9-Cc-qZUrTZ=V=LrHj-wK++kuOrxbiFQCkbu9THycEQ@mail.gmail.com> <eb829164-8035-92ee-e7ba-8e6b062ab1d8@toxicpanda.com>
In-Reply-To: <eb829164-8035-92ee-e7ba-8e6b062ab1d8@toxicpanda.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Oct 2020 11:38:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwZxj0WdGk2ryax574ut1xPq-=12DcFxZgq9rmCBdDbg@mail.gmail.com>
Message-ID: <CAHk-=whwZxj0WdGk2ryax574ut1xPq-=12DcFxZgq9rmCBdDbg@mail.gmail.com>
Subject: Re: [PATCH] pipe: fix hang when racing with a wakeup
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007af7d205b0a053eb"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000007af7d205b0a053eb
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 1, 2020 at 10:41 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Obviously not ideal, but I figured the simpler fix was better for stable, and
> then we could work out something better.

I think the attached is the proper fix, and it's not really any more
complicated.

The patch is bigger, but it's pretty obvious: get rid of the
non-specific "pipe_wait()", and replace them with specific versions
that wait for a particular thing.

NOTE! Entirely untested. It seems to build fine for me, and it _looks_
obvious, but I haven't actually rebooted to see if it works at all. I
don't think I have any real splice-heavy test cases.

Mind trying this out on the load that showed problems?

                    Linus

--0000000000007af7d205b0a053eb
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfr5w1530>
X-Attachment-Id: f_kfr5w1530

IGZzL3BpcGUuYyAgICAgICAgICAgICAgICAgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLQogZnMvc3BsaWNlLmMgICAgICAgICAgICAgICB8ICA4ICsr
Ky0tLQogaW5jbHVkZS9saW51eC9waXBlX2ZzX2kuaCB8ICA1ICsrLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgNDggaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvcGlw
ZS5jIGIvZnMvcGlwZS5jCmluZGV4IDYwZGJlZTQ1NzE0My4uNzYzOWUxMTE3NTIxIDEwMDY0NAot
LS0gYS9mcy9waXBlLmMKKysrIGIvZnMvcGlwZS5jCkBAIC0xMDYsMjUgKzEwNiw2IEBAIHZvaWQg
cGlwZV9kb3VibGVfbG9jayhzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlMSwKIAl9CiB9CiAK
LS8qIERyb3AgdGhlIGlub2RlIHNlbWFwaG9yZSBhbmQgd2FpdCBmb3IgYSBwaXBlIGV2ZW50LCBh
dG9taWNhbGx5ICovCi12b2lkIHBpcGVfd2FpdChzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBl
KQotewotCURFRklORV9XQUlUKHJkd2FpdCk7Ci0JREVGSU5FX1dBSVQod3J3YWl0KTsKLQotCS8q
Ci0JICogUGlwZXMgYXJlIHN5c3RlbS1sb2NhbCByZXNvdXJjZXMsIHNvIHNsZWVwaW5nIG9uIHRo
ZW0KLQkgKiBpcyBjb25zaWRlcmVkIGEgbm9uaW50ZXJhY3RpdmUgd2FpdDoKLQkgKi8KLQlwcmVw
YXJlX3RvX3dhaXQoJnBpcGUtPnJkX3dhaXQsICZyZHdhaXQsIFRBU0tfSU5URVJSVVBUSUJMRSk7
Ci0JcHJlcGFyZV90b193YWl0KCZwaXBlLT53cl93YWl0LCAmd3J3YWl0LCBUQVNLX0lOVEVSUlVQ
VElCTEUpOwotCXBpcGVfdW5sb2NrKHBpcGUpOwotCXNjaGVkdWxlKCk7Ci0JZmluaXNoX3dhaXQo
JnBpcGUtPnJkX3dhaXQsICZyZHdhaXQpOwotCWZpbmlzaF93YWl0KCZwaXBlLT53cl93YWl0LCAm
d3J3YWl0KTsKLQlwaXBlX2xvY2socGlwZSk7Ci19Ci0KIHN0YXRpYyB2b2lkIGFub25fcGlwZV9i
dWZfcmVsZWFzZShzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlLAogCQkJCSAgc3RydWN0IHBp
cGVfYnVmZmVyICpidWYpCiB7CkBAIC0xMDM1LDEyICsxMDE2LDUyIEBAIFNZU0NBTExfREVGSU5F
MShwaXBlLCBpbnQgX191c2VyICosIGZpbGRlcykKIAlyZXR1cm4gZG9fcGlwZTIoZmlsZGVzLCAw
KTsKIH0KIAorLyoKKyAqIFRoaXMgaXMgdGhlIHN0dXBpZCAid2FpdCBmb3IgcGlwZSB0byBiZSBy
ZWFkYWJsZSBvciB3cml0YWJsZSIKKyAqIG1vZGVsLgorICoKKyAqIFNlZSBwaXBlX3JlYWQvd3Jp
dGUoKSBmb3IgdGhlIHByb3BlciBraW5kIG9mIGV4Y2x1c2l2ZSB3YWl0LAorICogYnV0IHRoYXQg
cmVxdWlyZXMgdGhhdCB3ZSB3YWtlIHVwIGFueSBvdGhlciByZWFkZXJzL3dyaXRlcnMKKyAqIGlm
IHdlIHRoZW4gZG8gbm90IGVuZCB1cCByZWFkaW5nIGV2ZXJ5dGhpbmcgKGllIHRoZSB3aG9sZQor
ICogIndha2VfbmV4dF9yZWFkZXIvd3JpdGVyIiBsb2dpYyBpbiBwaXBlX3JlYWQvd3JpdGUoKSku
CisgKi8KK3ZvaWQgcGlwZV93YWl0X3JlYWRhYmxlKHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBp
cGUpCit7CisJcGlwZV91bmxvY2socGlwZSk7CisJd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHBp
cGUtPnJkX3dhaXQsIHBpcGVfcmVhZGFibGUocGlwZSkpOworCXBpcGVfbG9jayhwaXBlKTsKK30K
Kwordm9pZCBwaXBlX3dhaXRfd3JpdGFibGUoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSkK
K3sKKwlwaXBlX3VubG9jayhwaXBlKTsKKwl3YWl0X2V2ZW50X2ludGVycnVwdGlibGUocGlwZS0+
d3Jfd2FpdCwgcGlwZV93cml0YWJsZShwaXBlKSk7CisJcGlwZV9sb2NrKHBpcGUpOworfQorCisv
KgorICogVGhpcyBkZXBlbmRzIG9uIGJvdGggdGhlIChoZXJlKSB3YWl0IGFuZCB0aGUgd2FrZXVw
ICh3YWtlX3VwX3BhcnRuZXIpCisgKiBob2xkaW5nIHRoZSBwaXBlIGxvY2ssIHNvICIqY250IiBp
cyBzdGFibGUgYW5kIHdlIGtub3cgYSB3YWtldXAgY2Fubm90CisgKiByYWNlIHdpdGggdGhlIGNv
dW50IGNoZWNrIGFuZCB3YWl0cXVldWUgcHJlcC4KKyAqCisgKiBOb3JtYWxseSBpbiBvcmRlciB0
byBhdm9pZCByYWNlcywgeW91J2QgZG8gdGhlIHByZXBhcmVfdG9fd2FpdCgpIGZpcnN0LAorICog
dGhlbiBjaGVjayB0aGUgY29uZGl0aW9uIHlvdSdyZSB3YWl0aW5nIGZvciwgYW5kIG9ubHkgdGhl
biBzbGVlcC4gQnV0CisgKiBiZWNhdXNlIG9mIHRoZSBwaXBlIGxvY2ssIHdlIGNhbiBjaGVjayB0
aGUgY29uZGl0aW9uIGJlZm9yZSBiZWluZyBvbgorICogdGhlIHdhaXQgcXVldWUuCisgKgorICog
V2UgdXNlIHRoZSAncmRfd2FpdCcgd2FpdHF1ZXVlIGZvciBwaXBlIHBhcnRuZXIgd2FpdGluZy4K
KyAqLwogc3RhdGljIGludCB3YWl0X2Zvcl9wYXJ0bmVyKHN0cnVjdCBwaXBlX2lub2RlX2luZm8g
KnBpcGUsIHVuc2lnbmVkIGludCAqY250KQogeworCURFRklORV9XQUlUKHJkd2FpdCk7CiAJaW50
IGN1ciA9ICpjbnQ7CiAKIAl3aGlsZSAoY3VyID09ICpjbnQpIHsKLQkJcGlwZV93YWl0KHBpcGUp
OworCQlwcmVwYXJlX3RvX3dhaXQoJnBpcGUtPnJkX3dhaXQsICZyZHdhaXQsIFRBU0tfSU5URVJS
VVBUSUJMRSk7CisJCXBpcGVfdW5sb2NrKHBpcGUpOworCQlzY2hlZHVsZSgpOworCQlmaW5pc2hf
d2FpdCgmcGlwZS0+cmRfd2FpdCwgJnJkd2FpdCk7CisJCXBpcGVfbG9jayhwaXBlKTsKIAkJaWYg
KHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKQogCQkJYnJlYWs7CiAJfQpAQCAtMTA1MCw3ICsxMDcx
LDYgQEAgc3RhdGljIGludCB3YWl0X2Zvcl9wYXJ0bmVyKHN0cnVjdCBwaXBlX2lub2RlX2luZm8g
KnBpcGUsIHVuc2lnbmVkIGludCAqY250KQogc3RhdGljIHZvaWQgd2FrZV91cF9wYXJ0bmVyKHN0
cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUpCiB7CiAJd2FrZV91cF9pbnRlcnJ1cHRpYmxlX2Fs
bCgmcGlwZS0+cmRfd2FpdCk7Ci0Jd2FrZV91cF9pbnRlcnJ1cHRpYmxlX2FsbCgmcGlwZS0+d3Jf
d2FpdCk7CiB9CiAKIHN0YXRpYyBpbnQgZmlmb19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0
cnVjdCBmaWxlICpmaWxwKQpkaWZmIC0tZ2l0IGEvZnMvc3BsaWNlLmMgYi9mcy9zcGxpY2UuYwpp
bmRleCBkN2M4YTdjNGRiMDcuLmMzZDAwZGZjNzM0NCAxMDA2NDQKLS0tIGEvZnMvc3BsaWNlLmMK
KysrIGIvZnMvc3BsaWNlLmMKQEAgLTU2Myw3ICs1NjMsNyBAQCBzdGF0aWMgaW50IHNwbGljZV9m
cm9tX3BpcGVfbmV4dChzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlLCBzdHJ1Y3Qgc3BsaWNl
X2RlcwogCQkJc2QtPm5lZWRfd2FrZXVwID0gZmFsc2U7CiAJCX0KIAotCQlwaXBlX3dhaXQocGlw
ZSk7CisJCXBpcGVfd2FpdF9yZWFkYWJsZShwaXBlKTsKIAl9CiAKIAlyZXR1cm4gMTsKQEAgLTEw
NzcsNyArMTA3Nyw3IEBAIHN0YXRpYyBpbnQgd2FpdF9mb3Jfc3BhY2Uoc3RydWN0IHBpcGVfaW5v
ZGVfaW5mbyAqcGlwZSwgdW5zaWduZWQgZmxhZ3MpCiAJCQlyZXR1cm4gLUVBR0FJTjsKIAkJaWYg
KHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKQogCQkJcmV0dXJuIC1FUkVTVEFSVFNZUzsKLQkJcGlw
ZV93YWl0KHBpcGUpOworCQlwaXBlX3dhaXRfd3JpdGFibGUocGlwZSk7CiAJfQogfQogCkBAIC0x
NDU0LDcgKzE0NTQsNyBAQCBzdGF0aWMgaW50IGlwaXBlX3ByZXAoc3RydWN0IHBpcGVfaW5vZGVf
aW5mbyAqcGlwZSwgdW5zaWduZWQgaW50IGZsYWdzKQogCQkJcmV0ID0gLUVBR0FJTjsKIAkJCWJy
ZWFrOwogCQl9Ci0JCXBpcGVfd2FpdChwaXBlKTsKKwkJcGlwZV93YWl0X3JlYWRhYmxlKHBpcGUp
OwogCX0KIAogCXBpcGVfdW5sb2NrKHBpcGUpOwpAQCAtMTQ5Myw3ICsxNDkzLDcgQEAgc3RhdGlj
IGludCBvcGlwZV9wcmVwKHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsIHVuc2lnbmVkIGlu
dCBmbGFncykKIAkJCXJldCA9IC1FUkVTVEFSVFNZUzsKIAkJCWJyZWFrOwogCQl9Ci0JCXBpcGVf
d2FpdChwaXBlKTsKKwkJcGlwZV93YWl0X3dyaXRhYmxlKHBpcGUpOwogCX0KIAogCXBpcGVfdW5s
b2NrKHBpcGUpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9waXBlX2ZzX2kuaCBiL2luY2x1
ZGUvbGludXgvcGlwZV9mc19pLmgKaW5kZXggNTBhZmQwZDAwODRjLi41ZDI3MDVmMWQwMWMgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvcGlwZV9mc19pLmgKKysrIGIvaW5jbHVkZS9saW51eC9w
aXBlX2ZzX2kuaApAQCAtMjQwLDggKzI0MCw5IEBAIGV4dGVybiB1bnNpZ25lZCBpbnQgcGlwZV9t
YXhfc2l6ZTsKIGV4dGVybiB1bnNpZ25lZCBsb25nIHBpcGVfdXNlcl9wYWdlc19oYXJkOwogZXh0
ZXJuIHVuc2lnbmVkIGxvbmcgcGlwZV91c2VyX3BhZ2VzX3NvZnQ7CiAKLS8qIERyb3AgdGhlIGlu
b2RlIHNlbWFwaG9yZSBhbmQgd2FpdCBmb3IgYSBwaXBlIGV2ZW50LCBhdG9taWNhbGx5ICovCi12
b2lkIHBpcGVfd2FpdChzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlKTsKKy8qIFdhaXQgZm9y
IGEgcGlwZSB0byBiZSByZWFkYWJsZS93cml0YWJsZSB3aGlsZSBkcm9wcGluZyB0aGUgcGlwZSBs
b2NrICovCit2b2lkIHBpcGVfd2FpdF9yZWFkYWJsZShzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICop
Owordm9pZCBwaXBlX3dhaXRfd3JpdGFibGUoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqKTsKIAog
c3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqYWxsb2NfcGlwZV9pbmZvKHZvaWQpOwogdm9pZCBmcmVl
X3BpcGVfaW5mbyhzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICopOwo=
--0000000000007af7d205b0a053eb--
