Return-Path: <linux-fsdevel+bounces-72688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C62D000AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88C863002849
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4C229B38;
	Wed,  7 Jan 2026 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNHtG8Gi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5A2877ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818621; cv=none; b=J67R5lLa6r1DHdZcItJ3EoxGleAzcoxVwCHcg0Mbc9Qz5AhqMybD/iTz13r6FgS5ak1SBKGiQcvHKhpurlRO1nsLvGEdVKSrOcyqaZeegn+C1A2ODKyHXYW49L9ejK8RPJkKKtQKT2HJfEhw73msAHY0/la9tF87/8hVv33hHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818621; c=relaxed/simple;
	bh=aKG2D9pm/jId626C7hRmlYzE75SV/rH0qzDUEbuGvNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBo9Y6GpE15EW4ED42nQQmhKW+Fk4E5NFpd15/ufcihiUzHAfDd0PWjnnJtg7j2BVwFqJwJ9Y/EFG+qUCXkby4JidbAeBU1e+djOpnh9t83LTO9OYnVbC6L+uDqRJ7h1u2X2/Ac7e2l7XLCneOuKvZDL2caEC3ytkt3gPW9fv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNHtG8Gi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso3465061a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767818617; x=1768423417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9gG0jBoyVrgrYrbFKrdKRMzXYkz7vinBG5CCz66E0q4=;
        b=NNHtG8GiUvgRSof15LAxhyPGpmp2RJzY7CNJDXJkHN/KihDNI9XRKwFTm2DHLRESLL
         uunTKsHWqDNoHybRDYG4GHBiXqkSkdt9+lXKYioYbi5efTSOHbUWo4fCrhNnMEz9/mfY
         z2UmofIRr2B2rjhJ46cEAdpikDGqXRk040bp2KRAec+IkdjDhUXSk/abq5UezHmLFdee
         GUSlYpC5SWgLV4XaFT97hMJHk6sRIjgXae1SnFAW2oVMtt9FgVWpk7bUeypf8XbaAhpv
         D3m9SF8Wy8vxk3yUGEHg5WwUymRdP2q3CwY8S5xK/hCZ0Rjyw1j+rYcyv+hyWJzYDrVL
         x0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767818617; x=1768423417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gG0jBoyVrgrYrbFKrdKRMzXYkz7vinBG5CCz66E0q4=;
        b=l+zWSeNYZcw9GXudawLE/8CYV9cLFD8Q3mPlKyGkecQsyD/lAnt1CyA0U5ypN2jXvI
         G6WxpPjhdE88tr6Uu0FIpu4kHjcYFDMPXYlqbygDEAY4KQ6WnTsZoMZ1CgRQrqQN5/9L
         fqZOgmnBZ+J1QNoK9MQ437MfrFy9uQcYQ6pyzGzLli//JQbRTCnbGlcVP4svy3+SqOxz
         YgA5Q1ilhyylr3yUxcv9/hbdFb3fR9EzbFNjCERInlQ64N1rgYxr5yIDedIUJShXI33W
         HSs9hhfsTfjg+abFNNZXxU5NTYOh61KKcAAIWDflZYckTDWZCUm6jVt/kbOGUYY+TzYJ
         j1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoOUROx3aXwRFRlBimMP866GVJxXpdKfdCm9MOMi3Jv6P+qXcCo/tn/7wpLYTnypaiXstFTqTLvjz+uour@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPO6dKy04hkJZdmKBTsdgIP+havFS7uiUdzXGgLPkrGiqSxn/
	0m7sPYqc2ZNr4uvpwiduJKN74REPpCaQEJN1a6oTP2fRHlQJV7ABNsyUH+26trkFa1m/aHOUyB1
	kU6rjWjKkjTfy2RqaZihFtOyqVu5dZKs=
X-Gm-Gg: AY/fxX5r3abkrayG9mD31Ouxt66TM0YgtQE862Fjg8FlWyfzfXi7KgNAxeEqKuoNWbb
	+7t78tcmgqZR1o5aAiw/TXHGGou25wyLFyWDRj3gYusq1DI8eZmaDwuU4JKOEUTjTHlAmQvX38/
	BTon1bChyD5SKXgOjbA+JegBYnPbOKd2n0W62apP+d/a8Ha2SQqy68ZSlMRJbN5GHWS5X1V0791
	HgE2N/iZUxdYrmZ+iajamL9GL4zZNH7eTdz1z5v+zehROUBY2OKm1VxCrxqPsPR8RLX6WkwvJoV
	qir7p19XAL3G2FsBgsE1Rc2NG9gIYw==
