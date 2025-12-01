Return-Path: <linux-fsdevel+bounces-70309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83885C96590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 10:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E672634042D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767FA2F999A;
	Mon,  1 Dec 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGJU2EoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE81C5D72
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580654; cv=none; b=Ws9dGx4AZ/4wCrtvlE18qLYpClMCvIJAwJjXXfJNZm1AUrc3FyxDcnFRXURq5XLrdy7Ul6nKXmOwO3d1BtIBNCryBD4ORHVl7+U+Phcxv7xKsqnSqNgV1pW+pz9XIURsSlIo3Q+ZDpySsg3RS29U7ByyOGFnH3B152qdjFu00FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580654; c=relaxed/simple;
	bh=5IqWj9YtYS6jlDk2hqQJPeA4kSfoPwW+m9Dg1/N0voc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dAekndkYiaqil+vCywcPi+9PgfDybF7hS52+KyBi+byQnIdcL/WqrLoxpMY8Nh9ii5igpkf3bv4WYVtc3tdrU71A0R8OMIBQffnnjKAJOkyDq4zsQJMkX6ia1wCG9ksnuORcDTa4rkGfHlor8zDwf5aWgFo6AU5NhR5mYxsgYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGJU2EoF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2aa1ae006so522308385a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764580652; x=1765185452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7eXqPr+gfFKGtC2pWpqEXhq+YzmjGk6aiGUEIEIYBMw=;
        b=iGJU2EoFTjHkdaarwph7o7COM9ATsJD1vaNa54TCJ47DS3Z9aI80XxmD8VpdSOmWW7
         v5ABbMyUiJYgrAabpa7/CiC2LVPyrRRPreSPB+EHBzDjA6+oVFmbXr9mla7SWjNaEr3I
         iPi4j7s5Ywk1DMRQz9vKKSTAXtRpuEDQKKN+Yvuo7NBYQXHnYaF/xba+0jWxCrLvhCFo
         7dBeLHzmv22MQOdf4zmUqUVJQ3eKtjm6ZQr0uUXM9TxBBGs3NriEiOGEEJ1xy9hPfVOu
         /qpD9gvLnlwB3SKdswH5JUrUF7yr4TUBtcGLhx+A10sdBvUn4x2N6/hVxqb4wAH+wJJ8
         V5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764580652; x=1765185452;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eXqPr+gfFKGtC2pWpqEXhq+YzmjGk6aiGUEIEIYBMw=;
        b=p1FdoMsHKTTwdcFKWs7gk0UHdyipRVnLgpoufK500Pt89E/oAL2MgSA8GzIRgkhk3U
         Fq7YD6SrVY4SZoqEhEfkCwHYi1QLtu1AnJYaMrKWEmoUVNf1BDD99AOpgplJdWVO5bqj
         rlz/ixCnp7PwZ0JYroVvJocr7G3DFjzSPj9RLb7dBNHM7kIsBMG15/kqAmG6Uf7nk4E+
         S94nofp2tUlw3BBc16wVOpm+UnJiHhAaw+hcJ6ueU8WoVpH3J9JeVt/IPxh4FeFbgts0
         gXw8SJKPsJWjxNUwiuWz1nRYM+aq7ToK3M+cdfI/m2dbKJsCWYRy5qz5IWcLt7g1aCu7
         7njQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2IYBqgoAbvRA6ggughr8Z4oWS8pYKOweNQio/9rdYvOJIwnBiWAkvI3wDD+khnDxGde659wak+dYg3rBd@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+T8tUrJUPtR56k3cuCQwIb1NmcEX0brFxFqOijzd2ncSxkwb
	jirOKiWD/W4VsyXn44Kcd0lRkgVcRUcdZi/fmybj3wTrrboGE4U95G9e3SXCBaQlA9xMnils1xB
	55mNcCVKCCWRlrjwdEzgKwfRaSsYF/h0=
