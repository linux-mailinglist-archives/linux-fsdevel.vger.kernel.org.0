Return-Path: <linux-fsdevel+bounces-49809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FEAAC2FCF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EF04A422D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD21D799D;
	Sat, 24 May 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsflvgie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F32745E;
	Sat, 24 May 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748091721; cv=none; b=Qam/60Usc/Z50W6ZmSweM2sEioCvN1xMqdrU746FqoAEW8b2QaSr4N/C9ZYFzU1izkhC9Kyy8UZKwNkaGFRcUeq05ascaUvuF4+tzoMMG9CHMQ5gcvUBl6DUQLzO1mjDW4ze46TxDB91pEL0MFaTOKa3AL1GUde1Uu8QEsGmc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748091721; c=relaxed/simple;
	bh=RRcJZK/fdpm/UJirK6DuyBS1H1g+MRfNPW/QAj20+u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpxepuN5gQuIrOgMigexr+sy+K4n2TQeP0VnPAX+N4IpL3UVN8dbEFpv+hYRWfpp3X69Hi32jyoZHCRzqOqRjFqfbkkCFwSxhr2tIfVI3bEVWPe06CJeuf83v82b+IfRPNLbT9vEbZF8bcAXFJJGZiS6eztufFrzb9GuBByHQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsflvgie; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601968db16bso1502175a12.3;
        Sat, 24 May 2025 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748091718; x=1748696518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKli66YIl4D8KkYGob+nwhEH8L463HtKxvM0zVYBV2s=;
        b=lsflvgiekZizO3XbaMloNxblORDr68FHmP01w8oT89m72k9mrP3xz42NePmQWEKH7U
         cwliYuhFkP1jCMYJwiXSY+tzz9+3llTAP8zgvCJT8Z7w7VaVEamnHIpWeAdKRCmlymze
         y5gndaz4qYICAr3Fm4II5gQ5/9vSmT3DMcbwekIM5bpKrkud7pPaMO+e6KVzOhs+Qsxx
         kFtjTKl/CNC0BDYHXMZbs84C7HBKUeMrGqBntT9qCt0bfA7J5UI2tvsPJ9uOny/+b75o
         lnWni4twep8BbN7S7Oj+eIW0SnUaQ558p20p4Jxz/UlTfGfYxENlwo9asAS2gPpYKXWF
         Vq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748091718; x=1748696518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKli66YIl4D8KkYGob+nwhEH8L463HtKxvM0zVYBV2s=;
        b=Dpx9A0kHhfVddzwUi9XZktLKDwjigu3dpgQEtFfDodTTCYuY7gtpd/d8+0fM3fm4+N
         Wr7JmpBHMpWf5waWOczqk3hTdGoASzKHlDiSUNUurHySSMB9LZL4MSqgAcjBynJ6JBc2
         F80KE+cr35vH7p0WuvFusLAs7rKrA5JoBL6rcpsuF9NyadABeNE+5PaZV5bA7feeC2dh
         D/lmBq+l99RVXLsHX7ZahR5soEOBif7CnsCdpZhL48XPwk/x25urs/p5gjU6ORtcf0lx
         Lhmtka8AI6xVHUXzulgUuaeyXPMNt2eRODU0OQOj3WqWxC2C4M28EBMTpesdfr4WH4lW
         HqJg==
X-Forwarded-Encrypted: i=1; AJvYcCUVkU/fBTTRer2kYXIVUfA7QeIunq87GxLgnO9b2iHgS1XMtnpPuwa3yIP9s/hkxHBxtjVdcs/nKO6GtW79@vger.kernel.org, AJvYcCVu00b9tEseWlPq+tt/QNEx1c/u2MLizlr/1l9lcdD5shhFk1jK7YKEWRvHHrZuw7aZTDTptOMQAJBY6git3Q==@vger.kernel.org, AJvYcCXpdFYAKoGnt9Ggx8IYdfZhwec1qZLq5a2Wll2p7oH7Dh51+VTx8xn1weri6WLwMxCCHNHxDvKdftqA68y0yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDuZH8HQbh4QNfCOx1mMFH2e4aaLw4qAEzvyLBND/tbkz0GUe
	59hDV8X6AhJImXvNNd4pWd/qPn4tJtV0dKJl6bSJLeYDjFdUQbQEM71t/IdNyPcO8I8XaWDMFe7
	GssGveuFy/w23sSFxiRqulIZxt7IIWvw=
