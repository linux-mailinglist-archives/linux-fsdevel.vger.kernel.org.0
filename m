Return-Path: <linux-fsdevel+bounces-42580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DBA442D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 15:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26041882CD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191D26AA98;
	Tue, 25 Feb 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+bt/1zR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68318126C18
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493641; cv=none; b=DUHT2ys3d0QgMnz+awcKITsfhB/MMQiXYwoAU+cn7l1P7mNY7B01OyvI29/C2EeQR5LLwJBVODq84tfibBADgIdCs+gZlkDlibC6tOi/3dejd5/ryCGzuTkwZFKITWNiVh5vTFWXLjcbcdNIiZsNxTqFsximUlqi3iMNxOei5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493641; c=relaxed/simple;
	bh=s3CzAGQ9fUPMQrxptT1MpknPbszwu1n+Vjd/Wk9sOQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cpck8gaTReu64UbnbZYs/jW/+cigrAVSECI0O7abTOs4LLlwMRrxlVGiZbxCfeklQ1Gz1Sz/tgGbQLnr3MliMn95ch0UwnjRdVxoiJhQCiOnp1kCeojU0qcaHGtyxIKyBxk9lWlVQhmukiw4Bhf0cvfaatcg9XQ4/s8UW6SB1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+bt/1zR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4fu2PpV3y/MvTpLFuGZiqVh37Wll4MVy1MUpDTWvbQ=;
	b=D+bt/1zRFC0ZOT+xeoMOSUAAxQHdhe0+xRsR067RnnHcdAYT4qHH8BKoIdrV5d/ck6sYyF
	Ayiveoq3kn1AGURcli3GlYmmPEa2RQrAgMvNLt7Aa3LYQj+L6UiGMpEnV6Fdw3/d2H4CMi
	jYclCAX45Uo894ekAPTbd4CcmFHXjm8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-tITzaPO9OMK2Znf-2BEB0w-1; Tue,
 25 Feb 2025 09:27:15 -0500
X-MC-Unique: tITzaPO9OMK2Znf-2BEB0w-1
X-Mimecast-MFC-AGG-ID: tITzaPO9OMK2Znf-2BEB0w_1740493633
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AF2118D95DC;
	Tue, 25 Feb 2025 14:27:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.211])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C6C1F1800352;
	Tue, 25 Feb 2025 14:27:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Feb 2025 15:26:42 +0100 (CET)
Date: Tue, 25 Feb 2025 15:26:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250225142632.GA29585@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <CAHk-=wi+P5__7LfbTX66shvYC1X11G2ZdKcg4psi+k_pD3sO+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+P5__7LfbTX66shvYC1X11G2ZdKcg4psi+k_pD3sO+w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/24, Linus Torvalds wrote:
>
> However, I see at least one case where this exclusive wakeup seems broken:
>
>                 /*
>                  * But because we didn't read anything, at this point we can
>                  * just return directly with -ERESTARTSYS if we're interrupted,
>                  * since we've done any required wakeups and there's no need
>                  * to mark anything accessed. And we've dropped the lock.
>                  */
>                 if (wait_event_interruptible_exclusive(pipe->rd_wait,
> pipe_readable(pipe)) < 0)
>                         return -ERESTARTSYS;
>
> and I'm wondering if the issue is that the *readers* got stuck,
> Because that "return -ERESTARTSYS" path now basically will by-pass the
> logic to wake up the next exclusive waiter.

I think this is fine... lets denote this reader as R.

> Because that "return -ERESTARTSYS" is *after* the reader has been on
> the rd_wait queue - and possibly gotten the only wakeup that any of
> the readers will ever get - and now it returns without waking up any
> other reader.

I think this can't happen. ___wait_event() does

	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
	for (;;) {								\
		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
										\
		if (condition)							\
			break;							\
										\
		if (___wait_is_interruptible(state) && __int) {			\
			__ret = __int;						\
			goto __out;						\
		}								\
										\
		cmd;								\
	}									\

and in this case condition == pipe_readable(pipe), cmd == schedule().

Suppose that R got that only wakeup, and wake_up() races with some signal
so that signal_pending(R) is true.

In this case prepare_to_wait_event() will return -ERESTARTSYS, but
___wait_event() won't return this error code, it will check pipe_readable()
and return 0.

After that R will restart the main loop with wake_next_reader = true,
and whatever it does it should do wake_up(pipe->rd_wait) before return.

Note also that prepare_to_wait_event() removes the waiter from the
wait_queue_head->head list, so another wake_up() can't pick this task.

Can ___wait_event() miss the pipe_readable() event in this case? No,
both wake_up() and prepare_to_wait_event() take the same wq_head->lock.

What if pipe_readable() is actually false? Say, a spurios wakeup or, say,
pipe_write() does wake_up(rd_wait) when another reader has already made
the pipe_readable() condition false? This case looks "obviously fine" too.

So I am still confused.

I will wait for reply from Sapkal, then I'll try to make a debugging patch.

Oleg.


