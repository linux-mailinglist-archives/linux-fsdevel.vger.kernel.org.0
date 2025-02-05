Return-Path: <linux-fsdevel+bounces-40952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB6A29894
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F39188A96A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27B1FCCF6;
	Wed,  5 Feb 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR1UgUFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B11779AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779478; cv=none; b=umHrwSh4LWINJhlaq/Z29oSFUELzb9H2N3Ny3uby1YZncDoZalu2FSnRYbZW9qLs48lV5ewNWT6K7maHkvfLk3nL1lfc3OqjViiEi8RIrTiONyCwqZp0ln4+UNSEy3hQlXw7b1pM8dDZln4v6S6Nw59UltC6uCRfrFSuGXl4R5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779478; c=relaxed/simple;
	bh=c34wdRip4r0O+qy4GPeBJdDXK/Sus/O9TeLRCocFf+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uZtOfliKeT0nmU/2k97E5C/yCAdoAccTiXZeJWxWr6EcjPpTBF1O7aW5tT2qztRHIWwfogfszhQod94ckmNUgdR46VdtLajcsrFpj/BxBK8yJfdyFx939s8SZEUjkRI5zMFlGBiOzj10Pdk1N5DsUVkZ/YOvbXecZ2f/hfcqex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iR1UgUFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738779475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=c34wdRip4r0O+qy4GPeBJdDXK/Sus/O9TeLRCocFf+Y=;
	b=iR1UgUFGgQexMMnCZSh/91leGvzGK92vCy1624UXldAVOMpdUSxBBjvLpcjsp2GczRTDhW
	TKYlbaIh720bZlI7wtwAdPc3tvXDcVyHH3PDZz/E9A7dLv1X/aqzjqulSksQc3oGzklCEr
	grJGW36LeHdXdtV7XbLuAKOzZmNrthQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-pAR24RR_NIu8wE2YVPOxYg-1; Wed,
 05 Feb 2025 13:17:51 -0500
X-MC-Unique: pAR24RR_NIu8wE2YVPOxYg-1
X-Mimecast-MFC-AGG-ID: pAR24RR_NIu8wE2YVPOxYg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A39219560A3;
	Wed,  5 Feb 2025 18:17:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A9F981800879;
	Wed,  5 Feb 2025 18:17:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Feb 2025 19:17:22 +0100 (CET)
Date: Wed, 5 Feb 2025 19:17:16 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250205181716.GA13817@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

OK, let me send v3 right now...

Changes: make pipeanon_fops static.

Link to v1: https://lore.kernel.org/all/20250204132153.GA20921@redhat.com/
Link to v2: https://lore.kernel.org/all/20250205161636.GA1001@redhat.com/

Oleg.
---

 fs/pipe.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 15 deletions(-)


