Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1054C510
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 03:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfFTBof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 21:44:35 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:34767 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbfFTBof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:44:35 -0400
Received: by mail-pf1-f177.google.com with SMTP id c85so688022pfc.1;
        Wed, 19 Jun 2019 18:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0zOxBKUCYDOIWhRf58Otm+dLo3EckbJIQoYgCqazd24=;
        b=l32nv//PIdQ6sTQprdgpqu/QVROQXBFnnpZqHlApr4HhKUtzqHFfj8qTB5yZuj50eC
         07z9A/7y8sj0jCEX+DPD0UN5mwf4HRV/NCL340qCxnN2AD8bs1pD61DRndPUMRYSSiJq
         fqAz/oNvuLaMqHL+u1DeLKqVl5AQYJL1vYhLvmP1EQhqvg2J8zUPUFYV5g3/IzIxJjHJ
         20/n4YdtrRMMkCSdELpNGWt3CQ6yR7NqRGxAju/9S4dgHzoeGJgBv5ZPmXKdx7KwpEGa
         COyUmiLexj+O2560FEwBc5233BAq3XKRCMLNoF1kDBAzffblX50MC5nSJ1kWOo1lwWqi
         txzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0zOxBKUCYDOIWhRf58Otm+dLo3EckbJIQoYgCqazd24=;
        b=MjoMEk2S/7q0yDJEkRgsdLWbG1LwjFgrBV6+hMtW1G0BQyd7vHXB8ec9D8wZ9XheEo
         IOZzUkjyTEFKcg9rBvrqjLXYdqQXavIyGSsAixJTZtRnFt5HBdMVCiALtMpiAhrpLh0X
         JRz7NeVr2qYDABCDlUQt0F7G38+UNJicJVQARv1g7nhJceFn3e0zXv+DWn7y0p34phd2
         GCiYJbaKnBp/iOg/I477NNfTS4nU9UOD4DLOJpusEG2AgK9nTFwUch6Fy16dmDW5NRyW
         wU86bvUEF0dyhe9dsreIrN8h2g0+gXwXZoKjsftTuFtha9m7rtbma7FDEbMy9f26XIB9
         JMdg==
X-Gm-Message-State: APjAAAUOJdbdFpx3VMVPBY55Thw37g0niBJgVPvaDfl3DTN59htw6CZ4
        fpjXuk4LpL6xgOmd8s0TvXihMFIQfI6RWlzUA9Dh0Q==
X-Google-Smtp-Source: APXvYqweuRogMqI/AyZMce/SUayiDeo6KgbY5HyVeSwFAhYC7CAqdWxtN53Z6M3DE3mV2nMNMQq0/lq0KQU0QUBP6Bw=
X-Received: by 2002:a63:d4c:: with SMTP id 12mr10787654pgn.30.1560995073972;
 Wed, 19 Jun 2019 18:44:33 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 19 Jun 2019 20:44:22 -0500
Message-ID: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
Subject: [SMB3][PATCH] fix copy_file_range when copying beyond end of source file
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000e1ad76058bb77c0c"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000e1ad76058bb77c0c
Content-Type: text/plain; charset="UTF-8"

Patch attached fixes the case where copy_file_range over an SMB3 mount
tries to go beyond the end of file of the source file.  This fixes
xfstests generic/430 and generic/431

Amir's patches had added a similar change in the VFS layer, but
presumably harmless to have the check in cifs.ko as well to ensure
that we don't try to copy beyond end of the source file (otherwise
SMB3 servers will return an error on copychunk rather than doing the
partial copy (up to end of the source file) that copy_file_range
expects).



-- 
Thanks,

Steve

--000000000000e1ad76058bb77c0c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-SMB3-fix-copy-file-range-when-beyond-size-of-source-.patch"
Content-Disposition: attachment; 
	filename="0001-SMB3-fix-copy-file-range-when-beyond-size-of-source-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jx402gjq0>
X-Attachment-Id: f_jx402gjq0

