Return-Path: <linux-fsdevel+bounces-9428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC08411FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CD528AD30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18A13AC5;
	Mon, 29 Jan 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdkVew3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CB125C1
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553050; cv=none; b=OfhEi4jniRCvZgC5fBoqrZun+zbhJfEXXP8IuNMRpfBNnkcfXR1iRRSMbrlyZ31RDh2SXVJ/kULtuyToJY0GugdbOt6TBWkre3bx3oprRDXsr3xI1xrF1KCnM1XVHrxPfKO42hFZN9+HGX3+pI+XzsdLCvo+Bc8j58B4xSql0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553050; c=relaxed/simple;
	bh=kQQqyFOdPc3PmyNpZgAc7G6jLOKGlDHEjmF7Xmyd6qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQ/q+gfN2M96Bxzm+PocPtxE34KmqntbFxiNRQfyAobGNv0LPhP2Xrg/zTT3zDt+gawJVAMEXp1aWt/yM9vDJQR+ebjZZ1g+BeoV5HbJHTCAcysP/AK9VvOd2mYt5bivqW9l+Bg/qXmNRxY3IqVHn+tgm8hGtl32Oow0Pi9CgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdkVew3f; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-46b29f09401so516551137.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 10:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706553047; x=1707157847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHEyDcqypKFkwpNDe8GfvVy0x6/6h1Qp2TPjBPSdRNM=;
        b=CdkVew3f6VG0vLCRGqxpDdzvtPph1ioxAC8XKWq1DBl6DBP1XofUIXDNY9OQ/i0mff
         GWj91RojEGN7AUsV/Ah/ourg7soD4Q0nnmSVjE8iVcFPw0q3DD+6J/kMKhi7q7SbjAZQ
         i7YpEF75T3zvPo8/MUp5ZCDzCcF6bq94Rv+LR1uQu/YgWzzWsGcZ9/bAijxm6h/lQaxx
         xPIKNwWSGOj3QO3+BPoCfbpL+ZBN/M3TfxY51CRTH6ZVnGVQIHNtZqlePvB87rMBt9FL
         0yQ1ftQ2TrP4imN69TeKN3J074ls5nfxkZHdwzdhq89XbYQxqgxWkaYNtEu7X2KBQTm3
         sluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553047; x=1707157847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHEyDcqypKFkwpNDe8GfvVy0x6/6h1Qp2TPjBPSdRNM=;
        b=SxFA5na+EeTv409J7Cv6xQgAyXcGD2dBcfEtjQG7SKo9kL8qDHX6kSiH+uNiLG0Blr
         wdxIyB5wQ/0sOd0fiOJYVnnvKPFtIDt0Xy2P7g4sNWdq82uS8b4kmvG7YZEWCRL4iFhb
         hrRL172/cXVQDsdiG9u724jNTtefVRQ6OIv85c9NJSXAGnI6E4toYpQtKOPZvf2lTZVK
         E/Bdgq2EibbCX9Pol6cRAXQ92Wx7cQtRpLGQ2AiBy8PKK+iBmHV2DOiu7RI7ftpaPqTN
         2fhWKgc41Lx9gKLIpZ0YHk3EjlzGW22LdLP7YepkzxagLhp+tl24nypMlw/F/QuzqoS0
         MAvQ==
X-Gm-Message-State: AOJu0YyczovJT+Pj40ptonCgAcYl7qabxf+oOLNrG/GgizFBhwkTmNNA
	/I6f1Gz8FXvKmSbxxaOyaXbcuysP0yg/efOlCWPU/nCC1GsTGCo2H4Ljt35C6bw2ux4yd5r5LHV
	abogPP0vTBizahywsyapPDPmYAZk=
X-Google-Smtp-Source: AGHT+IH5+tz8PjAO0wb1CwnXalFgCzvaGBVYvQkzG3gFfHtmAyMTDWr6uNXfmJtzOxIBCKpBFixnULb7D3pCZ//nLKo=
X-Received: by 2002:a05:6102:1499:b0:46b:970b:daf9 with SMTP id
 d25-20020a056102149900b0046b970bdaf9mr119383vsv.2.1706553046933; Mon, 29 Jan
 2024 10:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208080135.4089880-1-amir73il@gmail.com> <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting> <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3> <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jan 2024 20:30:34 +0200
Message-ID: <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 5:53=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Dec 18, 2023 at 4:35=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 15-12-23 18:50:39, Amir Goldstein wrote:
> > > On Fri, Dec 15, 2023 at 5:31=E2=80=AFPM Josef Bacik <josef@toxicpanda=
.com> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 09:09:30PM +0200, Amir Goldstein wrote:
> > > > > On Wed, Dec 13, 2023 at 7:28=E2=80=AFPM Jan Kara <jack@suse.cz> w=
rote:
> > > > > >
> > > > > > On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> > > > > > > With FAN_DENY response, user trying to perform the filesystem=
 operation
