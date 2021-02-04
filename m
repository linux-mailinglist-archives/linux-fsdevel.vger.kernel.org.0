Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9F30EC7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 07:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBDG0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 01:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhBDG0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:26:09 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E1C061573;
        Wed,  3 Feb 2021 22:25:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a25so2099349ljn.0;
        Wed, 03 Feb 2021 22:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8BCgyPWgryxP/tPOgkCVquqADpYLO+SLhESdmPZvlaU=;
        b=ljb68kfuT/kr/btK4c2jNN/ZQGrslJp9V1MUyd6iUGTD97wQsU+E9fdpmi98w7moN8
         mGrJGrqE7KgG2wPeC5//KGSatul99XyOCi8H4bOBMTKBRQVsTz87bjQa4/k2E4C98OKm
         1my04kQjPKHHCl5+Ui7z317CnWI6yPD3yb2rzKkobHj3LvtHtQtsuzUmWAPDTY4R2/9j
         EnKCAJenT51+X9aUO2HzDBg4vGvY3NuXmTLydvPrh9WxHbC/AVaBCLpv2+321w4nJeAm
         gRyWH6KfdAykkrdiB3qnuW0SXdd8v2Y+8x+fjLqX7VATNeFeyI2kEiH/EvCNkW75SNtj
         p2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8BCgyPWgryxP/tPOgkCVquqADpYLO+SLhESdmPZvlaU=;
        b=F5ebyqEozYDUoBBnxKJXkR2F2jcQh1jCRQA9YUc039o5LCHXmqFhwFaqEuLTzAohg3
         xqvTYTzucbCn2bhN//45+y0G0NUTPbPw68TBcNu3bhDkw+eaTq2Iu5TuDwDwDLO1xNIk
         PruHbHQHxIMSjVoj5es66DEY0/F+7pRbgIGApNtLAp88XyYh+GqQjVrwwmjyAucDav24
         tc45QWFBhHxaYQQTLSq3A2afTqyMR4x1j8yf2s3F4YvpTOiiaqfxH10t95ntBSrWv5LY
         4fFFNKe3fzE6GecmJXJ+js7+XWIaLfEiRAiWPDfhP+3LTGxlnM0tSS3pIfy6WGYqICLl
         unGw==
X-Gm-Message-State: AOAM533uZxSx9EBDkL+CX+63ZQiH6zvqsi2TkHLxs7HEFwqY6SUdV0aX
        U2OYyewmDlybD5v3x78QNu3/3XUKbMJtIHLyYKNpAJf5JEmItw==
X-Google-Smtp-Source: ABdhPJyzO2OIf3a6lVmDASi9DdnGK5WUD7GDjWFDEFM7ERU54E02H5CQ0z6lhLr00EdoyjOLxsQOFEy85PpHqTN8dzM=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr4005423ljj.477.1612419927349;
 Wed, 03 Feb 2021 22:25:27 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 4 Feb 2021 00:25:16 -0600
Message-ID: <CAH2r5ms9dJ3RW=_+c0HApLyUC=LD5ACp_nhE2jJQuS-121kV=w@mail.gmail.com>
Subject: [PATCH] cifs: use discard iterator to discard unneeded network data
 more efficiently
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000ffb93d05ba7cc4f3"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ffb93d05ba7cc4f3
Content-Type: text/plain; charset="UTF-8"

(cleanup patch, to make netfs merge easier)

The iterator, ITER_DISCARD, that can only be used in READ mode and
just discards any data copied to it, was added to allow a network
filesystem to discard any unwanted data sent by a server.
Convert cifs_discard_from_socket() to use this.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/cifsproto.h |  2 ++
 fs/cifs/cifssmb.c   |  6 +++---
 fs/cifs/connect.c   | 10 ++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 32f7a013402e..75ce6f742b8d 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -232,6 +232,8 @@ extern unsigned int
setup_special_user_owner_ACE(struct cifs_ace *pace);
 extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
           unsigned int to_read);
+extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
+ size_t to_read);
 extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
  struct page *page,
  unsigned int page_offset,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 0496934feecb..c279527aae92 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1451,9 +1451,9 @@ cifs_discard_remaining_data(struct
TCP_Server_Info *server)
  while (remaining > 0) {
  int length;

- length = cifs_read_from_socket(server, server->bigbuf,
- min_t(unsigned int, remaining,
-     CIFSMaxBufSize + MAX_HEADER_SIZE(server)));
+ length = cifs_discard_from_socket(server,
+ min_t(size_t, remaining,
+       CIFSMaxBufSize + MAX_HEADER_SIZE(server)));
  if (length < 0)
  return length;
  server->total_read += length;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 10fe6d6d2dee..943f4eba027d 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -564,6 +564,16 @@ cifs_read_from_socket(struct TCP_Server_Info
*server, char *buf,
  return cifs_readv_from_socket(server, &smb_msg);
 }

+ssize_t
+cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
+{
+ struct msghdr smb_msg;
+
+ iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
+
+ return cifs_readv_from_socket(server, &smb_msg);
+}
+
 int
 cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
  unsigned int page_offset, unsigned int to_read)

-- 
Thanks,

Steve

--000000000000ffb93d05ba7cc4f3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-use-discard-iterator-to-discard-unneeded-networ.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-use-discard-iterator-to-discard-unneeded-networ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkqh5tsv0>
X-Attachment-Id: f_kkqh5tsv0

