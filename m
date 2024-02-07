Return-Path: <linux-fsdevel+bounces-10558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB284C467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45604286029
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E614AAD;
	Wed,  7 Feb 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9aBX96Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4D1CD19;
	Wed,  7 Feb 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707283980; cv=none; b=Xr9TSgD0IorJmTQRjAY7haxrhEkG43jDyDAICNpCR6uEwlh3dzrBgfIEKHxKFgTeWpL2+l92j3DVN1WMH+RidRbkgAvre8mIVIMdnVvh9Hv+3Hs6ZobvJ9LmSd6E8J7278di5z6qtBKRdAOxTenroTrwljOgwKz1r6SDYXk8cxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707283980; c=relaxed/simple;
	bh=guMBVRQHGG0qxxUyAG6ee8EyN1XPviMW+AUr2V1FdLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYQ+Jno5MQUPP79DzDJOqyPvYo+KppZvLI5krm39Jeu9ROgmuaueUp7XarbzGX7d4SdxJfvE8rWc4olXYM7MqefIRY7teRSVzUEK2woGfSzZKE76O0ES8GMgL/YmxBz4UEfEql2fO/mH0XnaNxFjsxnkNg162ozCb0tkgUhQQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9aBX96Y; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51160efad36so257468e87.1;
        Tue, 06 Feb 2024 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707283976; x=1707888776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkWin/HAkaF6yQxizHGzkRtK5pLw1KHFW//VvZBadcM=;
        b=T9aBX96YEWBAn68z1DKiEOs4l2D2NxEUI9io39BYklwRpDsT0ygIkfxWPMvXsKLlaS
         TwD+ja0eEvr7NjUqA28jFv9qVkdQvSrSMET6Xf8IdzQICRSmr6ba4VAYJz5KYrUyBw3J
         jf57exUvfB88n1aJ5fyUAL/ly9Tul7nKf1yBeIomG/11YtOYCvrxNYYFDUizJwYaY9AR
         VKDfeL3a9WpDjYmtG7iRZrSvLVEav1sJ61iu7Q/4n/GZM/+suFd/MMFWF8Dn6iuJK5H9
         fmuftlz/Lk2Li3fNmbcxwVaf/KKL5OIilJsYEkMj+kzPWYN3w0yPIHOkVKMnfP5F82nC
         XykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707283976; x=1707888776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkWin/HAkaF6yQxizHGzkRtK5pLw1KHFW//VvZBadcM=;
        b=GlJa1lWcuMRCwmD8TwR3mKG8wTKtih6gput4YRyQa2zqmf2HBlyO+E2a8VINjUOcDW
         Sx9AbRU6efPFp+pyvOXZOhGm4LO8bv2nujsMFfSS+BMCkDlq7agWQRc80+OA8pKkWOCI
         E4GtaaUH5QqH3jJROJyjVKfp/ajbavbmZSM4+/3sxKLaoHOwuv4sOwO+ou2S25zxPJQr
         RxCwMFK3ItSDVnF6HoWOpkkHbIjgjIHdmSJ3YzygC3bEIkIDE+myTtM1UPnmgxDSK2T9
         gFKvG72J9Rf9t6Wl5sGIgKSZgDGPNwBkg1WqFXZe/y7HJrjp8pb4hjVQ5CblUsGk6ZYm
         5IQA==
X-Gm-Message-State: AOJu0YyoJxQCSkOnqsf0kLQqN1XncvxetzuPVGX6z1fwCwlGaF27c/rQ
	WrUobnK5FXhRKZ0azJLfjtaOYlogatLpYF5IydsZwsAg8ECCDW5JYSh3SSLFeVqK6lpeL8E5etM
	4jBiw38VNmsfp6NA4TnDy5nQilX4=
X-Google-Smtp-Source: AGHT+IEw9UVfDZ2wHMuAQR1IQISU5kAX5hV3C+H82tbsD0JT/qsiL+IFfYqKNM2HSRgEdPyiPH1lis8LjzT+I4FeBo4=
X-Received: by 2002:ac2:560b:0:b0:511:4a6e:862b with SMTP id
 v11-20020ac2560b000000b005114a6e862bmr3290788lfd.43.1707283976023; Tue, 06
 Feb 2024 21:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
In-Reply-To: <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 6 Feb 2024 23:32:44 -0600
Message-ID: <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000ec10380610c40670"

--000000000000ec10380610c40670
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attached updated patch which also adds check to make sure max write
size is at least 4K