> > > > > > > gets an error with errno set to EPERM.
> > > > > > >
> > > > > > > It is useful for hierarchical storage management (HSM) servic=
e to be able
> > > > > > > to deny access for reasons more diverse than EPERM, for examp=
le EAGAIN,
> > > > > > > if HSM could retry the operation later.
> > > > > > >
> > > > > > > Allow userspace to response to permission events with the res=
ponse value
> > > > > > > FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom=
 error.
> > > > > > >
> > > > > > > The change in fanotify_response is backward compatible, becau=
se errno is
> > > > > > > written in the high 8 bits of the 32bit response field and ol=
d kernels
> > > > > > > reject respose value with high bits set.
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > >
> > > > > > So a couple of comments that spring to my mind when I'm looking=
 into this
> > > > > > now (partly maybe due to my weak memory ;):
> > > > > >
> > > > > > 1) Do we still need the EAGAIN return? I think we have mostly d=
ealt with
> > > > > > freezing deadlocks in another way, didn't we?
> > > > >
> > > > > I was thinking about EAGAIN on account of the HSM not being able =
to
> > > > > download the file ATM.
> > > > >
> > > > > There are a bunch of error codes that are typical for network fil=
esystems, e.g.
> > > > > ETIMEDOUT, ENOTCONN, ECONNRESET which could be relevant to
> > > > > HSM failures.
> > > > >
> > > > > >
> > > > > > 2) If answer to 1) is yes, then there is a second question - do=
 we expect
> > > > > > the errors to propagate back to the unsuspecting application do=
ing say
> > > > > > read(2) syscall? Because I don't think that will fly well with =
a big
> > > > > > majority of applications which basically treat *any* error from=
 read(2) as
> > > > > > fatal. This is also related to your question about standard per=
mission
> > > > > > events. Consumers of these error numbers are going to be random
> > > > > > applications and I see a potential for rather big confusion ari=
sing there
> > > > > > (like read(1) returning EINVAL or EBADF and now you wonder why =
the hell
> > > > > > until you go debug the kernel and find out the error is coming =
out of
> > > > > > fanotify handler). And the usecase is not quite clear to me for=
 ordinary
> > > > > > fanotify permission events (while I have no doubts about creati=
vity of
> > > > > > implementors of fanotify handlers ;)).
> > > > > >
> > > > >
> > > > > That's a good question.
> > > > > I prefer to delegate your question to the prospect users of the f=
eature.
> > > > >
> > > > > Josef, which errors did your use case need this feature for?
> > > > >
> > > > > > 3) Given the potential for confusion, maybe we should stay cons=
ervative and
> > > > > > only allow additional EAGAIN error instead of arbitrary errno i=
f we need it?
> > > > > >
> > > > >
> > > > > I know I was planning to use this for EDQUOT error (from FAN_PRE_=
MODIFY),
> > > > > but I certainly wouldn't mind restricting the set of custom error=
s.
> > > > > I think it makes sense. The hard part is to agree on this set of =
errors.
> > > > >
> > > >
> > > > I'm all for flexibility here.
> > > >
> > > > We're going to have 2 classes of applications interacting with HSM =
backed
> > > > storage, normal applications and applications that know they're bac=
ked by HSM.
> > > > The normal applications are just going to crash if they get an erro=
r on read(2),
> > > > it doesn't matter what errno it is.  The second class would have di=
fferent
> > > > things they'd want to do in the face of different errors, and that'=
s what this
> > > > patchset is targeting.  We can limit it to a few errno's if that ma=
kes you feel
> > > > better, but having more than just one would be helpful.
> > >
> > > Ok. In another email I got from your colleagues, they listed:
> > > EIO, EAGAIN, ENOSPC as possible errors to return.
> > > I added EDQUOT for our in house use case.
> >
> > OK, so do I get it right that you also have applications that are aware
> > that they are operation on top of HSM managed filesystem and thus they =
can
> > do meaningful things with the reported errors?
> >
>
> Some applications are HSM aware.
> Some just report the errors that they get which are meaningful to users.
> EIO is the standard response for HSM failure to fill content.
>
> EDQUOT/ENOSPC is a good example of special functionality.
> HSM "swaps out" file content to a slow remote tier, but the slow remote
> tier may have a space/quota limit that is known to HSM.
>
> By tracking the total of st_size under some HSM managed folder, including
> the st_size of files whose content is punched out, HSM can enforce this l=
imit
> not in the conventional meaning of local disk blocks usage.
>
> This is when returning EDQUOT/ENOSPC for FAN_PRE_MODIFY makes
> sense to most users/applications, except for ones that try to create
> large sparse
> files...
>
>
> > > Those are all valid errors for write(2) and some are valid for read(2=
).
> > > ENOSPC/EDQUOT make a lot of sense for HSM for read(2), but could
> > > be surprising to applications not aware of HSM.
> > > I think it wouldn't be that bad if we let HSM decide which of those e=
rrors
> > > to return for FAN_PRE_ACCESS as opposed to FAN_PRE_MODIFY.
> >
> > Yeah, I don't think we need to be super-restrictive here, I'd just pref=
er
> > to avoid the "whatever number you decide to return" kind of interface
> > because I can see potential for confusion and abuse there. I think all =
four
> > errors above are perfectly fine for both FAN_PRE_ACCESS and FAN_PRE_MOD=
IFY
> > if there are consumers that are able to use them.
> >
> > > But given that we do want to limit the chance of abusing this feature=
,
> > > perhaps it would be best to limit the error codes to known error code=
s
> > > for write(2) IO failures (i.e. not EBADF, not EFAULT) and allow retur=
ning
> > > FAN_DENY_ERRNO only for the new FAN_PRE_{ACCESS,MODIFY}
> > > HSM events.
> > >
> > > IOW, FAN_{OPEN,ACCESS}_PERM - no FAN_DENY_ERRNO for you!
> > >
> > > Does that sound good to you?
> >
> > It sounds OK to me. I'm open to allowing FAN_DENY_ERRNO for FAN_OPEN_PE=
RM
> > if there's a usecase because at least conceptually it makes a good sens=
e
> > and chances for confusion are low there. People are used to dealing wit=
h
> > errors on open(2).
> >
>
> I wrote about one case I have below.
>
> > > Furthermore, we can start with allowing a very limited set of errors
> > > and extend it in the future, on case by case basis.
> > >
> > > The way that this could be manageable is if we provide userspace
> > > a way to test for supported return codes.
> > >
> > > There is already a simple method that we used for testing FAN_INFO
> > > records type support -
> > > After fan_fd =3D fanotify_init(), userspace can write a "test" fanoti=
fy_response
> > > to fan_fd with fanotify_response.fd=3DFAN_NOFD.
> > >
> > > When setting fanotify_response.fd=3DFAN_DENY, this would return ENOEN=
T,
> > > but with fanotify_response.fd=3DFAN_DENY_ERRNO(EIO), upstream would
> > > return EINVAL.
> > >
> > > This opens the possibility of allowing, say, EIO, EAGAIN in the first=
 release