RnJvbSBhM2Q5MDMzZGY3YmI1MjA2MDkzZjAwZWIwMzcyNDIzMzZmZjdjY2ZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFdlZCwgMTkgSnVuIDIwMTkgMTU6MTA6MTIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBb
U01CM10gZml4IGNvcHkgZmlsZSByYW5nZSB3aGVuIGJleW9uZCBzaXplIG9mIHNvdXJjZSBmaWxl
CgpXaGVuIHJlcXVlc3RpbmcgYSBjb3B5IHdoaWNoIHdvdWxkIGdvIGJleW9uZCB0aGUgZW5kIG9m
IHRoZQpzb3VyY2UgZmlsZSwgb25seSBjb3B5IHRvIHRoZSBlbmQgb2YgdGhlIHNvdXJjZSBmaWxl
IGluc3RlYWQKb2YgcmV0dXJuaW5nIGFuIGVycm9yLiAgRml4ZXMgeGZzdGVzdHMgZ2VuZXJpYy80
MzAgYW5kCmdlbmVyaWMvNDMxCgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNo
QG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9zbWIyb3BzLmMgfCA5ICsrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMm9w
cy5jIGIvZnMvY2lmcy9zbWIyb3BzLmMKaW5kZXggMzc2NTc3Y2M0MTU5Li4xY2RiZWVjNTY0NTMg
MTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMm9wcy5jCisrKyBiL2ZzL2NpZnMvc21iMm9wcy5jCkBA
IC0xNTIyLDYgKzE1MjIsNyBAQCBzbWIyX2NvcHljaHVua19yYW5nZShjb25zdCB1bnNpZ25lZCBp
bnQgeGlkLAogCWludCBjaHVua3NfY29waWVkID0gMDsKIAlib29sIGNodW5rX3NpemVzX3VwZGF0
ZWQgPSBmYWxzZTsKIAlzc2l6ZV90IGJ5dGVzX3dyaXR0ZW4sIHRvdGFsX2J5dGVzX3dyaXR0ZW4g
PSAwOworCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKHNyY2ZpbGUtPmRlbnRyeSk7CiAK
IAlwY2NodW5rID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGNvcHljaHVua19pb2N0bCksIEdGUF9L
RVJORUwpOwogCkBAIC0xNTQ2LDYgKzE1NDcsMTQgQEAgc21iMl9jb3B5Y2h1bmtfcmFuZ2UoY29u
c3QgdW5zaWduZWQgaW50IHhpZCwKIAl0Y29uID0gdGxpbmtfdGNvbih0cmd0ZmlsZS0+dGxpbmsp
OwogCiAJd2hpbGUgKGxlbiA+IDApIHsKKwkJaWYgKHNyY19vZmYgPj0gaW5vZGUtPmlfc2l6ZSkg
eworCQkJY2lmc19kYmcoRllJLCAibm90aGluZyB0byBkbyBvbiBjb3B5Y2h1bmtcbiIpOworCQkJ
Z290byBjY2h1bmtfb3V0OyAvKiBub3RoaW5nIHRvIGRvICovCisJCX0gZWxzZSBpZiAoc3JjX29m
ZiArIGxlbiA+IGlub2RlLT5pX3NpemUpIHsKKwkJCS8qIGNvbnNpZGVyIGFkZGluZyBjaGVjayB0
byBzZWUgaWYgc3JjIG9wbG9ja2VkICovCisJCQlsZW4gPSBpbm9kZS0+aV9zaXplIC0gc3JjX29m
ZjsKKwkJCWNpZnNfZGJnKEZZSSwgImFkanVzdCBjb3B5Y2h1bmsgbGVuICVsbGQgbGVzc1xuIiwg
bGVuKTsKKwkJfQogCQlwY2NodW5rLT5Tb3VyY2VPZmZzZXQgPSBjcHVfdG9fbGU2NChzcmNfb2Zm
KTsKIAkJcGNjaHVuay0+VGFyZ2V0T2Zmc2V0ID0gY3B1X3RvX2xlNjQoZGVzdF9vZmYpOwogCQlw
Y2NodW5rLT5MZW5ndGggPQotLSAKMi4yMC4xCgo=
--000000000000e1ad76058bb77c0c--
