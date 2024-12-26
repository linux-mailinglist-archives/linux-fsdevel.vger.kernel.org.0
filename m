Return-Path: <linux-fsdevel+bounces-38146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64019FCDBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 21:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA6E1883263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711018A6AE;
	Thu, 26 Dec 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoMORyE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F8187554
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735246702; cv=none; b=fnmnTrm6zxA1Fg3YJGcRW3TxY337mlKa0zExOHJgIleiy/xEcIEbLsKmH074nxaSfmjVo6YUSowwADoWT2umCa/gJjlDQJAMR15kKH2QpwNhrt0BkL060xxZT4JP17QC3FxIEXdJVG1TULk98nvEJY/hEnl2YJ9ljP+GbyeARc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735246702; c=relaxed/simple;
	bh=+8bHYR8jE3pc/Axrw5lXgubHz/Toj2/WxIhtILvpMY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8hMXxeOQ+mskSI5VpbxRjVO0n243y+ReghzrAQymXSiKv7SVZxL+hHqaKM2FnrjDCdrr/+CxAgdPIZw8InVSuOGk1hb+ilNw7uzRTQEXsqci6GB8wVd61NIsQp45ZJtbxMDTYT78Pvp0DUppAGynbIWtjaSQZxn5YbiPoeoACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoMORyE7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735246700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8bHYR8jE3pc/Axrw5lXgubHz/Toj2/WxIhtILvpMY8=;
	b=ZoMORyE7lznADd1dgoc/GGVm+hHBWpaQrhFfLDwVxw8+UPjHkFN/18kjJ+YNVptlMqpOAM
	QCEilvok1ZahSrgK+dypQqtZ0d+CVF5BReISrRp681DjCuYKb/zZPH/IgWEjFBFfKhkMSz
	Ncs+7evkj4LlFOvalXWXDawbexLDHrw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-dCiV5SMMPymuIa-n2CPDNA-1; Thu,
 26 Dec 2024 15:58:16 -0500
X-MC-Unique: dCiV5SMMPymuIa-n2CPDNA-1
X-Mimecast-MFC-AGG-ID: dCiV5SMMPymuIa-n2CPDNA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE860195609F;
	Thu, 26 Dec 2024 20:58:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8C94019560AA;
	Thu, 26 Dec 2024 20:58:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 26 Dec 2024 21:57:50 +0100 (CET)
Date: Thu, 26 Dec 2024 21:57:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241226205746.GC11118@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <CAHk-=whRnW3e3g5PkEtH6geVVYZO2MPUH4ZV5a=khePC9evY4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whRnW3e3g5PkEtH6geVVYZO2MPUH4ZV5a=khePC9evY4g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/26, Linus Torvalds wrote:
>
> [ Ugh, removed the crazy cc list with tons of old addresses ]

thanks.

> So the optimization may be valid

I don't think so, see my initial reply.

unlike wait_event(), __pollwait() + the head/tail checks in pipe_poll()
doesn't have the necessary barriers (at least in theory) afaics. Between
add_wait_queue()->list_add() and LOAD(head/tail).

> (the config option definitely is
> not), but I think it needs to be explained much better.
>
> I end up being very nervous about this code because we've had bugs in
> this area, exactly because people optimize this code for the unixbench
> pipe benchmark.

Agreed!

Oleg.


