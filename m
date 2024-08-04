Return-Path: <linux-fsdevel+bounces-24931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F9946B88
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 02:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026942822CA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894B37E;
	Sun,  4 Aug 2024 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D3vidQLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10718E
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722729959; cv=none; b=bp75AgjHIwQKv4ldux8XmC91J2/empZfQSTzcwC7a1MeDFQQu+PzhQ0L6La+DWZlEuBhUaQj/xArswjreWPBU3E6jjYzX7HKiuaGxvj6wWBAElMmot5HV0Y+3fON7L+O0ZCkWCOVgGrI2ckgq95eQr25pfzTIK9Q2JwtgGv4rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722729959; c=relaxed/simple;
	bh=scWXKaWeNQ09XrOGU8mypZx9tAumxi/sK8daQCpPTA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqPo7x1EL3cHllo7MCED2UrozjxOrX6AfAgwmslWadNfSNV9KdtjrV1XcpxztxdpFG92lRVCefRf3U6pGcHA+j5EfnWs860IHohWhlz9e6E7AXLKhjZIoP1yWCwe8cuM6k2unuJ5XZxWLCymAwUbPEHftre9dJtyb057S7tpjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D3vidQLw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a728f74c23dso1197295166b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722729956; x=1723334756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lv3nA0eJFU5L8o663Pxx6s3G/6BxYG0Et8AWdrhc0s=;
        b=D3vidQLwjDVo8n1TUn+NRfp3xu4RH1X+a32FzH4QibzQIgzPYpA/g7rrVux5ymSNCg
         PntCg/tdS5KzrHU8gdtpgFcPG3SkDOQt52KH3EQXQjWOFN/ozFoYmFBPZkgwit2CVtkl
         R6RzLkxEBV+J/VPY0GBWIA5m6zw0k/v7RiXRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722729956; x=1723334756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lv3nA0eJFU5L8o663Pxx6s3G/6BxYG0Et8AWdrhc0s=;
        b=t4lk452INU5mzjevVrycLPsF1pe3qooGT3IZrZGQJv2+onEly2tht/nHNfSIermzIu
         szEe6JhdbTMMQg/0NxuYQ7gPh6Np7OfSHZ1asUmizGFgIjpQ//ZbJC0SAygTBCquSRlu
         y6rK+181iCgZGZo2xXl5R81iY39BOSU/wDqsSB4to6S0LaMdDD1UQJ0iAj7pvMq3WWbU
         Ysdl6RxUzRaFonfyyyLmXPHcd9lIRZBRNUmW/olp53JLUpSGARaWlvVxoUx1zoywIEC2
         O+T5q7XQbK7U5OENCKYCPz8vvdziq4O0JJAiIJXq2lpFzif3Fq4UPGgw+MjXMMgJRzGM
         CJug==
X-Forwarded-Encrypted: i=1; AJvYcCXvIL9TpsuzCTNGUUevEdU8ereUiY3KUpvQsNZFcbZM7MCHlileatengeNJ0jGubvpp1eKn/LMuMb7452aPFarmxsjzzf8APkw+U0yWTg==
X-Gm-Message-State: AOJu0YxASpmg0SKaJJWA+yHqjSLR3vXYBri8Q3c2oT5pmr0lCXY0X4IK
	Lbvi7Xl57sN2wSgKjJlAC6wJ2MBRbLhaERf2Qlr96mmxfOMNlCLWPk3l2WT3lGUAl5IPh8PEbRB
	WqH8Mow==
X-Google-Smtp-Source: AGHT+IHoXRSNZagZF4fn3kGcgQ01bIa0BiIex58wxoeyHyUEkrfM/PNrpYmbzaIDFS8MtLWhbOr98Q==
X-Received: by 2002:a17:907:1c21:b0:a7a:be06:d8dc with SMTP id a640c23a62f3a-a7dc506c4d7mr552038166b.48.1722729955519;
        Sat, 03 Aug 2024 17:05:55 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3cb3sm268667166b.27.2024.08.03.17.05.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 17:05:54 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso11815319a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 17:05:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAuXJkLjMA4aXx53BPXFkj8my0AJociPnn3kVKqvPggZ04N8kVwnY+HyQ133mHiBuvFP95f9/uaYLry8s5JxR7j5KP1u1i57PyH8ISaA==
