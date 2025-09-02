Return-Path: <linux-fsdevel+bounces-60017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CFB40E50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B187A514D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF071343D8C;
	Tue,  2 Sep 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cUBDM08O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364B30C629
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843512; cv=none; b=BEOYQjClo4aFM3AIIS8Z7sLK9Dxzt1vx36o9zSE72z9FDN5+McL4lIKEWwstQ2etBloYP6meTsFPidzwETGQR0XqbLgprmoZBELQbb43qZWekVacBp7rRlYY34bSlmWzR9LZ7UFlSlQf2FYLPnGyS2q8GWyCbzAuA3T65cwZrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843512; c=relaxed/simple;
	bh=KTjA3fKWIFWRVRBiXglZvWBxA/z++UC8H4eVQyQYv+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6gNPr+OqJjxUUA6BAaM6tDHLlh2x6XU9lHlQS9OliQKXiaUqaq87cwEl3IQGo7C5YRDq0zgkWIXWezX9LCSeUniKPfJwnUQt3/LUPLhZ0UcQrtF3//XwvBG0GP9cJy2ZOOIr2pCNsqBmtPmz7uXQ7hWegVZjp58YGqUtfPqxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cUBDM08O; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0439098469so346668566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756843508; x=1757448308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p78aXGUzBIUJNpn+xNLwzOKLx5M8rja/5vuublf4r3A=;
        b=cUBDM08OHpTSw7C2JnPum8KHCsvhRvNxDnKo5SIodeY0o0A4OuiLcWNI/u4ztF9YZf
         xwtsq14KeRDm/aWi7fVNn78sVXx3s7EGB5i/Jgd4JsqOvveDsrDedYTbeNge7im6nARC
         +w4JPEt6hgTcveg/bCT2t9U7a13FgzHOc2ArA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756843508; x=1757448308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p78aXGUzBIUJNpn+xNLwzOKLx5M8rja/5vuublf4r3A=;
        b=klLiBa6hgYhqI27MgS9IXjptBOIzWZfUQlU0F0EtpsI6O2ntBcctdbGTPw1d1eQo6E
         YZmF/F1icDhINxB0jAwvYpRT2p6KEfaowLSktlpk/ytw/A3rXN+z3SQw0acr4MTg5KS1
         zxJvG/GojWp1US16DyT1TU9S5KtOJEJeHWkbMZjshuQJMSZ/2gvvTq8sTDavl3FSf4Zw
         C5ReFU6/1/4hUFl/sqNpx0FM6PRSoX3DfLyQdiBe8egEB3phbJkJKDGFMJ3QOVN2iDvN
         4vDA5syqCS9p1Gr/G3pQfGv1Yv4eGKEljKTP8iz5JkhIvj3zDlIW4jNha98M7BLlQAbM
         d/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVkz+V4OouGHronuQ2/DcmnTCiQbNzqmrk7KNhQu0J0rXLbrBKGEk578gXxqaGrb8FtnmeItyBIyp5D8GAg@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQeX7kb6sti54PKpweNnyIcdBRZpZp4c0MjpJJZSrh5i47Ook
	BcOm+a7Uj/TNFJDqs6A2RTdnYJ65ky4trOGuRxWjWZ6sMvZU308GLSEb6knYSLZqtumK4EF1Bfr
	vnvQHqGs=
X-Gm-Gg: ASbGncvOxEqyPPjdTApSdNBugNQhauH6ACZvLjHDzTc2bachGCrP/Sp5QRJZeVuvhGP
	8L2vZNXPCfuux+9dSHYPwb2hvzyMWHX+TKNts6/oU46iaKAl+WWs5YooCTA9weC8UAeb3jdn86x
	ecEMwPr5G70Sp9BQPxs7bWVoVIdSNg2kVqOazwn2/d4V5ecMZNF4mydTsnumsszKn9iaCTvwfVx
	lNSBd/2KYNWMDevwzO291wb5smJphFUiPJnwnVXbPbClpmXqVZD3aJBRPsv+6ZKXz7GNbki67oT
	AS14FNFIXZ8M8ct6MSA8FfCYXLSztdzy1mZshfVCwpNB5pj4J7+ZODCplGiZHDWiXp34hiMzTyx
	nS0xV9FCzKxU+b8HHVXIraOX4nvp3m1MrNvy0C1UnaIu6qsffcIU4h4Ob0z9JU/rsatI44sBxMX
	1hWlaHV+I=
