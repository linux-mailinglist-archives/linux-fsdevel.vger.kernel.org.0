Return-Path: <linux-fsdevel+bounces-34468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24A9C5ABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85C528A3CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D801FF7BF;
	Tue, 12 Nov 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdJotj/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB151FF034;
	Tue, 12 Nov 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422588; cv=none; b=cOlSUBDvubXQIbD6oNwn/DBd88jET7rOwRoFe2M1f+ehDmNXpkzITbAjxRUbKxd2z212ndi0tZtS89+5RxOblAR/k1YbUGt7oFhNdAntsyO6L7rEfM5sn49cWdD5wn23qCG6aEZwo0gsZfo9XkH6RCBTKLxCvOVxcs0MSPit/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422588; c=relaxed/simple;
	bh=H7ySh2TXkX33QhtlaMClLoqvD9TtVhHSZgSzQrVzRTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyl/9byTVVxd8SJ4rhjCxwVNULVt2k0AG1U57d97a2GFUClqI3uw28S8R2atYrVlDpG2aPo0eQiSG4Pz4zj6TP8rExJjWAZBnNCPOv5mZf8NkaFQhfDQ1/YmmOZjdztr0zF7A23YghrZ4EYvOvYtCdLTkzzbgqsVrdbXUkAe4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdJotj/u; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbf0769512so38767336d6.3;
        Tue, 12 Nov 2024 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731422586; x=1732027386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJitszLJDg3VwSrulTOUYyc6BMdqCAbB6MWmGHGc2b0=;
        b=VdJotj/uTs9EJl2h2nDC1avNu5STfHGA9+MQy1yfFmANN4yLaxCjmJMO66TuUfo8fc
         Nltg49ueQJ75EVVqNqrDFIWlXQmyJkVh3alJYeYCeIfoesTBRxfkjS8jXtlZeIQ6spMh
         M4CsMagFTiO10aoavOTg7uznXPCmnsZYyp2c6bodlpNEu0aVx5l7V6qSf67egYcbbqL4
         Xg8Gex6CPsI+j8IK28SEQGmXj6zCgpoektfWux+Z+cz7rihetfDt+dJBfhGwMlDmpFDe
         UeyHyN3IIJjtCIJNBV5GFfLU75GA3T5FP3Rud5yeeByadbwIr6bGYG8Yvxz1lmSRgwQD
         CGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422586; x=1732027386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJitszLJDg3VwSrulTOUYyc6BMdqCAbB6MWmGHGc2b0=;
        b=IDLnhtbQd67JfTy2vY7PoPxq95ceR+MCxqqx+VLLiOldbN6k8f57B5xpRv4ryDVdUK
         83DXkZIA/n8twt0bqx+jb0VLgDnlhP+hAqSSZ7v6471XATk2uGU0ydk0N2wXQAcgpRui
         684MbKUFbYqIEB+PpQEjrDgKFDNSh4xwSuNWbJOw3gPB8fRr385NUEHXIs2eIgbD65Lk
         IvUT0O7CbXZHuDEW9mm2X3A+6aj+v530wEh7idnPW+he5WwGEv7F3B/XJ7MJKKd+jMn3
         8QEPJq2UE+N5qW+kOfr1W7yMDOJLXjZS35FlaMtxvriiSPXd0x7E0MxgWW6eXPzNFOIy
         lBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7eSymWFA2ImE7Pk6H9rJveDQoqCbTnrGfRFG5/LpLZ9Lnf+bNBgmyuKP6kV4ccT4wJfdrNNXqyedv8w==@vger.kernel.org, AJvYcCVSSY9ocrsgf6ym1E7QzEDxXYr8aPIXzjGdhGenup+4RKT7oQXvHnOIW0h1y4F7QlOmV947JgphsgJB@vger.kernel.org, AJvYcCW7rz8rlgssdQzSSEY9bl1O6kMZ8sc5LKHdQDRWCEAgz39gPK4pSA0U1I0zdZeRCSEcsAxzHCtyo+DRHsvp1A==@vger.kernel.org, AJvYcCXAhlh09rFTpFmVR2DqaC/C2gjIVinmFp1a4OYT7s4Ez2ZICcim8asHiXQrGmERrTA6IZQJyNiTytrUlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEpAnD8dIm8PQWPeHpdWOBeJTu+kE6st/9TGvy1gSvgoW2+rm
	WP6LN92CFRoTVo+CXOfoYlar2NyfDDI8FFUPtAR+Z6E5OkwLnTysjRHB4CHwM57q+hp0shWtROG
	95RlSsR4GiFCDq9XWJ0rJWSQdms8=