X-Received: by 2002:aa7:cd69:0:b0:58c:804a:6ee2 with SMTP id
 4fb4d7f45d1cf-5b7f4294a1emr5233629a12.20.1722729954550; Sat, 03 Aug 2024
 17:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803225054.GY5334@ZenIV> <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
In-Reply-To: <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Aug 2024 17:05:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgavzxOQv1LD6KV2gbenDxOcSU_C=pcHBq8LVJVPPmiXQ@mail.gmail.com>
Message-ID: <CAHk-=wgavzxOQv1LD6KV2gbenDxOcSU_C=pcHBq8LVJVPPmiXQ@mail.gmail.com>
Subject: Re: [PATCH] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fc61dd061ed052c9"

--000000000000fc61dd061ed052c9
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Aug 2024 at 16:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In fact, I think the full_fds_bits copy in copy_fd_bitmaps() should
> just be entirely rewritten. Even the initial copy shouldn't be done
> with some byte-wise memcpy/memset, since those are all 'unsigned long'
> arrays, and the size is aligned. So it should be done on words, but
> whatever.
>
> And the full_fds_bits case should use our actual bitmap functions.

Something ENTIRELY UNTESTED like this, IOW.

Am I just completely off my rocker? You decide.

                 Linus

--000000000000fc61dd061ed052c9
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lzesx9nf0>
X-Attachment-Id: f_lzesx9nf0

