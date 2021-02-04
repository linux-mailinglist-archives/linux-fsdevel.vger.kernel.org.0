Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3030ECB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhBDGuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 01:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhBDGuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:50:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42BDC061573;
        Wed,  3 Feb 2021 22:49:40 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a17so2132726ljq.2;
        Wed, 03 Feb 2021 22:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hn55GUfhyq3P6czDbmvqar/cddItmhmrdCEeqddMYkw=;
        b=pfvG25T+N9DqU/VW0LyV25J+UlhzUnPyOADcTb2WKw/ZH4M4cF7hfUxN5JcxolHk7b
         OocHSTR038ZMC0kCFaJi1KTFPBaTpKaLwVUI3pxptphmjIcR2HIQW9AxCpwdfm5VyqKx
         kaYwBr2FhmNhFvaBz47PAc/ZIZMEy+gFTyRkDc9Pt7SmT313P8Z4TEqz2RLqHM+rnaYZ
         C8bpe/IyfutaaRrNT51kXujB1r40POIvyjtu4OJhsPw5vmOrnwuX36/hJlDORzPOyuef
         /j8vchmcQqEZDzMW6/xKk+7L+afleiUUfNh3L2wsM1vHpRyQ0iou7pAn6AT0bQBpJoPz
         96pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hn55GUfhyq3P6czDbmvqar/cddItmhmrdCEeqddMYkw=;
        b=ZCUYlwpwb8kCJitMrOnzkw6Dvm86ISugEgH9sA5+0vhJkDn/88KLgXBFnue9MWSwFr
         YYIO0dSCD1YOjL9xMYP78/SRYi/12kiOUbrix5XkSWEGcR/OLB070FR8Fcq5WkuHTW63
         btNLmw4UxwrZ5ks5kGjUjSGfg3fETuTS5m/MbgWrIB3q5ewf6djQ+kBw9cCYxgn1ymYo
         SGt2gXfM18B8sBF156K8OCwDWykXqo2O65UEqVQoGQHuHjD/PaZacEAbR8VWJ8WCYiX3
         2DNDPm0bdL1GcmyuoNxipKLGkWqC4MfItzuzpjr1cNylryZM/QtAORX6WWRswGtr37Ye
         8VAQ==
X-Gm-Message-State: AOAM5326A751X72Nmr2dQHAJEwZ0L5NoqMsEsUcoDzzX54bGjNSltO2j
        XDvuUnjF0/gYpu+NY/dXIjBOVUIaojaCEXncG1N4JRzPoQcRWw==
X-Google-Smtp-Source: ABdhPJyhAg6Nk5M4s4pthONsgcqhKhg+bwk2gWQPhGG8wXdyGk4DaUYCdYVPBq3TiQ2NxkLVlvd1lCKT7n7+XEb7S9Y=
X-Received: by 2002:a05:651c:548:: with SMTP id q8mr3884690ljp.256.1612421378506;
 Wed, 03 Feb 2021 22:49:38 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 4 Feb 2021 00:49:27 -0600
Message-ID: <CAH2r5mt+69AZFh_2OOd2JHLtqG9jo7=O7HF4bTGbSjhgi=M53g@mail.gmail.com>
Subject: [PATCH] cifs: convert readpages_fill_pages to use iter
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000007e9f1405ba7d1b61"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000007e9f1405ba7d1b61
Content-Type: text/plain; charset="UTF-8"

(Another patch to make conversion to new netfs interfaces easier)

Optimize read_page_from_socket by using an iov_iter

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/cifsglob.h  |  1 +
 fs/cifs/cifsproto.h |  3 +++
 fs/cifs/connect.c   | 16 ++++++++++++++++
 fs/cifs/file.c      |  3 +--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 50fcb65920e8..73f80cc38316 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1301,6 +1301,7 @@ struct cifs_readdata {
  int (*copy_into_pages)(struct TCP_Server_Info *server,
  struct cifs_readdata *rdata,
  struct iov_iter *iter);
+ struct iov_iter iter;
  struct kvec iov[2];
  struct TCP_Server_Info *server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 75ce6f742b8d..64eb5c817712 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -239,6 +239,9 @@ extern int cifs_read_page_from_socket(struct
TCP_Server_Info *server,
  unsigned int page_offset,
  unsigned int to_read);
 extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
+extern int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
+       struct iov_iter *iter,
+       unsigned int to_read);
 extern int cifs_match_super(struct super_block *, void *);
 extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct
smb3_fs_context *ctx);
 extern void cifs_umount(struct cifs_sb_info *);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 943f4eba027d..7c8db233fba4 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -585,6 +585,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info