X-Google-Smtp-Source: AGHT+IFlwaseMMQHb3ElOYLh4pGTMn6hnAS0mXvYkZcCFEeXPsxyjSAwaCj0ZsKZKdugNJc9svc/mQ==
X-Received: by 2002:a17:906:aad6:b0:b04:2160:f61f with SMTP id a640c23a62f3a-b04216100ecmr755359066b.37.1756843507891;
        Tue, 02 Sep 2025 13:05:07 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b045e576edbsm109707966b.75.2025.09.02.13.05.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 13:05:05 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0428b537e5so431876566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 13:05:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRyFtiuPZ9No4X3KbvgGqNGXmG9kWh+p9XyjWgd/fAkITF4ZXWgc7iKFnObImJjwmLYbDpx2wGi0gOqDdm@vger.kernel.org
X-Received: by 2002:a17:907:80c:b0:af9:a5f8:2f0c with SMTP id
 a640c23a62f3a-b01d8c9275bmr1227617066b.28.1756843505375; Tue, 02 Sep 2025
 13:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk> <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV> <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV> <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner> <20250829163717.GD39973@ZenIV>
 <20250830043624.GE39973@ZenIV> <20250830073325.GF39973@ZenIV>
 <CAHk-=wiSNJ4yBYoLoMgF1M2VRrGfjqJZzem=RAjKhK8W=KohzQ@mail.gmail.com>
 <ed70bad5-c1a8-409f-981e-5ca7678a3f08@gotplt.org> <CAHk-=whb6Jpj-w4GKkY2XccG2DQ4a2thSH=bVNXhbTG8-V+FSQ@mail.gmail.com>
 <663880.1756835288@warthog.procyon.org.uk>
In-Reply-To: <663880.1756835288@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Sep 2025 13:04:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wju8XTW6MntZQ7HX2dCTtyrTb9oVCP3p60vtBhZebMA4g@mail.gmail.com>
X-Gm-Features: Ac12FXyJyQJKsFsjP0XKW9i6TlOoQpDlMhextpNZFtutXFYRniH57P4BLOhg93Q
Message-ID: <CAHk-=wju8XTW6MntZQ7HX2dCTtyrTb9oVCP3p60vtBhZebMA4g@mail.gmail.com>
Subject: Re: [RFC] does # really need to be escaped in devnames?
To: David Howells <dhowells@redhat.com>
Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, Ian Kent <raven@themaw.net>, 
	Christian Brauner <brauner@kernel.org>, Jeffrey Altman <jaltman@auristor.com>, linux-afs@lists.infradead.org
Content-Type: multipart/mixed; boundary="000000000000117490063dd7017f"

--000000000000117490063dd7017f
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 10:48, David Howells <dhowells@redhat.com> wrote:
>
> The problem with that is that it appears that people are making use of this.

Ok. So disallowing it isn't in the cards, but let's try to minimize the impact.

