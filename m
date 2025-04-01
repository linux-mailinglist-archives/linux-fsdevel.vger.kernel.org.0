Return-Path: <linux-fsdevel+bounces-45480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E35A78536
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 01:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A763AFC03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F061219306;
	Tue,  1 Apr 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jEE3WfX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBF79FE;
	Tue,  1 Apr 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550120; cv=fail; b=N4iu3zwEj3M4jOYhsQV4HNsaS0L5ThSd1N3xWJ44/jdcf77d5Vt2VDceGcl8tpzmiDHA0TLJ63re6KQTF9iyy5hEft8sX0r4ttdLQotarXfTXhXF3HY8/BV4sw8Nr7J5P7oXjYL/CnLvyo5JM625OVW5Y3CUOBDTHv6w+RymO78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550120; c=relaxed/simple;
	bh=3EdtnBCcPPQoRT39QH4cx4vpohrBi1mfsPi4WtMvZYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BngGlq9FYDZFnah5PWFoxdcDzT3xr+NanpXmFNw70sqTCBQZ5YQ5Nm02VhI3cxiQv5DvIyw9nDTEz3VBDbNRJ+rwdYcOpYSm1H7ERXLs1pRS+h54PSHP6207ig9jAUT+wSIhNvxJjc4ggCkf7Y3oEBSjWIZedhYAXuDXtQWEsto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jEE3WfX7; arc=fail smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0416B162AC6;
	Tue,  1 Apr 2025 22:53:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.103.0.25])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 51EEF162750;
	Tue,  1 Apr 2025 22:53:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743548004; a=rsa-sha256;
	cv=none;
	b=3uBL9qnv++k8OpHa3PgBEJwvJ8U8AHgXv6FgTzuxLlV9Yz9mSQooQ/E/6kXTVXMf/DAGl9
	e4h0H3K5YLCr2EmyzFXKHigoInalvYimoQmMPUjaL+BQlermGDaeQ37S6RfvLSqA8rCqkU
	zUF4EtnShqpS8FNZGmZP3Ia1W9F3YI6eWf4Wb6mWfY1/cCDrK3q2Rx9/6iXXHEmG+3bGeG
	HkQ2FxJ4G9pHPBFcMgOaBrhcESp7PvHeN05/W1V9t+94So07eE1dYj9D8PJ1ff1G6oXSkc
	3pABELere2SuHQ75Y9ZaESdRsdNovzp6dF+l2HN7LHwdBmr4DZmQ/JNBFfI+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743548004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TmEuivAsrB2aUlVpouUlJVZjbNXTLUQDImWDuTkDTiE=;
	b=EUDX5hcTIpCjSjWuDLS1bAtxEVSoQYmONtVM60aiC50tUQL9it6HRJ71WBIRMd47xsykXO
	DcsAuqfVpe4gWqe5LttB84D3b+H0omYanZicXole5+kXpbaj8yXdlNfbDl24vJaWaExvPQ
	WFjQ7rNSx5soh5TmqWKpwDPth5hcgbXF75gTT8Yq4+e3GWDDz+zgaWOqO5/aDVt4Umv6Go
	s6U/xvVGdWYiKKev7ky0WfNOmSzj8C4sfu1TnrqVguNkWd6UamvfrEWOKZYwkiWLNohmXO
	tc3zzhvy5KjIKNQZW/hDL7EDGELL+9WggXDY5vocIZIBYuP75bMcqALUw6Eazg==
ARC-Authentication-Results: i=1;
	rspamd-85757496c5-g86gm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Language-Tank: 20dc4a942d884c8f_1743548004812_1395248438
X-MC-Loop-Signature: 1743548004812:471694618
X-MC-Ingress-Time: 1743548004812
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.0.25 (trex/7.0.3);
	Tue, 01 Apr 2025 22:53:24 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4ZS3FH05k8z3p;
	Tue,  1 Apr 2025 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1743548004;
	bh=9qcEjBI/jntNKbsu31QIldbh3WSFsiDqWDYrQyuc12s=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jEE3WfX7ryEyDJ+B+hP/VQtq1AmS1A086BXxaSLLxgQPAYUOB9sBLuN8C1EOrPYkl
	 hClS6qK+RComUqXTJnBnPjJWa4K2EYYYiOcPJ5suRivi4aJ45jEl4+VBnSypdzeN2o
	 JYt8+t3eqPtkr8E3djYUEFvuHUpfoi5FMGP4pbkbQ6BnxD3PDPWnnWmWvnPiol6G0+
	 9NsiCuyHL6HVPdalEwA9BkMAMntJ9g6lU3PP+vfCDS1UlA5pf3fLdqnQuWuMZ9Tilh
	 aFN8u5+Ty9KzStqDO9veLzF0eVsWd/4GmE8bO+/3rurk4L4K0HUGzjcLm4YsYlxbce
	 DxoyWwNC985vw==
Date: Tue, 1 Apr 2025 15:53:20 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, jack@suse.cz,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, hannes@cmpxchg.org, oliver.sang@intel.com,
	david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH 1/3] mm/migrate: add might_sleep() on __migrate_folio()
Message-ID: <20250401225320.uee5as2bmw4p6ygl@offworld>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-2-mcgrof@kernel.org>
 <Z-kzMlwJXG7V9lip@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-kzMlwJXG7V9lip@casper.infradead.org>
User-Agent: NeoMutt/20220429

On Sun, 30 Mar 2025, Matthew Wilcox wrote:

>We deliberately don't sleep when the folio is only a single page.
>So this needs to be:
>
>	might_sleep_if(folio_test_large(folio));

Along with willy's suggestion:

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

... and the same rules apply for copy_folio():

fs/aio.c: atomic context but no large folio: safe

fs/fuse/file.c: no large folio: safe

fs/nilfs2/page.c: blocking safe, has large folio: safe

mm/migrate_device.c: no large folio: safe

mm/shmem.c: blocking safe, has large folio: safe
shmem_replace_folio() could use a might_sleep() I guess.

Thanks,
Davidlohr

