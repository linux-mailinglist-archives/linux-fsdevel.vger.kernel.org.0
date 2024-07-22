Return-Path: <linux-fsdevel+bounces-24103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B503939549
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 23:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36571F2244A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683B381A4;
	Mon, 22 Jul 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnIHfWQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436F28385
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682919; cv=none; b=DIAlVMtdHiZlDgNUh1Ila+uMQPrzwoxQ1OoXdqpXfgZFeNS7OxAo2DDm8Rv5r1IyPWferUfCMdtl+5Cq5vhLXcVe0T+PqlcX0kXOERMwthnpXcWAdcCbjuqxUkA3W3EoSyqGEP6B1vxX2g2hQdXaZalxP0Z72qo6DwI6yd8X/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682919; c=relaxed/simple;
	bh=1XLUZUvFYkDcTWPnI1xtCM/sFxX9BRfw1o5SuJ3j5VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umlmsngqxs8sXnJydLBSOZh/6NQVRELkg/PDk4vqAG5gMqrYox/6O9MRrxIceV9YQoAJJ0qCqpLBRE+TFucreTtcupLdGEVGx+cBy32i4wJ6kSeWePLhXI/iFF0zx/Bj3Rc1zov+ry+M1IbrNXC0qfhYPUUzUoPAX4FfentUlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnIHfWQq; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-708bf659898so2345271a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721682916; x=1722287716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx31oD+cfhEZOx7huZFVJn8h4RdEdtbQfmczcRYD0rY=;
        b=nnIHfWQqvumwCaIl8VavOBDPWnbPhcLkm+I7xm1z0S2xvz/wEPqMSXhbS/4eK9Atuv
         JLZNuNsv1L+lyXFrDLd/be+cDGXyGP4Xl1embuF/tEbvcAQhQFe46QeLNDc+CY2/FWNm
         axJuqncAmPM/LxcJQ/vveYz/xIleedpkrYTUB2XLbesTJtaWB3b0x4Bd9HuB4Dc3UvDc
         zTNhqBUlbWLcNpQgr4m3cAYU2O2nv85ShAZdOZqvdvmJ1ngfqafJLIJqwn8rJ93+ZYti
         iTPE464yI492GM4GWwdzXhi7X3exWfEX7dDozqKkBrmrXc4PScXqwH1DPT4yjd1785b8
         DwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682916; x=1722287716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx31oD+cfhEZOx7huZFVJn8h4RdEdtbQfmczcRYD0rY=;
        b=MEacYU3AjmkZtyWVvNtw0mD3DgaCZJdwOAR1KZ0fQIyty3b/1xx2gDVFLr5sSxCVO5
         utBwD64egCAi0MTb4o2mBHoc0dvQmX9sqOxhqjYEilgn+6ed1EmPIH8k7gN3kwDrti4F
         jsbVkBg7muuk1eQZohqDx4fogT8r6fnxPWmIXpjsNB6weoq7bjx028ei/6YJFz4auYwf
         lHqkBH+/sIfIJNX3e6Xw31cQT2Ac4AuCm4JorWeq0VraLwfFN2VJ7JRhRcrFlnQw3xWB
         /woqY/e4Sd3PdECwkbDVKDQ0FXAC3suFPnnLt6dw3BoPCXMw1CvSEBiLvyrozpaqtoUh
         6Bsw==
X-Forwarded-Encrypted: i=1; AJvYcCUURsGRHFNLCQYJmtxYpVNi9249hOzYtqgS4/scmanU4/ubaSKfhyBTuUzUiQQnCgatcWzuAgt7paP+ijRDJBL/yvzxy9iD1uVP0Vw49Q==
X-Gm-Message-State: AOJu0YzPqv9J/QyGoRozeRWmKbYwkMZUbW/BIAWMef1nfj0gT+4qVwch
	iF1fpdEIN6AYT+7xxPV0zAGKU6M2QJfGGsxt4x/0Ze03boPmu3CWyjaspyZMpPUKf8vxObk80i0
	Uh8jIIlO0JoGowOyfCyMOT0aauIQ=
X-Google-Smtp-Source: AGHT+IGwostvPU49Hh9dKbe/dUXr+p2DgQvqXIoE038RbuiRfFHdR92PtMFc1lcMilHr9skIRTwP28ZvqKSgOWYpNTY=
X-Received: by 2002:a05:6830:6811:b0:703:6a50:9097 with SMTP id
 46e09a7af769-709008ba9e5mr10238064a34.8.1721682916228; Mon, 22 Jul 2024
 14:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
 <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm> <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
 <0d34890b-0769-4b0c-86b7-0a43601962d4@aakef.fastmail.fm> <CAJnrk1Z6WAQU=zmseoPcGymwYy6Ng8Rak07DyVybZxCJHm1ESg@mail.gmail.com>
 <20240719130649.GA2302873@perftesting> <CAJnrk1bOTr6-aBH8kHOvupWf6=V7087f5f34OqrMCyKVffZ0=w@mail.gmail.com>
 <20240722205217.GB2392440@perftesting>
