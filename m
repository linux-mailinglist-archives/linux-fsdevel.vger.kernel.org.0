Return-Path: <linux-fsdevel+bounces-30083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C5986005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AB51F26365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABD5192B88;
	Wed, 25 Sep 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dhmG5ePW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83501BA87B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266864; cv=none; b=tgLmnpaxY0yw41ziwYbQldrVjg5dFr9/IgN1b6XKqQoOrKl9+PIuL566MY6kE2S1elbCHkypiy3shThD+U3ZbTM0GocWdh3LxB+59/X7LGdeVFfIny7i1FvIYnsg1r9q523+eUjqpqg9xHn4x5uSQJNsvwi3xqKCM4tAG/CRIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266864; c=relaxed/simple;
	bh=ga0Cx7tOBgH57Oelvhci2adrgTr03DDJ8MaBMV+OZAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLLodiGBWxknDCdXQejSnH0tNFxG4bYGAFUV2URQLLMPJy4FgsTSlvzAC9q0KaTHqX8unL7Az/JZuOqIw4rfjg5YmRPTZ3yUq0xTW/GKfTUpS6MDo/psXNC0WTaNETKqMQB1N60TF0tJu86mHP6HO9gsLW/kB9ctyilu7csQyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dhmG5ePW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso1093647866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727266859; x=1727871659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0rovbvcwz17VtlC6RUdTLoxXpB3BKdraf2nzblRa518=;
        b=dhmG5ePWXT7ePvWQiJ8G0pJZYAHWrfAbfYFTMXLFUNwJRM4Y3MjJBdVUmErEvrDsir
         lKmoK2mihW+CF+FtuUmiOHxx1S49N/GzN07O056bdkG5MzkIfovsimBLL5fsh7t5dTc1
         Q6JE7aeTcV2UX/+KwQ0tBpITgzXHJQmQlWDMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727266859; x=1727871659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rovbvcwz17VtlC6RUdTLoxXpB3BKdraf2nzblRa518=;
        b=Q0SDmt1Z1X+hiwwOaxyuAWzR93jyfcDo/EDTKKjVPtvjIz0z8jtusRrX8pYOY72Wpn
         WNt1Ag1I71d4eOC912eQIvGYalik00FXjGhak3BIzCGs/0E/y2MSnfG1mnjqVBaAJmAE
         axYi69pF7+XTed6vejZLv6v5n9q7tmt1n7plceT3bhZgem4LSkCZgPUwT+YP7pbTMuXL
         1z6gozmMGKNTDKrmKMbODi3Sr6AXBl5lZOE+2I9nfoDq8q+fV8mlke3yf5ev9w066Woo
         OsrDCvbYtFEVxaCBq8MfpNdmamEwTAhocwniTE0iMgzuilD4UqTg/1Opz1bSIVoB1Vtt
         VWqA==
X-Forwarded-Encrypted: i=1; AJvYcCWhxSTXRGnFHDjRYF6qykxUgyos74WUTzyCLc+DUyqkccM2uo1kbzizBfoDFzlpPTt+LmqvuMexfkbBZcvE@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8RrtBMizLDfpU6E8s1T31scRATb50Ma0c35S4xsxrsr3Xj3w
	IKXRVHChlWgevNHRpMjXjNTqZpbYbh2DnS9e/AVVcB1WTJQHcl9oYFU9DsX91aI4RBbNyNHkK8M
	HbKE5IYgl4N1+sELhMMO+rgKyu6ohl9urZkFF7A==
X-Google-Smtp-Source: AGHT+IFCQvR9d0jVlhxFf6DFIMpZA9vFvOEqWSC9XlfupIcmTwqiAoxigpaE87BG2i4iMydQ+F9Ft9WlnY2GJp9FdB0=
X-Received: by 2002:a17:907:940d:b0:a8d:2faf:d329 with SMTP id
 a640c23a62f3a-a93a031eb83mr238778266b.2.1727266858548; Wed, 25 Sep 2024
 05:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Sep 2024 14:20:47 +0200
