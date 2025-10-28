Return-Path: <linux-fsdevel+bounces-65939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E21EC15C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA16E188A324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571923469EF;
	Tue, 28 Oct 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj6vOuze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DD278E5D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668028; cv=none; b=CsB0fceE+ykwjn+u59Yc7B87SmVY5Oyf+YkqR40K3lIsOkME0U017Eq5ZHMx6ARDZROSxmP4/KhXFzO6bpwh9FlWpV82x73IhZYpmdmgJb+xr779RE4BB5Nch1S7Uf2g5em581JGAP0uZcx4zW0G9j7g54haK74S0bX38wpvFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668028; c=relaxed/simple;
	bh=joeG9s1IK0x5FDvibJ7jPQHlkmfdSgjP+of8cmTKQqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opBYn5sUc2pm4GCfB0Vw2QQgpMVk1wDOFlRqgKv0Y1Gkdy/7fit/nowd0h2twXfmd2sMGhIeUHde1jJ3R8v77vWR77SUuRPoI0XhMgyBcwPj+qawDcwcjN1w2lT7MjyKaKEe1wVmqu+r75shlMgFP3z+SYhJQ/Zo7bDON9eL9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj6vOuze; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3d5bb138b2cso552316fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761668024; x=1762272824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JkLO8uSDTo8WL1YVm9YgsbnmVg6I2uWeOBylZ2bSG0Y=;
        b=Qj6vOuze6F6/kDseshHIL6mtuxTqs2j2wkZH6enCslSiiLrEwnQl2dJThN0mqTbO5k
         oyPGnl3USTCzstXGMhlj2vpi64pxXFFg9gZc4JhVt2XAz9Z9awin2v52XSKRa6v9zVU7
         1Ljmizrsh0+JxpFlQKK/0PDoyNZqzHYOLRvSxr/XODTWq8Z8oG+ZwApbFC6jyr8+lvaX
         yBPpMNbgmslamJYLQaX9AXR9+749bgNCmEqBzkAVHtRy3TCzVGL77ioG2xAbTTDhBwbu
         2R5Ee7pvfBfQ33h1zFm1RpRpvWJ06W2g+LZO31bciwPxkjuycUZ3VyZjTMApig0tTqZT
         BSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668024; x=1762272824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkLO8uSDTo8WL1YVm9YgsbnmVg6I2uWeOBylZ2bSG0Y=;
        b=FXPsFQDHtv6J4f3a/PGmYbwTmhtse3BgQkyfRdhG1qybmHdaX9sPYw2O5PkaTGUImO
         1rFP1h8CmZJx7bOVufKAJJyhx/+9etSGIySXBJjP5MmQD7fhJy7R8LsEHvGpM1yW9aFV
         EVi1+S8tvCN4Q1Bu+V8fWZJ4ieZi3gaPhNAzCReJmC742Zltc3t87XPRdW2PajapQcUa
         aeHcyNBHmJCxcXRIUmBSGLq4JMlJgtkDi2POMnpCtV9RVAGZhoov5kiZzTPJBSJ5mo6h
         s8roM5OFZeoVF+VmlawU6N5b1oE++AKibjzXwskyCGOXlIqixlD3Ew2o7CBcyYBJ3dqS
         SR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtn93SG/KJ4cqVVPgebJSzOTp7lb8fq/uyz477bmKiZZfLEHWLomDNFkjeu7pYZa1iuFv2wMx8GBVYxKN0@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfykFvan3IfFNOD4LdJ8w8KsZrjqnJ19u2e08bTssNQG58EaR
	ACk/rRy7cuOw93vut3KOBUQLYWuxXa9mLt4WnXwY/eoVfHCeGq1uThnc+JaBNbEoEaS5KlWv5DS
	dV+CBZp+IK7SwLIOGccPEiwWPRHeEnX0=
X-Gm-Gg: ASbGnct/RXflkiqk3yyAdZNalIfdigFA5W7iFQ4aefc9LY1CJXWK6dhCmah8Fd7iOi2
	i0FK01MQ3nUF+PKcgj+4WfWkrvt5kK9JqjsAg3haEHkNA9Y2ul8pUR+K0VMPEcdfKhXL8jdxvNU
	J1QLqXL9AC1NGo0/5czWcPDDa9RQTrwM14qe9S6jMQtaTA3H+xktv9JRZRHaxQMC6qSjjbtHqIY
	D32t8Eq0dN5hgpAKMCO5TF0cj8x2mBKeMotynkEagA1/Si0WF21psL0iA==
