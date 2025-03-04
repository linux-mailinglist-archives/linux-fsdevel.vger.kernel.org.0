Return-Path: <linux-fsdevel+bounces-43101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00581A4DEDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA83B1B35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14237202F68;
	Tue,  4 Mar 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBk3ZA4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8B1FECDB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093869; cv=none; b=W+sU4rMpJJHXXxxnAbm3O3bP/NTkX1PxDtmFnsOBQrGzqhvZGIQYqKDyAQPcEDlPnVHxDxeCCwKGWKZ3WFc6jAJ8RA17eEiKq9FGk3j1t8OaNsvgOA1/J230uelFmriEeLp8mR7ipdd3bcNj90TSG/Qs5TOoDe2xmEY7OtTl578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093869; c=relaxed/simple;
	bh=4OLzeUheQgpWpByMFwnjHXPV/WLf3LL/1+pHyHMwHgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHff6wluosbyc2VsD54cYsM2Twngo6mKma6ta/nGI8G3gTxMyuMEMUJ4snCYnWxJsF4AxelwTD+az40aF9GYkoQ3I6vOCCsbvSY8BPl2Ash7PR8gWt9DI7hnNlvMMDg1RsEOTfZ/oWZwlttOpXsjNHR+fTq8KrfxJf2S7ey9rAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBk3ZA4T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741093862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szQdnM7GPw+ldN+eS33rGIs6AIDNE1MMTINOekM8Jog=;
	b=iBk3ZA4T8Q4WgbzgdoRWWV64/M5CI0zeSQ3r6elxMxwmTTkn5PNu8VhZvDl0CTO7YWL99O
	nhdIcNGba02CbNNpq/1ki/kWnemABXOUreSxe8U2pv5Am6rU+gtle6Jw+/Fcx0PomlBktV
	v3vumUc1ylCunF56aKf5s/c6u6S3/RU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-kOBlmHpOO4GhEq2yKCTT9w-1; Tue,
 04 Mar 2025 08:10:53 -0500
X-MC-Unique: kOBlmHpOO4GhEq2yKCTT9w-1
X-Mimecast-MFC-AGG-ID: kOBlmHpOO4GhEq2yKCTT9w_1741093852
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57C1D19540F3;
	Tue,  4 Mar 2025 13:10:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A5F9E180087B;
	Tue,  4 Mar 2025 13:10:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 14:10:22 +0100 (CET)
Date: Tue, 4 Mar 2025 14:10:18 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 05/15] pidfs: record exit code and cgroupid at exit
Message-ID: <20250304131017.GB26141@redhat.com>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I will read this series later, but I see nothing wrong after a quick glance.

Minor nit below...

On 03/04, Christian Brauner wrote:
>
> Record the exit code and cgroupid in do_exit()
                                    ^^^^^^^^^^^^
this is no longer true. In release_task().

> @@ -254,6 +255,7 @@ void release_task(struct task_struct *p)
>  	write_lock_irq(&tasklist_lock);
>  	ptrace_release_task(p);
>  	thread_pid = get_pid(p->thread_pid);
> +	pidfs_exit(p);
>  	__exit_signal(p);

And the next patch rightly moves pidfs_exit() up outside of tasklist.

Why not call it before write_lock_irq(&tasklist_lock) from the very
beginning?

Oleg.


