Return-Path: <linux-fsdevel+bounces-50325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DBACAEA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DE617DD30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242D221FD2;
	Mon,  2 Jun 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDQOg/Ff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA7221FBB
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869753; cv=none; b=oQdWo8pXQsG8e3ocISxUK3bVXrguz02Nwizc50lstKQnwdd2veUfHCQYpdjk8KtIAkQTMgyhPN6bONF5CctBCVxmx9rQ3WCNUJ8uvk7FlB0f9MJyX6PIx0rV4s4l//vcy4kTt+dAwgLnM2Yva2W4+Xhb47Bp4w9QIK00UlUdrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869753; c=relaxed/simple;
	bh=2U/rqDTkSEhF3kVkNcn14qr3OQRG+JbH96DVpplAJUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYgGyjXOWpGaPN6DsalvWJo0S6WP6Z/UBbLaocEOQH0JfzNG9zbm7snbjnBUzf5iCUhtaPSTK/pPN8PGW3qhmH2XL4HRu1c8AOQZeANYgu4jRHQa7yEuyISyIG04eESLnXXdOIbWwIBJ1WWtO9lsPZA8wSG6+6b9aKQgr8jvCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDQOg/Ff; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748869750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2U/rqDTkSEhF3kVkNcn14qr3OQRG+JbH96DVpplAJUI=;
	b=CDQOg/FfPrAoBZSq1VuTceoHzid6zJxo6FrRlQfDh8oTMBo+0TOOTnPzxIVEABnrn9u3xW
	iI5zTaYJVFkqIVLQx5VrbDJmmHG2TAmuGWCQn263kXbWVGIeYpT7vA+9G57bac6AdWuw1o
	Ck9qtT2Isppzh6QH2ZMb1i9knsD8GOU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-J6k_oaR1OLqL6Z52PrwNhg-1; Mon,
 02 Jun 2025 09:09:07 -0400
X-MC-Unique: J6k_oaR1OLqL6Z52PrwNhg-1
X-Mimecast-MFC-AGG-ID: J6k_oaR1OLqL6Z52PrwNhg_1748869745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D60F19560AE;
	Mon,  2 Jun 2025 13:09:05 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCD4C18001D8;
	Mon,  2 Jun 2025 13:09:03 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filelock: add new locks_wake_up_waiter() helper
Date: Mon, 02 Jun 2025 09:09:01 -0400
Message-ID: <F3D97B2E-1693-4E31-BBF8-63F7F550ADCB@redhat.com>
In-Reply-To: <20250602-filelock-6-16-v1-1-7da5b2c930fd@kernel.org>
References: <20250602-filelock-6-16-v1-1-7da5b2c930fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 2 Jun 2025, at 7:58, Jeff Layton wrote:

> Currently the function that does this takes a struct file_lock, but
> __locks_wake_up_blocks() deals with both locks and leases. Currently
> this works because both file_lock and file_lease have the file_lock_core
> at the beginning of the struct, but it's fragile to rely on that.
>
> Add a new locks_wake_up_waiter() function and call that from
> __locks_wake_up_blocks().
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good,

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


