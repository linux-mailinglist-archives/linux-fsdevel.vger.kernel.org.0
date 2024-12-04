Return-Path: <linux-fsdevel+bounces-36425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9EE9E396F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9841692A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0E01B4F1F;
	Wed,  4 Dec 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK6dSZ6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1419E979
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313806; cv=none; b=ubD6MPx90yTVwMqq7GgpqMPfQRMH9hoQbajBRnDnfmaMv2E/GhX+LqshfMUBxDH9pl682YyZn27vn2oU9nPonrFLdq+mTyBJtjvi0L/dLJSBStsqskatJKtiDg8Z0YDHcYPfoIllwxp93lbjJTNwvVVsRePJbIZFMxDXr68ngwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313806; c=relaxed/simple;
	bh=4EssO4jdsWxU+on0mCUZ3Gaq4iVHe+0b3yQKawkrdKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5QrmM6ik1UQS+oTqWKLdAST+A2IwENTyfyRaickpMxPaNHig0Pw8InlQDdv6aD6LwLj4e3ZPjEfIK/6ISoOePuWeIU5CCyy5kjl5hq7GjIqoZAtO12VpJwPjUlHxiy7cMiopeEHIpqdUftK+3PHNyz5si+FjewRD8B04sK2l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IK6dSZ6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733313803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8NGLP7ez45KM9t8ebgMe+199p/GlMRQH4wzhaiHZS4=;
	b=IK6dSZ6NkUgMR+uEWhVcNkE3pMUwekd44lM1gaU75dm4pJMXKVz0zIyZPMDNRxZp0X8Hch
	h0MrpEED7XJqDR0w4lcJYvERRjpkZzncLUiDR/2wrqjPKK632PJJKYL5V8VvUSu9rWZAhK
	JLnRLG1/1ur0Q4+Le1fWGWj2WTjZZYs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-ghEn3z_cOJSN_wNSEQlHgA-1; Wed,
 04 Dec 2024 07:03:19 -0500
X-MC-Unique: ghEn3z_cOJSN_wNSEQlHgA-1
X-Mimecast-MFC-AGG-ID: ghEn3z_cOJSN_wNSEQlHgA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C13F1956087;
	Wed,  4 Dec 2024 12:03:17 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ECF23000197;
	Wed,  4 Dec 2024 12:03:14 +0000 (UTC)
Date: Wed, 4 Dec 2024 07:05:01 -0500
From: Brian Foster <bfoster@redhat.com>
To: Long Li <leo.lilong@huawei.com>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z1BFbVhqjnCt-Gk5@bfoster>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
 <Z05oJqT7983ifKqv@dread.disaster.area>
 <Z08bsQ07cilOsUKi@bfoster>
 <Z1AbeD8QVtITsvic@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1AbeD8QVtITsvic@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 04, 2024 at 05:06:00PM +0800, Long Li wrote:
> On Tue, Dec 03, 2024 at 09:54:41AM -0500, Brian Foster wrote:
> > Not sure I see how this is a serialization dependency given that
> > writeback completion also samples i_size. But no matter, it seems a
> > reasonable implementation to me to make the submission path consistent
> > in handling eof.
> > 
> > I wonder if this could just use end_pos returned from
> > iomap_writepage_handle_eof()?
> > 
> > Brian
> > 
> 
> It seems reasonable to me, but end_pos is block-size granular. We need
> to pass in a more precise byte-granular end. 

Well Ok, but _handle_eof() doesn't actually use the value itself so from
that standpoint I see no reason it couldn't at least return the
unaligned end pos. From there, it looks like we do still want the
rounded up value for the various ifs state management calls.

I can see a couple ways of doing that.. one is just align the value in
the caller and use the two variants appropriately. Since the ifs_
helpers all seem to be in byte units, another option could be to
sanitize the helpers to the appropriate start/end rounding internally.

Either of those probably warrant a separate prep patch or two rather
than being squashed in with the i_size fix, but otherwise I'm not seeing
much of a roadblock here. Am I missing something?

Brian

> 
> Thanks,
> Long Li
> 


