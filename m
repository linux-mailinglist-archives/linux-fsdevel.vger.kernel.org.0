Return-Path: <linux-fsdevel+bounces-38595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6BA0481D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDD3A4155
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517131F4701;
	Tue,  7 Jan 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLkMSEa7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0918A6B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270748; cv=none; b=QjQi5Tl/wa5yj3QC2GpUGID2ccIfSh6Fc1dfHj47tBoeblqPhXc875KohU1lGZciiVJuGQBLpNc/pc3SHqsvi2NYv+aKMKDXeHjfrHPYOL2xZtRzRhkic/TiCaS9nxSkwSL4J+dSfyXASLP4uCTcQ1sP9lhOlMmh6Ti/YaUm0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270748; c=relaxed/simple;
	bh=vUzSIKAStG/JsHC0HvHWN/gR+y1v6GA4tNbXxLlX+8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWLTF8xq1kX3M93gMMOpxAdKREAzir/hNj/2eQJql2g6eFXHKSXU4/7e0oufBG6wu5EtjceuGX3WQTpS4cb7Pe8inZ24uTPNoPFj0it/HYX8auxng8EyiadCCPdOGzrgj/9lNmWCMrLcnH46zZ2GBAx+qlXxt+3RFS/1Jc8aD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLkMSEa7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736270746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mkw0Ooe87CkcSzoFXD+fKvs2EUI4qfBrd4mvpThckbY=;
	b=SLkMSEa7NXS2ss8jb4DSCN6PSmFr/37V8lap43NPhH1co85RBOY+3ZaSkH1jEV7J0YXxA/
	2cHvt74c5JeHlvzS9XYuMQfKvPNQfGQEXAwtzJ+wB31Cfl6b3W/nF2dh2SrISlhSPdhkAi
	tXiRQuHtoEg0s4FfVKVyEGTEkKnSvzU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-hjTcRlLzPBu9SugtaQVwJA-1; Tue,
 07 Jan 2025 12:25:43 -0500
X-MC-Unique: hjTcRlLzPBu9SugtaQVwJA-1
X-Mimecast-MFC-AGG-ID: hjTcRlLzPBu9SugtaQVwJA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A3D619560B2;
	Tue,  7 Jan 2025 17:25:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 85AD1195606B;
	Tue,  7 Jan 2025 17:25:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Jan 2025 18:25:17 +0100 (CET)
Date: Tue, 7 Jan 2025 18:25:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
Message-ID: <20250107172512.GB29771@redhat.com>
References: <20241229135737.GA3293@redhat.com>
 <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
 <20250106163038.GE7233@redhat.com>
 <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
 <20250106183646.GG7233@redhat.com>
 <20250106193336.GH7233@redhat.com>
 <CAHk-=wh-SxjH7uvADd5XJBuM2ReyPcLPyXKvBbwbiS5kod+3hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-SxjH7uvADd5XJBuM2ReyPcLPyXKvBbwbiS5kod+3hA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/06, Linus Torvalds wrote:
>
> On Mon, 6 Jan 2025 at 11:34, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > 1. pipe_read() says
> >
> >          * But when we do wake up writers, we do so using a sync wakeup
> >          * (WF_SYNC), because we want them to get going and generate more
> >          * data for us.
> >
> > OK, WF_SYNC makes sense if pipe_read() or pipe_write() is going to do wait_event()
> > after wake_up(). But wake_up_interruptible_sync_poll() looks at bit misleading if
> > we are going to wakeup the writer or next_reader before return.
>
> This heuristic has always been a bit iffy. And honestly, I think it's
> been driven by benchmarks that aren't necessarily always realistic (ie
> for ping-pong benchmarks, the best behavior is often to stay on the
> same CPU and just schedule between the reader/writer).

Agreed. But my question was not about performance, I just tried to
understand this logic. So in the case of

	wake_up_interruptible_sync_poll(wr_wait);
	wait_event_interruptible_exclusive(wr_read);

WF_SYNC is understandable, "stay on the same CPU" looks like the right
thing, and "_sync_" matches the comment above.

But if we are going to return, wake_up_interruptible_sync_poll() looks
a bit misleading to me.

> > 2. I can't understand this code in pipe_write()
> >
> >         if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
> >                 int err = file_update_time(filp);
> >                 if (err)
> >                         ret = err;
> >                 sb_end_write(file_inode(filp)->i_sb);
> >         }
> >
> >         - it only makes sense in the "fifo" case, right? When
> >           i_sb->s_magic != PIPEFS_MAGIC...
>
> I think we've done it for regular pipes too. You can see it with
> 'fstat()', after all.

Ah, indeed, thanks for correcting me...

And thanks for your other explanations. Again, it is not that I thought
this needs changes, just I was a bit confused. In particular by

	err = file_update_time();
	if (err)
		ret = err;

which doesn't match the usage of file_accessed() in pipe_read().

Oleg.