X-Gm-Gg: ASbGnctaGECtgPpmqB6e3rCoyO46wYvre0QnzWgEh8gD5EMr3kS5k8Ph1IW0+Y04vEO
	8utcDOKDMZ8zcsNMK788NTBsHvAPrlJUf67ilsfFMBSC4orfhlTdQ230gvbAaLTmBxzehMkirnk
	i1dqDh61QhAXQDasKHZlGoeVH/FgMJSmIwy7bzUrSIySGDIB+NXDjuFb1t9AHBCr0ijBnEpHzkq
	VJtWjf9fvJ2Z+ve9c3YFRF9UuGd1gx4uXwnuqFq73gnVGTMjWr5tyrmGgVdNF9utIp3Tm/vn71f
	y1dj5TlN
X-Google-Smtp-Source: AGHT+IHQRqJ1XTju5N0oj+IK1SZfYy4sjvyZ10lufIZ/1UFfLFvavHFA462OEgAMm4K13UXn6WCZ19+Jp/3Nl3xq4hI=
X-Received: by 2002:a05:620a:4687:b0:8a3:87ef:9245 with SMTP id
 af79cd13be357-8b33d4c71damr5084452885a.85.1764580652139; Mon, 01 Dec 2025
 01:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yao xiao <xiangyaof4free@gmail.com>
Date: Mon, 1 Dec 2025 17:17:20 +0800
X-Gm-Features: AWmQ_blDBYGbzf0XU5S93uV2a6bMmmKE8qZMjNoGyXS8deKYtj0PO8rs4ql7lhM
Message-ID: <CACpam_ZrXZwb-=EKc8HTyH7VPSWhuWBUgO0n6_z3H6wv8k6r3w@mail.gmail.com>
Subject: [PATCH v2] f2fs: add overflow/underflow checks to update_sit_entry
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f317660644e07243"

--000000000000f317660644e07243
Content-Type: text/plain; charset="UTF-8"

From: Yao Xiao <xiangyaof4free@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: add overflow/underflow checks to update_sit_entry

The update_sit_entry() function performs an arithmetic operation between
se->valid_blocks (a 10-bit unsigned bitfield) and a signed integer 'del'.
Under C integer promotion rules, the signed integer is converted to unsigned
before the addition, which can lead to wraparound behavior:

  - If 'del' is negative and large, it becomes a large unsigned integer,
    resulting in an unintended huge positive addition.
  - If 'del' is positive and large, the result can exceed the bitfield's
    maximum representable range.

To avoid undefined behavior caused by performing the arithmetic first and
validating the result afterwards, this patch adds explicit overflow/underflow
checks before computing the new value. This ensures the operation is safe
and prevents inconsistent SIT metadata updates.

This change follows the defensive overflow check style used in previous
f2fs fixes addressing similar boundary issues.

Signed-off-by: Yao Xiao <xiangyaof4free@gmail.com>
---
 fs/f2fs/segment.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..05ab34600e32 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2569,13 +2569,33 @@ static void update_sit_entry(struct
f2fs_sb_info *sbi, block_t blkaddr, int del)
  struct seg_entry *se;
  unsigned int segno, offset;
  long int new_vblocks;
+ unsigned int max_valid;

  segno = GET_SEGNO(sbi, blkaddr);
  if (segno == NULL_SEGNO)
  return;

  se = get_seg_entry(sbi, segno);
