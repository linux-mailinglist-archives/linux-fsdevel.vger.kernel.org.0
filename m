Return-Path: <linux-fsdevel+bounces-49795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F94AC2AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1236A4373C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C041F583D;
	Fri, 23 May 2025 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjEfejj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE8125B2;
	Fri, 23 May 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032232; cv=none; b=TYvT8mMTfe6X3b4LnQrUnN96u4I1Kv+Cm83+wDZnmTzAmKeQttybFCIMUje5KiaA12st/D0gxScqiZ0+YhNaiOnKXX++10JJeGkdoRpqeyqj7l7/Lm2zlRJjhV2F0kxtvrTCX0dqJCgQnp4sKWElncA0acbNkArYy/RwFpsNSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032232; c=relaxed/simple;
	bh=XQA+Tr7bUfqoDej4Op8H2jr6eS6aWcyWL1K/qdlBQTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1Hf0TOcq4NHweS9mLYnMjyLMO8VnsRA0eGHzOQRVr4lHY84LuqcsPe/2+Lk1uEC7+fjlhgT/J1q0Ex+xCj3hUVGbiogUL/B6DPlTWH6TC+hI9DLsNZrcbYQ52a7uw4N07MLADmK/LMLC9UqQXsHfo5f3PdR6S7x4fibLMU+E+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBjEfejj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6021b8b2c5fso490241a12.2;
        Fri, 23 May 2025 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748032229; x=1748637029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kltAxpJRzjBWJWHMeN0PQBedydfMxSN7vatLxuE8igA=;
        b=lBjEfejjB93MDrR8vKRaG8YWHdQm2Cutd+l4Pru0Nyc5FhDpF68bvSU2IfuPXG3dOh
         u7sLi1GWFXXS7iTgej7pWhd5EPqhvlVcKQN+KtXKULr2P+QLZavLU29y3bjxiC4nWXfR
         lgR362ahhp1SRsy50c+aRJ+kH4xnU7BvZzmKp9zLSal24DOhi8lChnvA2THMAECb6aur
         5Tlz5XRuB4HIf9N5KhiGcD7HP+rgGXEl+1NISvo38jQhjKWZ8lHYxtSpZawk2tPMGiLx
         JiXjlHGzVU6lsBCXYBPrKEC2DnYIQ5FPrymJ/g9A930grUQteZOPDYwKiJ8j/14JNfd6
         33RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748032229; x=1748637029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kltAxpJRzjBWJWHMeN0PQBedydfMxSN7vatLxuE8igA=;
        b=F8NYJ+CJX9fWs4DSxm7+j6sQyNbUUyjHqbfZt8lCAaD3/2S2kRX6qKN6WQ6O5XB5iv
         jyaRlGG4g8Qg2bd52eu+9t53itfTKeEFW2zDeCavSNYMEsU4M69qBRlzXs/ztQxi5a75
         zM1jbrPvhlw0oYlBHAfC/XKtsYaaV5WjhLxYcaDGsx1dWTy9qNurfDfdemcs9R76iego
         SOxTqqf/X6Pbn1fuTqK4LSW9X/uKHjmCv0/gTYl876PRk4tfjIeWXGWmwzEKU0FM4Aev
         2AfZWkRkQalSMT80gQN69mi7nW3gXOg3NZrf+zamM1T2jTo6pghGMDLl5YLk76FtM/Ve
         6VLw==
X-Forwarded-Encrypted: i=1; AJvYcCU5CpnUJV3VdkVlNgfydXDnUVSFOhlQwGsC9Y2QvaqjYsp8jJC6+1/3UMhCTcrifwgqqbpv+TLXbPjP50Evcw==@vger.kernel.org, AJvYcCVYe8cqDeNVrJKVmybXij3lTX945sujCD+jqUMx/zWy71Pl+uXOz3jXmfk6L4lP+EdFGnhuhqt5jreTMtzALA==@vger.kernel.org, AJvYcCVypAP8FRXOrqMb23pwVvxP8LVMpiFvGeQrNJ3ML13hsOU8B52hilQWiqLq1xI9zAIwl/wuHEGpHz+MvR/S@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6wI61lmBSTgtIrkShnKLKKvML0U4GY6wcEg9yaA9byg5lyyT
	SKEzV7Hv3iJsnoMncI54FfnUMBtIDMZMnKg5hILN5ruZcDF9qNLnQD+37oV/50a+4+5uBXBX7nr
	Q7tm0CbmZLWKYxM4AmhLNeuoTbYLOFRM=
