Return-Path: <linux-fsdevel+bounces-30201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4688987A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 22:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FEFB219DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 20:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9717F4F7;
	Thu, 26 Sep 2024 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D784LKgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB017C9AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382497; cv=none; b=rrKRvIJXwToP7o2XLClrSfpsd0EpqACnjarFKKl/yNuBrhAU1OsUbpU0jGlbgQT5oKpvW+PQ8It/K8UEYNbl3mBRsU6LwHHvlTq9ww7zm9MpGtV5UBwh+f7qdkXdWHKYfz1i8v9Ro+uZNEb6PNhGdpLhYf1y+aTS5XWYmaZcXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382497; c=relaxed/simple;
	bh=pknfZZZQcqqBmnB4YUw1rasAfvsUhrx+hscgFcM1NfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/PvBPmBM5HfW7++axD74SFv7R4jqP4eqX/6SSDUA+bEktZBjDbH+QzoMMTe5/5XWExKtZVgT2dBhwjdg3gKKeAZPJjbVMjl8oN6H+SAKx6G8+Yyar2qeqMOF7Vy4uZcO6bzXW6nKkVbzj3PNkDY0OPbGs79ZAnHvVSWbmzKYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D784LKgZ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25d405f255so933637276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727382495; x=1727987295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pknfZZZQcqqBmnB4YUw1rasAfvsUhrx+hscgFcM1NfM=;
        b=D784LKgZUVuwWeHk9RLw70mzyeyZjmsELTykIc8gVX42Kv5770AK7djvHY7xm858Hn
         KP1qEhBSM5IUGdWqWYtx8HGzgbHcnQW6Oxf5PwjqcLlUJPmYpPA6Clvw46v5NVC8pLxj
         VR/2Qk82SFv618cE+ldy9LU0aPHx0Zg8KJ+dB9heqUCBQ7o4VSrLZuK+F/fRKpXMO3aW
         E+W1VKpGSnTwVhbvtyZqQPQyxoPGnueE+Feotg4+x+fIgRERVsob99HI6PwkwcPbJdsP
         lE6lFNeOiXM9ZhqPAnb522WCD6nrgfmOcwTg2Vi59Nq/z9F+EYT+Gm1q4VwalGoN/ebl
         hx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727382495; x=1727987295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pknfZZZQcqqBmnB4YUw1rasAfvsUhrx+hscgFcM1NfM=;
        b=w9HW8i97cNiIB1AsnCRXlIWWjTiLMzzAwRffEH+MawzvZSpQj5JqB5kp5xcxSk9kp9
         bBFijP+RZ2lNimu4HbFy8gNbj3xk4arPJmDLrI23VoK8PYN4gtCLLQ1nllG5oMtK90la
         p2//DdelLY+VoTB6P8/0PR5T4lNREnwMMqFD9eTMbcqfKv+559Yk91SvInat+k+mixI8
         LJTIk7NZgHJGqDc7OtEL69iNvqAExC+/2vVT7YZB83kTUpTC0NG3mp3zft1Ys9cQ30eE
         EmbFo4g+u1I2vx7ypH0XGrGwFmTtyl+XXjr0KEN5Mf+ES+krMsvaf63UgJ9QJrC/pWqu
         97aw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6EaCyqWu8M87Qo07MhJIDGwpfwS7LT0ltJo7XbmOnmBi5g822DdBRGI0oXz4FGpq7QnU5Rpzi+onhGAp@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbCvorhIc8jMjsXR8tXhfHxUDO8xiguaunEHN/Sjy9zwPY7MG
	C5ZxpclzG7SKoJkfrSZpEJcrwTWSOtH25soyrIuYXnwOYwmLkGXENYfCzuf4fGmi0iZ4oytXE7S
	ogcdnt4cVrCW4Q62/IyWemqyM9l/5dEVsEVM=
X-Google-Smtp-Source: AGHT+IGBDy2RlG2XLotWUmR2bMly7Lt4Vd4mdCIC/hqNHTAu18kx/fUhOHB434FIoE0n7SUspusrRyC/zDShng7K5Q4=
X-Received: by 2002:a05:690c:2848:b0:6db:d5e8:d612 with SMTP id
 00721157ae682-6e247585df5mr7090797b3.23.1727382494998; Thu, 26 Sep 2024
 13:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 22:28:03 +0200
Message-ID: <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: multipart/mixed; boundary="00000000000001b36e06230b9422"

--00000000000001b36e06230b9422
Content-Type: text/plain; charset="UTF-8"

> > What would be the next steps for this investigation ?
> >
>
> I need to find some time and to debug the reason for 9p open failure
> so we can make sure the problem is in 9p code and report more details
> of the bug to 9p maintainers, but since a simple reproducer exists,
> they can also try to reproduce the issue right now.

FWIW, the attached reproducer mimics git clone rename_over pattern closer.
It reproduces fanotify_read() errors sometimes, not always,
with either CLOSE_WRITE or OPEN_PERM | CLOSE_WRITE.
maybe CLOSE_WRITE alone has better odds - I'm not sure.

Thanks,
Amir.

