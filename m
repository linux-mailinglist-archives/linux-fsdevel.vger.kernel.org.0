Return-Path: <linux-fsdevel+bounces-38466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB4A02F6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2401882C14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719721DF754;
	Mon,  6 Jan 2025 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crn3FYry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5451DF252
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186644; cv=none; b=O2QMaCEm6/4pvynZYxxgad3/k2FsWk6mImxM2I/tTtKKE6ljICIO2+8tT0leYyHLjr84turRF95WxN7TFgq9r60yVc4rRgN8plYSH68CYYqT38NZnesRnaM13+Y+HwuKJuikSVbmhJlEkHHGbQuHn6gMfSCukDt57H29k0FMKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186644; c=relaxed/simple;
	bh=6UyIiv1Dw4fgKeT+R0JQZWnxh/MGDXA/pRrNEJtW8so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPLCoLE97MV2guVini5DMrb1DEx+Q9u66k/RhteJgbHiPF2lj1FXv2kHETmrv7SsbsvOxjGlh8pZvmKq9UHZfyWIKcEm9lkSr3CvmlM0mhVK7fNpOzRReYNyLAOp80DJwnYRdSoimrzXigFrQxtQ8RpmIvkQCg3NDdGPM3bFCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crn3FYry; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736186642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AL9NesS086lBbDA2YUWQ7QfK7ZZ4IXXgIvT1iXWO99A=;
	b=Crn3FYryOXZtDSXPnRdb75h+0UQqCpxO2Xrn0GjXRLFGa2APuCTFRGRyNIJ/UauRbP8zcc
	IZWYlfadghoKwNHInMpgRV66weqXzvlWW7W5wUIBMU3zR8eYOGLKhEa8JZuiOiXJm8wVXI
	Tw22bjop/wbSBqgxyil1xouVkshwMqE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-AFY-qNluPcONVozdYe5iBA-1; Mon,
 06 Jan 2025 13:03:57 -0500
X-MC-Unique: AFY-qNluPcONVozdYe5iBA-1
X-Mimecast-MFC-AGG-ID: AFY-qNluPcONVozdYe5iBA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BE9F1956053;
	Mon,  6 Jan 2025 18:03:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 67EA9195605F;
	Mon,  6 Jan 2025 18:03:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jan 2025 19:03:30 +0100 (CET)
Date: Mon, 6 Jan 2025 19:03:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
Message-ID: <20250106180325.GF7233@redhat.com>
References: <20241229135737.GA3293@redhat.com>
 <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com>
 <20250106163038.GE7233@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106163038.GE7233@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/06, Oleg Nesterov wrote:
>
> To be honest, I don't understand the wait_address check in poll_wait(),
> it seems that wait_address is never NULL.

Yes,

	$ git grep -E '\bpoll_wait\('  | perl -wne '/\(.*?,\s*\&/ or print'

doesn't find anything "interesting". I think the wait_address check
should die, it only adds the unnecessary confusion.

Oleg.


