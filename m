Return-Path: <linux-fsdevel+bounces-9973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7A846B8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869C2281C77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE074297;
	Fri,  2 Feb 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQzazboQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDE65BA5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864999; cv=none; b=an0YjHR95SQ7Ge+bjuWzF9AL8pZeXEirB6YrYM4yf9lrgiSmK0mlLY6PvbW9LnFURAbeJQHc0lnNohKPRyvXeZme1ZJ9Y8pQCcO+eqqXQrufiOqnH59/Xc7bAwyElWcKn74Ml7OnzExhA5DcQL09yDIYF8f6iVmkEpjmV7RwRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864999; c=relaxed/simple;
	bh=CsuUIB9BGEhPpq82AnSmPqKa7q1L7vczo0Qa7uKk6HI=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=S2QQ8nxL1kFIfspQbPncQYU0Yqv4T+DQFy+Soe2LZaoQh9dBe0fby8zP+fixOXrU9RCemLHf/Fv/t2aD1uC7EBbvtHC0+BeMcdbzDl93HLyg9/V+nzV8siyE+/9rFS++Jlt/8qhwiSPSB++iIvkzdjQKiDw1DGVFaWpn7ImwdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQzazboQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706864996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wR/xEWsoc/qcVUxpsQwiYXMTwgRl2K/SGjKuYsI30Fw=;
	b=JQzazboQyhfpEM9Np0W+iw/SJUSxg3v9n96y4sYtysS/uLgnS1Qpah6gIpliEXMLjhxmt3
	9PPn4ckmRE02pYH/hV45R38kbM161DauCPp7iFd8djCNoYs3QBv/j7Fls3tGONQULfChtF
	TfrDCpCDHcLK/EeQV2lueNQxO5ORIFc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-uL2SUc8LORqDEysyTOZeOw-1; Fri,
 02 Feb 2024 04:09:55 -0500
X-MC-Unique: uL2SUc8LORqDEysyTOZeOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 288581C05194;
	Fri,  2 Feb 2024 09:09:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 682D21C060B2;
	Fri,  2 Feb 2024 09:09:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: lsf-pc@lists.linux-foundation.org
cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2701739.1706864989.1@warthog.procyon.org.uk>
Date: Fri, 02 Feb 2024 09:09:49 +0000
Message-ID: <2701740.1706864989@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi,

The topic came up in a recent discussion about how to deal with large folios
when it comes to swap as a swap device is normally considered a simple array
of PAGE_SIZE-sized elements that can be indexed by a single integer.

With the advent of large folios, however, we might need to change this in
order to be better able to swap out a compound page efficiently.  Swap
fragmentation raises its head, as does the need to potentially save multiple
indices per folio.  Does swap need to grow more filesystem features?

Further to this, we have at least two ways to cache data on disk/flash/etc. -
swap and fscache - and both want to set aside disk space for their operation.
Might it be possible to combine the two?

One thing I want to look at for fscache is the possibility of switching from a
file-per-object-based approach to a tagged cache more akin to the way OpenAFS
does things.  In OpenAFS, you have a whole bunch of small files, each
containing a single block (e.g. 256K) of data, and an index that maps a
particular {volume,file,version,block} to one of these files in the cache.

Now, I could also consider holding all the data blocks in a single file (or
blockdev) - and this might work for swap.  For fscache, I do, however, need to
have some sort of integrity across reboots that swap does not require.

David


