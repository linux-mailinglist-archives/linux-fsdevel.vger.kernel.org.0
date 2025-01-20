Return-Path: <linux-fsdevel+bounces-39711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F117A17219
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B147A4393
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F851EE03C;
	Mon, 20 Jan 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXQRPrRk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA221DFE16
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394908; cv=none; b=oRskdLPjawnsVXF7xA10EJFLc7Q/lcCBwsMSYyxKC4fM2wSfZG5jR3HRfr+naAwcvxTso6ZJEOF8xJXuFNxlS1UP3SVCV04gzdwMIKduIh4MT+wvE4E193av6dBfiNu8n5Wyi0sNZZbcquUC3g3WJHf71q1KXCaQ5up2EOOaB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394908; c=relaxed/simple;
	bh=RfwqfJ6WQFvFiurvX7OLUSqD6sAC/uLfdBok+sVje58=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gkxpaVg7TZlUVbh5QeYJoirxTD5CWEohUgbjydTcPoKqiv7qZZxhV3j15MHNzQTPDeLI66UQiB3WzNMQXvkwlyhwOx1vxUms6fSu4a6QzWLCFLqC7bTLUaOmz2SInbWIv8B0wffdbXT+awPUh5EAR3KD6hY0C3T8Y76ohTXL0D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXQRPrRk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737394905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpxnSlISiNchvWWX6LnEHPhu33sba9G29IFfuhf9BNM=;
	b=WXQRPrRkb0KnELwB3BVcj9IkM1V0fOJ49KL9MvpkH/Utyk7YGXhz7y0uQKFxLcJIXSHJJ+
	uSA7yICdEbTS7GYjOk4C2ih82Yp3z7/a0X93Wo5EzE9jpgoNgmVgLdazurxjKf0em0JBO4
	O6K1Kq7Kvm3rFwAiSWhI5XstcH4sq4k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-E_Bkld3aMdefOaFDLZKDhQ-1; Mon,
 20 Jan 2025 12:41:44 -0500
X-MC-Unique: E_Bkld3aMdefOaFDLZKDhQ-1
X-Mimecast-MFC-AGG-ID: E_Bkld3aMdefOaFDLZKDhQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 289B1195604F;
	Mon, 20 Jan 2025 17:41:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C268B19560AD;
	Mon, 20 Jan 2025 17:41:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250120172542.GC1159@sol.localdomain>
References: <20250120172542.GC1159@sol.localdomain> <1201003.1737382806@warthog.procyon.org.uk> <1113699.1737376348@warthog.procyon.org.uk> <1207325.1737387826@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    fstests@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: Error in generic/397 test script?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1211246.1737394900.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 17:41:40 +0000
Message-ID: <1211247.1737394900@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Eric Biggers <ebiggers@kernel.org> wrote:

> It would be enlightening to understand what the issue was here.  Did you
> explicitly disable these options, overriding the imply, without providing a
> replacement?  Or was this another issue specific to unmerged kernel patches?

I enabled CONFIG_FS_ENCRYPTION in addition to the options I normally use, but
didn't realise I needed to enable CONFIG_CRYPTO_XTS as well.

David


