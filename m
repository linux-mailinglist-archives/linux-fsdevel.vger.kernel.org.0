Return-Path: <linux-fsdevel+bounces-16431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A670889D65F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608002819A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F381ABE;
	Tue,  9 Apr 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSSLhcB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCE1E89D;
	Tue,  9 Apr 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657463; cv=none; b=dKtmhjrgOEKk94dmQsmpkvsRQu9/zEy/WDeO9dh7d/BNkvNfpFUtmobMvfr70pZD+GdxGaLFOiXbN8ZpYR+dl2LDYNwU/2T8ZujI1khTSypmSdMK9gZ2CIraPjJdp0XkvDyz1r80n7lunW7jzlzltQsKp2b5E8byDdCMNu+3p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657463; c=relaxed/simple;
	bh=PEWOZXQjdfAMZp2Rg7dsCexBjTtJ/VYS56bP2lSsKBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6ax48yr8CpmoUQEEqGlNyu0ZrVbx02PdHi2G61oy9xMXNVxkzBL4NMgFTr4ykdi2N9xNu9iC4yF32nai4fx4XM72sqvy/5idAfNd1srtJhSJ/9+aaTJ6FsERtfAgbYZE9Wzq9BfPoZP/PfEB1/thpu4iPu8Wj+O4RptGbR5x+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSSLhcB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A04C433F1;
	Tue,  9 Apr 2024 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712657462;
	bh=PEWOZXQjdfAMZp2Rg7dsCexBjTtJ/VYS56bP2lSsKBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSSLhcB1vuFhLuBYg82dueqUzgeKNUesajJuPFEGXZo+Vq8cnQcEdPRyQWZjHFYxz
	 lr5jQ1LWqKsRTm9l8mHLKpVKtZtnYcwJ7wH+UKBfXC5WPDpBdWq52sIAidIY7o2CKh
	 PMIu84kRw1GSaRW+vUuKGb7cXfttm2gK+5l/Z4ywufK4Zh+uPlAl/WxnYBE2xQtwQU
	 Gp7b6hKAWH5TM+IA6ZEGIzVSRLbd64TSVoCeGgoJ6WcT+oTa2n4R1r9bXPvYxmfzOs
	 Wu6F0AdaTFPxeeiv1q9sxu0w8dVWP4W1zGx3pV6poGg2LXtW51cir9SXiJsq+ETebX
	 2yB/KmIaKqQ+g==
Date: Tue, 9 Apr 2024 12:10:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] tools/include: Sync uapi/linux/fs.h with the kernel
 sources
Message-ID: <20240409-unbezahlbar-erzwungen-a815739eb854@brauner>
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <20240408185520.1550865-3-namhyung@kernel.org>
 <20240409100439.mal6tpxdvhphoyrp@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409100439.mal6tpxdvhphoyrp@quack3>

On Tue, Apr 09, 2024 at 12:04:39PM +0200, Jan Kara wrote:
> On Mon 08-04-24 11:55:13, Namhyung Kim wrote:
> > To pick up the changes from:
> > 
> >   41bcbe59c3b3f ("fs: FS_IOC_GETUUID")
> >   ae8c511757304 ("fs: add FS_IOC_GETFSSYSFSPATH")
> >   73fa7547c70b3 ("vfs: add RWF_NOAPPEND flag for pwritev2")
> > 
> > This should be used to beautify fs syscall arguments and it addresses
> > these tools/perf build warnings:
> > 
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Makes sense. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Christian Brauner <brauner@kernel.org>