--00000000000001b36e06230b9422
Content-Type: text/x-csrc; charset="US-ASCII"; name="rename_over.c"
Content-Disposition: attachment; filename="rename_over.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m1jqwsjk0>
X-Attachment-Id: f_m1jqwsjk0

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8dW5pc3Rk
Lmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCiNpbmNsdWRlIDxl
cnJuby5oPg0KI2luY2x1ZGUgPHB0aHJlYWQuaD4NCg0KDQp2b2lkICp0aHJlYWQodm9pZCAqcHRy
KQ0Kew0KICAgIGNoYXIgZmlsZW5hbWVbMTBdID0ge307DQogICAgY29uc3QgY2hhciAqbmV3X2Zp
bGVuYW1lID0gImNvbmZpZyI7DQogICAgY29uc3QgY2hhciAqY29udGVudCA9ICJIZWxsbywgdGhp
cyBpcyBhIHRlc3Qgd2l0aCBmaWxlIHJlbmFtZSBvcGVyYXRpb24uXG4iOw0KICAgIGNoYXIgYnVm
ZmVyWzEwMF07DQogICAgaW50IGZkOw0KICAgIHNzaXplX3QgYnl0ZXNfcmVhZDsNCiAgICBpbnQg
Y291bnRlcj0wOw0KDQogICAgZnByaW50ZihzdGRlcnIsIlRocmVhZCAlbGQgc3RhcnRlZFxuIiwg
KGxvbmcpcHRyKTsNCiAgICBzcHJpbnRmKGZpbGVuYW1lLCJjb25maWcuJWxkIiwgKGxvbmcpcHRy
KTsNCg0KcmV0cnk6DQogICAgLy8gQ3JlYXRlIGEgbmV3IGZpbGUgYW5kIHdyaXRlIHRvIGl0DQog
ICAgZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX0VYQ0wsIDA2NDQp
Ow0KICAgIGlmIChmZCA9PSAtMSkgew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byBjcmVhdGUg
ZmlsZSIpOw0KICAgICAgICByZXR1cm4gTlVMTDsNCiAgICB9DQogICAgaWYgKHdyaXRlKGZkLCBj
b250ZW50LCBzdHJsZW4oY29udGVudCkpID09IC0xKSB7DQogICAgICAgIHBlcnJvcigiRmFpbGVk
IHRvIHdyaXRlIHRvIGZpbGUiKTsNCiAgICAgICAgY2xvc2UoZmQpOw0KICAgICAgICByZXR1cm4g
TlVMTDsNCiAgICB9DQogICAgY2xvc2UoZmQpOw0KDQogICAgLy8gUmVuYW1lIHRoZSBmaWxlDQog
ICAgaWYgKHJlbmFtZShmaWxlbmFtZSwgbmV3X2ZpbGVuYW1lKSAhPSAwKSB7DQogICAgICAgIHBl
cnJvcigiRmFpbGVkIHRvIHJlbmFtZSBmaWxlIik7DQogICAgICAgIHJldHVybiBOVUxMOw0KICAg
IH0NCg0KICAgIGZkID0gb3BlbihuZXdfZmlsZW5hbWUsIE9fUkRPTkxZKTsNCg0KICAgIGlmIChm
ZCA9PSAtMSkgew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byBvcGVuIHJlbmFtZWQgZmlsZSIp
Ow0KICAgICAgICByZXR1cm4gTlVMTDsNCiAgICB9DQogICAgYnl0ZXNfcmVhZCA9IHJlYWQoZmQs
IGJ1ZmZlciwgc2l6ZW9mKGJ1ZmZlcikgLSAxKTsNCiAgICBpZiAoYnl0ZXNfcmVhZCA9PSAtMSkg
ew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byByZWFkIGZyb20gZmlsZSIpOw0KICAgICAgICBj
bG9zZShmZCk7DQogICAgICAgIHJldHVybiBOVUxMOw0KICAgIH0NCiAgICBidWZmZXJbYnl0ZXNf
cmVhZF0gPSAnXDAnOyAgLy8gTnVsbC10ZXJtaW5hdGUgdGhlIGJ1ZmZlcg0KICAgIGNsb3NlKGZk
KTsNCg0KICAgIC8vIE9wZW4gdGhlIHJlbmFtZWQgZmlsZSBhbmQgcmVhZCB0aGUgY29udGVudA0K
ICAgIGlmIChjb3VudGVyKysgPCAxMDApDQoJICAgIGdvdG8gcmV0cnk7DQoNCiAgICBwcmludGYo
IkZpbGUgc2F2ZWQgJWQgaXRlcmF0aW9uc1xuIiwgY291bnRlcik7DQoNCiAgICAvLyBQcmludCB0
aGUgY29udGVudA0KICAgIHByaW50ZigiQ29udGVudCBvZiAlczpcbiVzIiwgbmV3X2ZpbGVuYW1l
LCBidWZmZXIpOw0KDQogICAgcmV0dXJuIHB0cjsNCn0NCg0KaW50IG1haW4oKSB7DQogICAgcHRo
cmVhZF90IHRoWzEwXTsNCiAgICBsb25nIGk7DQogICAgZm9yIChpID0gMDsgaSA8IDEwOyBpKysp
DQoJICAgIHB0aHJlYWRfY3JlYXRlKCZ0aFtpXSwgTlVMTCwgKnRocmVhZCwgKHZvaWQgKilpKTsN
Cg0KICAgIGZvciAoaSA9IDA7IGkgPCAxMDsgaSsrKQ0KCSAgICBwdGhyZWFkX2pvaW4odGhbaV0g
LE5VTEwpOw0KDQogICAgcmV0dXJuIEVYSVRfU1VDQ0VTUzsNCn0NCg==
--00000000000001b36e06230b9422--