X-Google-Smtp-Source: AGHT+IHsEbdNRX2EeabFHLNPiKKT4tbxGfpFRPEv0WvCJKomF8HYSNpQhaRbhjSeBcbJAKgMvEpxWFBpgcQI7gZI5is=
X-Received: by 2002:a0c:f413:0:b0:6cb:fbb1:d1ba with SMTP id
 6a1803df08f44-6d39e107822mr203778346d6.9.1731422585638; Tue, 12 Nov 2024
 06:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
 <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com>
 <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
 <CAOQ4uxh7aT+EvWYMa9v=SyRjfdh4Je_FmS0+TNqonHE5Z+_TPw@mail.gmail.com> <20241112135457.zxzhtoe537gapkmu@quack3>
In-Reply-To: <20241112135457.zxzhtoe537gapkmu@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 15:42:54 +0100
Message-ID: <CAOQ4uxihtPaKT02CSS37DW0JXTPFFnfaRrH781oKHzbpuBC8vw@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="0000000000002c97f80626b83cf0"

--0000000000002c97f80626b83cf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:55=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 12-11-24 09:11:32, Amir Goldstein wrote:
> > On Tue, Nov 12, 2024 at 1:37=E2=80=AFAM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Mon, 11 Nov 2024 at 16:00, Amir Goldstein <amir73il@gmail.com> wro=
te:
> > > >
> > > > I think that's a good idea for pre-content events, because it's fin=
e
> > > > to say that if the sb/mount was not watched by a pre-content event =
listener
> > > > at the time of file open, then we do not care.
> > >
> > > Right.
> > >
> > > > The problem is that legacy inotify/fanotify watches can be added af=
ter
> > > > file is open, so that is allegedly why this optimization was not do=
ne for
> > > > fsnotify hooks in the past.
> > >
> > > So honestly, even if the legacy fsnotify hooks can't look at the file
> > > flag, they could damn well look at an inode flag.
> >
> > Legacy fanotify has a mount watch (FAN_MARK_MOUNT),
> > which is the common way for Anti-malware to set watches on
> > filesystems, so I am not sure what you are saying.
> >
> > > And I'm not even convinced that we couldn't fix them to just look at =
a
> > > file flag, and say "tough luck, somebody opened that file before you
> > > started watching, you don't get to see what they did".
> >
> > That would specifically break tail -f (for inotify) and probably many o=
ther
> > tools, but as long as we also look at the inode flags (i_fsnotify_mask)
> > and the dentry flags (DCACHE_FSNOTIFY_PARENT_WATCHED),
> > then I think we may be able to get away with changing the semantics
> > for open files on a fanotify mount watch.
>
> Yes, I agree we cannot afford to generate FS_MODIFY event only if the mar=
k
> was placed after file open. There's too much stuff in userspace depending
> on this since this behavior dates back to inotify interface sometime in
> 2010 or so.
>
> > Specifically, I would really like to eliminate completely the cost of
> > FAN_ACCESS_PERM event, which could be gated on file flag, because
> > this is only for security/Anti-malware and I don't think this event is
> > practically
> > useful and it sure does not need to guarantee permission events to moun=
t
> > watchers on already open files.
>
> For traditional fanotify permission events I agree generating them only i=
f
> the mark was placed before open is likely fine but we'll have to try and
> see whether something breaks. For the new pre-content events I like the
> per-file flag as Linus suggested. That should indeed save us some cache
> misses in some fast paths.

FWIW, attached a patch that implements FMODE_NOTIFY_PERM
I have asked Oliver to run his performance tests to see if we can
observe an improvement with existing workloads, but is sure is going
to be useful for pre-content events.

For example, here is what the pre content helper looks like after
I adapted Josef's patches to use the flag:

static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
{
        if (!(file->f_mode & FMODE_NOTIFY_PERM))
                return false;

        if (!(file_inode(file)->i_sb->s_iflags & SB_I_ALLOW_HSM))
                return false;

        return fsnotify_file_object_watched(file, FSNOTIFY_PRE_CONTENT_EVEN=
TS);
}

