Return-Path: <linux-fsdevel+bounces-12074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595085B025
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC81C21CC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A6DDB6;
	Tue, 20 Feb 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG2JOtRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CA7472
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390293; cv=none; b=EPSUMVQQHnkJCC8+W1e8YTNlqM+bQEn1vuIzGq9qoLOMavqprCQj9sUrpeG0e9Zs/aMpLImKzexbv2RRJxlX5zNcIvfibSpx5JeK8cmFo2MazbHmHvWMk9n5Q0twJubONsqxNPzj/Da2QU5Fs2gGVMnB/A4lh6dZ0/RsLHXVCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390293; c=relaxed/simple;
	bh=QJ/UucmQfy6TFKmkSSfPI8zK2k9mW41Ve0eZm5xuh14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVb+fwipVcRk6WugfwCbTTknfgvJtuSN+jxJJyNBFZO/hWVArrQyZgXpjJqgpHxyqje2zeKLfYVlCnWcg6O3a5i2hZ2lBwJ4NjP23JadcDGA7AxcIa8BD/qdfN+lgt6m5sXrHmWjosBH08kUPWrGErw26URAuBh0h1Z+H0HQ5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG2JOtRz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708390290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2766/Q+VAKCk7P5UAFOLvdi2ajKP6ngFDN5XcWc/bPM=;
	b=DG2JOtRz0cr51AK2xIg9LqHG/I701R7e2taqKzHgUy6qli6vwhOJ7Yz54zDqhue2gDUUOi
	fpCjXHlO2/YMLHQmGQMpHhetN3XpvGRewf7DaksFzny4fd1pv57ZWClWiHzfGmcYzMjzV2
	Fx4lK/tv83uIPE8B5zWroN+muml/EYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-t0KWA3UgPMSPW0mLLVHBog-1; Mon, 19 Feb 2024 19:51:27 -0500
X-MC-Unique: t0KWA3UgPMSPW0mLLVHBog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51470101A52A;
	Tue, 20 Feb 2024 00:51:26 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A321C060AF;
	Tue, 20 Feb 2024 00:51:26 +0000 (UTC)
Date: Mon, 19 Feb 2024 18:51:24 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH] efs: convert efs to use the new mount api
Message-ID: <ZdP3jM3GrksJ9L_1@redhat.com>
References: <20240220003318.166143-1-bodonnel@redhat.com>
 <ZdP2a9VZ_GOcABY6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdP2a9VZ_GOcABY6@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Tue, Feb 20, 2024 at 12:46:35AM +0000, Matthew Wilcox wrote:
> On Mon, Feb 19, 2024 at 06:33:18PM -0600, Bill O'Donnell wrote:
> > Convert the efs filesystem to use the new mount API.
> 
> Hey Bill, what testing were you able to do for this?  I found some EFS
> images, but they didn't have any symlinks in them, so I wasn't able to
> test my rewrite of the symlink handling code.  Do you have a source of
> EFS images?
> 
Hi Matthew-
I only checked if it mounts and remounts. Since no mount options, my testing
was minimal.
Thanks-
Bill


