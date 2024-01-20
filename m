Return-Path: <linux-fsdevel+bounces-8351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B332283339E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3CB1F22118
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85CD516;
	Sat, 20 Jan 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0zoLztB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DD320F;
	Sat, 20 Jan 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705746756; cv=none; b=gogs4/dCtaSs1STZKb9i+nEj1xUYY+KD4BKEk0ADNEKZGQvP2tItJkeNR6CeCANL++vzRkvLZJ4q6Da/tq8RbGSdxWe2y0eHGgPZAnm7hcNWPdZdLbo/5f+47q7KGHgtNOwE9lCSGI2yiL0xLJqwrYVEAvNBV8PpeG5Ilw8+im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705746756; c=relaxed/simple;
	bh=Kko/TFVQg67L6uPHDx/OHAeeBEVdw7+F5TEiwyua6lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsVJ4hF5f1RcNHdPMstXq42YltQGu0snUZ6hQjxGcBN/GZiMKGI6ju1ZqswrXan6c9YWBs5/3Jo0zmUK0854DlNfNpCfalEm6Mke6RlBvnXJWha8K0lkmsHhx27/SI80NCct74ufamWyStBEiFEzcO4gTGBAVoqk7AJsCzHOCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0zoLztB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7831389c7daso137056285a.2;
        Sat, 20 Jan 2024 02:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705746754; x=1706351554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQL+IxFDSsi0LIUwsRrjaUyuCDr96sypq5Dj+KPGiMM=;
        b=M0zoLztBZlgRf+NngGtyy63yJpKh+9hVATe0FpLyTnbk+sgK18P6zGMgmzdQ0esITj
         y24b9f/P29mYSJ/5YeLIpEQvWtMK0IXOZozlcfVxbZGvdmFRHKFzH463pMUEgKmosR3j
         iNH3LOvvtHfdh4Ei4fbyE1G0iqp9nlFc3yt8b9qNx0C3XCSn7kj0jEZ6BGlNvaQBNZUw
         1BkUPEpsn9WyWItf+bXIizBsTFfN/h5sg0sfQG+fcEAhJvEyfO+Z6sOhF8Y6T9PJtKYO
         ifXZ7CH5OY3GwbT9iD8Rq4QY5HiHsKLfGUba4kYHnBfdBN33EpPMbSabpQcQDE+5Ntm9
         HOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705746754; x=1706351554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQL+IxFDSsi0LIUwsRrjaUyuCDr96sypq5Dj+KPGiMM=;
        b=ia3lYU/TRS8gXrtXMZctQJJjbinWTGJpSFS3fUYwzvydccxHman6jR+q+KQAYPq00y
         7CZZg481k9HQv9xDgNNZso4Wdq26L6kv9OeQgz9cxf98/0t8kuBsWGaxGA27W66FSBe3
         KVGmj0j4zDyQ/1Y9EzKN29knKPYRqB3Jm6jwpEtxIs/uGa592l552TfAdU9OT5j2T4Q3
         JBg6t46gR/bMgDuk61ofB7YaoqxafvOYP42aCVXlPclVdJsoixhTOsSmYj1X/7tXf7DX
         Oj/7KAPGCu97ZZIvA/ydQPxElgx7hm7WQ357405HXJFdGUz/uF0WAJYJH8c2GNTaUJCE
         7Ayg==
X-Gm-Message-State: AOJu0YzH2DMsz7ISiyT1xo+b2GX9uItE9WD3IyEYR/ELOowBos0AF3kj
	h/z72vCEwa9zZIpGQShrevUsbn6x1IixJpc/si33nxK6wC4AnPe6tZ0A2v18rlnc0m8Pq5ELlJk
	pVV98G0cWqhQ8DuLURSc49F4h+aM=
