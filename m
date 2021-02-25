Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2FE325704
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhBYTpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 14:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhBYTnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:43:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BBAC061574;
        Thu, 25 Feb 2021 11:43:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id w36so10359296lfu.4;
        Thu, 25 Feb 2021 11:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+53X3tsgIIGYEic7as5AIOyPMdcVwcLUcoH1RGZe9I=;
        b=G3IJc6PAVdTEh4z7PsspuIOMQNQQ2hdGKB5Pl/1/LnguoOO3X1ivm2U/PzksEW3Jyc
         z0QGJtlVUNWYNsMsrt7f/33Sx1ECZKqTL9ayuZUvZcZBzei+V7Hkhiv3ZLf0AdN4rbAp
         qj5m/q47sZ8ywEjh6Ovhcm61CDghMUVL7/+XGOQF+H/UT5KC8Yxgu2sy/OBboakvlllA
         jeA0ULJEaJ5TPxxxFW5mg8xGKTqZgsddR2qjZH2OMSByYfQtkIxoy3wJMBkJ4+Y1Wl3G
         tUBzOD/KmMINSm/obG/iG3qYSUsWhosOjmuVHzpsgdEP30gSpnPKqDsJiFz1z634QtO3
         /V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+53X3tsgIIGYEic7as5AIOyPMdcVwcLUcoH1RGZe9I=;
        b=B/a6SJzyXECPX9sb2jNgv8X+q8HDtb5NMPRLeF6FF2APWWRCmNygTLa8rOLSBeEF0s
         IGtovyy+Zl5fr+VC+UQ3qz5Z5BSCnPrpZZje608Qoo0K3hRt1q4ftdv2o1cIqEoxlHzh
         cKKDozaLlVvTH5RZzPF/jxuy6PhUDwpVMsPYqu8l5Rz8TcY3SoJWjLjPqOmca0Tt8fjg
         DFwegrl0BtZHoRKxDqCIbTG4PLdFCAhFlx4PYjHjIDB1Ya65LLnJt6k5DRoZgEWsGBow
         HobPe5o5/96//yL0SWSFtTias0mCGI5bG4TaaxWnMF8+JEPG+tHYstxYdo66XRjU2xah
         Mhcw==
X-Gm-Message-State: AOAM531Xpo7/Iab+sE14xVDZ9DGiw8Gx1cnXYO4m/poRt/2F5Hlq+wqB
        UGDJ4hNV/EVaGWsoWLBx0Egb+pyW61qKCKS2Iho=
X-Google-Smtp-Source: ABdhPJxv05QcgOcUT7nilIDW33RMxLkaUKO2xb4vq+/JGyNuU0mwWrCKhTOicQb3v3OcAOA5bVvMOzhLNzhJlrsHgJQ=
X-Received: by 2002:a05:6512:1284:: with SMTP id u4mr2831452lfs.175.1614282193047;
 Thu, 25 Feb 2021 11:43:13 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5ms9dJ3RW=_+c0HApLyUC=LD5ACp_nhE2jJQuS-121kV=w@mail.gmail.com>
 <87eehwnn2c.fsf@suse.com> <CAH2r5muuEj_ZpbZ+yAGfnG-JPRP0mAzaBNVYhw7SnbReT8B1DA@mail.gmail.com>
In-Reply-To: <CAH2r5muuEj_ZpbZ+yAGfnG-JPRP0mAzaBNVYhw7SnbReT8B1DA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 25 Feb 2021 13:43:01 -0600
Message-ID: <CAH2r5muV02_MT_641_OGB8gWdxZk4Och=2Mv-768MR36o8ukfA@mail.gmail.com>
Subject: Re: [PATCH] cifs: use discard iterator to discard unneeded network
 data more efficiently
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000af387b05bc2e5c4d"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000af387b05bc2e5c4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

lightly updated patch


