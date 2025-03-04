Return-Path: <linux-fsdevel+bounces-43098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB3FA4DE74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D621892847
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C8202C3A;
	Tue,  4 Mar 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS8c3kdl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F800202974
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092912; cv=none; b=qoMp6AV5Vj0OCTRaQNvc4ImDDBRG6N9tZsUQlTTc43iUXt+VsmEPX3WrgUQF+NNPtINFEAkqnjeGqH+/TtWPwlnLdxtN5+XnokJ+Ty2LIn1sJNBqnV/rLUIfOeIz+UKr5TmdzPMohzhdMhYsEHj0e3QTRoOJW4Zt8Hh4T7Rrg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092912; c=relaxed/simple;
	bh=DiEVCMAGpueHuWnJu6E8MC5GPgN6xjv+sQKeXs/FkJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDJ5rVMY9i3yYWaRxh9VM8nKK+uNRYqzqkSco77fDRttahdKAEol2VXln4O0QnYgx5s98j7Kjy+FLNuwBfvlXHE3m65bxaekEe3AsOcONMSxNbP480H3JxN6oXXl34TeLH3Vqi+aoheBV8XGheF0oMkRNgSBa/is1gbrFoo7BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gS8c3kdl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741092909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fH9J4ARJLyt28l+yIiFu9Mp4M2zRb+mAnPPqf6DryPU=;
	b=gS8c3kdlOvHAI165cZ84f8KCXkat4zlT8Gj74NS7/ia3xm2ecySc7t75qAY7QbRBnztJgV
	MnN9vdrlJqV31aOFobYIcJlHOy/YYf8j+YtCrP5VJFKj3j8Y9lLeRjX05RH2fi9rjtC4b9
	08mJ3BzHdiI7KbFzlFEWrnatqq6FKBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-ltJdboBeP6W1-e8tqC9VfA-1; Tue,
 04 Mar 2025 07:54:55 -0500
X-MC-Unique: ltJdboBeP6W1-e8tqC9VfA-1
X-Mimecast-MFC-AGG-ID: ltJdboBeP6W1-e8tqC9VfA_1741092894
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7B061801A13;
	Tue,  4 Mar 2025 12:54:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2140F3000197;
	Tue,  4 Mar 2025 12:54:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 13:54:23 +0100 (CET)
Date: Tue, 4 Mar 2025 13:54:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250304125416.GA26141@redhat.com>
References: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com>
 <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/03, Linus Torvalds wrote:
>
> ENTIRELY UNTESTED, but it seems to generate ok code. It might even
> generate better code than what we have now.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

but I have another question...

>  static inline bool pipe_readable(const struct pipe_inode_info *pipe)
>  {
> -	unsigned int head = READ_ONCE(pipe->head);
> -	unsigned int tail = READ_ONCE(pipe->tail);
> +	union pipe_index idx = { READ_ONCE(pipe->head_tail) };

I thought this is wrong, but then I noticed that in your version
->head_tail is the 1st member in this union.

Still perhaps

	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };

will look more clear?

> +/*
> + * Really only alpha needs 32-bit fields, but
> + * might as well do it for 64-bit architectures
> + * since that's what we've historically done,
> + * and it makes 'head_tail' always be a simple
> + * 'unsigned long'.
> + */
> +#ifdef CONFIG_64BIT
> +  typedef unsigned int pipe_index_t;
> +#else
> +  typedef unsigned short pipe_index_t;
> +#endif

I am just curious, why we can't use "unsigned short" unconditionally
and avoid #ifdef ?

Is "unsigned int" more efficient on 64-bit?

Oleg.


