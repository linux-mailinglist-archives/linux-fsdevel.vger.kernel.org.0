Return-Path: <linux-fsdevel+bounces-46295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4BA861F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFE189D576
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21DF20E00B;
	Fri, 11 Apr 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fI2LZrKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69F487BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385656; cv=none; b=To1Y6QHlrJ45NexMtOJRvoEOqaEFxATaivjfoplY/v88wEMn26FL3ESrQGywtGrqEtxyVr1v/4uqflBf9sRFIe54MqB3LyjygCr7lxOd8jpU3V/XaFdZbC9HCoM5plJPogA0lffXblJ/TvYD/7X8g+/UGjD2lg798uHgb7G7fyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385656; c=relaxed/simple;
	bh=rG9dFgpUFs+9Utfiof1P9qMSsV1pNeVw+D8FvtrrL1Y=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hgZ+6+koTap5w2ESetqaDIYiyuJoNFAN4nUbK1oSLqIaulbQePNRkfaakNoxfVnvjx0ZMbWwKlR2gtVM+zsiy9/vS9C6Nhl3MwqqP1YeV8O8pOoMzBVT9q+TqAY9W+VoHSt7h+WcHm731QLGKODGY4GyZlBe8nf7HVgaIbXD/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fI2LZrKn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744385653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhYsOJdsfx866WPJGrSolHlP/LFfcf7OlKxeuxGvw9Y=;
	b=fI2LZrKna8lTPiDtizi/v5Fdw/QgvD4j3/Q/yk0PUyK8khcQUNEDVrGD/hmRdxBAD1iOAJ
	WrdNZFCKLtzxywR/07E7w9okGelYz2HB70OavHelHicywFPeoUN0eIXR5d1wP+mVtFjWZJ
	uw+tz/My9nix7kSRmDJD6s0um+eAW4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-DFLz-8QhPbOMGRTUZG__Sg-1; Fri,
 11 Apr 2025 11:34:10 -0400
X-MC-Unique: DFLz-8QhPbOMGRTUZG__Sg-1
X-Mimecast-MFC-AGG-ID: DFLz-8QhPbOMGRTUZG__Sg_1744385649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D87018001F3;
	Fri, 11 Apr 2025 15:34:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29DEE19560AD;
	Fri, 11 Apr 2025 15:34:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com> <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 1/5] fs/filesystems: Fix potential unsigned integer underflow in fs_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2425259.1744385645.1@warthog.procyon.org.uk>
Date: Fri, 11 Apr 2025 16:34:05 +0100
Message-ID: <2425260.1744385645@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Zijun Hu <zijun_hu@icloud.com> wrote:

> fs_name() has @index as unsigned int, so there is underflow risk for
> operation '@index--'.
> 
> Fix by breaking the for loop when '@index == 0' which is also more proper
> than '@index <= 0' for unsigned integer comparison.

There isn't really a risk.  The list walked by "tmp" and the checks that this
is or is not NULL will prevent a problem.

I also feel that breaking out of the loop with "<= 0" - even if the variable
is unsigned - is safer, on the off chance that someone in the future changes
the signedness of the variable.

David


