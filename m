Return-Path: <linux-fsdevel+bounces-10866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3584EDFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 00:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0995DB29B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51756474;
	Thu,  8 Feb 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU0zvL5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D756458;
	Thu,  8 Feb 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434762; cv=none; b=Tpw8BCGEgZ0IN+QR2Y4W8+MdlJvYLeCt7zxDUGXWb/joVHBsuFrYisGr3aWQG50dUuS+F3H9Ng7MIi0Kad+BXIuXt0BzhlWJp9hlCZ9SYhbhxHIfc0a6Xa/p8WB5ygLFDhI7VDeWd/JzB+Ye/fa9sgy7n/pwonKoka98GTam5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434762; c=relaxed/simple;
	bh=ltOS/Js3Dm6l4sxheTCRdreloaB158cvUG64Xz6J9dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9hO8FmxFbEDZl5t6Mihzl8NhjV1JQWMADfAroaIc/oWHlyPiIo1VzU5aPWKCJJorh7rfgCCpWB+YmKxiVbaT7x8t4HO286GCRWrMrLBYUupEhdpXIeQqDma7zaITewkWZfMKTMdbXdehuvRzmTwxdloIm1+/sw0xRXhuXbOz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU0zvL5z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511689cc22aso577614e87.0;
        Thu, 08 Feb 2024 15:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707434758; x=1708039558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijliBSIb+fWqPQdA69fOELGAiVQKN7CFVcarJ41DoRw=;
        b=IU0zvL5zqaBRb2LW/Xmxuka+CP6zBReH13Xc7+VHTu1Q0soDot2eFr6Ffkfuh3C2Ik
         hoh4IBK+cW8r0frsuwi1PoMmTVAxdM3lVbhaiFXifN7rrcblec9CZIHz7FalNjZd0Q0Z
         cabw9RNAvJagtVUoLdstbSOYLz0qlpOpKLGFtashEvwyHocktvz8v0M8m6P63v9sFUIp
         E3RF+ZLLuvrYZMKZqXxmO9JhojAo1C9x2Rguij+NWbglartSBGT268ZdSsYNALN5PYgu
         T8c7sH3tEBqtVU6uKPFo+ut2Gt/YL8HKnNXO7fFREtqS4h/f8hBDNeI/lpUFqgPNi6Yw
         ZLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707434758; x=1708039558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijliBSIb+fWqPQdA69fOELGAiVQKN7CFVcarJ41DoRw=;
        b=cZlKUkfRtTMzq3RDgFbk5nUpZz+n3RBAwQV7XUQfSxN4xrOiyb5HBTls4rEwl750VP
         Hv5KkHkQ72fmEuH7KTfC8E+82ztFcQPJmojzS5TwHlTxatlkEjhlY0ECOpTj83FtoCwZ
         tJ4Mc2keII+0641gFoPXUTd5vs7vE/p9a1JogyDypALdCcthia9b7TMMWkrC7nAuGayz
         iUq1dXBjhmkyV5qjxfkaNZ7yKkOWYRwybr5RYw2cJUOFgBI18KeLXTA6s/JiePHdb8Km
         3TxtZpBxwh+ZAB7ltJtGaJJmF1/ZGgkVY1gG7bcdRAVQA4/ft6qNd8GvxznQ3LRAvEpG
         4OWw==
X-Forwarded-Encrypted: i=1; AJvYcCXg4SokhEC4QvuNQbAX9UBD0tlrPbtJZF9TZhAUuL5cO8jXVr+s63UVI6OOechhmQEZ7aZgHv3sepLIEEU+qbyIeQkWKDuqvfs+HNx407CkdHkn3tFBYyGxS+Ly+yCYT1F3MpWbi345peM=
X-Gm-Message-State: AOJu0YyOjvgd4sGYzjucXWwUlD2zfg/ROsMydlwBtRjOo3xc5zZCp6gl
	hF1ljzxeJne8amU/x2MIUi1aocKZGRh1ZBaQMjtShlodejQQBuEb3Ll094sFHYFy9xDuZW5/WRs
	LcPo81bwppYsmHs43UJfNsHUF228=
X-Google-Smtp-Source: AGHT+IFZvm6/IEtLrKWwT7b8HLfBb9pgpb2VK/+4B/qJTJEnIkJ68GYUmI9B0SgHpzFJg7bn+ds7pwLUUBIrhUvt/HE=
X-Received: by 2002:a05:6512:3ac:b0:511:48ab:2f9c with SMTP id
 v12-20020a05651203ac00b0051148ab2f9cmr370135lfp.42.1707434758096; Thu, 08 Feb
 2024 15:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com> <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
