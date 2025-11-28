Return-Path: <linux-fsdevel+bounces-70105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31CC90B2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE8E3AC7AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AC28689A;
	Fri, 28 Nov 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twC46c6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C52765DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298962; cv=none; b=RdBj31OQ2I3Zw/ra+0wOj10vcmvyTb/kFfUiReSyrpkAA73CLqgKZDnZYWN67O3PHvoqH0fjEvbERD3dZGKqZvXPTHfTf2u+uKKHDWpaaxiHlApBwltpa4acXFl7EHXACtAwjYKo8Y5xIJGXBfvBsx+bOulZzu+arvFyvrnNDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298962; c=relaxed/simple;
	bh=MTf6BVx2wzvVxSSC85YKDXjKkofefJ/V6+3xzqS2Ze4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRjO0Vm9pL1LcPWQohB1/mS2OqTh+ELgV5oWH2wMSwiObL6iEnIGN3bnn/0ombNK2+1JPI84B77oEnWsWLJJvxTkDyzRXDzgMyortTf2VGsOh1RD2gnftMvD9GCo/4hMBI6zY6MWjIesQVsGYg+H0KAnQrz4J6DU5wYBrYccT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twC46c6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A5C4AF09
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298961;
	bh=MTf6BVx2wzvVxSSC85YKDXjKkofefJ/V6+3xzqS2Ze4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=twC46c6EBUz29Lit+G5muRebp66o5nHajGxtdwkJt0NB6Z7xfwmgKHexKvjI/avLa
	 BIqXff0IOzplFwjYxvzFotW1elkRbycX6TY48ve32Y8+0skizl3xMKGgZM+JgyWugk
	 WkFQTudGmmS5TYVR7wHm/5l9H/p0YFi1GrEPXcdHrHoDIzqhcrdnAr8FjC+Kb2OSSL
	 Knobsk+jMEkemok/d/vJYIMmJwg0JAuJ/aeoNM2gcicexjTxhfjcblT9Ps8bEq+WkG
	 +A28oKx28cW4SHBFU3/AyWVbnm22iHZA7UUqqsAAl0R5zCNvr6v3YyxHMYVgaB0e11
	 e4mmTpit+eBNw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso2694013a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 19:02:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/c1g/83GGMRfZxqsL5+kvvXx2dWYfJ+xK3c/KNhKdMOVjSmzz5NjPR28z4O0M0ijH2veu0MNkOXJ7AByq@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDCnKS8XvdblKzHuSHajpDuNykHENIh0b4CPEo0szgxkOmqgH
	QhLwfCQN+iByIg3GoUppc8SMg9K5ECdbdNODSKA78orhnPltlIzL3C9q+wO8lCz7lP5SCmN1UqO
	WpZcloutu/AOaXisN5GtjoSTiOLt1zuo=
X-Google-Smtp-Source: AGHT+IHOQa7Xii9lYXHyLLDvvra6D7Z1/tY2Hk6U/RNRDzvx/RMeZTWI3bjyXerzG7EYKhVOrN5JDZWOXIDIs728qsY=
X-Received: by 2002:a05:6402:5244:b0:640:f2cd:831 with SMTP id
 4fb4d7f45d1cf-6455443f4bemr23787151a12.10.1764298959964; Thu, 27 Nov 2025
 19:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-12-linkinjeon@kernel.org>
 <CAOQ4uxhwy1a+dtkoTkMp5LLJ5m4FzvQefJXfZ2JzrUZiZn7w0w@mail.gmail.com>
 <CAKYAXd99CJOeH=nZg_iLb+q5F5N+xxbZm-4Uwxas_tAR3e_xVA@mail.gmail.com> <CAOQ4uxiGMLe=FD72BBCLnk6kmOTrqSQ5wM4mVHSshKc+TN14TQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiGMLe=FD72BBCLnk6kmOTrqSQ5wM4mVHSshKc+TN14TQ@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Nov 2025 12:02:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8K76CeQNtR-QOMSJ_JjuoiibuQkd4NhkPPM_CQNdNajw@mail.gmail.com>
X-Gm-Features: AWmQ_bnOZt-0lc4cutB5XlQFC_OD68MX69O9aD4NFwtdxr_k8fnKFoYPRYERiv0
Message-ID: <CAKYAXd8K76CeQNtR-QOMSJ_JjuoiibuQkd4NhkPPM_CQNdNajw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: multipart/mixed; boundary="000000000000c9a7bc06449edc18"