X-Gm-Gg: ASbGncvVaf2MgLE/2LUzj3HB3+uh5uWZrmQOonZ2R70k73yS5vQU2Bbi/I/QW1e4rg7
	tY5P/UOFoFRm9KbVNtJBp6TkyG1xwt+fdBmr639/slmEHEY7js4ZXH5shBVKLyUPgrqoKXq23/U
	QG2VBtV2oa7nIAXA/X7Qb3NeIfuCkHhbnp
X-Google-Smtp-Source: AGHT+IGFBuSQWTc2AAcR3FwFP7yOs/CuTeEbBHHmWeUnThUmXvogiu/D4qUlObhi1NJKDe5soESb6rq9vROFyqvVDe0=
X-Received: by 2002:a17:907:da7:b0:ac3:17bb:34fc with SMTP id
 a640c23a62f3a-ad85b2f3465mr212279766b.52.1748091717392; Sat, 24 May 2025
 06:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
 <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com> <ltzdzvmycohkgvmr3bd6f2ve4a4faxuvkav3d7wt2zoo5gkote@47o5yfse2mzn>
In-Reply-To: <ltzdzvmycohkgvmr3bd6f2ve4a4faxuvkav3d7wt2zoo5gkote@47o5yfse2mzn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 24 May 2025 15:01:44 +0200
X-Gm-Features: AX0GCFsWbisYlOZ9f-uZKVJuy4gvFqMnUE-fT8CU5vNIsj46pl3EvxBQal41DSo
Message-ID: <CAOQ4uxjHb4B1YL2hSMHxd2Y0mMmfpHMzgbHO5wLF3=rMVxsHyQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: multipart/mixed; boundary="000000000000d9cf060635e15135"

--000000000000d9cf060635e15135
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 11:10=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, May 23, 2025 at 10:30:16PM +0200, Amir Goldstein wrote:
>
> That makes fstests generic/631 pass.

Yes, that is not very surprising.
I meant if you could help test that:

1. mounting case folder upperdir/lowerdir fails
2. lookup a case folder subdir fails
3. lookup in a dir that was empty and became case folder while ovl was
mounted fails

For me, I do not have any setup with case folding subtrees
so testing those use cases would take me time and
I think that you must have tested all those scenarios with your patch set?
and maybe already have some fstests for them?

>
> We really should be logging something in dmesg on error due to
> casefolded directory, though.

No problem.
Attached v2 with warnings.

For example, here is the new warning in test overlay/065:

[  131.815110] overlayfs: failed lookup in lower (/lower,
name=3D'upper', err=3D-40): overlapping layers

Thanks,
Amir.

--000000000000d9cf060635e15135
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-ovl-support-layers-on-case-folding-capable-filesy.patch"
Content-Disposition: attachment; 
	filename="v2-0001-ovl-support-layers-on-case-folding-capable-filesy.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mb28nuoh0>
X-Attachment-Id: f_mb28nuoh0

