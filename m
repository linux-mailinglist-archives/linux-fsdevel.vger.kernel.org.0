Return-Path: <linux-fsdevel+bounces-41323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EEA2DFAA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51374164E37
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8841E0DCD;
	Sun,  9 Feb 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfesa2lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F611DEFD6
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124174; cv=none; b=ARalOHEI/b4nLdYWKB0eXKkU3E7PzxKq/oMf8fEzVz/6jQf2dAtD/0HP3teqU1K85k7dtk8RXRTfE5BUYL0yC/9KBA7Zu+SaUt+oQCvtAwCEbZ4X+iwwPWgGv3olC8vswf2xcDwgWYrB2S5cxVs0JhmQ7LvHBM8L4f2wSWL+9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124174; c=relaxed/simple;
	bh=k4dSF+1/8S8QyL/aW0J/1GcegQPTYVVhk6RVsCaWtzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIMXyrZgiOC3xE2OLF2r8XFa+VFkUdLMN63UIBEWQGrQUuj/StNa9Ea3YfJdgw7zL/9N3t8pS5IKH1SSrYnsFV04E/p0BLNW4MoQAdbq7dEMnQmIrjizkb6SDZJUlr7qSwzQTKIFRd+cc4dgSsRJ1Tbb6weFRnSdK5r+1CBGRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfesa2lm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739124171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfvTC66qId/c8WXiJdvmvVhhEh0Ssvdm8E/DMI9uyak=;
	b=gfesa2lmzlX5crxEoXwzgti3f/oU20q8N3++cU1c7HKBDquspZFlXSUoVSXumvzdprvKql
	rSXUkyn4ICLvgJ7CgEc7lPx3BdUwWx4/wM/ybTTMKM9n1LHy9naXfHmEnNcO3Cq49LHTIu
	fGwhqbJberYgDAGLWzsnBaLzKIRK/ds=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-CKAa2_oTOd6AMhSjr1fDNA-1; Sun,
 09 Feb 2025 13:02:50 -0500
X-MC-Unique: CKAa2_oTOd6AMhSjr1fDNA-1
X-Mimecast-MFC-AGG-ID: CKAa2_oTOd6AMhSjr1fDNA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B844A1800875;
	Sun,  9 Feb 2025 18:02:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 15B0B180035E;
	Sun,  9 Feb 2025 18:02:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Feb 2025 19:02:20 +0100 (CET)
Date: Sun, 9 Feb 2025 19:02:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized
 buffer
Message-ID: <20250209180214.GA23386@redhat.com>
References: <20250209150718.GA17013@redhat.com>
 <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/09, Linus Torvalds wrote:
>
> This patch seems to be the right thing to do and removes the vestiges
> of the old model.

OK, thanks.

> But I don't think you need that pipe_buf_assert_len() thing.

Well, I'd prefer to keep this WARN_ON_ONCE() for some time... If
nobody hits this warning we can kill eat_empty_buffer() and more
hopefully dead checks, for example

	/* zero-length bvecs are not supported, skip them */
	if (!this_len)
		continue;

in iter_file_splice_write().

> And if
> you do, please don't make it a pointless inline helper that only hides
> what it does.

Could you explain what do you think should I do if I keep this check?
make pipe_buf_assert_len() return void? or just replace it with
WARN_ON_ONCE(!buf->len) in its callers?

Oleg.