In-Reply-To: <20240722205217.GB2392440@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Jul 2024 14:15:05 -0700
Message-ID: <CAJnrk1bgw+iFxR47vUueDR1twWth=0sV4Hf0rXchD-YCmtLQ-Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: Josef Bacik <josef@toxicpanda.com>
Cc: Bernd Schubert <bs_lists@aakef.fastmail.fm>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, osandov@osandov.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:52=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Mon, Jul 22, 2024 at 11:58:03AM -0700, Joanne Koong wrote:
> > On Fri, Jul 19, 2024 at 6:06=E2=80=AFAM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 05:37:06PM -0700, Joanne Koong wrote:
> > > > On Thu, Jul 18, 2024 at 3:11=E2=80=AFPM Bernd Schubert
> > > > <bs_lists@aakef.fastmail.fm> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 7/18/24 07:24, Joanne Koong wrote:
> > > > > > On Wed, Jul 17, 2024 at 3:23=E2=80=AFPM Bernd Schubert
> > > > > > <bernd.schubert@fastmail.fm> wrote:
> > > > > >>
> > > > > >> Hi Joanne,
> > > > > >>
> > > > > >> On 7/17/24 23:34, Joanne Koong wrote:
> > > > > >>> There are situations where fuse servers can become unresponsi=
ve or take
> > > > > >>> too long to reply to a request. Currently there is no upper b=
ound on
> > > > > >>> how long a request may take, which may be frustrating to user=
s who get
> > > > > >>> stuck waiting for a request to complete.
> > > > > >>>
> > > > > >>> This commit adds a daemon timeout option (in seconds) for fus=
e requests.
> > > > > >>> If the timeout elapses before the request is replied to, the =
request will
> > > > > >>> fail with -ETIME.
> > > > > >>>
> > > > > >>> There are 3 possibilities for a request that times out:
> > > > > >>> a) The request times out before the request has been sent to =
userspace
> > > > > >>> b) The request times out after the request has been sent to u=
serspace
> > > > > >>> and before it receives a reply from the server
> > > > > >>> c) The request times out after the request has been sent to u=
serspace
> > > > > >>> and the server replies while the kernel is timing out the req=
uest
> > > > > >>>
> > > > > >>> Proper synchronization must be added to ensure that the reque=
st is
> > > > > >>> handled correctly in all of these cases. To this effect, ther=
e is a new
> > > > > >>> FR_PROCESSING bit added to the request flags, which is set at=
omically by
> > > > > >>> either the timeout handler (see fuse_request_timeout()) which=
 is invoked
> > > > > >>> after the request timeout elapses or set by the request reply=
 handler
> > > > > >>> (see dev_do_write()), whichever gets there first.
> > > > > >>>
> > > > > >>> If the reply handler and the timeout handler are executing si=
multaneously
> > > > > >>> and the reply handler sets FR_PROCESSING before the timeout h=
andler, then
> > > > > >>> the request is re-queued onto the waitqueue and the kernel wi=
ll process the
> > > > > >>> reply as though the timeout did not elapse. If the timeout ha=
ndler sets
> > > > > >>> FR_PROCESSING before the reply handler, then the request will=
 fail with
> > > > > >>> -ETIME and the request will be cleaned up.
> > > > > >>>
> > > > > >>> Proper acquires on the request reference must be added to ens=
ure that the
> > > > > >>> timeout handler does not drop the last refcount on the reques=
t while the
> > > > > >>> reply handler (dev_do_write()) or forwarder handler (dev_do_r=
ead()) is
> > > > > >>> still accessing the request. (By "forwarder handler", this is=
 the handler
> > > > > >>> that forwards the request to userspace).
> > > > > >>>
> > > > > >>> Currently, this is the lifecycle of the request refcount:
> > > > > >>>
> > > > > >>> Request is created:
> > > > > >>> fuse_simple_request -> allocates request, sets refcount to 1
> > > > > >>>   __fuse_request_send -> acquires refcount
> > > > > >>>     queues request and waits for reply...
> > > > > >>> fuse_simple_request -> drops refcount
> > > > > >>>
> > > > > >>> Request is freed:
> > > > > >>> fuse_dev_do_write
> > > > > >>>   fuse_request_end -> drops refcount on request
> > > > > >>>
> > > > > >>> The timeout handler drops the refcount on the request so that=
 the
