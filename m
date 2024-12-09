Return-Path: <linux-fsdevel+bounces-36868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562529EA21E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 23:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1FC284966
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473CB1991C8;
	Mon,  9 Dec 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eTEnmG/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0262C9A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784565; cv=none; b=qrWn13kMnyn3crunB0e/R6yaXMIz48PpkNWr0HrHmpIt+30HvdvTkOtZ0FAa02bqtimCVgohuNjSSytoTeKRs8L0xbZyrnBCTClCogcosrCOa+48r8yIEnIWJjodvsElXueyB6TbEL/eiN6iWqFsrTzhjE6cgFTMaJS7oPai3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784565; c=relaxed/simple;
	bh=tDyHT31d2NdKLYrtFVoM00AlQLkdV5jtbdTnlX7x0YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyjUiME6pZXwGP9NWrweYymFshvbxcOPIGQAgng0eMfYVgU+d7L+qqbaetvInxzSV25UbtKRvZQT5d7Xmq8hm+wa+DjPsOp14gwwzZX/UO3C4gMZbVBpHp4Hapc6aRHyF80f/c/3wkTI91lkaeLfY8zDp/9WhjSO0uSeZ0oB3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eTEnmG/M; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa69251292dso239999566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733784561; x=1734389361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cx4qOMTCamPzVs94CAH4cBnCLSfjA8LtF8kWWOrrq2U=;
        b=eTEnmG/Mfl/uHddc7vq5ezehum9VSD3TQRQn06BIaWWyJ/IjzXGS5mAViNz/LaLdNo
         cmBEjltujnxDUiZYTNSjfzppsNF6OR/WDCrHmw59iKUgR3iszVH08KYms96qw8gUayL5
         xn7hWWYVemKQQm3HX+VhHi2C1qny3AWWOipdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784561; x=1734389361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cx4qOMTCamPzVs94CAH4cBnCLSfjA8LtF8kWWOrrq2U=;
        b=IFYIIERpvWAQfh7Q4orTw5a5KraSucSVlH9F4idKejp1SGSrYyuVd1hzeGqxSFn6vp
         lL+pbj7HEYEX9PlJUzRJ8a6MjAzO3l8CeLjC1C6sjnyFHmkt4oKjpbqIfjE0wFWPxzOq
         AuLB43mg1+b7g+BQZTJ04TC8w9zgC7NBzNhllojlD0WQnJ68e3pkXDrOpb7/U5rodfiN
         ov357c9PfsoF7XDx6UU4eG9zyYS6lHI6U6742fa/+TMhsjYPo6B0a0vyvWZ1Tg3gDJ34
         ALpDtnEg8LN2g52ONhXz+tgy3ObAAs8z3QyO4zpFt8JPYpiMdqVfSZMiOw6JYq6M7tXg
         M6Fg==
X-Gm-Message-State: AOJu0YxDX/7Z9M0o46voMAL5WlN0YVm4ZlKiZsJTDXaqSkiDLh7OX0DS
	wMhdZP+HkPNTRuEf+/xFRsQfEqZMgBFr+UABAWRkIVuryMlp0rBnp/aZaIi7KVK5nKpUdzjZSWb
	nj/c=
X-Gm-Gg: ASbGncshpZHCDMc/tsjhUUNOxvOL8AWucMxfoCyYm21w/19SKkbZuNcLh/R2rAplhls
	xK/T/WSqUUb9k/EFMG4g6oBGollsWrgA0QdD5qI7i52s5g7leZagewHchSfc6YYnIY9uG+iIjTP
	c3zU0R1GXBx0oK7bd5bvk0mJQEk+iHx0hDYGa2cRr63aKUZn8QrxQkvDK/EaXljHtAotfbJdjUT
	CU4B5WfYecVAXeviziYKAoQQQt7gp4wo4roCSZyUKELbtQvJtNZsRr94WTUxXAHaZ8+46wWQ1OF
	q+9VrCuUi7MT7QGgthhI1QYe14RF
X-Google-Smtp-Source: AGHT+IGh/qAJ37Vtv6p0uA6TtMGaWtk4hLvSpEujNkvZqmI3ITezPlkMy1SlT9nFqpPQd8QdBjo2oQ==
X-Received: by 2002:a17:906:1baa:b0:aa6:85a4:31f8 with SMTP id a640c23a62f3a-aa685a433f9mr527361766b.33.1733784561061;
        Mon, 09 Dec 2024 14:49:21 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa693ac1346sm148387566b.198.2024.12.09.14.49.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 14:49:20 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so567551266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 14:49:20 -0800 (PST)
X-Received: by 2002:a17:906:3cb2:b0:aa6:423c:8502 with SMTP id
 a640c23a62f3a-aa6423c885fmr1193176666b.60.1733784559854; Mon, 09 Dec 2024
 14:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209035251.GV3387508@ZenIV> <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV> <20241209222854.GB3387508@ZenIV>
In-Reply-To: <20241209222854.GB3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Dec 2024 14:49:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
Message-ID: <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cef6ea0628de2c08"

--000000000000cef6ea0628de2c08
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 14:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Do you have any objections to the diff below?

I'd split it up a bit more, and in particular, I think I'd want
DNAME_INLINE_LEN to be defined in terms of the long-words, rather than
doing it the other way around with that

        BUILD_BUG_ON(DNAME_INLINE_LEN != sizeof(struct short_name_store));

IOW, I'd *start* with something like the attached, and then build on that..

