Return-Path: <linux-fsdevel+bounces-43349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8605AA54AB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941EA3A922F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB8820B7F3;
	Thu,  6 Mar 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8nXhH5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723EC1DBB03
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264139; cv=none; b=evTT+Q7M9R+HWZW1TkA1mjpHBJ4+yy9Pe0nGPSow9E5dC0h0fUI3+BrrToOLHElIAWR9l6mAW5Woawos3BoJq7xLb5MiS4FbUDTbtNvoD4/LYvsnadsT2s7T2h7NoFL+4qN7f3CXZwZyDy4I9Hk73sl4R6apuJKjAVnubQ6owL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264139; c=relaxed/simple;
	bh=lq2YrIb5jWHI4kYgySuAWdRce2aAiZNsZiwC8rAo2bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7lzmQYFtkCI3fcLqToEYj9pRa3WLFuiNndzBk5ysLPMXdWIJVt771/TJQ8fXuTBZUhM4Z/UW9LxycEACpYqWk4zA/I34MN+zJUJAPBMdMZEWxG7vqRn35wSVVt0skVhSkPLYD8in09lRYQ/eoa8X5PmNH+AQzhTCohZf0RD3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8nXhH5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741264136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0V8bEBMj4qDTw4A6gJnd9yt6K6KK+9XkOtnCntFymag=;
	b=c8nXhH5xZMvtfF7ge0RsXByMJvVAg11XkRniVUZNAYcRv1o6jPIJGo/avzzDjajm4J3lyk
	caG5Jyr8AgZ+tMwnte0dRuzOJwfq6ronANzYcQM3pqRt9os7VZgZIU7iUABSEvahRrSHnO
	AXM6sWwA3tpzhhkaa2IWeVPE1+fN7tM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-I2e09rAfMYy5CSas15muGA-1; Thu,
 06 Mar 2025 07:28:50 -0500
X-MC-Unique: I2e09rAfMYy5CSas15muGA-1
X-Mimecast-MFC-AGG-ID: I2e09rAfMYy5CSas15muGA_1741264128
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 417EF1956055;
	Thu,  6 Mar 2025 12:28:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 26037180AF7A;
	Thu,  6 Mar 2025 12:28:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 13:28:16 +0100 (CET)
Date: Thu, 6 Mar 2025 13:28:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Neeraj.Upadhyay@amd.com,
	Ananth.narayan@amd.com, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 1/3] fs/pipe: Limit the slots in pipe_resize_ring()
Message-ID: <20250306122807.GD19868@redhat.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
 <20250306113924.20004-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306113924.20004-2-kprateek.nayak@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/06, K Prateek Nayak wrote:
>
> @@ -1272,6 +1272,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  	struct pipe_buffer *bufs;
>  	unsigned int head, tail, mask, n;
>
> +	/* nr_slots larger than limits of pipe->{head,tail} */
> +	if (unlikely(nr_slots > BIT(BITS_PER_TYPE(pipe_index_t) - 1)))

Hmm, perhaps

	if (nr_slots > (pipe_index_t)-1u)

is more clear?

Oleg.


