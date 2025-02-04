Return-Path: <linux-fsdevel+bounces-40776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E7A2768E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8843A5FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE46215194;
	Tue,  4 Feb 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6gdFHNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DF215068
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684557; cv=none; b=eXUv7Cmpi8RK+DLxQdE7KF2N8zf4bcdHlGzE9EEG7JAUl9pbYFbu9CsQ+yWGMOjqf5tIBymrdDeltv3aXLdde31ciF2SnPMghRW3VnObBdUL/PVCnmXoPGDmGBCSmhgIJhXK+JC/K4st9pcSjKN2vz0pzpnM/hEzhs+LKT/BDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684557; c=relaxed/simple;
	bh=PcHimLdF0m9I1OPXBEq8+f8x1JXxleTVaMhwUes7bgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSefvsvNGgEPhS6+Zuai0FTj453zF9POqZSp40DwaUAc9vvrg5qrWl/TTUYBYiAKpxD+5XudRyJh/Y5uyZ4ESCuJDly2CZCXFVwPuUKRSE6NidR64pIwJX7/Baq9sJym4vXAOr2CD2BvAjbkm7qM+14Ny8I1Hvqf+53WZ9lGPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6gdFHNu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738684553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcHimLdF0m9I1OPXBEq8+f8x1JXxleTVaMhwUes7bgI=;
	b=X6gdFHNudtGY6g3hyDGpIywhGd1qv/NTxrJYsEmMoBuYu2cWIoszFOGQU3oDUbiCjV36j8
	W8s44acFUDMwlIrbcdg4AqEOtQSj/zpFoQcwTLXpGH6O5npFp8MZjCnyJOY8LGAjINpKGH
	NcTzDsGgaivJYAyYGkxfCKL6wNApv0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-TJQP98TPO7KVDhLtxX1lGw-1; Tue,
 04 Feb 2025 10:55:50 -0500
X-MC-Unique: TJQP98TPO7KVDhLtxX1lGw-1
X-Mimecast-MFC-AGG-ID: TJQP98TPO7KVDhLtxX1lGw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D3601801F23;
	Tue,  4 Feb 2025 15:55:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.214])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E87BA19560AA;
	Tue,  4 Feb 2025 15:55:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Feb 2025 16:55:21 +0100 (CET)
Date: Tue, 4 Feb 2025 16:55:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250204155514.GD6031@redhat.com>
References: <20250204132153.GA20921@redhat.com>
 <CAHk-=whwYt=hRk3EG7ASM-=xi3Xp7f82Ltqa=dtbVfZnGhN9ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whwYt=hRk3EG7ASM-=xi3Xp7f82Ltqa=dtbVfZnGhN9ow@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/04, Linus Torvalds wrote:
>
> IOW, we should have "anon_pipe_read()" and "anon_pipe_write()", and
> then the named pipes just do

OK, will do in v2.

Oleg.


