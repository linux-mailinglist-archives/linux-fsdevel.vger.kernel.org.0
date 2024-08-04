Return-Path: <linux-fsdevel+bounces-24933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE0946C14
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 05:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A481C21190
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F786FC5;
	Sun,  4 Aug 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h+DyNNr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272D33D8
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722742954; cv=none; b=QnX5mAws6qGUjwAqS1QMU1LdOp/mC7LniDia1FMTtM7XNUggtwSzw2kD9F1/5h2Acc1p1BTO1gaWPwnY2DcrSXIka4kTh3jbaiO6M1u+Tt0d3RebsPSm1SVO2+NL3VELSDqJHYakbDly5PmXfQxWTPB55Bgvs/WdjYB3iEI5F1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722742954; c=relaxed/simple;
	bh=49ALTSLJ39l4fHH2zNnTn2SlhVJBiZIX1psvdq/cf9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1u9isBgQIF8s7H0F3xRxN82xbX3h9TRBD23CwtHcY/Ie1zOFnUAZs7oH4mBvoHzlofvmLXzkWZudp/68u0rRt2OoVDvPRFvtWdl8k/yzrMARfdV1govhtomQkvfelaBN1ugTICm7MuYTepng8NHKPJo2R7v+g144LAhbzFVg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h+DyNNr4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a8553db90so1225622866b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722742950; x=1723347750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiTdukzxLxnQGUGaDkbrbkgpFhTGC/DcegqBcYIWpAY=;
        b=h+DyNNr489GZIq7LVWUOLPmhbKkUo3USUdfO0bY6FQQZMbeGGETl0hyoZ6sOjcvx6z
         0rpE1T+4J3o8ojGrIvzKDC0M+9Gj83u3bPiAflYE7+4FydHrcVMa3HPk2kl4jrWhoKmp
         LkwjKyye8nBqqPmG6jeLZ5bmFubncOJBrOnqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722742950; x=1723347750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiTdukzxLxnQGUGaDkbrbkgpFhTGC/DcegqBcYIWpAY=;
        b=of0+PVWMe1YI6A7dPuuDuLIko8n2Wb1Wvv5moVmI/aEePfwl5nRPLI0e6f0SZPxm3a
         2vhpeWPfPLAEob095GRELpDk9WrqTyX9bFCt5tncaUh0tljoKf8N0Qc6VULXzeXWXixn
         a38w2FPNj2zgToXN7Vo2xlp1CZBYFXhTIdFiFF1VeWj7zNlgyGhJfW7UDuy/WXz2MSV3
         rrH7VboPse1HQfvbcq2gylP1RUzPHrVEh1qDY/rETwhToiNE8pDgFB+IUQIk/WSaQWt3
         zs6Z+4nJJPBx0/bLb8F1hmhojjBURiEPra+8vhtWbStNFLK9b7ai646iGnyg3J+4ps1/
         ZiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgoIoAqtWarq8I4xCNWl72vwcoP9lPD9yCOYd/edO6kenhHyMHaoqbTzIZPV/8YAfKz9ZG3gh2GoNsf2kePH5sB7VLSerCLr3XarbMcA==
X-Gm-Message-State: AOJu0YwsmauySG1I+V4qdm3svUghn1azw9IdNSOkhA8OGc+lm8mE4BEx
	V4D52KCQ0BIpfwjPtV/xk2Rzothn+uleHqlztApktwt5NjOLF+KOPUZUzdtK+TBWQIbup2hjfaG
	nQN2uVA==
X-Google-Smtp-Source: AGHT+IG1MdAciJt11v+p93snQTIISXMrOoY0l5EdKXjMsxCxzcXe2dWDnwCbSDBibdwyZPkFLTTpvA==
X-Received: by 2002:a17:907:3f28:b0:a7a:acae:3415 with SMTP id a640c23a62f3a-a7dc4db4b08mr610954566b.10.1722742949637;
        Sat, 03 Aug 2024 20:42:29 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0d5sm284526166b.48.2024.08.03.20.42.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 20:42:28 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so1152273866b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 20:42:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUxF+s5v1MkVwLF6RHZFPCbTjawFCycX9XuceKk4ouFdcaHfqBtR10/q7olXWIe4Shuhu7KONvbx4AG6vrGimHAZ1qmaL/hZBPuZxz4Q==
X-Received: by 2002:a17:907:d92:b0:a77:c583:4f78 with SMTP id
 a640c23a62f3a-a7dc4fee5f7mr765149966b.39.1722742948452; Sat, 03 Aug 2024
 20:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803225054.GY5334@ZenIV> <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
