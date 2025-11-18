Return-Path: <linux-fsdevel+bounces-68999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393BC6B005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E70602C110
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463833C1AD;
	Tue, 18 Nov 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fxn7giCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B135FF5D;
	Tue, 18 Nov 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487233; cv=none; b=L5C2AOpODPSNp7OCzmY7Z+hbDcfR3SeB5uq6FQ02gWwGgQS6apR7N65IkiA2zM2QPySrRj2KlEuu0wmdKtHc/lSB1QHEKyQkb3ApoOsG7R5Twb+XubaaEcmvqnxoNABpuVRJGdef4WNXH5g9g1xZ5ctO0TVg9fIGme0JuGzzW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487233; c=relaxed/simple;
	bh=lMCMay4OPV+EPmMwOUTyyXs4Bv2SJ+rfqLlyshkGMVk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kmhxMENE8ODGS3d9d1gK8/5HWoiqFltXzGrTFFHcLCKZE9tbj3/RAbDHg9Z59eaVTWFExuYm+vPNXZ1FbaGznWQRSaisRxs3nmZWEWaBBjJ9MpQzkucCsI+y50wKUfLf1ZuelaM+mnpmzWSnJoPspot9iCd4iG7x57NycV3hBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fxn7giCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62976C4AF12;
	Tue, 18 Nov 2025 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763487231;
	bh=lMCMay4OPV+EPmMwOUTyyXs4Bv2SJ+rfqLlyshkGMVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxn7giCzujVYHabc0Viil4nTOhRJkJImVxhMvBoYAZm8UMdE8WkL0IEmq48z8t4q/
	 2L2usb0jNNPAQ+9QHlFn7d61iFAcqDEi0YpMl75gJrIP88ywm+ohXHafRwoO1KPuzV
	 5JyBNmd4VcM+XKpcGhTJV6aTZoOgXDRyNa8YOa2A=
Date: Tue, 18 Nov 2025 09:33:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Andrei
 Vagin <avagin@gmail.com>
Subject: Re: [PATCH v4 0/9] introduce VM_MAYBE_GUARD and make it sticky
Message-Id: <20251118093348.9dac5d7142dc6df182833612@linux-foundation.org>
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 10:17:42 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Currently, guard regions are not visible to users except through
> /proc/$pid/pagemap, with no explicit visibility at the VMA level.
> 
> This makes the feature less useful, as it isn't entirely apparent which
> VMAs may have these entries present, especially when performing actions
> which walk through memory regions such as those performed by CRIU.
> 
> This series addresses this issue by introducing the VM_MAYBE_GUARD flag
> which fulfils this role, updating the smaps logic to display an entry for
> these.

I updated mm-unstable to this version.

