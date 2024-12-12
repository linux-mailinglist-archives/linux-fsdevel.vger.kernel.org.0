Return-Path: <linux-fsdevel+bounces-37176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9547C9EE9A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFC416650F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC722156EA;
	Thu, 12 Dec 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTW9lM1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731292EAE5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015754; cv=none; b=G+l+KMBuDTAlDNYWlYFinfRK6YSYVRsakb4efct27M4/NrFd2yTeRROZCIg/s7xTsshJqcJlzP0PzjmBpv9JJjUBUh3Ux1eutOpWdUQRSsIJ8GTe+ADgMhVspLtjKHRgBPTeqvvYUfuvHfmCLJt5ZEw1cDY+BLUgRpO74VVmPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015754; c=relaxed/simple;
	bh=xrAKakLajENaes8MZW1xN350bnWpgkkdg6KqZySy4nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUy7jicf+Uq2JNj7ZeYqxco2RU06jbbj1eHU0wT/Cy5lYOIPbDl1g74Ch+ks3zG79wpoDt4dR9rFqBKXF5kiFvnnUj6IEkKZLSw4rzkEnqrDrUSe/pkz7PnDpfVJu6jC/DAQrQrO1zJf0NatT2eVMV/fujpd3dV84jw6J0P5qpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTW9lM1w; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so1215201a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734015751; x=1734620551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1M8PUmc3BzNgDhP9HDAwAKHwg4cwUuiQEGq492IGxY=;
        b=VTW9lM1wc1bO4A0KXaSURo5H6kYetER3u7G9/AgwZ8D+m6EvdWiaERzZ3HIQQpc6Jq
         F78jQf4k3wFT8kQ8VfoQNQW2/wtCIcWt4ADZMMV34gNyg3nuzwG0H+W1RWlT4/UPeLZv
         dCG7u05EgBZ77qZinq80q00lQ6SeGN3mObzHBvakl50m0ddtmlHdko6KOTfjH4fqrc2H
         O/shq9BLT09Q2jHCOswXH3vXVqn2MsznzV0AtseW/6yH3Vj1/r0Bv6/LZmYud/qb7FvL
         SPZEASzsLSxfaWwa/R7GvQHt71s9TsaTAsAF5lGYXmEZk6ccVgXLGOGPWRDsf6yiKa36
         r4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734015751; x=1734620551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1M8PUmc3BzNgDhP9HDAwAKHwg4cwUuiQEGq492IGxY=;
        b=EyU7lPcx0mL4fu381XkXBEVkrttIwcyGU+EdUDAbP81gzPTMTrg+HYBwd6pDBSBPnB
         yYhp475f5P6TWXjt6vJdFBAY80YgHqXGqXoOcXTC8os3LK213cRDIw8HhBNRsl333Rti
         zFHxmdxpUXd0HGfNo7wr1bAW88vHtAcakGcWgQA3LtXmHxBEF+as8A8oXnz6ZHtVgZQ1
         7lb/d7VJbM3CIJJ3pRItDxZYKYLoqSnSvBreGyeyDgyarydUEM2ETcriTIu+vIIrZdg0
         gFOGWQMpXWUTqxnFPPt2btsd9c9pgEYW6mZpOm12XTDVrB29M+KQTNbAeEDcb0Blxrlu
         8LwA==
X-Forwarded-Encrypted: i=1; AJvYcCV+nc9SvLvkDDP0QqWbRmxiqLbCXs4hg0CYHidjuqg8+ujJj5VHWLrNViljRKBmcvRgqi14NPhOrtKHbdW2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4hY2g3YUnx/Fkeh4QGiMUwLLlLaIKUWqDbGA3X/iZWEEm0W+
	c9CG23R9LGOdl26N3Qkp1F1KN7YEkNbGzQZWKCMhLK0+mey+4JJzPmPLfoYnUBtRzebxeY9IW3D
	YVbP1+EBFdAvtLbWhgwXYb22Cmg0=
