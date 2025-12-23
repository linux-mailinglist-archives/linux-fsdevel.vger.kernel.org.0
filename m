Return-Path: <linux-fsdevel+bounces-71935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F6CD7A90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E38C304C1CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264FC354AE6;
	Tue, 23 Dec 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h44+IsG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C6354ADB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453374; cv=none; b=FprwiTvDxQyoAIv8sEY0iztUHsuKpNGkUS6U1aeIlLoCctWMRnTyM5Ww+r4RHt6BVqEKdUJwnxDWOydQv7JDXNGkEL0jN54wZRVI/D7oSIWOAtOWhQauXF2nkiV4QdM/fA3b4ADACqc5lZy4ZxLlR/jGmTLM3YpUw5mbM25uCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453374; c=relaxed/simple;
	bh=tnVmiQvk3TdzZHeV/MEsMpRHNEUbfvdFAf0v/2dAxtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTOeTSeQKcRHxavXmYattfqE9tvjB9St7fbGwE0/SHep5AdySpt+mFn1tjYbsJB+yQpHJeFqz7DkccFA02SApOiQLSJjxQJiE8IrD6ybHw7S6lynTz+R7mTG7bxtHXcym4KdZsida/2ff3kxftrSyy2E8sRy9Mo+HvZ6j6lfvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h44+IsG0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b736ffc531fso802014166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 17:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766453371; x=1767058171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhwXnt5hJ0imZS+xNsBGPQ+kpSbizuoLhgsv4Ha59ms=;
        b=h44+IsG0qXBHrGeDVzUdOVABa6h8zD69sBZ3QeJu9GlY30qS53K+Xf+oMY9S7GyAdp
         D+i1ofwDddiF24VachrOGmm1IyDqC6KjdpDdlMf2vNX+nDyz6bs6aPp67pWSOt07SqYh
         xyaMCWL0hprZrBeb5qxATJIFDIr1zTb0qZoBC9uTOjQ75R9u1v8h6DSuyGdpWAvZELy9
         2e/X+Ey8S4OOYK2UzC+Sf/leczYLbdVldJmMKduzA3EayJ4GAgyMHycmQ72djklCwiYk
         /4JjGew8lkF26hCpryh9fzYkK8ceNzwit/BgRIcDdDcCh5uVoKAHDhkCMnB5nzUogFQT
         RWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766453371; x=1767058171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhwXnt5hJ0imZS+xNsBGPQ+kpSbizuoLhgsv4Ha59ms=;
        b=QdmIZVpninfkQLc8diAPg8tKMdjnaYzPFcT4Om1L9PpDes3tZZvnzy4/rg6F+Y1Vaf
         uN19vbhPcBU21j8akclhmQKwy1wM9Mmt7Rkprt1VClbEakHceZrU34GdmgoVPhE+DRlK
         tz6WVKnKfwt8Gf2eDM2Eh97rqGkU/WOz3VxzBM2a2Wt8zz3KFomyce88wZkwMpQA3MNO
         i53dqm8EvcE+sTnTfPEryK+iC9A2HrUqU/xG+uui7beNR1YjfyCiXkghF0ky4SZyxqSL
         TRQr/r4U0Y3XqP2r5HHbkEY1YIgnm9ZGqAtWcA955k9ZFof228gPjM2JvmM5NKbIui90
         lqkg==
X-Forwarded-Encrypted: i=1; AJvYcCWUUw9X+4aiF+ytzV2WmxewlxO/5+eO6mkdM51xjjLxdLJCwMVkwBwFMI6WWfQR3eAykVIimgou0Dy4JxWK@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP1i5GS2awzDgTVmeoTStcTn62HqbkjCpJgznGHHEKT7zJ5pp
	KxrEEiNRWYOmHRtTpNky2sWCwB4A4hQaDdr5+He4f0BosL7/8s56EAvVByLiYoLyVWUSqHynhFv
	VmU3WKXJlANdfTS8ncGFS3kVtsZzpOfU=
X-Gm-Gg: AY/fxX6wo/AUneyVE51aXR9Mu/r7Qcl800+J/ulb16tJlRVPNzyRzrQKrq+jxPSJ+Al
	WUUirQrCgkTcvHxE5vgHamqy1KjEp1E0sqN+XKnCogNNXIQgaGO2QA+Pqt3l6JoOsmRRrUy5tli
	NvBI2S8EinD7hSoobKRcxyF2yhHfHKRhTLwXhzcBkRaC87kt22bVOdv2cQIbff/qVu5vzTc7Qu3
	Vrw65gQWGCFL/14B0JS45EJ/St4Co2AQJOBgT2aenS6xx8KyCSMdck8RBk68/w8nPxVppqk