X-Google-Smtp-Source: AGHT+IG2Jv5W7UO/DLsiKVqSOaV8dYU+c43B75QWLq4coJkxffIjeUIWijqIob2TT3tXJ58tpJBQ4NmCRvy5sU84Whk=
X-Received: by 2002:aa7:c4e7:0:b0:64c:69e6:ad3a with SMTP id
 4fb4d7f45d1cf-65097e6107amr2505709a12.27.1767818616531; Wed, 07 Jan 2026
 12:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107034551.439-1-luochunsheng@ustc.edu>
In-Reply-To: <20260107034551.439-1-luochunsheng@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 Jan 2026 21:43:25 +0100
X-Gm-Features: AQt7F2o6V8AjZdD_r_x9Kwi_5hcKpibUG5THE2aXE9UuA1aZVEK6F26Nak4WtR0
Message-ID: <CAOQ4uxhjWwTdENS2GqmOxtx4hdbv=N4f90iLVuxHNgH=NLem9w@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: mask d_type high bits before whiteout check
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, bschubert@ddn.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000aaa72b0647d2589b"

--000000000000aaa72b0647d2589b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:46=E2=80=AFAM Chunsheng Luo <luochunsheng@ustc.edu=
> wrote:
>
> Commit c31f91c6af96 ("fuse: don't allow signals to interrupt getdents
> copying") introduced the use of high bits in d_type as flags. However,
> overlayfs was not adapted to handle this change.
>
> In ovl_cache_entry_new(), the code checks if d_type =3D=3D DT_CHR to
> determine if an entry might be a whiteout. When fuse is used as the
> lower layer and sets high bits in d_type, this comparison fails,
> causing whiteout files to not be recognized properly and resulting in
> incorrect overlayfs behavior.
>
> Fix this by masking out the high bits with S_DT_MASK before checking.
>
> Fixes: c31f91c6af96 ("fuse: don't allow signals to interrupt getdents cop=
ying")
> Link: https://github.com/containerd/stargz-snapshotter/issues/2214
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>

Hi Chunsheng,

Thanks for the report and the suggested fix.

This time overlayfs was surprised by unexpected d_type flags and next
time it could be another user.

I prefer to fix this in a more profound way -
Instead of making overlafys aware of d_type flags, require the users that
use the d_type flags to opt-in for them.

Please test/review the attached patch.

Thanks,
Amir.


> ---
>  fs/overlayfs/readdir.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 160960bb0ad0..a2ac47458bf9 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -246,6 +246,9 @@ static int ovl_fill_lowest(struct ovl_readdir_data *r=
dd,
>  {
>         struct ovl_cache_entry *p;
>
> +       /* Mask out high bits that may be used (e.g., fuse) */
> +       d_type &=3D S_DT_MASK;
> +
>         p =3D ovl_cache_entry_find(rdd->root, c_name, c_len);
>         if (p) {
>                 list_move_tail(&p->l_node, &rdd->middle);
> @@ -316,6 +319,9 @@ static bool ovl_fill_merge(struct dir_context *ctx, c=
onst char *name,
>         char *cf_name =3D NULL;
>         int c_len =3D 0, ret;
>
> +       /* Mask out high bits that may be used (e.g., fuse) */
> +       d_type &=3D S_DT_MASK;
> +
>         if (ofs->casefold)
>                 c_len =3D ovl_casefold(rdd, name, namelen, &cf_name);
>
> @@ -632,6 +638,9 @@ static bool ovl_fill_plain(struct dir_context *ctx, c=
onst char *name,
>         struct ovl_readdir_data *rdd =3D
>                 container_of(ctx, struct ovl_readdir_data, ctx);
>
> +       /* Mask out high bits that may be used (e.g., fuse) */
> +       d_type &=3D S_DT_MASK;
> +
>         rdd->count++;
>         p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_typ=
e);
>         if (p =3D=3D NULL) {
> @@ -755,6 +764,9 @@ static bool ovl_fill_real(struct dir_context *ctx, co=
nst char *name,
>         struct dir_context *orig_ctx =3D rdt->orig_ctx;
>         bool res;
>
> +       /* Mask out high bits that may be used (e.g., fuse) */
> +       d_type &=3D S_DT_MASK;
> +
>         if (rdt->parent_ino && strcmp(name, "..") =3D=3D 0) {
>                 ino =3D rdt->parent_ino;
>         } else if (rdt->cache) {
> @@ -1144,6 +1156,9 @@ static bool ovl_check_d_type(struct dir_context *ct=
x, const char *name,
>         struct ovl_readdir_data *rdd =3D
>                 container_of(ctx, struct ovl_readdir_data, ctx);
>
> +       /* Mask out high bits that may be used (e.g., fuse) */
> +       d_type &=3D S_DT_MASK;
> +
>         /* Even if d_type is not supported, DT_DIR is returned for . and =
.. */
>         if (!strncmp(name, ".", namelen) || !strncmp(name, "..", namelen)=
)
>                 return true;
> --
> 2.43.0
>

--000000000000aaa72b0647d2589b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-readdir-require-opt-in-for-d_type-flags.patch"
Content-Disposition: attachment; 
	filename="0001-readdir-require-opt-in-for-d_type-flags.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mk4hg36a0>
X-Attachment-Id: f_mk4hg36a0

RnJvbSAyODNmYWE5NjRiMmZiMjgyMWVhNjRlYjQ1MTQwN2U4YTUwOTVmZTBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDcgSmFuIDIwMjYgMTA6MDA6NTcgKzAxMDAKU3ViamVjdDogW1BBVENIXSByZWFk
ZGlyOiByZXF1aXJlIG9wdC1pbiBmb3IgZF90eXBlIGZsYWdzCgpDb21taXQgYzMxZjkxYzZhZjk2
ICgiZnVzZTogZG9uJ3QgYWxsb3cgc2lnbmFscyB0byBpbnRlcnJ1cHQgZ2V0ZGVudHMKY29weWlu
ZyIpIGludHJvZHVjZWQgdGhlIHVzZSBvZiBoaWdoIGJpdHMgaW4gZF90eXBlIGFzIGZsYWdzLiBI
b3dldmVyLApvdmVybGF5ZnMgd2FzIG5vdCBhZGFwdGVkIHRvIGhhbmRsZSB0aGlzIGNoYW5nZS4K
CkluIG92bF9jYWNoZV9lbnRyeV9uZXcoKSwgdGhlIGNvZGUgY2hlY2tzIGlmIGRfdHlwZSA9PSBE
VF9DSFIgdG8KZGV0ZXJtaW5lIGlmIGFuIGVudHJ5IG1pZ2h0IGJlIGEgd2hpdGVvdXQuIFdoZW4g
ZnVzZSBpcyB1c2VkIGFzIHRoZQpsb3dlciBsYXllciBhbmQgc2V0cyBoaWdoIGJpdHMgaW4gZF90
eXBlLCB0aGlzIGNvbXBhcmlzb24gZmFpbHMsCmNhdXNpbmcgd2hpdGVvdXQgZmlsZXMgdG8gbm90
IGJlIHJlY29nbml6ZWQgcHJvcGVybHkgYW5kIHJlc3VsdGluZyBpbgppbmNvcnJlY3Qgb3Zlcmxh
eWZzIGJlaGF2aW9yLgoKRml4IHRoaXMgYnkgcmVxdWlyaW5nIGNhbGxlcnMgb2YgaXRlcmF0ZV9k
aXIoKSB0byBvcHQtaW4gZm9yIGdldHRpbmcKZmxhZyBiaXRzIGluIGRfdHlwZSBvdXRzaWRlIG9m
IFNfRFRfTUFTSy4KCkZpeGVzOiBjMzFmOTFjNmFmOTYgKCJmdXNlOiBkb24ndCBhbGxvdyBzaWdu
YWxzIHRvIGludGVycnVwdCBnZXRkZW50cyBjb3B5aW5nIikKTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjYwMTA3MDM0NTUxLjQzOS0xLWx1b2NodW5zaGVuZ0B1c3RjLmVkdS8K
TGluazogaHR0cHM6Ly9naXRodWIuY29tL2NvbnRhaW5lcmQvc3Rhcmd6LXNuYXBzaG90dGVyL2lz
c3Vlcy8yMjE0ClJlcG9ydGVkLWJ5OiBDaHVuc2hlbmcgTHVvIDxsdW9jaHVuc2hlbmdAdXN0Yy5l
ZHU+ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0t
LQogZnMvcmVhZGRpci5jICAgICAgIHwgMyArKysKIGluY2x1ZGUvbGludXgvZnMuaCB8IDYgKysr
KystCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2ZzL3JlYWRkaXIuYyBiL2ZzL3JlYWRkaXIuYwppbmRleCA3NzY0Yjg2Mzg5Nzg4
Li43N2U0YWE3NzIzMTVkIDEwMDY0NAotLS0gYS9mcy9yZWFkZGlyLmMKKysrIGIvZnMvcmVhZGRp
ci5jCkBAIC0zMTYsNiArMzE2LDcgQEAgU1lTQ0FMTF9ERUZJTkUzKGdldGRlbnRzLCB1bnNpZ25l
ZCBpbnQsIGZkLAogCXN0cnVjdCBnZXRkZW50c19jYWxsYmFjayBidWYgPSB7CiAJCS5jdHguYWN0
b3IgPSBmaWxsZGlyLAogCQkuY3R4LmNvdW50ID0gY291bnQsCisJCS5jdHguZHRfZmxhZ19tYXNr
ID0gRklMTERJUl9GTEFHX05PSU5UUiwKIAkJLmN1cnJlbnRfZGlyID0gZGlyZW50CiAJfTsKIAlp
bnQgZXJyb3I7CkBAIC00MDAsNiArNDAxLDcgQEAgU1lTQ0FMTF9ERUZJTkUzKGdldGRlbnRzNjQs
IHVuc2lnbmVkIGludCwgZmQsCiAJc3RydWN0IGdldGRlbnRzX2NhbGxiYWNrNjQgYnVmID0gewog
CQkuY3R4LmFjdG9yID0gZmlsbGRpcjY0LAogCQkuY3R4LmNvdW50ID0gY291bnQsCisJCS5jdHgu
ZHRfZmxhZ19tYXNrID0gRklMTERJUl9GTEFHX05PSU5UUiwKIAkJLmN1cnJlbnRfZGlyID0gZGly
ZW50CiAJfTsKIAlpbnQgZXJyb3I7CkBAIC01NjksNiArNTcxLDcgQEAgQ09NUEFUX1NZU0NBTExf
REVGSU5FMyhnZXRkZW50cywgdW5zaWduZWQgaW50LCBmZCwKIAlzdHJ1Y3QgY29tcGF0X2dldGRl
bnRzX2NhbGxiYWNrIGJ1ZiA9IHsKIAkJLmN0eC5hY3RvciA9IGNvbXBhdF9maWxsZGlyLAogCQku
Y3R4LmNvdW50ID0gY291bnQsCisJCS5jdHguZHRfZmxhZ19tYXNrID0gRklMTERJUl9GTEFHX05P
SU5UUiwKIAkJLmN1cnJlbnRfZGlyID0gZGlyZW50LAogCX07CiAJaW50IGVycm9yOwpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9mcy5oIGIvaW5jbHVkZS9saW51eC9mcy5oCmluZGV4IGY1Yzlj
ZjI4YzRkY2YuLmMzNjk5MjgzMmZiMmIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAor
KysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgKQEAgLTE4NTUsNiArMTg1NSw4IEBAIHN0cnVjdCBkaXJf
Y29udGV4dCB7CiAJICogSU5UX01BWCAgdW5saW1pdGVkCiAJICovCiAJaW50IGNvdW50OworCS8q
IEBhY3RvciBzdXBwb3J0cyB0aGVzZSBmbGFncyBpbiBkX3R5cGUgaGlnaCBiaXRzICovCisJdW5z
aWduZWQgaW50IGR0X2ZsYWdfbWFzazsKIH07CiAKIC8qIElmIE9SLWVkIHdpdGggZF90eXBlLCBw
ZW5kaW5nIHNpZ25hbHMgYXJlIG5vdCBjaGVja2VkICovCkBAIC0zNTI0LDcgKzM1MjYsOSBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgZGlyX2VtaXQoc3RydWN0IGRpcl9jb250ZXh0ICpjdHgsCiAJCQkg
ICAgY29uc3QgY2hhciAqbmFtZSwgaW50IG5hbWVsZW4sCiAJCQkgICAgdTY0IGlubywgdW5zaWdu
ZWQgdHlwZSkKIHsKLQlyZXR1cm4gY3R4LT5hY3RvcihjdHgsIG5hbWUsIG5hbWVsZW4sIGN0eC0+
cG9zLCBpbm8sIHR5cGUpOworCXVuc2lnbmVkIGludCBkdF9tYXNrID0gU19EVF9NQVNLIHwgY3R4
LT5kdF9mbGFnX21hc2s7CisKKwlyZXR1cm4gY3R4LT5hY3RvcihjdHgsIG5hbWUsIG5hbWVsZW4s
IGN0eC0+cG9zLCBpbm8sIHR5cGUgJiBkdF9tYXNrKTsKIH0KIHN0YXRpYyBpbmxpbmUgYm9vbCBk
aXJfZW1pdF9kb3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQog
ewotLSAKMi41Mi4wCgo=
--000000000000aaa72b0647d2589b--