In-Reply-To: <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 8 Feb 2024 17:25:46 -0600
Message-ID: <CAH2r5msRy_KB95yyqrRbTmcaL-5Y_Wh+zD8KYfu+mtroO1d2UQ@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003be0dc0610e7223f"

--0000000000003be0dc0610e7223f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor update to patch following suggestion by Shyam - more accurately
state the PAGE_SIZE in the debug message from:

   cifs_dbg(VFS, "wsize should be a multiple of 4096 (PAGE_SIZE)\n");

to

   cifs_dbg(VFS, "wsize should be a multiple of %ld (PAGE_SIZE)\n", PAGE_SI=
ZE);

On Wed, Feb 7, 2024 at 8:50=E2=80=AFAM Steve French <smfrench@gmail.com> wr=
ote:
>
> I had attached the wrong file - reattaching the correct patch (ie that
> updates the previous version to use PAGE_SIZE instead of 4096)
>
> On Wed, Feb 7, 2024 at 1:12=E2=80=AFAM Steve French <smfrench@gmail.com> =
wrote:
> >
> > Updated patch - now use PAGE_SIZE instead of hard coding to 4096.
> >
> > See attached
> >
> > On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@gmail.co=
m> wrote:
> > >
> > > Attached updated patch which also adds check to make sure max write
> > > size is at least 4K
> > >
> > > On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@gmail.=
com> wrote:
> > > >
> > > > > his netfslib work looks like quite a big refactor. Is there any p=
lans to land this in 6.8? Or will this be 6.9 / later?
> > > >
> > > > I don't object to putting them in 6.8 if there was additional revie=
w
> > > > (it is quite large), but I expect there would be pushback, and am
> > > > concerned that David's status update did still show some TODOs for
> > > > that patch series.  I do plan to upload his most recent set to
> > > > cifs-2.6.git for-next later in the week and target would be for
> > > > merging the patch series would be 6.9-rc1 unless major issues were
> > > > found in review or testing
> > > >
> > > > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > > > <matthew.ruffell@canonical.com> wrote:
> > > > >
> > > > > I have bisected the issue, and found the commit that introduces t=
he problem:
> > > > >
> > > > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > > Author: David Howells <dhowells@redhat.com>
> > > > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > > > Subject: cifs: Change the I/O paths to use an iterator rather tha=
n a page list
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > > >
> > > > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23fdf=
2
> > > > > v6.3-rc1~136^2~7
> > > > >
> > > > > David, I also tried your cifs-netfs tree available here:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dcifs-netfs
> > > > >
> > > > > This tree solves the issue. Specifically:
> > > > >
> > > > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > > > Author: David Howells <dhowells@redhat.com>
> > > > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > > > Subject: cifs: Cut over to using netfslib
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/li=
nux-fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db119f=
d0d8
> > > > >
> > > > > This netfslib work looks like quite a big refactor. Is there any =
plans to land this in 6.8? Or will this be 6.9 / later?
> > > > >
> > > > > Do you have any suggestions on how to fix this with a smaller del=
ta in 6.3 -> 6.8-rc3 that the stable kernels can use?
> > > > >
> > > > > Thanks,
> > > > > Matthew
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
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

--0000000000003be0dc0610e7223f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Disposition: attachment; 
	filename="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsduk1l70>
X-Attachment-Id: f_lsduk1l70

