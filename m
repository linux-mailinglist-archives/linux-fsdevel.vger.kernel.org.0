Return-Path: <linux-fsdevel+bounces-46365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F1A88022
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58A61896557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB829DB7D;
	Mon, 14 Apr 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbZorzUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B228F948
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632767; cv=none; b=al5rGcdaXuRVR95sCGYatb2+C/coG0Gqs219Wdxvr3h73R3/K+fpE/gCS0PwEErMCG1KpGEkpH4f6AKKYNGIWvRj35YlGuLGVZ3d9N2eGWmfQIbUtUI46MsvZa6TJJoJuTeSA/ZYJJPW48QXQ+U6L1CV1ShmW5uC4jKhp7qriag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632767; c=relaxed/simple;
	bh=1S+ITQydYbgE+uA/RIk7xnL9LLWkvENVbfnlHt0wCsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND+3aHAhmb+rckwA0avnRRaUwfNQXgjU2/iR53c14Y1l2Wi1KD9qKjxbqWw8hSYk/7zTIrlXfbwnTCMv5zKET+VUiCWVaNocuGcnqwuGVTW/oG27VcC8opLsV3S6r26TxbMiOucYdfTl203XfBZOvlJmxEYlOzgT5+Tfbu3TVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbZorzUo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744632764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xE6hbqCqCOzEbv4rU1vZXMJioz7aWAmnIdx1bIH/tng=;
	b=LbZorzUoxfIbvugdyr0mpKKVEai+8B1D2eVVkeEi9hlosCJKB8xFRSYr5WJrHdfrAvCQku
	ig3CzcxOo3NXKwAuJAutHgCFvsX8HJy0yGTiJ5tGI/IIVSwzwL0ynxq6sN1tKu0ezYL4uq
	WnJtrdSW1OM9m73l+U6D4vuKeKZgG4E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-NNlnUyEPPz-pBzCRNTXsmQ-1; Mon,
 14 Apr 2025 08:12:38 -0400
X-MC-Unique: NNlnUyEPPz-pBzCRNTXsmQ-1
X-Mimecast-MFC-AGG-ID: NNlnUyEPPz-pBzCRNTXsmQ_1744632757
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3CCD195608B;
	Mon, 14 Apr 2025 12:12:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.114])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3DE761956094;
	Mon, 14 Apr 2025 12:12:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Apr 2025 14:12:00 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:11:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] coredump: fix error handling for replace_fd()
Message-ID: <20250414121156.GA28345@redhat.com>
References: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
 <20250414-work-coredump-v1-2-6caebc807ff4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-work-coredump-v1-2-6caebc807ff4@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 04/14, Christian Brauner wrote:
>
> The replace_fd() helper returns the file descriptor number on success
> and a negative error code on failure. The current error handling in
> umh_pipe_setup() only works because the file descriptor that is replaced
> is zero but that's pretty volatile. Explicitly check for a negative
> error code.

...

> @@ -515,6 +517,9 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
>  
>  	err = replace_fd(0, files[0], 0);
>  	fput(files[0]);
> +	if (err < 0)
> +		return err;
> +
>  	/* and disallow core files too */
>  	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};

The patch looks trivial and correct, but if we do not want to rely on
the fact that replace_fd(fd => 0) return 0 on sucess, then this patch
should also do

	-	return err;
	+	return 0;

?

otherwise this cleanup looks "incomplete" to me.

Oleg.


