Return-Path: <linux-fsdevel+bounces-22917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1691F05A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 09:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837941F23466
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1E148841;
	Tue,  2 Jul 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GCBLdFrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465744CB23;
	Tue,  2 Jul 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905876; cv=none; b=W6wg9moEUN1R95TjERWcw/pXdnkLbfVI+EATzZV+auLbFu3aq6Xcx1zw0UeIET0bNfk7Sjm933pHv4a0o03lXs0umM4F7Yt052NVKvHV5CsUxCD2rp2J5Zej0KvIHkd7XQBDWc6YuU2l0Nq38u0hjzPhyfzGDvVxUsJnlwN0uIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905876; c=relaxed/simple;
	bh=2VYDxOt/ANNEhf8pUSMHmU8uQwhxTzHw4bbej7YnNQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpN4Tc6FSFKq2h40U5YAA1r5V8GZwxAVDMTK7k2suZ107bocAxi8yni0bg90brOZJ1T/4d8yMcGw+KnYZz8QRf5Rup7EqDynhW6/ApP8LD1eeifbwhQVlA0f9YzJzfyvNHTjePfFupm4/SFnjMmRiiDPdFIhhlBt3PopjO/YJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GCBLdFrj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rxGl+63oN1WDMSTt3tuoEFowmTF6ElvlJY4+FmesakA=; b=GCBLdFrjfKQdOXAbJDYAUldMcU
	DSmkwndO1FhRCRFEv30KICrnRNwrFf9kJcEYMqhwqQDtLGuTCsv/XKs1i4qYzbEK4bDB//29ZIl/Z
	TyUMsccI/iUY5NQUTOrNNQZM0hhSV+5kkoK79H8Po0NcbQPcICCM3GQwh25NRLhmhXCICDRSuyiPq
	wrFue8viWQOTqL+Fg5JPI4ghXP1YvSA80e3qc0eztth2PFfU/1m0gidDEYPN+n80rPsZURhP7EL1V
	ZfShbVBnFGywltDR18+pzXwEuIrHk/UYIUMD5W1zc+qOJRqd8wAWe5dbAhyAv/2NL90AXPEqVJLQ0
	Xb2L/HoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOY5D-00000005sux-1EZd;
	Tue, 02 Jul 2024 07:37:47 +0000
Date: Tue, 2 Jul 2024 00:37:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <ZoOuSxRlvEQ5rOqn@infradead.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
 <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 01, 2024 at 08:22:07PM -0400, Jeff Layton wrote:
> 2) the filesystem has been altered (fuzzing? deliberate doctoring?).
> 
> None of these seem like legitimate use cases so I'm arguing that we
> shouldn't worry about them.

Not worry seems like the wrong answer here.  Either we decide they
are legitimate enough and we preserve them, or we decide they are
bogus and refuse reading the inode.  But we'll need to consciously
deal with the case.


