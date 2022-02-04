Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2B4A9D53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiBDREO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 12:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiBDREO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:04:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186E6C061714
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Feb 2022 09:04:14 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j14so9412440lja.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Feb 2022 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=sHNaCUSyi40jeSk5rgZsLUetSbk8OD0s9HLyoh3WK4w=;
        b=oJYKx0DA3ZTIhgzaDcg3HdM8ROoOxU4w6uPwwEmu95Ml/6Th5nAGRhzjpnAHrKm884
         9aKKpS7bb0NHPlfIUN6j8brLaenqTIfTwpeK1+DjZ4LAMOGyN2SExEf+0AF1X8g9rt3H
         sFI0/2Yb6/AGMgwJHcSNm0cbDKrbDOLz4UIWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sHNaCUSyi40jeSk5rgZsLUetSbk8OD0s9HLyoh3WK4w=;
        b=PArCJbWPaz28nqN4d7fg/Hp0Cig374tsIkpSgWNDfD3bRDKtnK07mM4msOHQJIkuLW
         mAzkusuCOL/pVXhAPdLQECVnDr6C6T7/NoNVxn4jK3WTlwoJ5/jde6fOISs2p8PaulnB
         0iE3/1ZvmoJRRqKtJRsAYnAqYUNIPxlJxoJTu2pMKO8wkn0Ma4vCoSNckP4dfUOnbL3o
         3eEK4SpL3wVS/wGhxQ+ukxzarlNn/9uYQoWHEAFswKewpZTn+nsWSZJ7gA2zSvpU7RAv
         35mFbFuJHartmfXK3o55wTUdZM7gCEGXFqowFvqpuyLbZcpF+Q7bzDbUOAhn87Wmpq8Y
         kKfg==
X-Gm-Message-State: AOAM530EkmYwCoEREvt08E+sVYl4RQPJJoIMqpp1ShpCkm98kgv8CrJe
        P2iXWjRBxdemINumtG9Af9caP+jilkOdsj7LPoMsPNCe4+Pnww==
X-Google-Smtp-Source: ABdhPJwl4FzxprQpirDXGCRk8rYsALsCrs3A+5QCUbWl9aWTqtjqtRUoIPU4NnJC1n0/HWLexJKN5+6bAiRrRl6OS+8=
X-Received: by 2002:a05:651c:2122:: with SMTP id a34mr2322775ljq.50.1643994252032;
 Fri, 04 Feb 2022 09:04:12 -0800 (PST)
MIME-Version: 1.0
From:   Xavier Roche <xavier.roche@algolia.com>
Date:   Fri, 4 Feb 2022 18:04:01 +0100
Message-ID: <CAE9vp3+H6zjPqR=6JcH=5FmX7C2kvLTruxrMmQ=XSTtppvxpxg@mail.gmail.com>
Subject: [PATCH RFC] Support for btime (creation time) for tmpfs/shmem ?
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000067eb0705d7343d7d"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000067eb0705d7343d7d
Content-Type: text/plain; charset="UTF-8"

Hi,

I am wondering if including support for creation time for tmpfs would
be something sensible ?

The attached patch tentatively adds support for a creation time in
mm/shmem.c, but the patch is probably incomplete or broken, because
while files do appear to behave correctly in tmpfs (birth time is
correctly set, and unmodified when the file is touched), directories
do not appear to bear any metadata (I am missing an obvious other
codepath than shmem_getattr).

Any comment (or rebuttal) welcome.

Note: the birth time can be checked with the now standard statx call:

#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char** argv)
{
    if (argc == 1) {
        fprintf(stderr, "Usage: %s [file...]\n", argv[0]);
    }
    int i;
    for (i = 1; i < argc; i++) {
        struct statx st;
        if (statx(AT_FDCWD, argv[i], 0, STATX_ALL, &st) == 0) {
            fprintf(stderr,
                    "file='%s',\tmtime == %ld,\tbtime == %ld\n",
                    argv[i],
                    (long)st.stx_mtime.tv_sec,
                    (long)st.stx_btime.tv_sec);
        } else {
            perror("statx");
        }
    }

    return EXIT_SUCCESS;
}


-- 
Xavier Roche

--00000000000067eb0705d7343d7d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-support-for-file-creation-time.patch"
Content-Disposition: attachment; 
	filename="0001-mm-support-for-file-creation-time.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kz8ngb5t0>
X-Attachment-Id: f_kz8ngb5t0

