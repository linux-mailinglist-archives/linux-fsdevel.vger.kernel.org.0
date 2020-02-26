Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4716F807
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 07:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBZGgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 01:36:04 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:36777 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBZGgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:36:04 -0500
Received: by mail-io1-f46.google.com with SMTP id d15so2144878iog.3;
        Tue, 25 Feb 2020 22:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eFo/amBiw4ra9qJF2sHSoCjzhIEMIa3Edz34Kt0xAwI=;
        b=dhEjyFqSp7aLk7RcKJXSEmWOU7r54o17dGXzyFHN8nQmy7U4LSAteSM9R6BMen+myC
         p0g18JZldQiTYVqNeQV6YphadUZyuQtae0ieyNcTIBsEbYis1+gJUWsbpDQEvqw5jOSq
         NcUO1qT4ZKkREme2LLJgVvHwZCK3a4TR1vnjfq8DnX8Ll4z5eO5MCtHbuzrVaIaD1KZp
         zViAo1aP4ibxvCnHKkBje0CNaPZN2DU9ltuFEm/0hLPcY2ScTs3C2QQxNC0o6hqVW8WW
         /Tb3PZgcXpcSaxOmud+91auzF6stQDtvMGZNIa6lesmFshl+iER96CluI/z0IY5yZucy
         BrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eFo/amBiw4ra9qJF2sHSoCjzhIEMIa3Edz34Kt0xAwI=;
        b=ugLBAhl+LFYom2qAB4LCfV09snSYzXD20iL6IT/UooELQO5kPBlYoSh1M4nWVpMIdf
         IS//xgsRJEBy1oo8A23hwPK60KZTJM2SiaGDi8+NJO90CqYsRfUFM68I4c4j6R5NakVA
         9dgzOaxtNZ91TzO2r5PGE1uT+UrUBBIJ8je5jm7KjmtE/LWHh0bpG+rJDt+UwU8ql2TQ
         i6tX99DJ36KOMW0djO/uSgGhjPHPr2JLWrg2zzZwaq+hKRoWTeFP7ceefHFnaLrnFuNk
         l2FLMQYbJDGkiDNKuGtH+GtZfcbmvt4PsoWu7Vm74JRkC7yQV8KZ677R6Bwg5vOZnHfB
         94RQ==
X-Gm-Message-State: APjAAAWuIiLGPG/q1xNj5mO+L5WNw5sQIMJ5WEsSKChcheM6dpTn8beZ
        q0g57SogR3uAs5Jbt25wN3YK2MuY2Osh7d9GtoUX1g==
X-Google-Smtp-Source: APXvYqwX8A3Hd2lbBCep5kIfXNaBAi1xmcK8jdjkUNhedPox5PQphF/+56QeowLlHLT0ZLEsa7wPK8bYwAPdQPAXIbA=
X-Received: by 2002:a05:6638:149:: with SMTP id y9mr2359365jao.132.1582698963130;
 Tue, 25 Feb 2020 22:36:03 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 26 Feb 2020 00:35:51 -0600
Message-ID: <CAH2r5mt0=WRC2SgG6UZmZ32PbjZrcK4N_sZ9=WcSEar1utTmCw@mail.gmail.com>
Subject: [PATCH][CIFS] Use FS_RENAME_DOES_D_MOVE to minimize races in rename
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007c35c8059f74d1c0"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000007c35c8059f74d1c0
Content-Type: text/plain; charset="UTF-8"

Should be safer to do the dentry move immediately after the rename
rather than later.





-- 
Thanks,

Steve

--0000000000007c35c8059f74d1c0
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-cifs-do-d_move-in-rename.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-do-d_move-in-rename.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k72y39610>
X-Attachment-Id: f_k72y39610

RnJvbSBjMWJjNzUxNzg3ODA2NjU3MTZhZDE0YjhjNDBhOGQ4ZTU4ZDBmM2UzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMjUgRmViIDIwMjAgMTg6MDg6NTQgLTA2MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBkbyBkX21vdmUgaW4gcmVuYW1lCgpJdCBpcyBzYWZlciB0byBkbyB0aGUgZF9tb3ZlIGNs
b3NlciB0byB0aGUgcmVuYW1lIHRvCmF2b2lkIHJhY2VzLgoKU2lnbmVkLW9mZi1ieTogU3RldmUg
RnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc2ZzLmMgfCA0
ICsrLS0KIGZzL2NpZnMvaW5vZGUuYyAgfCAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNmcy5jIGIv
ZnMvY2lmcy9jaWZzZnMuYwppbmRleCBmYTc3ZmU1MjU4YjAuLjk0ZTNlZDQ4NTBiNSAxMDA2NDQK
LS0tIGEvZnMvY2lmcy9jaWZzZnMuYworKysgYi9mcy9jaWZzL2NpZnNmcy5jCkBAIC0xMDE4LDcg
KzEwMTgsNyBAQCBzdHJ1Y3QgZmlsZV9zeXN0ZW1fdHlwZSBjaWZzX2ZzX3R5cGUgPSB7CiAJLm5h
bWUgPSAiY2lmcyIsCiAJLm1vdW50ID0gY2lmc19kb19tb3VudCwKIAkua2lsbF9zYiA9IGNpZnNf
a2lsbF9zYiwKLQkvKiAgLmZzX2ZsYWdzICovCisJLmZzX2ZsYWdzID0gRlNfUkVOQU1FX0RPRVNf
RF9NT1ZFLAogfTsKIE1PRFVMRV9BTElBU19GUygiY2lmcyIpOwogCkBAIC0xMDI3LDcgKzEwMjcs
NyBAQCBzdGF0aWMgc3RydWN0IGZpbGVfc3lzdGVtX3R5cGUgc21iM19mc190eXBlID0gewogCS5u
YW1lID0gInNtYjMiLAogCS5tb3VudCA9IHNtYjNfZG9fbW91bnQsCiAJLmtpbGxfc2IgPSBjaWZz
X2tpbGxfc2IsCi0JLyogIC5mc19mbGFncyAqLworCS5mc19mbGFncyA9IEZTX1JFTkFNRV9ET0VT
X0RfTU9WRSwKIH07CiBNT0RVTEVfQUxJQVNfRlMoInNtYjMiKTsKIE1PRFVMRV9BTElBUygic21i
MyIpOwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9pbm9kZS5jIGIvZnMvY2lmcy9pbm9kZS5jCmluZGV4
IDY1NDM0NjU1OTVmNi4uN2JiN2ZmMTEwZGM2IDEwMDY0NAotLS0gYS9mcy9jaWZzL2lub2RlLmMK
KysrIGIvZnMvY2lmcy9pbm9kZS5jCkBAIC0xODM1LDYgKzE4MzUsOCBAQCBjaWZzX2RvX3JlbmFt
ZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgZGVudHJ5ICpmcm9tX2RlbnRyeSwKIAkJ
Q0lGU1NNQkNsb3NlKHhpZCwgdGNvbiwgZmlkLm5ldGZpZCk7CiAJfQogZG9fcmVuYW1lX2V4aXQ6
CisJaWYgKHJjID09IDApCisJCWRfbW92ZShmcm9tX2RlbnRyeSwgdG9fZGVudHJ5KTsKIAljaWZz
X3B1dF90bGluayh0bGluayk7CiAJcmV0dXJuIHJjOwogfQotLSAKMi4yMC4xCgo=
--0000000000007c35c8059f74d1c0--
