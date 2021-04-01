Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE6351FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 21:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhDATXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhDATXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:23:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E55C08E750;
        Thu,  1 Apr 2021 11:30:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m12so4215801lfq.10;
        Thu, 01 Apr 2021 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=40avOPfC1Fu2kiJ4DKn5f2Yq5VnQaYcTK2JOpGiRFtI=;
        b=CxJI/5fa6dOmTAGwQhm2K+hBDvY3NnHTHr65MjMPquJLssl0Uw/BqrsxMUVWrj3rmw
         zBtd9hzk+MQy1i286P2RUycp7wrHxjerTbBB/SVO9FGukZHUNUGxwpOmALWgSapTT4DP
         eMHVuXgm9+TLRE0jMS1hu+GxiQwMZBiIlpUg2eoDFflTP9Eul2DZt9iRcF748O2yRmkQ
         PFZ4iK6SmZre7ucUsSap5ZvMWoqwRX0HwRVh0+3B3ARsOdPgJaQLr46jfPJWYzfHtODp
         u6Ke8/9TizWScvYnWTUsH9ciIQNISpMZY4SyvOZ9dwof+ILehsnpf8R+LGsnomapqMr5
         49zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=40avOPfC1Fu2kiJ4DKn5f2Yq5VnQaYcTK2JOpGiRFtI=;
        b=HrM3c3Is/9YMQFrVQa3KCjtpnWpI0FAhEAJyGFYBvVI5vcSmx/fX7bGzWDbvHZv5Ls
         qeII2qgyKTqD/E7hY69f6Y71xDW5tMtNsu1TWitphVNrix3CgLF2SVDqXZtdBMTA6WnE
         V2ZsEE8rgYFTsmJ7RguaiGzCf2Xyp7AGZBSoMFt2iygC0nNgpCQDmCHXREOiTPRBqmy2
         cxyt8EIIJD+MsqDA2rATJTNEDd5W04fMcv5OoXgey0Z8Y7N/8dBDIde6g4kUrlo+qJpQ
         jwmX/3xbaMY9nLJKHwQiBIqxwTOYs/L4ZwohBkmjLd/lECVCyN0tySe+ITlnT3btvju/
         HKaQ==
X-Gm-Message-State: AOAM531+PYYacxNMQGHVpElW7U7lTIue7h2CouMgE2uLT7JzyBfRl0mh
        uMDo+vHLLtp82NYsG/D6gpszu+Nl6ddE2Sy15qb2vMigb7ZZDg==
X-Google-Smtp-Source: ABdhPJwiPjSm+JOHwZBBmbAemlk6I7J45C87EFMTPGzCqw3S2jslS3d23j4ZeFqYGiJaC4Pao8Bifj5DBOPCoVLZemY=
X-Received: by 2002:ac2:5f07:: with SMTP id 7mr6394916lfq.313.1617301839771;
 Thu, 01 Apr 2021 11:30:39 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 1 Apr 2021 13:30:28 -0500
Message-ID: <CAH2r5mvhUQEqXQmrz5KKbTCFaeS5ejZBGysaeQVC_ESSc-snuw@mail.gmail.com>
Subject: [PATCH][CIFS] Insert and Collapse range
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a7920905beed6dba"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a7920905beed6dba
Content-Type: text/plain; charset="UTF-8"

Updated version of Ronnie's patch for FALLOC_FL_INSERT_RANGE and
FALLOC_FL_COLLAPSE_RANGE attached (cleaned up the two redundant length
checks noticed out by Aurelien, and fixed the endian check warnings
pointed out by sparse).

They fix at least six xfstests (but still more xfstests to work
through that seem to have other new feature dependencies beyond
fcollapse)

# ./check -cifs generic/072 generic/145 generic/147 generic/153
generic/351 generic/458
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 smfrench-Virtual-Machine
5.12.0-051200rc4-generic #202103212230 SMP Sun Mar 21 22:33:27 UTC
2021

generic/072 7s ...  6s
generic/145 0s ...  1s
generic/147 1s ...  0s
generic/153 0s ...  1s
generic/351 5s ...  3s
generic/458 1s ...  1s
Ran: generic/072 generic/145 generic/147 generic/153 generic/351 generic/458
Passed all 6 tests
-- 
Thanks,