- new_vblocks = se->valid_blocks + del;
+ max_valid = f2fs_usable_blks_in_seg(sbi, segno);
+
+ /* Prevent overflow/underflow before performing arithmetic. */
+ if (del > 0) {
+ if ((unsigned int)del > max_valid ||
+    se->valid_blocks > max_valid - (unsigned int)del) {
+ f2fs_bug_on(sbi, 1);
+ return;
+ }
+ } else if (del < 0) {
+ if (se->valid_blocks < (unsigned int)(-del)) {
+ f2fs_bug_on(sbi, 1);
+ return;
+ }
+ }
+
+ new_vblocks = (long int)se->valid_blocks + del;
  offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);

  f2fs_bug_on(sbi, (new_vblocks < 0 ||
-- 
2.34.1

--000000000000f317660644e07243
Content-Type: application/octet-stream; 
	name="f2fs-fix-update_sit_entry-overflow-checks.patch"
Content-Disposition: attachment; 
	filename="f2fs-fix-update_sit_entry-overflow-checks.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mimxdl8e0>
X-Attachment-Id: f_mimxdl8e0

RnJvbSA0YWNiMTBjNzUxN2IwYTJiZDlmZDZmMWFiMzMzN2NmYzFiOTBmOTliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogWWFvIFhpYW8gPHhpYW5neWFvZjRmcmVlQGdtYWlsLmNvbT4N
CkRhdGU6IFdlZCwgNCBEZWMgMjAyNCAxMjowMDowMCArMDgwMA0KU3ViamVjdDogW1BBVENIIHYy
XSBmMmZzOiBhZGQgb3ZlcmZsb3cvdW5kZXJmbG93IGNoZWNrcyB0byB1cGRhdGVfc2l0X2VudHJ5
DQoNClNpZ25lZC1vZmYtYnk6IFlhbyBYaWFvIDx4aWFuZ3lhb2Y0ZnJlZUBnbWFpbC5jb20+DQot
LS0NCiBmcy9mMmZzL3NlZ21lbnQuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2ZzL2YyZnMvc2VnbWVudC5jIGIvZnMvZjJmcy9zZWdtZW50LmMNCmluZGV4IGI0
NWVhY2U4NzlkNy4uMDVhYjM0NjAwZTMyIDEwMDY0NA0KLS0tIGEvZnMvZjJmcy9zZWdtZW50LmMN
CisrKyBiL2ZzL2YyZnMvc2VnbWVudC5jDQpAQCAtMjU2OSwxMyArMjU2OSwzMyBAQCBzdGF0aWMg
dm9pZCB1cGRhdGVfc2l0X2VudHJ5KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgYmxvY2tfdCBi
bGthZGRyLCBpbnQgZGVsKQ0KIAlzdHJ1Y3Qgc2VnX2VudHJ5ICpzZTsNCiAJdW5zaWduZWQgaW50
IHNlZ25vLCBvZmZzZXQ7DQogCWxvbmcgaW50IG5ld192YmxvY2tzOw0KKwl1bnNpZ25lZCBpbnQg
bWF4X3ZhbGlkOw0KDQogCXNlZ25vID0gR0VUX1NFR05PKHNiaSwgYmxrYWRkcik7DQogCWlmIChz
ZWdubyA9PSBOVUxMX1NFR05PKQ0KIAkJcmV0dXJuOw0KDQogCXNlID0gZ2V0X3NlZ19lbnRyeShz
YmksIHNlZ25vKTsNCi0JbmV3X3ZibG9ja3MgPSBzZS0+dmFsaWRfYmxvY2tzICsgZGVsOw0KKwlt
YXhfdmFsaWQgPSBmMmZzX3VzYWJsZV9ibGtzX2luX3NlZyhzYmksIHNlZ25vKTsNCisNCisJLyog
UHJldmVudCBvdmVyZmxvdy91bmRlcmZsb3cgYmVmb3JlIHBlcmZvcm1pbmcgYXJpdGhtZXRpYy4g
Ki8NCisJaWYgKGRlbCA+IDApIHsNCisJCWlmICgodW5zaWduZWQgaW50KWRlbCA+IG1heF92YWxp
ZCB8fA0KKwkJICAgIHNlLT52YWxpZF9ibG9ja3MgPiBtYXhfdmFsaWQgLSAodW5zaWduZWQgaW50
KWRlbCkgew0KKwkJCWYyZnNfYnVnX29uKHNiaSwgMSk7DQorCQkJcmV0dXJuOw0KKwkJfQ0KKwl9
IGVsc2UgaWYgKGRlbCA8IDApIHsNCisJCWlmIChzZS0+dmFsaWRfYmxvY2tzIDwgKHVuc2lnbmVk
IGludCkoLWRlbCkpIHsNCisJCQlmMmZzX2J1Z19vbihzYmksIDEpOw0KKwkJCXJldHVybjsNCisJ
CX0NCisJfQ0KKw0KKwluZXdfdmJsb2NrcyA9IChsb25nIGludClzZS0+dmFsaWRfYmxvY2tzICsg
ZGVsOw0KIAlvZmZzZXQgPSBHRVRfQkxLT0ZGX0ZST01fU0VHMChzYmksIGJsa2FkZHIpOw0KDQog
CWYyZnNfYnVnX29uKHNiaSwgKG5ld192YmxvY2tzIDwgMCB8fA0KLS0gDQoyLjM0LjENCg==
--000000000000f317660644e07243--