> > > > > >>> request is properly cleaned up if a reply is never received. =
Because of
> > > > > >>> this, both the forwarder handler and the reply handler must a=
cquire a refcount
> > > > > >>> on the request while it accesses the request, and the refcoun=
t must be
> > > > > >>> acquired while the lock of the list the request is on is held=
.
> > > > > >>>
> > > > > >>> There is a potential race if the request is being forwarded t=
o
> > > > > >>> userspace while the timeout handler is executing (eg FR_PENDI=
NG has
> > > > > >>> already been cleared but dev_do_read() hasn't finished execut=
ing). This
> > > > > >>> is a problem because this would free the request but the requ=
est has not
> > > > > >>> been removed from the fpq list it's on. To prevent this, dev_=
do_read()
> > > > > >>> must check FR_PROCESSING at the end of its logic and remove t=
he request
> > > > > >>> from the fpq list if the timeout occurred.
> > > > > >>>
> > > > > >>> There is also the case where the connection may be aborted or=
 the
> > > > > >>> device may be released while the timeout handler is running. =
To protect
> > > > > >>> against an extra refcount drop on the request, the timeout ha=
ndler
> > > > > >>> checks the connected state of the list and lets the abort han=
dler drop the
> > > > > >>> last reference if the abort is running simultaneously. Simila=
rly, the
> > > > > >>> timeout handler also needs to check if the req->out.h.error i=
s set to
> > > > > >>> -ESTALE, which indicates that the device release is cleaning =
up the
> > > > > >>> request. In both these cases, the timeout handler will return=
 without
> > > > > >>> dropping the refcount.
> > > > > >>>
> > > > > >>> Please also note that background requests are not applicable =
for timeouts
> > > > > >>> since they are asynchronous.
> > > > > >>
> > > > > >>
> > > > > >> This and that thread here actually make me wonder if this is t=
he right
> > > > > >> approach
> > > > > >>
> > > > > >> https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.x=
u@shopee.com/T/
> > > > > >>
> > > > > >>
> > > > > >> In  th3 thread above a request got interrupted, but fuse-serve=
r still
> > > > > >> does not manage stop it. From my point of view, interrupting a=
 request
> > > > > >> suggests to add a rather short kernel lifetime for it. With th=
at one
> > > > > >
> > > > > > Hi Bernd,
> > > > > >
> > > > > > I believe this solution fixes the problem outlined in that thre=
ad
> > > > > > (namely, that the process gets stuck waiting for a reply). If t=
he
> > > > > > request is interrupted before it times out, the kernel will wai=
t with
> > > > > > a timeout again on the request (timeout would start over, but t=
he
> > > > > > request will still eventually sooner or later time out). I'm no=
t sure
> > > > > > I agree that we want to cancel the request altogether if it's
> > > > > > interrupted. For example, if the user uses the user-defined sig=
nal
> > > > > > SIGUSR1, it can be unexpected and arbitrary behavior for the re=
quest
> > > > > > to be aborted by the kernel. I also don't think this can be con=
sistent
> > > > > > for what the fuse server will see since some requests may have =
already
> > > > > > been forwarded to userspace when the request is aborted and som=
e
> > > > > > requests may not have.
> > > > > >
> > > > > > I think if we were to enforce that the request should be aborte=
d when
> > > > > > it's interrupted regardless of whether a timeout is specified o=
r not,
> > > > > > then we should do it similarly to how the timeout handler logic
> > > > > > handles it in this patch,rather than the implementation in the =
thread
> > > > > > linked above (namely, that the request should be explicitly cle=
aned up
> > > > > > immediately instead of when the interrupt request sends a reply=
); I
> > > > > > don't believe the implementation in the link handles the case w=
here
> > > > > > for example the fuse server is in a deadlock and does not reply=
 to the
