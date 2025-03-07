Return-Path: <linux-fsdevel+bounces-43443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8123A56ADF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D3A1748CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043121C19D;
	Fri,  7 Mar 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9mwjOrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6D16EB4C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359136; cv=none; b=jHlXOT3XEAbWe7hbneeBSaFC2UemIwXvUF8fXWzEx8dSDPyHmoW254m1QK/Fc5xo9psvkdCJH8cMfqzn2Eea4DO9pxS9Uhzkb8N+DdDceVLADpHvW8JpebPP++t5s1Lr6jmvI/xWR4cK86+isEzDahvfFNwBBjZT50tEJKgGZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359136; c=relaxed/simple;
	bh=gkim01leCLkscIEVRTyqshEj98uVAAJKqAisacjpMwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxuegScsOznttcSX3i0pPft31fG/WY2t8DIHlzeDJ9JxZ3DHTB6EGf+5UrfuzKehMV06hix63Bk54gWccMK6E0LsAhl/IR1eqO1JYJoH6KOWTKRFeN61JYEuk8fRMyvY4wEULq85aE+n2rG7m7f4zfrVBHcm4iZ9TfADqLiIDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9mwjOrD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741359134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOV1/NR0uZQx/Nlqn4EmktpOgzyfwXnxmkg+11MiUZc=;
	b=a9mwjOrDQ0qvxBuDSiAnZXxZxFp962eueObhM46BOFSDykKgOU4/gqjxsoYLvwh/Zx9qSf
	F25eZ8ME3yhA280FVSQ6H3LgyR7tCzMavJwAwS4+T5E+tiOsjgdHFF/AU5RSg2V4ZIcV7e
	tOBh7+OXZxzsgZQKXwD0RIL5guZG0Vw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-h6ldjJstNZySD3fReAmTRw-1; Fri,
 07 Mar 2025 09:52:08 -0500
X-MC-Unique: h6ldjJstNZySD3fReAmTRw-1
X-Mimecast-MFC-AGG-ID: h6ldjJstNZySD3fReAmTRw_1741359125
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAD46180AF6B;
	Fri,  7 Mar 2025 14:52:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DD2F618001E9;
	Fri,  7 Mar 2025 14:51:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 15:51:32 +0100 (CET)
Date: Fri, 7 Mar 2025 15:51:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [PATCH v2 1/4] fs/pipe: Limit the slots in pipe_resize_ring()
Message-ID: <20250307145125.GE5963@redhat.com>
References: <20250307052919.34542-1-kprateek.nayak@amd.com>
 <20250307052919.34542-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307052919.34542-2-kprateek.nayak@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/07, K Prateek Nayak wrote:
>
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1271,6 +1271,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  	struct pipe_buffer *bufs;
>  	unsigned int head, tail, mask, n;
>
> +	/* nr_slots larger than limits of pipe->{head,tail} */
> +	if (unlikely(nr_slots > (pipe_index_t)-1u))
> +		return -EINVAL;

The whole series look "obviously" good to me,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

-------------------------------------------------------------------------------
But damn ;) lets look at round_pipe_size(),

	unsigned int round_pipe_size(unsigned int size)
	{
		if (size > (1U << 31))
			return 0;

		/* Minimum pipe size, as required by POSIX */
		if (size < PAGE_SIZE)
			return PAGE_SIZE;

		return roundup_pow_of_two(size);
	}

it is a bit silly to allow the maximum size == 1U << 31 in pipe_set_size()
or (more importantly) in /proc/sys/fs/pipe-max-size, and then nack nr_slots
in pipe_resize_ring().

So perhaps this check should go into round_pipe_size() ? Although I can't
suggest a simple/clear check without unnecesary restrictions for the case
when pipe_index_t is u16.

pipe_resize_ring() has another caller, watch_queue_set_size(), but it has
its own hard limits...

Oleg.