In-Reply-To: <20240804003405.GA5334@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Aug 2024 20:42:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCXck9DbuzcGEQNbaiAL5bLyO3fuFj7ra8M=9Qjyr_zA@mail.gmail.com>
Message-ID: <CAHk-=wjCXck9DbuzcGEQNbaiAL5bLyO3fuFj7ra8M=9Qjyr_zA@mail.gmail.com>
Subject: Re: [PATCH] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007b8fd5061ed35927"

--0000000000007b8fd5061ed35927
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Aug 2024 at 17:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Bitmap handling in there certainly needs to be cleaned up; no arguments
> here.  If anything, we might want something like
>
> bitmap_copy_and_extend(unsigned long *to, const unsigned long *from,
>                         unsigned int count, unsigned int size)
> {
>         unsigned int copy = BITS_TO_LONGS(count);
>
>         memcpy(to, from, copy * sizeof(long));
>         if (count % BITS_PER_LONG)
>                 to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
>         memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
> }
>
> and use it for all of three bitmaps.

That certainly works for me.

If you want to specialize it a bit more, you might do a separate
routine for the "known to be word aligned" case.

I extended on my previous patch. I'm not sure it's worth it, and it's
still ENTIRELY UNTESTED, but you get the idea..

But I'm ok with your generic bitmap version too.

              Linus

--0000000000007b8fd5061ed35927
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lzf0nnfo0>
X-Attachment-Id: f_lzf0nnfo0