RnJvbSBjYmNmYzI2ODY5NGVhZjg0OTNjYjdhNDNjNDBjYjkzM2I0YmYxYWEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYYXZpZXIgUm9jaGUgPHhhdmllci5yb2NoZUBhbGdvbGlhLmNv
bT4KRGF0ZTogVGh1LCAzIEZlYiAyMDIyIDE2OjA0OjAyICswMTAwClN1YmplY3Q6IFtQQVRDSF0g
bW06IHN1cHBvcnQgZm9yIGZpbGUgY3JlYXRpb24gdGltZQoKLS0tCiBpbmNsdWRlL2xpbnV4L3No
bWVtX2ZzLmggfCAxICsKIG1tL3NobWVtLmMgICAgICAgICAgICAgICB8IDcgKysrKysrKwogMiBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3NobWVtX2ZzLmggYi9pbmNsdWRlL2xpbnV4L3NobWVtX2ZzLmgKaW5kZXggZTY1YjgwZWQwOWU3
Li4yOTc4Nzc2N2MzYjkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2htZW1fZnMuaAorKysg
Yi9pbmNsdWRlL2xpbnV4L3NobWVtX2ZzLmgKQEAgLTI1LDYgKzI1LDcgQEAgc3RydWN0IHNobWVt
X2lub2RlX2luZm8gewogCXN0cnVjdCBzaW1wbGVfeGF0dHJzCXhhdHRyczsJCS8qIGxpc3Qgb2Yg
eGF0dHJzICovCiAJYXRvbWljX3QJCXN0b3BfZXZpY3Rpb247CS8qIGhvbGQgd2hlbiB3b3JraW5n
IG9uIGlub2RlICovCiAJc3RydWN0IGlub2RlCQl2ZnNfaW5vZGU7CisJc3RydWN0IHRpbWVzcGVj
NjQJaV9jcnRpbWU7CS8qIGZpbGUgY3JlYXRpb24gdGltZSAqLwogfTsKIAogc3RydWN0IHNobWVt
X3NiX2luZm8gewpkaWZmIC0tZ2l0IGEvbW0vc2htZW0uYyBiL21tL3NobWVtLmMKaW5kZXggYTA5
YjI5ZWMyYjQ1Li40NzFlOGI2ZTkxZjEgMTAwNjQ0Ci0tLSBhL21tL3NobWVtLmMKKysrIGIvbW0v
c2htZW0uYwpAQCAtMTA2MSw2ICsxMDYxLDEyIEBAIHN0YXRpYyBpbnQgc2htZW1fZ2V0YXR0cihz
dHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsCiAJaWYgKHNobWVtX2lzX2h1Z2UoTlVM
TCwgaW5vZGUsIDApKQogCQlzdGF0LT5ibGtzaXplID0gSFBBR0VfUE1EX1NJWkU7CiAKKwlpZiAo
KHJlcXVlc3RfbWFzayAmIFNUQVRYX0JUSU1FKSkgeworCQlzdGF0LT5yZXN1bHRfbWFzayB8PSBT
VEFUWF9CVElNRTsKKwkJc3RhdC0+YnRpbWUudHZfc2VjID0gaW5mby0+aV9jcnRpbWUudHZfc2Vj
OworCQlzdGF0LT5idGltZS50dl9uc2VjID0gaW5mby0+aV9jcnRpbWUudHZfbnNlYzsKKwl9CisK
IAlyZXR1cm4gMDsKIH0KIApAQCAtMjI2NSw2ICsyMjcxLDcgQEAgc3RhdGljIHN0cnVjdCBpbm9k
ZSAqc2htZW1fZ2V0X2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGNvbnN0IHN0cnVjdCBp
bm9kZQogCQlhdG9taWNfc2V0KCZpbmZvLT5zdG9wX2V2aWN0aW9uLCAwKTsKIAkJaW5mby0+c2Vh
bHMgPSBGX1NFQUxfU0VBTDsKIAkJaW5mby0+ZmxhZ3MgPSBmbGFncyAmIFZNX05PUkVTRVJWRTsK
KwkJaW5mby0+aV9jcnRpbWUgPSBpbm9kZS0+aV9tdGltZTsKIAkJSU5JVF9MSVNUX0hFQUQoJmlu
Zm8tPnNocmlua2xpc3QpOwogCQlJTklUX0xJU1RfSEVBRCgmaW5mby0+c3dhcGxpc3QpOwogCQlz
aW1wbGVfeGF0dHJzX2luaXQoJmluZm8tPnhhdHRycyk7Ci0tIAoyLjI1LjEKCg==
--00000000000067eb0705d7343d7d--