> The standard format of AFS volume names is [%#][<cell>:]<volume-name-or-id>
> but I could make it an option to stick something on the front and use that
> internally and display that in /proc/mounts, e.g.:
>
>         mount afs:#openafs.org:afs.root /mnt

Yeah, let's aim for trying to avoid the '#' at the beginning when all
possible, by trying to make at least the default formats not start
with a hash.

And then make the escaping logic only escape the hashmark if it's the
first character.

> I don't think there should be a problem with still accepting lines beginning
> with '#' in mount() if I display them with an appropriate prefix.  That would
> at least permit backward compatibility.

Well, right now we obviously escape it everywhere, but how about we
make it the rule that 'show_devname()' at least doesn't use it as the
first character, and then if somebody uses '#' for the mount name from
user space, we would just do the octal-escape then.

Something ENTIRELY UNTESTED like this, in other words?

                Linus

--000000000000117490063dd7017f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mf2z8m840>
X-Attachment-Id: f_mf2z8m840

IGZzL2Fmcy9zdXBlci5jICAgICAgfCAyICstCiBmcy9wcm9jX25hbWVzcGFjZS5jIHwgOSArKysr
KysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL2Fmcy9zdXBlci5jIGIvZnMvYWZzL3N1cGVyLmMKaW5kZXggZGE0MDdm
MmQ2ZjBkLi4zMWY5Y2MzMGFlMjMgMTAwNjQ0Ci0tLSBhL2ZzL2Fmcy9zdXBlci5jCisrKyBiL2Zz
L2Fmcy9zdXBlci5jCkBAIC0xODAsNyArMTgwLDcgQEAgc3RhdGljIGludCBhZnNfc2hvd19kZXZu
YW1lKHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0IGRlbnRyeSAqcm9vdCkKIAkJYnJlYWs7CiAJ
fQogCi0Jc2VxX3ByaW50ZihtLCAiJWMlczolcyVzIiwgcHJlZiwgY2VsbC0+bmFtZSwgdm9sdW1l
LT5uYW1lLCBzdWYpOworCXNlcV9wcmludGYobSwgImFmcy0lYyVzOiVzJXMiLCBwcmVmLCBjZWxs
LT5uYW1lLCB2b2x1bWUtPm5hbWUsIHN1Zik7CiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBh
L2ZzL3Byb2NfbmFtZXNwYWNlLmMgYi9mcy9wcm9jX25hbWVzcGFjZS5jCmluZGV4IDVjNTU1ZGI2
OGFhMi4uY2E1NzczYmZiOThlIDEwMDY0NAotLS0gYS9mcy9wcm9jX25hbWVzcGFjZS5jCisrKyBi
L2ZzL3Byb2NfbmFtZXNwYWNlLmMKQEAgLTg2LDcgKzg2LDcgQEAgc3RhdGljIHZvaWQgc2hvd192
ZnNtbnRfb3B0cyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCB2ZnNtb3VudCAqbW50KQogCiBz
dGF0aWMgaW5saW5lIHZvaWQgbWFuZ2xlKHN0cnVjdCBzZXFfZmlsZSAqbSwgY29uc3QgY2hhciAq
cykKIHsKLQlzZXFfZXNjYXBlKG0sIHMsICIgXHRcblxcIyIpOworCXNlcV9lc2NhcGUobSwgcywg
IiBcdFxuXFwiKTsKIH0KIAogc3RhdGljIHZvaWQgc2hvd190eXBlKHN0cnVjdCBzZXFfZmlsZSAq
bSwgc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKQEAgLTExMSw3ICsxMTEsMTIgQEAgc3RhdGljIGlu
dCBzaG93X3Zmc21udChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCB2ZnNtb3VudCAqbW50KQog
CQlpZiAoZXJyKQogCQkJZ290byBvdXQ7CiAJfSBlbHNlIHsKLQkJbWFuZ2xlKG0sIHItPm1udF9k
ZXZuYW1lKTsKKwkJY29uc3QgY2hhciAqbW50X2Rldm5hbWUgPSByLT5tbnRfZGV2bmFtZTsKKwkJ
aWYgKCptbnRfZGV2bmFtZSA9PSAnIycpIHsKKwkJCXNlcV9wcmludGYobSwgIlxcJW8iLCAnIycp
OworCQkJbW50X2Rldm5hbWUrKzsKKwkJfQorCQltYW5nbGUobSwgbW50X2Rldm5hbWUpOwogCX0K
IAlzZXFfcHV0YyhtLCAnICcpOwogCS8qIG1vdW50cG9pbnRzIG91dHNpZGUgb2YgY2hyb290IGph
aWwgd2lsbCBnaXZlIFNFUV9TS0lQIG9uIHRoaXMgKi8K
--000000000000117490063dd7017f--

