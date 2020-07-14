Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75D21F124
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGNMYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNMYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:24:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5CC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:24:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d18so16854341edv.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LYBEaBRyuis0Be1SFDt4HqJhBIwOXUUG3MSMkOQOUw=;
        b=WKLDC2c2K9TBZmX1yD7Ch61moUX9XE7uQLZbiA0XH83CyWX2rU1lhfEbJNw2sRMkH4
         vuAHn/GIfe2Xxuht0ijB7Xzn97EbdR3Uru40Vb2ME+UaSXw/KyxQ1fRn+F6F65LZSc//
         3qqlEhWJArc2JNZNkjIsHValY5kzEUhLFKlw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LYBEaBRyuis0Be1SFDt4HqJhBIwOXUUG3MSMkOQOUw=;
        b=YCAcUfxhwx81QEsPXEj798xspLBUudQw9SjldLJla/75uROj+eyi+tm4u4QY/rOwX8
         auV2Hc+w+V5PLMF6dIZ9tMJ5si9yz3zpcxn5++foeEsdthVtbAJUkWBXWjAHQbyd1or/
         2IAs31q0t3eiXBy1joiUgcStmDzVH9o6vVIfUfg7BZyddt481sQvmcy/HNch8hBMYaEt
         OUxxKVmm7uGcP+PXJO+66MdNXExRSjSEDiRMt6+ybCMDPvtoNJON9suxJAyKuQ9xAvv2
         63wQM6I1tA1e6cCGYZby8pA9aBmFbVP91FmOLYOdi6D7d7fgXb/EpNfH2vVJXcfUaYbI
         1mkA==
X-Gm-Message-State: AOAM532+HldfxXzEknO7QQWfLhITChOMkUagH63xq3GvqQtEqydYfjdS
        QrIMgQInol9OdGUzIrKGO2021yrNltMSvfMjkLnL4g==
X-Google-Smtp-Source: ABdhPJyKH+QSIc5w/1NGLSwn4aMd/CRFVqmigbjqowt8jjhQfJmOU38cH62fqr5t/gMCVtTKnlsu4sHosTiwWzvAcIA=
X-Received: by 2002:a50:cd1e:: with SMTP id z30mr4076057edi.364.1594729485027;
 Tue, 14 Jul 2020 05:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com> <446f0df5-798d-ab3a-e773-39d9f202c092@virtuozzo.com>
In-Reply-To: <446f0df5-798d-ab3a-e773-39d9f202c092@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 14:24:33 +0200
Message-ID: <CAJfpegv_7nvWoigY-eCX0ny+phWYOz3kEZvYsuGb=u65yMLGHg@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill: simplified "if-else if" constuction
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000077f70505aa65e488"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000077f70505aa65e488
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 25, 2020 at 11:30 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> fuse_writepages_fill uses following construction:
> if (wpa && ap->num_pages &&
>     (A || B || C)) {
>         action;
> } else if (wpa && D) {
>         if (E) {
>                 the same action;
>         }
> }
>
> - ap->num_pages check is always true and can be removed
> - "if" and "else if" calls the same action and can be merged.

Makes sense.  Attached patch goes further and moves checking the
conditions to a separate helper for clarity.

Thanks,
Miklos

--00000000000077f70505aa65e488
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-clean-up-writepage-sending.patch"
Content-Disposition: attachment; 
	filename="fuse-clean-up-writepage-sending.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kclwpq8b0>