On Thu, Feb 25, 2021 at 1:29 PM Steve French <smfrench@gmail.com> wrote:
>
> The other two routines initialize in iov_iter_bvec
>
> iov->type
> iov->bvec
> iov->offset
> iov->count
>
> but iov_iter_discard already does the initialization:
> iov_type
> iov_offset
> iov_count
>
> and then we call cifs_readv_from_socket in all 3
> which sets:
>     iov->msg_control =3D NULL
>     iov->msg_controllen =3D NULL
>
> I will set the two additional ones to null
>     iov->msg_name
> and
>     iov->msg_namelen
>
>
>
> On Thu, Feb 4, 2021 at 4:29 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrot=
e:
> >
> > Steve French <smfrench@gmail.com> writes:
> > > +ssize_t
> > > +cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_r=
ead)
> > > +{
> > > +     struct msghdr smb_msg;
> > > +
> > > +     iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
> > > +
> > > +     return cifs_readv_from_socket(server, &smb_msg);
> > > +}
> > > +
> >
> > Shouldn't smb_msg be initialized to zeroes? Looking around this needs t=
o
> > be done for cifs_read_from_socket() and cifs_read_page_from_socket() to=
o.
> >
> > Cheers,
> > --
> > Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> > GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> > SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnber=
g, DE
> > GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=
=C3=BCnchen)
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--000000000000af387b05bc2e5c4d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-use-discard-iterator-to-discard-unneeded-networ.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-use-discard-iterator-to-discard-unneeded-networ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kll9xfrg0>
X-Attachment-Id: f_kll9xfrg0

