Return-Path: <linux-fsdevel+bounces-53986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6640AF9B7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 22:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3628B4A4230
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E322FF2E;
	Fri,  4 Jul 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z//DoQLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B72147F5;
	Fri,  4 Jul 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751659904; cv=none; b=TxRGAywH2+JGPhxRRfRYfyyOC1pVlOjCff7Xlhxe5zBR+OXQD7DmZffP8Xh8AeN4QSBvW3iuOcCH5fVX7VmlSvXmK+wz+fdXODV8z4TJ/hiIXT+9N2ARXR7PXSBl4HLWeSvl2JjsPOyd4kBo2E/L1Mxg03SZwP1+Dp6i4XgFFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751659904; c=relaxed/simple;
	bh=2PAoa0MKK1+xtzhOz4VJuro5NHJ+r4nGEvFdt7lZ9Lo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lTezhzcJ5QQYWK6aOISVZ6hTttCrBMP6jD0vGL7B5VKhqk9dA+RUhn817k/54jku9jq4PExMOc1PFXPJwUJgpINQ38h1nwm8q5geih6O/ycITtEPszYF1gIakTHxqZksEY5VWCypWm8ZBUhE6w3CXf2PSZGC+TNyxd5OpWE4Y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z//DoQLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F07C4CEE3;
	Fri,  4 Jul 2025 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751659904;
	bh=2PAoa0MKK1+xtzhOz4VJuro5NHJ+r4nGEvFdt7lZ9Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z//DoQLTAZ6NEOaXcB2/HH5KQRCvobbpiSfq20qIjYykrW8XlQtXwW9GED6rwQDGB
	 Y/gQK1O7j3B46o2u77/2KeQ7zrGYb7oHlSlw+Prli8t9rtQqacKxKAASIp9ptLOBfR
	 vXaMR4gT8Wuz6cyYBVaGa2SVlpLeP46HbuS2qz58=
Date: Fri, 4 Jul 2025 13:11:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Michal Hocko <mhocko@suse.com>, david@redhat.com,
 shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 donettom@linux.ibm.com, aboorvad@linux.ibm.com, sj@kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
Message-Id: <20250704131142.54d2bf06d554c9000e2d0c00@linux-foundation.org>
In-Reply-To: <34be0c05-a805-4173-b8bd-8245b5eb0df8@redhat.com>
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
	<87bjqx4h82.fsf@gmail.com>
	<aEaOzpQElnG2I3Tz@tiehlicka>
	<890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
	<87a56h48ow.fsf@gmail.com>
	<4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
	<06d9981e-4a4a-4b99-9418-9dec0a3420e8@suse.cz>
	<20250609171758.afc946b81451e1ad5a8ce027@linux-foundation.org>
	<34be0c05-a805-4173-b8bd-8245b5eb0df8@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 14:22:11 -0400 Luiz Capitulino <luizcap@redhat.com> wrote:

> > The patch is simple enough.  I'll add fixes:f1a7941243c1 and cc:stable
> > and, as the problem has been there for years, I'll leave the patch in
> > mm-unstable so it will eventually get into LTS, in a well tested state.
> 
> Andrew, are you considering submitting this patch for 6.16? I think
> we should, it does look like a regression for larger systems built
> with 64k base page size.

I wasn't planning on 6.16-rcX because it's been there for years but
sure, I moved it into the mm-hotfixes pile so it'll go Linuswards next
week.

> On comparing a very simple app which just allocates & touches some
> memory against v6.1 (which doesn't have f1a7941243c1) and latest
> Linus tree (4c06e63b9203) I can see that on latest Linus tree the
> values for VmRSS, RssAnon and RssFile from /proc/self/status are
> all zeroes while they do report values on v6.1 and a Linus tree
> with this patch.

Cool, I'll paste this para into the changelog to help people link this
patch with wrong behavior which they are observing.



