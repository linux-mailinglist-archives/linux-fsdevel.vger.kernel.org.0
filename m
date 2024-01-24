Return-Path: <linux-fsdevel+bounces-8783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0197C83AF4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A316D283A7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332317E784;
	Wed, 24 Jan 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jle4hcVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE017A721
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116280; cv=none; b=nAQdwtClhe0/8OiL1nwErzEwpSCm3cqmGfiAAyGdHyQu8WEWr4UYMHaP0tc9zvTqdNKGOTPup/AI+OuzW2vOW8dgbWVrkd+qNVryceyLnQSUwxgtfXceUdYBR5xyjIKNSF3c3OEMDiTZiLZ411udo0Txne5LN4h6aJOylQfk5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116280; c=relaxed/simple;
	bh=Kl/HAVfdMhADs0Tsv5S4YUd1uTXeFaa2nCYlPTrHhvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIvyXNTTWshZPZOuy7REdoa0eKlzaZn7dh3WzRN9EEdcvyjDDACC0WOPxFQGWQUSX5yhlkNCLcm36cMH0o5F7fQTEbv4izanOzJUdb+/Tj14IEOA2wnL96JFtmIHklZFth1RCpv7dA9uBUwOmPaIA7Y5++3CKTM94JPpi5Z1BE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jle4hcVd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30d2bd22e7so186033766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706116276; x=1706721076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RzKprHyYfiPaLEeOIvMtbDAp0S6N60JXbJyiLEkNDw=;
        b=Jle4hcVdatlgk0uvxxuzzKqALCGZWizS84SlAupbcBeyoeqSl+dVE53VfDoHXsg9lh
         S7sIwWcJiG0dowztBusIuCPaw2AwRgBMS8dSE/z35w8QEJloxKfyf+4UbD462pjgfdtc
         k5gKMZi1u6DUrkbY0kOw6x9G1X/7fUXoTk6Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116276; x=1706721076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RzKprHyYfiPaLEeOIvMtbDAp0S6N60JXbJyiLEkNDw=;
        b=hMxe8iD3+Y1R6QPAsIabJjpGTXLjOAmut1hHuon94PC8ILOiWrY3KjrrjvcQutIOAw
         CVC6SNYLsHjG8H52JihJHP1oBExCw6suJlBSUvZGJcVphESNbcjmL64tDKY0K+BGjwVA
         2I95+2+haexcPda5ssIF4UyDM61QOHPSX46S5ktdMIkc48s0hleR/9XHmSbEyDk6NzDz
         x6El2BzgF4IwvjzPfLGrCeBnFpKQL1HOMOGe56/BFoNA4hCOXPgv3WKgZFLEVmDd3PRQ
         phGZwGuO7CAsOEIdzh6ElWN2y08c9KwroZx9KW5RRQ0VW3jdnoqFu7l4j340YMiOQ8lk
         LjnQ==
X-Gm-Message-State: AOJu0YyU3XRdXqy4RoghvZ+Jbn6IaCt5w8lSgVjVoTzmyfhM3uPJM+WL
	8lb3UAFmxsv7yK1IQK+zdo3YvYy7I7URsDXrcv81pSuZCevj5mbBH30MUX0qNGqUz/hUjtMk20N
	MrUsqAQ==
X-Google-Smtp-Source: AGHT+IGFPhHALLFZlM0lkfWQ2MbE/OmOI2F5zXRA7QVXfGjQUTBGDh3AxyElLZmvF2Ye91HCecNpww==
X-Received: by 2002:a17:906:3755:b0:a27:af7:bba5 with SMTP id e21-20020a170906375500b00a270af7bba5mr1037004ejc.22.1706116276524;
        Wed, 24 Jan 2024 09:11:16 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id jy21-20020a170907763500b00a2d1b0c7b80sm84764ejc.57.2024.01.24.09.11.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:11:15 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a354a65afso5044696a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 09:11:15 -0800 (PST)
X-Received: by 2002:a05:6402:440d:b0:55c:8a2e:df41 with SMTP id
 y13-20020a056402440d00b0055c8a2edf41mr1934309eda.84.1706116275091; Wed, 24
 Jan 2024 09:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com> <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
In-Reply-To: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 09:10:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Message-ID: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000085dd51060fb42625"

--00000000000085dd51060fb42625
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. That whole thing is disgusting. I think it should have checked
> FMODE_EXEC, and I have no idea why it doesn't.

Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
think it would be even better if we had the 'intent' flags from
'struct open_flags' available, but they aren't there in the
file_open() security chain.

Anyway, moving current->in_execve earlier looks fairly trivial, but I
worry about the randomness. I'd be *so*( much happier if this crazy
flag went away, and it got changed to look at the open intent instead.

Attached patch is ENTIRELY UNTESTED. And disgusting.

I went back and looked. This whole disgusting thing goes back to 2009
and commit f9ce1f1cda8b ("Add in_execve flag into task_struct").

              Linus

--00000000000085dd51060fb42625
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrs1gcul0>
X-Attachment-Id: f_lrs1gcul0

