Return-Path: <linux-fsdevel+bounces-24092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2039393E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AFA1F21F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910C317083F;
	Mon, 22 Jul 2024 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZD9592C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391381CF83
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674698; cv=none; b=dFIzxtWJw8o2+btTkuMYGDg4SzU+bozttdXABpMj04dRczxYvsMvsfuR2gbtn8Ny8t54HRV/VbAjfkroGPse1PkuIDejqya9mcnnt9lTOSw3DjNq2sz1pB8C03OWpXlEM5xWbpIuwnRbVNAWR+5qml/FYIRMLA5riWaMlkDewvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674698; c=relaxed/simple;
	bh=zJ576zGLaIiI8pgheoClGRN6SR4JYdghcSVXXA16GKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUKc7ij2e6QP/oqWyZh9ImgoMvp6DjFK0m8Coqoae9XLcza7Xk7E3x7zvAwPF63ed7KWMQIGEN8aInuLxTHHCZakDdmolGFvpTunptBB7PLukK7mTgjAdxj6BFSuoJmigENDN4hxdJtjXHRxgs+Minw6hOWHzTUK/W1BKHFzoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZD9592C; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44953ab0e2bso24265401cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721674695; x=1722279495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juqIh5cXr76tgWklYbBjz4eG26gFnLSFooG2Ud5pioc=;
        b=OZD9592ChHV0vzhLqLJMTPktjSTVuKExprBK/XTa7vtn4pSx9aMCON1L8WS1bLD09f
         BoCfW+Yk409f9MeYjesgiC2eBRKgQN1lzkGuWFs67tV/TghSSP0mEGClcX2KqgvRUNr6
         PKLaBr00OGEgzJ02kfgAN5AT02PyXmn5I84vTS9DiqVnM3/QkY1S9ZnAR4vJlsDifPCZ
         YhjFf2wq2/1z1jRd8Sn1cWzNAx1jRFMRI3kZvs3qe44JS5rhqqrilvTjHhp558EXqazc
         E0gq/wVZC7kXxaFRcHQGWNvXXQcgOIS7LBJuCc0CQ7/oyyCrriBHwjrXdCNQ1FVU2NOz
         t23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721674695; x=1722279495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juqIh5cXr76tgWklYbBjz4eG26gFnLSFooG2Ud5pioc=;
        b=Mpwt4GQX78kykSImreY0rrNPBv1Jjm8smMgSOOJV7o24YXpIS2hGu3LsPaJO5tli5F
         Lao+G4NHRssBAkZFWX04sR8HDPiD0pduovm/O4PZtFYSCVTfz5G+wzZ8xfgLDdcoXUG5
         4nSGGfZBblO6yQC3lqvjsME53KrWCEa2nYNcJZKMjUMrAcPK2JUkGYucDh8v7zzaHpwE
         z8mYiSAQ74Ku/XLDfLrj2UshFJ+gxewM/cIS1LLTL8cx9jBZhzFy/lqs6Yz2fOLf0ela
         TvUTe1uGEXiwTJNq6X65QxPH0uU+ID3TJw1ej7KO6cUs5PqgFJGDqSP8t2PipClWDRLG
         Mo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7vHo4mFIUAMqwdXdW8iNvvkxnv8XBwpYbNBlUlAP1pfwK2l9bRgHUF8/8YkuEbKtBfuVoX0FE0u/d9duTnnj01vNruOVtC/pf9xeLWg==
X-Gm-Message-State: AOJu0YwFc8PjozTOnRrPHmfslhLLksTBg81h1fYTKmQWNFrjm3y4+DjA
	3XvfHrPviirnDuCsrBlYB4H2pdiGd6pwPWTi8Gz1sxAoL9o7mzZtIBu7cCsKGX+uIKeLpB9uF+Z
	TfHRR7oO7CPQKC2BHq5X5LHtAucg=