X-Gm-Gg: ASbGncvgEPiWYEbRsYUE9HobawysEIQW6mMb9fHYEEk9xnZTrYgel2rtO3lessPDtGk
	Pzr4dDQOxKwYZw8F4MoiIRMoN/nMipIdnnAVOAProauigVEmokiDzEN59lrkshvLoVg8MWE5Z+3
	ay8JaFs0j3ugJGrWAQIbSUh04VOHcAczc2
X-Google-Smtp-Source: AGHT+IHdNEu5ZtN7sRoZ2p1fYDNKebgIQrjSRxvomdYiv+c3i6sR9JnHEidDzQOpS3vjPJFYi9d/qZfv3fSaGZKhXPY=
X-Received: by 2002:a17:906:99c2:b0:ad2:4144:2329 with SMTP id
 a640c23a62f3a-ad85b1205c3mr46674366b.7.1748032228573; Fri, 23 May 2025
 13:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka> <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
In-Reply-To: <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 23 May 2025 22:30:16 +0200
X-Gm-Features: AX0GCFs6i3n_AyjzI8sOM9D1AyTj0Oz9Ow31viIhZu2EEBawM6DdmFpgqjD1KWo
Message-ID: <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: multipart/mixed; boundary="0000000000000a76270635d378f6"

--0000000000000a76270635d378f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 7:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, May 23, 2025 at 4:10=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, May 20, 2025 at 04:33:14PM +0200, Amir Goldstein wrote:
> > > I am saying that IMO a smaller impact (and less user friendly) fix is=
 more
> > > appropriate way to deal with this problem.
> >
> > What do you think about doing your approach as a stopgap?
> >
> > It seems this is hitting a lot of people, something we can backport to
> > 6.15 would be good to have.
>
> Yes, I think I can do that.
> Will try to get to it next week.
>

On second look, here is a compile-basic-sanity-tested patch.

Care to test if it does the job for you?

Thanks,
Amir.

--0000000000000a76270635d378f6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-support-casefolded-filesystems.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-support-casefolded-filesystems.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mb1966vo0>
X-Attachment-Id: f_mb1966vo0

