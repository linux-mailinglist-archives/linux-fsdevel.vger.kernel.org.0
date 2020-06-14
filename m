Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0371F88D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jun 2020 14:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFNMuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNMuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:50:50 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505EC05BD43;
        Sun, 14 Jun 2020 05:50:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so14945671ioa.1;
        Sun, 14 Jun 2020 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVwLAlsSZwuDVMQ+LcExjy/lGo/GmX6XALxJzHxSWK0=;
        b=FTvs/mPOgjKHYoMcJHw3uOT0M0/60MleriSWJ0xCrRhoTCF0ekmjH2ueyhMXyf/idz
         +dbnHqi7sV2YBm+VBnm1/sxSpe0VMZRctpx9iAatj+WxvD185PXA1ODWw03FoJ0TPWPM
         JhuY43/egrYymWcHGrUu9tllHy5pNKOoWOjEvIwpHjIRGxzr4uvpj17Ol2EbVzxzepNC
         O6i4sbo/GLKUF5JQOkjOU/Ac4h0zNzy4HnNFNEcqAC5GNd34MCAXgWFlOVbOotBTkosO
         8Vlq/LqP1RHYXrHtHlLx1rQdWnWyoo/TUDc6g2BBXz49o8/u2ja0DEskp3sCny8tSJ9f
         reGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVwLAlsSZwuDVMQ+LcExjy/lGo/GmX6XALxJzHxSWK0=;
        b=V4EW6rO4shD/2bc56onR0wCJZFgGdUEaZNC7/NcqO4HqMHaUoMBUV03q9bpBGtJSAn
         JcshlpJnS0NXH7qu0AZ7PUZ73kvw2aoJTL5WHOsDvB+CVwo9/OiD6qpZaAvGd+Fyyt+U
         FnxcxKWP51rA03VmiZJ4nHuzk7ZzSX8hlNBrK/zEe422VIEUYhWwmeXk3rzHP96XLcBL
         BexD5mCjxc1RBZ0zxU9oTudB7rSaXbWLIbktGBm7+WoXu14Fl88jjCFA7iM2SkKyseZ5
         U2DXQWkTH9AOrGId3Hi99m3RAzd+r7E8jv3ApIUOktLJ+NqqWBLJOOJgxZAqRbcVAi2O
         F+tg==
X-Gm-Message-State: AOAM530ehhUltD9tyYbUgrzAweDY1r14D1s1BLB/rt2uEUgLUu8V7392
        bhAQ801RMK6A9TYFkOysfIsr635vx+LzAzZ5AzM=
X-Google-Smtp-Source: ABdhPJxB6hWJwUeXE7ZeMWH7rXZyPYcSeN2OVGX0LlPEpaoEfMjMwmI4FYcieT7GxEy7QRLMjoQQMX+IpqP36JRVGMA=
X-Received: by 2002:a05:6602:5c8:: with SMTP id w8mr22872440iox.64.1592139048843;
 Sun, 14 Jun 2020 05:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com> <20200612004644.255692-2-mike.kravetz@oracle.com>