X-Google-Smtp-Source: AGHT+IGSiUQL/QKPhDdW3Ecm4zFPcZk6L3k4n0h46F8ANxNEc2FUYkPBlANpzdRs5OMhc0PxFIHVbOEWXWSlJ4JUp4Y=
X-Received: by 2002:a05:622a:650:b0:43e:717:38cc with SMTP id
 d75a77b69052e-44fa535fd10mr134116201cf.53.1721674694791; Mon, 22 Jul 2024
 11:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
 <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm> <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
 <0d34890b-0769-4b0c-86b7-0a43601962d4@aakef.fastmail.fm> <CAJnrk1Z6WAQU=zmseoPcGymwYy6Ng8Rak07DyVybZxCJHm1ESg@mail.gmail.com>
 <20240719130649.GA2302873@perftesting>
In-Reply-To: <20240719130649.GA2302873@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Jul 2024 11:58:03 -0700
Message-ID: <CAJnrk1bOTr6-aBH8kHOvupWf6=V7087f5f34OqrMCyKVffZ0=w@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: Josef Bacik <josef@toxicpanda.com>
Cc: Bernd Schubert <bs_lists@aakef.fastmail.fm>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, osandov@osandov.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 6:06=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Thu, Jul 18, 2024 at 05:37:06PM -0700, Joanne Koong wrote:
> > On Thu, Jul 18, 2024 at 3:11=E2=80=AFPM Bernd Schubert
> > <bs_lists@aakef.fastmail.fm> wrote:
> > >
> > >
> > >
> > > On 7/18/24 07:24, Joanne Koong wrote:
> > > > On Wed, Jul 17, 2024 at 3:23=E2=80=AFPM Bernd Schubert
> > > > <bernd.schubert@fastmail.fm> wrote:
> > > >>
> > > >> Hi Joanne,
> > > >>
> > > >> On 7/17/24 23:34, Joanne Koong wrote:
> > > >>> There are situations where fuse servers can become unresponsive o=
r take
> > > >>> too long to reply to a request. Currently there is no upper bound=
 on
> > > >>> how long a request may take, which may be frustrating to users wh=
o get
> > > >>> stuck waiting for a request to complete.
> > > >>>
> > > >>> This commit adds a daemon timeout option (in seconds) for fuse re=
quests.
> > > >>> If the timeout elapses before the request is replied to, the requ=
est will
> > > >>> fail with -ETIME.
> > > >>>
> > > >>> There are 3 possibilities for a request that times out:
> > > >>> a) The request times out before the request has been sent to user=
space
> > > >>> b) The request times out after the request has been sent to users=
pace
> > > >>> and before it receives a reply from the server
> > > >>> c) The request times out after the request has been sent to users=
pace
> > > >>> and the server replies while the kernel is timing out the request
> > > >>>
> > > >>> Proper synchronization must be added to ensure that the request i=
s
> > > >>> handled correctly in all of these cases. To this effect, there is=
 a new
