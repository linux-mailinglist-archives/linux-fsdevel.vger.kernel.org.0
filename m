Return-Path: <linux-fsdevel+bounces-46248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C0A85C23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E6C3AC632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156D12980D4;
	Fri, 11 Apr 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhQbRakS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061A26FA79
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371748; cv=none; b=uDs+sdRyFPG6MpWplt/ldryO7lJsQnVg4rj+ap87Kg1Ik50vNIgtECLshgrKvq4d0PcnEQ3qVoknby8s1hiln4HIUN9FZEM/OsNNEGV1cLFsndLrsGTzxeEbPEUKdY1egD82iy7xoLvBQOVlUKPrum/4wr7Vm2SUwMT1C+8+BbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371748; c=relaxed/simple;
	bh=I6aUlf76Hj9oWT5IUPqlEFEXUQbl+N0fO/0i+e7uNSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLXs5d6wW9GXc14tC6qDPZD6HOazTjLPhXvECw4AFyw7HZ+QFodboUrzdWUDKOgrKaKiNiax53k+uzaAtGBV6sX3H0N6f/WXrRc8vS1nbuG4zqWvZA8u9JEqJE2ASLChICNduQmJuYrqhPH4T0KY3aFtxpFTZpj3Bc/8jDFpSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhQbRakS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744371745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQvxCPteal/twSkIPQWB0ZTQdjoa0MyFaK2SpsJtBd4=;
	b=bhQbRakS0ghGBVdNFDGh/h+FCU89t6VKEQyGRrMyCjd0pSHL8oQ+dfi8ErFfHT1mdJkcjn
	QRTAU19VogSVQswfLrrZtyynCH8FUG7FmBtsYOKO1Xp3MiD36njkqWQ+y/eD6036aUODES
	cYYSnAAZm3py7kbBa18OlUVFvdkUrkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-PrPHMUzqPKihBeJxiBIG4g-1; Fri,
 11 Apr 2025 07:42:20 -0400
X-MC-Unique: PrPHMUzqPKihBeJxiBIG4g-1
X-Mimecast-MFC-AGG-ID: PrPHMUzqPKihBeJxiBIG4g_1744371739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EDBD1800361;
	Fri, 11 Apr 2025 11:42:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.222])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 50B251808882;
	Fri, 11 Apr 2025 11:42:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Apr 2025 13:41:42 +0200 (CEST)
Date: Fri, 11 Apr 2025 13:41:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250411114137.GD5322@redhat.com>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
 <20250410101801.GA15280@redhat.com>
 <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
 <20250410131008.GB15280@redhat.com>
 <20250410-inklusive-kehren-e817ba060a34@brauner>
 <20250410-akademie-skaten-75bd4686ad6b@brauner>
 <20250411-tagwerk-server-313ff9395188@brauner>
 <20250411112532.GC5322@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411112532.GC5322@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/11, Oleg Nesterov wrote:
>
> On 04/11, Christian Brauner wrote:
> >
> > > Looking close at this. Why is:
> > >
> > >         if (type == PIDTYPE_PID) {
> > >                 WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
> > >                 wake_up_all(&pid->wait_pidfd);
> > >         }
> > >
> > > located in __change_pid()? The only valid call to __change_pid() with a NULL
> > > argument and PIDTYPE_PID is from __unhash_process(), no?
> >
> > We used to perform free_pid() directly from __change_pid() so prior to
> > v6.15 changes it wasn't possible.
>
> Yes, exactly ;)

To clarify, it was actually possible because the caller, release_task(),
does

	thread_pid = get_pid(p->thread_pid);

before __exit_signal() and detach_pid(PIDTYPE_PID) uses the same
task_struct->thread_pid. But I didn't want to rely on this fact.

And it seems we can do another cleanup... We can kill the no longer
needed get_pid/put_pid in release_task(). I'll send the patch.

> > Now that we free the pids separately let's
> > just move the notification into __unhash_process(). I have a patch ready
> > for this.
>
> Agreed,
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>