RnJvbSAxMGI3ZGFmMTQyN2Q2YmNlOGMwMWI4MzYxNzJlODk2ODlmZTBhZWNmIE1vbiBTZXAgMTcg
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
c2FobGJlcmdAZ21haWwuY29tPgpBY2tlZC1ieTogUm9ubmllIFNhaGxiZXJnIDxyb25uaWVzYWhs
YmVyZ0BnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNy
b3NvZnQuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjMrCkNjOiBEYXZpZCBI
b3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2gg
PHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL2NsaWVudC9jb25uZWN0LmMgICAg
fCAxMyArKysrKysrKysrKy0tCiBmcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyB8ICAyICsrCiAy
IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZnMvc21iL2NsaWVudC9jb25uZWN0LmMgYi9mcy9zbWIvY2xpZW50L2Nvbm5lY3QuYwpp
bmRleCBiZmQ1NjhmODk3MTAuLjc5Y2U0YTI5ZDFlZiAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVu
dC9jb25uZWN0LmMKKysrIGIvZnMvc21iL2NsaWVudC9jb25uZWN0LmMKQEAgLTM0MzgsOCArMzQz
OCwxNyBAQCBpbnQgY2lmc19tb3VudF9nZXRfdGNvbihzdHJ1Y3QgY2lmc19tb3VudF9jdHggKm1u
dF9jdHgpCiAJICogdGhlIHVzZXIgb24gbW91bnQKIAkgKi8KIAlpZiAoKGNpZnNfc2ItPmN0eC0+
d3NpemUgPT0gMCkgfHwKLQkgICAgKGNpZnNfc2ItPmN0eC0+d3NpemUgPiBzZXJ2ZXItPm9wcy0+
bmVnb3RpYXRlX3dzaXplKHRjb24sIGN0eCkpKQotCQljaWZzX3NiLT5jdHgtPndzaXplID0gc2Vy
dmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpOworCSAgICAoY2lmc19zYi0+Y3R4
LT53c2l6ZSA+IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwgY3R4KSkpIHsKKwkJ
Y2lmc19zYi0+Y3R4LT53c2l6ZSA9IHJvdW5kX2Rvd24oc2VydmVyLT5vcHMtPm5lZ290aWF0ZV93
c2l6ZSh0Y29uLCBjdHgpLCBQQUdFX1NJWkUpOworCQkvKgorCQkgKiBpbiB0aGUgdmVyeSB1bmxp
a2VseSBldmVudCB0aGF0IHRoZSBzZXJ2ZXIgc2VudCBhIG1heCB3cml0ZSBzaXplIHVuZGVyIFBB
R0VfU0laRSwKKwkJICogKHdoaWNoIHdvdWxkIGdldCByb3VuZGVkIGRvd24gdG8gMCkgdGhlbiBy
ZXNldCB3c2l6ZSB0byBhYnNvbHV0ZSBtaW5pbXVtIGVnIDQwOTYKKwkJICovCisJCWlmIChjaWZz
X3NiLT5jdHgtPndzaXplID09IDApIHsKKwkJCWNpZnNfc2ItPmN0eC0+d3NpemUgPSBQQUdFX1NJ
WkU7CisJCQljaWZzX2RiZyhWRlMsICJ3c2l6ZSB0b28gc21hbGwsIHJlc2V0IHRvIG1pbmltdW0g
aWUgUEFHRV9TSVpFLCB1c3VhbGx5IDQwOTZcbiIpOworCQl9CisJfQogCWlmICgoY2lmc19zYi0+
Y3R4LT5yc2l6ZSA9PSAwKSB8fAogCSAgICAoY2lmc19zYi0+Y3R4LT5yc2l6ZSA+IHNlcnZlci0+
b3BzLT5uZWdvdGlhdGVfcnNpemUodGNvbiwgY3R4KSkpCiAJCWNpZnNfc2ItPmN0eC0+cnNpemUg
PSBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3JzaXplKHRjb24sIGN0eCk7CmRpZmYgLS1naXQgYS9m
cy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jCmlu
ZGV4IDUyY2JlZjJlZWIyOC4uOGIwOTBmNzA5MTk0IDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50
L2ZzX2NvbnRleHQuYworKysgYi9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYwpAQCAtMTExMSw2
ICsxMTExLDggQEAgc3RhdGljIGludCBzbWIzX2ZzX2NvbnRleHRfcGFyc2VfcGFyYW0oc3RydWN0
IGZzX2NvbnRleHQgKmZjLAogCWNhc2UgT3B0X3dzaXplOgogCQljdHgtPndzaXplID0gcmVzdWx0
LnVpbnRfMzI7CiAJCWN0eC0+Z290X3dzaXplID0gdHJ1ZTsKKwkJaWYgKHJvdW5kX3VwKGN0eC0+
d3NpemUsIFBBR0VfU0laRSkgIT0gY3R4LT53c2l6ZSkKKwkJCWNpZnNfZGJnKFZGUywgIndzaXpl
IHNob3VsZCBiZSBhIG11bHRpcGxlIG9mICVsZCAoUEFHRV9TSVpFKVxuIiwgUEFHRV9TSVpFKTsK
IAkJYnJlYWs7CiAJY2FzZSBPcHRfYWNyZWdtYXg6CiAJCWN0eC0+YWNyZWdtYXggPSBIWiAqIHJl
c3VsdC51aW50XzMyOwotLSAKMi40MC4xCgo=
--0000000000003be0dc0610e7223f--