Steve

--000000000000a7920905beed6dba
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-add-support-for-FALLOC_FL_COLLAPSE_RANGE.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-add-support-for-FALLOC_FL_COLLAPSE_RANGE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kmz7a68x0>
X-Attachment-Id: f_kmz7a68x0

RnJvbSA2NDA4NjIyODQ4MGY4ZDNiYTgwZWI5MzBiNDBmNTAxYWZiYjFlODNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb25uaWUgU2FobGJlcmcgPGxzYWhsYmVyQHJlZGhhdC5jb20+
CkRhdGU6IFNhdCwgMjcgTWFyIDIwMjEgMDU6NTI6MjkgKzEwMDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gY2lmczogYWRkIHN1cHBvcnQgZm9yIEZBTExPQ19GTF9DT0xMQVBTRV9SQU5HRQoKRW11bGF0
ZWQgZm9yIFNNQjMgYW5kIGxhdGVyIHZpYSBzZXJ2ZXIgc2lkZSBjb3B5CmFuZCBzZXRzaXplLiBF
dmVudHVhbGx5IHRoaXMgY291bGQgYmUgY29tcG91bmRlZC4KClJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRh
bi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KU2lnbmVkLW9mZi1ieTogUm9ubmllIFNhaGxiZXJnIDxs
c2FobGJlckByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNo
QG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9zbWIyb3BzLmMgfCAzNSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJvcHMuYyBiL2ZzL2NpZnMvc21iMm9wcy5jCmluZGV4
IGY3MDMyMDRmYjE4NS4uYzZhNDljMzFkYzBlIDEwMDY0NAotLS0gYS9mcy9jaWZzL3NtYjJvcHMu
YworKysgYi9mcy9jaWZzL3NtYjJvcHMuYwpAQCAtMzY1Miw2ICszNjUyLDM5IEBAIHN0YXRpYyBs
b25nIHNtYjNfc2ltcGxlX2ZhbGxvYyhzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGNpZnNfdGNv
biAqdGNvbiwKIAlyZXR1cm4gcmM7CiB9CiAKK3N0YXRpYyBsb25nIHNtYjNfY29sbGFwc2VfcmFu
Z2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCisJCQkgICAgbG9m
Zl90IG9mZiwgbG9mZl90IGxlbikKK3sKKwlpbnQgcmM7CisJdW5zaWduZWQgaW50IHhpZDsKKwlz
dHJ1Y3QgY2lmc0ZpbGVJbmZvICpjZmlsZSA9IGZpbGUtPnByaXZhdGVfZGF0YTsKKwlfX2xlNjQg
ZW9mOworCisJeGlkID0gZ2V0X3hpZCgpOworCisJaWYgKG9mZiA+PSBpX3NpemVfcmVhZChmaWxl
LT5mX2lub2RlKSB8fAorCSAgICBvZmYgKyBsZW4gPj0gaV9zaXplX3JlYWQoZmlsZS0+Zl9pbm9k
ZSkpIHsKKwkJcmMgPSAtRUlOVkFMOworCQlnb3RvIG91dDsKKwl9CisKKwlyYyA9IHNtYjJfY29w
eWNodW5rX3JhbmdlKHhpZCwgY2ZpbGUsIGNmaWxlLCBvZmYgKyBsZW4sCisJCQkJICBpX3NpemVf
cmVhZChmaWxlLT5mX2lub2RlKSAtIG9mZiAtIGxlbiwgb2ZmKTsKKwlpZiAocmMgPCAwKQorCQln
b3RvIG91dDsKKworCWVvZiA9IGNwdV90b19sZTY0KGlfc2l6ZV9yZWFkKGZpbGUtPmZfaW5vZGUp
IC0gbGVuKTsKKwlyYyA9IFNNQjJfc2V0X2VvZih4aWQsIHRjb24sIGNmaWxlLT5maWQucGVyc2lz
dGVudF9maWQsCisJCQkgIGNmaWxlLT5maWQudm9sYXRpbGVfZmlkLCBjZmlsZS0+cGlkLCAmZW9m
KTsKKwlpZiAocmMgPCAwKQorCQlnb3RvIG91dDsKKworCXJjID0gMDsKKyBvdXQ6CisJZnJlZV94
aWQoeGlkKTsKKwlyZXR1cm4gcmM7Cit9CisKIHN0YXRpYyBsb2ZmX3Qgc21iM19sbHNlZWsoc3Ry
dWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sIGxvZmZfdCBvZmZzZXQsIGlu
dCB3aGVuY2UpCiB7CiAJc3RydWN0IGNpZnNGaWxlSW5mbyAqd3JjZmlsZSwgKmNmaWxlID0gZmls
ZS0+cHJpdmF0ZV9kYXRhOwpAQCAtMzgyMyw2ICszODU2LDggQEAgc3RhdGljIGxvbmcgc21iM19m
YWxsb2NhdGUoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sIGludCBt
b2RlLAogCQlyZXR1cm4gc21iM196ZXJvX3JhbmdlKGZpbGUsIHRjb24sIG9mZiwgbGVuLCBmYWxz
ZSk7CiAJfSBlbHNlIGlmIChtb2RlID09IEZBTExPQ19GTF9LRUVQX1NJWkUpCiAJCXJldHVybiBz
bWIzX3NpbXBsZV9mYWxsb2MoZmlsZSwgdGNvbiwgb2ZmLCBsZW4sIHRydWUpOworCWVsc2UgaWYg
KG1vZGUgPT0gRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFKQorCQlyZXR1cm4gc21iM19jb2xsYXBz
ZV9yYW5nZShmaWxlLCB0Y29uLCBvZmYsIGxlbik7CiAJZWxzZSBpZiAobW9kZSA9PSAwKQogCQly
ZXR1cm4gc21iM19zaW1wbGVfZmFsbG9jKGZpbGUsIHRjb24sIG9mZiwgbGVuLCBmYWxzZSk7CiAK
LS0gCjIuMjcuMAoK
--000000000000a7920905beed6dba
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-cifs-add-FALLOC_FL_INSERT_RANGE-support.patch"
Content-Disposition: attachment; 
	filename="0002-cifs-add-FALLOC_FL_INSERT_RANGE-support.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kmz7a69n1>
