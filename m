Return-Path: <linux-fsdevel+bounces-46367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A71A880CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956BC16907E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015B2BD5A0;
	Mon, 14 Apr 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfixvZG7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E719E967
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634972; cv=none; b=HNcjsMBAXywJ/V+NfBEoVeT0XDXYpO/aRZDoIEHIFwWV5Gcu3mHftHch2J1TUvTxc8KGGwYpolZRqMZh7BkopHebNaK2QZfOvoSHzFNl7m7s3DFiQZ6sYZFSVt1dNFkGqCbEwzuFB34OmUZk+Jht0b8DSyMfqvsuxVdAe88utZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634972; c=relaxed/simple;
	bh=lgSt8x0de9kAYoaRC+cxwWGGxm6vAlCqN5KNKarOOSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKgyEvo8FbLlCHn0Q5O+P9NxakblgnZBiSNR83fcY5sPLLsBdKmmORvgXGGNTRyKYlBcip0+Y6fAIij5z1WbBA8B/yoKsvtWqkz1wKj3li4CIGR5Sr5FRhkcfhJiaJ8ommvZvv/grFAUAXHbxKNXPCbxcmP3I90YzhT4KAhLA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfixvZG7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744634969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBOfitIJJpSh+LYLLT3w+jaL/RZlHujMls6QbDA3nQo=;
	b=AfixvZG77rFP9rYNUqYIzYhKjGCSqset8HLOMShKcZ0Mk//DHyfZaueX3O1CdHKpRDad7h
	H4uC/fIFU8eVoBxBZ74Lv6Gimm+IVPwstPD7RQSQxU72CtJ5WHdwX+VPQDB0v2TEzZEmGt
	qEwmtIXJ1uGeb/ZZOOXtptM98f+/yqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-EoyECqEzNdKkKp0aUGfaGw-1; Mon,
 14 Apr 2025 08:49:26 -0400
X-MC-Unique: EoyECqEzNdKkKp0aUGfaGw-1
X-Mimecast-MFC-AGG-ID: EoyECqEzNdKkKp0aUGfaGw_1744634964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DAAB1809CA6;
	Mon, 14 Apr 2025 12:49:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E05C419560AD;
	Mon, 14 Apr 2025 12:49:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Apr 2025 14:48:48 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:48:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250414124843.GB28345@redhat.com>
References: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
 <20250414-work-coredump-v1-3-6caebc807ff4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-work-coredump-v1-3-6caebc807ff4@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/14, Christian Brauner wrote:
>
> +			case 'F': {
> +				struct file *pidfs_file __free(fput) = NULL;
> +
> +				/*
> +				 * Install a pidfd only makes sense if
> +				 * we actually spawn a usermode helper.
> +				 */
> +				if (!ispipe)
> +					break;
> +
> +				/*
> +				 * We already created a pidfs_file but the user
> +				 * specified F multiple times. Just print the
> +				 * number multiple times.
> +				 */
> +				if (!cprm->pidfs_file) {
> +					/*
> +					 * Create a pidfs file for the
> +					 * coredumping thread that we can
> +					 * install into the usermode helper's
> +					 * file descriptor table later.
> +					 *
> +					 * Note that we'll install a pidfd for
> +					 * the thread-group leader. We know that
> +					 * task linkage hasn't been removed yet
> +					 * and even if this @current isn't the
> +					 * actual thread-group leader we know
> +					 * that the thread-group leader cannot
> +					 * be reaped until @current has exited.
> +					 */
> +					pidfs_file = pidfs_alloc_file(task_tgid(current), 0);
> +					if (IS_ERR(pidfs_file))
> +						return PTR_ERR(pidfs_file);
> +				}
> +
> +				 /*
> +				 * Usermode helpers are childen of
> +				 * either system_unbound_wq or of
> +				 * kthreadd. So we know that we're
> +				 * starting off with a clean file
> +				 * descriptor table. Thus, we should
> +				 * always be able to use file descriptor
> +				 * number 3.
> +				 */
> +				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
> +				if (err)
> +					return err;
> +
> +				cprm->pidfs_file = no_free_ptr(pidfs_file);
> +				break;
> +			}

So the new case 'F' differs from other case's in that it doesn't do
"break" but returns the error... this is a bit inconsistent.

Note also that if you do cn_printf() before pidfs_alloc_file(), then you
can avoid __free(fput) and no_free_ptr().

But this is minor. Can't we simplify this patch?

Rather than add the new pidfs_file member into coredump_params, we can
add "struct pid *pid". format_corename() will simply do

	case 'F':
		if (ispipe) {
			// no need to do get_pid()
			cprm->pid = task_tgid(current);
			err = cn_printf(...);
		}
		break;

and umh_pipe_setup() can itself do pidfs_alloc_file(cp->pid) if it is
not NULL.

This way do_coredump() doesn't need any changes.

No?

Oleg.


