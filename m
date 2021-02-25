Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8188732585B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 22:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBYVFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 16:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBYVCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:02:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00923C061793;
        Thu, 25 Feb 2021 13:01:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j19so10602562lfr.12;
        Thu, 25 Feb 2021 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+y7M2YdyWOJwNcoE/npVoO4W5SDgapwq18dZ8K3CKP0=;
        b=RiKI/IfshKwphaZLtuhrm+RlwKbjh+3trklZUJz9KRrUUjFbC0iHs0Rogy1kyl5Hfn
         vOZEst4CoAEBz4+jZWOeYLvgXtLTKKqT42E7HDg+pNp5gEYVQN9oj/Tbmu1V27fLRCUn
         sE7X0Fc8xMYoAMdBmEwP7E0RbHa2IIQ1VXUJCG3GcfbiGuOH5ZS0jkKH7cESV/HRU73q
         v0DpEAq3MXBkkyiWhv0jRs8YD8Yzi/2hX8FR2QK9kcURJ0rYMcO1IOQ/lKbXlvUQHlo4
         ltmfLxhQDQ+8yE087jlq+G2e0pHyclXwcteoY+Vhij2RCwxnp/l5VYegyudk0a5nRf1l
         UIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y7M2YdyWOJwNcoE/npVoO4W5SDgapwq18dZ8K3CKP0=;
        b=MSIUV4TTaLmXXuJEcNKyJfoQxQJTkqtXcgdusGFRiUAVIMT0a4lxs2vTH4L4jb0CJk
         AwZ4AaIrh1sGhnf+trau5nSR3FAOKz5IPW7yfcF0lcA1RBefqA6cZUns9IsXaXEeHwKr
         CUOlMdBcPaehnBg1Ytf2vy5W6ZzFES2tRtul3+K9uZlF8TQAwBrEL/UYEF73rIP4K++B
         VGQ+AqCvct6YTYDHl+VebhRPeR0wG5RAYWp4PW29LC1E1/H+9EZNnXwXqXNUgyoQ+FtB
         EmspWHuRPSIGt0M72Rxi/J0mDU7H5aQJLUupf5J3yDtGRf+qNZkfbXYADDmBPyslZCpe
         fg9A==
X-Gm-Message-State: AOAM532KsdFx5LGNM1OAzNx3/CJpY7z7V6de2UWjmS5k09v8MCo+UO/6
        UGXmCrwbQUYz/5A6/rM4AeFoxV+//2DPNpr4VJE=
X-Google-Smtp-Source: ABdhPJzYk2lOmOcNHokbTUVgIcxBi3pT1kPVMOrhu8tZVpMtyksO66kA/tcixL07fo+z9+MWm5zufgNdypTrn3iHMBw=
X-Received: by 2002:a19:404f:: with SMTP id n76mr3021876lfa.184.1614286881305;
 Thu, 25 Feb 2021 13:01:21 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5ms9dJ3RW=_+c0HApLyUC=LD5ACp_nhE2jJQuS-121kV=w@mail.gmail.com>
 <87eehwnn2c.fsf@suse.com> <CAH2r5muuEj_ZpbZ+yAGfnG-JPRP0mAzaBNVYhw7SnbReT8B1DA@mail.gmail.com>
 <CAH2r5muV02_MT_641_OGB8gWdxZk4Och=2Mv-768MR36o8ukfA@mail.gmail.com>
In-Reply-To: <CAH2r5muV02_MT_641_OGB8gWdxZk4Och=2Mv-768MR36o8ukfA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 25 Feb 2021 15:01:10 -0600
Message-ID: <CAH2r5mu7kYdLG3P39x1oRoqp6wbbCrBWR9MgT4FdPwAnacZH+Q@mail.gmail.com>
Subject: Re: [PATCH] cifs: use discard iterator to discard unneeded network
 data more efficiently
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000002071fe05bc2f7477"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000002071fe05bc2f7477
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Had a typo in the previous attachment - reattached