X-Google-Smtp-Source: AGHT+IEfJ0gbODuHo88u+ro/iaHikBVJsCLo+Ykp6gz68mpFlZlCIuv43obehxufoJ/eFtU8ZBEvph6/RLf+Z/zA5vk=
X-Received: by 2002:a0c:df84:0:b0:681:7f6b:e4d7 with SMTP id
 w4-20020a0cdf84000000b006817f6be4d7mr1313956qvl.85.1705746753921; Sat, 20 Jan
 2024 02:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
 <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com> <CAJfpeguFY8KX9kXPBgz5imVTV4A0R+aqS_SRiwdoPXPqR_B_xg@mail.gmail.com>
In-Reply-To: <CAJfpeguFY8KX9kXPBgz5imVTV4A0R+aqS_SRiwdoPXPqR_B_xg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 20 Jan 2024 12:32:21 +0200
Message-ID: <CAOQ4uxgBuhx_ae=+R1LrEkkSctf9MdyZzW=WWsHD6J2ZKSJgww@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Larsson <alexl@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005863dd060f5e1d23"

--0000000000005863dd060f5e1d23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:30=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 19 Jan 2024 at 20:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > How about checking xwhiteouts xattrs along with impure and
> > origin xattrs in ovl_get_inode()?
> >

That was not a very good suggestion on my part.
ovl_get_inode() only checks impure xattr on upper dir and origin xattr
on non-merge non-multi lower dir.

If we change the location of xwhiteout xattr check, it should be in
ovl_lookup_single() next to checking opaque xattr, which makes
me think - hey, why don't we overload opaque xattr, just like we
did with metacopy xattr?

An overlay.opaque xattr with empty string means "may have xwhiteouts"
and that is backward compatible, because ovl_is_opaquedir() checks
for xattr of length 1.

The only extra getxattr() needed would be for the d->last case...

> > Then there will be no overhead in readdir and no need for
> > marking the layer root?
> >
> > Miklos, would that be acceptable?
>
> It's certainly a good idea, but doesn't really address my worry.  The
> minor performance impact is not what bothers me most.  It's the fact
> that in the common case the result of these calls are discarded.
> That's just plain ugly, IMO.

...so the question boils down to, whether you find it too ugly
to always getxattr(opaque) on lookup of the last lower layer and
whether you find the overloading of opaque xattr too hacky?

As a precedent, we *always* check metacopy xattr in last lower layer
to check for error conditions, even if user did not opt-in to metacopy
at all, while we could just as easily have ignored it.

>
> My preferred alternative would be a mount option.  Amir, Alex, would
> you both be okay with that?
>

I think I had suggested that escaped private xattrs would also require
an opt-in mount option, but Alex explained that the users mounting the
overlay are not always aware of the fact that the layers were composed
this way, but I admit that I do not remember all the exact details.

Alex, do I remember correctly that the overlay instance where xwhiteouts
needs to be checked does NOT necessarily have a lowerdata layers?
The composefs instance with lowerdata layers is the one exposing the
(escaped) xwhiteout entries as xwhiteouts. Is that correct?

Is there even a use case for xwhiteouts NOT inside another lower
overlayfs?

If we limit the check for xwhiteouts only to nested overlayfs, then maybe
Miklos will care less about an extra getxattr on lookup?

Attached patch implements both xwhiteout and opaque checks during
lookup - we can later choose only one of them to keep.

Note that is changes the optimization to per-dentry, not per-layer,
so in the common case (no layers have xwhiteouts) xwhiteouts will not
be checked, but if xwhiteouts exist in any lower layer in the stack, then
xwhiteouts will be checked in all the layers of the merged dir (*).

(*) still need to optimize away lookup of xwhiteouts in upperdir.

Let me know what you think.

Thanks,
Amir.

--0000000000005863dd060f5e1d23
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v3-0001-fsnotify-optimize-the-case-of-no-content-event-wa.patch"
Content-Disposition: attachment; 
	filename="v3-0001-fsnotify-optimize-the-case-of-no-content-event-wa.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrlxfp9w0>
X-Attachment-Id: f_lrlxfp9w0

