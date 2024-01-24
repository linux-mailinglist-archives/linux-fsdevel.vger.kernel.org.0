Return-Path: <linux-fsdevel+bounces-8787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398F83B07D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770531C2081B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0DE12BEBF;
	Wed, 24 Jan 2024 17:51:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09711272CF;
	Wed, 24 Jan 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118666; cv=none; b=KhGMe1X3nROfgzqpxv6U7g0B3/xQCusvF8kN2yDTgyYt7B26GGXErNWCXyN5UJ3X589FbhsxTf4ZBefyPH3SpUmaleRWni2v3d64SmpruJtsVk6Hn+qHo17/ToHxAgbeYo4TaPnIGYJhwFoi7angcQU4J3zRysXnTRWymL2n2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118666; c=relaxed/simple;
	bh=w7rEBfdQN1/zYVzqjkLSQ1tMJOL/dF1Tae38s5/U7yQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OAIt0yqmbBSxk1DxizoBQ7gftR/KI/1EdvloI1ximUo1TAONBmP2D5x2gcspW0ompBG8ylweWACyHwASNOVKgi/GhxD8V+fe/hUJVeyNn9xu92JKKGXBZXU+IvQj1ekKj/iqRCEUMN3cTB7ePwcjFnZbc59GQQ2/R7aE0iAu0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 854D340A94; Wed, 24 Jan 2024 09:51:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 838C840787;
	Wed, 24 Jan 2024 09:51:02 -0800 (PST)
Date: Wed, 24 Jan 2024 09:51:02 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Matthew Wilcox <willy@infradead.org>
cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
    Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <Za2lS-jG1s-HCqbx@casper.infradead.org>
Message-ID: <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com> <Za2lS-jG1s-HCqbx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 21 Jan 2024, Matthew Wilcox wrote:

>
> I'd like to keep this topic relevant to as many people as possible.
> I can add a proposal for a topic on both the PCP and Buddy allocators
> (I have a series of Thoughts on how the PCP allocator works in a memdesc
> world that I haven't written down & sent out yet).

Well the PCP cache's  (I would not call it an allocator) intent is to 
provide cache hot / tlb hot pages. In some ways this is like the SLAB/SLUB 
situation. I.e. lists of objects vs. service objects that are 
locally related.

Can we come up with a design that uses a huge page (or some 
arbitrary page size) and the breaks out portions of the large page? That 
way potentially TLB use can be reduced (multiple sections of a large page 
use the same TLB) and defragmentation occurs because allocs and frees 
focus on a selection of large memory sections.

This is rougly equivalent to a per cpu page (folio?) in SLUB where cache 
hot objects can be served from a single memory section and also freed back 
without too much interaction with higher level more expensive components 
of the allocator.