The iterator, ITER_DISCARD, that can only be used in READ mode and
just discards any data copied to it, was added to allow a network
filesystem to discard any unwanted data sent by a server.
Convert cifs_discard_from_socket() to use this.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/cifsproto.h |  2 ++
 fs/cifs/cifssmb.c   |  6 +++---
 fs/cifs/connect.c   | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index d4b2cc7e6b1e..64eb5c817712 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -232,6 +232,8 @@ extern unsigned int
setup_special_user_owner_ACE(struct cifs_ace *pace);
 extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf=
,
           unsigned int to_read);
+extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
+ size_t to_read);
 extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
  struct page *page,
  unsigned int page_offset,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 0496934feecb..c279527aae92 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1451,9 +1451,9 @@ cifs_discard_remaining_data(struct
TCP_Server_Info *server)
  while (remaining > 0) {
  int length;

- length =3D cifs_read_from_socket(server, server->bigbuf,
- min_t(unsigned int, remaining,
-     CIFSMaxBufSize + MAX_HEADER_SIZE(server)));
+ length =3D cifs_discard_from_socket(server,
+ min_t(size_t, remaining,
+       CIFSMaxBufSize + MAX_HEADER_SIZE(server)));
  if (length < 0)
  return length;
  server->total_read +=3D length;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 55b1ec731d52..b9085625334e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -564,6 +564,23 @@ cifs_read_from_socket(struct TCP_Server_Info
*server, char *buf,
  return cifs_readv_from_socket(server, &smb_msg);
 }

+ssize_t
+cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
+{
+ struct msghdr smb_msg;
+
+ /*
+ *  iov_iter_discard already sets smb_msg.type and count and iov_offset
+ *  and cifs_readv_from_socket sets msg_control and msg_controllen
+ *  so little to initialize in struct msghdr
+ */
+ smb_msg.msg_name =3D NULL;
+ smb_msg.msg_namelen =3D 0;
+ iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
+
+ return cifs_readv_from_socket(server, &smb_msg);
+}
+
 int
 cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *pa=
ge,
  unsigned int page_offset, unsigned int to_read)

On Thu, Feb 25, 2021 at 1:43 PM Steve French <smfrench@gmail.com> wrote:
>
> lightly updated patch
>
>
> On Thu, Feb 25, 2021 at 1:29 PM Steve French <smfrench@gmail.com> wrote:
> >
> > The other two routines initialize in iov_iter_bvec
> >
> > iov->type
> > iov->bvec
> > iov->offset
> > iov->count
> >
> > but iov_iter_discard already does the initialization:
> > iov_type
> > iov_offset
> > iov_count
> >
> > and then we call cifs_readv_from_socket in all 3
> > which sets:
> >     iov->msg_control =3D NULL
> >     iov->msg_controllen =3D NULL
> >
> > I will set the two additional ones to null
> >     iov->msg_name
> > and
> >     iov->msg_namelen
> >
> >
> >
> > On Thu, Feb 4, 2021 at 4:29 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wr=
ote:
> > >
> > > Steve French <smfrench@gmail.com> writes:
> > > > +ssize_t
> > > > +cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to=
_read)
> > > > +{
> > > > +     struct msghdr smb_msg;
> > > > +
> > > > +     iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
> > > > +
> > > > +     return cifs_readv_from_socket(server, &smb_msg);
> > > > +}
> > > > +
> > >
> > > Shouldn't smb_msg be initialized to zeroes? Looking around this needs=
 to
> > > be done for cifs_read_from_socket() and cifs_read_page_from_socket() =
too.
> > >
> > > Cheers,
> > > --
> > > Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> > > GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> > > SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnb=
erg, DE
> > > GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=
=C3=BCnchen)
> > >
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

--0000000000002071fe05bc2f7477
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-use-discard-iterator-to-discard-unneeded-networ.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-use-discard-iterator-to-discard-unneeded-networ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kllcph710>
X-Attachment-Id: f_kllcph710