> > > and ENOSPC, EDQUOT in the following release.
> >
> > If we forsee that ENOSPC and EDQUOT will be needed, then we can just en=
able
> > it from start and not complicate our lives more than necessary.
> >
>
> Sure, I was just giving an example how the list could be extended case by=
 case
> in the future.
>
> > > The advantage in this method is that it is very simple and already wo=
rking
> > > correctly for old kernels.
> > >
> > > The downside is that this simple method does not allow checking for
> > > allowed errors per specific event type, so if we decide that we do wa=
nt
> > > to allow returning FAN_DENY_ERRNO for FAN_OPEN_PERM later on, this me=
thod
> > > could not be used by userspace to test for this finer grained support=
.
> >
> > True, in that case the HSM manager would have to try responding with
> > FAN_DENY_ERRNO() and if it fails, it will have to fallback to respondin=
g
> > with FAN_DENY. Not too bad I'd say.
> >
>
> Yeah that works too.
>
> > > In another thread, I mention the fact that FAN_OPEN_PERM still has a
> > > potential freeze deadlock when called from open(O_TRUNC|O_CREATE),
> > > so we can consider the fact that FAN_DENY_ERRNO is not allowed with
> > > FAN_OPEN_PERM as a negative incentive for people to consider using
> > > FAN_OPEN_PERM as a trigger for HSM.
> >
> > AFAIU from the past discussions, there's no good use of FAN_OPEN_PERM
> > event for HSM. If that's the case, I'm for not allowing FAN_DENY_ERRNO =
for
> > FAN_OPEN_PERM.
>
> In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> to deny open of file during the short time that it's content is being
> punched out [1].
> It is quite complicated to explain, but I only used it for denying access=
,
> not to fill content and not to write anything to filesystem.
> It's worth noting that returning EBUSY in that case would be more meaning=
ful
> to users.
>
> That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PERM,
> but mainly I do not have a proof that people will not need it.
>
> OTOH, I am a bit concerned that this will encourage developer to use
> FAN_OPEN_PERM as a trigger to filling file content and then we are back t=
o
> deadlock risk zone.
>
> Not sure which way to go.
>
> Anyway, I think we agree that there is no reason to merge FAN_DENY_ERRNO
> before FAN_PRE_* events, so we can continue this discussion later when
> I post FAN_PRE_* patches - not for this cycle.
>

Hi Jan,

I started to prepare the pre-content events patches for posting and got bac=
k
to this one as well.

Since we had this discussion I have learned of another use case that requir=
es
filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXEC_PERM to
be exact.

The reason is that unless an executable content is filled at execve() time,
there is no other opportunity to fill its content without getting -ETXTBSY.

So to keep things more flexible, I decided to add -ETXTBSY to the
allowed errors with FAN_DENY_ERRNO() and to decided to allow
FAN_DENY_ERRNO() with all permission events.

To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
added a limitation that FAN_DENY_ERRNO() is allowed only for
FAN_CLASS_PRE_CONTENT groups.

Thanks,
Amir.

