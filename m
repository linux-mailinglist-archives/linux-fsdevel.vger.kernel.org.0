Return-Path: <linux-fsdevel+bounces-38476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA11A030B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 20:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768247A1180
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA421E0DE3;
	Mon,  6 Jan 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWTIU7LM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB51E0496
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192054; cv=none; b=lem4kuwjs3RqNy/KPVHfmP6zMWdMIsABrq4kFQaaX2dlj9MOlCQdB5ZYuZgFxKtKe0kIJFV0a+fCaVbhrEO762fGKaYINnUSZ60qZ3o5ZZCPXy9TviIDCRh64GtQlqBgD13+6nqZ1EO0OGLpCEzKIGGUe8lziPZtXGmWy2wqPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192054; c=relaxed/simple;
	bh=GB3sXo3jAtM81w79ykpn4c5FBCPRD/E0J0LJOVeLMes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCBiT83ziLTmnNO0abHH1OFkYnmTK0gzg56JjMTAcMXZJ6Li4SG/NS/1ZsDfYFTwWfItWZP/lJXCVnE1DJHMYTWnE5qtMc/A1HDjzy91q6VRNpV64HZTIJyZ171FsjKBeU61j1J7643G6JQIa0A6OUj0030SJAnu/7zha4Gfc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWTIU7LM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736192051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPwn/8SQnPxOYFh1+f07h1WSOgnvETMG9MM+HTA/pYY=;
	b=YWTIU7LM7aDc/dCmXhFABHMmCIC9xyq+DgJk0sWFi9M0ewbFa7WpyQ6JAJkYbT/ArJPaWV
	UEUglSa8bX39UcPa3zABTRjpbAFzzJvp81QkcTilAHMvnfzIyAIcHHdT8Ve+b2qqNs1rIY
	eV7/SdrAeJZAP7kA7+NwaIuH4tB26Q8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-1S819-6uM7CS8FErvQe9vw-1; Mon,
 06 Jan 2025 14:34:08 -0500
X-MC-Unique: 1S819-6uM7CS8FErvQe9vw-1
X-Mimecast-MFC-AGG-ID: 1S819-6uM7CS8FErvQe9vw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 197761955F42;
	Mon,  6 Jan 2025 19:34:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 64F8B1956053;
	Mon,  6 Jan 2025 19:34:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jan 2025 20:33:40 +0100 (CET)
Date: Mon, 6 Jan 2025 20:33:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
Message-ID: <20250106193336.GH7233@redhat.com>
References: <20241229135737.GA3293@redhat.com>
 <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
 <20250106163038.GE7233@redhat.com>
 <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
 <20250106183646.GG7233@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106183646.GG7233@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Damn ;)

It is amazing how much unnecessary spam I added to these discussions.
But let me ask 2 more questions, hopefully no more.

1. pipe_read() says

	 * But when we do wake up writers, we do so using a sync wakeup
	 * (WF_SYNC), because we want them to get going and generate more
	 * data for us.

OK, WF_SYNC makes sense if pipe_read() or pipe_write() is going to do wait_event()
after wake_up(). But wake_up_interruptible_sync_poll() looks at bit misleading if
we are going to wakeup the writer or next_reader before return.

2. I can't understand this code in pipe_write()

	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
		int err = file_update_time(filp);
		if (err)
			ret = err;
		sb_end_write(file_inode(filp)->i_sb);
	}

	- it only makes sense in the "fifo" case, right? When
	  i_sb->s_magic != PIPEFS_MAGIC...

	- why should we propogate the error code if "ret > 0" but
	  file_update_time() fails?

Oleg.


