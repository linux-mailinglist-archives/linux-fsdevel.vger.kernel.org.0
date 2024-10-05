Return-Path: <linux-fsdevel+bounces-31056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9199167D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 13:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376A61F2303B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA2A14D2BB;
	Sat,  5 Oct 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5AYUQjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46914C5AA
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127797; cv=none; b=pUQzMRxGTTJj4TgL5DsAlH+q+dP01BCmJCRPUmMny0ibKNHXRyQ0C+QzfnLif/8XH0cogyh8HlS393TBWtOb1haPh1WW/fmhDkJ4TSLEJfvvlXC/a7LI3rG4dA9AUvHnvxibCsYfx1veKJj/gbAjjDc1kVPizhh3ZsxGhncbnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127797; c=relaxed/simple;
	bh=H3gJOBEhKV3hH0xXZ0LSqXKayhs6Juf9evTT1CuS0TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRRceYkcbOu/Kwhu2wLpnyjB9cSESJDWxiX+Rfroq7oz2Cf7pHYOka7wC3WGly1BO2kVo8tBQS8vJdeJasSagX+j1W0gS56AqaSPYQ9bp4hXMI39TfvZ5bOfHh4rMdgGirQYVSD6T/yAJaDaOhJg08qksNzl0YM/u6wPjjHTYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5AYUQjr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728127794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHETXvLrrh4dL5doL/kbVtAAMHPfV8QYEzlH6ARMCNA=;
	b=B5AYUQjrjWOKRHmwqzPwKBHPdiOIysN0pkCc3yb3ssPILRDW9B+Ke8qZ4NxToxWz1arpVd
	42D8hxDnSQWoGwr1r2QrtethrkoaTVE3G68ooUKvQ0hS61lYvVBdlaeW78/TO6R2rCnJcX
	P8f1qb6pi0MXdS1e/c4vLtu2wwGaTiA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-wKFeT59nPXOrT7M57q9Czg-1; Sat,
 05 Oct 2024 07:29:49 -0400
X-MC-Unique: wKFeT59nPXOrT7M57q9Czg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B9A1954AE4;
	Sat,  5 Oct 2024 11:29:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2E82B3000198;
	Sat,  5 Oct 2024 11:29:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  5 Oct 2024 13:29:33 +0200 (CEST)
Date: Sat, 5 Oct 2024 13:29:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Message-ID: <20241005112929.GA24386@redhat.com>
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <20241004-signal-erfolg-c76d6fdeee1c@brauner>
 <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
 <20241004192958.GA28441@redhat.com>
 <CAMw=ZnRp5N6tU=4T5VTbk-jx58fFUM=1YdkWc2MsmrDqkO2BZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRp5N6tU=4T5VTbk-jx58fFUM=1YdkWc2MsmrDqkO2BZA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/04, Luca Boccassi wrote:
>
> On Fri, 4 Oct 2024 at 20:30, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I guess Christian meant you should simply use
> >
> >                 info.pid = task_pid_vnr(task);
> >
> > task_pid_vnr(task) returns the task's pid in the caller's namespace.
>
> Ah I see, I didn't realize there was a difference, sent v3 with the
> suggested change just now, thanks.

I didn't get v3, I guess I wasn't cc'ed again.

So, just in case, let me add that task_pid_vnr(task) can return 0 if
this task exits after get_pid_task().

Perhaps this is fine, I do not know. But perhaps you should actually
use pid_vnr(pid).

Oleg.