RnJvbSBjM2E0NjIxZjU2ZGI4MDM4YjE5ODQ0ZmE5ZDVmMzk1MWFmYWFjNGZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUaHUsIDQgRmViIDIwMjEgMDA6MTU6MjEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBjaWZz
OiB1c2UgZGlzY2FyZCBpdGVyYXRvciB0byBkaXNjYXJkIHVubmVlZGVkIG5ldHdvcmsgZGF0YQog
bW9yZSBlZmZpY2llbnRseQoKVGhlIGl0ZXJhdG9yLCBJVEVSX0RJU0NBUkQsIHRoYXQgY2FuIG9u
bHkgYmUgdXNlZCBpbiBSRUFEIG1vZGUgYW5kCmp1c3QgZGlzY2FyZHMgYW55IGRhdGEgY29waWVk
IHRvIGl0LCB3YXMgYWRkZWQgdG8gYWxsb3cgYSBuZXR3b3JrCmZpbGVzeXN0ZW0gdG8gZGlzY2Fy
ZCBhbnkgdW53YW50ZWQgZGF0YSBzZW50IGJ5IGEgc2VydmVyLgpDb252ZXJ0IGNpZnNfZGlzY2Fy
ZF9mcm9tX3NvY2tldCgpIHRvIHVzZSB0aGlzLgoKU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxs
cyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZy
ZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc3Byb3RvLmggfCAgMiArKwogZnMv
Y2lmcy9jaWZzc21iLmMgICB8ICA2ICsrKy0tLQogZnMvY2lmcy9jb25uZWN0LmMgICB8IDEwICsr
KysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNwcm90by5oIGIvZnMvY2lmcy9jaWZzcHJvdG8u
aAppbmRleCAzMmY3YTAxMzQwMmUuLjc1Y2U2Zjc0MmI4ZCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9j
aWZzcHJvdG8uaAorKysgYi9mcy9jaWZzL2NpZnNwcm90by5oCkBAIC0yMzIsNiArMjMyLDggQEAg
ZXh0ZXJuIHVuc2lnbmVkIGludCBzZXR1cF9zcGVjaWFsX3VzZXJfb3duZXJfQUNFKHN0cnVjdCBj
aWZzX2FjZSAqcGFjZSk7CiBleHRlcm4gdm9pZCBkZXF1ZXVlX21pZChzdHJ1Y3QgbWlkX3FfZW50
cnkgKm1pZCwgYm9vbCBtYWxmb3JtZWQpOwogZXh0ZXJuIGludCBjaWZzX3JlYWRfZnJvbV9zb2Nr
ZXQoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCBjaGFyICpidWYsCiAJCQkgICAgICAg
ICB1bnNpZ25lZCBpbnQgdG9fcmVhZCk7CitleHRlcm4gc3NpemVfdCBjaWZzX2Rpc2NhcmRfZnJv
bV9zb2NrZXQoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLAorCQkJCQlzaXplX3QgdG9f
cmVhZCk7CiBleHRlcm4gaW50IGNpZnNfcmVhZF9wYWdlX2Zyb21fc29ja2V0KHN0cnVjdCBUQ1Bf
U2VydmVyX0luZm8gKnNlcnZlciwKIAkJCQkJc3RydWN0IHBhZ2UgKnBhZ2UsCiAJCQkJCXVuc2ln
bmVkIGludCBwYWdlX29mZnNldCwKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc3NtYi5jIGIvZnMv
Y2lmcy9jaWZzc21iLmMKaW5kZXggMDQ5NjkzNGZlZWNiLi5jMjc5NTI3YWFlOTIgMTAwNjQ0Ci0t
LSBhL2ZzL2NpZnMvY2lmc3NtYi5jCisrKyBiL2ZzL2NpZnMvY2lmc3NtYi5jCkBAIC0xNDUxLDkg
KzE0NTEsOSBAQCBjaWZzX2Rpc2NhcmRfcmVtYWluaW5nX2RhdGEoc3RydWN0IFRDUF9TZXJ2ZXJf
SW5mbyAqc2VydmVyKQogCXdoaWxlIChyZW1haW5pbmcgPiAwKSB7CiAJCWludCBsZW5ndGg7CiAK
LQkJbGVuZ3RoID0gY2lmc19yZWFkX2Zyb21fc29ja2V0KHNlcnZlciwgc2VydmVyLT5iaWdidWYs
Ci0JCQkJbWluX3QodW5zaWduZWQgaW50LCByZW1haW5pbmcsCi0JCQkJICAgIENJRlNNYXhCdWZT
aXplICsgTUFYX0hFQURFUl9TSVpFKHNlcnZlcikpKTsKKwkJbGVuZ3RoID0gY2lmc19kaXNjYXJk
X2Zyb21fc29ja2V0KHNlcnZlciwKKwkJCQltaW5fdChzaXplX3QsIHJlbWFpbmluZywKKwkJCQkg
ICAgICBDSUZTTWF4QnVmU2l6ZSArIE1BWF9IRUFERVJfU0laRShzZXJ2ZXIpKSk7CiAJCWlmIChs
ZW5ndGggPCAwKQogCQkJcmV0dXJuIGxlbmd0aDsKIAkJc2VydmVyLT50b3RhbF9yZWFkICs9IGxl
bmd0aDsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY29ubmVjdC5jIGIvZnMvY2lmcy9jb25uZWN0LmMK
aW5kZXggMTBmZTZkNmQyZGVlLi45NDNmNGViYTAyN2QgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY29u
bmVjdC5jCisrKyBiL2ZzL2NpZnMvY29ubmVjdC5jCkBAIC01NjQsNiArNTY0LDE2IEBAIGNpZnNf
cmVhZF9mcm9tX3NvY2tldChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsIGNoYXIgKmJ1
ZiwKIAlyZXR1cm4gY2lmc19yZWFkdl9mcm9tX3NvY2tldChzZXJ2ZXIsICZzbWJfbXNnKTsKIH0K
IAorc3NpemVfdAorY2lmc19kaXNjYXJkX2Zyb21fc29ja2V0KHN0cnVjdCBUQ1BfU2VydmVyX0lu
Zm8gKnNlcnZlciwgc2l6ZV90IHRvX3JlYWQpCit7CisJc3RydWN0IG1zZ2hkciBzbWJfbXNnOwor
CisJaW92X2l0ZXJfZGlzY2FyZCgmc21iX21zZy5tc2dfaXRlciwgUkVBRCwgdG9fcmVhZCk7CisK
KwlyZXR1cm4gY2lmc19yZWFkdl9mcm9tX3NvY2tldChzZXJ2ZXIsICZzbWJfbXNnKTsKK30KKwog
aW50CiBjaWZzX3JlYWRfcGFnZV9mcm9tX3NvY2tldChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpz
ZXJ2ZXIsIHN0cnVjdCBwYWdlICpwYWdlLAogCXVuc2lnbmVkIGludCBwYWdlX29mZnNldCwgdW5z
aWduZWQgaW50IHRvX3JlYWQpCi0tIAoyLjI3LjAKCg==
--000000000000ffb93d05ba7cc4f3--
