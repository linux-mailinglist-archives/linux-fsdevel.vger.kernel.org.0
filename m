Return-Path: <linux-fsdevel+bounces-12113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738585B5BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0471C21235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7B5F549;
	Tue, 20 Feb 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DA88dLfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5415F542
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418869; cv=none; b=HybjAgc90UbZKXiVI69qaMu5o7CycndGfAz5potND03a5MDlXnXda+cHuVOFKff3cxwsijyTynlgl6IGDSJdE4X/5SwKuYAsobuwogZHaBMJTFAM/kzjpbEPXQqM/qYMC+uC61baruUqf8JbQteJg9lSE4y5S9SrFs288LT7dZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418869; c=relaxed/simple;
	bh=Oe+OnyLGqLMHcNYGavmiBRuDFBBIiWopj3R8HU0bOQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czo1s7X+AY20nzOUaEvhs1AkbBt8SkFTIvzXh6tSCv/6X9RsYaGiPoBv1fgAMfh91A6dNfjHik53RRnyODPYkjvCkB1ReB6DQq7no54wgFhlrfgERjyQiQjf1sMjwMx3tdDW75M4ANEQCsBczqcvhGpAWUHCCMGOEREkHdvFz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DA88dLfX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso6261324a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708418865; x=1709023665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdUlqpS3e9vUqpe0Sf6eYmPB2+T1K+eYKiHKrcBtXVg=;
        b=DA88dLfXi67X3Mpo1ZC1s9F9OtIYR+qNYvE9zEurLhhJ2+BgUB+eRDxaCYh+CtbXAn
         tT2g4n7USH3w2rakTXgPJ/FOyihm53xc7bVtglK4rFZ21V5RUnCnWa9dHTV3N4ARUEy5
         Y0CBfPr9brXv/PXAd17WxJfQ83Y5W1zTVfSrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418865; x=1709023665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdUlqpS3e9vUqpe0Sf6eYmPB2+T1K+eYKiHKrcBtXVg=;
        b=Y49cNOL4riJGOJfgNTgmrVmS/OtPKHerggRz2RZGSwPIhgx5o7bdq+Ay3fb676yxbG
         RlV+/yW4XwFCrMTKHYjmoQppRVSBtKEt6aYU1DlBNJEkvk4mSt3OlyNw4GtU6c4Qlyy4
         6VAg2dzxeYlX4lGD0RGNO3+l8D6MiZ/x6tLkVfY8UwhVqk+wqEnNeogQ5taNirTBBfz0
         ndGwXaS/pKBuE6e09FTUtK8a8e7hCffYIFStfKkZ6emRifo8WuasMitBEMZWm3U8G2m6
         q4ubNnTDuNZq+/v91ug7/N8ucIABaRKPESEVNUXghvAwqicmhlLraVFBx4QmaY+QKyaW
         3rMg==
X-Forwarded-Encrypted: i=1; AJvYcCWANsCrQlpSX/SRI6ZZt+6dcWarNyQ9qCpgExv1BFJirGOsxRMdtsEjgK6lPVqpOOAqsVHdrqKbgwmcde0+Q3C4XHGVXkW3wdWtafCBJA==
X-Gm-Message-State: AOJu0YwVdNMoYmDiFnb/wV3GOLFpBmjyv/Madh8BNCCOR+6lFe2cuzjm
	+yH1rlK8kxgSNjQjY/XUAqTywnDI4QpvlDXSUkfM3cPMsJ+hYsUFiYRQ3QvnaTMlbvi4edeYNkf
	uy8VdAeAnlGosUkezS3mriD9p1mMsG1gRoBMS3Q==
X-Google-Smtp-Source: AGHT+IFNeYJpaGlW4jujl6syDwAkgtksaB4Wce0uEMi+4erGvACpesB9QLMldBwGNqcsaqKXw950jg5H35k0N4AyMp4=
X-Received: by 2002:a17:906:a899:b0:a3e:931d:69c1 with SMTP id
 ha25-20020a170906a89900b00a3e931d69c1mr3494828ejb.56.1708418865374; Tue, 20
 Feb 2024 00:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
In-Reply-To: <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Feb 2024 09:47:34 +0100
Message-ID: <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="000000000000994ab40611cc43aa"

--000000000000994ab40611cc43aa
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 09:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 19 Feb 2024 at 20:54, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> >
> > On 2/19/24 13:38, Miklos Szeredi wrote:
> > > On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> > >
> > >> This is what I see from the kernel:
> > >>
> > >> lookup(nodeid=3, name=.);
> > >> lookup(nodeid=3, name=..);
> > >> lookup(nodeid=1, name=dir2);
> > >> lookup(nodeid=1, name=..);
>
>
> Can you please try the attached patch?

Sorry, missing one hunk from the previous patch.  Here's an updated one.

Thanks,
Miklos

--000000000000994ab40611cc43aa
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-bad-root-v2.patch"
Content-Disposition: attachment; filename="fuse-fix-bad-root-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsu4gv950>
X-Attachment-Id: f_lsu4gv950

LS0tCiBmcy9mdXNlL2Rpci5jICAgIHwgICAgMiArLQogZnMvZnVzZS9mdXNlX2kuaCB8ICAgIDMg
KystCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCi0t
LSBhL2ZzL2Z1c2UvZGlyLmMKKysrIGIvZnMvZnVzZS9kaXIuYwpAQCAtMTIxMCw3ICsxMjEwLDcg
QEAgc3RhdGljIGludCBmdXNlX2RvX3N0YXR4KHN0cnVjdCBpbm9kZSAqaQogCWlmICgoKHN4LT5t
YXNrICYgU1RBVFhfU0laRSkgJiYgIWZ1c2VfdmFsaWRfc2l6ZShzeC0+c2l6ZSkpIHx8CiAJICAg
ICgoc3gtPm1hc2sgJiBTVEFUWF9UWVBFKSAmJiAoIWZ1c2VfdmFsaWRfdHlwZShzeC0+bW9kZSkg
fHwKIAkJCQkJIGlub2RlX3dyb25nX3R5cGUoaW5vZGUsIHN4LT5tb2RlKSkpKSB7Ci0JCW1ha2Vf
YmFkX2lub2RlKGlub2RlKTsKKwkJZnVzZV9tYWtlX2JhZChpbm9kZSk7CiAJCXJldHVybiAtRUlP
OwogCX0KIAotLS0gYS9mcy9mdXNlL2Z1c2VfaS5oCisrKyBiL2ZzL2Z1c2UvZnVzZV9pLmgKQEAg
LTkzOSw3ICs5MzksOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZnVzZV9zdGFsZV9pbm9kZShjb25z
CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBmdXNlX21ha2VfYmFkKHN0cnVjdCBpbm9kZSAqaW5vZGUp
CiB7Ci0JcmVtb3ZlX2lub2RlX2hhc2goaW5vZGUpOworCWlmIChnZXRfZnVzZV9pbm9kZShpbm9k
ZSktPm5vZGVpZCAhPSBGVVNFX1JPT1RfSUQpCisJCXJlbW92ZV9pbm9kZV9oYXNoKGlub2RlKTsK
IAlzZXRfYml0KEZVU0VfSV9CQUQsICZnZXRfZnVzZV9pbm9kZShpbm9kZSktPnN0YXRlKTsKIH0K
IAo=
--000000000000994ab40611cc43aa--

