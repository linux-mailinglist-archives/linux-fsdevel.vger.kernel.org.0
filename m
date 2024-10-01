Return-Path: <linux-fsdevel+bounces-30488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523C98BACA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709B1B23EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770421BF7FA;
	Tue,  1 Oct 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPTQA4Xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425591BF333
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781353; cv=none; b=LazCuERjav0onUbqLtwrknRR5bvfq1cf40W6BtMRhyzxk+Q5KvKCPlAXHS2+IxviP6NQrhc6Ry+fvSGPqzZyP+89Fb8oy7j0+L65DPCtQRfkBU13RxY5xNfkglY00bF+DNoUn99vFQXvQVgRrgmTMNOAqIYvaEnxnQFCcNsva1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781353; c=relaxed/simple;
	bh=75htphhgA085Ed8d9ndrShWFVyE9Crb9bXv3CKbhqHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV6IFa4j5j7ZUfgdOiJ0XaBCWkVMq8VPBCLSO3cEkJzEUaPPJEhQKrOx0MUPCcll01GxYlHJ5UMBtmk3nh9YcEeMUbQjPmwz8Mp5j1p9LsTQfo0GVncxmHDEB6WJElyx7wOwlA1ID/N2Mox6ZbKYWfO4DdWd1G7pZW06QyWGqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPTQA4Xw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727781351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIVZImqQH49iyAAF5H9hztBo3T/3c+Ny3Vzoq1Av9pM=;
	b=WPTQA4XwWPEGEn0T4upx7KKZDgkjIAwUTajD0DAId9AS9VMZDohfaXOmkqGqjOBfEI82q9
	6dPBv58FdIv7nYHTbJIwugnxCRpecP3j5TLO32kuImS4VjvbM33FKcduXuDiJPxO2S6oPr
	b/xJEwqwE5g0QHqjvAthtvrvTZAZMmM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-gpYJf8bhNRKEkSMww0yRxw-1; Tue,
 01 Oct 2024 07:15:45 -0400
X-MC-Unique: gpYJf8bhNRKEkSMww0yRxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68422194511F;
	Tue,  1 Oct 2024 11:15:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D20FF1944B21;
	Tue,  1 Oct 2024 11:15:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 13:15:29 +0200 (CEST)
Date: Tue, 1 Oct 2024 13:15:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Stas Sergeev <stsp2@yandex.ru>
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
Message-ID: <20241001111516.GA23907@redhat.com>
References: <20240930195958.389922-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930195958.389922-1-stsp2@yandex.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I can't comment the intent, just some nits about implementation.

On 09/30, Stas Sergeev wrote:
>
>  struct group_info {
>  	refcount_t	usage;
> +	unsigned int	restrict_bitmap;

Why not unsigned long?

>  int groups_search(const struct group_info *group_info, kgid_t grp)
>  {
>  	unsigned int left, right;
> @@ -105,7 +108,7 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
>  		else if (gid_lt(grp, group_info->gid[mid]))
>  			right = mid;
>  		else
> -			return 1;
> +			return mid + 1;

Suppose we change groups_search()

	--- a/kernel/groups.c
	+++ b/kernel/groups.c
	@@ -104,8 +104,11 @@ int groups_search(const struct group_info *group_info, kgid_t grp)
				left = mid + 1;
			else if (gid_lt(grp, group_info->gid[mid]))
				right = mid;
	-		else
	-			return 1;
	+		else {
	+			bool r = mid < BITS_PER_LONG &&
	+				 test_bit(mid, &group_info->restrict_bitmap);
	+			return r ? -1 : 1;
	+		}
		}
		return 0;
	 }

so that it returns, say, -1 if the found grp is restricted.

Then everything else can be greatly simplified, afaics...

Oleg.