Message-ID: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Laura Promberger <laura.promberger@cern.ch>
Cc: "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: multipart/mixed; boundary="0000000000008976900622f0a76b"

--0000000000008976900622f0a76b
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 16:45, Laura Promberger <laura.promberger@cern.ch> wrote:

> - But for corrupted symlinks `fuse_change_attributes()` exits before `fuse_change_attributes_common()` is called and as such the length stays the old one.

The reason is that the attr_version check fails.  The trace logs show
a zero attr_version value, which suggests that the check can not fail.
But we know that fuse_dentry_revalidate() supplies a non-zero
attr_version to fuse_change_attributes() and if there's a racing
fuse_reverse_inval_inode() which updates the fuse_inode's
attr_version, then it would result in fuse_change_attributes() exiting
before updating the cached attributes, which is what you observe.

This is probably okay, as the cached attributes remain invalid and the
next call to fuse_change_attributes() will likely update the inode
with the correct values.

The reason this causes problems is that cached symlinks will be
returned through page_get_link(), which truncates the symlink to
inode->i_size.  This is correct for filesystems that don't mutate
symlinks, but for cvmfs it causes problems.

My proposed solution would be to just remove this truncation.  This
can cause a regression in a filesystem that relies on supplying a
symlink larger than the file size, but this is unlikely.   If that
happens we'd need to make this behavior conditional.

Can you please try the  attached patch?

Thanks,
Miklos

