Return-Path: <linux-fsdevel+bounces-23999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 474C793781C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE07F1F225EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637513C67D;
	Fri, 19 Jul 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zArPjj6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FB5811A
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394415; cv=none; b=MtNt2768QUYlB1WaxmaoAkiqDt0Wa5Auy7UScvaix4ED5KECmfGcYsLzHd5BYg9Q1OXhyi1ROgLef4foQeg/FTtcWOTGbXF9E2cHBm54bvLqeOE5sjhpvr4gKju8s8AxF13vbgR49vFa43PjbL1nAiZ7UDrYYvJC2QtrYLqM9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394415; c=relaxed/simple;
	bh=ctSpZK02Bq1kGLZavabmlQVEKkXQhRBBbO+yTpCniFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3VLFmTOT7TW4eIvsDW3Rs2ZVYbt9JUSDmZTOADSo2RnEg7CB0J9ndHmdXF7xvYg2xpN5ABVmbL9Ozj69CNMIOHEKBHMbuHUnweExJHS8sme6o+BHCiWtCFeZ2xw+Yzf88g+6GB8RivMBpqQOlMpIIVqEkeMpqoLUtwG189h1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zArPjj6z; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f16cad2a7so91214485a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721394410; x=1721999210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMn78po2FLWa4HgynkMHoB8ESL7XVgwiRft4AGfUbuA=;
        b=zArPjj6zgXz0s4sLaZ/6C0YvbgIL2oHSWVWBpmD1e0z36HcsQge3+hzm6ZNvuysga5
         HEYvMVS2nyeDZ7qiL6nUt7fZfqpz0q+RRT5umPZTIWkOvGpRNHzr5f/UgbjpjHGK01Mc
         x0fIyUeV1L2ohOlFrJYZ2PgFsFa3NkvrBUn5CWHX+VR5OHhKuzDTzybc+KMayAW8GL6s
         Syj7DbLqQd45in2PLD5Ib45CK17/9tcKWloK+TpsYIBD3q420pVMdOnmMpWQQRpWU8cH
         ErqIrmxZm3ECfl/8k/uS7QwpNIZBRTLAwa34JB9QpLaWP9jRWzGXbM9VlqbJuj2Aar2P
         WW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721394410; x=1721999210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMn78po2FLWa4HgynkMHoB8ESL7XVgwiRft4AGfUbuA=;
        b=xFPClUi5V0+ZAUkGI+kDibYNVvBVuTZNjvr+kiCOJBa12oDQY+2xCRoVu59+EQ1wHU
         QaDI5zBvI3cE8KjcSfNb3ASK9HIpzZ3LpgzZif67xpJAY7K2zygXFuwb/hVkC5/lM/nY
         R9kTW+R/9yUKz78b5B9oeLDpN3cRSjJzJNyP+q9VJRFUF9aAwjTJiqh5y/wWIEZFnn1D
         1sbMXNao7P99lnwI5oKjiv1Eluh3h8kqMbu37RRsgUA5/JaFibOqX1NgdutsXCVFyS7F
         d2arQC8I+Nj6FBL+UTxDPWIADRNH7GC9uRyR9mcXAp+OMQqN5KO0NmEMD5+D13lvZ9z5
         0cXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxzj+T78QMFPAbUFB4Il4S4cmSROuSb8hDz8gyC90HcN9NoP5mQJMbQcg8YYNJf7tjwq9q+iTciEZKm5W3m/jSmI926RW2Pf74UtjFIQ==
X-Gm-Message-State: AOJu0YzQocyMI048IgovFlTspcyZwFQ0xBt2HzpIe74BNQ4a87iwNVOF
	5PQWT1Dh6rYvLzaQEh80PsM+BbG6TjaduyRxnlfBbfAsqIxxXYNJqu/6RDhRTw8=
X-Google-Smtp-Source: AGHT+IF92yYsAIlo2DHDrM2SS89S3a5QE3GHiRlq2hUdIU20Y1PDekMWknPoGjkGZhYW6r+yom9RJA==
X-Received: by 2002:a05:620a:4614:b0:79f:11d7:8175 with SMTP id af79cd13be357-7a19392329amr446566785a.32.1721394410461;
        Fri, 19 Jul 2024 06:06:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199013905sm76371185a.67.2024.07.19.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 06:06:50 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:06:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bs_lists@aakef.fastmail.fm>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, osandov@osandov.com,
	kernel-team@meta.com
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse
 requests
Message-ID: <20240719130649.GA2302873@perftesting>
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
 <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm>
 <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
 <0d34890b-0769-4b0c-86b7-0a43601962d4@aakef.fastmail.fm>
 <CAJnrk1Z6WAQU=zmseoPcGymwYy6Ng8Rak07DyVybZxCJHm1ESg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z6WAQU=zmseoPcGymwYy6Ng8Rak07DyVybZxCJHm1ESg@mail.gmail.com>