--000000000000c9a7bc06449edc18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Nov 27, 2025 at 1:40=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > On Thu, Nov 27, 2025 at 8:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Namjae Jeon <linkinjeon@kerne=
l.org> wrote:
> > > >
> > > > This adds the Kconfig and Makefile for ntfsplus.
> > > >
> > > > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > > > ---
> > > >  fs/Kconfig           |  1 +
> > > >  fs/Makefile          |  1 +
> > > >  fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  fs/ntfsplus/Makefile | 18 ++++++++++++++++++
> > > >  4 files changed, 65 insertions(+)
> > > >  create mode 100644 fs/ntfsplus/Kconfig
> > > >  create mode 100644 fs/ntfsplus/Makefile
> > > >
> > > > diff --git a/fs/Kconfig b/fs/Kconfig
> > > > index 0bfdaecaa877..70d596b99c8b 100644
> > > > --- a/fs/Kconfig
> > > > +++ b/fs/Kconfig
> > > > @@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
> > > >  source "fs/fat/Kconfig"
> > > >  source "fs/exfat/Kconfig"
> > > >  source "fs/ntfs3/Kconfig"
> > > > +source "fs/ntfsplus/Kconfig"
> > > >
> > > >  endmenu
> > > >  endif # BLOCK
> > > > diff --git a/fs/Makefile b/fs/Makefile
> > > > index e3523ab2e587..2e2473451508 100644
> > > > --- a/fs/Makefile
> > > > +++ b/fs/Makefile
> > > > @@ -91,6 +91,7 @@ obj-y                         +=3D unicode/
> > > >  obj-$(CONFIG_SMBFS)            +=3D smb/
> > > >  obj-$(CONFIG_HPFS_FS)          +=3D hpfs/
> > > >  obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
> > > > +obj-$(CONFIG_NTFSPLUS_FS)      +=3D ntfsplus/
> > >
> > > I suggested in another reply to keep the original ntfs name
> > >
> > > More important is to keep your driver linked before the unmaintained
> > > ntfs3, so that it hopefully gets picked up before ntfs3 for auto moun=
t type
> > > if both drivers are built-in.
> > Okay, I will check it:)
> > >
> > > I am not sure if keeping the order here would guarantee the link/regi=
stration
> > > order. If not, it may make sense to mutually exclude them as built-in=
 drivers.
> > Okay, I am leaning towards the latter.
>
> Well it's not this OR that.
> please add you driver as the original was before ntfs3
>
> obj-$(CONFIG_NTFS_FS)      +=3D ntfs/
> obj-$(CONFIG_NTFS3_FS)         +=3D ntfs3/
Okay.
>
> > If you have no objection, I will add the patch to mutually exclude the =
two ntfs implementation.
>
> You should definitely allow them both if at least one is built as a modul=
e
> I think it would be valuable for testing.
>
> Just that
> CONFIG_NTFS_FS=3Dy
> CONFIG_NTFS3_FS=3Dy
>
> I don't see the usefulness in allowing that.
> (other people may disagree)
>
> I think that the way to implement it is using an auxiliary choice config =
var
> in fs/Kconfig (i.e. CONFIG_DEFAULT_NTFS) and select/depends statements
> to only allow the default ntfs driver to be configured as 'y',
> but couldn't find a good example to point you at.
Okay. Could you please check whether the attached patch matches what
you described ?

Thanks!
>
> Thanks,
> Amir.

--000000000000c9a7bc06449edc18
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs-restrict-built-in-NTFS-seclection-to-one-driver.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs-restrict-built-in-NTFS-seclection-to-one-driver.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mii9xtmf0>
X-Attachment-Id: f_mii9xtmf0