Thanks,
Amir.

--0000000000002c97f80626b83cf0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-opt-in-for-permission-events-at-file_open_p.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-opt-in-for-permission-events-at-file_open_p.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3ek7wxp0>
X-Attachment-Id: f_m3ek7wxp0

RnJvbSA4YzhlOTQ1MmQxNTNhMTkxODQ3MGNiZTUyYThlYjY1MDVjNjc1OTExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEyIE5vdiAyMDI0IDEzOjQ2OjA4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IG9wdC1pbiBmb3IgcGVybWlzc2lvbiBldmVudHMgYXQgZmlsZV9vcGVuX3Blcm0oKQog
dGltZQoKTGVnYWN5IGlub3RpZnkvZmFub3RpZnkgbGlzdGVuZXJzIGNhbiBhZGQgd2F0Y2hlcyBm
b3IgZXZlbnRzIG9uIGlub2RlLApwYXJlbnQgb3IgbW91bnQgYW5kIGV4cGVjdCB0byBnZXQgZXZl
bnRzIChlLmcuIEZTX01PRElGWSkgb24gZmlsZXMgdGhhdAp3ZXJlIGFscmVhZHkgb3BlbiBhdCB0
aGUgdGltZSBvZiBzZXR0aW5nIHVwIHRoZSB3YXRjaGVzLgoKZmFub3RpZnkgcGVybWlzc2lvbiBl
dmVudHMgYXJlIHR5cGljYWxseSB1c2VkIGJ5IEFudGktbWFsd2FyZSBzb2Z3YXJlLAp0aGF0IGlz
IHdhdGNoaW5nIHRoZSBlbnRpcmUgbW91bnQgYW5kIGl0IGlzIG5vdCBjb21tb24gdG8gaGF2ZSBt
b3JlIHRoYXQKb25lIEFudGktbWFsd2FyZSBlbmdpbmUgaW5zdGFsbGVkIG9uIGEgc3lzdGVtLgoK
VG8gcmVkdWNlIHRoZSBvdmVyaGVhZCBvZiB0aGUgZnNub3RpZnlfZmlsZV9wZXJtKCkgaG9va3Mg
b24gZXZlcnkgZmlsZQphY2Nlc3MsIHJlbGF4IHRoZSBzZW1hbnRpY3Mgb2YgdGhlIGxlZ2FjeSBG
QU5fT1BFTl9QRVJNIGV2ZW50IHRvIGdlbmVyYXRlCmV2ZW50cyBvbmx5IGlmIHRoZXJlIHdlcmUg
KmFueSogcGVybWlzc2lvbiBldmVudCBsaXN0ZW5lcnMgb24gdGhlCmZpbGVzeXN0ZW0gYXQgdGhl
IHRpbWUgdGhhdCB0aGUgZmlsZSB3YXMgb3Blbi4KClRoZSBuZXcgc2VtYW50aWNzLCBpbXBsZW1l
bnRlZCB3aXRoIHRoZSBvcHQtaW4gRk1PREVfTk9USUZZX1BFUk0gZmxhZwphcmUgYWxzbyBnb2lu
ZyB0byBhcHBseSB0byB0aGUgbmV3IGZhbm90aWZ5IHByZS1jb250ZW50IGV2ZW50IGluIG9yZGVy
CnRvIHJlZHVjZSB0aGUgY29zdCBvZiB0aGUgcHJlLWNvbnRlbnQgZXZlbnQgdmZzIGhvb2tzLgoK
U3VnZ2VzdGVkLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5v
cmc+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvQ0FIay09d2o4
TD1tdGNSVGk9TkVDSE1HZlpRZ1hPcF91aXgxWVZoMDRmRW1yS2FNblhBQG1haWwuZ21haWwuY29t
LwpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0K
IGluY2x1ZGUvbGludXgvZnMuaCAgICAgICB8ICAzICsrLQogaW5jbHVkZS9saW51eC9mc25vdGlm
eS5oIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMiBmaWxl
cyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgKaW5kZXggOWMxMzIyMjM2
MmY1Li45YjU4ZTk4ODdlNGIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAorKysgYi9p
bmNsdWRlL2xpbnV4L2ZzLmgKQEAgLTE3Myw3ICsxNzMsOCBAQCB0eXBlZGVmIGludCAoZGlvX2lv
ZG9uZV90KShzdHJ1Y3Qga2lvY2IgKmlvY2IsIGxvZmZfdCBvZmZzZXQsCiAKICNkZWZpbmUJRk1P
REVfTk9SRVVTRQkJKChfX2ZvcmNlIGZtb2RlX3QpKDEgPDwgMjMpKQogCi0vKiBGTU9ERV8qIGJp
dCAyNCAqLworLyogRmlsZSBtYXkgZ2VuZXJhdGUgZmFub3RpZnkgYWNjZXNzIHBlcm1pc3Npb24g
ZXZlbnRzICovCisjZGVmaW5lIEZNT0RFX05PVElGWV9QRVJNCSgoX19mb3JjZSBmbW9kZV90KSgx
IDw8IDI0KSkKIAogLyogRmlsZSBpcyBlbWJlZGRlZCBpbiBiYWNraW5nX2ZpbGUgb2JqZWN0ICov
CiAjZGVmaW5lIEZNT0RFX0JBQ0tJTkcJCSgoX19mb3JjZSBmbW9kZV90KSgxIDw8IDI1KSkKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnNub3RpZnkuaCBiL2luY2x1ZGUvbGludXgvZnNub3Rp
ZnkuaAppbmRleCAyNzg2MjBlMDYzYWIuLmYwZmQzZGNhZTY1NCAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9mc25vdGlmeS5oCisrKyBiL2luY2x1ZGUvbGludXgvZnNub3RpZnkuaApAQCAtMTA4
LDEwICsxMDgsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZnNub3RpZnlfZGVudHJ5KHN0cnVjdCBk
ZW50cnkgKmRlbnRyeSwgX191MzIgbWFzaykKIAlmc25vdGlmeV9wYXJlbnQoZGVudHJ5LCBtYXNr
LCBkZW50cnksIEZTTk9USUZZX0VWRU5UX0RFTlRSWSk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgaW50
IGZzbm90aWZ5X2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUsIF9fdTMyIG1hc2spCisvKiBTaG91bGQg
ZXZlbnRzIGJlIGdlbmVyYXRlZCBvbiB0aGlzIG9wZW4gZmlsZSByZWdhcmRsZXNzIG9mIHdhdGNo
ZXM/ICovCitzdGF0aWMgaW5saW5lIGJvb2wgZnNub3RpZnlfZmlsZV93YXRjaGFibGUoc3RydWN0
IGZpbGUgKmZpbGUsIF9fdTMyIG1hc2spCiB7Ci0JY29uc3Qgc3RydWN0IHBhdGggKnBhdGg7Ci0K
IAkvKgogCSAqIEZNT0RFX05PTk9USUZZIGFyZSBmZHMgZ2VuZXJhdGVkIGJ5IGZhbm90aWZ5IGl0
c2VsZiB3aGljaCBzaG91bGQgbm90CiAJICogZ2VuZXJhdGUgbmV3IGV2ZW50cy4gV2UgYWxzbyBk
b24ndCB3YW50IHRvIGdlbmVyYXRlIGV2ZW50cyBmb3IKQEAgLTExOSwxNCArMTE4LDM3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IGZzbm90aWZ5X2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUsIF9fdTMyIG1h
c2spCiAJICogaGFuZGxlIGNyZWF0aW9uIC8gZGVzdHJ1Y3Rpb24gZXZlbnRzIGFuZCBub3QgInJl
YWwiIGZpbGUgZXZlbnRzLgogCSAqLwogCWlmIChmaWxlLT5mX21vZGUgJiAoRk1PREVfTk9OT1RJ
RlkgfCBGTU9ERV9QQVRIKSkKKwkJcmV0dXJuIGZhbHNlOworCisJLyogUGVybWlzc2lvbiBldmVu
dHMgcmVxdWlyZSB0aGF0IHdhdGNoZXMgYXJlIHNldCBiZWZvcmUgRlNfT1BFTl9QRVJNICovCisJ
aWYgKG1hc2sgJiBBTExfRlNOT1RJRllfUEVSTV9FVkVOVFMgJiB+RlNfT1BFTl9QRVJNICYmCisJ
ICAgICEoZmlsZS0+Zl9tb2RlICYgRk1PREVfTk9USUZZX1BFUk0pKQorCQlyZXR1cm4gZmFsc2U7
CisKKwlyZXR1cm4gdHJ1ZTsKK30KKworc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfZmlsZShz
dHJ1Y3QgZmlsZSAqZmlsZSwgX191MzIgbWFzaykKK3sKKwljb25zdCBzdHJ1Y3QgcGF0aCAqcGF0
aDsKKworCWlmICghZnNub3RpZnlfZmlsZV93YXRjaGFibGUoZmlsZSwgbWFzaykpCiAJCXJldHVy
biAwOwogCiAJcGF0aCA9ICZmaWxlLT5mX3BhdGg7Ci0JLyogUGVybWlzc2lvbiBldmVudHMgcmVx
dWlyZSBncm91cCBwcmlvID49IEZTTk9USUZZX1BSSU9fQ09OVEVOVCAqLwotCWlmIChtYXNrICYg
QUxMX0ZTTk9USUZZX1BFUk1fRVZFTlRTICYmCi0JICAgICFmc25vdGlmeV9zYl9oYXNfcHJpb3Jp
dHlfd2F0Y2hlcnMocGF0aC0+ZGVudHJ5LT5kX3NiLAotCQkJCQkgICAgICAgRlNOT1RJRllfUFJJ
T19DT05URU5UKSkKLQkJcmV0dXJuIDA7CisJLyoKKwkgKiBQZXJtaXNzaW9uIGV2ZW50cyByZXF1
aXJlIGdyb3VwIHByaW8gPj0gRlNOT1RJRllfUFJJT19DT05URU5ULgorCSAqIFVubGVzcyBwZXJt
aXNzaW9uIGV2ZW50IHdhdGNoZXJzIGV4aXN0IGF0IEZTX09QRU5fUEVSTSB0aW1lLAorCSAqIG9w
ZXJhdGlvbnMgb24gZmlsZSB3aWxsIG5vdCBiZSBnZW5lcmF0aW5nIGFueSBwZXJtaXNzaW9uIGV2
ZW50cy4KKwkgKi8KKwlpZiAobWFzayAmIEFMTF9GU05PVElGWV9QRVJNX0VWRU5UUykgeworCQlp
ZiAoIWZzbm90aWZ5X3NiX2hhc19wcmlvcml0eV93YXRjaGVycyhwYXRoLT5kZW50cnktPmRfc2Is
CisJCQkJCQkgICAgICAgRlNOT1RJRllfUFJJT19DT05URU5UKSkKKwkJCXJldHVybiAwOworCisJ
CWlmIChtYXNrICYgRlNfT1BFTl9QRVJNKQorCQkJZmlsZS0+Zl9tb2RlIHw9IEZNT0RFX05PVElG
WV9QRVJNOworCX0KIAogCXJldHVybiBmc25vdGlmeV9wYXJlbnQocGF0aC0+ZGVudHJ5LCBtYXNr
LCBwYXRoLCBGU05PVElGWV9FVkVOVF9QQVRIKTsKIH0KQEAgLTE2NiwxNSArMTg4LDEyIEBAIHN0
YXRpYyBpbmxpbmUgaW50IGZzbm90aWZ5X2ZpbGVfcGVybShzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50
IHBlcm1fbWFzaykKICAqLwogc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfb3Blbl9wZXJtKHN0
cnVjdCBmaWxlICpmaWxlKQogewotCWludCByZXQ7CisJaW50IHJldCA9IGZzbm90aWZ5X2ZpbGUo
ZmlsZSwgRlNfT1BFTl9QRVJNKTsKIAotCWlmIChmaWxlLT5mX2ZsYWdzICYgX19GTU9ERV9FWEVD
KSB7CisJaWYgKCFyZXQgJiYgZmlsZS0+Zl9mbGFncyAmIF9fRk1PREVfRVhFQykKIAkJcmV0ID0g
ZnNub3RpZnlfZmlsZShmaWxlLCBGU19PUEVOX0VYRUNfUEVSTSk7Ci0JCWlmIChyZXQpCi0JCQly
ZXR1cm4gcmV0OwotCX0KIAotCXJldHVybiBmc25vdGlmeV9maWxlKGZpbGUsIEZTX09QRU5fUEVS
TSk7CisJcmV0dXJuIHJldDsKIH0KIAogI2Vsc2UKLS0gCjIuMzQuMQoK
--0000000000002c97f80626b83cf0--

