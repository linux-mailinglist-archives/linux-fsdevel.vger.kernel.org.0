Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63921C200
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jul 2020 06:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgGKEBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jul 2020 00:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgGKEBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jul 2020 00:01:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8609AC08C5DD
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 21:01:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so8141494ejj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dANNcJSKLhpGYdfB8vIrW1dizRELDDGmxA6X9jjm+Yc=;
        b=kRP6BZIiBvyCycWx/YpZw07EtFt9ifWd6TMtinjbhr3tyuBvdxNdX1sld+wtHTwI8p
         80BBxlob/ZUd9rAzdkgOMzhPHZqK9TQDHMBXlI1vHe8g+tEVMsnJqMg2RsFBsjzJilGp
         0oYeKw41M8xnFkYMBgdokYnt7HRL2oOZUDRkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dANNcJSKLhpGYdfB8vIrW1dizRELDDGmxA6X9jjm+Yc=;
        b=kr7Nn/e1aTRguaHnbxysJlsLLa79tVAY/Cf5bPV787SUcOh6kTjHZERoOE+TBSXaL3
         tDFvPgGEuw8Tc3FFsV/E+Lwhb2yW9H/ZyRtBs3zQ1n92dLLTHEv+/oEnlT/NuKolaF1X
         sTnmKidCjPyiavj7k31aDQKJyQ/IcZdAhVpBoPIg9eq0+AjZ8XBKEP+wwVYyI7IelIrW
         4XwwLT+cZZhz7QYqllntacNhq7b+ofchE9MrGl/Kqaa0GjdeWRXjLOfuZDKBGcQIhev2
         5SR1PASrjZD98B/S2UwlCkivdOhygjX1Foll9djkWOJf+rkgAmWgVzIjxtwWiXNG0G9t
         Ho5g==
X-Gm-Message-State: AOAM532eA/qTp3i+Peafqo9r/OavywQZXAP8seLwYpCHxsCaLX8sNwyi
        GA+BGOEY0/1C75H1RZVWBTfMDwm7XXYiZ00bRUehIDhJkN0=
X-Google-Smtp-Source: ABdhPJyO4AqD5ZruQElhFac3byJZcXNbvDQLzICVz7Uym2TwkF5fIknXa/d7NjtFZh3zoQs5crMgoQX625i44jWhHj0=
X-Received: by 2002:a17:906:824c:: with SMTP id f12mr62890543ejx.443.1594440080226;
 Fri, 10 Jul 2020 21:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com> <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
In-Reply-To: <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 11 Jul 2020 06:01:08 +0200
Message-ID: <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000099304f05aa22823b"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000099304f05aa22823b
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 25, 2020 at 11:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> In current implementation fuse_writepages_fill() tries to share the code:
> for new wpa it calls tree_insert() with num_pages = 0
> then switches to common code used non-modified num_pages
> and increments it at the very end.
>
> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>  Call Trace:
>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
>   write_cache_pages+0x171/0x470
>   fuse_writepages+0x8a/0x100 [fuse]
>   do_writepages+0x43/0xe0
>
> This patch re-works fuse_writepages_fill() to call tree_insert()
> with num_pages = 1 and avoids its subsequent increment and
> an extra spin_lock(&fi->lock) for newly added wpa.

Looks good.  However, I don't like the way fuse_writepage_in_flight()
is silently changed to insert page into the rb_tree.  Also the
insertion can be merged with the search for in-flight and be done
unconditionally to simplify the logic.  See attached patch.

Thanks,
Miklos

--00000000000099304f05aa22823b
Content-Type: application/x-patch; 
	name="fuse-fix-warning-in-tree_insert.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-warning-in-tree_insert.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kch4733j0>
X-Attachment-Id: f_kch4733j0