In-Reply-To: <20200612004644.255692-2-mike.kravetz@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 14 Jun 2020 15:50:37 +0300
Message-ID: <CAOQ4uxi+FcVM2amOOsuEzV8N3EeHn1MPOPi5=StSNOQLCOwkZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ovl: call underlying get_unmapped_area() routine.
 propogate FMODE_HUGETLBFS
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000709dd905a80ac219"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000709dd905a80ac219
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 12, 2020 at 3:57 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The core routine get_unmapped_area will call a filesystem specific version
> of get_unmapped_area if it exists in file operations.  If a file is on a
> union/overlay, overlayfs does not contain a get_unmapped_area f_op and the
> underlying filesystem routine may be ignored.  Add an overlayfs f_op to call
> the underlying f_op if it exists.
>
> The routine is_file_hugetlbfs() is used to determine if a file is on
> hugetlbfs.  This is determined by f_mode & FMODE_HUGETLBFS.  Copy the mode
> to the overlayfs file during open so that is_file_hugetlbfs() will work as
> intended.
>
> These two issues can result in the BUG as shown in [1].
>
> [1] https://lore.kernel.org/linux-mm/000000000000b4684e05a2968ca6@google.com/
>
> Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/overlayfs/file.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 87c362f65448..41e5746ba3c6 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -124,6 +124,8 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
>         return ovl_real_fdget_meta(file, real, false);
>  }
>
> +#define OVL_F_MODE_TO_UPPER    (FMODE_HUGETLBFS)
> +
>  static int ovl_open(struct inode *inode, struct file *file)
>  {
>         struct file *realfile;
> @@ -140,6 +142,9 @@ static int ovl_open(struct inode *inode, struct file *file)
>         if (IS_ERR(realfile))
>                 return PTR_ERR(realfile);
>
> +       /* Copy modes from underlying file */
> +       file->f_mode |= (realfile->f_mode & OVL_F_MODE_TO_UPPER);
> +

The name OVL_F_MODE_TO_UPPER is strange because
ovl_open() may be opening a file from lower or from upper.

Please see attached patches.
They are not enough to solve the syzbot repro, but if you do want to
fix hugetlb/overlay interop I think they will be necessary.

Thanks,
Amir.

--000000000000709dd905a80ac219
Content-Type: text/plain; charset="US-ASCII"; 
	name="0002-ovl-warn-about-unsupported-file-operations-on-upper-.patch.txt"
Content-Disposition: attachment; 
	filename="0002-ovl-warn-about-unsupported-file-operations-on-upper-.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kbf2h10o1>
X-Attachment-Id: f_kbf2h10o1

RnJvbSA2OTE5MTVmZDhkNGJiMmMwZjk0NGI3ZDhlNTA0YTMyM2I4ZTUzYjY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDE0IEp1biAyMDIwIDEzOjUxOjMwICswMzAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IG92bDogd2FybiBhYm91dCB1bnN1cHBvcnRlZCBmaWxlIG9wZXJhdGlvbnMgb24gdXBwZXIgZnMK
CnN5emJvdCBoYXMgcmVwb3J0ZWQgYSBjcmFzaCBpbiBhIHRlc3QgY2FzZSB3aGVyZSBvdmVybGF5
ZnMgdXNlcwpodWdldGxiZnMgYXMgdXBwZXIgZnMuCgpTaW5jZSBodWdldGxiZnMgaGFzIG5vIHdy
aXRlKCkgbm9yIHdyaXRlX2l0ZXIoKSBmaWxlIG9wcywgdGhlcmUgc2VlbXMKdG8gYmUgbGl0dGxl
IHZhbHVlIGluIHN1cHBvcnRpbmcgdGhpcyBjb25maWd1cmF0aW9uLCBob3dldmVyLCB3ZSBkbyBu
b3QKd2FudCB0byByZWdyZXNzIHN0cmFuZ2UgdXNlIGNhc2VzIHRoYXQgbWUgYmUgdXNpbmcgc3Vj
aCBjb25maWd1cmF0aW9uLgoKQXMgYSBtaW5pbXVtLCBjaGVjayBmb3IgdGhpcyBjYXNlIGFuZCB3
YXJuIGFib3V0IGl0IG9uIG1vdW50IHRpbWUgYXMKd2VsbCBhcyBhZGRpbmcgdGhpcyBjaGVjayBm
b3IgdGhlIHN0cmljdCByZXF1aXJlbWVudHMgc2V0IG9mIHJlbW90ZQp1cHBlciBmcy4KClNpZ25l
ZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvb3Zl
cmxheWZzL3N1cGVyLmMgfCA2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9zdXBlci5jIGIvZnMvb3ZlcmxheWZzL3N1cGVy
LmMKaW5kZXggOTE0NzZiYzQyMmY5Li41YmVlNzBlYjhmNjQgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJs
YXlmcy9zdXBlci5jCisrKyBiL2ZzL292ZXJsYXlmcy9zdXBlci5jCkBAIC02LDYgKzYsNyBAQAog
CiAjaW5jbHVkZSA8dWFwaS9saW51eC9tYWdpYy5oPgogI2luY2x1ZGUgPGxpbnV4L2ZzLmg+Cisj
aW5jbHVkZSA8bGludXgvZmlsZS5oPgogI2luY2x1ZGUgPGxpbnV4L25hbWVpLmg+CiAjaW5jbHVk
ZSA8bGludXgveGF0dHIuaD4KICNpbmNsdWRlIDxsaW51eC9tb3VudC5oPgpAQCAtMTEzMSw0MiAr
MTEzMiw2MSBAQCBzdGF0aWMgaW50IG92bF9nZXRfdXBwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpz
Yiwgc3RydWN0IG92bF9mcyAqb2ZzLAogfQogCiAvKgotICogUmV0dXJucyAxIGlmIFJFTkFNRV9X
SElURU9VVCBpcyBzdXBwb3J0ZWQsIDAgaWYgbm90IHN1cHBvcnRlZCBhbmQKKyAqIFJldHVybnMg
MSBpZiByZXF1aXJlZCBvcHMgYXJlIHN1cHBvcnRlZCwgMCBpZiBub3Qgc3VwcG9ydGVkIGFuZAog
ICogbmVnYXRpdmUgdmFsdWVzIGlmIGVycm9yIGlzIGVuY291bnRlcmVkLgogICovCi1zdGF0aWMg
aW50IG92bF9jaGVja19yZW5hbWVfd2hpdGVvdXQoc3RydWN0IGRlbnRyeSAqd29ya2RpcikKK3N0
YXRpYyBpbnQgb3ZsX2NoZWNrX3N1cHBvcnRlZF9vcHMoc3RydWN0IG92bF9mcyAqb2ZzKQogewot
CXN0cnVjdCBpbm9kZSAqZGlyID0gZF9pbm9kZSh3b3JrZGlyKTsKLQlzdHJ1Y3QgZGVudHJ5ICp0
ZW1wOworCXN0cnVjdCBpbm9kZSAqZGlyID0gZF9pbm9kZShvZnMtPndvcmtkaXIpOworCXN0cnVj
dCBkZW50cnkgKnRlbXAgPSBOVUxMOwogCXN0cnVjdCBkZW50cnkgKmRlc3Q7CiAJc3RydWN0IGRl
bnRyeSAqd2hpdGVvdXQ7CiAJc3RydWN0IG5hbWVfc25hcHNob3QgbmFtZTsKKwlzdHJ1Y3QgcGF0
aCBwYXRoOworCXN0cnVjdCBmaWxlICpmaWxlOworCXVuc2lnbmVkIGludCB1bnN1cHBvcnRlZDsK
IAlpbnQgZXJyOwogCiAJaW5vZGVfbG9ja19uZXN0ZWQoZGlyLCBJX01VVEVYX1BBUkVOVCk7CiAK
LQl0ZW1wID0gb3ZsX2NyZWF0ZV90ZW1wKHdvcmtkaXIsIE9WTF9DQVRUUihTX0lGUkVHIHwgMCkp
OwotCWVyciA9IFBUUl9FUlIodGVtcCk7Ci0JaWYgKElTX0VSUih0ZW1wKSkKKwlwYXRoLm1udCA9
IG92bF91cHBlcl9tbnQob2ZzKTsKKwlwYXRoLmRlbnRyeSA9IG92bF9jcmVhdGVfdGVtcChvZnMt
PndvcmtkaXIsIE9WTF9DQVRUUihTX0lGUkVHIHwgMCkpOworCWVyciA9IFBUUl9FUlIocGF0aC5k
ZW50cnkpOworCWlmIChJU19FUlIocGF0aC5kZW50cnkpKQogCQlnb3RvIG91dF91bmxvY2s7CiAK
LQlkZXN0ID0gb3ZsX2xvb2t1cF90ZW1wKHdvcmtkaXIpOwotCWVyciA9IFBUUl9FUlIoZGVzdCk7
Ci0JaWYgKElTX0VSUihkZXN0KSkgewotCQlkcHV0KHRlbXApOworCXRlbXAgPSBwYXRoLmRlbnRy
eTsKKwlmaWxlID0gZGVudHJ5X29wZW4oJnBhdGgsIE9fUkRXUiwgY3VycmVudF9jcmVkKCkpOwor
CWVyciA9IFBUUl9FUlIoZmlsZSk7CisJaWYgKElTX0VSUihmaWxlKSkKKwkJZ290byBvdXRfdW5s
b2NrOworCisJdW5zdXBwb3J0ZWQgPSBPVkxfVVBQRVJfRk1PREVfTUFTSyAmIH5maWxlLT5mX21v
ZGU7CisJZnB1dChmaWxlKTsKKwlpZiAodW5zdXBwb3J0ZWQpIHsKKwkJZXJyID0gMDsKKwkJcHJf
d2FybigidXBwZXIgZnMgZG9lcyBub3Qgc3VwcG9ydCByZXF1aXJlZCBmaWxlIG9wZXJhdGlvbnMg
KCV4KS5cbiIsCisJCQl1bnN1cHBvcnRlZCk7CiAJCWdvdG8gb3V0X3VubG9jazsKIAl9CiAKKwlk
ZXN0ID0gb3ZsX2xvb2t1cF90ZW1wKG9mcy0+d29ya2Rpcik7CisJZXJyID0gUFRSX0VSUihkZXN0
KTsKKwlpZiAoSVNfRVJSKGRlc3QpKQorCQlnb3RvIG91dF91bmxvY2s7CisKIAkvKiBOYW1lIGlz
IGlubGluZSBhbmQgc3RhYmxlIC0gdXNpbmcgc25hcHNob3QgYXMgYSBjb3B5IGhlbHBlciAqLwog
CXRha2VfZGVudHJ5X25hbWVfc25hcHNob3QoJm5hbWUsIHRlbXApOwogCWVyciA9IG92bF9kb19y
ZW5hbWUoZGlyLCB0ZW1wLCBkaXIsIGRlc3QsIFJFTkFNRV9XSElURU9VVCk7CiAJaWYgKGVycikg
ewotCQlpZiAoZXJyID09IC1FSU5WQUwpCisJCWlmIChlcnIgPT0gLUVJTlZBTCkgewogCQkJZXJy
ID0gMDsKKwkJCXByX3dhcm4oInVwcGVyIGZzIGRvZXMgbm90IHN1cHBvcnQgUkVOQU1FX1dISVRF
T1VULlxuIik7CisJCX0KIAkJZ290byBjbGVhbnVwX3RlbXA7CiAJfQogCi0Jd2hpdGVvdXQgPSBs
b29rdXBfb25lX2xlbihuYW1lLm5hbWUubmFtZSwgd29ya2RpciwgbmFtZS5uYW1lLmxlbik7CisJ
d2hpdGVvdXQgPSBsb29rdXBfb25lX2xlbihuYW1lLm5hbWUubmFtZSwgb2ZzLT53b3JrZGlyLCBu
YW1lLm5hbWUubGVuKTsKIAllcnIgPSBQVFJfRVJSKHdoaXRlb3V0KTsKIAlpZiAoSVNfRVJSKHdo
aXRlb3V0KSkKIAkJZ290byBjbGVhbnVwX3RlbXA7CkBAIC0xMTgxLDEwICsxMjAxLDEwIEBAIHN0
YXRpYyBpbnQgb3ZsX2NoZWNrX3JlbmFtZV93aGl0ZW91dChzdHJ1Y3QgZGVudHJ5ICp3b3JrZGly
KQogY2xlYW51cF90ZW1wOgogCW92bF9jbGVhbnVwKGRpciwgdGVtcCk7CiAJcmVsZWFzZV9kZW50
cnlfbmFtZV9zbmFwc2hvdCgmbmFtZSk7Ci0JZHB1dCh0ZW1wKTsKIAlkcHV0KGRlc3QpOwogCiBv
dXRfdW5sb2NrOgorCWRwdXQodGVtcCk7CiAJaW5vZGVfdW5sb2NrKGRpcik7CiAKIAlyZXR1cm4g
ZXJyOwpAQCAtMTE5NSw3ICsxMjE1LDcgQEAgc3RhdGljIGludCBvdmxfbWFrZV93b3JrZGlyKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBvdmxfZnMgKm9mcywKIHsKIAlzdHJ1Y3QgdmZz
bW91bnQgKm1udCA9IG92bF91cHBlcl9tbnQob2ZzKTsKIAlzdHJ1Y3QgZGVudHJ5ICp0ZW1wOwot
CWJvb2wgcmVuYW1lX3doaXRlb3V0OworCWJvb2wgc3VwcG9ydGVkX29wczsKIAlib29sIGRfdHlw
ZTsKIAlpbnQgZmhfdHlwZTsKIAlpbnQgZXJyOwpAQCAtMTIzNSwxNCArMTI1NSwxMiBAQCBzdGF0
aWMgaW50IG92bF9tYWtlX3dvcmtkaXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IG92
bF9mcyAqb2ZzLAogCQlwcl93YXJuKCJ1cHBlciBmcyBkb2VzIG5vdCBzdXBwb3J0IHRtcGZpbGUu
XG4iKTsKIAogCi0JLyogQ2hlY2sgaWYgdXBwZXIvd29yayBmcyBzdXBwb3J0cyBSRU5BTUVfV0hJ
VEVPVVQgKi8KLQllcnIgPSBvdmxfY2hlY2tfcmVuYW1lX3doaXRlb3V0KG9mcy0+d29ya2Rpcik7
CisJLyogQ2hlY2sgaWYgdXBwZXIvd29yayBmcyBzdXBwb3J0cyByZXF1aXJlZCBvcHMgKi8KKwll
cnIgPSBvdmxfY2hlY2tfc3VwcG9ydGVkX29wcyhvZnMpOwogCWlmIChlcnIgPCAwKQogCQlnb3Rv
IG91dDsKIAotCXJlbmFtZV93aGl0ZW91dCA9IGVycjsKLQlpZiAoIXJlbmFtZV93aGl0ZW91dCkK
LQkJcHJfd2FybigidXBwZXIgZnMgZG9lcyBub3Qgc3VwcG9ydCBSRU5BTUVfV0hJVEVPVVQuXG4i
KTsKKwlzdXBwb3J0ZWRfb3BzID0gZXJyOwogCiAJLyoKIAkgKiBDaGVjayBpZiB1cHBlci93b3Jr
IGZzIHN1cHBvcnRzIHRydXN0ZWQub3ZlcmxheS4qIHhhdHRyCkBAIC0xMjY0LDcgKzEyODIsNyBA
QCBzdGF0aWMgaW50IG92bF9tYWtlX3dvcmtkaXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3Ry
dWN0IG92bF9mcyAqb2ZzLAogCSAqIHdlIGNhbiBlbmZvcmNlIHN0cmljdCByZXF1aXJlbWVudHMg
Zm9yIHJlbW90ZSB1cHBlciBmcy4KIAkgKi8KIAlpZiAob3ZsX2RlbnRyeV9yZW1vdGUob2ZzLT53
b3JrZGlyKSAmJgotCSAgICAoIWRfdHlwZSB8fCAhcmVuYW1lX3doaXRlb3V0IHx8IG9mcy0+bm94
YXR0cikpIHsKKwkgICAgKCFkX3R5cGUgfHwgIXN1cHBvcnRlZF9vcHMgfHwgb2ZzLT5ub3hhdHRy
KSkgewogCQlwcl9lcnIoInVwcGVyIGZzIG1pc3NpbmcgcmVxdWlyZWQgZmVhdHVyZXMuXG4iKTsK
IAkJZXJyID0gLUVJTlZBTDsKIAkJZ290byBvdXQ7Ci0tIAoyLjE3LjEKCg==
--000000000000709dd905a80ac219
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-ovl-inherit-supported-ops-f_mode-flags-from-final-re.patch.txt"
Content-Disposition: attachment; 
	filename="0001-ovl-inherit-supported-ops-f_mode-flags-from-final-re.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kbf2h10c0>
X-Attachment-Id: f_kbf2h10c0

RnJvbSBiZDRlNDQyNDVmMmYxNjJkYTM3YjAyZGMxZTBlNzQ1OGNkMjhhNWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDE0IEp1biAyMDIwIDEwOjQ0OjA5ICswMzAwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IG92bDogaW5oZXJpdCBzdXBwb3J0ZWQgb3BzIGZfbW9kZSBmbGFncyBmcm9tIGZpbmFsIHJlYWwK
IGZpbGUKCk1pa2UgS3JhdmV0eiByZXBvcnRlZCB0aGF0IHdoZW4gaHVnZXRsYmZzIGlzIHVzZWQg
YXMgb3ZlcmxheWZzIHVwcGVyCmxheWVyLCB3cml0ZXMgZG8gbm90IGZhaWwsIGJ1dCByZXN1bHQg
aW4gd3JpdGluZyB0byBsb3dlciBsYXllci4KClRoaXMgaXMgc3VycHJpc2luZyBiZWNhdXNlIGh1
Z2VsdGJmcyBmaWxlIGRvZXMgbm90IGhhdmUgd3JpdGUoKSBub3IKd3JpdGVfaXRlcigpIG1ldGhv
ZC4KClJlZ2FyZGxlc3Mgb2YgdGhlIHF1ZXN0aW9uIHdoZXRoZXIgb3Igbm90IHRoaXMgdHlwZSBv
ZiBmaWxlc3lzdGVtIHNob3VsZApiZSBhbGxvd2VkIGFzIG92ZXJsYXlmcyB1cHBlciBsYXllciwg
b3ZlcmxheWZzIGZpbGUgc2hvdWxkIGVtdWxhdGUgdGhlCnN1cHBvcnRlZCBvcHMgb2YgdGhlIHVu
ZGVybHlpbmcgZmlsZXMsIHNvIGF0IGxlYXN0IGluIHRoZSBjYXNlIHdoZXJlCnVuZGVybHlpbmcg
ZmlsZSBvcHMgY2Fubm90IGNoYW5nZSBhcyByZXN1bHQgb2YgY29weSB1cCwgdGhlIG92ZXJsYXlm
cwpmaWxlIHNob3VsZCBpbmhlcml0IHRoZSBmX21vZGUgZmxhZ3MgaW5kaWNhdGluZyB0aGUgc3Vw
cG9ydGVkIG9wcyBvZgp0aGUgdW5kZXJseWluZyBmaWxlLgoKUmVwb3J0ZWQtYnk6IE1pa2UgS3Jh
dmV0eiA8bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb20+ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvb3ZlcmxheWZzL2NvcHlfdXAuYyAgIHwg
MTEgKysrKysrKysrKysKIGZzL292ZXJsYXlmcy9maWxlLmMgICAgICB8IDExICsrKysrKysrKysr
CiBmcy9vdmVybGF5ZnMvb3ZlcmxheWZzLmggfCAgNSArKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAy
NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL2NvcHlfdXAuYyBiL2Zz
L292ZXJsYXlmcy9jb3B5X3VwLmMKaW5kZXggNzlkZDA1MmM3ZGJmLi40MjRmMmExNzBmMTEgMTAw
NjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9jb3B5X3VwLmMKKysrIGIvZnMvb3ZlcmxheWZzL2NvcHlf
dXAuYwpAQCAtOTUzLDYgKzk1MywxNyBAQCBzdGF0aWMgYm9vbCBvdmxfb3Blbl9uZWVkX2NvcHlf
dXAoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBpbnQgZmxhZ3MpCiAJcmV0dXJuIHRydWU7CiB9CiAK
Ky8qIE1heSBuZWVkIGNvcHkgdXAgaW4gdGhlIGZ1dHVyZT8gKi8KK2Jvb2wgb3ZsX21heV9uZWVk
X2NvcHlfdXAoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQoreworCWludCBmbGFncyA9IE9fUkRPTkxZ
OworCisJaWYgKG92bF91cHBlcl9tbnQoT1ZMX0ZTKGRlbnRyeS0+ZF9zYikpKQorCQlmbGFncyA9
IE9fUkRXUjsKKworCXJldHVybiBvdmxfb3Blbl9uZWVkX2NvcHlfdXAoZGVudHJ5LCBmbGFncyk7
Cit9CisKIGludCBvdmxfbWF5YmVfY29weV91cChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGludCBm
bGFncykKIHsKIAlpbnQgZXJyID0gMDsKZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9maWxlLmMg
Yi9mcy9vdmVybGF5ZnMvZmlsZS5jCmluZGV4IDAxODIwZTY1NGEyMS4uMDFkZDNlZDcyM2RmIDEw
MDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvZmlsZS5jCisrKyBiL2ZzL292ZXJsYXlmcy9maWxlLmMK
QEAgLTE1Myw2ICsxNTMsMTcgQEAgc3RhdGljIGludCBvdmxfb3BlbihzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAlpZiAoSVNfRVJSKHJlYWxmaWxlKSkKIAkJcmV0dXJu
IFBUUl9FUlIocmVhbGZpbGUpOwogCisJLyoKKwkgKiBPdmVybGF5IGZpbGUgc3VwcG9ydGVkIG9w
cyBhcmUgYSBzdXBlciBzZXQgb2YgdGhlIHVuZGVybHlpbmcgZmlsZQorCSAqIHN1cHBvcnRlZCBv
cHMgYW5kIHdlIGRvIG5vdCBjaGFuZ2UgdGhlbSB3aGVuIGZpbGUgaXMgY29waWVkIHVwLgorCSAq
IEJ1dCBpZiBmaWxlIGNhbm5vdCBiZSBjb3BpZWQgdXAsIHRoZW4gdGhlcmUgaXMgbm8gbmVlZCB0
byBhZHZlcnRpemUKKwkgKiBtb3JlIHN1cHBvcnRlZCBvcHMgdGhhbiB1bmRlcmx5aW5nIGZpbGUg
YWN0dWFsbHkgaGFzLgorCSAqLworCWlmICghb3ZsX21heV9uZWVkX2NvcHlfdXAoZmlsZV9kZW50
cnkoZmlsZSkpKSB7CisJCWZpbGUtPmZfbW9kZSAmPSB+T1ZMX1VQUEVSX0ZNT0RFX01BU0s7CisJ
CWZpbGUtPmZfbW9kZSB8PSByZWFsZmlsZS0+Zl9tb2RlICYgT1ZMX1VQUEVSX0ZNT0RFX01BU0s7
CisJfQorCiAJZmlsZS0+cHJpdmF0ZV9kYXRhID0gcmVhbGZpbGU7CiAKIAlyZXR1cm4gMDsKZGlm
ZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaCBiL2ZzL292ZXJsYXlmcy9vdmVybGF5
ZnMuaAppbmRleCBiNzI1YzdmMTVmZjQuLjY3NDhjMjhmZjQ3NyAxMDA2NDQKLS0tIGEvZnMvb3Zl
cmxheWZzL292ZXJsYXlmcy5oCisrKyBiL2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaApAQCAtMTEw
LDYgKzExMCwxMCBAQCBzdHJ1Y3Qgb3ZsX2ZoIHsKICNkZWZpbmUgT1ZMX0ZIX0ZJRF9PRkZTRVQJ
KE9WTF9GSF9XSVJFX09GRlNFVCArIFwKIAkJCQkgb2Zmc2V0b2Yoc3RydWN0IG92bF9mYiwgZmlk
KSkKIAorLyogZl9tb2RlIGJpdHMgZXhwZWN0ZWQgdG8gYmUgc2V0IG9uIGFuIHVwcGVyIGZpbGUg
Ki8KKyNkZWZpbmUgT1ZMX1VQUEVSX0ZNT0RFX01BU0sgKEZNT0RFX0NBTl9SRUFEIHwgRk1PREVf
Q0FOX1dSSVRFIHwgXAorCQkJICAgICAgRk1PREVfTFNFRUsgfCBGTU9ERV9QUkVBRCB8IEZNT0RF
X1BXUklURSkKKwogc3RhdGljIGlubGluZSBpbnQgb3ZsX2RvX3JtZGlyKHN0cnVjdCBpbm9kZSAq
ZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpCiB7CiAJaW50IGVyciA9IHZmc19ybWRpcihkaXIs
IGRlbnRyeSk7CkBAIC00ODUsNiArNDg5LDcgQEAgaW50IG92bF9jb3B5X3VwKHN0cnVjdCBkZW50
cnkgKmRlbnRyeSk7CiBpbnQgb3ZsX2NvcHlfdXBfd2l0aF9kYXRhKHN0cnVjdCBkZW50cnkgKmRl
bnRyeSk7CiBpbnQgb3ZsX2NvcHlfdXBfZmxhZ3Moc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBpbnQg
ZmxhZ3MpOwogaW50IG92bF9tYXliZV9jb3B5X3VwKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgaW50
IGZsYWdzKTsKK2Jvb2wgb3ZsX21heV9uZWVkX2NvcHlfdXAoc3RydWN0IGRlbnRyeSAqZGVudHJ5
KTsKIGludCBvdmxfY29weV94YXR0cihzdHJ1Y3QgZGVudHJ5ICpvbGQsIHN0cnVjdCBkZW50cnkg
Km5ldyk7CiBpbnQgb3ZsX3NldF9hdHRyKHN0cnVjdCBkZW50cnkgKnVwcGVyLCBzdHJ1Y3Qga3N0
YXQgKnN0YXQpOwogc3RydWN0IG92bF9maCAqb3ZsX2VuY29kZV9yZWFsX2ZoKHN0cnVjdCBkZW50
cnkgKnJlYWwsIGJvb2wgaXNfdXBwZXIpOwotLSAKMi4xNy4xCgo=
--000000000000709dd905a80ac219--