X-Gm-Gg: ASbGncuNhR9MJ2qUA9jJB7yQQqcq8XQyqbzwEruO3KJxLE6uoWGtrK3KahjcO0YCJAW
	ztQbiCIkUMDiPW/q74R4w8TcFEvPCEpMcioT+PA==
X-Google-Smtp-Source: AGHT+IEmOHraXbZN8q3u9MIhqwwnu2gh5tCNuqWMUFx3tPUPlZ0+Miw7rnoZRzELb9q5UbT4+4/izFShaWx9x5I7eiI=
X-Received: by 2002:a05:6402:5215:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5d633cb1120mr844129a12.26.1734015748202; Thu, 12 Dec 2024
 07:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153709.149603-1-mszeredi@redhat.com> <20241212112707.6ueqp5fwgk64bry2@quack3>
 <CAJfpeguN6bfPa1rBWHFcA4HhCCkHN_CatGB4cC-z6mKa_dckWA@mail.gmail.com>
In-Reply-To: <CAJfpeguN6bfPa1rBWHFcA4HhCCkHN_CatGB4cC-z6mKa_dckWA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Dec 2024 16:02:16 +0100
Message-ID: <CAOQ4uxhNCg53mcNpzDyos3BV5dmL=2FVAipb4YKYmK3bvEzaBQ@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify: notify on mount attach and detach
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000b54fd40629140032"

--000000000000b54fd40629140032
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:45=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 12 Dec 2024 at 12:27, Jan Kara <jack@suse.cz> wrote:
>
> > Why not:
> >         if (p->prev_ns =3D=3D p->mnt_ns) {
> >                 fsnotify_mnt_move(p->mnt_ns, &p->mnt);
> >                 return;
> >         }
>
> I don't really care, but I think this fails both as an optimization
> (zero chance of actually making a difference) and as a readability
> improvement.
>
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanot=
ify.c
> > > index 24c7c5df4998..a9dc004291bf 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify=
_event *old,
> > >       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> > >               return fanotify_error_event_equal(FANOTIFY_EE(old),
> > >                                                 FANOTIFY_EE(new));
> > > +     case FANOTIFY_EVENT_TYPE_MNT:
> > > +             return false;
> >
> > Perhaps instead of handling this in fanotify_should_merge(), we could
> > modify fanotify_merge() directly to don't even try if the event is of t=
ype
> > FANOTIFY_EVENT_TYPE_MNT? Similarly as we do it there for permission eve=
nts.
>
> Okay.

Actually, I disagree.
For permission events there is a conceptual reason not to merge,
but this is not true for mount events.

Miklos said that he is going to add a FAN_MOUNT_MODIFY event
for changing mount properties and we should very much merge multiple
mount modify events.

Furthermore, I wrote my comment about not merging mount events
back when the mount event info included the parent mntid.
Now that the mount event includes only the mount's mntid itself,
multiple mount moves *could* actually be merged to a single move
and a detach + attach could be merged to a move.
Do we want to merge mount move events? that is a different question
I guess we don't, but any case this means that the check should remain
where it is now, so that we can check for specific mount events in the
mask to decide whether or not to merge them.