> > > > > > interrupt request. Also, as I understand it, it is optional for
> > > > > > servers to reply or not to the interrupt request.
> > > > >
> > > > > Hi Joanne,
> > > > >
> > > > > yeah, the solution in the link above is definitely not ideal and =
I think
> > > > > a timout based solution would be better. But I think your patch w=
ouldn't
> > > > > work either right now, unless server side sets a request timeout.
> > > > > Btw, I would rename the variable 'daemon_timeout' to somethink li=
ke
> > > > > req_timeout.
> > > > >
> > > > Hi Bernd,
> > > >
> > > > I think we need to figure out if we indeed want the kernel to abort
> > > > interrupted requests if no request timeout was explicitly set by th=
e
> > > > server. I'm leaning towards no, for the reasons in my previous repl=
y;
> > > > in addition to that I'm also not sure if we would be potentially
> > > > breaking existing filesystems if we introduced this new behavior.
> > > > Curious to hear your and others' thoughts on this.
> > > >
> > > > (Btw, if we did want to add this in, i think the change would be
> > > > actually pretty simple. We could pretty much just reuse all the log=
ic
> > > > that's implemented in the timeout handling code. It's very much the
> > > > same scenario (request getting aborted and needing to protect again=
st
> > > > races with different handlers))
> > > >
> > > > I will rename daemon_timeout to req_timeout in v2. Thanks for the s=
uggestion.
> > > >
> > > > > >
> > > > > >> either needs to wake up in intervals and check if request time=
out got
> > > > > >> exceeded or it needs to be an async kernel thread. I think tha=
t async
> > > > > >> thread would also allow to give a timeout to background reques=
ts.
> > > > > >
> > > > > > in my opinion, background requests do not need timeouts. As I
> > > > > > understand it, background requests are used only for direct i/o=
 async
> > > > > > read/writes, writing back dirty pages,and readahead requests ge=
nerated
> > > > > > by the kernel. I don't think fuse servers would have a need for=
 timing
> > > > > > out background requests.
> > > > >
> > > > > There is another discussion here, where timeouts are a possible a=
lthough
> > > > > ugly solution to avoid page copies
> > > > >
> > > > > https://lore.kernel.org/linux-kernel/233a9fdf-13ea-488b-a593-5566=
fc9f5d92@fastmail.fm/T/
> > > > >
> > > > Thanks for the link, it's an interesting read.
> > > >
> > > > >
> > > > > That is the bg writeback code path.
> > > > >
> > > > > >
> > > > > >>
> > > > > >> Or we add an async timeout to bg and interupted requests addit=
ionally?
> > > > > >
> > > > > > The interrupted request will already have a timeout on it since=
 it
> > > > > > waits with a timeout again for the reply after it's interrupted=
.
> > > > >
> > > > > If daemon side configures timeouts. And interrupted requests migh=
t want
> > > > > to have a different timeout. I will check when I'm back if we can=
 update
> > > > > your patch a bit for that.
> > > > >
> > > > > Your patch hooks in quite nicely and basically without overhead i=
nto fg
> > > > > (sync) requests. Timing out bg requests will have a bit overhead =
(unless
> > > > > I miss something), so maybe we need two solutions here. And if we=
 want
> > > > > to go that route at all, to avoid these extra fuse page copies.
> > > > >
> > > > Agreed, I think if we do decide to go down this route, it seems
> > > > cleaner to me to have the background request timeouts handled
> > > > separately. Maybe something like having a timer per batch (where
> > > > "batch" is the group of requests that get flushed at the same time)=
?
> > > > That seems to me like the approach with the least overhead.
> > > >
> > >
> > > I don't want to have a bunch of different timeouts, we should just ha=
ve one and
> > > have consistent behavior across all classes of requests.
> > >
> > > I think the only thing we should have that is "separate" is a way to =
set request
> > > timeouts that aren't set by the daemon itself.  Administrators should=
 be able to
> > > set a per-mount timeout via sysfs/algo in order to have some sort of =
control
> > > over possibly malicious FUSE file systems.
> > >
> > > But that should just tie into whatever mechanism you come up with, an=
d
> > > everything should all behave consistently with that timeout.  Thanks,
> > >
> > > Josef
> >
> > To summarize this thread so far, there are 2 open questions:
> > 1) should interrupted requests be automatically aborted/cancelled by
> > default (even if no timeout is set)?
> > 2) should background requests also have some timeout enforced on them?
>
> Yes I think background requests should have a timeout enforced on them if=
 it's
> set.  Page writeout is actually one of the bigger problems because stuff =
will
> just hang forever, like if you hit sync or something (which a lot of
> applications do).
>

Sounds good, I will add in timeouts for background requests for v2.

> For #1 I have to think some more and look at what the mechanics/expectati=
ons of
> those requests are, but if it's a thing you can leave for a follup them t=
hat
> sounds good.
>
> Additionally I think leaving the extra page copy thing as future work onc=
e this
> work is done is the best bet.
>
> Miklos are you around?  We've had a few different patches/discussions goi=
ng on.
> I assume you are/have been on summer vacation.  Thanks,
>
> Josef