*server, struct page *page,
  return cifs_readv_from_socket(server, &smb_msg);
 }

+int
+cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct
iov_iter *iter,
+    unsigned int to_read)
+{
+ struct msghdr smb_msg;
+ int ret;
+
+ smb_msg.msg_iter = *iter;
+ if (smb_msg.msg_iter.count > to_read)
+ smb_msg.msg_iter.count = to_read;
+ ret = cifs_readv_from_socket(server, &smb_msg);
+ if (ret > 0)
+ iov_iter_advance(iter, ret);
+ return ret;
+}
+
 static bool
 is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 {
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 6d001905c8e5..4b8c1ac58f00 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4261,8 +4261,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
  result = n;
 #endif
  else
- result = cifs_read_page_from_socket(
- server, page, page_offset, n);
+ result = cifs_read_iter_from_socket(server, &rdata->iter, n);
  if (result < 0)
  break;


-- 
Thanks,

Steve

--0000000000007e9f1405ba7d1b61
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-convert-readpages_fill_pages-to-use-iter.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-convert-readpages_fill_pages-to-use-iter.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkqi1q1t0>
X-Attachment-Id: f_kkqi1q1t0

RnJvbSBhNGM5NjM4MDNkZGY4YzE3ZjM2OTEzMDg5OTY1ZjAzNDhlNTM2MzMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUaHUsIDQgRmViIDIwMjEgMDA6NDQ6MDQgLTA2MDAKU3ViamVjdDogW1BBVENIXSBjaWZz
OiBjb252ZXJ0IHJlYWRwYWdlc19maWxsX3BhZ2VzIHRvIHVzZSBpdGVyCgpPcHRpbWl6ZSByZWFk
X3BhZ2VfZnJvbV9zb2NrZXQgYnkgdXNpbmcgYW4gaW92X2l0ZXIKClNpZ25lZC1vZmYtYnk6IERh
dmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZy
ZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2NpZnNnbG9iLmggIHwg
IDEgKwogZnMvY2lmcy9jaWZzcHJvdG8uaCB8ICAzICsrKwogZnMvY2lmcy9jb25uZWN0LmMgICB8
IDE2ICsrKysrKysrKysrKysrKysKIGZzL2NpZnMvZmlsZS5jICAgICAgfCAgMyArLS0KIDQgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9mcy9jaWZzL2NpZnNnbG9iLmggYi9mcy9jaWZzL2NpZnNnbG9iLmgKaW5kZXggNTBmY2I2NTky
MGU4Li43M2Y4MGNjMzgzMTYgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc2dsb2IuaAorKysgYi9m
cy9jaWZzL2NpZnNnbG9iLmgKQEAgLTEzMDEsNiArMTMwMSw3IEBAIHN0cnVjdCBjaWZzX3JlYWRk
YXRhIHsKIAlpbnQgKCpjb3B5X2ludG9fcGFnZXMpKHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNl
cnZlciwKIAkJCQlzdHJ1Y3QgY2lmc19yZWFkZGF0YSAqcmRhdGEsCiAJCQkJc3RydWN0IGlvdl9p
dGVyICppdGVyKTsKKwlzdHJ1Y3QgaW92X2l0ZXIJCQlpdGVyOwogCXN0cnVjdCBrdmVjCQkJaW92
WzJdOwogCXN0cnVjdCBUQ1BfU2VydmVyX0luZm8JCSpzZXJ2ZXI7CiAjaWZkZWYgQ09ORklHX0NJ
RlNfU01CX0RJUkVDVApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzcHJvdG8uaCBiL2ZzL2NpZnMv
Y2lmc3Byb3RvLmgKaW5kZXggNzVjZTZmNzQyYjhkLi42NGViNWM4MTc3MTIgMTAwNjQ0Ci0tLSBh
L2ZzL2NpZnMvY2lmc3Byb3RvLmgKKysrIGIvZnMvY2lmcy9jaWZzcHJvdG8uaApAQCAtMjM5LDYg
KzIzOSw5IEBAIGV4dGVybiBpbnQgY2lmc19yZWFkX3BhZ2VfZnJvbV9zb2NrZXQoc3RydWN0IFRD
UF9TZXJ2ZXJfSW5mbyAqc2VydmVyLAogCQkJCQl1bnNpZ25lZCBpbnQgcGFnZV9vZmZzZXQsCiAJ
CQkJCXVuc2lnbmVkIGludCB0b19yZWFkKTsKIGV4dGVybiBpbnQgY2lmc19zZXR1cF9jaWZzX3Ni
KHN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IpOworZXh0ZXJuIGludCBjaWZzX3JlYWRfaXRl
cl9mcm9tX3NvY2tldChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsCisJCQkJICAgICAg
c3RydWN0IGlvdl9pdGVyICppdGVyLAorCQkJCSAgICAgIHVuc2lnbmVkIGludCB0b19yZWFkKTsK
IGV4dGVybiBpbnQgY2lmc19tYXRjaF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKiwgdm9pZCAq
KTsKIGV4dGVybiBpbnQgY2lmc19tb3VudChzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiLCBz
dHJ1Y3Qgc21iM19mc19jb250ZXh0ICpjdHgpOwogZXh0ZXJuIHZvaWQgY2lmc191bW91bnQoc3Ry
dWN0IGNpZnNfc2JfaW5mbyAqKTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY29ubmVjdC5jIGIvZnMv
Y2lmcy9jb25uZWN0LmMKaW5kZXggOTQzZjRlYmEwMjdkLi43YzhkYjIzM2ZiYTQgMTAwNjQ0Ci0t
LSBhL2ZzL2NpZnMvY29ubmVjdC5jCisrKyBiL2ZzL2NpZnMvY29ubmVjdC5jCkBAIC01ODUsNiAr
NTg1LDIyIEBAIGNpZnNfcmVhZF9wYWdlX2Zyb21fc29ja2V0KHN0cnVjdCBUQ1BfU2VydmVyX0lu
Zm8gKnNlcnZlciwgc3RydWN0IHBhZ2UgKnBhZ2UsCiAJcmV0dXJuIGNpZnNfcmVhZHZfZnJvbV9z
b2NrZXQoc2VydmVyLCAmc21iX21zZyk7CiB9CiAKK2ludAorY2lmc19yZWFkX2l0ZXJfZnJvbV9z
b2NrZXQoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCBzdHJ1Y3QgaW92X2l0ZXIgKml0
ZXIsCisJCQkgICB1bnNpZ25lZCBpbnQgdG9fcmVhZCkKK3sKKwlzdHJ1Y3QgbXNnaGRyIHNtYl9t
c2c7CisJaW50IHJldDsKKworCXNtYl9tc2cubXNnX2l0ZXIgPSAqaXRlcjsKKwlpZiAoc21iX21z
Zy5tc2dfaXRlci5jb3VudCA+IHRvX3JlYWQpCisJCXNtYl9tc2cubXNnX2l0ZXIuY291bnQgPSB0
b19yZWFkOworCXJldCA9IGNpZnNfcmVhZHZfZnJvbV9zb2NrZXQoc2VydmVyLCAmc21iX21zZyk7
CisJaWYgKHJldCA+IDApCisJCWlvdl9pdGVyX2FkdmFuY2UoaXRlciwgcmV0KTsKKwlyZXR1cm4g
cmV0OworfQorCiBzdGF0aWMgYm9vbAogaXNfc21iX3Jlc3BvbnNlKHN0cnVjdCBUQ1BfU2VydmVy
X0luZm8gKnNlcnZlciwgdW5zaWduZWQgY2hhciB0eXBlKQogewpkaWZmIC0tZ2l0IGEvZnMvY2lm
cy9maWxlLmMgYi9mcy9jaWZzL2ZpbGUuYwppbmRleCA2ZDAwMTkwNWM4ZTUuLjRiOGMxYWM1OGYw
MCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9maWxlLmMKKysrIGIvZnMvY2lmcy9maWxlLmMKQEAgLTQy
NjEsOCArNDI2MSw3IEBAIHJlYWRwYWdlc19maWxsX3BhZ2VzKHN0cnVjdCBUQ1BfU2VydmVyX0lu
Zm8gKnNlcnZlciwKIAkJCXJlc3VsdCA9IG47CiAjZW5kaWYKIAkJZWxzZQotCQkJcmVzdWx0ID0g
Y2lmc19yZWFkX3BhZ2VfZnJvbV9zb2NrZXQoCi0JCQkJCXNlcnZlciwgcGFnZSwgcGFnZV9vZmZz
ZXQsIG4pOworCQkJcmVzdWx0ID0gY2lmc19yZWFkX2l0ZXJfZnJvbV9zb2NrZXQoc2VydmVyLCAm
cmRhdGEtPml0ZXIsIG4pOwogCQlpZiAocmVzdWx0IDwgMCkKIAkJCWJyZWFrOwogCi0tIAoyLjI3
LjAKCg==
--0000000000007e9f1405ba7d1b61--