X-Attachment-Id: f_kmz7a69n1

RnJvbSBlM2NkZDFjOTQzZTY1YzM5MWFmMzZmNTczNTk5YjY5ZGRlODBmY2IwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb25uaWUgU2FobGJlcmcgPGxzYWhsYmVyQHJlZGhhdC5jb20+
CkRhdGU6IFNhdCwgMjcgTWFyIDIwMjEgMDY6MzE6MzAgKzEwMDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gY2lmczogYWRkIEZBTExPQ19GTF9JTlNFUlRfUkFOR0Ugc3VwcG9ydAoKRW11bGF0ZWQgdmlh
IHNlcnZlciBzaWRlIGNvcHkgYW5kIHNldHNpemUgZm9yClNNQjMgYW5kIGxhdGVyLiBJbiB0aGUg
ZnV0dXJlIHdlIGNvdWxkIGNvbXBvdW5kCnRoaXMgKGFuZC9vciBvcHRpb25hbGx5IHVzZSBEVVBM
SUNBVEVfRVhURU5UUwppZiBzdXBwb3J0ZWQgYnkgdGhlIHNlcnZlcikuCgpTaWduZWQtb2ZmLWJ5
OiBSb25uaWUgU2FobGJlcmcgPGxzYWhsYmVyQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0
ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL3NtYjJvcHMu
YyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWIyb3BzLmMg
Yi9mcy9jaWZzL3NtYjJvcHMuYwppbmRleCBjNmE0OWMzMWRjMGUuLjQ4MzdhYzliNDgzNyAxMDA2
NDQKLS0tIGEvZnMvY2lmcy9zbWIyb3BzLmMKKysrIGIvZnMvY2lmcy9zbWIyb3BzLmMKQEAgLTM2
ODUsNiArMzY4NSw0NCBAQCBzdGF0aWMgbG9uZyBzbWIzX2NvbGxhcHNlX3JhbmdlKHN0cnVjdCBm
aWxlICpmaWxlLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCXJldHVybiByYzsKIH0KIAorc3Rh
dGljIGxvbmcgc21iM19pbnNlcnRfcmFuZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBjaWZz
X3Rjb24gKnRjb24sCisJCQkgICAgICBsb2ZmX3Qgb2ZmLCBsb2ZmX3QgbGVuKQoreworCWludCBy
YzsKKwl1bnNpZ25lZCBpbnQgeGlkOworCXN0cnVjdCBjaWZzRmlsZUluZm8gKmNmaWxlID0gZmls
ZS0+cHJpdmF0ZV9kYXRhOworCV9fbGU2NCBlb2Y7CisJX191NjQgIGNvdW50OworCisJeGlkID0g
Z2V0X3hpZCgpOworCisJaWYgKG9mZiA+PSBpX3NpemVfcmVhZChmaWxlLT5mX2lub2RlKSkgewor
CQlyYyA9IC1FSU5WQUw7CisJCWdvdG8gb3V0OworCX0KKworCWNvdW50ID0gaV9zaXplX3JlYWQo
ZmlsZS0+Zl9pbm9kZSkgLSBvZmY7CisJZW9mID0gY3B1X3RvX2xlNjQoaV9zaXplX3JlYWQoZmls
ZS0+Zl9pbm9kZSkgKyBsZW4pOworCisJcmMgPSBTTUIyX3NldF9lb2YoeGlkLCB0Y29uLCBjZmls
ZS0+ZmlkLnBlcnNpc3RlbnRfZmlkLAorCQkJICBjZmlsZS0+ZmlkLnZvbGF0aWxlX2ZpZCwgY2Zp
bGUtPnBpZCwgJmVvZik7CisJaWYgKHJjIDwgMCkKKwkJZ290byBvdXQ7CisKKwlyYyA9IHNtYjJf
Y29weWNodW5rX3JhbmdlKHhpZCwgY2ZpbGUsIGNmaWxlLCBvZmYsIGNvdW50LCBvZmYgKyBsZW4p
OworCWlmIChyYyA8IDApCisJCWdvdG8gb3V0OworCisJcmMgPSBzbWIzX3plcm9fcmFuZ2UoZmls
ZSwgdGNvbiwgb2ZmLCBsZW4sIDEpOworCWlmIChyYyA8IDApCisJCWdvdG8gb3V0OworCisJcmMg
PSAwOworIG91dDoKKwlmcmVlX3hpZCh4aWQpOworCXJldHVybiByYzsKK30KKwogc3RhdGljIGxv
ZmZfdCBzbWIzX2xsc2VlayhzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGNpZnNfdGNvbiAqdGNv
biwgbG9mZl90IG9mZnNldCwgaW50IHdoZW5jZSkKIHsKIAlzdHJ1Y3QgY2lmc0ZpbGVJbmZvICp3
cmNmaWxlLCAqY2ZpbGUgPSBmaWxlLT5wcml2YXRlX2RhdGE7CkBAIC0zODU4LDYgKzM4OTYsOCBA
QCBzdGF0aWMgbG9uZyBzbWIzX2ZhbGxvY2F0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGNp
ZnNfdGNvbiAqdGNvbiwgaW50IG1vZGUsCiAJCXJldHVybiBzbWIzX3NpbXBsZV9mYWxsb2MoZmls
ZSwgdGNvbiwgb2ZmLCBsZW4sIHRydWUpOwogCWVsc2UgaWYgKG1vZGUgPT0gRkFMTE9DX0ZMX0NP
TExBUFNFX1JBTkdFKQogCQlyZXR1cm4gc21iM19jb2xsYXBzZV9yYW5nZShmaWxlLCB0Y29uLCBv
ZmYsIGxlbik7CisJZWxzZSBpZiAobW9kZSA9PSBGQUxMT0NfRkxfSU5TRVJUX1JBTkdFKQorCQly
ZXR1cm4gc21iM19pbnNlcnRfcmFuZ2UoZmlsZSwgdGNvbiwgb2ZmLCBsZW4pOwogCWVsc2UgaWYg
KG1vZGUgPT0gMCkKIAkJcmV0dXJuIHNtYjNfc2ltcGxlX2ZhbGxvYyhmaWxlLCB0Y29uLCBvZmYs
IGxlbiwgZmFsc2UpOwogCi0tIAoyLjI3LjAKCg==
--000000000000a7920905beed6dba--