RnJvbSA5ZmQ5Y2UwZTJiNmRlODRiMzY2NWVkNzQzYjM2MzQ4MDA2NzM5Y2QzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDIzIE1heSAyMDI1IDIyOjEzOjE4ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiBzdXBwb3J0IGNhc2Vmb2xkZWQgZmlsZXN5c3RlbXMKCkNhc2UgZm9sZGluZyBpcyBvZnRlbiBh
cHBsaWVkIHRvIHN1YnRyZWVzIGFuZCBub3Qgb24gYW4gZW50aXJlCmZpbGVzeXN0ZW0uCgpEaXNh
bGxvd2luZyBsYXllcnMgZnJvbSBmaWxlc3lzdGVtcyB0aGF0IHN1cHBvcnQgY2FzZSBmb2xkaW5n
IGlzIG92ZXIKbGltaXRpbmcuCgpSZXBsYWNlIHRoZSBydWxlIHRoYXQgY2FzZS1mb2xkaW5nIGNh
cGFibGUgYXJlIG5vdCBhbGxvd2VkIGFzIGxheWVycwp3aXRoIGEgcnVsZSB0aGF0IGNhc2UgZm9s
ZGVkIGRpcmVjdG9yaWVzIGFyZSBub3QgYWxsb3dlZCBpbiBhIG1lcmdlZApkaXJlY3Rvcnkgc3Rh
Y2suCgpTaG91bGQgY2FzZSBmb2xkaW5nIGJlIGVuYWJsZWQgb24gYW4gdW5kZXJseWluZyBkaXJl
Y3Rvcnkgd2hpbGUKb3ZlcmxheWZzIGlzIG1vdW50ZWQgdGhlIG91dGNvbWUgaXMgZ2VuZXJhbGx5
IHVuZGVmaW5lZC4KClNwZWNpZmljYWxseSBpbiBvdmxfbG9va3VwKCksIHdlIGNoZWNrIHRoZSBi
YXNlIHVuZGVybHlpbmcgZGlyZWN0b3J5CmFuZCBmYWlsIHdpdGggLUVTVEFMRSBpZiBhbiB1bmRl
cmx5aW5nIGRpcmVjdG9yeSBjYXNlIGZvbGRpbmcgaXMKZW5hYmxlZC4KClN1Z2dlc3RlZC1ieTog
S2VudCBPdmVyc3RyZWV0IDxrZW50Lm92ZXJzdHJlZXRAbGludXguZGV2PgpMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjUwNTIwMDUxNjAwLjE5MDMzMTktMS1r
ZW50Lm92ZXJzdHJlZXRAbGludXguZGV2LwpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8
YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL292ZXJsYXlmcy9uYW1laS5jICB8IDEwICsrKysr
KysrKysKIGZzL292ZXJsYXlmcy9wYXJhbXMuYyB8IDEwICsrKystLS0tLS0KIGZzL292ZXJsYXlm
cy91dGlsLmMgICB8IDE1ICsrKysrKysrKysrLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvbmFt
ZWkuYyBiL2ZzL292ZXJsYXlmcy9uYW1laS5jCmluZGV4IGQ0ODllODBmZWI2Zi4uNTE2OGI3MmQ5
NzEwIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvbmFtZWkuYworKysgYi9mcy9vdmVybGF5ZnMv
bmFtZWkuYwpAQCAtMjM3LDYgKzIzNywxNiBAQCBzdGF0aWMgaW50IG92bF9sb29rdXBfc2luZ2xl
KHN0cnVjdCBkZW50cnkgKmJhc2UsIHN0cnVjdCBvdmxfbG9va3VwX2RhdGEgKmQsCiAJYm9vbCBp
c191cHBlciA9IGQtPmxheWVyLT5pZHggPT0gMDsKIAljaGFyIHZhbDsKIAorCS8qCisJICogV2Ug
YWxsb3cgZmlsZXN5c3RlbXMgdGhhdCBhcmUgY2FzZS1mb2xkaW5nIGNhcGFibGUgYnV0IGRlbnkg
Y29tcG9zaW5nCisJICogb3ZsIHN0YWNrIGZyb20gY2FzZS1mb2xkZWQgZGlyZWN0b3JpZXMuIElm
IHNvbWVvbmUgaGFzIGVuYWJsZWQgY2FzZQorCSAqIGZvbGRpbmcgb24gYSBkaXJlY3Rvcnkgb24g
dW5kZXJseWluZyBsYXllciwgdGhlIHdhcnJhbnR5IG9mIHRoZSBvdmwKKwkgKiBzdGFjayBpcyB2
b2lkZWQuCisJICovCisJZXJyID0gLUVTVEFMRTsKKwlpZiAoc2JfaGFzX2VuY29kaW5nKGJhc2Ut
PmRfc2IpICYmIElTX0NBU0VGT0xERUQoZF9pbm9kZShiYXNlKSkpCisJCWdvdG8gb3V0OworCiAJ
dGhpcyA9IG92bF9sb29rdXBfcG9zaXRpdmVfdW5sb2NrZWQoZCwgbmFtZSwgYmFzZSwgbmFtZWxl
biwgZHJvcF9uZWdhdGl2ZSk7CiAJaWYgKElTX0VSUih0aGlzKSkgewogCQllcnIgPSBQVFJfRVJS
KHRoaXMpOwpkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL3BhcmFtcy5jIGIvZnMvb3ZlcmxheWZz
L3BhcmFtcy5jCmluZGV4IGY0MjQ4OGMwMTk1Ny4uMzBjZDcxNDViMjM0IDEwMDY0NAotLS0gYS9m
cy9vdmVybGF5ZnMvcGFyYW1zLmMKKysrIGIvZnMvb3ZlcmxheWZzL3BhcmFtcy5jCkBAIC0yODIs
MTMgKzI4MiwxMSBAQCBzdGF0aWMgaW50IG92bF9tb3VudF9kaXJfY2hlY2soc3RydWN0IGZzX2Nv
bnRleHQgKmZjLCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwKIAkJcmV0dXJuIGludmFsZmMoZmMs
ICIlcyBpcyBub3QgYSBkaXJlY3RvcnkiLCBuYW1lKTsKIAogCS8qCi0JICogUm9vdCBkZW50cmll
cyBvZiBjYXNlLWluc2Vuc2l0aXZlIGNhcGFibGUgZmlsZXN5c3RlbXMgbWlnaHQKLQkgKiBub3Qg
aGF2ZSB0aGUgZGVudHJ5IG9wZXJhdGlvbnMgc2V0LCBidXQgc3RpbGwgYmUgaW5jb21wYXRpYmxl
Ci0JICogd2l0aCBvdmVybGF5ZnMuICBDaGVjayBleHBsaWNpdGx5IHRvIHByZXZlbnQgcG9zdC1t
b3VudAotCSAqIGZhaWx1cmVzLgorCSAqIEFsbG93IGZpbGVzeXN0ZW1zIHRoYXQgYXJlIGNhc2Ut
Zm9sZGluZyBjYXBhYmxlIGJ1dCBkZW55IGNvbXBvc2luZworCSAqIG92bCBzdGFjayBmcm9tIGNh
c2UtZm9sZGVkIGRpcmVjdG9yaWVzLgogCSAqLwotCWlmIChzYl9oYXNfZW5jb2RpbmcocGF0aC0+
bW50LT5tbnRfc2IpKQotCQlyZXR1cm4gaW52YWxmYyhmYywgImNhc2UtaW5zZW5zaXRpdmUgY2Fw
YWJsZSBmaWxlc3lzdGVtIG9uICVzIG5vdCBzdXBwb3J0ZWQiLCBuYW1lKTsKKwlpZiAoc2JfaGFz
X2VuY29kaW5nKHBhdGgtPm1udC0+bW50X3NiKSAmJiBJU19DQVNFRk9MREVEKGRfaW5vZGUocGF0
aC0+ZGVudHJ5KSkpCisJCXJldHVybiBpbnZhbGZjKGZjLCAiY2FzZS1pbnNlbnNpdGl2ZSBkaXJl
Y3Rvcnkgb24gJXMgbm90IHN1cHBvcnRlZCIsIG5hbWUpOwogCiAJaWYgKG92bF9kZW50cnlfd2Vp
cmQocGF0aC0+ZGVudHJ5KSkKIAkJcmV0dXJuIGludmFsZmMoZmMsICJmaWxlc3lzdGVtIG9uICVz
IG5vdCBzdXBwb3J0ZWQiLCBuYW1lKTsKZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy91dGlsLmMg
Yi9mcy9vdmVybGF5ZnMvdXRpbC5jCmluZGV4IGRjY2NiNGI0YTY2Yy4uNTkzYzRkYTEwN2Q2IDEw
MDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvdXRpbC5jCisrKyBiL2ZzL292ZXJsYXlmcy91dGlsLmMK
QEAgLTIwNiwxMCArMjA2LDE3IEBAIGJvb2wgb3ZsX2RlbnRyeV93ZWlyZChzdHJ1Y3QgZGVudHJ5
ICpkZW50cnkpCiAJaWYgKCFkX2Nhbl9sb29rdXAoZGVudHJ5KSAmJiAhZF9pc19maWxlKGRlbnRy
eSkgJiYgIWRfaXNfc3ltbGluayhkZW50cnkpKQogCQlyZXR1cm4gdHJ1ZTsKIAotCXJldHVybiBk
ZW50cnktPmRfZmxhZ3MgJiAoRENBQ0hFX05FRURfQVVUT01PVU5UIHwKLQkJCQkgIERDQUNIRV9N
QU5BR0VfVFJBTlNJVCB8Ci0JCQkJICBEQ0FDSEVfT1BfSEFTSCB8Ci0JCQkJICBEQ0FDSEVfT1Bf
Q09NUEFSRSk7CisJaWYgKGRlbnRyeS0+ZF9mbGFncyAmIChEQ0FDSEVfTkVFRF9BVVRPTU9VTlQg
fCBEQ0FDSEVfTUFOQUdFX1RSQU5TSVQpKQorCQlyZXR1cm4gdHJ1ZTsKKworCS8qCisJICogQWxs
b3cgZmlsZXN5c3RlbXMgdGhhdCBhcmUgY2FzZS1mb2xkaW5nIGNhcGFibGUgYnV0IGRlbnkgY29t
cG9zaW5nCisJICogb3ZsIHN0YWNrIGZyb20gY2FzZS1mb2xkZWQgZGlyZWN0b3JpZXMuCisJICov
CisJaWYgKHNiX2hhc19lbmNvZGluZyhkZW50cnktPmRfc2IpKQorCQlyZXR1cm4gSVNfQ0FTRUZP
TERFRChkX2lub2RlKGRlbnRyeSkpOworCisJcmV0dXJuIGRlbnRyeS0+ZF9mbGFncyAmIChEQ0FD
SEVfT1BfSEFTSCB8IERDQUNIRV9PUF9DT01QQVJFKTsKIH0KIAogZW51bSBvdmxfcGF0aF90eXBl
IG92bF9wYXRoX3R5cGUoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQotLSAKMi4zNC4xCgo=
--0000000000000a76270635d378f6--