On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> > his netfslib work looks like quite a big refactor. Is there any plans t=
o land this in 6.8? Or will this be 6.9 / later?
>
> I don't object to putting them in 6.8 if there was additional review
> (it is quite large), but I expect there would be pushback, and am
> concerned that David's status update did still show some TODOs for
> that patch series.  I do plan to upload his most recent set to
> cifs-2.6.git for-next later in the week and target would be for
> merging the patch series would be 6.9-rc1 unless major issues were
> found in review or testing
>
> On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> <matthew.ruffell@canonical.com> wrote:
> >
> > I have bisected the issue, and found the commit that introduces the pro=
blem:
> >
> > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Mon Jan 24 21:13:24 2022 +0000
> > Subject: cifs: Change the I/O paths to use an iterator rather than a pa=
ge list
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> >
> > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > v6.3-rc1~136^2~7
> >
> > David, I also tried your cifs-netfs tree available here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/l=
og/?h=3Dcifs-netfs
> >
> > This tree solves the issue. Specifically:
> >
> > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Fri Oct 6 18:29:59 2023 +0100
> > Subject: cifs: Cut over to using netfslib
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> >
> > This netfslib work looks like quite a big refactor. Is there any plans =
to land this in 6.8? Or will this be 6.9 / later?
> >
> > Do you have any suggestions on how to fix this with a smaller delta in =
6.3 -> 6.8-rc3 that the stable kernels can use?
> >
> > Thanks,
> > Matthew
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--000000000000ec10380610c40670
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Disposition: attachment; 
	filename="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsbcsgcy0>
X-Attachment-Id: f_lsbcsgcy0

