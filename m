Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F4CB1F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfJCWjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 18:39:01 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:41673 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfJCWjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:39:01 -0400
Received: by mail-io1-f45.google.com with SMTP id n26so9275350ioj.8;
        Thu, 03 Oct 2019 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xfQsyRrCq1AzCVJLTgc7JdY4HG0z0X5Xs7b59g9+I5Q=;
        b=VuXotxnbCf9TOWbMIlo9KTk2/qnDyjDImJuSKpp55BJaMSxGjncZ7teSLawu638w4a
         fWSFxEUNfxSXEEb90YHaLvNYfxJ8Y+lNLqmbXa8dEY1hdTntHtkM4koVSZI9i7Gcmpcf
         oSWje2RRqeJ+8dkIAJa8bfSlhNFWqoNnbcIOczpAKldSq+gV3vs0g1XbGVV2i6exrFKL
         OlIuQFlPAyu7Hn8ZQQGHhMu2Pv9VASYfzufHaoi2TGeSyBP/Etq5VnNpACqyH+YcZ0ju
         U7XDqiDf0dxGc84gyo8Jvps0w1i3bxWremBRsWnJE64ew62TU56/oxWSAvm5GzAEhwFG
         9/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xfQsyRrCq1AzCVJLTgc7JdY4HG0z0X5Xs7b59g9+I5Q=;
        b=dYF/n+qX9W7esWDInO5psRT489H2Ir7PFN31ZppOg/mf0nknPe0IWQMSy2F9TPYM6F
         kewPNGgk4NQy+aufRdQaGT0GZgE40sS2QtpnrdGRrHhvkPZt0ImW7AkBiOSaDpzCpPhf
         yewqzvR1QIGKwviXSG7iyu0HK9IH58Wk1jZu7goZBvnyW+1Gpp42nkFHNJDOEdyMG3NI
         /8zeF/59ZL26e7hx2qYjHcoi8s9zmUCU7ZkFbKEkUiYja0dyZUFj8bSRJyWG7F8heAtE
         e4rNpDJf+XsibAOAWJ8NGoEyTVvy72nUj3V9+Vzcbz7diMIygQOEZVp2doHsD6wmr1pA
         hqyA==
X-Gm-Message-State: APjAAAVYKwbMR9on7yKdSCI0DGuMhcfM0N7wsjZWqpsdG5gwFjNiSdMx
        NqfrRa8oTg1vnjCCMQ7C8uVQa0wMH2RHAxB9QE7RjcHgvZI=
X-Google-Smtp-Source: APXvYqzyxST3QfOn+yWV2/V9aaKbk7QFjbjDBk7Jxtb6owfp0tIs7k4UziWStbXMfx/5Gl++U8VGXOV8Bws7+69nKrE=
X-Received: by 2002:a92:c00d:: with SMTP id q13mr12838884ild.169.1570142338347;
 Thu, 03 Oct 2019 15:38:58 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 3 Oct 2019 17:38:47 -0500
Message-ID: <CAH2r5msPyXcsC6JkjVCrWXp9bMhHva0-9hWB7qsGmXw2i4SPSA@mail.gmail.com>
Subject: 
To:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        samba <samba@sfconservancy.org>
Content-Type: multipart/mixed; boundary="0000000000005363d005940940fa"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000005363d005940940fa
Content-Type: text/plain; charset="UTF-8"

Haven't heard anything recently on this (although something similar
was apparently discussed last month on various other mailing lists) so
posting Aurelien's patch for external review/comments before deciding
whether to put in cifs's for-next branch.    One question is whether
the check should (only) be done at the higher (VFS) layer, but if ok
to check at (potentially both the layer above, the VFS and ) the
individual fs level, I would prefer to get this patch or something
similar in pretty soon into cifs.ko.  Although cifs.ko is probably
less at risk due to signing and encryption - the idea seems fine to
protect against / in path components.


[PATCH] cifs: do not accept filenames containing dir separators

Check for / in all connection types and additionally check for \ in
non-posix paths connections.

By returning early we do not add this directory entry via dir_emits(),
essentially skipping it.

Since the code relies on ctx->pos being incremented regardless of
errors, we return 0.

This fix addresses CVE-2019-10220.

Link: https://bugzilla.samba.org/show_bug.cgi?id=14072
CC: <stable@vger.kernel.org>
Signed-off-by: Paulo Alcantara (SUSE) <paulo@paulo.ac>
Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/readdir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 3925a7bfc74d..30d69a9d3e94 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -744,6 +744,20 @@ static int cifs_filldir(char *find_entry, struct
file *file,
  name.len = de.namelen;
  }