>
> >
> > > @@ -303,7 +305,11 @@ static u32 fanotify_group_event_mask(struct fsno=
tify_group *group,
> > >       pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_type=3D=
%d\n",
> > >                __func__, iter_info->report_mask, event_mask, data, da=
ta_type);
> > >
> > > -     if (!fid_mode) {
> > > +     if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > > +     {
> >
> > Unusual style here..
>
> Yeah, fixed.
>
> > Now if we expect these mount notification groups will not have more tha=
n
> > these two events, then probably it isn't worth the hassle. If we expect
> > more event types may eventually materialize, it may be worth it. What d=
o
> > people think?
>
> I have a bad feeling about just overloading mask values.  How about
> reserving a single mask bit for all mount events?  I.e.
>
> #define FAN_MNT_ATTACH 0x00100001
> #define FAN_MNT_DETACH 0x00100002

This is problematic.
Because the bits reported in event->mask are often masked
using this model makes assumptions that are not less risky
that the risk of overloading 0x1 0x2 IMO.

I was contemplating deferring the decision about overloading for a while
by using high bits for mount events.
fanotify_mark() mask is already 64bit with high bits reserved
and fanotify_event_metadata->mask is also 64bit.

The challenge is that all internal fsnotify code uses __u32 masks
and so do {i,sb,mnt}_fsnotify_mask.

However, as I have already claimed, maintaining the mount event bits
in the calculated object mask is not very helpful IMO.

Attached demo patch that sends all mount events to group IFF
group has a mount mark.

This is quite simple, but could also be extended later with a little
more work to allow sb/mount mark to actually subscribe to mount events
or to ignore mount events for a specific sb/mount, if we think this is usef=
ul.

WDYT?

Thanks,
Amir.

--000000000000b54fd40629140032
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-demo-send-all-mount-events-to-mount-watcher.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-demo-send-all-mount-events-to-mount-watcher.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4lfvlh70>
X-Attachment-Id: f_m4lfvlh70

RnJvbSAwMTI5NWJlNGRmMTA1M2I4M2EzM2M4MGZkYTEzOGVjNTczNGFjODU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDEyIERlYyAyMDI0IDE1OjExOjI4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IGRlbW8gc2VuZCBhbGwgbW91bnQgZXZlbnRzIHRvIG1vdW50IHdhdGNoZXJzCgpTaG91
bGQgYmUgY2hhbmdlZCB0byBzZW5kIG1vdW50IGV2ZW50IHRvIGFsbCBncm91cHMgd2l0aCBtbnRu
cwptYXJrcyBvbiB0aGUgcmVzcGVjdGl2ZSBtbnRucy4KLS0tCiBmcy9ub3RpZnkvZmFub3RpZnkv
ZmFub3RpZnkuYyAgICB8IDIzICsrKysrKysrKysrKysrKysrLS0tLS0tCiBmcy9ub3RpZnkvZnNu
b3RpZnkuYyAgICAgICAgICAgICB8IDE2ICsrKysrKysrKy0tLS0tLS0KIGluY2x1ZGUvbGludXgv
ZnNub3RpZnlfYmFja2VuZC5oIHwgIDggKysrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgMzEgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zhbm90
aWZ5L2Zhbm90aWZ5LmMgYi9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnkuYwppbmRleCA5NTY0
NmY3YzQ2Y2EuLmQxYzA1ZTJhMTJkYSAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zh
bm90aWZ5LmMKKysrIGIvZnMvbm90aWZ5L2Zhbm90aWZ5L2Zhbm90aWZ5LmMKQEAgLTI5Niw3ICsy
OTYsNyBAQCBzdGF0aWMgaW50IGZhbm90aWZ5X2dldF9yZXNwb25zZShzdHJ1Y3QgZnNub3RpZnlf
Z3JvdXAgKmdyb3VwLAogICovCiBzdGF0aWMgdTMyIGZhbm90aWZ5X2dyb3VwX2V2ZW50X21hc2so
c3RydWN0IGZzbm90aWZ5X2dyb3VwICpncm91cCwKIAkJCQkgICAgIHN0cnVjdCBmc25vdGlmeV9p
dGVyX2luZm8gKml0ZXJfaW5mbywKLQkJCQkgICAgIHUzMiAqbWF0Y2hfbWFzaywgdTMyIGV2ZW50
X21hc2ssCisJCQkJICAgICB1MzIgKm1hdGNoX21hc2ssIHU2NCBldmVudF9tYXNrLAogCQkJCSAg
ICAgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwKIAkJCQkgICAgIHN0cnVjdCBpbm9k
ZSAqZGlyKQogewpAQCAtMzA5LDEwICszMDksMTQgQEAgc3RhdGljIHUzMiBmYW5vdGlmeV9ncm91
cF9ldmVudF9tYXNrKHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCiAJYm9vbCBvbmRpciA9
IGV2ZW50X21hc2sgJiBGQU5fT05ESVI7CiAJaW50IHR5cGU7CiAKLQlwcl9kZWJ1ZygiJXM6IHJl
cG9ydF9tYXNrPSV4IG1hc2s9JXggZGF0YT0lcCBkYXRhX3R5cGU9JWRcbiIsCisJcHJfZGVidWco
IiVzOiByZXBvcnRfbWFzaz0leCBtYXNrPSVsbHggZGF0YT0lcCBkYXRhX3R5cGU9JWRcbiIsCiAJ
CSBfX2Z1bmNfXywgaXRlcl9pbmZvLT5yZXBvcnRfbWFzaywgZXZlbnRfbWFzaywgZGF0YSwgZGF0
YV90eXBlKTsKIAotCWlmICghZmlkX21vZGUpIHsKKwlpZiAoZXZlbnRfbWFzayAmIEZTX01PVU5U
X0VWRU5UUykgeworCQkvKiBNb3VudCBldmVudHMgYXJlIG5vdCBhYm91dCBhIHNwZWNpZmljIHBh
dGggKi8KKwkJaWYgKHBhdGgpCisJCQlyZXR1cm4gMDsKKwl9IGVsc2UgaWYgKCFmaWRfbW9kZSkg
ewogCQkvKiBEbyB3ZSBoYXZlIHBhdGggdG8gb3BlbiBhIGZpbGUgZGVzY3JpcHRvcj8gKi8KIAkJ
aWYgKCFwYXRoKQogCQkJcmV0dXJuIDA7CkBAIC0zMjYsNiArMzMwLDggQEAgc3RhdGljIHUzMiBm
YW5vdGlmeV9ncm91cF9ldmVudF9tYXNrKHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCiAJ
fQogCiAJZnNub3RpZnlfZm9yZWFjaF9pdGVyX21hcmtfdHlwZShpdGVyX2luZm8sIG1hcmssIHR5
cGUpIHsKKwkJaWYgKHR5cGUgPT0gRlNOT1RJRllfSVRFUl9UWVBFX1ZGU01PVU5UKQorCQkJbWFy
a3NfbWFzayB8PSBGU19NT1VOVF9FVkVOVFM7CiAJCS8qCiAJCSAqIEFwcGx5IGlnbm9yZSBtYXNr
IGRlcGVuZGluZyBvbiBldmVudCBmbGFncyBpbiBpZ25vcmUgbWFzay4KIAkJICovCkBAIC03MjAs
NyArNzI2LDcgQEAgc3RhdGljIHN0cnVjdCBmYW5vdGlmeV9ldmVudCAqZmFub3RpZnlfYWxsb2Nf
ZXJyb3JfZXZlbnQoCiAKIHN0YXRpYyBzdHJ1Y3QgZmFub3RpZnlfZXZlbnQgKmZhbm90aWZ5X2Fs
bG9jX2V2ZW50KAogCQkJCXN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCi0JCQkJdTMyIG1h
c2ssIGNvbnN0IHZvaWQgKmRhdGEsIGludCBkYXRhX3R5cGUsCisJCQkJdTY0IG1hc2ssIGNvbnN0
IHZvaWQgKmRhdGEsIGludCBkYXRhX3R5cGUsCiAJCQkJc3RydWN0IGlub2RlICpkaXIsIGNvbnN0
IHN0cnVjdCBxc3RyICpmaWxlX25hbWUsCiAJCQkJX19rZXJuZWxfZnNpZF90ICpmc2lkLCB1MzIg
bWF0Y2hfbWFzaykKIHsKQEAgLTgyNiw2ICs4MzIsMTEgQEAgc3RhdGljIHN0cnVjdCBmYW5vdGlm
eV9ldmVudCAqZmFub3RpZnlfYWxsb2NfZXZlbnQoCiAJCQkJCQkgIG1vdmVkLCAmaGFzaCwgZ2Zw
KTsKIAl9IGVsc2UgaWYgKGZpZF9tb2RlKSB7CiAJCWV2ZW50ID0gZmFub3RpZnlfYWxsb2NfZmlk
X2V2ZW50KGlkLCBmc2lkLCAmaGFzaCwgZ2ZwKTsKKwl9IGVsc2UgaWYgKG1hc2sgJiBGU19NT1VO
VF9FVkVOVFMpIHsKKwkJbWFzayA8PD0gMzI7CisJCXN0cnVjdCBwYXRoIG51bGxfcGF0aCA9IHt9
OworCQkvKiBYWFg6IGFsbG9jYXRlIG1vdW50IGV2ZW50ICovCisJCWV2ZW50ID0gZmFub3RpZnlf
YWxsb2NfcGF0aF9ldmVudCgmbnVsbF9wYXRoLCAmaGFzaCwgZ2ZwKTsKIAl9IGVsc2UgewogCQll
dmVudCA9IGZhbm90aWZ5X2FsbG9jX3BhdGhfZXZlbnQocGF0aCwgJmhhc2gsIGdmcCk7CiAJfQpA
QCAtODkyLDcgKzkwMyw3IEBAIHN0YXRpYyB2b2lkIGZhbm90aWZ5X2luc2VydF9ldmVudChzdHJ1
Y3QgZnNub3RpZnlfZ3JvdXAgKmdyb3VwLAogCWhsaXN0X2FkZF9oZWFkKCZldmVudC0+bWVyZ2Vf
bGlzdCwgaGxpc3QpOwogfQogCi1zdGF0aWMgaW50IGZhbm90aWZ5X2hhbmRsZV9ldmVudChzdHJ1
Y3QgZnNub3RpZnlfZ3JvdXAgKmdyb3VwLCB1MzIgbWFzaywKK3N0YXRpYyBpbnQgZmFub3RpZnlf
aGFuZGxlX2V2ZW50KHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsIHU2NCBtYXNrLAogCQkJ
CSBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90eXBlLAogCQkJCSBzdHJ1Y3QgaW5vZGUgKmRp
ciwKIAkJCQkgY29uc3Qgc3RydWN0IHFzdHIgKmZpbGVfbmFtZSwgdTMyIGNvb2tpZSwKQEAgLTkz
NCw3ICs5NDUsNyBAQCBzdGF0aWMgaW50IGZhbm90aWZ5X2hhbmRsZV9ldmVudChzdHJ1Y3QgZnNu
b3RpZnlfZ3JvdXAgKmdyb3VwLCB1MzIgbWFzaywKIAlpZiAoIW1hc2spCiAJCXJldHVybiAwOwog
Ci0JcHJfZGVidWcoIiVzOiBncm91cD0lcCBtYXNrPSV4IHJlcG9ydF9tYXNrPSV4XG4iLCBfX2Z1
bmNfXywKKwlwcl9kZWJ1ZygiJXM6IGdyb3VwPSVwIG1hc2s9JWxseCByZXBvcnRfbWFzaz0leFxu
IiwgX19mdW5jX18sCiAJCSBncm91cCwgbWFzaywgbWF0Y2hfbWFzayk7CiAKIAlpZiAoZmFub3Rp
ZnlfaXNfcGVybV9ldmVudChtYXNrKSkgewpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zzbm90aWZ5
LmMgYi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCA4ZWU0OTVhNThkMGEuLmUxODMzZDdiOWIz
YyAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIvZnMvbm90aWZ5L2Zzbm90
aWZ5LmMKQEAgLTM3MiwxMyArMzcyLDEzIEBAIHN0YXRpYyBpbnQgZnNub3RpZnlfaGFuZGxlX2V2
ZW50KHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsIF9fdTMyIG1hc2ssCiAJCQkJCSAgIGRp
ciwgbmFtZSwgY29va2llKTsKIH0KIAotc3RhdGljIGludCBzZW5kX3RvX2dyb3VwKF9fdTMyIG1h
c2ssIGNvbnN0IHZvaWQgKmRhdGEsIGludCBkYXRhX3R5cGUsCitzdGF0aWMgaW50IHNlbmRfdG9f
Z3JvdXAoX191NjQgbWFzaywgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwKIAkJCSBz
dHJ1Y3QgaW5vZGUgKmRpciwgY29uc3Qgc3RydWN0IHFzdHIgKmZpbGVfbmFtZSwKIAkJCSB1MzIg
Y29va2llLCBzdHJ1Y3QgZnNub3RpZnlfaXRlcl9pbmZvICppdGVyX2luZm8pCiB7CiAJc3RydWN0
IGZzbm90aWZ5X2dyb3VwICpncm91cCA9IE5VTEw7Ci0JX191MzIgdGVzdF9tYXNrID0gKG1hc2sg
JiBBTExfRlNOT1RJRllfRVZFTlRTKTsKLQlfX3UzMiBtYXJrc19tYXNrID0gMDsKKwlfX3U2NCB0
ZXN0X21hc2sgPSAobWFzayAmIEFMTF9GU05PVElGWV9FVkVOVFMpOworCV9fdTY0IG1hcmtzX21h
c2sgPSAwOwogCV9fdTMyIG1hcmtzX2lnbm9yZV9tYXNrID0gMDsKIAlib29sIGlzX2RpciA9IG1h
c2sgJiBGU19JU0RJUjsKIAlzdHJ1Y3QgZnNub3RpZnlfbWFyayAqbWFyazsKQEAgLTM5OCwxMyAr
Mzk4LDE1IEBAIHN0YXRpYyBpbnQgc2VuZF90b19ncm91cChfX3UzMiBtYXNrLCBjb25zdCB2b2lk
ICpkYXRhLCBpbnQgZGF0YV90eXBlLAogCiAJLyogQXJlIGFueSBvZiB0aGUgZ3JvdXAgbWFya3Mg
aW50ZXJlc3RlZCBpbiB0aGlzIGV2ZW50PyAqLwogCWZzbm90aWZ5X2ZvcmVhY2hfaXRlcl9tYXJr
X3R5cGUoaXRlcl9pbmZvLCBtYXJrLCB0eXBlKSB7CisJCWlmICh0eXBlID09IEZTTk9USUZZX0lU
RVJfVFlQRV9WRlNNT1VOVCkKKwkJCW1hcmtzX21hc2sgfD0gRlNfTU9VTlRfRVZFTlRTOwogCQln
cm91cCA9IG1hcmstPmdyb3VwOwogCQltYXJrc19tYXNrIHw9IG1hcmstPm1hc2s7CiAJCW1hcmtz
X2lnbm9yZV9tYXNrIHw9CiAJCQlmc25vdGlmeV9lZmZlY3RpdmVfaWdub3JlX21hc2sobWFyaywg
aXNfZGlyLCB0eXBlKTsKIAl9CiAKLQlwcl9kZWJ1ZygiJXM6IGdyb3VwPSVwIG1hc2s9JXggbWFy
a3NfbWFzaz0leCBtYXJrc19pZ25vcmVfbWFzaz0leCBkYXRhPSVwIGRhdGFfdHlwZT0lZCBkaXI9
JXAgY29va2llPSVkXG4iLAorCXByX2RlYnVnKCIlczogZ3JvdXA9JXAgbWFzaz0lbGx4IG1hcmtz
X21hc2s9JWxseCBtYXJrc19pZ25vcmVfbWFzaz0leCBkYXRhPSVwIGRhdGFfdHlwZT0lZCBkaXI9
JXAgY29va2llPSVkXG4iLAogCQkgX19mdW5jX18sIGdyb3VwLCBtYXNrLCBtYXJrc19tYXNrLCBt
YXJrc19pZ25vcmVfbWFzaywKIAkJIGRhdGEsIGRhdGFfdHlwZSwgZGlyLCBjb29raWUpOwogCkBA
IC01MzMsNyArNTM1LDcgQEAgc3RhdGljIHZvaWQgZnNub3RpZnlfaXRlcl9uZXh0KHN0cnVjdCBm
c25vdGlmeV9pdGVyX2luZm8gKml0ZXJfaW5mbykKICAqCQlyZXBvcnRlZCB0byBib3RoLgogICog
QGNvb2tpZToJaW5vdGlmeSByZW5hbWUgY29va2llCiAgKi8KLWludCBmc25vdGlmeShfX3UzMiBt
YXNrLCBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90eXBlLCBzdHJ1Y3QgaW5vZGUgKmRpciwK
K2ludCBmc25vdGlmeShfX3U2NCBtYXNrLCBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90eXBl
LCBzdHJ1Y3QgaW5vZGUgKmRpciwKIAkgICAgIGNvbnN0IHN0cnVjdCBxc3RyICpmaWxlX25hbWUs
IHN0cnVjdCBpbm9kZSAqaW5vZGUsIHUzMiBjb29raWUpCiB7CiAJY29uc3Qgc3RydWN0IHBhdGgg
KnBhdGggPSBmc25vdGlmeV9kYXRhX3BhdGgoZGF0YSwgZGF0YV90eXBlKTsKQEAgLTU0NSw3ICs1
NDcsNyBAQCBpbnQgZnNub3RpZnkoX191MzIgbWFzaywgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRh
dGFfdHlwZSwgc3RydWN0IGlub2RlICpkaXIsCiAJc3RydWN0IGRlbnRyeSAqbW92ZWQ7CiAJaW50
IGlub2RlMl90eXBlOwogCWludCByZXQgPSAwOwotCV9fdTMyIHRlc3RfbWFzaywgbWFya3NfbWFz
azsKKwlfX3U2NCB0ZXN0X21hc2ssIG1hcmtzX21hc2s7CiAKIAlpZiAocGF0aCkKIAkJbW50ID0g
cmVhbF9tb3VudChwYXRoLT5tbnQpOwpAQCAtNTgzLDcgKzU4NSw3IEBAIGludCBmc25vdGlmeShf
X3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90eXBlLCBzdHJ1Y3QgaW5vZGUg
KmRpciwKIAogCW1hcmtzX21hc2sgPSBSRUFEX09OQ0Uoc2ItPnNfZnNub3RpZnlfbWFzayk7CiAJ
aWYgKG1udCkKLQkJbWFya3NfbWFzayB8PSBSRUFEX09OQ0UobW50LT5tbnRfZnNub3RpZnlfbWFz
ayk7CisJCW1hcmtzX21hc2sgfD0gUkVBRF9PTkNFKG1udC0+bW50X2Zzbm90aWZ5X21hc2spIHwg
RlNfTU9VTlRfRVZFTlRTOwogCWlmIChpbm9kZSkKIAkJbWFya3NfbWFzayB8PSBSRUFEX09OQ0Uo
aW5vZGUtPmlfZnNub3RpZnlfbWFzayk7CiAJaWYgKGlub2RlMikKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNr
ZW5kLmgKaW5kZXggMGQyNGEyMWE4ZTYwLi41OGI1YWM3NWY1ZjQgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oCisrKyBiL2luY2x1ZGUvbGludXgvZnNub3RpZnlf
YmFja2VuZC5oCkBAIC0xMDYsNiArMTA2LDggQEAKICAqLwogI2RlZmluZSBGU19FVkVOVFNfUE9T
U19UT19QQVJFTlQgKEZTX0VWRU5UU19QT1NTX09OX0NISUxEKQogCisjZGVmaW5lIEZTX01PVU5U
X0VWRU5UUyAoMHhmVUwgPDwgMzIpCisKIC8qIEV2ZW50cyB0aGF0IGNhbiBiZSByZXBvcnRlZCB0
byBiYWNrZW5kcyAqLwogI2RlZmluZSBBTExfRlNOT1RJRllfRVZFTlRTIChBTExfRlNOT1RJRllf
RElSRU5UX0VWRU5UUyB8IFwKIAkJCSAgICAgRlNfRVZFTlRTX1BPU1NfT05fQ0hJTEQgfCBcCkBA
IC0xNjIsNyArMTY0LDcgQEAgc3RydWN0IG1lbV9jZ3JvdXA7CiAgKgkJdXNlcnNwYWNlIG1lc3Nh
Z2VzIHRoYXQgbWFya3MgaGF2ZSBiZWVuIHJlbW92ZWQuCiAgKi8KIHN0cnVjdCBmc25vdGlmeV9v
cHMgewotCWludCAoKmhhbmRsZV9ldmVudCkoc3RydWN0IGZzbm90aWZ5X2dyb3VwICpncm91cCwg
dTMyIG1hc2ssCisJaW50ICgqaGFuZGxlX2V2ZW50KShzdHJ1Y3QgZnNub3RpZnlfZ3JvdXAgKmdy
b3VwLCB1NjQgbWFzaywKIAkJCSAgICBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90eXBlLCBz
dHJ1Y3QgaW5vZGUgKmRpciwKIAkJCSAgICBjb25zdCBzdHJ1Y3QgcXN0ciAqZmlsZV9uYW1lLCB1
MzIgY29va2llLAogCQkJICAgIHN0cnVjdCBmc25vdGlmeV9pdGVyX2luZm8gKml0ZXJfaW5mbyk7
CkBAIC02MDUsNyArNjA3LDcgQEAgc3RydWN0IGZzbm90aWZ5X21hcmsgewogLyogY2FsbGVkIGZy
b20gdGhlIHZmcyBoZWxwZXJzICovCiAKIC8qIG1haW4gZnNub3RpZnkgY2FsbCB0byBzZW5kIGV2
ZW50cyAqLwotZXh0ZXJuIGludCBmc25vdGlmeShfX3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRh
LCBpbnQgZGF0YV90eXBlLAorZXh0ZXJuIGludCBmc25vdGlmeShfX3U2NCBtYXNrLCBjb25zdCB2
b2lkICpkYXRhLCBpbnQgZGF0YV90eXBlLAogCQkgICAgc3RydWN0IGlub2RlICpkaXIsIGNvbnN0
IHN0cnVjdCBxc3RyICpuYW1lLAogCQkgICAgc3RydWN0IGlub2RlICppbm9kZSwgdTMyIGNvb2tp
ZSk7CiBleHRlcm4gaW50IF9fZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwg
X191MzIgbWFzaywgY29uc3Qgdm9pZCAqZGF0YSwKQEAgLTkwNiw3ICs5MDgsNyBAQCBzdGF0aWMg
aW5saW5lIGludCBmc25vdGlmeV9wcmVfY29udGVudChjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwK
IAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnkoX191MzIgbWFzaywg
Y29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwKK3N0YXRpYyBpbmxpbmUgaW50IGZzbm90
aWZ5KF9fdTY0IG1hc2ssIGNvbnN0IHZvaWQgKmRhdGEsIGludCBkYXRhX3R5cGUsCiAJCQkgICBz
dHJ1Y3QgaW5vZGUgKmRpciwgY29uc3Qgc3RydWN0IHFzdHIgKm5hbWUsCiAJCQkgICBzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCB1MzIgY29va2llKQogewotLSAKMi4zNC4xCgo=
--000000000000b54fd40629140032--