X-Google-Smtp-Source: AGHT+IGtbPXkp/1iq6B6e2HcORnQrAIemgfhFqPhpetL2XNJkDKKd0PIiYuJqJavMoe6JYSNihwduBK8Tuy9zNjRXtQ=
X-Received: by 2002:a17:906:9f92:b0:b2b:3481:93c8 with SMTP id
 a640c23a62f3a-b8036f1d812mr1219906866b.19.1766453370757; Mon, 22 Dec 2025
 17:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFnufp2ZD5u6pp84xtTcZKqQWtmtwN8n_d7-9UpqoUJUsEwwAA@mail.gmail.com>
 <87345fxayu.fsf@gmail.com> <8cd912f2-587b-45ff-a3aa-951272f1f538@cs.ucla.edu>
 <CAFnufp0zMe04Hh41-z6Yi8RTc0gZ7i74F6zRBDqOS5k9DZu2TQ@mail.gmail.com>
 <dabc0311-8872-4744-89ec-82a3170880b1@draigBrady.com> <CAFnufp35pGf6SDYRxf8YW17tdT0sTTXt_SXnPjpdWtg4ndojZA@mail.gmail.com>
 <4b3d3a05-09db-4a6a-80e2-8d6131d56366@cs.ucla.edu> <CAFnufp26+PnkY2OM=5NMvxDxrBf3F=FfoKBU8e0XVu4im6ZU0g@mail.gmail.com>
 <6831a0c6-baa1-4fbb-b021-4de4026922ab@cs.ucla.edu> <CAFnufp1z=-BfUVEX+wiiv+Y5f-fGbzBTZYwwhXM7VFGxAQLexQ@mail.gmail.com>
 <1a8636a8-bc53-4bb8-9ecb-677c0514efa2@cs.ucla.edu>
In-Reply-To: <1a8636a8-bc53-4bb8-9ecb-677c0514efa2@cs.ucla.edu>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 23 Dec 2025 02:28:53 +0100
X-Gm-Features: AQt7F2rXv4PR5blAs4-UyuEOfD2TaA33hAZCePJewpZ3AYzL_PSRslABsOjfvvQ
Message-ID: <CAFnufp072=wSfU4TUY7DcymJCqY5VYw2dqxt=OAY3Op3zZwEpw@mail.gmail.com>
Subject: Re: cat: adjust the maximum data copied by copy_file_range
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Collin Funk <collin.funk1@gmail.com>, coreutils@gnu.org, 
	=?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ad87880646947934"

