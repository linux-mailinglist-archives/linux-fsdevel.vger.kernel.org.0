Return-Path: <linux-fsdevel+bounces-43419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B0EA566C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD816EF79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30F2185B4;
	Fri,  7 Mar 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aD3N96Vs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9C21771E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347007; cv=none; b=s12u6yRngUCdk3gC82HB5trZZTNxR6+qrvwZB0QwfWTO5ECEmWmVmHoKXbfCSKKpVLwgHjXSGlfiYlS2vJlbls9nhI9S/ckkV8r3+65DPl7a/1ggQr4EMH1utKrnSTzBo7UpzXabclu2277lP52AksDgK4PiZ6RR0wLvgWyohJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347007; c=relaxed/simple;
	bh=3xFqsfmNyph+Xl2XdVJUArNLkdZCz7c3+dVcIqg96Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcbf6Px8r6a7+YnhZJ/FTDRoKr0LNWHZtvplVinC/+eBhdLASnp0kFphRNGlrqBFFgBZugxEmYtg1AYsW1VJ0OaAQPfUIM+cwS6SsBe6Dnqf5eOk3aWXdhqQtcJ+KyiWM0unjiSmEkWDr+0AB1K6iCMYMqahcReXo90wqLDlHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aD3N96Vs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741347004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojp02tMMlaCOgsrJPucLz0Hwm5Y00WT/jYhUO+/vuWg=;
	b=aD3N96VsvAc6Fb+nKafuAtI3gAJY0nuU648ef6HCCsWF8vBcmDxyG4ffezbREp8b4th/uG
	4SwMiBF3qtIAGP+RXH3nt6AFHkGDFoNXPBFVt7HnzogJOPXQeXhOumVzK9aBAh6BZ9r7nn
	R4c/8EAWMjWHMeLksPVLc7AEZIciNVA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-zEl5gvgUMmq14HrDIZkdEg-1; Fri,
 07 Mar 2025 06:29:58 -0500
X-MC-Unique: zEl5gvgUMmq14HrDIZkdEg-1
X-Mimecast-MFC-AGG-ID: zEl5gvgUMmq14HrDIZkdEg_1741346997
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0328E19560AB;
	Fri,  7 Mar 2025 11:29:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BA49B1801751;
	Fri,  7 Mar 2025 11:29:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 12:29:26 +0100 (CET)
Date: Fri, 7 Mar 2025 12:29:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250307112920.GB5963@redhat.com>
References: <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307104654.3100-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/07, Hillf Danton wrote:
>
> On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> >> step-03
> >> 	task-118766 new reader
> >> 	makes pipe empty
> >
> >Reader seeing a pipe full should wake up a writer allowing 118768 to
> >wakeup again and fill the pipe. Am I missing something?
> >
> Good catch, but that wakeup was cut off [2,3]
>
> [2] https://lore.kernel.org/lkml/20250304123457.GA25281@redhat.com/
> [3] https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/

Why do you think

	[PATCH v2 1/1] pipe: change pipe_write() to never add a zero-sized buffer
	https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/

can make any difference ???

Where do you think a zero-sized buffer with ->len == 0 can come from?

Oleg.


