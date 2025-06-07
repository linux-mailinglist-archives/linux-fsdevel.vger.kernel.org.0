Return-Path: <linux-fsdevel+bounces-50916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03AAD0FE2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 23:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2813A3AE53A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF31FDE01;
	Sat,  7 Jun 2025 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EvkcaoAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EF2F3E;
	Sat,  7 Jun 2025 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749331139; cv=none; b=LTWb3qMrJu6jLD8xz0ewqANdbm4eSu5LNeUCJOF6qrXFH33FybHCvvCqpk9TGE2P6x4XwEWgt52fk/ba/wXV7+Zw1lGOdCa+DvoYgFnxsBaL2AKbUTfh5AGbmFg43fVNOrQ5WmAoEjrUmgz443SmzINcmvSaBkOSzZF33Hh/Nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749331139; c=relaxed/simple;
	bh=Ixnjtv1hB/d+WRPLJvFfd0QaRHpleKtKLErTDOVBRls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CqRS7JmkfVTxv67wEe4EiM8WbpFLKPD8IObThzgcrz+YX6FyoLW8miYq2MoUdXrAb9WH16hKuKQzc9uOZf4XdBVl6ss7rfsKj7p63euvywneiarHG11J0nXtCBSujSwYOT33WDS7K6KJod/apOgOwnD1kyu13g0xgNd4mBRvcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EvkcaoAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4889C4CEF0;
	Sat,  7 Jun 2025 21:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749331138;
	bh=Ixnjtv1hB/d+WRPLJvFfd0QaRHpleKtKLErTDOVBRls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvkcaoAps5D/RSYz1MLgxk0SGCtHmco6FMBWLuMroLOXtHB4UUL11Wq4l95Iw3ess
	 vthZ48Fwg4Pvrr7mbIAwCTOSkowQqcVTDGqsmLLJoOaw70VysLyDgR53o/zH/1ZsGP
	 EFPyirgyAf3KcgqQZzlm9HRIvzbVvqIStV7SFwrY=
Date: Sat, 7 Jun 2025 14:18:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wangfushuai <wangfushuai@baidu.com>
Cc: <david@redhat.com>, <andrii@kernel.org>, <osalvador@suse.de>,
 <Liam.Howlett@Oracle.com>, <christophe.leroy@csgroup.eu>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] /proc/pid/smaps: add mo info for vma in NOMMU system
Message-Id: <20250607141857.40b912e164b8211b6d62eafd@linux-foundation.org>
In-Reply-To: <20250607165335.87054-1-wangfushuai@baidu.com>
References: <20250607165335.87054-1-wangfushuai@baidu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Jun 2025 00:53:35 +0800 wangfushuai <wangfushuai@baidu.com> wrote:

> Add mo in /proc/[pid]/smaps to indicate vma is marked VM_MAYOVERLAY,
> which means the file mapping may overlay in NOMMU system.
>
> ...
>
> Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")

In what sense does this "fix" b6b7a8faf05c?  Which, after all, said "no
functional change intended".

It does appear to be an improvement to the NOMMU user interface. 
However it is non-backward-compatible - perhaps there's existing
userspace which is looking for "um" and which now needs to be changed
to look for "mo".

We could prevent this by continiing to show "um" on CONFIG_MMU and
additionally showing the new "mo".  If we do this, let's have a code
comment in show_smap_vma_flags() explaining why the code is this way.