LS0tCiBmcy9mdXNlL2ZpbGUuYyB8ICAgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKSwgMzIgZGVsZXRpb25zKC0pCgotLS0gYS9mcy9mdXNlL2ZpbGUuYworKysgYi9mcy9mdXNl
L2ZpbGUuYwpAQCAtMTY3NCw3ICsxNjc0LDggQEAgX19hY3F1aXJlcyhmaS0+bG9jaykKIAl9CiB9
CiAKLXN0YXRpYyB2b2lkIHRyZWVfaW5zZXJ0KHN0cnVjdCByYl9yb290ICpyb290LCBzdHJ1Y3Qg
ZnVzZV93cml0ZXBhZ2VfYXJncyAqd3BhKQorc3RhdGljIHN0cnVjdCBmdXNlX3dyaXRlcGFnZV9h
cmdzICpmdXNlX2luc2VydF93cml0ZWJhY2soc3RydWN0IHJiX3Jvb3QgKnJvb3QsCisJCQkJCQlz
dHJ1Y3QgZnVzZV93cml0ZXBhZ2VfYXJncyAqd3BhKQogewogCXBnb2ZmX3QgaWR4X2Zyb20gPSB3
cGEtPmlhLndyaXRlLmluLm9mZnNldCA+PiBQQUdFX1NISUZUOwogCXBnb2ZmX3QgaWR4X3RvID0g
aWR4X2Zyb20gKyB3cGEtPmlhLmFwLm51bV9wYWdlcyAtIDE7CkBAIC0xNjk3LDExICsxNjk4LDE3
IEBAIHN0YXRpYyB2b2lkIHRyZWVfaW5zZXJ0KHN0cnVjdCByYl9yb290ICoKIAkJZWxzZSBpZiAo
aWR4X3RvIDwgY3Vycl9pbmRleCkKIAkJCXAgPSAmKCpwKS0+cmJfbGVmdDsKIAkJZWxzZQotCQkJ
cmV0dXJuICh2b2lkKSBXQVJOX09OKHRydWUpOworCQkJcmV0dXJuIGN1cnI7CiAJfQogCiAJcmJf
bGlua19ub2RlKCZ3cGEtPndyaXRlcGFnZXNfZW50cnksIHBhcmVudCwgcCk7CiAJcmJfaW5zZXJ0
X2NvbG9yKCZ3cGEtPndyaXRlcGFnZXNfZW50cnksIHJvb3QpOworCXJldHVybiBOVUxMOworfQor
CitzdGF0aWMgdm9pZCB0cmVlX2luc2VydChzdHJ1Y3QgcmJfcm9vdCAqcm9vdCwgc3RydWN0IGZ1
c2Vfd3JpdGVwYWdlX2FyZ3MgKndwYSkKK3sKKwlXQVJOX09OKGZ1c2VfaW5zZXJ0X3dyaXRlYmFj
ayhyb290LCB3cGEpKTsKIH0KIAogc3RhdGljIHZvaWQgZnVzZV93cml0ZXBhZ2VfZW5kKHN0cnVj
dCBmdXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgZnVzZV9hcmdzICphcmdzLApAQCAtMTk1MywxNCArMTk2
MCwxNCBAQCBzdGF0aWMgdm9pZCBmdXNlX3dyaXRlcGFnZXNfc2VuZChzdHJ1Y3QKIH0KIAogLyoK
LSAqIEZpcnN0IHJlY2hlY2sgdW5kZXIgZmktPmxvY2sgaWYgdGhlIG9mZmVuZGluZyBvZmZzZXQg
aXMgc3RpbGwgdW5kZXIKLSAqIHdyaXRlYmFjay4gIElmIHllcywgdGhlbiBpdGVyYXRlIGF1eGls
aWFyeSB3cml0ZSByZXF1ZXN0cywgdG8gc2VlIGlmIHRoZXJlJ3MKKyAqIENoZWNrIHVuZGVyIGZp
LT5sb2NrIGlmIHRoZSBwYWdlIGlzIHVuZGVyIHdyaXRlYmFjaywgYW5kIGluc2VydCBpdCBvbnRv
IHRoZQorICogcmJfdHJlZSBpZiBub3QuIE90aGVyd2lzZSBpdGVyYXRlIGF1eGlsaWFyeSB3cml0
ZSByZXF1ZXN0cywgdG8gc2VlIGlmIHRoZXJlJ3MKICAqIG9uZSBhbHJlYWR5IGFkZGVkIGZvciBh
IHBhZ2UgYXQgdGhpcyBvZmZzZXQuICBJZiB0aGVyZSdzIG5vbmUsIHRoZW4gaW5zZXJ0CiAgKiB0
aGlzIG5ldyByZXF1ZXN0IG9udG8gdGhlIGF1eGlsaWFyeSBsaXN0LCBvdGhlcndpc2UgcmV1c2Ug
dGhlIGV4aXN0aW5nIG9uZSBieQotICogY29weWluZyB0aGUgbmV3IHBhZ2UgY29udGVudHMgb3Zl
ciB0byB0aGUgb2xkIHRlbXBvcmFyeSBwYWdlLgorICogc3dhcHBpbmcgdGhlIG5ldyB0ZW1wIHBh
Z2Ugd2l0aCB0aGUgb2xkIG9uZS4KICAqLwotc3RhdGljIGJvb2wgZnVzZV93cml0ZXBhZ2VfaW5f
ZmxpZ2h0KHN0cnVjdCBmdXNlX3dyaXRlcGFnZV9hcmdzICpuZXdfd3BhLAotCQkJCSAgICAgc3Ry
dWN0IHBhZ2UgKnBhZ2UpCitzdGF0aWMgYm9vbCBmdXNlX3dyaXRlcGFnZV9hZGQoc3RydWN0IGZ1
c2Vfd3JpdGVwYWdlX2FyZ3MgKm5ld193cGEsCisJCQkgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2Up
CiB7CiAJc3RydWN0IGZ1c2VfaW5vZGUgKmZpID0gZ2V0X2Z1c2VfaW5vZGUobmV3X3dwYS0+aW5v
ZGUpOwogCXN0cnVjdCBmdXNlX3dyaXRlcGFnZV9hcmdzICp0bXA7CkBAIC0xOTY4LDE3ICsxOTc1
LDE1IEBAIHN0YXRpYyBib29sIGZ1c2Vfd3JpdGVwYWdlX2luX2ZsaWdodChzdHIKIAlzdHJ1Y3Qg
ZnVzZV9hcmdzX3BhZ2VzICpuZXdfYXAgPSAmbmV3X3dwYS0+aWEuYXA7CiAKIAlXQVJOX09OKG5l
d19hcC0+bnVtX3BhZ2VzICE9IDApOworCW5ld19hcC0+bnVtX3BhZ2VzID0gMTsKIAogCXNwaW5f
bG9jaygmZmktPmxvY2spOwotCXJiX2VyYXNlKCZuZXdfd3BhLT53cml0ZXBhZ2VzX2VudHJ5LCAm
ZmktPndyaXRlcGFnZXMpOwotCW9sZF93cGEgPSBmdXNlX2ZpbmRfd3JpdGViYWNrKGZpLCBwYWdl
LT5pbmRleCwgcGFnZS0+aW5kZXgpOworCW9sZF93cGEgPSBmdXNlX2luc2VydF93cml0ZWJhY2so
JmZpLT53cml0ZXBhZ2VzLCBuZXdfd3BhKTsKIAlpZiAoIW9sZF93cGEpIHsKLQkJdHJlZV9pbnNl
cnQoJmZpLT53cml0ZXBhZ2VzLCBuZXdfd3BhKTsKIAkJc3Bpbl91bmxvY2soJmZpLT5sb2NrKTsK
LQkJcmV0dXJuIGZhbHNlOworCQlyZXR1cm4gdHJ1ZTsKIAl9CiAKLQluZXdfYXAtPm51bV9wYWdl
cyA9IDE7CiAJZm9yICh0bXAgPSBvbGRfd3BhLT5uZXh0OyB0bXA7IHRtcCA9IHRtcC0+bmV4dCkg
ewogCQlwZ29mZl90IGN1cnJfaW5kZXg7CiAKQEAgLTIwMDcsNyArMjAxMiw3IEBAIHN0YXRpYyBi
b29sIGZ1c2Vfd3JpdGVwYWdlX2luX2ZsaWdodChzdHIKIAkJZnVzZV93cml0ZXBhZ2VfZnJlZShu
ZXdfd3BhKTsKIAl9CiAKLQlyZXR1cm4gdHJ1ZTsKKwlyZXR1cm4gZmFsc2U7CiB9CiAKIHN0YXRp
YyBpbnQgZnVzZV93cml0ZXBhZ2VzX2ZpbGwoc3RydWN0IHBhZ2UgKnBhZ2UsCkBAIC0yMDg2LDEy
ICsyMDkxLDYgQEAgc3RhdGljIGludCBmdXNlX3dyaXRlcGFnZXNfZmlsbChzdHJ1Y3QgcAogCQlh
cC0+YXJncy5lbmQgPSBmdXNlX3dyaXRlcGFnZV9lbmQ7CiAJCWFwLT5udW1fcGFnZXMgPSAwOwog
CQl3cGEtPmlub2RlID0gaW5vZGU7Ci0KLQkJc3Bpbl9sb2NrKCZmaS0+bG9jayk7Ci0JCXRyZWVf
aW5zZXJ0KCZmaS0+d3JpdGVwYWdlcywgd3BhKTsKLQkJc3Bpbl91bmxvY2soJmZpLT5sb2NrKTsK
LQotCQlkYXRhLT53cGEgPSB3cGE7CiAJfQogCXNldF9wYWdlX3dyaXRlYmFjayhwYWdlKTsKIApA
QCAtMjA5OSwyNiArMjA5OCwyNSBAQCBzdGF0aWMgaW50IGZ1c2Vfd3JpdGVwYWdlc19maWxsKHN0
cnVjdCBwCiAJYXAtPnBhZ2VzW2FwLT5udW1fcGFnZXNdID0gdG1wX3BhZ2U7CiAJYXAtPmRlc2Nz
W2FwLT5udW1fcGFnZXNdLm9mZnNldCA9IDA7CiAJYXAtPmRlc2NzW2FwLT5udW1fcGFnZXNdLmxl
bmd0aCA9IFBBR0VfU0laRTsKKwlkYXRhLT5vcmlnX3BhZ2VzW2FwLT5udW1fcGFnZXNdID0gcGFn
ZTsKIAogCWluY193Yl9zdGF0KCZpbm9kZV90b19iZGkoaW5vZGUpLT53YiwgV0JfV1JJVEVCQUNL
KTsKIAlpbmNfbm9kZV9wYWdlX3N0YXRlKHRtcF9wYWdlLCBOUl9XUklURUJBQ0tfVEVNUCk7CiAK
IAllcnIgPSAwOwotCWlmIChpc193cml0ZWJhY2sgJiYgZnVzZV93cml0ZXBhZ2VfaW5fZmxpZ2h0
KHdwYSwgcGFnZSkpIHsKKwlpZiAoZGF0YS0+d3BhKSB7CisJCS8qCisJCSAqIFByb3RlY3RlZCBi
eSBmaS0+bG9jayBhZ2FpbnN0IGNvbmN1cnJlbnQgYWNjZXNzIGJ5CisJCSAqIGZ1c2VfcGFnZV9p
c193cml0ZWJhY2soKS4KKwkJICovCisJCXNwaW5fbG9jaygmZmktPmxvY2spOworCQlhcC0+bnVt
X3BhZ2VzKys7CisJCXNwaW5fdW5sb2NrKCZmaS0+bG9jayk7CisJfSBlbHNlIGlmIChmdXNlX3dy
aXRlcGFnZV9hZGQod3BhLCBwYWdlKSkgeworCQlkYXRhLT53cGEgPSB3cGE7CisJfSBlbHNlIHsK
IAkJZW5kX3BhZ2Vfd3JpdGViYWNrKHBhZ2UpOwotCQlkYXRhLT53cGEgPSBOVUxMOwotCQlnb3Rv
IG91dF91bmxvY2s7CiAJfQotCWRhdGEtPm9yaWdfcGFnZXNbYXAtPm51bV9wYWdlc10gPSBwYWdl
OwotCi0JLyoKLQkgKiBQcm90ZWN0ZWQgYnkgZmktPmxvY2sgYWdhaW5zdCBjb25jdXJyZW50IGFj
Y2VzcyBieQotCSAqIGZ1c2VfcGFnZV9pc193cml0ZWJhY2soKS4KLQkgKi8KLQlzcGluX2xvY2so
JmZpLT5sb2NrKTsKLQlhcC0+bnVtX3BhZ2VzKys7Ci0Jc3Bpbl91bmxvY2soJmZpLT5sb2NrKTsK
LQogb3V0X3VubG9jazoKIAl1bmxvY2tfcGFnZShwYWdlKTsKIAo=
--00000000000099304f05aa22823b--