RnJvbSAxYjBiZGI1ZTZjOWM4ODQ2YWI0YTU0ODA5M2EzMjMxMWFlOWQwMDM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUaHUsIDQgRmViIDIwMjEgMDA6MTU6MjEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBjaWZz
OiB1c2UgZGlzY2FyZCBpdGVyYXRvciB0byBkaXNjYXJkIHVubmVlZGVkIG5ldHdvcmsgZGF0YQog
bW9yZSBlZmZpY2llbnRseQoKVGhlIGl0ZXJhdG9yLCBJVEVSX0RJU0NBUkQsIHRoYXQgY2FuIG9u
bHkgYmUgdXNlZCBpbiBSRUFEIG1vZGUgYW5kCmp1c3QgZGlzY2FyZHMgYW55IGRhdGEgY29waWVk
IHRvIGl0LCB3YXMgYWRkZWQgdG8gYWxsb3cgYSBuZXR3b3JrCmZpbGVzeXN0ZW0gdG8gZGlzY2Fy
ZCBhbnkgdW53YW50ZWQgZGF0YSBzZW50IGJ5IGEgc2VydmVyLgpDb252ZXJ0IGNpZnNfZGlzY2Fy
ZF9mcm9tX3NvY2tldCgpIHRvIHVzZSB0aGlzLgoKU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxs
cyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZy
ZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc3Byb3RvLmggfCAgMiArKwogZnMv
Y2lmcy9jaWZzc21iLmMgICB8ICA2ICsrKy0tLQogZnMvY2lmcy9jb25uZWN0LmMgICB8IDE3ICsr
KysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzcHJvdG8uaCBiL2ZzL2NpZnMvY2lm
c3Byb3RvLmgKaW5kZXggZDRiMmNjN2U2YjFlLi42NGViNWM4MTc3MTIgMTAwNjQ0Ci0tLSBhL2Zz
L2NpZnMvY2lmc3Byb3RvLmgKKysrIGIvZnMvY2lmcy9jaWZzcHJvdG8uaApAQCAtMjMyLDYgKzIz
Miw4IEBAIGV4dGVybiB1bnNpZ25lZCBpbnQgc2V0dXBfc3BlY2lhbF91c2VyX293bmVyX0FDRShz
dHJ1Y3QgY2lmc19hY2UgKnBhY2UpOwogZXh0ZXJuIHZvaWQgZGVxdWV1ZV9taWQoc3RydWN0IG1p
ZF9xX2VudHJ5ICptaWQsIGJvb2wgbWFsZm9ybWVkKTsKIGV4dGVybiBpbnQgY2lmc19yZWFkX2Zy
b21fc29ja2V0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwgY2hhciAqYnVmLAogCQkJ
ICAgICAgICAgdW5zaWduZWQgaW50IHRvX3JlYWQpOworZXh0ZXJuIHNzaXplX3QgY2lmc19kaXNj
YXJkX2Zyb21fc29ja2V0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwKKwkJCQkJc2l6
ZV90IHRvX3JlYWQpOwogZXh0ZXJuIGludCBjaWZzX3JlYWRfcGFnZV9mcm9tX3NvY2tldChzdHJ1
Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsCiAJCQkJCXN0cnVjdCBwYWdlICpwYWdlLAogCQkJ
CQl1bnNpZ25lZCBpbnQgcGFnZV9vZmZzZXQsCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNzbWIu
YyBiL2ZzL2NpZnMvY2lmc3NtYi5jCmluZGV4IDA0OTY5MzRmZWVjYi4uYzI3OTUyN2FhZTkyIDEw
MDY0NAotLS0gYS9mcy9jaWZzL2NpZnNzbWIuYworKysgYi9mcy9jaWZzL2NpZnNzbWIuYwpAQCAt
MTQ1MSw5ICsxNDUxLDkgQEAgY2lmc19kaXNjYXJkX3JlbWFpbmluZ19kYXRhKHN0cnVjdCBUQ1Bf
U2VydmVyX0luZm8gKnNlcnZlcikKIAl3aGlsZSAocmVtYWluaW5nID4gMCkgewogCQlpbnQgbGVu
Z3RoOwogCi0JCWxlbmd0aCA9IGNpZnNfcmVhZF9mcm9tX3NvY2tldChzZXJ2ZXIsIHNlcnZlci0+
YmlnYnVmLAotCQkJCW1pbl90KHVuc2lnbmVkIGludCwgcmVtYWluaW5nLAotCQkJCSAgICBDSUZT
TWF4QnVmU2l6ZSArIE1BWF9IRUFERVJfU0laRShzZXJ2ZXIpKSk7CisJCWxlbmd0aCA9IGNpZnNf
ZGlzY2FyZF9mcm9tX3NvY2tldChzZXJ2ZXIsCisJCQkJbWluX3Qoc2l6ZV90LCByZW1haW5pbmcs
CisJCQkJICAgICAgQ0lGU01heEJ1ZlNpemUgKyBNQVhfSEVBREVSX1NJWkUoc2VydmVyKSkpOwog
CQlpZiAobGVuZ3RoIDwgMCkKIAkJCXJldHVybiBsZW5ndGg7CiAJCXNlcnZlci0+dG90YWxfcmVh
ZCArPSBsZW5ndGg7CmRpZmYgLS1naXQgYS9mcy9jaWZzL2Nvbm5lY3QuYyBiL2ZzL2NpZnMvY29u
bmVjdC5jCmluZGV4IDU1YjFlYzczMWQ1Mi4uYjkwODU2MjUzMzRlIDEwMDY0NAotLS0gYS9mcy9j
aWZzL2Nvbm5lY3QuYworKysgYi9mcy9jaWZzL2Nvbm5lY3QuYwpAQCAtNTY0LDYgKzU2NCwyMyBA
QCBjaWZzX3JlYWRfZnJvbV9zb2NrZXQoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCBj
aGFyICpidWYsCiAJcmV0dXJuIGNpZnNfcmVhZHZfZnJvbV9zb2NrZXQoc2VydmVyLCAmc21iX21z
Zyk7CiB9CiAKK3NzaXplX3QKK2NpZnNfZGlzY2FyZF9mcm9tX3NvY2tldChzdHJ1Y3QgVENQX1Nl
cnZlcl9JbmZvICpzZXJ2ZXIsIHNpemVfdCB0b19yZWFkKQoreworCXN0cnVjdCBtc2doZHIgc21i
X21zZzsKKworCS8qCisJICogIGlvdl9pdGVyX2Rpc2NhcmQgYWxyZWFkeSBzZXRzIHNtYl9tc2cu
dHlwZSBhbmQgY291bnQgYW5kIGlvdl9vZmZzZXQKKwkgKiAgYW5kIGNpZnNfcmVhZHZfZnJvbV9z
b2NrZXQgc2V0cyBtc2dfY29udHJvbCBhbmQgbXNnX2NvbnRyb2xsZW4KKwkgKiAgc28gbGl0dGxl
IHRvIGluaXRpYWxpemUgaW4gc3RydWN0IG1zZ2hkcgorCSAqLworCXNtYl9tc2cubXNnX25hbWUg
PSBOVUxMOworCXNtYl9tc2dfbmFtZWxlbiA9IDA7CisJaW92X2l0ZXJfZGlzY2FyZCgmc21iX21z
Zy5tc2dfaXRlciwgUkVBRCwgdG9fcmVhZCk7CisKKwlyZXR1cm4gY2lmc19yZWFkdl9mcm9tX3Nv
Y2tldChzZXJ2ZXIsICZzbWJfbXNnKTsKK30KKwogaW50CiBjaWZzX3JlYWRfcGFnZV9mcm9tX3Nv
Y2tldChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsIHN0cnVjdCBwYWdlICpwYWdlLAog
CXVuc2lnbmVkIGludCBwYWdlX29mZnNldCwgdW5zaWduZWQgaW50IHRvX3JlYWQpCi0tIAoyLjI3
LjAKCg==
--000000000000af387b05bc2e5c4d--