RnJvbSAxMTE1NDkxN2ZmNTNkNmNmMjE4YWM1OGU2Nzc2ZTYwMzI0NjU4N2I2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBGcmksIDI4IE5vdiAyMDI1IDExOjQ0OjQ1ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gbnRm
czogcmVzdHJpY3QgYnVpbHQtaW4gTlRGUyBzZWNsZWN0aW9uIHRvIG9uZSBkcml2ZXIsIGFsbG93
CiBib3RoIGFzIG1vZHVsZXMKClNpZ25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9u
QGtlcm5lbC5vcmc+Ci0tLQogZnMvS2NvbmZpZyAgICAgICAgICB8IDExICsrKysrKysrKysrCiBm
cy9udGZzMy9LY29uZmlnICAgIHwgIDIgKysKIGZzL250ZnNwbHVzL0tjb25maWcgfCAgMSArCiAz
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9LY29uZmln
IGIvZnMvS2NvbmZpZwppbmRleCA3MGQ1OTZiOTljOGIuLmMzNzkzODNjYjRmZiAxMDA2NDQKLS0t
IGEvZnMvS2NvbmZpZworKysgYi9mcy9LY29uZmlnCkBAIC0xNTUsNiArMTU1LDE3IEBAIHNvdXJj
ZSAiZnMvZXhmYXQvS2NvbmZpZyIKIHNvdXJjZSAiZnMvbnRmczMvS2NvbmZpZyIKIHNvdXJjZSAi
ZnMvbnRmc3BsdXMvS2NvbmZpZyIKIAorY2hvaWNlCisgICBwcm9tcHQgIlNlbGVjdCBidWlsdC1p
biBOVEZTIGZpbGVzeXN0ZW0gKG9ubHkgb25lIGNhbiBiZSBidWlsdC1pbikiCisgICBoZWxwCisg
ICAgIE9ubHkgb25lIE5URlMgY2FuIGJlIGJ1aWx0IGludG8gdGhlIGtlcm5lbCh5KS4KKyAgICAg
Qm90aCBjYW4gc3RpbGwgYmUgYnVpbHQgYXMgbW9kdWxlcyhtKS4KKworICAgY29uZmlnIERFRkFV
TFRfTlRGU1BMVVMKKyAgICAgICBib29sICJOVEZTKyIKKyAgIGNvbmZpZyBERUZBVUxUX05URlMz
CisgICAgICAgYm9vbCAiTlRGUzMiCitlbmRjaG9pY2UKIGVuZG1lbnUKIGVuZGlmICMgQkxPQ0sK
IApkaWZmIC0tZ2l0IGEvZnMvbnRmczMvS2NvbmZpZyBiL2ZzL250ZnMzL0tjb25maWcKaW5kZXgg
N2JjMzFkNjlmNjgwLi4xOGJkNmM5OGM2ZWIgMTAwNjQ0Ci0tLSBhL2ZzL250ZnMzL0tjb25maWcK
KysrIGIvZnMvbnRmczMvS2NvbmZpZwpAQCAtMSw2ICsxLDcgQEAKICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seQogY29uZmlnIE5URlMzX0ZTCiAJdHJpc3RhdGUgIk5URlMg
UmVhZC1Xcml0ZSBmaWxlIHN5c3RlbSBzdXBwb3J0IgorCWRlcGVuZHMgb24gIURFRkFVTFRfTlRG
U1BMVVMgfHwgbQogCXNlbGVjdCBCVUZGRVJfSEVBRAogCXNlbGVjdCBOTFMKIAlzZWxlY3QgTEVH
QUNZX0RJUkVDVF9JTwpAQCAtNDksNiArNTAsNyBAQCBjb25maWcgTlRGUzNfRlNfUE9TSVhfQUNM
CiAKIGNvbmZpZyBOVEZTX0ZTCiAJdHJpc3RhdGUgIk5URlMgZmlsZSBzeXN0ZW0gc3VwcG9ydCIK
KwlkZXBlbmRzIG9uICFERUZBVUxUX05URlNQTFVTIHx8IG0KIAlzZWxlY3QgTlRGUzNfRlMKIAlz
ZWxlY3QgQlVGRkVSX0hFQUQKIAlzZWxlY3QgTkxTCmRpZmYgLS1naXQgYS9mcy9udGZzcGx1cy9L
Y29uZmlnIGIvZnMvbnRmc3BsdXMvS2NvbmZpZwppbmRleCA3OGJjMzQ4NDA0NjMuLmM4ZDFhYjk5
MTEzYyAxMDA2NDQKLS0tIGEvZnMvbnRmc3BsdXMvS2NvbmZpZworKysgYi9mcy9udGZzcGx1cy9L
Y29uZmlnCkBAIC0xLDYgKzEsNyBAQAogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vbmx5CiBjb25maWcgTlRGU1BMVVNfRlMKIAl0cmlzdGF0ZSAiTlRGUysgZmlsZSBzeXN0ZW0g
c3VwcG9ydCAoRVhQRVJJTUVOVEFMKSIKKwlkZXBlbmRzIG9uICFERUZBVUxUX05URlMzIHx8IG0K
IAlzZWxlY3QgTkxTCiAJaGVscAogCSAgTlRGUyBpcyB0aGUgZmlsZSBzeXN0ZW0gb2YgTWljcm9z
b2Z0IFdpbmRvd3MgTlQsIDIwMDAsIFhQIGFuZCAyMDAzLgotLSAKMi4zNC4xCgo=
--000000000000c9a7bc06449edc18--

