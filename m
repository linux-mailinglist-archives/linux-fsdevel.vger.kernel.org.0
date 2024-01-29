Return-Path: <linux-fsdevel+bounces-9454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA84D8414B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F8228998A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DEA157E68;
	Mon, 29 Jan 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="a45d4hFm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641629D03;
	Mon, 29 Jan 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561604; cv=none; b=X22E8Xxa1nUJsYlqO3mf4P+CoS5I7Qs5sLk8z5e3jevhvBZFygqMsnSeHRXeTlnOqikWfidU4vPk3CGP6x+6PbZafU/q4Vy94d94hBCyOMspcL5tmzo3QIwcDMnIFdo0OJ7p7i+yuxP1urTSfVm1a0zkqgAKUyAaZL/sfhdtmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561604; c=relaxed/simple;
	bh=7shu1kQp5hKe9agoMH9qJo8QtYjjAUCVX1MLlx22v1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugpHnhI4KGp3hoOH7d80b3fsllh1b+BLq6RtP1SoEGy0aYefmWiDkIviUrvz4Fl65kWKTd+6u6yj/ry4Ia+FnsjWT5Zq0P7+BGa0T6OqXhd27usIwW2ujUiH1calD7rc/TGmOf1PEvR2/dvAr0dhC/imPd7nt9xWQSpf1nvu4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=a45d4hFm; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=2dTEyjtteeuqOs2PRClBfhfMNIS8T9MNH+TgboxuqbY=; b=a45d4hFmybCdijy4TXhiCFFbFs
	NWL/Y7lkUWm58OqzeLEYiUTCBAtp5Sr8kyOIuyiKIwZ0mLIUqgucQRoZzy5dOUyN9iTy1Bq/kSkgY
	9P3gHx44UdxOLI6qodRvssAYO2nZFe/FMU0SKlmCONjNmS+kR33o+5Nopw+SZljmhme5zH1Iw4yQK
	Pj85DoPO0i95fpuEohClOsrBVgEO4xM6yOckL5nuIZciCidzLCs/Wy7Z5OKY6zXHIXUxYwuXnep3g
	GOPKlRPwxAXe/umGjGi4SOVXW9HWm7Brp/MedqI89RRZ0b8LLUo0e1LJxndDOQ75AdulrvBpnYbuX
	izXrrKTdYCofr60bEqe3Gh2MeOxui8Hdtu7lVxeHtLprFrYdgvQ/HIPRdSQuFncWGE+6VyQoPTNQ6
	kk3cpHwmNX1Wo8cfhrO4QYV8Fe8LhPxwIHZGiRwsyAJ4D4ZgfJ5Csc4fn15+UXdMMK0qeFCIlfuMJ
	OxrlC1cpbDMpGVusfhNKoTsYj6eZumqAXQArpszJXmlwmUAo7tPrZ8hPa/ZXD3+MpgiyOTDvUd//I
	xpyxSo/JMpX3HExjDwhCQldsKf1WFrv3DyjHv1L2ZDBTdnR7dvRiLrLwoKoBaR+0vqJYggqCgl9s/
	zvf+SagYnHCxVsKxc24z5tOE8T9g0ZWakGfvQeZks=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Matthew Wilcox <willy@infradead.org>,
 Jeff Layton <jlayton@kernel.org>, Christian Brauner <christian@brauner.io>,
 netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] 9p: Further netfslib-related changes
Date: Mon, 29 Jan 2024 21:53:09 +0100
Message-ID: <5747464.0Q8nNhgPvr@silver>
In-Reply-To: <1400271.1706538135@warthog.procyon.org.uk>
References:
 <1726980.McBZPkGeyK@silver> <20240129115512.1281624-1-dhowells@redhat.com>
 <1400271.1706538135@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, January 29, 2024 3:22:15 PM CET David Howells wrote:
> Christian Schoenebeck <linux_oss@crudebyte.com> wrote:
> 
> > >  (1) Enable large folio support for 9p.  This is handled entirely by
> > >      netfslib and is already supported in afs.  I wonder if we should limit
> > >      the maximum folio size to 1MiB to match the maximum I/O size in the 9p
> > >      protocol.
> > 
> > The limit depends on user's 'msize' 9p client option and on the 9p transport
> > implementation. The hard limit with virtio transport for instance is currently
> > just 500k (patches for virtio 4MB limit fetching dust unfortunately).
> 
> Okay.  Is that 500KiB or 512Kib?

'msize' is currently hard limited by virtio transport to exactly 512000. For
rdma and fd transports it's both exactly 1MiB. For xen transport it should be
exactly 524288 (could be lowered though depending on configured xen ring
size). You find the individual transports to fill the field 'maxsize'
accordingly (in net/9p/trans_*.c).

So that's the maximum message size. Then the individual 9p message header
size needs to be subtracted. For Twrite request that's -23, for Rread
response that's -11.

> > Would you see an advantage to limit folio size? I mean p9_client_read() etc.
> > are automatically limiting the read/write chunk size accordingly.
> 
> For reads not so much, but for writes it would mean that a dirty folio is
> either entirely written or entirely failed.  I don't know how important this
> would be for the 9p usecases.
> 
> David
> 
> 