X-Attachment-Id: f_kclwpq8b0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGNsZWFuIHVwIGNvbmRpdGlvbiBmb3Igd3JpdGVwYWdlIHNlbmRpbmcKCmZ1c2Vfd3JpdGVwYWdl
c19maWxsIHVzZXMgZm9sbG93aW5nIGNvbnN0cnVjdGlvbjoKCmlmICh3cGEgJiYgYXAtPm51bV9w
YWdlcyAmJgogICAgKEEgfHwgQiB8fCBDKSkgewogICAgICAgIGFjdGlvbjsKfSBlbHNlIGlmICh3
cGEgJiYgRCkgewogICAgICAgIGlmIChFKSB7CiAgICAgICAgICAgICAgICB0aGUgc2FtZSBhY3Rp
b247CiAgICAgICAgfQp9CgogLSBhcC0+bnVtX3BhZ2VzIGNoZWNrIGlzIGFsd2F5cyB0cnVlIGFu
ZCBjYW4gYmUgcmVtb3ZlZAoKIC0gImlmIiBhbmQgImVsc2UgaWYiIGNhbGxzIHRoZSBzYW1lIGFj
dGlvbiBhbmQgY2FuIGJlIG1lcmdlZC4KCk1vdmUgY2hlY2tpbmcgQSwgQiwgQywgRCwgRSBjb25k
aXRpb25zIHRvIGEgaGVscGVyLCBhZGQgY29tbWVudHMuCgpPcmlnaW5hbC1wYXRjaC1ieTogVmFz
aWx5IEF2ZXJpbiA8dnZzQHZpcnR1b3p6by5jb20+ClNpZ25lZC1vZmYtYnk6IE1pa2xvcyBTemVy
ZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgotLS0KIGZzL2Z1c2UvZmlsZS5jIHwgICA1MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCi0tLSBhL2ZzL2Z1c2Uv
ZmlsZS5jCisrKyBiL2ZzL2Z1c2UvZmlsZS5jCkBAIC0yMDE1LDYgKzIwMTUsMzggQEAgc3RhdGlj
IGJvb2wgZnVzZV93cml0ZXBhZ2VfYWRkKHN0cnVjdCBmdQogCXJldHVybiBmYWxzZTsKIH0KIAor
c3RhdGljIGJvb2wgZnVzZV93cml0ZXBhZ2VfbmVlZF9zZW5kKHN0cnVjdCBmdXNlX2Nvbm4gKmZj
LCBzdHJ1Y3QgcGFnZSAqcGFnZSwKKwkJCQkgICAgIHN0cnVjdCBmdXNlX2FyZ3NfcGFnZXMgKmFw
LAorCQkJCSAgICAgc3RydWN0IGZ1c2VfZmlsbF93Yl9kYXRhICpkYXRhKQoreworCS8qCisJICog
QmVpbmcgdW5kZXIgd3JpdGViYWNrIGlzIHVubGlrZWx5IGJ1dCBwb3NzaWJsZS4gIEZvciBleGFt
cGxlIGRpcmVjdAorCSAqIHJlYWQgdG8gYW4gbW1hcGVkIGZ1c2UgZmlsZSB3aWxsIHNldCB0aGUg
cGFnZSBkaXJ0eSB0d2ljZTsgb25jZSB3aGVuCisJICogdGhlIHBhZ2VzIGFyZSBmYXVsdGVkIHdp
dGggZ2V0X3VzZXJfcGFnZXMoKSwgYW5kIHRoZW4gYWZ0ZXIgdGhlIHJlYWQKKwkgKiBjb21wbGV0
ZWQuCisJICovCisJaWYgKGZ1c2VfcGFnZV9pc193cml0ZWJhY2soZGF0YS0+aW5vZGUsIHBhZ2Ut
PmluZGV4KSkKKwkJcmV0dXJuIHRydWU7CisKKwkvKiBSZWFjaGVkIG1heCBwYWdlcyAqLworCWlm
IChhcC0+bnVtX3BhZ2VzID09IGZjLT5tYXhfcGFnZXMpCisJCXJldHVybiB0cnVlOworCisJLyog
UmVhY2hlZCBtYXggd3JpdGUgYnl0ZXMgKi8KKwlpZiAoKGFwLT5udW1fcGFnZXMgKyAxKSAqIFBB
R0VfU0laRSA+IGZjLT5tYXhfd3JpdGUpCisJCXJldHVybiB0cnVlOworCisJLyogRGlzY29udGlu
dWl0eSAqLworCWlmIChkYXRhLT5vcmlnX3BhZ2VzW2FwLT5udW1fcGFnZXMgLSAxXS0+aW5kZXgg
KyAxICE9IHBhZ2UtPmluZGV4KQorCQlyZXR1cm4gdHJ1ZTsKKworCS8qIE5lZWQgdG8gZ3JvdyB0
aGUgcGFnZXMgYXJyYXk/ICBJZiBzbywgZGlkIHRoZSBleHBhbnNpb24gZmFpbD8gKi8KKwlpZiAo
YXAtPm51bV9wYWdlcyA9PSBkYXRhLT5tYXhfcGFnZXMgJiYgIWZ1c2VfcGFnZXNfcmVhbGxvYyhk
YXRhKSkKKwkJcmV0dXJuIHRydWU7CisKKwlyZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyBpbnQg
ZnVzZV93cml0ZXBhZ2VzX2ZpbGwoc3RydWN0IHBhZ2UgKnBhZ2UsCiAJCXN0cnVjdCB3cml0ZWJh
Y2tfY29udHJvbCAqd2JjLCB2b2lkICpfZGF0YSkKIHsKQEAgLTIwMjUsNyArMjA1Nyw2IEBAIHN0
YXRpYyBpbnQgZnVzZV93cml0ZXBhZ2VzX2ZpbGwoc3RydWN0IHAKIAlzdHJ1Y3QgZnVzZV9pbm9k
ZSAqZmkgPSBnZXRfZnVzZV9pbm9kZShpbm9kZSk7CiAJc3RydWN0IGZ1c2VfY29ubiAqZmMgPSBn
ZXRfZnVzZV9jb25uKGlub2RlKTsKIAlzdHJ1Y3QgcGFnZSAqdG1wX3BhZ2U7Ci0JYm9vbCBpc193
cml0ZWJhY2s7CiAJaW50IGVycjsKIAogCWlmICghZGF0YS0+ZmYpIHsKQEAgLTIwMzUsMjUgKzIw
NjYsOSBAQCBzdGF0aWMgaW50IGZ1c2Vfd3JpdGVwYWdlc19maWxsKHN0cnVjdCBwCiAJCQlnb3Rv
IG91dF91bmxvY2s7CiAJfQogCi0JLyoKLQkgKiBCZWluZyB1bmRlciB3cml0ZWJhY2sgaXMgdW5s
aWtlbHkgYnV0IHBvc3NpYmxlLiAgRm9yIGV4YW1wbGUgZGlyZWN0Ci0JICogcmVhZCB0byBhbiBt
bWFwZWQgZnVzZSBmaWxlIHdpbGwgc2V0IHRoZSBwYWdlIGRpcnR5IHR3aWNlOyBvbmNlIHdoZW4K
LQkgKiB0aGUgcGFnZXMgYXJlIGZhdWx0ZWQgd2l0aCBnZXRfdXNlcl9wYWdlcygpLCBhbmQgdGhl
biBhZnRlciB0aGUgcmVhZAotCSAqIGNvbXBsZXRlZC4KLQkgKi8KLQlpc193cml0ZWJhY2sgPSBm
dXNlX3BhZ2VfaXNfd3JpdGViYWNrKGlub2RlLCBwYWdlLT5pbmRleCk7Ci0KLQlpZiAod3BhICYm
IGFwLT5udW1fcGFnZXMgJiYKLQkgICAgKGlzX3dyaXRlYmFjayB8fCBhcC0+bnVtX3BhZ2VzID09
IGZjLT5tYXhfcGFnZXMgfHwKLQkgICAgIChhcC0+bnVtX3BhZ2VzICsgMSkgKiBQQUdFX1NJWkUg
PiBmYy0+bWF4X3dyaXRlIHx8Ci0JICAgICBkYXRhLT5vcmlnX3BhZ2VzW2FwLT5udW1fcGFnZXMg
LSAxXS0+aW5kZXggKyAxICE9IHBhZ2UtPmluZGV4KSkgeworCWlmICh3cGEgJiYgZnVzZV93cml0
ZXBhZ2VfbmVlZF9zZW5kKGZjLCBwYWdlLCBhcCwgZGF0YSkpIHsKIAkJZnVzZV93cml0ZXBhZ2Vz
X3NlbmQoZGF0YSk7CiAJCWRhdGEtPndwYSA9IE5VTEw7Ci0JfSBlbHNlIGlmICh3cGEgJiYgYXAt
Pm51bV9wYWdlcyA9PSBkYXRhLT5tYXhfcGFnZXMpIHsKLQkJaWYgKCFmdXNlX3BhZ2VzX3JlYWxs
b2MoZGF0YSkpIHsKLQkJCWZ1c2Vfd3JpdGVwYWdlc19zZW5kKGRhdGEpOwotCQkJZGF0YS0+d3Bh
ID0gTlVMTDsKLQkJfQogCX0KIAogCWVyciA9IC1FTk9NRU07Cg==
--00000000000077f70505aa65e488--