--0000000000008976900622f0a76b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-fix-cached-symlink-size-limiting.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-cached-symlink-size-limiting.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1hth9lg0>
X-Attachment-Id: f_m1hth9lg0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IDU0MTA0ZGQ0
OGFmNy4uNzBmYjU3NzE0Zjc5IDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1
c2UvZGlyLmMKQEAgLTE2MzIsNyArMTYzMiw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpmdXNlX2dl
dF9saW5rKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGlub2RlICppbm9kZSwKIAkJZ290
byBvdXRfZXJyOwogCiAJaWYgKGZjLT5jYWNoZV9zeW1saW5rcykKLQkJcmV0dXJuIHBhZ2VfZ2V0
X2xpbmsoZGVudHJ5LCBpbm9kZSwgY2FsbGJhY2spOworCQlyZXR1cm4gcGFnZV9nZXRfbGlua19y
YXcoZGVudHJ5LCBpbm9kZSwgY2FsbGJhY2spOwogCiAJZXJyID0gLUVDSElMRDsKIAlpZiAoIWRl
bnRyeSkKZGlmZiAtLWdpdCBhL2ZzL25hbWVpLmMgYi9mcy9uYW1laS5jCmluZGV4IDRhNGEyMmEw
OGFjMi4uNjc5NTYwMGM1NzM4IDEwMDY0NAotLS0gYS9mcy9uYW1laS5jCisrKyBiL2ZzL25hbWVp
LmMKQEAgLTUzMDAsMTAgKzUzMDAsOSBAQCBjb25zdCBjaGFyICp2ZnNfZ2V0X2xpbmsoc3RydWN0
IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgZGVsYXllZF9jYWxsICpkb25lKQogRVhQT1JUX1NZTUJP
TCh2ZnNfZ2V0X2xpbmspOwogCiAvKiBnZXQgdGhlIGxpbmsgY29udGVudHMgaW50byBwYWdlY2Fj
aGUgKi8KLWNvbnN0IGNoYXIgKnBhZ2VfZ2V0X2xpbmsoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBz
dHJ1Y3QgaW5vZGUgKmlub2RlLAotCQkJICBzdHJ1Y3QgZGVsYXllZF9jYWxsICpjYWxsYmFjaykK
K3N0YXRpYyBjaGFyICpfX3BhZ2VfZ2V0X2xpbmsoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1
Y3QgaW5vZGUgKmlub2RlLAorCQkJICAgICBzdHJ1Y3QgZGVsYXllZF9jYWxsICpjYWxsYmFjaykK
IHsKLQljaGFyICprYWRkcjsKIAlzdHJ1Y3QgcGFnZSAqcGFnZTsKIAlzdHJ1Y3QgYWRkcmVzc19z
cGFjZSAqbWFwcGluZyA9IGlub2RlLT5pX21hcHBpbmc7CiAKQEAgLTUzMjIsOCArNTMyMSwyMyBA
QCBjb25zdCBjaGFyICpwYWdlX2dldF9saW5rKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0
IGlub2RlICppbm9kZSwKIAl9CiAJc2V0X2RlbGF5ZWRfY2FsbChjYWxsYmFjaywgcGFnZV9wdXRf
bGluaywgcGFnZSk7CiAJQlVHX09OKG1hcHBpbmdfZ2ZwX21hc2sobWFwcGluZykgJiBfX0dGUF9I
SUdITUVNKTsKLQlrYWRkciA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsKLQluZF90ZXJtaW5hdGVfbGlu
ayhrYWRkciwgaW5vZGUtPmlfc2l6ZSwgUEFHRV9TSVpFIC0gMSk7CisJcmV0dXJuIHBhZ2VfYWRk
cmVzcyhwYWdlKTsKK30KKworY29uc3QgY2hhciAqcGFnZV9nZXRfbGlua19yYXcoc3RydWN0IGRl
bnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAorCQkJICAgICAgc3RydWN0IGRlbGF5
ZWRfY2FsbCAqY2FsbGJhY2spCit7CisJcmV0dXJuIF9fcGFnZV9nZXRfbGluayhkZW50cnksIGlu
b2RlLCBjYWxsYmFjayk7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChwYWdlX2dldF9saW5rX3Jhdyk7
CisKK2NvbnN0IGNoYXIgKnBhZ2VfZ2V0X2xpbmsoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1
Y3QgaW5vZGUgKmlub2RlLAorCQkJCQlzdHJ1Y3QgZGVsYXllZF9jYWxsICpjYWxsYmFjaykKK3sK
KwljaGFyICprYWRkciA9IF9fcGFnZV9nZXRfbGluayhkZW50cnksIGlub2RlLCBjYWxsYmFjayk7
CisKKwlpZiAoIUlTX0VSUihrYWRkcikpCisJCW5kX3Rlcm1pbmF0ZV9saW5rKGthZGRyLCBpbm9k
ZS0+aV9zaXplLCBQQUdFX1NJWkUgLSAxKTsKIAlyZXR1cm4ga2FkZHI7CiB9CiAKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaAppbmRleCBlYWU1YjY3
ZTRhMTUuLmZjOTBkMWY2ZThjNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oCisrKyBi
L2luY2x1ZGUvbGludXgvZnMuaApAQCAtMzMxNiw2ICszMzE2LDggQEAgZXh0ZXJuIGNvbnN0IHN0
cnVjdCBmaWxlX29wZXJhdGlvbnMgZ2VuZXJpY19yb19mb3BzOwogCiBleHRlcm4gaW50IHJlYWRs
aW5rX2NvcHkoY2hhciBfX3VzZXIgKiwgaW50LCBjb25zdCBjaGFyICopOwogZXh0ZXJuIGludCBw
YWdlX3JlYWRsaW5rKHN0cnVjdCBkZW50cnkgKiwgY2hhciBfX3VzZXIgKiwgaW50KTsKK2V4dGVy
biBjb25zdCBjaGFyICpwYWdlX2dldF9saW5rX3JhdyhzdHJ1Y3QgZGVudHJ5ICosIHN0cnVjdCBp
bm9kZSAqLAorCQkJCSAgICAgc3RydWN0IGRlbGF5ZWRfY2FsbCAqKTsKIGV4dGVybiBjb25zdCBj
aGFyICpwYWdlX2dldF9saW5rKHN0cnVjdCBkZW50cnkgKiwgc3RydWN0IGlub2RlICosCiAJCQkJ
IHN0cnVjdCBkZWxheWVkX2NhbGwgKik7CiBleHRlcm4gdm9pZCBwYWdlX3B1dF9saW5rKHZvaWQg
Kik7Cg==
--0000000000008976900622f0a76b--