--000000000000ad87880646947934
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 22 dic 2025 alle ore 19:41 Paul Eggert
<eggert@cs.ucla.edu> ha scritto:
>
> [cc'ing linux-fsdevel@vger.kernel.org; this coreutils thread can be
> found in <https://lists.gnu.org/r/coreutils/2025-12/threads.html#00055>.]
>
> On 2025-12-20 00:51, Matteo Croce wrote:
> > This can be triggered with a huge file:
> >
> > $ truncate -s $((2**63 - 1)) file1
> >
> > $ ( dd bs=1M skip=$((2**43 - 2)) count=0 && cat ) < file1
> > 0+0 records in
> > 0+0 records out
> > 0 bytes copied, 2,825e-05 s, 0,0 kB/s
> > cat: -: Invalid argument
> >
> > $ dd if=file1 bs=1M skip=$((2**43 - 2))
> > dd: error reading 'file1': Invalid argument
> > 1+0 records in
> > 1+0 records out
> > 1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s
>
> OK, but in bleeding-edge coreutils neither of these examples call
> copy_file_range. The diagnostics result from plain 'read' syscalls near
> TYPE_MAXIMUM (off_t). (dd never calls copy_file_range, and ironically
> the code in 'cat' that does call copy_file_range avoids the overflow
> itself, before invoking copy_file_range, and relies on plain 'read' to
> do the right thing near TYPE_MAXIMUM (off_t).) So these examples have
> nothing to do with copy_file_range.
>

Yes I know that copy_file_range is unrelated, my commands are just a
simple reproducers for the kernel issue.
Where in cat.c the code avoids the overflow? I see:

ssize_t copy_max = MIN (SSIZE_MAX, SIZE_MAX) >> 30 << 30;

which should evaluate to 0x7FFFFFFFC0000000
also strace says:

$ strace -e copy_file_range cat /etc/fstab >fstab
copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 568
copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 0
+++ exited with 0 +++

> You've found a Linux kernel bug that affects countless apps, and we
> can't reasonably expect app developers to patch all the apps to work
> around the bug. So the fix should be done in the kernel.
>
> I looked at the kernel patch you suggested in
> <https://lore.kernel.org/linux-fsdevel/20251219125250.65245-1-teknoraver@meta.com/T/>.
> Unfortunately, I see two problems with it, the first minor, the second
> less so.
>
> The minor problem is that the unpatched kernel code is merely
> incorrectly checking whether pos + count fits into loff_t. MAX_RW_COUNT
> should not be involved with the fix, as MAX_RW_COUNT is irrelevant to
> file offset range. Better would be to do correct overflow checks, with
> something like the attached patch (which I have not compiled or tested).
>
> Second and more important, the patch doesn't fix the real bug which is
> that read(FD, BUF, SIZE) fails with -EINVAL if adding SIZE to the
> current file position would overflow off_t. That's wrong: the syscall
> should read whatever bytes are present (up to EOF), and then report the
> number of bytes read. We cannot fix this bug merely via something like
> the attached patch.
>
> One possible fix for the second problem would be to change
> rw_verify_area's API to return the possibly-smaller number of bytes that
> can be read, and then modify its callers to do the right thing.
> ("correct" in the sense of "don't try to read past TYPE_MAXIMUM
> (off_t)".) Alternatively, we could fix rw_verify_area's callers to not
> try to read past TYPE_MAXIMUM (off_t), without changing the API.

Yes, the kernel bug has to be fixed, of course.
Your patch doesn't compile due to an unmatched curly brace, I fixed it
but it panics at boot, can you check if I preserved the correct logic?

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

--000000000000ad87880646947934
Content-Type: application/octet-stream; name="rw_verify_area-overflow.diff"
Content-Disposition: attachment; filename="rw_verify_area-overflow.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mjhw0t6y0>
X-Attachment-Id: f_mjhw0t6y0

ZGlmZiAtLWdpdCBhL2ZzL3JlYWRfd3JpdGUuYyBiL2ZzL3JlYWRfd3JpdGUuYwppbmRleCA4MzNi
YWUwNjg3NzAuLjQyNmVjNTA0NGY4MSAxMDA2NDQKLS0tIGEvZnMvcmVhZF93cml0ZS5jCisrKyBi
L2ZzL3JlYWRfd3JpdGUuYwpAQCAtNDU5LDEzICs0NTksMTYgQEAgaW50IHJ3X3ZlcmlmeV9hcmVh
KGludCByZWFkX3dyaXRlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgbG9mZl90ICpwcG9zLCBz
aXplX3QKIAlpZiAocHBvcykgewogCQlsb2ZmX3QgcG9zID0gKnBwb3M7CgotCQlpZiAodW5saWtl
bHkocG9zIDwgMCkpIHsKLQkJCWlmICghdW5zaWduZWRfb2Zmc2V0cyhmaWxlKSkKKwkJaWYgKCF1
bnNpZ25lZF9vZmZzZXRzKGZpbGUpKQorCQkJcmV0dXJuIC1FSU5WQUw7CisJCWlmICh1bnNpZ25l
ZF9vZmZzZXRzKGZpbGUpKSB7CisJCQlpZiAoY2hlY2tfYWRkX292ZXJmbG93ICgodW9mZl90KSBw
b3MsIGNvdW50LAorCQkJCQkJJih1b2ZmX3QpIHswfSkpCiAJCQkJcmV0dXJuIC1FSU5WQUw7Ci0J
CQlpZiAoY291bnQgPj0gLXBvcykgLyogYm90aCB2YWx1ZXMgYXJlIGluIDAuLkxMT05HX01BWCAq
LwotCQkJCXJldHVybiAtRU9WRVJGTE9XOwotCQl9IGVsc2UgaWYgKHVubGlrZWx5KChsb2ZmX3Qp
IChwb3MgKyBjb3VudCkgPCAwKSkgewotCQkJaWYgKCF1bnNpZ25lZF9vZmZzZXRzKGZpbGUpKQor
CQl9IGVsc2UgeworCQkJaWYgKHVubGlrZWx5KHBvcyA8IDApKQorCQkJCXJldHVybiAtRUlOVkFM
OworCQkJaWYgKGNoZWNrX2FkZF9vdmVyZmxvdyAocG9zLCBjb3VudCwgJihsb2ZmX3QpIHswfSkp
CiAJCQkJcmV0dXJuIC1FSU5WQUw7CiAJCX0KIAl9Cg==
--000000000000ad87880646947934--

