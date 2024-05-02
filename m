Return-Path: <linux-fsdevel+bounces-18526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E978BA25D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920DEB216AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 21:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3921BF6F7;
	Thu,  2 May 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kMWDdPq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC91BED6F;
	Thu,  2 May 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685720; cv=none; b=ag34cZBiN5rrRzOlmGN1srFSPoFVIFBu9lFGvx8JR1FeH3tQXyOTKVy0Cxf3MXdEOZWwJIJsAQ9SSb29OMSfaJ43jolQ3xhzp3PiszXmPjNu18hA/5Pv+lLW8Dtept+73XIaKJzmXuFhrVNCMvIAJE/1T9vwDG8QSqfbBFBjc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685720; c=relaxed/simple;
	bh=dGVoI4d4tynFDPGLs6MfTg5m6n3+0kLY1UaKnKdA55k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLiY2PaJK2t49eht7pOXyWw+APGIriJXTj5psje/+pZiSZaw1evOhjgzGYSidp4BYm39PvTuBnhhdmHckBOQ1K3X2vmxdLFeXHFDXFhkf37xyKbFdWqu1K81pReEMf7zPj/v3LCgGficPspnDLRmRvrTgkuw+08rkW95r8uLrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kMWDdPq6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tlFW8nHNMe/kIplt0cgGnakBNynrklQOcrWEc7IQ7x4=; b=kMWDdPq6vs1CUwS+IRPUbgpLoA
	IC8dWLw6FaCljPdIJWTkh4MImGo5Ty2XG0jnQ8eMOHqj4i6byL8Sstn/I4JOXliEjY5jvCvoKaXl5
	3HNrPT8//2gKQfyGPO+EdzOS84mlIe4MG55TupkdB6W/+SMQsanlE73aXBjYgUvUyd6BkYHL91/PC
	3M4qdcaMnIyXnnb1dGoniT1IqGRPS3wXcU353S1r/zt8TQAKllsLUF25JhzlqPgToXZl+ifv9vhfn
	IMfo4YL3OH/6ADo5OwtaFfxrA0OzfbMUc5ufFQ+yul6Cvb1v5xzR0CiEPQC4UOXdXQKpsEZhZfqOc
	fBEUzOmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2e5C-0000000DzCy-2lmy;
	Thu, 02 May 2024 21:35:14 +0000
Date: Thu, 2 May 2024 14:35:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Allen Pais <apais@linux.microsoft.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, j.granados@samsung.com
Subject: Re: [PATCH v2] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <ZjQHEpRW7q686kU7@bombadil.infradead.org>
References: <20240502145920.5011-1-apais@linux.microsoft.com>
 <202405021045.360F5313EA@keescook>
 <CAOMdWSJzXiqB5tusdKaavJFTaKC-qyArT0ssRHVY-fvZVKJW+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSJzXiqB5tusdKaavJFTaKC-qyArT0ssRHVY-fvZVKJW+Q@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, May 02, 2024 at 01:03:52PM -0700, Allen wrote:
> +int proc_core_file_note_size_max(struct ctl_table *table, int write,
> void __user *buffer, size_t *lenp, loff_t *ppos) {
> +    int error = proc_douintvec(table, write, buffer, lenp, ppos);
> +    if (write && (core_file_note_size_max < MAX_FILE_NOTE_SIZE ||
> core_file_note_size_max > MAX_ALLOWED_NOTE_SIZE))
> +        core_file_note_size_max = MAX_FILE_NOTE_SIZE;  // Revert to
> default if out of bounds
> +    return error;
> +}

There's already a proc helper which let's you set min / max.

  Luis