+ /*
+ * Regardless of connection type, / is always forbidden
+ * IFF we use normal windows paths then \ is forbidden
+ */
+
+ if (strnchr(name.name, name.len, '/')
+     || (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS)
+ && strnchr(name.name, name.len, '\\'))) {
+ cifs_dbg(VFS, "server returned name containing dir separator");
+ /* skip this entry for next readdir() interaction */
+ file_info->srch_inf.entries_in_buffer--;
+ return 0;
+ }
+
  switch (file_info->srch_inf.info_level) {
  case SMB_FIND_FILE_UNIX:
  cifs_unix_basic_to_fattr(&fattr,



-- 
Thanks,

Steve

--0000000000005363d005940940fa
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-do-not-accept-filenames-containing-dir-separato.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-do-not-accept-filenames-containing-dir-separato.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1ba3w4m0>
X-Attachment-Id: f_k1ba3w4m0

RnJvbSA2NmViMzUyYTcwOWFmMTgxMzQ0ODlmMTcyN2MyNDA0ZGQwZTdiMDMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdXJlbGllbiBBcHRlbCA8YWFwdGVsQHN1c2UuY29tPgpEYXRl
OiBUaHUsIDggQXVnIDIwMTkgMTg6NDI6MTcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBjaWZzOiBk
byBub3QgYWNjZXB0IGZpbGVuYW1lcyBjb250YWluaW5nIGRpciBzZXBhcmF0b3JzCgpDaGVjayBm
b3IgLyBpbiBhbGwgY29ubmVjdGlvbiB0eXBlcyBhbmQgYWRkaXRpb25hbGx5IGNoZWNrIGZvciBc
IGluCm5vbi1wb3NpeCBwYXRocyBjb25uZWN0aW9ucy4KCkJ5IHJldHVybmluZyBlYXJseSB3ZSBk
byBub3QgYWRkIHRoaXMgZGlyZWN0b3J5IGVudHJ5IHZpYSBkaXJfZW1pdHMoKSwKZXNzZW50aWFs
bHkgc2tpcHBpbmcgaXQuCgpTaW5jZSB0aGUgY29kZSByZWxpZXMgb24gY3R4LT5wb3MgYmVpbmcg
aW5jcmVtZW50ZWQgcmVnYXJkbGVzcyBvZgplcnJvcnMsIHdlIHJldHVybiAwLgoKVGhpcyBmaXgg
YWRkcmVzc2VzIENWRS0yMDE5LTEwMjIwLgoKTGluazogaHR0cHM6Ly9idWd6aWxsYS5zYW1iYS5v
cmcvc2hvd19idWcuY2dpP2lkPTE0MDcyCkNDOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KU2ln
bmVkLW9mZi1ieTogUGF1bG8gQWxjYW50YXJhIChTVVNFKSA8cGF1bG9AcGF1bG8uYWM+ClNpZ25l
ZC1vZmYtYnk6IEF1cmVsaWVuIEFwdGVsIDxhYXB0ZWxAc3VzZS5jb20+ClNpZ25lZC1vZmYtYnk6
IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL3JlYWRk
aXIuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvcmVhZGRpci5jIGIvZnMvY2lmcy9yZWFkZGlyLmMKaW5k
ZXggMzkyNWE3YmZjNzRkLi4zMGQ2OWE5ZDNlOTQgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvcmVhZGRp
ci5jCisrKyBiL2ZzL2NpZnMvcmVhZGRpci5jCkBAIC03NDQsNiArNzQ0LDIwIEBAIHN0YXRpYyBp
bnQgY2lmc19maWxsZGlyKGNoYXIgKmZpbmRfZW50cnksIHN0cnVjdCBmaWxlICpmaWxlLAogCQlu
YW1lLmxlbiA9IGRlLm5hbWVsZW47CiAJfQogCisJLyoKKwkgKiBSZWdhcmRsZXNzIG9mIGNvbm5l
Y3Rpb24gdHlwZSwgLyBpcyBhbHdheXMgZm9yYmlkZGVuCisJICogSUZGIHdlIHVzZSBub3JtYWwg
d2luZG93cyBwYXRocyB0aGVuIFwgaXMgZm9yYmlkZGVuCisJICovCisKKwlpZiAoc3RybmNocihu
YW1lLm5hbWUsIG5hbWUubGVuLCAnLycpCisJICAgIHx8ICghKGNpZnNfc2ItPm1udF9jaWZzX2Zs
YWdzICYgQ0lGU19NT1VOVF9QT1NJWF9QQVRIUykKKwkJJiYgc3RybmNocihuYW1lLm5hbWUsIG5h
bWUubGVuLCAnXFwnKSkpIHsKKwkJY2lmc19kYmcoVkZTLCAic2VydmVyIHJldHVybmVkIG5hbWUg
Y29udGFpbmluZyBkaXIgc2VwYXJhdG9yIik7CisJCS8qIHNraXAgdGhpcyBlbnRyeSBmb3IgbmV4
dCByZWFkZGlyKCkgaW50ZXJhY3Rpb24gKi8KKwkJZmlsZV9pbmZvLT5zcmNoX2luZi5lbnRyaWVz
X2luX2J1ZmZlci0tOworCQlyZXR1cm4gMDsKKwl9CisKIAlzd2l0Y2ggKGZpbGVfaW5mby0+c3Jj
aF9pbmYuaW5mb19sZXZlbCkgewogCWNhc2UgU01CX0ZJTkRfRklMRV9VTklYOgogCQljaWZzX3Vu
aXhfYmFzaWNfdG9fZmF0dHIoJmZhdHRyLAotLSAKMi4yMC4xCgo=
--0000000000005363d005940940fa--
