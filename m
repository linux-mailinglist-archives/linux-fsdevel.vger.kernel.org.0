Return-Path: <linux-fsdevel+bounces-16875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D18A3FC1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 02:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7949F1F214F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1136322A;
	Sun, 14 Apr 2024 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gMW+j/eE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3217F8
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713054298; cv=none; b=UgU0Iw5PBqpqJ1MwhAA6iLRjbA5blu7xE5FrMTMo31P5T3I3NK3K9dfvb4RuBetKuIjxuzvm7c1P3HQwi0GYHDWlr1lfnRQiREvjTvvBSSBRUFCJE22OWuOeR0U4Dun2Bo5NvkdORYMIL9I4yNbxL4g61wjxlQMIuwXyxzEHJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713054298; c=relaxed/simple;
	bh=6cwz7sq9/Ry/X3YPf1XJMdD/vYMuqKwjtDLDys1bQog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYYVO1m1S1ANuZZANbktRu3x5SET1/QwN9eSzoQ8WhJzPKW6P+oSn2pHqEoqiaYiDBcBNGMOiVnHtm5GNTJzg30nXnwp6GoeU8VQbxtgVGASZam4ow3s7MbUP0XZ0Trom7Er2lm0afwbMZKF7NQVXgXfluQ7RLlIa2Qz5kjtvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gMW+j/eE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43E0OBpU010410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 20:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713054255; bh=qb/AK26peA9M1+LO1ejrXo5H1qOcrwEngc2lVcRQn9M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gMW+j/eEZZ227dKTw8qgb3SuQZg06xUa58esbWcXoX8dpUZB1en0reXXGStK9DAcq
	 2NGcjQX+f5Uxytao5c/IPST/8CAmKWJQ8J6giqwWVbMycz+Bs3AkizauEhbKqhSYdN
	 DxSIOVCkhv9XEe+HuIh81hyJ1XtcdtxK9wOdZWilsJ1GPXStJy9yi4B33K7Ic86xFj
	 n7WqCj8j1P4UC/ednNZ22PYaGCw73K4CnGamuueyD9KjtGgqHil7hhIblz97bVYW+d
	 0Ys+GZuvSoQtAVvgck4WiGfLlErZ9Tm9PdwdNLSM9aBxKsUrVPpzmw+NIFnS5NBnw5
	 ycfENAmksYO9A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 611C115C0CB5; Sat, 13 Apr 2024 20:24:11 -0400 (EDT)
Date: Sat, 13 Apr 2024 20:24:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nam Cao <namcao@linutronix.de>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        Conor Dooley <conor@kernel.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240414002411.GG187181@mit.edu>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413164318.7260c5ef@namcao>

On Sat, Apr 13, 2024 at 04:43:18PM +0200, Nam Cao wrote:
> 
> I have zero knowledge about file system, but I think it's an integer
> overflow problem. The calculation of "dlimit" overflow and dlimit wraps
> around, this leads to wrong comparison later on.
> 
> I guess that explains why your bisect and Conor's bisect results are
> strange: the bug has been here for quite some time, but it only appears
> when "dlimit" happens to overflow.

So the problem with that theory is that for that to be the case
buf_size would have to be invalid, and it's unclear how could have
happened.  We can try to test that theory by putting something like
this at the beginning of ext4_search_dir():

	if (buf_size < 0 || buf_size > dir->i_sb->s_blocksize) {
		/* should never happen */
		EXT4_ERROR_INODE(dir, "insane buf_size %d", buf_size);
		WARN_ON(1)
		return -EFSCORRUPTED;
	}

Just to confirm, this file system is not one that has been fuzzed or
is being dynamically modified while mounted, right?  Even if that were
the case, looking at the stack trace, I don't see how this could have
happened.  (I could imagine some scenario involving inline directoreis
and fuzzed or dynamically modified file systems might be a potential
problem=, or at least one that involve much more careful; code review,
since that code is not as battle tested as other parts of ext4; but
the stack trace reported at the beginning of this thread doesn't seem
to indicate that inline directories were involved.)

   	    	 		    - Ted

