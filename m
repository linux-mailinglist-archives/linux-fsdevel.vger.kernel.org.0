Return-Path: <linux-fsdevel+bounces-47615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C449AA12A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837FA188AE3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C95024E4C4;
	Tue, 29 Apr 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcKV1ohs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54053221DA7;
	Tue, 29 Apr 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945640; cv=none; b=KHDcKYMS+96Wbhvyk003hfND/pi17H7rbOKcqUDxcS0HBb6i++FNjHcKF+g6ggD/GLLfLkSRVWTD1PIYpr1rG6cIKz61pctyO3f5qagmDA9p17Uys68Cj0Agle+F09aRz8q1Qs6I57LiRYRbea38D9IHZzgS8K/y/7IMavmtOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945640; c=relaxed/simple;
	bh=5RJO3uiAH1dTPxWEzb5m8V+Y2lqOnzCa86KySLOdzbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIV4B/i617K4XULHR8ta14z1mCrB6vE3/4eAn9/5BiHjkRIQdnRH0hL+VB7HBn6tz8WInE+BlsCsvb8JAyaHBUNZDX4OsSjkOwCkvYtoBgDsmd4iAy8RzmfkS5Geq7j2RUo5OCrbLix4ZvVDHkbuL4VWoUqTCdMBNxqHT7X9wBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcKV1ohs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F553C4CEE3;
	Tue, 29 Apr 2025 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945640;
	bh=5RJO3uiAH1dTPxWEzb5m8V+Y2lqOnzCa86KySLOdzbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcKV1ohsGwxmF70tNP3aPhc8lKT3edJ3ES1uM32qXcH2EOduPFu1cAiHltG0DSPzy
	 5+N5jYm8EBGIJIzsvjh4qLoZ8JYAjAqyxHDpkTHXIZDQP2kVd2OxrCzahgejBGUt8q
	 ijbUIJUZRh0cAsbQ8iSvNwq2Iq2msZBlUtLbpyqMgKKrf7zuSa71HtCe/h8QnvRFqM
	 qKISiBXSav1WhxZgAuJCqaITIeeJu9Ta6cnTmREv7AK3VFkAGGjbmcyyn4EVrqVoo3
	 aaobg3vS2YEZQ3Z/pLI9quBdSkEcOH32KbwKEXLoBb5h9gV6+vgt7uzEajhul+9829
	 UNAxCaFkA8r3g==
Date: Tue, 29 Apr 2025 09:53:56 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm
 VMA functionality
Message-ID: <202504290953.70A8F99@keescook>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>

On Mon, Apr 28, 2025 at 04:28:14PM +0100, Lorenzo Stoakes wrote:
> There is functionality that overlaps the exec and memory mapping
> subsystems. While it properly belongs in mm, it is important that exec
> maintainers maintain oversight of this functionality correctly.
> 
> We can establish both goals by adding a new mm/vma_exec.c file which
> contains these 'glue' functions, and have fs/exec.c import them.
> 
> As a part of this change, to ensure that proper oversight is achieved, add
> the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections.
> 
> scripts/get_maintainer.pl can correctly handle files in multiple entries
> and this neatly handles the cross-over.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

(I realize I didn't actually send tags...)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

