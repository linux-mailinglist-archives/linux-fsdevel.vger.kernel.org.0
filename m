Return-Path: <linux-fsdevel+bounces-67652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277EBC45B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B213B75C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF6301716;
	Mon, 10 Nov 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqOLMzeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFAF30103F
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767913; cv=none; b=LghJNjPfpy98nab5EYPIkQlAeccRiM00xOsPkfPd5dK1q05fSOrqk8FZ8CkYxrZINGN7oTI3PVyiytbSLlJ6471cuxEBpFPe80WFAwjQ77b4TwinBV9EXG4agcGBhDjmvQL2zhvb4SdOxdehrzKKtPXzNylAMp6V9IYOUUQT10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767913; c=relaxed/simple;
	bh=goBB6a9ijYsjH1ApwGICOTD9RRiuY+gQpLOMLI1pKjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IvG98xHzWebx521S2wv+ZoYD8Ja/wzQMai1tpuBDgGYM8pTsbsneNK6h0ZwrKlUeoB5hSfnyS5q9LW23O6iCJoROyMjqW0FDGom4MrCFdPtFsXjrqSsxYyiRkU/OOk70/ipEUR7XPvBpqiJ1X/T6zrSiMtLwAA4pvAliwnEEetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqOLMzeY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762767909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVXpka/wfvK1NTQpXcElrqr+Eu4p1Ghvs93NaoRYmkY=;
	b=UqOLMzeYsMiJ1XxiRnZuPq029M5xXXA6wkIZwMn37Yq0/ktjg3akP0gXYuje3cOQYE2llS
	4GXtLKlDXb35xChIaFFB6J6/OHSTFh1sSP2f04gBrcGwjYlcJcXJlCnW1ENcEbxQVz0FOO
	WVX/TwlKmCNj+wJ0TLqgzf3fWUtEbHE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-tAv0p3UENYmR87MU9ynLsg-1; Mon,
 10 Nov 2025 04:45:06 -0500
X-MC-Unique: tAv0p3UENYmR87MU9ynLsg-1
X-Mimecast-MFC-AGG-ID: tAv0p3UENYmR87MU9ynLsg_1762767905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E97195606D;
	Mon, 10 Nov 2025 09:45:05 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25B581800576;
	Mon, 10 Nov 2025 09:45:00 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,  Matthew Wilcox
 <willy@infradead.org>,  Hans Holmberg <hans.holmberg@wdc.com>,
  linux-xfs@vger.kernel.org,  Carlos Maiolino <cem@kernel.org>,  "Darrick J
 . Wong" <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251110093701.GB22674@lst.de> (Christoph Hellwig's message of
	"Mon, 10 Nov 2025 10:37:01 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<aRESlvWf9VquNzx3@dread.disaster.area> <20251110093701.GB22674@lst.de>
Date: Mon, 10 Nov 2025 10:44:58 +0100
Message-ID: <lhuframz0f9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Christoph Hellwig:

> I think what Florian wants (although I might be misunderstanding him)
> is an interface that will increase the file size up to the passed in
> size, but never reduce it and lose data.

Exaclty.  Thank you for the succinct summary.

Florian