RnJvbSA0ZjczMDgxMWI4MDY3MGI2NWU0ZWRkODE4NjIxYjk4OGM1OWUxNTBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDIzIE1heSAyMDI1IDIyOjEzOjE4ICswMjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0g
b3ZsOiBzdXBwb3J0IGxheWVycyBvbiBjYXNlLWZvbGRpbmcgY2FwYWJsZSBmaWxlc3lzdGVtcwoK
Q2FzZSBmb2xkaW5nIGlzIG9mdGVuIGFwcGxpZWQgdG8gc3VidHJlZXMgYW5kIG5vdCBvbiBhbiBl
bnRpcmUKZmlsZXN5c3RlbS4KCkRpc2FsbG93aW5nIGxheWVycyBmcm9tIGZpbGVzeXN0ZW1zIHRo
YXQgc3VwcG9ydCBjYXNlIGZvbGRpbmcgaXMgb3ZlcgpsaW1pdGluZy4KClJlcGxhY2UgdGhlIHJ1
bGUgdGhhdCBjYXNlLWZvbGRpbmcgY2FwYWJsZSBhcmUgbm90IGFsbG93ZWQgYXMgbGF5ZXJzCndp
dGggYSBydWxlIHRoYXQgY2FzZSBmb2xkZWQgZGlyZWN0b3JpZXMgYXJlIG5vdCBhbGxvd2VkIGlu
IGEgbWVyZ2VkCmRpcmVjdG9yeSBzdGFjay4KClNob3VsZCBjYXNlIGZvbGRpbmcgYmUgZW5hYmxl
ZCBvbiBhbiB1bmRlcmx5aW5nIGRpcmVjdG9yeSB3aGlsZQpvdmVybGF5ZnMgaXMgbW91bnRlZCB0
aGUgb3V0Y29tZSBpcyBnZW5lcmFsbHkgdW5kZWZpbmVkLgoKU3BlY2lmaWNhbGx5IGluIG92bF9s
b29rdXAoKSwgd2UgY2hlY2sgdGhlIGJhc2UgdW5kZXJseWluZyBkaXJlY3RvcnkKYW5kIGZhaWwg
d2l0aCAtRVNUQUxFIGFuZCB3cml0ZSBhIHdhcm5pbmcgdG8ga21zZyBpZiBhbiB1bmRlcmx5aW5n
CmRpcmVjdG9yeSBjYXNlIGZvbGRpbmcgaXMgZW5hYmxlZC4KClN1Z2dlc3RlZC1ieTogS2VudCBP
dmVyc3RyZWV0IDxrZW50Lm92ZXJzdHJlZXRAbGludXguZGV2PgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjUwNTIwMDUxNjAwLjE5MDMzMTktMS1rZW50Lm92
ZXJzdHJlZXRAbGludXguZGV2LwpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPgotLS0KIGZzL292ZXJsYXlmcy9uYW1laS5jICB8IDI1ICsrKysrKysrKysr
KysrKysrKysrKystLS0KIGZzL292ZXJsYXlmcy9wYXJhbXMuYyB8IDExICsrKysrLS0tLS0tCiBm
cy9vdmVybGF5ZnMvdXRpbC5jICAgfCAxNSArKysrKysrKysrKy0tLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgMzggaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvb3Zl
cmxheWZzL25hbWVpLmMgYi9mcy9vdmVybGF5ZnMvbmFtZWkuYwppbmRleCBkNDg5ZTgwZmViNmYu
LjMzMzAxN2Y2YWU2NSAxMDA2NDQKLS0tIGEvZnMvb3ZlcmxheWZzL25hbWVpLmMKKysrIGIvZnMv
b3ZlcmxheWZzL25hbWVpLmMKQEAgLTIzMCwxMyArMjMwLDI2IEBAIHN0YXRpYyBpbnQgb3ZsX2xv
b2t1cF9zaW5nbGUoc3RydWN0IGRlbnRyeSAqYmFzZSwgc3RydWN0IG92bF9sb29rdXBfZGF0YSAq
ZCwKIAkJCSAgICAgc3RydWN0IGRlbnRyeSAqKnJldCwgYm9vbCBkcm9wX25lZ2F0aXZlKQogewog
CXN0cnVjdCBvdmxfZnMgKm9mcyA9IE9WTF9GUyhkLT5zYik7Ci0Jc3RydWN0IGRlbnRyeSAqdGhp
czsKKwlzdHJ1Y3QgZGVudHJ5ICp0aGlzID0gTlVMTDsKKwljb25zdCBjaGFyICp3YXJuOwogCXN0
cnVjdCBwYXRoIHBhdGg7CiAJaW50IGVycjsKIAlib29sIGxhc3RfZWxlbWVudCA9ICFwb3N0WzBd
OwogCWJvb2wgaXNfdXBwZXIgPSBkLT5sYXllci0+aWR4ID09IDA7CiAJY2hhciB2YWw7CiAKKwkv
KgorCSAqIFdlIGFsbG93IGZpbGVzeXN0ZW1zIHRoYXQgYXJlIGNhc2UtZm9sZGluZyBjYXBhYmxl
IGJ1dCBkZW55IGNvbXBvc2luZworCSAqIG92bCBzdGFjayBmcm9tIGNhc2UtZm9sZGVkIGRpcmVj
dG9yaWVzLiBJZiBzb21lb25lIGhhcyBlbmFibGVkIGNhc2UKKwkgKiBmb2xkaW5nIG9uIGEgZGly
ZWN0b3J5IG9uIHVuZGVybHlpbmcgbGF5ZXIsIHRoZSB3YXJyYW50eSBvZiB0aGUgb3ZsCisJICog
c3RhY2sgaXMgdm9pZGVkLgorCSAqLworCWlmIChzYl9oYXNfZW5jb2RpbmcoYmFzZS0+ZF9zYikg
JiYgSVNfQ0FTRUZPTERFRChkX2lub2RlKGJhc2UpKSkgeworCQl3YXJuID0gImNhc2UgZm9sZGVk
IHBhcmVudCI7CisJCWVyciA9IC1FU1RBTEU7CisJCWdvdG8gb3V0X3dhcm47CisJfQorCiAJdGhp
cyA9IG92bF9sb29rdXBfcG9zaXRpdmVfdW5sb2NrZWQoZCwgbmFtZSwgYmFzZSwgbmFtZWxlbiwg
ZHJvcF9uZWdhdGl2ZSk7CiAJaWYgKElTX0VSUih0aGlzKSkgewogCQllcnIgPSBQVFJfRVJSKHRo
aXMpOwpAQCAtMjQ4LDggKzI2MSw5IEBAIHN0YXRpYyBpbnQgb3ZsX2xvb2t1cF9zaW5nbGUoc3Ry
dWN0IGRlbnRyeSAqYmFzZSwgc3RydWN0IG92bF9sb29rdXBfZGF0YSAqZCwKIAogCWlmIChvdmxf
ZGVudHJ5X3dlaXJkKHRoaXMpKSB7CiAJCS8qIERvbid0IHN1cHBvcnQgdHJhdmVyc2luZyBhdXRv
bW91bnRzIGFuZCBvdGhlciB3ZWlyZG5lc3MgKi8KKwkJd2FybiA9ICJ1bnN1cHBvcnRlZCBvYmpl
Y3QgdHlwZSI7CiAJCWVyciA9IC1FUkVNT1RFOwotCQlnb3RvIG91dF9lcnI7CisJCWdvdG8gb3V0
X3dhcm47CiAJfQogCiAJcGF0aC5kZW50cnkgPSB0aGlzOwpAQCAtMjgzLDggKzI5Nyw5IEBAIHN0
YXRpYyBpbnQgb3ZsX2xvb2t1cF9zaW5nbGUoc3RydWN0IGRlbnRyeSAqYmFzZSwgc3RydWN0IG92
bF9sb29rdXBfZGF0YSAqZCwKIAl9IGVsc2UgewogCQlpZiAob3ZsX2xvb2t1cF90cmFwX2lub2Rl
KGQtPnNiLCB0aGlzKSkgewogCQkJLyogQ2F1Z2h0IGluIGEgdHJhcCBvZiBvdmVybGFwcGluZyBs
YXllcnMgKi8KKwkJCXdhcm4gPSAib3ZlcmxhcHBpbmcgbGF5ZXJzIjsKIAkJCWVyciA9IC1FTE9P
UDsKLQkJCWdvdG8gb3V0X2VycjsKKwkJCWdvdG8gb3V0X3dhcm47CiAJCX0KIAogCQlpZiAobGFz
dF9lbGVtZW50KQpAQCAtMzE2LDYgKzMzMSwxMCBAQCBzdGF0aWMgaW50IG92bF9sb29rdXBfc2lu
Z2xlKHN0cnVjdCBkZW50cnkgKmJhc2UsIHN0cnVjdCBvdmxfbG9va3VwX2RhdGEgKmQsCiAJdGhp
cyA9IE5VTEw7CiAJZ290byBvdXQ7CiAKK291dF93YXJuOgorCXByX3dhcm5fcmF0ZWxpbWl0ZWQo
ImZhaWxlZCBsb29rdXAgaW4gJXMgKCVwZDIsIG5hbWU9JyUuKnMnLCBlcnI9JWkpOiAlc1xuIiwK
KwkJCSAgICBpc191cHBlciA/ICJ1cHBlciIgOiAibG93ZXIiLCBiYXNlLAorCQkJICAgIG5hbWVs
ZW4sIG5hbWUsIGVyciwgd2Fybik7CiBvdXRfZXJyOgogCWRwdXQodGhpcyk7CiAJcmV0dXJuIGVy
cjsKZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9wYXJhbXMuYyBiL2ZzL292ZXJsYXlmcy9wYXJh
bXMuYwppbmRleCBmNDI0ODhjMDE5NTcuLjg0OGE2YjEzNTE0MyAxMDA2NDQKLS0tIGEvZnMvb3Zl
cmxheWZzL3BhcmFtcy5jCisrKyBiL2ZzL292ZXJsYXlmcy9wYXJhbXMuYwpAQCAtMjgyLDEzICsy
ODIsMTIgQEAgc3RhdGljIGludCBvdmxfbW91bnRfZGlyX2NoZWNrKHN0cnVjdCBmc19jb250ZXh0
ICpmYywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsCiAJCXJldHVybiBpbnZhbGZjKGZjLCAiJXMg
aXMgbm90IGEgZGlyZWN0b3J5IiwgbmFtZSk7CiAKIAkvKgotCSAqIFJvb3QgZGVudHJpZXMgb2Yg
Y2FzZS1pbnNlbnNpdGl2ZSBjYXBhYmxlIGZpbGVzeXN0ZW1zIG1pZ2h0Ci0JICogbm90IGhhdmUg
dGhlIGRlbnRyeSBvcGVyYXRpb25zIHNldCwgYnV0IHN0aWxsIGJlIGluY29tcGF0aWJsZQotCSAq
IHdpdGggb3ZlcmxheWZzLiAgQ2hlY2sgZXhwbGljaXRseSB0byBwcmV2ZW50IHBvc3QtbW91bnQK
LQkgKiBmYWlsdXJlcy4KKwkgKiBBbGxvdyBmaWxlc3lzdGVtcyB0aGF0IGFyZSBjYXNlLWZvbGRp
bmcgY2FwYWJsZSBidXQgZGVueSBjb21wb3NpbmcKKwkgKiBvdmwgc3RhY2sgZnJvbSBjYXNlLWZv
bGRlZCBkaXJlY3Rvcmllcy4KIAkgKi8KLQlpZiAoc2JfaGFzX2VuY29kaW5nKHBhdGgtPm1udC0+
bW50X3NiKSkKLQkJcmV0dXJuIGludmFsZmMoZmMsICJjYXNlLWluc2Vuc2l0aXZlIGNhcGFibGUg
ZmlsZXN5c3RlbSBvbiAlcyBub3Qgc3VwcG9ydGVkIiwgbmFtZSk7CisJaWYgKHNiX2hhc19lbmNv
ZGluZyhwYXRoLT5tbnQtPm1udF9zYikgJiYKKwkgICAgSVNfQ0FTRUZPTERFRChkX2lub2RlKHBh
dGgtPmRlbnRyeSkpKQorCQlyZXR1cm4gaW52YWxmYyhmYywgImNhc2UtaW5zZW5zaXRpdmUgZGly
ZWN0b3J5IG9uICVzIG5vdCBzdXBwb3J0ZWQiLCBuYW1lKTsKIAogCWlmIChvdmxfZGVudHJ5X3dl
aXJkKHBhdGgtPmRlbnRyeSkpCiAJCXJldHVybiBpbnZhbGZjKGZjLCAiZmlsZXN5c3RlbSBvbiAl
cyBub3Qgc3VwcG9ydGVkIiwgbmFtZSk7CmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvdXRpbC5j
IGIvZnMvb3ZlcmxheWZzL3V0aWwuYwppbmRleCBkY2NjYjRiNGE2NmMuLjU5M2M0ZGExMDdkNiAx
MDA2NDQKLS0tIGEvZnMvb3ZlcmxheWZzL3V0aWwuYworKysgYi9mcy9vdmVybGF5ZnMvdXRpbC5j
CkBAIC0yMDYsMTAgKzIwNiwxNyBAQCBib29sIG92bF9kZW50cnlfd2VpcmQoc3RydWN0IGRlbnRy
eSAqZGVudHJ5KQogCWlmICghZF9jYW5fbG9va3VwKGRlbnRyeSkgJiYgIWRfaXNfZmlsZShkZW50
cnkpICYmICFkX2lzX3N5bWxpbmsoZGVudHJ5KSkKIAkJcmV0dXJuIHRydWU7CiAKLQlyZXR1cm4g
ZGVudHJ5LT5kX2ZsYWdzICYgKERDQUNIRV9ORUVEX0FVVE9NT1VOVCB8Ci0JCQkJICBEQ0FDSEVf
TUFOQUdFX1RSQU5TSVQgfAotCQkJCSAgRENBQ0hFX09QX0hBU0ggfAotCQkJCSAgRENBQ0hFX09Q
X0NPTVBBUkUpOworCWlmIChkZW50cnktPmRfZmxhZ3MgJiAoRENBQ0hFX05FRURfQVVUT01PVU5U
IHwgRENBQ0hFX01BTkFHRV9UUkFOU0lUKSkKKwkJcmV0dXJuIHRydWU7CisKKwkvKgorCSAqIEFs
bG93IGZpbGVzeXN0ZW1zIHRoYXQgYXJlIGNhc2UtZm9sZGluZyBjYXBhYmxlIGJ1dCBkZW55IGNv
bXBvc2luZworCSAqIG92bCBzdGFjayBmcm9tIGNhc2UtZm9sZGVkIGRpcmVjdG9yaWVzLgorCSAq
LworCWlmIChzYl9oYXNfZW5jb2RpbmcoZGVudHJ5LT5kX3NiKSkKKwkJcmV0dXJuIElTX0NBU0VG
T0xERUQoZF9pbm9kZShkZW50cnkpKTsKKworCXJldHVybiBkZW50cnktPmRfZmxhZ3MgJiAoRENB
Q0hFX09QX0hBU0ggfCBEQ0FDSEVfT1BfQ09NUEFSRSk7CiB9CiAKIGVudW0gb3ZsX3BhdGhfdHlw
ZSBvdmxfcGF0aF90eXBlKHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKLS0gCjIuMzQuMQoK
--000000000000d9cf060635e15135--