RnJvbSBmMmNhODYyZGViZDhiOTg3NWI1NDQ4NTUzYmUwZjIxNzhmYzQyMzFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgNiBGZWIgMjAyNCAxNjozNDoyMiAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjogRml4IHJlZ3Jlc3Npb24gaW4gd3JpdGVzIHdoZW4gbm9uLXN0YW5kYXJkIG1heGltdW0gd3Jp
dGUKIHNpemUgbmVnb3RpYXRlZAoKVGhlIGNvbnZlcnNpb24gdG8gbmV0ZnMgaW4gdGhlIDYuMyBr
ZXJuZWwgY2F1c2VkIGEgcmVncmVzc2lvbiB3aGVuCm1heGltdW0gd3JpdGUgc2l6ZSBpcyBzZXQg
YnkgdGhlIHNlcnZlciB0byBhbiB1bmV4cGVjdGVkIHZhbHVlIHdoaWNoIGlzCm5vdCBhIG11bHRp
cGxlIG9mIDQwOTYgKHNpbWlsYXJseSBpZiB0aGUgdXNlciBvdmVycmlkZXMgdGhlIG1heGltdW0K
d3JpdGUgc2l6ZSBieSBzZXR0aW5nIG1vdW50IHBhcm0gIndzaXplIiwgYnV0IHNldHMgaXQgdG8g
YSB2YWx1ZSB0aGF0CmlzIG5vdCBhIG11bHRpcGxlIG9mIDQwOTYpLiAgV2hlbiBuZWdvdGlhdGVk
IHdyaXRlIHNpemUgaXMgbm90IGEKbXVsdGlwbGUgb2YgNDA5NiB0aGUgbmV0ZnMgY29kZSBjYW4g
c2tpcCB0aGUgZW5kIG9mIHRoZSBmaW5hbApwYWdlIHdoZW4gZG9pbmcgbGFyZ2Ugc2VxdWVudGlh
bCB3cml0ZXMsIGNhdXNpbmcgZGF0YSBjb3JydXB0aW9uLgoKVGhpcyBzZWN0aW9uIG9mIGNvZGUg
aXMgYmVpbmcgcmV3cml0dGVuL3JlbW92ZWQgZHVlIHRvIGEgbGFyZ2UKbmV0ZnMgY2hhbmdlLCBi
dXQgdW50aWwgdGhhdCBwb2ludCAoaWUgZm9yIHRoZSA2LjMga2VybmVsIHVudGlsIG5vdykKd2Ug
Y2FuIG5vdCBzdXBwb3J0IG5vbi1zdGFuZGFyZCBtYXhpbXVtIHdyaXRlIHNpemVzLgoKQWRkIGEg
d2FybmluZyBpZiBhIHVzZXIgc3BlY2lmaWVzIGEgd3NpemUgb24gbW91bnQgdGhhdCBpcyBub3QK
YSBtdWx0aXBsZSBvZiA0MDk2LCBhbmQgYWxzbyBhZGQgYSBjaGFuZ2Ugd2hlcmUgd2Ugcm91bmQg
ZG93biB0aGUKbWF4aW11bSB3cml0ZSBzaXplIGlmIHRoZSBzZXJ2ZXIgbmVnb3RpYXRlcyBhIHZh
bHVlIHRoYXQgaXMgbm90CmEgbXVsdGlwbGUgb2YgNDA5NiAod2UgYWxzbyBoYXZlIHRvIGNoZWNr
IHRvIG1ha2Ugc3VyZSB0aGF0CndlIGRvIG5vdCByb3VuZCBpdCBkb3duIHRvIHplcm8pLgoKUmVw
b3J0ZWQtYnk6IFIuIERpZXoiIDxyZGllei0yMDA2QHJkMTAuZGU+CkZpeGVzOiBkMDgwODlmNjQ5
YTAgKCJjaWZzOiBDaGFuZ2UgdGhlIEkvTyBwYXRocyB0byB1c2UgYW4gaXRlcmF0b3IgcmF0aGVy
IHRoYW4gYSBwYWdlIGxpc3QiKQpTdWdnZXN0ZWQtYnk6IFJvbm5pZSBTYWhsYmVyZyA8cm9ubmll
c2FobGJlcmdAZ21haWwuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjMrCkNj
OiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2
ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL2NsaWVudC9jb25u
ZWN0LmMgICAgfCAxMyArKysrKysrKysrKy0tCiBmcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyB8
ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jb25uZWN0LmMgYi9mcy9zbWIvY2xpZW50L2Nv
bm5lY3QuYwppbmRleCBiZmQ1NjhmODk3MTAuLjQ2YjNhZWViZmJmMiAxMDA2NDQKLS0tIGEvZnMv
c21iL2NsaWVudC9jb25uZWN0LmMKKysrIGIvZnMvc21iL2NsaWVudC9jb25uZWN0LmMKQEAgLTM0
MzgsOCArMzQzOCwxNyBAQCBpbnQgY2lmc19tb3VudF9nZXRfdGNvbihzdHJ1Y3QgY2lmc19tb3Vu
dF9jdHggKm1udF9jdHgpCiAJICogdGhlIHVzZXIgb24gbW91bnQKIAkgKi8KIAlpZiAoKGNpZnNf
c2ItPmN0eC0+d3NpemUgPT0gMCkgfHwKLQkgICAgKGNpZnNfc2ItPmN0eC0+d3NpemUgPiBzZXJ2
ZXItPm9wcy0+bmVnb3RpYXRlX3dzaXplKHRjb24sIGN0eCkpKQotCQljaWZzX3NiLT5jdHgtPndz
aXplID0gc2VydmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpOworCSAgICAoY2lm
c19zYi0+Y3R4LT53c2l6ZSA+IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwgY3R4
KSkpIHsKKwkJY2lmc19zYi0+Y3R4LT53c2l6ZSA9IHJvdW5kX2Rvd24oc2VydmVyLT5vcHMtPm5l
Z290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpLCA0MDk2KTsKKwkJLyoKKwkJICogaW4gdGhlIHZlcnkg
dW5saWtlbHkgZXZlbnQgdGhhdCB0aGUgc2VydmVyIHNlbnQgYSBtYXggd3JpdGUgc2l6ZSB1bmRl
ciA0SywKKwkJICogKHdoaWNoIHdvdWxkIGdldCByb3VuZGVkIGRvd24gdG8gMCkgdGhlbiByZXNl
dCB3c2l6ZSB0byBhYnNvbHV0ZSBtaW5pbXVtIGllIDQwOTYKKwkJICovCisJCWlmIChjaWZzX3Ni
LT5jdHgtPndzaXplID09IDApIHsKKwkJCWNpZnNfc2ItPmN0eC0+d3NpemUgPSA0MDk2OworCQkJ
Y2lmc19kYmcoVkZTLCAid3NpemUgdG9vIHNtYWxsLCByZXNldCB0byBtaW5pbXVtIGllIDQwOTZc
biIpOworCQl9CisJfQogCWlmICgoY2lmc19zYi0+Y3R4LT5yc2l6ZSA9PSAwKSB8fAogCSAgICAo
Y2lmc19zYi0+Y3R4LT5yc2l6ZSA+IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfcnNpemUodGNvbiwg
Y3R4KSkpCiAJCWNpZnNfc2ItPmN0eC0+cnNpemUgPSBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3Jz
aXplKHRjb24sIGN0eCk7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyBi
L2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jCmluZGV4IDUyY2JlZjJlZWIyOC4uNjAwYTc3MDUy
YzNiIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYworKysgYi9mcy9zbWIv
Y2xpZW50L2ZzX2NvbnRleHQuYwpAQCAtMTExMSw2ICsxMTExLDggQEAgc3RhdGljIGludCBzbWIz
X2ZzX2NvbnRleHRfcGFyc2VfcGFyYW0oc3RydWN0IGZzX2NvbnRleHQgKmZjLAogCWNhc2UgT3B0
X3dzaXplOgogCQljdHgtPndzaXplID0gcmVzdWx0LnVpbnRfMzI7CiAJCWN0eC0+Z290X3dzaXpl
ID0gdHJ1ZTsKKwkJaWYgKHJvdW5kX3VwKGN0eC0+d3NpemUsIDQwOTYpICE9IGN0eC0+d3NpemUp
CisJCQljaWZzX2RiZyhWRlMsICJ3c2l6ZSBzaG91bGQgYmUgYSBtdWx0aXBsZSBvZiA0MDk2XG4i
KTsKIAkJYnJlYWs7CiAJY2FzZSBPcHRfYWNyZWdtYXg6CiAJCWN0eC0+YWNyZWdtYXggPSBIWiAq
IHJlc3VsdC51aW50XzMyOwotLSAKMi40MC4xCgo=
--000000000000ec10380610c40670--