RnJvbSAxYjBiZGI1ZTZjOWM4ODQ2YWI0YTU0ODA5M2EzMjMxMWFlOWQwMDM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUaHUsIDQgRmViIDIwMjEgMDA6MTU6MjEgLTA2MDAKU3ViamVjdDogW1BBVENIIDEvMl0g
Y2lmczogdXNlIGRpc2NhcmQgaXRlcmF0b3IgdG8gZGlzY2FyZCB1bm5lZWRlZCBuZXR3b3JrCiBk
YXRhIG1vcmUgZWZmaWNpZW50bHkKClRoZSBpdGVyYXRvciwgSVRFUl9ESVNDQVJELCB0aGF0IGNh
biBvbmx5IGJlIHVzZWQgaW4gUkVBRCBtb2RlIGFuZApqdXN0IGRpc2NhcmRzIGFueSBkYXRhIGNv
cGllZCB0byBpdCwgd2FzIGFkZGVkIHRvIGFsbG93IGEgbmV0d29yawpmaWxlc3lzdGVtIHRvIGRp
c2NhcmQgYW55IHVud2FudGVkIGRhdGEgc2VudCBieSBhIHNlcnZlci4KQ29udmVydCBjaWZzX2Rp
c2NhcmRfZnJvbV9zb2NrZXQoKSB0byB1c2UgdGhpcy4KClNpZ25lZC1vZmYtYnk6IERhdmlkIEhv
d2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8
c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2NpZnNwcm90by5oIHwgIDIgKysK
IGZzL2NpZnMvY2lmc3NtYi5jICAgfCAgNiArKystLS0KIGZzL2NpZnMvY29ubmVjdC5jICAgfCAx
NyArKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc3Byb3RvLmggYi9mcy9jaWZz
L2NpZnNwcm90by5oCmluZGV4IGQ0YjJjYzdlNmIxZS4uNjRlYjVjODE3NzEyIDEwMDY0NAotLS0g
YS9mcy9jaWZzL2NpZnNwcm90by5oCisrKyBiL2ZzL2NpZnMvY2lmc3Byb3RvLmgKQEAgLTIzMiw2
ICsyMzIsOCBAQCBleHRlcm4gdW5zaWduZWQgaW50IHNldHVwX3NwZWNpYWxfdXNlcl9vd25lcl9B
Q0Uoc3RydWN0IGNpZnNfYWNlICpwYWNlKTsKIGV4dGVybiB2b2lkIGRlcXVldWVfbWlkKHN0cnVj
dCBtaWRfcV9lbnRyeSAqbWlkLCBib29sIG1hbGZvcm1lZCk7CiBleHRlcm4gaW50IGNpZnNfcmVh
ZF9mcm9tX3NvY2tldChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsIGNoYXIgKmJ1ZiwK
IAkJCSAgICAgICAgIHVuc2lnbmVkIGludCB0b19yZWFkKTsKK2V4dGVybiBzc2l6ZV90IGNpZnNf
ZGlzY2FyZF9mcm9tX3NvY2tldChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsCisJCQkJ
CXNpemVfdCB0b19yZWFkKTsKIGV4dGVybiBpbnQgY2lmc19yZWFkX3BhZ2VfZnJvbV9zb2NrZXQo
c3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLAogCQkJCQlzdHJ1Y3QgcGFnZSAqcGFnZSwK
IAkJCQkJdW5zaWduZWQgaW50IHBhZ2Vfb2Zmc2V0LApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZz
c21iLmMgYi9mcy9jaWZzL2NpZnNzbWIuYwppbmRleCAwNDk2OTM0ZmVlY2IuLmMyNzk1MjdhYWU5
MiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jaWZzc21iLmMKKysrIGIvZnMvY2lmcy9jaWZzc21iLmMK
QEAgLTE0NTEsOSArMTQ1MSw5IEBAIGNpZnNfZGlzY2FyZF9yZW1haW5pbmdfZGF0YShzdHJ1Y3Qg
VENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIpCiAJd2hpbGUgKHJlbWFpbmluZyA+IDApIHsKIAkJaW50
IGxlbmd0aDsKIAotCQlsZW5ndGggPSBjaWZzX3JlYWRfZnJvbV9zb2NrZXQoc2VydmVyLCBzZXJ2
ZXItPmJpZ2J1ZiwKLQkJCQltaW5fdCh1bnNpZ25lZCBpbnQsIHJlbWFpbmluZywKLQkJCQkgICAg
Q0lGU01heEJ1ZlNpemUgKyBNQVhfSEVBREVSX1NJWkUoc2VydmVyKSkpOworCQlsZW5ndGggPSBj
aWZzX2Rpc2NhcmRfZnJvbV9zb2NrZXQoc2VydmVyLAorCQkJCW1pbl90KHNpemVfdCwgcmVtYWlu
aW5nLAorCQkJCSAgICAgIENJRlNNYXhCdWZTaXplICsgTUFYX0hFQURFUl9TSVpFKHNlcnZlcikp
KTsKIAkJaWYgKGxlbmd0aCA8IDApCiAJCQlyZXR1cm4gbGVuZ3RoOwogCQlzZXJ2ZXItPnRvdGFs
X3JlYWQgKz0gbGVuZ3RoOwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jb25uZWN0LmMgYi9mcy9jaWZz
L2Nvbm5lY3QuYwppbmRleCA1NWIxZWM3MzFkNTIuLmI5MDg1NjI1MzM0ZSAxMDA2NDQKLS0tIGEv
ZnMvY2lmcy9jb25uZWN0LmMKKysrIGIvZnMvY2lmcy9jb25uZWN0LmMKQEAgLTU2NCw2ICs1NjQs
MjMgQEAgY2lmc19yZWFkX2Zyb21fc29ja2V0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZl
ciwgY2hhciAqYnVmLAogCXJldHVybiBjaWZzX3JlYWR2X2Zyb21fc29ja2V0KHNlcnZlciwgJnNt
Yl9tc2cpOwogfQogCitzc2l6ZV90CitjaWZzX2Rpc2NhcmRfZnJvbV9zb2NrZXQoc3RydWN0IFRD
UF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCBzaXplX3QgdG9fcmVhZCkKK3sKKwlzdHJ1Y3QgbXNnaGRy
IHNtYl9tc2c7CisKKwkvKgorCSAqICBpb3ZfaXRlcl9kaXNjYXJkIGFscmVhZHkgc2V0cyBzbWJf
bXNnLnR5cGUgYW5kIGNvdW50IGFuZCBpb3Zfb2Zmc2V0CisJICogIGFuZCBjaWZzX3JlYWR2X2Zy
b21fc29ja2V0IHNldHMgbXNnX2NvbnRyb2wgYW5kIG1zZ19jb250cm9sbGVuCisJICogIHNvIGxp
dHRsZSB0byBpbml0aWFsaXplIGluIHN0cnVjdCBtc2doZHIKKwkgKi8KKwlzbWJfbXNnLm1zZ19u
YW1lID0gTlVMTDsKKwlzbWJfbXNnLm1zZ19uYW1lbGVuID0gMDsKKwlpb3ZfaXRlcl9kaXNjYXJk
KCZzbWJfbXNnLm1zZ19pdGVyLCBSRUFELCB0b19yZWFkKTsKKworCXJldHVybiBjaWZzX3JlYWR2
X2Zyb21fc29ja2V0KHNlcnZlciwgJnNtYl9tc2cpOworfQorCiBpbnQKIGNpZnNfcmVhZF9wYWdl
X2Zyb21fc29ja2V0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwgc3RydWN0IHBhZ2Ug
KnBhZ2UsCiAJdW5zaWduZWQgaW50IHBhZ2Vfb2Zmc2V0LCB1bnNpZ25lZCBpbnQgdG9fcmVhZCkK
LS0gCjIuMjcuMAoK
--0000000000002071fe05bc2f7477--