(By all means turn that

        unsigned long d_iname_words[DNAME_INLINE_WORDS];

into a struct so that you can then do the struct assignment for it - I
just hate the pattern of starting with a byte size and then doing
"DNAME_INLINE_LEN / sizeof(unsigned long)".

Hmm?

            Linus

--000000000000cef6ea0628de2c08
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m4hmhf2x0>
X-Attachment-Id: f_m4hmhf2x0

IGZzL2RjYWNoZS5jICAgICAgICAgICAgfCAgMiArLQogaW5jbHVkZS9saW51eC9kY2FjaGUuaCB8
IDEzICsrKysrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9kY2FjaGUuYyBiL2ZzL2RjYWNoZS5jCmluZGV4
IGI0ZDVlOWUxZTQzZC4uZDZhNDUxMzI1MTMzIDEwMDY0NAotLS0gYS9mcy9kY2FjaGUuYworKysg
Yi9mcy9kY2FjaGUuYwpAQCAtMzE5Niw3ICszMTk2LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGRj
YWNoZV9pbml0KHZvaWQpCiAJICovCiAJZGVudHJ5X2NhY2hlID0gS01FTV9DQUNIRV9VU0VSQ09Q
WShkZW50cnksCiAJCVNMQUJfUkVDTEFJTV9BQ0NPVU5UfFNMQUJfUEFOSUN8U0xBQl9BQ0NPVU5U
LAotCQlkX2luYW1lKTsKKwkJZF9pbmFtZV93b3Jkcyk7CiAKIAkvKiBIYXNoIG1heSBoYXZlIGJl
ZW4gc2V0IHVwIGluIGRjYWNoZV9pbml0X2Vhcmx5ICovCiAJaWYgKCFoYXNoZGlzdCkKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvZGNhY2hlLmggYi9pbmNsdWRlL2xpbnV4L2RjYWNoZS5oCmlu
ZGV4IGJmZjk1NmY3YjJiOS4uMGRhYWVjZDUzMzUzIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L2RjYWNoZS5oCisrKyBiL2luY2x1ZGUvbGludXgvZGNhY2hlLmgKQEAgLTY4LDE1ICs2OCwxNyBA
QCBleHRlcm4gY29uc3Qgc3RydWN0IHFzdHIgZG90ZG90X25hbWU7CiAgKiBsYXJnZSBtZW1vcnkg
Zm9vdHByaW50IGluY3JlYXNlKS4KICAqLwogI2lmZGVmIENPTkZJR182NEJJVAotIyBkZWZpbmUg
RE5BTUVfSU5MSU5FX0xFTiA0MCAvKiAxOTIgYnl0ZXMgKi8KKyMgZGVmaW5lIEROQU1FX0lOTElO
RV9XT1JEUyA1IC8qIDE5MiBieXRlcyAqLwogI2Vsc2UKICMgaWZkZWYgQ09ORklHX1NNUAotIyAg
ZGVmaW5lIEROQU1FX0lOTElORV9MRU4gMzYgLyogMTI4IGJ5dGVzICovCisjICBkZWZpbmUgRE5B
TUVfSU5MSU5FX1dPUkRTIDkgLyogMTI4IGJ5dGVzICovCiAjIGVsc2UKLSMgIGRlZmluZSBETkFN
RV9JTkxJTkVfTEVOIDQ0IC8qIDEyOCBieXRlcyAqLworIyAgZGVmaW5lIEROQU1FX0lOTElORV9X
T1JEUyAxMSAvKiAxMjggYnl0ZXMgKi8KICMgZW5kaWYKICNlbmRpZgogCisjZGVmaW5lIEROQU1F
X0lOTElORV9MRU4gKEROQU1FX0lOTElORV9XT1JEUypzaXplb2YodW5zaWduZWQgbG9uZykpCisK
ICNkZWZpbmUgZF9sb2NrCWRfbG9ja3JlZi5sb2NrCiAKIHN0cnVjdCBkZW50cnkgewpAQCAtODgs
NyArOTAsMTAgQEAgc3RydWN0IGRlbnRyeSB7CiAJc3RydWN0IHFzdHIgZF9uYW1lOwogCXN0cnVj
dCBpbm9kZSAqZF9pbm9kZTsJCS8qIFdoZXJlIHRoZSBuYW1lIGJlbG9uZ3MgdG8gLSBOVUxMIGlz
CiAJCQkJCSAqIG5lZ2F0aXZlICovCi0JdW5zaWduZWQgY2hhciBkX2luYW1lW0ROQU1FX0lOTElO
RV9MRU5dOwkvKiBzbWFsbCBuYW1lcyAqLworCXVuaW9uIHsJCQkJLyogc21hbGwgbmFtZXMgKi8K
KwkJdW5zaWduZWQgbG9uZyBkX2luYW1lX3dvcmRzW0ROQU1FX0lOTElORV9XT1JEU107CisJCURF
Q0xBUkVfRkxFWF9BUlJBWSh1bnNpZ25lZCBjaGFyLCBkX2luYW1lKTsKKwl9OwogCS8qIC0tLSBj
YWNoZWxpbmUgMSBib3VuZGFyeSAoNjQgYnl0ZXMpIHdhcyAzMiBieXRlcyBhZ28gLS0tICovCiAK
IAkvKiBSZWYgbG9va3VwIGFsc28gdG91Y2hlcyBmb2xsb3dpbmcgKi8K
--000000000000cef6ea0628de2c08--