RnJvbSA3ZmEyMTk1MTY0N2FlMjQyOTZjZDA2MDJmMTI5MWQwMGE4ZmE4NGQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDkgRGVjIDIwMjIgMTE6NTA6MjYgKzAyMDAKU3ViamVjdDogW1BBVENIIHYzXSBm
c25vdGlmeTogb3B0aW1pemUgdGhlIGNhc2Ugb2Ygbm8gY29udGVudCBldmVudCB3YXRjaGVycwoK
Q29tbWl0IGU0M2RlN2YwODYyYiAoImZzbm90aWZ5OiBvcHRpbWl6ZSB0aGUgY2FzZSBvZiBubyBt
YXJrcyBvZiBhbnkgdHlwZSIpCm9wdGltaXplZCB0aGUgY2FzZSB3aGVyZSB0aGVyZSBhcmUgbm8g
ZnNub3RpZnkgd2F0Y2hlcnMgb24gYW55IG9mIHRoZQpmaWxlc3lzdGVtJ3Mgb2JqZWN0cy4KCkl0
IGlzIHF1aXRlIGNvbW1vbiBmb3IgYSBzeXN0ZW0gdG8gaGF2ZSBhIHNpbmdsZSBsb2NhbCBmaWxl
c3lzdGVtIGFuZAppdCBpcyBxdWl0ZSBjb21tb24gZm9yIHRoZSBzeXN0ZW0gdG8gaGF2ZSBzb21l
IGlub3RpZnkgd2F0Y2hlcyBvbiBzb21lCmNvbmZpZyBmaWxlcyBvciBkaXJlY3Rvcmllcywgc28g
dGhlIG9wdGltaXphdGlvbiBvZiBubyBtYXJrcyBhdCBhbGwgaXMKb2Z0ZW4gbm90IGluIGVmZmVj
dC4KCkNvbnRlbnQgZXZlbnQgKGkuZS4gYWNjZXNzLG1vZGlmeSkgd2F0Y2hlcnMgb24gc2IvbW91
bnQgbW9yZSByYXJlLCBzbwpvcHRpbWl6aW5nIHRoZSBjYXNlIG9mIG5vIHNiL21vdW50IG1hcmtz
IHdpdGggY29udGVudCBldmVudHMgY2FuIGltcHJvdmUKcGVyZm9ybWFuY2UgZm9yIG1vcmUgc3lz
dGVtcywgZXNwZWNpYWxseSBmb3IgcGVyZm9ybWFuY2Ugc2Vuc2l0aXZlIGlvCndvcmtsb2Fkcy4K
ClVubGVzcyBhIHBhcmVudCBpbm9kZSBpcyB3YXRjaGluZywgY2hlY2sgZm9yIGNvbnRlbnQgZXZl
bnRzIGluIG1hc2tzIG9mCnNiL21vdW50L2lub2RlIG1hc2tzIGVhcmx5IHRvIG9wdGltaXplIG91
dCB0aGUgY29kZSBpbiBfX2Zzbm90aWZ5X3BhcmVudCgpCmFuZCBmc25vdGlmeSgpIGZvciBmc25v
dGlmeSBhY2Nlc3MvbW9kaWZ5IGhvb2tzLgoKU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4g
PGFtaXI3M2lsQGdtYWlsLmNvbT4KLS0tCiBmcy9ub3RpZnkvZnNub3RpZnkuYyAgICAgICAgICAg
ICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBmcy9ub3RpZnkvbWFyay5jICAgICAg
ICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKystCiBpbmNsdWRlL2xpbnV4
L2ZzLmggICAgICAgICAgICAgICB8ICAxICsKIGluY2x1ZGUvbGludXgvZnNub3RpZnkuaCAgICAg
ICAgIHwgMjEgKysrKysrKysrKysrLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2Jh
Y2tlbmQuaCB8IDEzICsrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMg
Yi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCA3OTc0ZTkxZmZlMTMuLmI5NjI1MWNkZDE2NSAx
MDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIvZnMvbm90aWZ5L2Zzbm90aWZ5
LmMKQEAgLTIzNyw2ICsyMzcsMzIgQEAgaW50IF9fZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50
cnkgKmRlbnRyeSwgX191MzIgbWFzaywgY29uc3Qgdm9pZCAqZGF0YSwKIH0KIEVYUE9SVF9TWU1C
T0xfR1BMKF9fZnNub3RpZnlfcGFyZW50KTsKIAorLyogTm90aWZ5IHNiL21vdW50L2lub2RlL3Bh
cmVudCB3YXRjaGVycyBvZiB0aGlzIHBhdGggKi8KK2ludCBmc25vdGlmeV9wYXRoKGNvbnN0IHN0
cnVjdCBwYXRoICpwYXRoLCBfX3UzMiBtYXNrKQoreworCXN0cnVjdCBkZW50cnkgKmRlbnRyeSA9
IHBhdGgtPmRlbnRyeTsKKworCWlmICghZnNub3RpZnlfc2JfaGFzX3dhdGNoZXJzKGRlbnRyeS0+
ZF9zYikpCisJCXJldHVybiAwOworCisJLyogT3B0aW1pemUgdGhlIGxpa2VseSBjYXNlIG9mIHNi
L21vdW50L2lub2RlIG5vdCB3YXRjaGluZyBjb250ZW50ICovCisJaWYgKG1hc2sgJiBGU05PVElG
WV9DT05URU5UX0VWRU5UUyAmJgorCSAgICBsaWtlbHkoIShkZW50cnktPmRfZmxhZ3MgJiBEQ0FD
SEVfRlNOT1RJRllfUEFSRU5UX1dBVENIRUQpKSkgeworCQlfX3UzMiBtYXJrc19tYXNrID0gZF9p
bm9kZShkZW50cnkpLT5pX2Zzbm90aWZ5X21hc2sgfAorCQkJCSAgIHJlYWxfbW91bnQocGF0aC0+
bW50KS0+bW50X2Zzbm90aWZ5X21hc2sgfAorCQkJCSAgIGRlbnRyeS0+ZF9zYi0+c19mc25vdGlm
eV9tYXNrOworCisJCWlmICghKG1hc2sgJiBtYXJrc19tYXNrKSkKKwkJCXJldHVybiAwOworCX0K
KworCS8qCisJICogZnNub3RpZnlfcGFyZW50KCkgY2hlY2tzIHRoZSBldmVudCBtYXNrcyBvZiBz
Yi9tb3VudC9pbm9kZS9wYXJlbnQuCisJICovCisJcmV0dXJuIGZzbm90aWZ5X3BhcmVudChwYXRo
LT5kZW50cnksIG1hc2ssIHBhdGgsIEZTTk9USUZZX0VWRU5UX1BBVEgpOworfQorRVhQT1JUX1NZ
TUJPTF9HUEwoZnNub3RpZnlfcGF0aCk7CisKIHN0YXRpYyBpbnQgZnNub3RpZnlfaGFuZGxlX2lu
b2RlX2V2ZW50KHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCiAJCQkJICAgICAgIHN0cnVj
dCBmc25vdGlmeV9tYXJrICppbm9kZV9tYXJrLAogCQkJCSAgICAgICB1MzIgbWFzaywgY29uc3Qg
dm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9tYXJrLmMg
Yi9mcy9ub3RpZnkvbWFyay5jCmluZGV4IGQ2OTQ0ZmY4NmZmYS4uZDBlMjA4OTEzODgxIDEwMDY0
NAotLS0gYS9mcy9ub3RpZnkvbWFyay5jCisrKyBiL2ZzL25vdGlmeS9tYXJrLmMKQEAgLTE1Myw5
ICsxNTMsMzAgQEAgc3RhdGljIHN0cnVjdCBpbm9kZSAqZnNub3RpZnlfdXBkYXRlX2lyZWYoc3Ry
dWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uLAogCXJldHVybiBpbm9kZTsKIH0KIAor
LyoKKyAqIFRvIGF2b2lkIHRoZSBwZXJmb3JtYW5jZSBwZW5hbHR5IG9mIHJhcmUgY2FzZSBvZiBz
Yi9tb3VudCBjb250ZW50IGV2ZW50CisgKiB3YXRjaGVycyBpbiB0aGUgaG90IGlvIHBhdGgsIHRh
aW50IHNiIGlmIHN1Y2ggd2F0Y2hlcnMgYXJlIGFkZGVkLgorICovCitzdGF0aWMgdm9pZCBmc25v
dGlmeV91cGRhdGVfc2Jfd2F0Y2hlcnMoc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpj
b25uLAorCQkJCQl1MzIgb2xkX21hc2ssIHUzMiBuZXdfbWFzaykKK3sKKwlzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnNiID0gZnNub3RpZnlfY29ubmVjdG9yX3NiKGNvbm4pOworCXUzMiBuZXdfd2F0Y2hl
cnMgPSBuZXdfbWFzayAmIH5vbGRfbWFzayAmIEZTTk9USUZZX0NPTlRFTlRfRVZFTlRTOworCisJ
aWYgKGNvbm4tPnR5cGUgPT0gRlNOT1RJRllfT0JKX1RZUEVfSU5PREUgfHwgIXNiIHx8ICFuZXdf
d2F0Y2hlcnMpCisJCXJldHVybjsKKworCS8qCisJICogVE9ETzogV2UgbmVlZCB0byB0YWtlIHNi
IGNvbm4tPmxvY2sgdG8gc2V0IEZTX01OVF9DT05URU5UX1dBVENIRUQKKwkgKiBpbiBzYi0+c19m
c25vdGlmeV9tYXNrLCBidXQgaWYgdGhpcyBpcyBhIHJlY2FsYyBvZiBtb3VudCBtYXJrIG1hc2ss
CisJICogaXQgaXMgbm90IHN1cmUgdGhhdCB3ZSBoYXZlIGFuIHNiIGNvbm5lY3RvciBhdHRhY2hl
ZCB5ZXQuCisJICovCisJc2ItPnNfaWZsYWdzIHw9IFNCX0lfQ09OVEVOVF9XQVRDSEVEOworfQor
CiBzdGF0aWMgdm9pZCAqX19mc25vdGlmeV9yZWNhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFy
a19jb25uZWN0b3IgKmNvbm4pCiB7Ci0JdTMyIG5ld19tYXNrID0gMDsKKwl1MzIgb2xkX21hc2ss
IG5ld19tYXNrID0gMDsKIAlib29sIHdhbnRfaXJlZiA9IGZhbHNlOwogCXN0cnVjdCBmc25vdGlm
eV9tYXJrICptYXJrOwogCkBAIC0xNjMsNiArMTg0LDcgQEAgc3RhdGljIHZvaWQgKl9fZnNub3Rp
ZnlfcmVjYWxjX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQogCS8q
IFdlIGNhbiBnZXQgZGV0YWNoZWQgY29ubmVjdG9yIGhlcmUgd2hlbiBpbm9kZSBpcyBnZXR0aW5n
IHVubGlua2VkLiAqLwogCWlmICghZnNub3RpZnlfdmFsaWRfb2JqX3R5cGUoY29ubi0+dHlwZSkp
CiAJCXJldHVybiBOVUxMOworCW9sZF9tYXNrID0gZnNub3RpZnlfY29ubl9tYXNrKGNvbm4pOwog
CWhsaXN0X2Zvcl9lYWNoX2VudHJ5KG1hcmssICZjb25uLT5saXN0LCBvYmpfbGlzdCkgewogCQlp
ZiAoIShtYXJrLT5mbGFncyAmIEZTTk9USUZZX01BUktfRkxBR19BVFRBQ0hFRCkpCiAJCQljb250
aW51ZTsKQEAgLTE3Myw2ICsxOTUsOCBAQCBzdGF0aWMgdm9pZCAqX19mc25vdGlmeV9yZWNhbGNf
bWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4pCiAJfQogCSpmc25vdGlm
eV9jb25uX21hc2tfcChjb25uKSA9IG5ld19tYXNrOwogCisJZnNub3RpZnlfdXBkYXRlX3NiX3dh
dGNoZXJzKGNvbm4sIG9sZF9tYXNrLCBuZXdfbWFzayk7CisKIAlyZXR1cm4gZnNub3RpZnlfdXBk
YXRlX2lyZWYoY29ubiwgd2FudF9pcmVmKTsKIH0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9mcy5oIGIvaW5jbHVkZS9saW51eC9mcy5oCmluZGV4IGU2YmEwY2M2ZjJlZS4uZGFjMzZmZTEz
OWUxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgKKysrIGIvaW5jbHVkZS9saW51eC9m
cy5oCkBAIC0xMTczLDYgKzExNzMsNyBAQCBleHRlcm4gaW50IHNlbmRfc2lndXJnKHN0cnVjdCBm
b3duX3N0cnVjdCAqZm93bik7CiAjZGVmaW5lIFNCX0lfVFNfRVhQSVJZX1dBUk5FRCAweDAwMDAw
NDAwIC8qIHdhcm5lZCBhYm91dCB0aW1lc3RhbXAgcmFuZ2UgZXhwaXJ5ICovCiAjZGVmaW5lIFNC
X0lfUkVUSVJFRAkweDAwMDAwODAwCS8qIHN1cGVyYmxvY2sgc2hvdWxkbid0IGJlIHJldXNlZCAq
LwogI2RlZmluZSBTQl9JX05PVU1BU0sJMHgwMDAwMTAwMAkvKiBWRlMgZG9lcyBub3QgYXBwbHkg
dW1hc2sgKi8KKyNkZWZpbmUgU0JfSV9DT05URU5UX1dBVENIRUQgMHgwMDAwMjAwMCAvKiBmc25v
dGlmeSBmaWxlIGNvbnRlbnQgbW9uaXRvciAqLwogCiAvKiBQb3NzaWJsZSBzdGF0ZXMgb2YgJ2Zy
b3plbicgZmllbGQgKi8KIGVudW0gewpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25vdGlm
eS5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCmluZGV4IDExZTY0MzRiOGU3MS4uMmUwZjQ3
NjQ4YThiIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKKysrIGIvaW5jbHVk
ZS9saW51eC9mc25vdGlmeS5oCkBAIC0xNyw2ICsxNywxMiBAQAogI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4KICNpbmNsdWRlIDxsaW51eC9idWcuaD4KIAorLyogQXJlIHRoZXJlIGFueSBpbm9kZS9t
b3VudC9zYiBvYmplY3RzIHRoYXQgYXJlIGJlaW5nIHdhdGNoZWQ/ICovCitzdGF0aWMgaW5saW5l
IGJvb2wgZnNub3RpZnlfc2JfaGFzX3dhdGNoZXJzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCit7
CisJcmV0dXJuIGF0b21pY19sb25nX3JlYWQoJnNiLT5zX2Zzbm90aWZ5X2Nvbm5lY3RvcnMpOwor
fQorCiAvKgogICogTm90aWZ5IHRoaXMgQGRpciBpbm9kZSBhYm91dCBhIGNoYW5nZSBpbiBhIGNo
aWxkIGRpcmVjdG9yeSBlbnRyeS4KICAqIFRoZSBkaXJlY3RvcnkgZW50cnkgbWF5IGhhdmUgdHVy
bmVkIHBvc2l0aXZlIG9yIG5lZ2F0aXZlIG9yIGl0cyBpbm9kZSBtYXkKQEAgLTMwLDcgKzM2LDcg
QEAgc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfbmFtZShfX3UzMiBtYXNrLCBjb25zdCB2b2lk
ICpkYXRhLCBpbnQgZGF0YV90eXBlLAogCQkJCXN0cnVjdCBpbm9kZSAqZGlyLCBjb25zdCBzdHJ1
Y3QgcXN0ciAqbmFtZSwKIAkJCQl1MzIgY29va2llKQogewotCWlmIChhdG9taWNfbG9uZ19yZWFk
KCZkaXItPmlfc2ItPnNfZnNub3RpZnlfY29ubmVjdG9ycykgPT0gMCkKKwlpZiAoIWZzbm90aWZ5
X3NiX2hhc193YXRjaGVycyhkaXItPmlfc2IpKQogCQlyZXR1cm4gMDsKIAogCXJldHVybiBmc25v
dGlmeShtYXNrLCBkYXRhLCBkYXRhX3R5cGUsIGRpciwgbmFtZSwgTlVMTCwgY29va2llKTsKQEAg
LTQ0LDcgKzUwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RpcmVudChzdHJ1Y3Qg
aW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCiBzdGF0aWMgaW5saW5lIHZvaWQg
ZnNub3RpZnlfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgX191MzIgbWFzaykKIHsKLQlpZiAo
YXRvbWljX2xvbmdfcmVhZCgmaW5vZGUtPmlfc2ItPnNfZnNub3RpZnlfY29ubmVjdG9ycykgPT0g
MCkKKwlpZiAoIWZzbm90aWZ5X3NiX2hhc193YXRjaGVycyhpbm9kZS0+aV9zYikpCiAJCXJldHVy
bjsKIAogCWlmIChTX0lTRElSKGlub2RlLT5pX21vZGUpKQpAQCAtNTksOSArNjUsNiBAQCBzdGF0
aWMgaW5saW5lIGludCBmc25vdGlmeV9wYXJlbnQoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBfX3Uz
MiBtYXNrLAogewogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKGRlbnRyeSk7CiAKLQlp
ZiAoYXRvbWljX2xvbmdfcmVhZCgmaW5vZGUtPmlfc2ItPnNfZnNub3RpZnlfY29ubmVjdG9ycykg
PT0gMCkKLQkJcmV0dXJuIDA7Ci0KIAlpZiAoU19JU0RJUihpbm9kZS0+aV9tb2RlKSkgewogCQlt
YXNrIHw9IEZTX0lTRElSOwogCkBAIC04NiwxOCArODksMTggQEAgc3RhdGljIGlubGluZSBpbnQg
ZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgX191MzIgbWFzaywKICAqLwog
c3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RlbnRyeShzdHJ1Y3QgZGVudHJ5ICpkZW50cnks
IF9fdTMyIG1hc2spCiB7CisJaWYgKCFmc25vdGlmeV9zYl9oYXNfd2F0Y2hlcnMoZGVudHJ5LT5k
X3NiKSkKKwkJcmV0dXJuOworCiAJZnNub3RpZnlfcGFyZW50KGRlbnRyeSwgbWFzaywgZGVudHJ5
LCBGU05PVElGWV9FVkVOVF9ERU5UUlkpOwogfQogCiBzdGF0aWMgaW5saW5lIGludCBmc25vdGlm
eV9maWxlKHN0cnVjdCBmaWxlICpmaWxlLCBfX3UzMiBtYXNrKQogewotCWNvbnN0IHN0cnVjdCBw
YXRoICpwYXRoOwotCiAJaWYgKGZpbGUtPmZfbW9kZSAmIEZNT0RFX05PTk9USUZZKQogCQlyZXR1
cm4gMDsKIAotCXBhdGggPSAmZmlsZS0+Zl9wYXRoOwotCXJldHVybiBmc25vdGlmeV9wYXJlbnQo
cGF0aC0+ZGVudHJ5LCBtYXNrLCBwYXRoLCBGU05PVElGWV9FVkVOVF9QQVRIKTsKKwlyZXR1cm4g
ZnNub3RpZnlfcGF0aCgmZmlsZS0+Zl9wYXRoLCBtYXNrKTsKIH0KIAogLyoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlm
eV9iYWNrZW5kLmgKaW5kZXggN2Y2M2JlNWNhMGYxLi40ZTA5OGJkZWIzY2EgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oCisrKyBiL2luY2x1ZGUvbGludXgvZnNu
b3RpZnlfYmFja2VuZC5oCkBAIC02Niw2ICs2NiwxMSBAQAogI2RlZmluZSBGU19SRU5BTUUJCTB4
MTAwMDAwMDAJLyogRmlsZSB3YXMgcmVuYW1lZCAqLwogI2RlZmluZSBGU19ETl9NVUxUSVNIT1QJ
CTB4MjAwMDAwMDAJLyogZG5vdGlmeSBtdWx0aXNob3QgKi8KICNkZWZpbmUgRlNfSVNESVIJCTB4
NDAwMDAwMDAJLyogZXZlbnQgb2NjdXJyZWQgYWdhaW5zdCBkaXIgKi8KKy8qCisgKiBUaGlzIGZs
YWcgaXMgc2V0IGluIHRoZSBvYmplY3QgaW50ZXJlc3QgbWFzayBvZiBzYiB0byBpbmRpY2F0ZSB0
aGF0CisgKiBzb21lIG1vdW50IG1hcmsgaXMgaW50ZXJlc3RlZCB0byBnZXQgY29udGVudCBldmVu
dHMuCisgKi8KKyNkZWZpbmUgRlNfTU5UX0NPTlRFTlRfV0FUQ0hFRAkweDgwMDAwMDAwCiAKICNk
ZWZpbmUgRlNfTU9WRQkJCShGU19NT1ZFRF9GUk9NIHwgRlNfTU9WRURfVE8pCiAKQEAgLTc3LDYg
KzgyLDEzIEBACiAgKi8KICNkZWZpbmUgQUxMX0ZTTk9USUZZX0RJUkVOVF9FVkVOVFMgKEZTX0NS
RUFURSB8IEZTX0RFTEVURSB8IEZTX01PVkUgfCBGU19SRU5BTUUpCiAKKy8qIENvbnRlbnQgZXZl
bnRzIGNhbiBiZSB1c2VkIHRvIGluc3BlY3QgZmlsZSBjb250ZW50ICovCisjZGVmaW5lIEZTTk9U
SUZZX0NPTlRFTlRfUEVSTV9FVkVOVFMJKEZTX0FDQ0VTU19QRVJNKQorCisvKiBDb250ZW50IGV2
ZW50cyBjYW4gYmUgdXNlZCB0byBtb25pdG9yIGZpbGUgY29udGVudCAqLworI2RlZmluZSBGU05P
VElGWV9DT05URU5UX0VWRU5UUwkJKEZTX0FDQ0VTUyB8IEZTX01PRElGWSB8IFwKKwkJCQkJIEZT
Tk9USUZZX0NPTlRFTlRfUEVSTV9FVkVOVFMpCisKICNkZWZpbmUgQUxMX0ZTTk9USUZZX1BFUk1f
RVZFTlRTIChGU19PUEVOX1BFUk0gfCBGU19BQ0NFU1NfUEVSTSB8IFwKIAkJCQkgIEZTX09QRU5f
RVhFQ19QRVJNKQogCkBAIC01NDEsNiArNTUzLDcgQEAgc3RydWN0IGZzbm90aWZ5X21hcmsgewog
ZXh0ZXJuIGludCBmc25vdGlmeShfX3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0
YV90eXBlLAogCQkgICAgc3RydWN0IGlub2RlICpkaXIsIGNvbnN0IHN0cnVjdCBxc3RyICpuYW1l
LAogCQkgICAgc3RydWN0IGlub2RlICppbm9kZSwgdTMyIGNvb2tpZSk7CitleHRlcm4gaW50IGZz
bm90aWZ5X3BhdGgoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIF9fdTMyIG1hc2spOwogZXh0ZXJu
IGludCBfX2Zzbm90aWZ5X3BhcmVudChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIF9fdTMyIG1hc2ss
IGNvbnN0IHZvaWQgKmRhdGEsCiAJCQkgICBpbnQgZGF0YV90eXBlKTsKIGV4dGVybiB2b2lkIF9f
ZnNub3RpZnlfaW5vZGVfZGVsZXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpOwotLSAKMi4zNC4xCgo=
--0000000000005863dd060f5e1d23--