> > > >>> FR_PROCESSING bit added to the request flags, which is set atomic=
ally by
> > > >>> either the timeout handler (see fuse_request_timeout()) which is =
invoked
> > > >>> after the request timeout elapses or set by the request reply han=
dler
> > > >>> (see dev_do_write()), whichever gets there first.
> > > >>>
> > > >>> If the reply handler and the timeout handler are executing simult=
aneously
> > > >>> and the reply handler sets FR_PROCESSING before the timeout handl=
er, then
> > > >>> the request is re-queued onto the waitqueue and the kernel will p=
rocess the
> > > >>> reply as though the timeout did not elapse. If the timeout handle=
r sets
> > > >>> FR_PROCESSING before the reply handler, then the request will fai=
l with
> > > >>> -ETIME and the request will be cleaned up.
> > > >>>
> > > >>> Proper acquires on the request reference must be added to ensure =
that the
> > > >>> timeout handler does not drop the last refcount on the request wh=
ile the
> > > >>> reply handler (dev_do_write()) or forwarder handler (dev_do_read(=
)) is
> > > >>> still accessing the request. (By "forwarder handler", this is the=
 handler
> > > >>> that forwards the request to userspace).
> > > >>>
> > > >>> Currently, this is the lifecycle of the request refcount:
> > > >>>
> > > >>> Request is created:
> > > >>> fuse_simple_request -> allocates request, sets refcount to 1
> > > >>>   __fuse_request_send -> acquires refcount
> > > >>>     queues request and waits for reply...
> > > >>> fuse_simple_request -> drops refcount
> > > >>>
> > > >>> Request is freed:
> > > >>> fuse_dev_do_write
> > > >>>   fuse_request_end -> drops refcount on request
> > > >>>
> > > >>> The timeout handler drops the refcount on the request so that the
> > > >>> request is properly cleaned up if a reply is never received. Beca=
use of
> > > >>> this, both the forwarder handler and the reply handler must acqui=
re a refcount
> > > >>> on the request while it accesses the request, and the refcount mu=
st be
> > > >>> acquired while the lock of the list the request is on is held.
> > > >>>
> > > >>> There is a potential race if the request is being forwarded to
> > > >>> userspace while the timeout handler is executing (eg FR_PENDING h=
as
> > > >>> already been cleared but dev_do_read() hasn't finished executing)=
. This
> > > >>> is a problem because this would free the request but the request =
has not
> > > >>> been removed from the fpq list it's on. To prevent this, dev_do_r=
ead()
> > > >>> must check FR_PROCESSING at the end of its logic and remove the r=
equest
> > > >>> from the fpq list if the timeout occurred.
> > > >>>
> > > >>> There is also the case where the connection may be aborted or the
> > > >>> device may be released while the timeout handler is running. To p=
rotect
> > > >>> against an extra refcount drop on the request, the timeout handle=
r
> > > >>> checks the connected state of the list and lets the abort handler=
 drop the
> > > >>> last reference if the abort is running simultaneously. Similarly,=
 the
> > > >>> timeout handler also needs to check if the req->out.h.error is se=
t to
> > > >>> -ESTALE, which indicates that the device release is cleaning up t=
he
> > > >>> request. In both these cases, the timeout handler will return wit=
hout
> > > >>> dropping the refcount.
> > > >>>
> > > >>> Please also note that background requests are not applicable for =
timeouts
> > > >>> since they are asynchronous.
> > > >>
> > > >>
> > > >> This and that thread here actually make me wonder if this is the r=
ight
> > > >> approach
> > > >>
> > > >> https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.xu@sh=
opee.com/T/
> > > >>
> > > >>
> > > >> In  th3 thread above a request got interrupted, but fuse-server st=
ill
> > > >> does not manage stop it. From my point of view, interrupting a req=
uest
> > > >> suggests to add a rather short kernel lifetime for it. With that o=
ne
> > > >
> > > > Hi Bernd,
> > > >
> > > > I believe this solution fixes the problem outlined in that thread
> > > > (namely, that the process gets stuck waiting for a reply). If the
> > > > request is interrupted before it times out, the kernel will wait wi=
th
> > > > a timeout again on the request (timeout would start over, but the
> > > > request will still eventually sooner or later time out). I'm not su=
re
> > > > I agree that we want to cancel the request altogether if it's
> > > > interrupted. For example, if the user uses the user-defined signal
> > > > SIGUSR1, it can be unexpected and arbitrary behavior for the reques=
t
> > > > to be aborted by the kernel. I also don't think this can be consist=
ent
> > > > for what the fuse server will see since some requests may have alre=
ady
> > > > been forwarded to userspace when the request is aborted and some
> > > > requests may not have.
> > > >
> > > > I think if we were to enforce that the request should be aborted wh=
en
> > > > it's interrupted regardless of whether a timeout is specified or no=
t,
> > > > then we should do it similarly to how the timeout handler logic
> > > > handles it in this patch,rather than the implementation in the thre=
ad
> > > > linked above (namely, that the request should be explicitly cleaned=
 up
> > > > immediately instead of when the interrupt request sends a reply); I
> > > > don't believe the implementation in the link handles the case where
> > > > for example the fuse server is in a deadlock and does not reply to =
the
> > > > interrupt request. Also, as I understand it, it is optional for
> > > > servers to reply or not to the interrupt request.
> > >
> > > Hi Joanne,
> > >
> > > yeah, the solution in the link above is definitely not ideal and I th=
ink
> > > a timout based solution would be better. But I think your patch would=
n't
> > > work either right now, unless server side sets a request timeout.
> > > Btw, I would rename the variable 'daemon_timeout' to somethink like
> > > req_timeout.
> > >
> > Hi Bernd,
> >
> > I think we need to figure out if we indeed want the kernel to abort
> > interrupted requests if no request timeout was explicitly set by the
> > server. I'm leaning towards no, for the reasons in my previous reply;
> > in addition to that I'm also not sure if we would be potentially
> > breaking existing filesystems if we introduced this new behavior.
> > Curious to hear your and others' thoughts on this.
> >
> > (Btw, if we did want to add this in, i think the change would be
> > actually pretty simple. We could pretty much just reuse all the logic
> > that's implemented in the timeout handling code. It's very much the
> > same scenario (request getting aborted and needing to protect against
> > races with different handlers))
> >
> > I will rename daemon_timeout to req_timeout in v2. Thanks for the sugge=
stion.
> >
> > > >
> > > >> either needs to wake up in intervals and check if request timeout =
got
> > > >> exceeded or it needs to be an async kernel thread. I think that as=
ync
> > > >> thread would also allow to give a timeout to background requests.
> > > >
> > > > in my opinion, background requests do not need timeouts. As I
> > > > understand it, background requests are used only for direct i/o asy=
nc
> > > > read/writes, writing back dirty pages,and readahead requests genera=
ted
> > > > by the kernel. I don't think fuse servers would have a need for tim=
ing
> > > > out background requests.
> > >
> > > There is another discussion here, where timeouts are a possible altho=
ugh
> > > ugly solution to avoid page copies
> > >
> > > https://lore.kernel.org/linux-kernel/233a9fdf-13ea-488b-a593-5566fc9f=
5d92@fastmail.fm/T/
> > >
> > Thanks for the link, it's an interesting read.
> >
> > >
> > > That is the bg writeback code path.
> > >
> > > >
> > > >>
> > > >> Or we add an async timeout to bg and interupted requests additiona=
lly?
> > > >
> > > > The interrupted request will already have a timeout on it since it
> > > > waits with a timeout again for the reply after it's interrupted.
> > >
> > > If daemon side configures timeouts. And interrupted requests might wa=
nt
> > > to have a different timeout. I will check when I'm back if we can upd=
ate
> > > your patch a bit for that.
> > >
> > > Your patch hooks in quite nicely and basically without overhead into =
fg
> > > (sync) requests. Timing out bg requests will have a bit overhead (unl=
ess
> > > I miss something), so maybe we need two solutions here. And if we wan=
t
> > > to go that route at all, to avoid these extra fuse page copies.
> > >
> > Agreed, I think if we do decide to go down this route, it seems
> > cleaner to me to have the background request timeouts handled
> > separately. Maybe something like having a timer per batch (where
> > "batch" is the group of requests that get flushed at the same time)?
> > That seems to me like the approach with the least overhead.
> >
>
> I don't want to have a bunch of different timeouts, we should just have o=
ne and
> have consistent behavior across all classes of requests.
>
> I think the only thing we should have that is "separate" is a way to set =
request
> timeouts that aren't set by the daemon itself.  Administrators should be =
able to
> set a per-mount timeout via sysfs/algo in order to have some sort of cont=
rol
> over possibly malicious FUSE file systems.
>
> But that should just tie into whatever mechanism you come up with, and
> everything should all behave consistently with that timeout.  Thanks,
>
> Josef

To summarize this thread so far, there are 2 open questions:
1) should interrupted requests be automatically aborted/cancelled by
default (even if no timeout is set)?
2) should background requests also have some timeout enforced on them?

I think the decision on 2) is the blocker for this patch ( 1) could be
added in the future as a separate patch).
Is this the route we want to go down for avoiding the extra page
copies? Who makes the call on this? I'm assuming it's the fuse
maintainer (Miklos)?