X-Google-Smtp-Source: AGHT+IEB9yEQqBkr74YLR2tyTAnQ60nVJlHnhmNaDrfUyDztzRouDAIp0spmTqrABMs6W8xEIiwWr0uhWN63Px90Hqc=
X-Received: by 2002:a05:6870:3923:b0:3c9:8bce:e383 with SMTP id
 586e51a60fabf-3d5d8006963mr1983799fac.21.1761668023776; Tue, 28 Oct 2025
 09:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916133437.713064-1-ekffu200098@gmail.com>
 <20250916133437.713064-3-ekffu200098@gmail.com> <CABFDxMFtZKSr5KbqcGQzJWYwT5URUYeuEHJ1a_jDUQPO-OKVGg@mail.gmail.com>
 <CAOQ4uxgEL=gOpSaSAV_+U=a3W5U5_Uq2Sk4agQhUpL4jHMMQ9w@mail.gmail.com>
 <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com>
 <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com>
 <CABFDxMFRhKNENWyqh3Yraq_vDh0P=KxuXA9RcuVPX4FUnhKqGw@mail.gmail.com> <CAOQ4uxjxG7KCwsHYv3Oi+t1pwjLS8jUoiAroXtzTatu3+11CWg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjxG7KCwsHYv3Oi+t1pwjLS8jUoiAroXtzTatu3+11CWg@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 29 Oct 2025 01:13:31 +0900
X-Gm-Features: AWmQ_bmaHIhXW-ixXLopG5YdwZYLQ9h7cQ9u2ijKR-Uhonb8TMgGlmbWVna5zZY
Message-ID: <CABFDxMGyH9jek19qEzp-3cQiS=9CTXzvtVDZztouLeO6nYEP3w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] smb: client: add directory change tracking via
 SMB2 Change Notify
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, linux-cifs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Stef Bon <stefbon@gmail.com>, 
	Ioannis Angelakopoulos <iangelak@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000c5138e06423a4c75"

--000000000000c5138e06423a4c75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:30=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> ...
> > > > Hello, Amir
> > > >
> > > > > First feedback (value):
> > > > > -----------------------------
> > > > > This looks very useful. this feature has been requested and
> > > > > attempted several times in the past (see links below), so if you =
are
> > > > > willing to incorporate feedback, I hope you will reach further th=
an those
> > > > > past attempts and I will certainly do my best to help you with th=
at.
> > > >
> > > > Thanks for your kind comment. I'm really glad to hear that.
> > > >
> > > > > Second feedback (reviewers):
> > > > > ----------------------------------------
> > > > > I was very surprised that your patch doesn't touch any vfs code
> > > > > (more on that on design feedback), but this is not an SMB-contain=
ed
> > > > > change at all.
> > > >
> > > > I agree with your last comment. I think it might not be easy;
> > > > honestly, I may know less than
> > > > Ioannis or Vivek; but I'm fully committed to giving it a try, no
> > > > matter the challenge.
> > > >
> > > > > Your patch touches the guts of the fsnotify subsystem (in a wrong=
 way).
> > > > > For the next posting please consult the MAINTAINERS entry
> > > > > of the fsnotify subsystem for reviewers and list to CC (now added=
).
> > > >
> > > > I see. I'll keep it in my mind.
> > > >
> > > > > Third feedback (design):
> > > > > --------------------------------
> > > > > The design choice of polling i_fsnotify_mask on readdir()
> > > > > is quite odd and it is not clear to me why it makes sense.
> > > > > Previous discussions suggested to have a filesystem method
> > > > > to update when applications setup a watch on a directory [1].
> > > > > Another prior feedback was that the API should allow a clear
> > > > > distinction between the REMOTE notifications and the LOCAL
> > > > > notifications [2][3].
> > > >
> > > > Current design choice is a workaround for setting an appropriate ad=
d
> > > > watch point (as well as remove). I don't want to stick to the RFC
> > > > design. Also, The point that I considered important is similar to
> > > > Ioannis' one: compatible with existing applications.
> > > >
> > > > > IMO it would be better to finalize the design before working on t=
he
> > > > > code, but that's up to you.
> > > >
> > > > I agree, although it's quite hard to create a perfect blueprint, bu=
t
> > > > it might be better to draw to some extent.
> > > >
> > > > Based on my current understanding, I think we need to do the follow=
ing things.
> > > > - design more compatible and general fsnotify API for all network f=
s;
> > > > should process LOCAL and REMOTE both smoothly.
> > > > - expand inotify (if needed, fanotify both) flow with new fsnotify =
API
> > > > - replace SMB2 change_notify start/end point to new API
> > > >
> > >
> > > Yap, that's about it.
> > > All the rest is the details...
> > >
> > > > Let me know if I missed or misunderstood something. And also please
> > > > give me some time to read attached threads more deeply and clean up=
 my
> > > > thoughts and questions.
> > > >
> > >
> > > Take your time.
> > > It's good to understand the concerns of previous attempts to
> > > avoid hitting the same roadblocks.
> >
> > Good to see you again!
> >
> > I read and try to understand previous discussions that you attached. I
> > would like to ask for your opinion about my current step.
> > I considered different places for new fsnotify API. I came to the same
> > conclusion that you already suggested to Inoannis [1]
> > After adding new API to `struct super_operations`, I tried to find the
> > right place for API calls that would not break existing systems and
> > have compatibility with inotify and fanotify.
> >
> > From my current perspective, I think the outside of fsnotify (like
> > inotify_user.c/fanotify_user.c) is a better place to call new API.
> > Also, it might lead some duplicate code with inotify and fanotify, but
> > it seems difficult to create one unified logic that covers both
> > inotify and fanotify.
>
>
> Personally, I don't mind duplicating this call in the inotify and
> fanotify backends.
> Not sure if this feature is relevant to other backends like nfsd and audi=
t.
>
> I do care about making this feature opt-in, which goes a bit against your
> requirement that existing applications will get the REMOTE notifications
> without opting in for them and without the notifications being clearly ma=
rked
> as REMOTE notifications.
>
> If you do not make this feature opt-in (e.g. by fanotify flag FAN_MARK_RE=
MOTE)
> then it's a change of behavior that could be desired to some and surprisi=
ng to
> others.

