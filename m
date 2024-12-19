Return-Path: <linux-fsdevel+bounces-37830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8E9F80C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34190189597A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FCC1632FB;
	Thu, 19 Dec 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i3pKrXIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41572AE96
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627195; cv=none; b=g+/y1s1r2p+BUso0kzXKUOuTbrISRhjo8C76WnasT1TA0d45sykja3/0cNuftwhCibZ8F/U7Mww0sfVpDAwnuoZmNeHYluKU/9b+GLjxqk+JUsmECEfnxEEEzJ+2KgsGk3N8Hf9xPS5ouIFsrjKAI23h6nV60Wh6ATArBDc2WFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627195; c=relaxed/simple;
	bh=+VbN4XN/7gyztiYSNgX+hksCMLU0fu7tKNyKFFpqq5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5OrT8JWbvY8pCmQ2FwL9bH53xGJBrSwqG23eu0dVzvmxoozewZAxs5kVCHHwB8EWJVdcPI8LIg9DScS7xS36Jba9lnCa5pqmcDz/7HOzY4SkBlcrpZ+pSw4eCHEzuz1TscNcX0AJl0XW49xpsoVMzY2WYT5E108Dah9Mb92dks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i3pKrXIH; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 08:53:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734627189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/v/tr3WkcfEug0hC1qOWrJZFyNOIJcl6HHvB0r/nlo=;
	b=i3pKrXIHumH+nSJu3npYm7OIC/6GpDp2Xox2fDCXmhytgZNmW3IG1wNPhtljRnwaFJDfSI
	hKwGw/pHfUyvgVqhNZgWXh1hNEzUlABtvzq4DQgkOcTHhfi6E0lH31713p+TOiC/Owg62z
	MKpM0OXEHb3IzDBGKN2ZfXDRQxqjt7Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <azx4lwcvcfkh37e36sdp22x7ixthgviuplb2ecb3zzjndys4ao@gmtbq2zyhhp3>
References: <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
 <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
 <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
 <ec2e747d-ea84-4487-9c9f-af3db8a3355f@fastmail.fm>
 <6FBDD501-25A0-4A21-8051-F8EE74AD177B@nvidia.com>
 <7qyun2waznrduxpf2i5eebqdvpigrd5ycu4rlpawu336kqkyvh@xmfmlsmr43gw>
 <4104f64a-09c3-4f20-8e1a-5f4547fdcb25@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4104f64a-09c3-4f20-8e1a-5f4547fdcb25@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 05:31:14PM +0100, David Hildenbrand wrote:
[...]
> > I think this whole concern of fuse making system memory unmovable
> > forever is overblown. Fuse is already using a temp (unmovable) page
> 
> Right, and we allocated in a way that we expect it to not be movable (e.g.,
> not on ZONE_MOVABLE, usually in a UNMOVABLE pageblock etc).
> 
> As another question, which effect does this change here have on
> folio_wait_writeback() users like arch/s390/kernel/uv.c or
> shrink_folio_list()?
> 

shrink_folio_list() is handled in second patch [1] of this series. To
summarize only memcg-v1 which does not have sane dirty throttling can be
impacted and needs change. For arch/s390/kernel/uv.c, I don't think this
series is doing anything. For sane fuse folios, things should be fine.


[1] https://lore.kernel.org/linux-mm/CAJnrk1bXDkwExR=ztnidX4DAvVD5wZZemEVNt9bg=tkwWAg6fw@mail.gmail.com/T/#m02461fb4fb73849900e811d695deee0706c370f9


