Return-Path: <linux-fsdevel+bounces-46391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E10A8863C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA16C19065C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41456297A45;
	Mon, 14 Apr 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/6Kzk44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF22973B1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640936; cv=none; b=UTzSyR7carGY/MoN2qBlViN4RXw7zlxz6DSYRnKpM9wvnvkrhMsTFvQQ3iKD4gPRJHYfIedXYMO+5Taqqq4hpdcjNpeynaipw3rLa4FBOffQoJ9IjdU0winX5n4z6KLcff0NDFojMFOxhhpmAknwFjy1fje9BSqAsZ13jdWdFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640936; c=relaxed/simple;
	bh=blv48R6B7vWiz0UYLJWcs3h270DPa8dk2P5WDUKDcFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cae61gvxmXjAUdmdTHnXTnis+byBnu4zZx0AvBHX/HmQpCGyT11wgp3NM2JsFlUMSG1URMJjuDVj1dbQfT/zkJEe1dZ8TfJg/1OlFwWVsaEWAXH1koDEqB/R323HKJsNBI0leISgZdzRyDusraBkjTvCXUOBp/cnTp34HijuNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/6Kzk44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744640933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmzL+6oHQI4eVdsu/YCAC9ojI8tmHQUBWtrcimZovNI=;
	b=B/6Kzk44jSqwZaoJUhSVFGsasg0N+cPeCDH34BE9sbBOxzwITtUSKKYjjETpFbHmwl2f+f
	Krhu7p4T89R6SN4kzOuSBk8/RAqjnSZyafLAN08WQ5DxCiwAlV94KUW5ZiyEdQsDvSYAkH
	TwtAPiMlh3368X1x2ZVQ9pHf0zu5zO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-lWgCaTSoPH-42IKj5yl_QQ-1; Mon,
 14 Apr 2025 10:28:49 -0400
X-MC-Unique: lWgCaTSoPH-42IKj5yl_QQ-1
X-Mimecast-MFC-AGG-ID: lWgCaTSoPH-42IKj5yl_QQ_1744640928
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5C8180025A;
	Mon, 14 Apr 2025 14:28:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B24CB195DF86;
	Mon, 14 Apr 2025 14:28:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Apr 2025 16:28:12 +0200 (CEST)
Date: Mon, 14 Apr 2025 16:28:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250414142807.GF28345@redhat.com>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
 <20250414141450.GE28345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414141450.GE28345@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/14, Oleg Nesterov wrote:
>
> On 04/14, Christian Brauner wrote:
> >
> > -static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> > +static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
> >  {
> >  	struct file *files[2];
> >  	struct coredump_params *cp = (struct coredump_params *)info->data;
> >  	int err;
> >
> > +	if (cp->pid) {
> > +		struct file *pidfs_file __free(fput) = NULL;
> > +
> > +		pidfs_file = pidfs_alloc_file(cp->pid, 0);
> > +		if (IS_ERR(pidfs_file))
> > +			return PTR_ERR(pidfs_file);
> > +
> > +		/*
> > +		 * Usermode helpers are childen of either
> > +		 * system_unbound_wq or of kthreadd. So we know that
> > +		 * we're starting off with a clean file descriptor
> > +		 * table. So we should always be able to use
> > +		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
> > +		 */
> > +		VFS_WARN_ON_ONCE((pidfs_file = fget_raw(COREDUMP_PIDFD_NUMBER)) != NULL);
> > +
> > +		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
> > +		if (err < 0)
> > +			return err;
>
> Yes, but if replace_fd() succeeds we need to nullify pidfs_file
> to avoid fput from __free(fput) ?

Aah, please ignore me ;) replace_fd/do_dup2 does get_file() .

For this series:

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