On Thu, Jul 18, 2024 at 05:37:06PM -0700, Joanne Koong wrote:
> On Thu, Jul 18, 2024 at 3:11 PM Bernd Schubert
> <bs_lists@aakef.fastmail.fm> wrote:
> >
> >
> >
> > On 7/18/24 07:24, Joanne Koong wrote:
> > > On Wed, Jul 17, 2024 at 3:23 PM Bernd Schubert
> > > <bernd.schubert@fastmail.fm> wrote:
> > >>
> > >> Hi Joanne,
> > >>
> > >> On 7/17/24 23:34, Joanne Koong wrote:
> > >>> There are situations where fuse servers can become unresponsive or take
> > >>> too long to reply to a request. Currently there is no upper bound on
> > >>> how long a request may take, which may be frustrating to users who get
> > >>> stuck waiting for a request to complete.
> > >>>
> > >>> This commit adds a daemon timeout option (in seconds) for fuse requests.
> > >>> If the timeout elapses before the request is replied to, the request will
> > >>> fail with -ETIME.
> > >>>
> > >>> There are 3 possibilities for a request that times out:
> > >>> a) The request times out before the request has been sent to userspace
> > >>> b) The request times out after the request has been sent to userspace
> > >>> and before it receives a reply from the server
> > >>> c) The request times out after the request has been sent to userspace
> > >>> and the server replies while the kernel is timing out the request
> > >>>
> > >>> Proper synchronization must be added to ensure that the request is
> > >>> handled correctly in all of these cases. To this effect, there is a new
> > >>> FR_PROCESSING bit added to the request flags, which is set atomically by
> > >>> either the timeout handler (see fuse_request_timeout()) which is invoked
> > >>> after the request timeout elapses or set by the request reply handler
> > >>> (see dev_do_write()), whichever gets there first.
> > >>>
> > >>> If the reply handler and the timeout handler are executing simultaneously
> > >>> and the reply handler sets FR_PROCESSING before the timeout handler, then
> > >>> the request is re-queued onto the waitqueue and the kernel will process the
> > >>> reply as though the timeout did not elapse. If the timeout handler sets
> > >>> FR_PROCESSING before the reply handler, then the request will fail with
> > >>> -ETIME and the request will be cleaned up.
> > >>>
> > >>> Proper acquires on the request reference must be added to ensure that the
> > >>> timeout handler does not drop the last refcount on the request while the
> > >>> reply handler (dev_do_write()) or forwarder handler (dev_do_read()) is
> > >>> still accessing the request. (By "forwarder handler", this is the handler
> > >>> that forwards the request to userspace).
> > >>>
> > >>> Currently, this is the lifecycle of the request refcount:
> > >>>
> > >>> Request is created:
> > >>> fuse_simple_request -> allocates request, sets refcount to 1
> > >>>   __fuse_request_send -> acquires refcount
> > >>>     queues request and waits for reply...
> > >>> fuse_simple_request -> drops refcount
> > >>>
> > >>> Request is freed:
> > >>> fuse_dev_do_write
> > >>>   fuse_request_end -> drops refcount on request
> > >>>
> > >>> The timeout handler drops the refcount on the request so that the
> > >>> request is properly cleaned up if a reply is never received. Because of
> > >>> this, both the forwarder handler and the reply handler must acquire a refcount
> > >>> on the request while it accesses the request, and the refcount must be
> > >>> acquired while the lock of the list the request is on is held.
> > >>>
> > >>> There is a potential race if the request is being forwarded to
> > >>> userspace while the timeout handler is executing (eg FR_PENDING has
> > >>> already been cleared but dev_do_read() hasn't finished executing). This
> > >>> is a problem because this would free the request but the request has not
> > >>> been removed from the fpq list it's on. To prevent this, dev_do_read()
> > >>> must check FR_PROCESSING at the end of its logic and remove the request
> > >>> from the fpq list if the timeout occurred.
> > >>>
> > >>> There is also the case where the connection may be aborted or the
> > >>> device may be released while the timeout handler is running. To protect
> > >>> against an extra refcount drop on the request, the timeout handler
> > >>> checks the connected state of the list and lets the abort handler drop the
> > >>> last reference if the abort is running simultaneously. Similarly, the
> > >>> timeout handler also needs to check if the req->out.h.error is set to
> > >>> -ESTALE, which indicates that the device release is cleaning up the
> > >>> request. In both these cases, the timeout handler will return without
> > >>> dropping the refcount.
> > >>>
> > >>> Please also note that background requests are not applicable for timeouts
> > >>> since they are asynchronous.
> > >>
> > >>
> > >> This and that thread here actually make me wonder if this is the right
> > >> approach
> > >>
> > >> https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.xu@shopee.com/T/
> > >>
> > >>
> > >> In  th3 thread above a request got interrupted, but fuse-server still
> > >> does not manage stop it. From my point of view, interrupting a request
> > >> suggests to add a rather short kernel lifetime for it. With that one
> > >
> > > Hi Bernd,
> > >
> > > I believe this solution fixes the problem outlined in that thread
> > > (namely, that the process gets stuck waiting for a reply). If the
> > > request is interrupted before it times out, the kernel will wait with
> > > a timeout again on the request (timeout would start over, but the
> > > request will still eventually sooner or later time out). I'm not sure
> > > I agree that we want to cancel the request altogether if it's
> > > interrupted. For example, if the user uses the user-defined signal
> > > SIGUSR1, it can be unexpected and arbitrary behavior for the request
> > > to be aborted by the kernel. I also don't think this can be consistent
> > > for what the fuse server will see since some requests may have already
> > > been forwarded to userspace when the request is aborted and some
> > > requests may not have.
> > >
> > > I think if we were to enforce that the request should be aborted when
> > > it's interrupted regardless of whether a timeout is specified or not,
> > > then we should do it similarly to how the timeout handler logic
> > > handles it in this patch,rather than the implementation in the thread
> > > linked above (namely, that the request should be explicitly cleaned up
> > > immediately instead of when the interrupt request sends a reply); I
> > > don't believe the implementation in the link handles the case where
> > > for example the fuse server is in a deadlock and does not reply to the
> > > interrupt request. Also, as I understand it, it is optional for
> > > servers to reply or not to the interrupt request.
> >
> > Hi Joanne,
> >
> > yeah, the solution in the link above is definitely not ideal and I think
> > a timout based solution would be better. But I think your patch wouldn't
> > work either right now, unless server side sets a request timeout.
> > Btw, I would rename the variable 'daemon_timeout' to somethink like
> > req_timeout.
> >
> Hi Bernd,
> 
> I think we need to figure out if we indeed want the kernel to abort
> interrupted requests if no request timeout was explicitly set by the
> server. I'm leaning towards no, for the reasons in my previous reply;
> in addition to that I'm also not sure if we would be potentially
> breaking existing filesystems if we introduced this new behavior.
> Curious to hear your and others' thoughts on this.
> 
> (Btw, if we did want to add this in, i think the change would be
> actually pretty simple. We could pretty much just reuse all the logic
> that's implemented in the timeout handling code. It's very much the
> same scenario (request getting aborted and needing to protect against
> races with different handlers))
> 
> I will rename daemon_timeout to req_timeout in v2. Thanks for the suggestion.
> 
> > >
> > >> either needs to wake up in intervals and check if request timeout got
> > >> exceeded or it needs to be an async kernel thread. I think that async
> > >> thread would also allow to give a timeout to background requests.
> > >
> > > in my opinion, background requests do not need timeouts. As I
> > > understand it, background requests are used only for direct i/o async
> > > read/writes, writing back dirty pages,and readahead requests generated
> > > by the kernel. I don't think fuse servers would have a need for timing
> > > out background requests.
> >
> > There is another discussion here, where timeouts are a possible although
> > ugly solution to avoid page copies
> >
> > https://lore.kernel.org/linux-kernel/233a9fdf-13ea-488b-a593-5566fc9f5d92@fastmail.fm/T/
> >
> Thanks for the link, it's an interesting read.
> 
> >
> > That is the bg writeback code path.
> >
> > >
> > >>
> > >> Or we add an async timeout to bg and interupted requests additionally?
> > >
> > > The interrupted request will already have a timeout on it since it
> > > waits with a timeout again for the reply after it's interrupted.
> >
> > If daemon side configures timeouts. And interrupted requests might want
> > to have a different timeout. I will check when I'm back if we can update
> > your patch a bit for that.
> >
> > Your patch hooks in quite nicely and basically without overhead into fg
> > (sync) requests. Timing out bg requests will have a bit overhead (unless
> > I miss something), so maybe we need two solutions here. And if we want
> > to go that route at all, to avoid these extra fuse page copies.
> >
> Agreed, I think if we do decide to go down this route, it seems
> cleaner to me to have the background request timeouts handled
> separately. Maybe something like having a timer per batch (where
> "batch" is the group of requests that get flushed at the same time)?
> That seems to me like the approach with the least overhead.
> 

I don't want to have a bunch of different timeouts, we should just have one and
have consistent behavior across all classes of requests.

I think the only thing we should have that is "separate" is a way to set request
timeouts that aren't set by the daemon itself.  Administrators should be able to
set a per-mount timeout via sysfs/algo in order to have some sort of control
over possibly malicious FUSE file systems.

But that should just tie into whatever mechanism you come up with, and
everything should all behave consistently with that timeout.  Thanks,

Josef