IGZzL2ZpbGUuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9maWxlLmMgYi9mcy9maWxlLmMKaW5kZXggYTExZTU5YjVkNjAyLi5lYTdmOTM4OTA1ZjMgMTAw
NjQ0Ci0tLSBhL2ZzL2ZpbGUuYworKysgYi9mcy9maWxlLmMKQEAgLTQ2LDI3ICs0NiwzNiBAQCBz
dGF0aWMgdm9pZCBmcmVlX2ZkdGFibGVfcmN1KHN0cnVjdCByY3VfaGVhZCAqcmN1KQogI2RlZmlu
ZSBCSVRCSVRfTlIobnIpCUJJVFNfVE9fTE9OR1MoQklUU19UT19MT05HUyhucikpCiAjZGVmaW5l
IEJJVEJJVF9TSVpFKG5yKQkoQklUQklUX05SKG5yKSAqIHNpemVvZihsb25nKSkKIAorc3RhdGlj
IGlubGluZSB2b2lkIGNvcHlfYml0bWFwX3dvcmRzKHVuc2lnbmVkIGxvbmcgKmRzdCwgdW5zaWdu
ZWQgbG9uZyAqc3JjLAorCXVuc2lnbmVkIGludCBjb3B5LCB1bnNpZ25lZCBpbnQgY2xlYXIpCit7
CisJbWVtY3B5KGRzdCwgc3JjLCBjb3B5ICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsKKwltZW1z
ZXQoZHN0ICsgY29weSwgMCwgY2xlYXIgKiBzaXplb2YodW5zaWduZWQgbG9uZykpOworfQorCiAv
KgogICogQ29weSAnY291bnQnIGZkIGJpdHMgZnJvbSB0aGUgb2xkIHRhYmxlIHRvIHRoZSBuZXcg
dGFibGUgYW5kIGNsZWFyIHRoZSBleHRyYQogICogc3BhY2UgaWYgYW55LiAgVGhpcyBkb2VzIG5v
dCBjb3B5IHRoZSBmaWxlIHBvaW50ZXJzLiAgQ2FsbGVkIHdpdGggdGhlIGZpbGVzCiAgKiBzcGlu
bG9jayBoZWxkIGZvciB3cml0ZS4KKyAqCisgKiBOb3RlOiB0aGUgZmQgYml0bWFwcyBhcmUgYWx3
YXlzIGZ1bGwgYml0bWFwIHdvcmRzIChzZWUgc2FuZV9mZHRhYmxlX3NpemUoKSksCisgKiBidXQg
dGhlIGZ1bGxfZmRzX2JpdHMgYml0bWFwIGlzIGEgYml0bWFwIG9mIGZkIGJpdG1hcCB3b3Jkcywg
bm90IG9mIGZkcy4KICAqLwogc3RhdGljIHZvaWQgY29weV9mZF9iaXRtYXBzKHN0cnVjdCBmZHRh
YmxlICpuZmR0LCBzdHJ1Y3QgZmR0YWJsZSAqb2ZkdCwKIAkJCSAgICB1bnNpZ25lZCBpbnQgY291
bnQpCiB7Ci0JdW5zaWduZWQgaW50IGNweSwgc2V0OworCXVuc2lnbmVkIGludCBjb3B5LCBjbGVh
cjsKIAotCWNweSA9IGNvdW50IC8gQklUU19QRVJfQllURTsKLQlzZXQgPSAobmZkdC0+bWF4X2Zk
cyAtIGNvdW50KSAvIEJJVFNfUEVSX0JZVEU7Ci0JbWVtY3B5KG5mZHQtPm9wZW5fZmRzLCBvZmR0
LT5vcGVuX2ZkcywgY3B5KTsKLQltZW1zZXQoKGNoYXIgKiluZmR0LT5vcGVuX2ZkcyArIGNweSwg
MCwgc2V0KTsKLQltZW1jcHkobmZkdC0+Y2xvc2Vfb25fZXhlYywgb2ZkdC0+Y2xvc2Vfb25fZXhl
YywgY3B5KTsKLQltZW1zZXQoKGNoYXIgKiluZmR0LT5jbG9zZV9vbl9leGVjICsgY3B5LCAwLCBz
ZXQpOworCWNvcHkgPSBjb3VudCAvIEJJVFNfUEVSX0xPTkc7CisJY2xlYXIgPSAobmZkdC0+bWF4
X2ZkcyAtIGNvdW50KSAvIEJJVFNfUEVSX0xPTkc7CiAKLQljcHkgPSBCSVRCSVRfU0laRShjb3Vu
dCk7Ci0Jc2V0ID0gQklUQklUX1NJWkUobmZkdC0+bWF4X2ZkcykgLSBjcHk7Ci0JbWVtY3B5KG5m
ZHQtPmZ1bGxfZmRzX2JpdHMsIG9mZHQtPmZ1bGxfZmRzX2JpdHMsIGNweSk7Ci0JbWVtc2V0KChj
aGFyICopbmZkdC0+ZnVsbF9mZHNfYml0cyArIGNweSwgMCwgc2V0KTsKKwkvKiBDb3B5IHRoZSBi
aXRtYXAgd29yZHMgKi8KKwljb3B5X2JpdG1hcF93b3JkcyhuZmR0LT5vcGVuX2Zkcywgb2ZkdC0+
b3Blbl9mZHMsIGNvcHksIGNsZWFyKTsKKwljb3B5X2JpdG1hcF93b3JkcyhuZmR0LT5jbG9zZV9v
bl9leGVjLCBvZmR0LT5jbG9zZV9vbl9leGVjLCBjb3B5LCBjbGVhcik7CisKKwkvKiBDb3B5IHRo
ZSBiaXRzIGZvciB0aGUgd29yZHMgKi8KKwliaXRtYXBfY29weShuZmR0LT5mdWxsX2Zkc19iaXRz
LCBvZmR0LT5mdWxsX2Zkc19iaXRzLCBjb3B5KTsKKwliaXRtYXBfY2xlYXIobmZkdC0+ZnVsbF9m
ZHNfYml0cywgY29weSwgY2xlYXIpOwogfQogCiAvKgo=
--000000000000fc61dd061ed052c9--

