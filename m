Return-Path: <linux-fsdevel+bounces-49274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB66AB9EF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727541C000A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AD19ABC6;
	Fri, 16 May 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKLFiR62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E5139579
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407184; cv=none; b=IG4RIBrwWRTIaXeDt7uBquy7FEmk9682RHvIGHQCyO8tlEKwgX0Ehu2qfBCDo01ozfsfFKrtBceVuo+uyHnk39yRtucM3dqFhPAyuRP4NMDFHE/HEMa/npLrWnz6EJ2e/UQI7T2w9kp4GvOUpJABZqKqIyFTOtnFkkaKNCNJcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407184; c=relaxed/simple;
	bh=q7WjgDTPdaU3BTGpUJIX2kLOTrHFAkVYzQOeh6mCvEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAlmupPc7ZTQ90EV36oNBsjHGJWs0kj7QlHQI91urUeaIvBBcELhDddf+lj4qdJj4/7ctsIMNWYZePiz6pnI1Xu43rittUTpz3/sZlpcW6L9PJOx83dO7fK9hiNFhDM34lcaAMl7+eb+t8j0Jd5ad9UxL5K5PHnoemmWIIBeDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKLFiR62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747407182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eUnwzuxOw0gUMu1n5Pr4hXe85qgGk4DgfxJ9oyFnEuU=;
	b=aKLFiR62Bhchsof6OXuZO+4qb51T7zcI1D32n/LNm8XvhqOq5EoBGtH71jyooYelYRM3A9
	575ASSd7q9OxUlWDZrcBT7auuqrzgKXwDsmKnPmuqPkWc+HX1LCADQuDaG4coGnkRm+UA7
	Y8JqKLPV7xgFBIZ6kYpzuJvzPCBok1E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-vzLHRjzaOaubWHfVeb5IGA-1; Fri,
 16 May 2025 10:52:58 -0400
X-MC-Unique: vzLHRjzaOaubWHfVeb5IGA-1
X-Mimecast-MFC-AGG-ID: vzLHRjzaOaubWHfVeb5IGA_1747407176
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93AF31800446;
	Fri, 16 May 2025 14:52:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.144])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B3E51956066;
	Fri, 16 May 2025 14:52:51 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Vincent Lefevre <vincent@vinc17.net>
Cc: Rich Felker <dalias@libc.org>,  Alejandro Colomar <alx@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian
 Brauner <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
In-Reply-To: <20250516143957.GB5388@qaa.vinc17.org> (Vincent Lefevre's message
	of "Fri, 16 May 2025 16:39:57 +0200")
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
	<efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
	<20250516130547.GV1509@brightrain.aerifal.cx>
	<20250516143957.GB5388@qaa.vinc17.org>
Date: Fri, 16 May 2025 16:52:48 +0200
Message-ID: <87cyc8oben.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

* Vincent Lefevre:

> On 2025-05-16 09:05:47 -0400, Rich Felker wrote:
>> FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
>> issue, and later changed it to returning 0 since applications
>> (particularly, any written prior to this interpretation) are prone to
>> interpret EINPROGRESS as an error condition rather than success and
>> possibly misinterpret it as meaning the fd is still open and valid to
>> pass to close again.
>
> If I understand correctly, this is a poor choice. POSIX.1-2024 says:
>
> ERRORS
>   The close() and posix_close() functions shall fail if:
> [...]
>   [EINPROGRESS]
>     The function was interrupted by a signal and fildes was closed
>     but the close operation is continuing asynchronously.
>
> But this does not mean that the asynchronous close operation will
> succeed.
>
> So the application could incorrectly deduce that the close operation
> was done without any error.

But on Linux, close traditionally has poor error reporting anyway.  You
have to fsync (or equivalent) before calling close if you want error
checking.  On other systems, the fsync is more or less implied by the
close, leading to rather poor performance.

Thanks,
Florian