You're right, Upon further reflection, my previous approach may create
unexpected effects to the user program. But to achieve my requirement,
inotify should be supported (also safely). I will revisit inotify with
opt-in method after finishing the discussion about fanotify.

> Also when performing an operation on the local smb client (e.g. unlink)
> you would get two notifications, one the LOCAL and one the REMOTE,
> not being able to distinguish between them or request just one of them
> is going to be confusing.
>
> > With this approach, we could start inotify first
> > and then fanotify second that Inoannis and Vivek already attempted.
> > Even if unified logic is possible, I don't think it is not difficult
> > to merge and move them into inside of fsnotify (like mark.c)
> >
>
> For all the reasons above I would prefer to support fanotify first
> (with opt-in flag) and not support inotify at all, but if you want to
> support inotify, better have some method to opt-in at least.
> Could be a global inotify kob for all I care, as long as the default
> does not take anyone by surprise.

Thanks for the detailed description. I understand the point of
distinguishing remote and local notification better. And the way you
prefer (fanotify first) is also reasonable to me because implementing
fanotify would also help support inotify more safely.

> > Also, I have concerns when to call the new API. I think after updating
> > the mark is a good moment to call API if we decide to ignore errors
> > from new API; now, to me, it is affordable in terms of minimizing side
> > effect and lower risk with user spaces. However, eventually, I believe
> > the user should be able to decide whether to ignore the error or not
> > of new API, maybe by config or flag else. In that case, we need to
> > rollback update of fsnotify when new API fails. but it is not
> > supported yet. Could you share your thoughts on this, too?
> >
>
> If you update remote mask with explicit FAN_MARK_REMOTE
> and update local mask without FAN_MARK_REMOTE, then
> there is no problem is there?
>
> Either FAN_MARK_REMOTE succeeded or not.
> If it did, remote fs could be expected to generate remote events.

I understand you mean splitting mask into a local and remote
notification instead of sharing, is it right?
TBH, I never thought of that solution but it's quite clear and looks good t=
o me.
If I misunderstand, could you please explain a bit more?

> > If my inspection is wrong or you might have better idea, please let me
> > know about it. TBH, understanding new things is hard, but it's also a
> > happy moment to me.
> >
>
> I am relying on what I think you mean, but I may misunderstand you
> because you did not sketch any code samples, so I don't believe
> I fully understand all your concerns and ideas.
>
> Even an untested patch could help me understand if we are on the same pag=
e.

Thanks for your advice. I think we're getting closer to the same page.
I also attached patch of my current sketch (not tested and cleaned),
feel free to give your opinions.

Thanks for your consideration as well.

> Thanks,
> Amir.

Best Regards.
Sang-Heon Jeon

--000000000000c5138e06423a4c75
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fanotify-introduce-remote-mask.patch"
Content-Disposition: attachment; 
	filename="0001-fanotify-introduce-remote-mask.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mharg4mt0>
X-Attachment-Id: f_mharg4mt0