IGZzL2V4ZWMuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9leGVjLmMKaW5kZXgg
OGNkZDViMmRkMDljLi5mYzFkNmJlZmU4MzAgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZWMuYworKysgYi9m
cy9leGVjLmMKQEAgLTE4NDMsNyArMTg0Myw2IEBAIHN0YXRpYyBpbnQgYnBybV9leGVjdmUoc3Ry
dWN0IGxpbnV4X2JpbnBybSAqYnBybSkKIAkgKiB3aGVyZSBzZXR1aWQtbmVzcyBpcyBldmFsdWF0
ZWQuCiAJICovCiAJY2hlY2tfdW5zYWZlX2V4ZWMoYnBybSk7Ci0JY3VycmVudC0+aW5fZXhlY3Zl
ID0gMTsKIAlzY2hlZF9tbV9jaWRfYmVmb3JlX2V4ZWN2ZShjdXJyZW50KTsKIAogCXNjaGVkX2V4
ZWMoKTsKQEAgLTE4NjAsNyArMTg1OSw2IEBAIHN0YXRpYyBpbnQgYnBybV9leGVjdmUoc3RydWN0
IGxpbnV4X2JpbnBybSAqYnBybSkKIAlzY2hlZF9tbV9jaWRfYWZ0ZXJfZXhlY3ZlKGN1cnJlbnQp
OwogCS8qIGV4ZWN2ZSBzdWNjZWVkZWQgKi8KIAljdXJyZW50LT5mcy0+aW5fZXhlYyA9IDA7Ci0J
Y3VycmVudC0+aW5fZXhlY3ZlID0gMDsKIAlyc2VxX2V4ZWN2ZShjdXJyZW50KTsKIAl1c2VyX2V2
ZW50c19leGVjdmUoY3VycmVudCk7CiAJYWNjdF91cGRhdGVfaW50ZWdyYWxzKGN1cnJlbnQpOwpA
QCAtMTg3OSw3ICsxODc3LDYgQEAgc3RhdGljIGludCBicHJtX2V4ZWN2ZShzdHJ1Y3QgbGludXhf
YmlucHJtICpicHJtKQogCiAJc2NoZWRfbW1fY2lkX2FmdGVyX2V4ZWN2ZShjdXJyZW50KTsKIAlj
dXJyZW50LT5mcy0+aW5fZXhlYyA9IDA7Ci0JY3VycmVudC0+aW5fZXhlY3ZlID0gMDsKIAogCXJl
dHVybiByZXR2YWw7CiB9CkBAIC0xOTEwLDYgKzE5MDcsNyBAQCBzdGF0aWMgaW50IGRvX2V4ZWN2
ZWF0X2NvbW1vbihpbnQgZmQsIHN0cnVjdCBmaWxlbmFtZSAqZmlsZW5hbWUsCiAJLyogV2UncmUg
YmVsb3cgdGhlIGxpbWl0IChzdGlsbCBvciBhZ2FpbiksIHNvIHdlIGRvbid0IHdhbnQgdG8gbWFr
ZQogCSAqIGZ1cnRoZXIgZXhlY3ZlKCkgY2FsbHMgZmFpbC4gKi8KIAljdXJyZW50LT5mbGFncyAm
PSB+UEZfTlBST0NfRVhDRUVERUQ7CisJY3VycmVudC0+aW5fZXhlY3ZlID0gMTsKIAogCWJwcm0g
PSBhbGxvY19icHJtKGZkLCBmaWxlbmFtZSwgZmxhZ3MpOwogCWlmIChJU19FUlIoYnBybSkpIHsK
QEAgLTE5NjUsNiArMTk2Myw3IEBAIHN0YXRpYyBpbnQgZG9fZXhlY3ZlYXRfY29tbW9uKGludCBm
ZCwgc3RydWN0IGZpbGVuYW1lICpmaWxlbmFtZSwKIAlmcmVlX2Jwcm0oYnBybSk7CiAKIG91dF9y
ZXQ6CisJY3VycmVudC0+aW5fZXhlY3ZlID0gMDsKIAlwdXRuYW1lKGZpbGVuYW1lKTsKIAlyZXR1
cm4gcmV0dmFsOwogfQpAQCAtMTk4NSw2ICsxOTg0LDcgQEAgaW50IGtlcm5lbF9leGVjdmUoY29u
c3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLAogCWlmIChJU19FUlIoZmlsZW5hbWUpKQogCQlyZXR1
cm4gUFRSX0VSUihmaWxlbmFtZSk7CiAKKwljdXJyZW50LT5pbl9leGVjdmUgPSAxOwogCWJwcm0g
PSBhbGxvY19icHJtKGZkLCBmaWxlbmFtZSwgMCk7CiAJaWYgKElTX0VSUihicHJtKSkgewogCQly
ZXR2YWwgPSBQVFJfRVJSKGJwcm0pOwpAQCAtMjAyNCw2ICsyMDI0LDcgQEAgaW50IGtlcm5lbF9l
eGVjdmUoY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLAogb3V0X2ZyZWU6CiAJZnJlZV9icHJt
KGJwcm0pOwogb3V0X3JldDoKKwljdXJyZW50LT5pbl9leGVjdmUgPSAwOwogCXB1dG5hbWUoZmls
ZW5hbWUpOwogCXJldHVybiByZXR2YWw7CiB9Cg==
--00000000000085dd51060fb42625--