IGZzL2ZpbGUuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy9maWxlLmMgYi9mcy9maWxlLmMKaW5kZXggYTExZTU5YjVk
NjAyLi45NDg4NTZkOGNhZWUgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGUuYworKysgYi9mcy9maWxlLmMK
QEAgLTQ2LDI3ICs0Niw1NyBAQCBzdGF0aWMgdm9pZCBmcmVlX2ZkdGFibGVfcmN1KHN0cnVjdCBy
Y3VfaGVhZCAqcmN1KQogI2RlZmluZSBCSVRCSVRfTlIobnIpCUJJVFNfVE9fTE9OR1MoQklUU19U
T19MT05HUyhucikpCiAjZGVmaW5lIEJJVEJJVF9TSVpFKG5yKQkoQklUQklUX05SKG5yKSAqIHNp
emVvZihsb25nKSkKIAorI2RlZmluZSBDT1BZX1dPUkRTKGRzdCxzcmMsbikgZG8geyAqZHN0Kysg
PSAqc3JjKys7IH0gd2hpbGUgKC0tbikKKyNkZWZpbmUgQ0xFQVJfV09SRFMoZHN0LG4pIGRvIHsg
KmRzdCsrID0gMDsgfSB3aGlsZSAoLS1uKQorCitzdGF0aWMgdm9pZCBjb3B5X2JpdG1hcF93b3Jk
cyh1bnNpZ25lZCBsb25nICpkc3QsIHVuc2lnbmVkIGxvbmcgKnNyYywKKwl1bnNpZ25lZCBpbnQg
Y29weSwgdW5zaWduZWQgaW50IGNsZWFyKQoreworCS8qIFRoZXJlIGlzIGFsd2F5cyBhdCBsZWFz
dCBvbmUgd29yZCBpbiB0aGUgZmQgYml0bWFwISAqLworCUNPUFlfV09SRFMoZHN0LCBzcmMsIGNv
cHkpOworCS8qIC4uIGJ1dCBtaWdodCBub3QgYmUgYW55dGhpbmcgdG8gY2xlYXIgKi8KKwlpZiAo
Y2xlYXIpIENMRUFSX1dPUkRTKGRzdCwgY2xlYXIpOworfQorCitzdGF0aWMgdm9pZCBjb3B5X2Jp
dG1hcF9iaXRzKHVuc2lnbmVkIGxvbmcgKmRzdCwgdW5zaWduZWQgbG9uZyAqc3JjLAorCXVuc2ln
bmVkIGludCBjb3B5LCB1bnNpZ25lZCBpbnQgY2xlYXIpCit7CisJaWYgKGNvcHkgPj0gQklUU19Q
RVJfTE9ORykgeworCQl1bnNpZ25lZCBpbnQgd29yZHMgPSBjb3B5IC8gQklUU19QRVJfTE9ORzsK
KwkJQ09QWV9XT1JEUyhkc3QsIHNyYywgd29yZHMpOworCQljb3B5ICY9IEJJVFNfUEVSX0xPTkct
MTsKKwl9CisJaWYgKGNvcHkpIHsKKwkJKmRzdCA9ICpzcmMgJiAoKDF1bCA8PCBjb3B5KS0xKTsK
KwkJZHN0Kys7CisJfQorCS8qIFRoZSBhYm92ZSB3aWxsIGhhdmUgZGVhbHQgd2l0aCB0aGUgbG93
IGJpdHMgb2YgJ2NsZWFyJyB0b28gKi8KKwljbGVhciAvPSBCSVRTX1BFUl9MT05HOworCWlmIChj
bGVhcikgQ0xFQVJfV09SRFMoZHN0LCBjbGVhcik7Cit9CisKIC8qCiAgKiBDb3B5ICdjb3VudCcg
ZmQgYml0cyBmcm9tIHRoZSBvbGQgdGFibGUgdG8gdGhlIG5ldyB0YWJsZSBhbmQgY2xlYXIgdGhl
IGV4dHJhCiAgKiBzcGFjZSBpZiBhbnkuICBUaGlzIGRvZXMgbm90IGNvcHkgdGhlIGZpbGUgcG9p
bnRlcnMuICBDYWxsZWQgd2l0aCB0aGUgZmlsZXMKICAqIHNwaW5sb2NrIGhlbGQgZm9yIHdyaXRl
LgorICoKKyAqIE5vdGU6IHRoZSBmZCBiaXRtYXBzIGFyZSBhbHdheXMgZnVsbCBiaXRtYXAgd29y
ZHMgKHNlZSBzYW5lX2ZkdGFibGVfc2l6ZSgpKSwKKyAqIGJ1dCB0aGUgZnVsbF9mZHNfYml0cyBi
aXRtYXAgaXMgYSBiaXRtYXAgb2YgZmQgYml0bWFwIHdvcmRzLCBub3Qgb2YgZmRzLgogICovCiBz
dGF0aWMgdm9pZCBjb3B5X2ZkX2JpdG1hcHMoc3RydWN0IGZkdGFibGUgKm5mZHQsIHN0cnVjdCBm
ZHRhYmxlICpvZmR0LAogCQkJICAgIHVuc2lnbmVkIGludCBjb3VudCkKIHsKLQl1bnNpZ25lZCBp
bnQgY3B5LCBzZXQ7CisJdW5zaWduZWQgaW50IGNvcHksIGNsZWFyOwogCi0JY3B5ID0gY291bnQg
LyBCSVRTX1BFUl9CWVRFOwotCXNldCA9IChuZmR0LT5tYXhfZmRzIC0gY291bnQpIC8gQklUU19Q
RVJfQllURTsKLQltZW1jcHkobmZkdC0+b3Blbl9mZHMsIG9mZHQtPm9wZW5fZmRzLCBjcHkpOwot
CW1lbXNldCgoY2hhciAqKW5mZHQtPm9wZW5fZmRzICsgY3B5LCAwLCBzZXQpOwotCW1lbWNweShu
ZmR0LT5jbG9zZV9vbl9leGVjLCBvZmR0LT5jbG9zZV9vbl9leGVjLCBjcHkpOwotCW1lbXNldCgo
Y2hhciAqKW5mZHQtPmNsb3NlX29uX2V4ZWMgKyBjcHksIDAsIHNldCk7CisJY29weSA9IGNvdW50
IC8gQklUU19QRVJfTE9ORzsKKwljbGVhciA9IG5mZHQtPm1heF9mZHMgLyBCSVRTX1BFUl9MT05H
IC0gY29weTsKIAotCWNweSA9IEJJVEJJVF9TSVpFKGNvdW50KTsKLQlzZXQgPSBCSVRCSVRfU0la
RShuZmR0LT5tYXhfZmRzKSAtIGNweTsKLQltZW1jcHkobmZkdC0+ZnVsbF9mZHNfYml0cywgb2Zk
dC0+ZnVsbF9mZHNfYml0cywgY3B5KTsKLQltZW1zZXQoKGNoYXIgKiluZmR0LT5mdWxsX2Zkc19i
aXRzICsgY3B5LCAwLCBzZXQpOworCS8qIENvcHkgdGhlIGJpdG1hcCB3b3JkcyAqLworCWNvcHlf
Yml0bWFwX3dvcmRzKG5mZHQtPm9wZW5fZmRzLCBvZmR0LT5vcGVuX2ZkcywgY29weSwgY2xlYXIp
OworCWNvcHlfYml0bWFwX3dvcmRzKG5mZHQtPmNsb3NlX29uX2V4ZWMsIG9mZHQtPmNsb3NlX29u
X2V4ZWMsIGNvcHksIGNsZWFyKTsKKworCS8qIENvcHkgdGhlIGJpdHMgZm9yIHRoZSB3b3JkcyAq
LworCWNvcHlfYml0bWFwX2JpdHMobmZkdC0+ZnVsbF9mZHNfYml0cywgb2ZkdC0+ZnVsbF9mZHNf
Yml0cywgY29weSwgY2xlYXIpOwogfQogCiAvKgo=
--0000000000007b8fd5061ed35927--