RnJvbSA3ZmU4N2RjNGNmNDExOTNkMjgwY2VlMDhlYTk5NWU5OTkxZTg4NWI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW5nLUhlb24gSmVvbiA8ZWtmZnUyMDAwOThAZ21haWwuY29t
PgpEYXRlOiBXZWQsIDI5IE9jdCAyMDI1IDAwOjQ2OjAyICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
ZmFub3RpZnk6IGludHJvZHVjZSByZW1vdGUgbWFzawoKU2lnbmVkLW9mZi1ieTogU2FuZy1IZW9u
IEplb24gPGVrZmZ1MjAwMDk4QGdtYWlsLmNvbT4KLS0tCiBmcy9pbm9kZS5jICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEgKwogZnMvbm90aWZ5L2Zhbm90aWZ5L2Zhbm90aWZ5X3VzZXIuYyB8
IDU0ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQogZnMvbm90aWZ5L21hcmsuYyAgICAg
ICAgICAgICAgICAgICB8IDIzICsrKysrKysrKysrKy0KIGluY2x1ZGUvbGludXgvZmFub3RpZnku
aCAgICAgICAgICAgfCAgMyArLQogaW5jbHVkZS9saW51eC9mcy5oICAgICAgICAgICAgICAgICB8
ICAxICsKIGluY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oICAgfCAyMiArKysrKysrKysr
KysKIDYgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMKaW5kZXggZWM5MzM5MDI0YWMzLi43
NmI2OGY3ZmVkM2QgMTAwNjQ0Ci0tLSBhL2ZzL2lub2RlLmMKKysrIGIvZnMvaW5vZGUuYwpAQCAt
MzAwLDYgKzMwMCw3IEBAIGludCBpbm9kZV9pbml0X2Fsd2F5c19nZnAoc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwgc3RydWN0IGlub2RlICppbm9kZSwgZ2ZwX3QgZ2ZwCiAKICNpZmRlZiBDT05GSUdf
RlNOT1RJRlkKIAlpbm9kZS0+aV9mc25vdGlmeV9tYXNrID0gMDsKKwlpbm9kZS0+aV9mc25vdGlm
eV9yZW1vdGVfbWFzayA9IDA7CiAjZW5kaWYKIAlpbm9kZS0+aV9mbGN0eCA9IE5VTEw7CiAKZGlm
ZiAtLWdpdCBhL2ZzL25vdGlmeS9mYW5vdGlmeS9mYW5vdGlmeV91c2VyLmMgYi9mcy9ub3RpZnkv
ZmFub3RpZnkvZmFub3RpZnlfdXNlci5jCmluZGV4IDFkYWRkYTgyY2FlNS4uNDlmNzIzODM2ODM5
IDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNlci5jCisrKyBiL2Zz
L25vdGlmeS9mYW5vdGlmeS9mYW5vdGlmeV91c2VyLmMKQEAgLTEyNDcsMjAgKzEyNDcsMjkgQEAg
c3RhdGljIF9fdTMyIGZhbm90aWZ5X21hcmtfcmVtb3ZlX2Zyb21fbWFzayhzdHJ1Y3QgZnNub3Rp
ZnlfbWFyayAqZnNuX21hcmssCiAJLyogdW1hc2sgYml0cyBjYW5ub3QgYmUgcmVtb3ZlZCBieSB1
c2VyICovCiAJbWFzayAmPSB+dW1hc2s7CiAJc3Bpbl9sb2NrKCZmc25fbWFyay0+bG9jayk7Ci0J
b2xkbWFzayA9IGZzbm90aWZ5X2NhbGNfbWFzayhmc25fbWFyayk7Ci0JaWYgKCEoZmxhZ3MgJiBG
QU5PVElGWV9NQVJLX0lHTk9SRV9CSVRTKSkgewotCQlmc25fbWFyay0+bWFzayAmPSB+bWFzazsK
KwlpZiAoZmxhZ3MgJiBGQU5fTUFSS19SRU1PVEUpIHsKKwkJb2xkbWFzayA9IGZzbm90aWZ5X2Nh
bGNfcmVtb3RlX21hc2soZnNuX21hcmspOworCQlpZiAoIShmbGFncyAmIEZBTk9USUZZX01BUktf
SUdOT1JFX0JJVFMpKQorCQkJZnNuX21hcmstPnJlbW90ZV9tYXNrICY9IH5tYXNrOworCQllbHNl
CisJCQlmc25fbWFyay0+cmVtb3RlX2lnbm9yZV9tYXNrICY9IH5tYXNrOworCQluZXdtYXNrID0g
ZnNub3RpZnlfY2FsY19yZW1vdGVfbWFzayhmc25fbWFyayk7CiAJfSBlbHNlIHsKLQkJZnNuX21h
cmstPmlnbm9yZV9tYXNrICY9IH5tYXNrOworCQlvbGRtYXNrID0gZnNub3RpZnlfY2FsY19tYXNr
KGZzbl9tYXJrKTsKKwkJaWYgKCEoZmxhZ3MgJiBGQU5PVElGWV9NQVJLX0lHTk9SRV9CSVRTKSkK
KwkJCWZzbl9tYXJrLT5tYXNrICY9IH5tYXNrOworCQllbHNlCisJCQlmc25fbWFyay0+aWdub3Jl
X21hc2sgJj0gfm1hc2s7CisJCW5ld21hc2sgPSBmc25vdGlmeV9jYWxjX21hc2soZnNuX21hcmsp
OwogCX0KLQluZXdtYXNrID0gZnNub3RpZnlfY2FsY19tYXNrKGZzbl9tYXJrKTsKIAkvKgogCSAq
IFdlIG5lZWQgdG8ga2VlcCB0aGUgbWFyayBhcm91bmQgZXZlbiBpZiByZW1haW5pbmcgbWFzayBj
YW5ub3QKIAkgKiByZXN1bHQgaW4gYW55IGV2ZW50cyAoZS5nLiBtYXNrID09IEZBTl9PTkRJUikg
dG8gc3VwcG9ydCBpbmNyZW1lbmFsCiAJICogY2hhbmdlcyB0byB0aGUgbWFzay4KIAkgKiBEZXN0
cm95IG1hcmsgd2hlbiBvbmx5IHVtYXNrIGJpdHMgcmVtYWluLgogCSAqLwotCSpkZXN0cm95ID0g
ISgoZnNuX21hcmstPm1hc2sgfCBmc25fbWFyay0+aWdub3JlX21hc2spICYgfnVtYXNrKTsKKwkq
ZGVzdHJveSA9ICEoKGZzbl9tYXJrLT5yZW1vdGVfbWFzayB8IGZzbl9tYXJrLT5yZW1vdGVfaWdu
b3JlX21hc2sgfAorCQlmc25fbWFyay0+bWFzayB8IGZzbl9tYXJrLT5pZ25vcmVfbWFzaykgJiB+
dW1hc2spOwogCXNwaW5fdW5sb2NrKCZmc25fbWFyay0+bG9jayk7CiAKIAlyZXR1cm4gb2xkbWFz
ayAmIH5uZXdtYXNrOwpAQCAtMTI4Myw4ICsxMjkyLDEzIEBAIHN0YXRpYyBpbnQgZmFub3RpZnlf
cmVtb3ZlX21hcmsoc3RydWN0IGZzbm90aWZ5X2dyb3VwICpncm91cCwKIAogCXJlbW92ZWQgPSBm
YW5vdGlmeV9tYXJrX3JlbW92ZV9mcm9tX21hc2soZnNuX21hcmssIG1hc2ssIGZsYWdzLAogCQkJ
CQkJIHVtYXNrLCAmZGVzdHJveV9tYXJrKTsKLQlpZiAocmVtb3ZlZCAmIGZzbm90aWZ5X2Nvbm5f
bWFzayhmc25fbWFyay0+Y29ubmVjdG9yKSkKLQkJZnNub3RpZnlfcmVjYWxjX21hc2soZnNuX21h
cmstPmNvbm5lY3Rvcik7CisJaWYgKGZsYWdzICYgRkFOX01BUktfUkVNT1RFKSB7CisJCWlmIChy
ZW1vdmVkICYgZnNub3RpZnlfY29ubl9yZW1vdGVfbWFzayhmc25fbWFyay0+Y29ubmVjdG9yKSkK
KwkJCWZzbm90aWZ5X3JlY2FsY19yZW1vdGVfbWFzayhmc25fbWFyay0+Y29ubmVjdG9yKTsKKwl9
IGVsc2UgeworCQlpZiAocmVtb3ZlZCAmIGZzbm90aWZ5X2Nvbm5fbWFzayhmc25fbWFyay0+Y29u
bmVjdG9yKSkKKwkJCWZzbm90aWZ5X3JlY2FsY19tYXNrKGZzbl9tYXJrLT5jb25uZWN0b3IpOwor
CX0KIAlpZiAoZGVzdHJveV9tYXJrKQogCQlmc25vdGlmeV9kZXRhY2hfbWFyayhmc25fbWFyayk7
CiAJZnNub3RpZnlfZ3JvdXBfdW5sb2NrKGdyb3VwKTsKQEAgLTEzMjAsOCArMTMzNCwxMiBAQCBz
dGF0aWMgYm9vbCBmYW5vdGlmeV9tYXJrX3VwZGF0ZV9mbGFncyhzdHJ1Y3QgZnNub3RpZnlfbWFy
ayAqZnNuX21hcmssCiAJaWYgKGlnbm9yZSAmJiAoZmFuX2ZsYWdzICYgRkFOX01BUktfSUdOT1JF
RF9TVVJWX01PRElGWSkgJiYKIAkgICAgIShmc25fbWFyay0+ZmxhZ3MgJiBGU05PVElGWV9NQVJL
X0ZMQUdfSUdOT1JFRF9TVVJWX01PRElGWSkpIHsKIAkJZnNuX21hcmstPmZsYWdzIHw9IEZTTk9U
SUZZX01BUktfRkxBR19JR05PUkVEX1NVUlZfTU9ESUZZOwotCQlpZiAoIShmc25fbWFyay0+bWFz
ayAmIEZTX01PRElGWSkpCi0JCQlyZWNhbGMgPSB0cnVlOworCQlpZiAoIShmc25fbWFyay0+bWFz
ayAmIEZTX01PRElGWSkgJiYKKwkJCSEoZmFuX2ZsYWdzICYgRkFOX01BUktfUkVNT1RFKSkKKwkJ
CQlyZWNhbGMgPSB0cnVlOworCQlpZiAoIShmc25fbWFyay0+cmVtb3RlX21hc2sgJiBGU19NT0RJ
RlkpICYmCisJCQkoZmFuX2ZsYWdzICYgRkFOX01BUktfUkVNT1RFKSkKKwkJCQlyZWNhbGMgPSB0
cnVlOwogCX0KIAogCWlmIChmc25fbWFyay0+Y29ubmVjdG9yLT50eXBlICE9IEZTTk9USUZZX09C
Sl9UWVBFX0lOT0RFIHx8CkBAIC0xMzQ1LDkgKzEzNjMsMTUgQEAgc3RhdGljIGJvb2wgZmFub3Rp
ZnlfbWFya19hZGRfdG9fbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFyayAqZnNuX21hcmssCiAKIAlz
cGluX2xvY2soJmZzbl9tYXJrLT5sb2NrKTsKIAlpZiAoIShmYW5fZmxhZ3MgJiBGQU5PVElGWV9N
QVJLX0lHTk9SRV9CSVRTKSkKLQkJZnNuX21hcmstPm1hc2sgfD0gbWFzazsKKwkJaWYgKGZhbl9m
bGFncyAmIEZBTl9NQVJLX1JFTU9URSkKKwkJCWZzbl9tYXJrLT5yZW1vdGVfbWFzayB8PSBtYXNr
OworCQllbHNlCisJCQlmc25fbWFyay0+bWFzayB8PSBtYXNrOwogCWVsc2UKLQkJZnNuX21hcmst
Pmlnbm9yZV9tYXNrIHw9IG1hc2s7CisJCWlmIChmYW5fZmxhZ3MgJiBGQU5fTUFSS19SRU1PVEUp
CisJCQlmc25fbWFyay0+cmVtb3RlX2lnbm9yZV9tYXNrIHw9IG1hc2s7CisJCWVsc2UKKwkJCWZz
bl9tYXJrLT5pZ25vcmVfbWFzayB8PSBtYXNrOwogCiAJcmVjYWxjID0gZnNub3RpZnlfY2FsY19t
YXNrKGZzbl9tYXJrKSAmCiAJCX5mc25vdGlmeV9jb25uX21hc2soZnNuX21hcmstPmNvbm5lY3Rv
cik7CkBAIC0xNTA5LDcgKzE1MzMsMTEgQEAgc3RhdGljIGludCBmYW5vdGlmeV9tYXlfdXBkYXRl
X2V4aXN0aW5nX21hcmsoc3RydWN0IGZzbm90aWZ5X21hcmsgKmZzbl9tYXJrLAogCQlyZXR1cm4g
LUVFWElTVDsKIAogCS8qIEZvciBub3cgcHJlLWNvbnRlbnQgZXZlbnRzIGFyZSBub3QgZ2VuZXJh
dGVkIGZvciBkaXJlY3RvcmllcyAqLwotCW1hc2sgfD0gZnNuX21hcmstPm1hc2s7CisJaWYgKGZh
bl9mbGFncyAmIEZBTl9NQVJLX1JFTU9URSkKKwkJbWFzayB8PSBmc25fbWFyay0+cmVtb3RlX21h
c2s7CisJZWxzZQorCQltYXNrIHw9IGZzbl9tYXJrLT5tYXNrOworCiAJaWYgKG1hc2sgJiBGQU5P
VElGWV9QUkVfQ09OVEVOVF9FVkVOVFMgJiYgbWFzayAmIEZBTl9PTkRJUikKIAkJcmV0dXJuIC1F
RVhJU1Q7CiAKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9tYXJrLmMgYi9mcy9ub3RpZnkvbWFyay5j
CmluZGV4IDU1YTAzYmIwNWFhMS4uMWYwMzBkOTFmY2M1IDEwMDY0NAotLS0gYS9mcy9ub3RpZnkv
bWFyay5jCisrKyBiL2ZzL25vdGlmeS9tYXJrLmMKQEAgLTEyNyw2ICsxMjcsMTQgQEAgc3RhdGlj
IF9fdTMyICpmc25vdGlmeV9jb25uX21hc2tfcChzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0
b3IgKmNvbm4pCiAJcmV0dXJuIE5VTEw7CiB9CiAKK3N0YXRpYyBfX3UzMiAqZnNub3RpZnlfY29u
bl9yZW1vdGVfbWFza19wKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikKK3sK
KwlpZiAoY29ubi0+dHlwZSA9PSBGU05PVElGWV9PQkpfVFlQRV9JTk9ERSkKKwkJcmV0dXJuICZm
c25vdGlmeV9jb25uX2lub2RlKGNvbm4pLT5pX2Zzbm90aWZ5X3JlbW90ZV9tYXNrOworCisJcmV0
dXJuIE5VTEw7Cit9CisKIF9fdTMyIGZzbm90aWZ5X2Nvbm5fbWFzayhzdHJ1Y3QgZnNub3RpZnlf
bWFya19jb25uZWN0b3IgKmNvbm4pCiB7CiAJaWYgKFdBUk5fT04oIWZzbm90aWZ5X3ZhbGlkX29i
al90eXBlKGNvbm4tPnR5cGUpKSkKQEAgLTEzNSw2ICsxNDMsMTQgQEAgX191MzIgZnNub3RpZnlf
Y29ubl9tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubikKIAlyZXR1cm4g
UkVBRF9PTkNFKCpmc25vdGlmeV9jb25uX21hc2tfcChjb25uKSk7CiB9CiAKK19fdTMyIGZzbm90
aWZ5X2Nvbm5fcmVtb3RlX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25u
KQoreworCWlmIChjb25uLT50eXBlICE9IEZTTk9USUZZX09CSl9UWVBFX0lOT0RFKQorCQlyZXR1
cm4gMDsKKworCXJldHVybiBSRUFEX09OQ0UoKmZzbm90aWZ5X2Nvbm5fcmVtb3RlX21hc2tfcChj
b25uKSk7Cit9CisKIHN0YXRpYyB2b2lkIGZzbm90aWZ5X2dldF9zYl93YXRjaGVkX29iamVjdHMo
c3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIHsKIAlhdG9taWNfbG9uZ19pbmMoZnNub3RpZnlfc2Jf
d2F0Y2hlZF9vYmplY3RzKHNiKSk7CkBAIC0yMzksOSArMjU1LDEwIEBAIHN0YXRpYyBzdHJ1Y3Qg
aW5vZGUgKmZzbm90aWZ5X3VwZGF0ZV9pcmVmKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3Rv
ciAqY29ubiwKIAogc3RhdGljIHZvaWQgKl9fZnNub3RpZnlfcmVjYWxjX21hc2soc3RydWN0IGZz
bm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQogewotCXUzMiBuZXdfbWFzayA9IDA7CisJdTMy
IG5ld19tYXNrID0gMCwgbmV3X3JlbW90ZV9tYXNrID0gMDsKIAlib29sIHdhbnRfaXJlZiA9IGZh
bHNlOwogCXN0cnVjdCBmc25vdGlmeV9tYXJrICptYXJrOworCXUzMiAqcmVtb3RlX21hc2tfcDsK
IAogCWFzc2VydF9zcGluX2xvY2tlZCgmY29ubi0+bG9jayk7CiAJLyogV2UgY2FuIGdldCBkZXRh
Y2hlZCBjb25uZWN0b3IgaGVyZSB3aGVuIGlub2RlIGlzIGdldHRpbmcgdW5saW5rZWQuICovCkBA
IC0yNTEsNiArMjY4LDcgQEAgc3RhdGljIHZvaWQgKl9fZnNub3RpZnlfcmVjYWxjX21hc2soc3Ry
dWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQogCQlpZiAoIShtYXJrLT5mbGFncyAm
IEZTTk9USUZZX01BUktfRkxBR19BVFRBQ0hFRCkpCiAJCQljb250aW51ZTsKIAkJbmV3X21hc2sg
fD0gZnNub3RpZnlfY2FsY19tYXNrKG1hcmspOworCQluZXdfcmVtb3RlX21hc2sgfD0gZnNub3Rp
ZnlfY2FsY19yZW1vdGVfbWFzayhtYXJrKTsKIAkJaWYgKGNvbm4tPnR5cGUgPT0gRlNOT1RJRllf
T0JKX1RZUEVfSU5PREUgJiYKIAkJICAgICEobWFyay0+ZmxhZ3MgJiBGU05PVElGWV9NQVJLX0ZM
QUdfTk9fSVJFRikpCiAJCQl3YW50X2lyZWYgPSB0cnVlOwpAQCAtMjYwLDYgKzI3OCw5IEBAIHN0
YXRpYyB2b2lkICpfX2Zzbm90aWZ5X3JlY2FsY19tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nv
bm5lY3RvciAqY29ubikKIAkgKiBjb25mdXNpbmcgcmVhZGVycyBub3QgaG9sZGluZyBjb25uLT5s
b2NrIHdpdGggcGFydGlhbCB1cGRhdGVzLgogCSAqLwogCVdSSVRFX09OQ0UoKmZzbm90aWZ5X2Nv
bm5fbWFza19wKGNvbm4pLCBuZXdfbWFzayk7CisJcmVtb3RlX21hc2tfcCA9IGZzbm90aWZ5X2Nv
bm5fcmVtb3RlX21hc2tfcChjb25uKTsKKwlpZiAocmVtb3RlX21hc2tfcCkKKwkJV1JJVEVfT05D
RSgqcmVtb3RlX21hc2tfcCwgbmV3X3JlbW90ZV9tYXNrKTsKIAogCXJldHVybiBmc25vdGlmeV91
cGRhdGVfaXJlZihjb25uLCB3YW50X2lyZWYpOwogfQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9mYW5vdGlmeS5oIGIvaW5jbHVkZS9saW51eC9mYW5vdGlmeS5oCmluZGV4IDg3OWNmZjVlY2Nk
NC4uMzRiZTI5MmVlYzJmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zhbm90aWZ5LmgKKysr
IGIvaW5jbHVkZS9saW51eC9mYW5vdGlmeS5oCkBAIC03Miw3ICs3Miw4IEBACiAJCQkJIEZBTl9N
QVJLX0RPTlRfRk9MTE9XIHwgXAogCQkJCSBGQU5fTUFSS19PTkxZRElSIHwgXAogCQkJCSBGQU5f
TUFSS19JR05PUkVEX1NVUlZfTU9ESUZZIHwgXAotCQkJCSBGQU5fTUFSS19FVklDVEFCTEUpCisJ
CQkJIEZBTl9NQVJLX0VWSUNUQUJMRSB8IFwKKwkJCQkgRkFOX01BUktfUkVNT1RFKQogCiAvKgog
ICogRXZlbnRzIHRoYXQgY2FuIGJlIHJlcG9ydGVkIHdpdGggZGF0YSB0eXBlIEZTTk9USUZZX0VW
RU5UX1BBVEguCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4
L2ZzLmgKaW5kZXggNjhjNGE1OWVjOGZiLi4wZmY4M2EwMWY3MTEgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgKQEAgLTg5NSw2ICs4OTUsNyBA
QCBzdHJ1Y3QgaW5vZGUgewogCiAjaWZkZWYgQ09ORklHX0ZTTk9USUZZCiAJX191MzIJCQlpX2Zz
bm90aWZ5X21hc2s7IC8qIGFsbCBldmVudHMgdGhpcyBpbm9kZSBjYXJlcyBhYm91dCAqLworCV9f
dTMyCQkJaV9mc25vdGlmeV9yZW1vdGVfbWFzazsKIAkvKiAzMi1iaXQgaG9sZSByZXNlcnZlZCBm
b3IgZXhwYW5kaW5nIGlfZnNub3RpZnlfbWFzayAqLwogCXN0cnVjdCBmc25vdGlmeV9tYXJrX2Nv
bm5lY3RvciBfX3JjdQkqaV9mc25vdGlmeV9tYXJrczsKICNlbmRpZgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmggYi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2Jh
Y2tlbmQuaAppbmRleCAwZDk1NGVhN2IxNzkuLmI4MTg3N2RjNmI3MiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmgKKysrIGIvaW5jbHVkZS9saW51eC9mc25vdGlm
eV9iYWNrZW5kLmgKQEAgLTYzNSw2ICs2MzUsOSBAQCBzdHJ1Y3QgZnNub3RpZnlfbWFyayB7CiAj
ZGVmaW5lIEZTTk9USUZZX01BUktfRkxBR19IQVNfRlNJRAkJMHgwODAwCiAjZGVmaW5lIEZTTk9U
SUZZX01BUktfRkxBR19XRUFLX0ZTSUQJCTB4MTAwMAogCXVuc2lnbmVkIGludCBmbGFnczsJCS8q
IGZsYWdzIFttYXJrLT5sb2NrXSAqLworCisJX191MzIgcmVtb3RlX21hc2s7CisJX191MzIgcmVt
b3RlX2lnbm9yZV9tYXNrOwogfTsKIAogI2lmZGVmIENPTkZJR19GU05PVElGWQpAQCAtNzk5LDYg
KzgwMiwxMSBAQCBzdGF0aWMgaW5saW5lIF9fdTMyIGZzbm90aWZ5X2lnbm9yZWRfZXZlbnRzKHN0
cnVjdCBmc25vdGlmeV9tYXJrICptYXJrKQogCXJldHVybiBtYXJrLT5pZ25vcmVfbWFzayAmIEFM
TF9GU05PVElGWV9FVkVOVFM7CiB9CiAKK3N0YXRpYyBpbmxpbmUgX191MzIgZnNub3RpZnlfcmVt
b3RlX2lnbm9yZWRfZXZlbnRzKHN0cnVjdCBmc25vdGlmeV9tYXJrICptYXJrKQoreworCXJldHVy
biBtYXJrLT5yZW1vdGVfaWdub3JlX21hc2sgJiBBTExfRlNOT1RJRllfRVZFTlRTOworfQorCiAv
KgogICogQ2hlY2sgaWYgbWFzayAob3IgaWdub3JlIG1hc2spIHNob3VsZCBiZSBhcHBsaWVkIGRl
cGVuZGluZyBpZiB2aWN0aW0gaXMgYQogICogZGlyZWN0b3J5IGFuZCB3aGV0aGVyIGl0IGlzIHJl
cG9ydGVkIHRvIGEgd2F0Y2hpbmcgcGFyZW50LgpAQCAtODYwLDggKzg2OCwyMiBAQCBzdGF0aWMg
aW5saW5lIF9fdTMyIGZzbm90aWZ5X2NhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFyayAqbWFy
aykKIAlyZXR1cm4gbWFzayB8IG1hcmstPmlnbm9yZV9tYXNrOwogfQogCitzdGF0aWMgaW5saW5l
IF9fdTMyIGZzbm90aWZ5X2NhbGNfcmVtb3RlX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmsgKm1h
cmspCit7CisJX191MzIgbWFzayA9IG1hcmstPnJlbW90ZV9tYXNrOworCisJaWYgKCFmc25vdGlm
eV9yZW1vdGVfaWdub3JlZF9ldmVudHMobWFyaykpCisJCXJldHVybiBtYXNrOworCisJaWYgKCEo
bWFyay0+ZmxhZ3MgJiBGU05PVElGWV9NQVJLX0ZMQUdfSUdOT1JFRF9TVVJWX01PRElGWSkpCisJ
CW1hc2sgfD0gRlNfTU9ESUZZOworCisJcmV0dXJuIG1hc2sgfCBtYXJrLT5yZW1vdGVfaWdub3Jl
X21hc2s7Cit9CisKIC8qIEdldCBtYXNrIG9mIGV2ZW50cyBmb3IgYSBsaXN0IG9mIG1hcmtzICov
CiBleHRlcm4gX191MzIgZnNub3RpZnlfY29ubl9tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nv
bm5lY3RvciAqY29ubik7CitleHRlcm4gX191MzIgZnNub3RpZnlfY29ubl9yZW1vdGVfbWFzayhz
dHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4pOwogLyogQ2FsY3VsYXRlIG1hc2sg
b2YgZXZlbnRzIGZvciBhIGxpc3Qgb2YgbWFya3MgKi8KIGV4dGVybiB2b2lkIGZzbm90aWZ5X3Jl
Y2FsY19tYXNrKHN0cnVjdCBmc25vdGlmeV9tYXJrX2Nvbm5lY3RvciAqY29ubik7CiBleHRlcm4g
dm9pZCBmc25vdGlmeV9pbml0X21hcmsoc3RydWN0IGZzbm90aWZ5X21hcmsgKm1hcmssCi0tIAoy
LjQzLjAKCg==
--000000000000c5138e06423a4c75--

