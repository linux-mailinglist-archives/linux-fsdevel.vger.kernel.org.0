Return-Path: <linux-fsdevel+bounces-30498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C298BD03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF92281DBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D91BFDE8;
	Tue,  1 Oct 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAB01wfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C7637
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787789; cv=none; b=ZH8rLGUYB5MmFLq8fXBioeEjaL7/A536bUwkvx0WYH4l/GhOAveRl9EG1poVcfJzuHxBVgQia/LM0umy6I/9Jtqa9SrFtg7UXfMP82OWKqjCen0t6LnhyV4PvDxYZtHIP0ElSSk3Yo9rkiX5EEhu1twX3i45SRoXTjarXQ53jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787789; c=relaxed/simple;
	bh=2Tif58ZXz2Z08oWuKc1J6B61tFcO39UIPyUxCirEyDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC+EEXv2Ab2vMrbPovtLIlHvpMB57e4QCEPoDCHWNax3MbqQpA+hBvoeZViGs87JNQhQzgoMd6/pFRN8OpL2KNY9/TcS6ElRQJCJInjybEnC7XgHS2cRftKG8isoJi68jEHCYg0Wi+yCOM00m9JnQbFKUjiCybNP6R99+3zsqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAB01wfr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727787787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLog/XPLvy9nJRGchSA6Jwy6NGYIeN4k4C/NJZ7JJrc=;
	b=RAB01wfrB5RFag95ueM0QAoyjxi1u6RhiPvVoWn/7DTWhrDknV2aekeUk1Odur4L3XlcG/
	p1rzBItIuVHsYqi07M5MfECtUfdZ0z42cUdj5mN19mlp1zWfX1RMbAJDQwFEyp0PrKfTNW
	4RVwGlppXwBqWc0KeQCGR56hXrVF8YA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-Akci6jl4MwK6SMVNbl3tuw-1; Tue,
 01 Oct 2024 09:03:02 -0400
X-MC-Unique: Akci6jl4MwK6SMVNbl3tuw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F0BE1955DD7;
	Tue,  1 Oct 2024 13:02:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7506D3003DEC;
	Tue,  1 Oct 2024 13:02:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 15:02:45 +0200 (CEST)
Date: Tue, 1 Oct 2024 15:02:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Florent Revest <revest@chromium.org>, Kees Cook <kees@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Benjamin Gray <bgray@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3] add group restriction bitmap
Message-ID: <20241001130236.GB23907@redhat.com>
References: <20240930195958.389922-1-stsp2@yandex.ru>
 <20241001111516.GA23907@redhat.com>
 <02ae38f6-698c-496f-9e96-1376ef9f1332@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02ae38f6-698c-496f-9e96-1376ef9f1332@yandex.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/01, stsp wrote:
>
> 01.10.2024 14:15, Oleg Nesterov пишет:
> >Suppose we change groups_search()
> >
> >	--- a/kernel/groups.c
> >	+++ b/kernel/groups.c
> >	@@ -104,8 +104,11 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
> >				left = mid + 1;
> >			else if (gid_lt(grp, group_info->gid[mid]))
> >				right = mid;
> >	-		else
> >	-			return 1;
> >	+		else {
> >	+			bool r = mid < BITS_PER_LONG &&
> >	+				 test_bit(mid, &group_info->restrict_bitmap);
> >	+			return r ? -1 : 1;
> >	+		}
> >		}
> >		return 0;
> >	 }
> >
> >so that it returns, say, -1 if the found grp is restricted.
> >
> >Then everything else can be greatly simplified, afaics...
> This will mean updating all callers
> of groups_search(), in_group_p(),
> in_egroup_p(), vfsxx_in_group_p()

Why? I think with this change you do not need to touch in_group_p/etc at all.

> if in_group_p() returns -1 for not found
> and 0 for gid,

With the the change above in_group_p() returns 0 if not found, !0 otherwise.
It returns -1 if grp != cred->fsgid and the found grp is restricted.

So acl_permission_check() can simply do

	if (mask & (mode ^ (mode >> 3))) {
		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
		int xxx = vfsgid_in_group_p(vfsgid);

		if (xxx) {
			if (mask & ~(mode >> 3))
				return -EACCES;
			if (xxx > 0)
				return 0;
			/* If we hit restrict_bitmap, then check Others. */
		}
	}

> So unless I am missing your intention,
> this isn't really helping.

OK, please forget, perhaps I missed something.

Oleg.


