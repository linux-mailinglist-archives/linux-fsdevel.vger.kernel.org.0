Return-Path: <linux-fsdevel+bounces-30337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3781989F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56F91C22504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2A18BC0F;
	Mon, 30 Sep 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAiTntfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15DA18A921
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692416; cv=none; b=JEpcDhTw4bSqLyk5qVGoCbwk2MBc/4H8GKCuF9VUqI3i28mCfgzYvu1RjxqVvUNIz5aOrkClozN3BucQ1I17t8zYAR2OC99yEHnSzAGxCAqiQJK/2fLXfDwCbncP1A1jouuunWtJxqL8/VrLXNyLrcyUtP/ufMclDh15hNl4eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692416; c=relaxed/simple;
	bh=GQWWTfHubQuieHaS/hviuz6e8IYCnUTftJg25TZvPag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PemlGGzb54rPCg5S0G0IcvQwqFORjaF1AGHjIQxlhrCfvn7EUy77hiLVaYOmLq8h46jqVEuXpkkXgzy6mdjBVKd1HEbm2P+zTBFSOGgmO3+5Hn1aWHD9OSz0O/s8p4TmXX8DokwfaOhfyAJE7b7oagohr22KCXyJu9z/qVFg1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAiTntfM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727692413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWjTQgM2FW5gQeC40mC/LxGIRFWdUXta0r321EYH9ic=;
	b=DAiTntfM1B9laSvZJ1g3KU5xAzgLc+v5k7XxekjBatp6Uf29ZeSFF+UxkmFP//mcS1CF+6
	uVz4knY0Hh+HtQBr1CX8PmwdxGDcwtLxA3quqktr9lFzBO4O1yAcDOJvHJ+EZfWLL/Jdt3
	p62tD5BkN5FzDvDK5wQQuOgRxyx2dRw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-CyjLEtWuNmOvKROz4UGw9A-1; Mon,
 30 Sep 2024 06:33:28 -0400
X-MC-Unique: CyjLEtWuNmOvKROz4UGw9A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 334A2195395B;
	Mon, 30 Sep 2024 10:33:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.151])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A708C1956088;
	Mon, 30 Sep 2024 10:33:21 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>,  Shuah Khan
 <shuah@kernel.org>,  "Liam R . Howlett" <Liam.Howlett@oracle.com>,  Suren
 Baghdasaryan <surenb@google.com>,  Vlastimil Babka <vbabka@suse.cz>,
  pedro.falcato@gmail.com,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
In-Reply-To: <cover.1727644404.git.lorenzo.stoakes@oracle.com> (Lorenzo
	Stoakes's message of "Mon, 30 Sep 2024 10:22:27 +0100")
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
Date: Mon, 30 Sep 2024 12:33:18 +0200
Message-ID: <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Lorenzo Stoakes:

> If you wish to utilise a pidfd interface to refer to the current process
> (from the point of view of userland - from the kernel point of view - the
> thread group leader), it is rather cumbersome, requiring something like:
>
> 	int pidfd = pidfd_open(getpid(), 0);
>
> 	...
>
> 	close(pidfd);
>
> Or the equivalent call opening /proc/self. It is more convenient to use a
> sentinel value to indicate to an interface that accepts a pidfd that we
> simply wish to refer to the current process.

The descriptor will refer to the current thread, not process, right?

The distinction matters for pidfd_getfd if a process contains multiple
threads with different file descriptor tables, and probably for
pidfd_send_signal as well.

Thanks,
Florian


