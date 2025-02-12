Return-Path: <linux-fsdevel+bounces-41580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5DFA325E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628AE166A1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2720C487;
	Wed, 12 Feb 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="M6EO4GmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7E1F866A;
	Wed, 12 Feb 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363780; cv=none; b=aC5qVmqPP9MNOFxqC1tVzmyVc5/KwlYJ73AWTqNfdRzPamx+Lu25Q7wh5jskgP3d8c89PcRmHbWarBTrMS5GOj0pRWim0qPnG9Tkif6v30Jl/sdPe6mCTYSGU01+ewqnqdVlToXupnHcJbeoiE5RnrjhRO/t8iXWrutGEJ8FQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363780; c=relaxed/simple;
	bh=t1Gi8u5fl8LKlaMA00fx6gX/vB+eQd/c1cEcv1qySpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew/XH67WmPVqVLpnaSjAqRqOswDqcSRjcQ/ej2RA+0rut07DaSsB/MJjOk1i0wJDdt5ZhzyvY/dgbpFxrK5Fr9LQHusMls/znl2j2FgPSnvpcDriP5h5f4YFP0DB3kIVO8YmWr3iBaoRvo2iIkJCQBB8yjBuU1r9WEJERLFjf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=M6EO4GmV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l4QNsOu5d8tr1TxoA52BG3z/YkO4QivARC/+iso/bls=; b=M6EO4GmVC2g9oSgEAoFmeFIMxw
	VhCqf09VUC4o9/bmcEr+Rv29+0GbbaRkL1rLxtotP3i/GhN+/yczUXYlUlg/pHfTMwKYm5uCvPjfh
	VFa+quxuDWfLiZMnExUgbw1hTRbfaFZmtLDkT0lg9qLkRJBYfv82bhoaRldVUjp8z8EtkSBWZ6e/I
	3kScNuLOawQo01XvdnUtM49t8AvaK3ocU/NjfbZLFwWE/WEWAvFAaL16Klk/U70BZufT3GON63efr
	TWdcVxNC8XjOE2p+igQWuHhApS5QBi8eV5tPWpgFXyIz+32cVpBtT7/6xImi64LdlAMoLxfH23Bkv
	BNu15iLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiByL-0000000Bduh-1SFO;
	Wed, 12 Feb 2025 12:36:09 +0000
Date: Wed, 12 Feb 2025 12:36:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Use str_yes_no() helper in proc_pid_ksm_stat()
Message-ID: <20250212123609.GP1977892@ZenIV>
References: <20250212115954.111652-2-thorsten.blum@linux.dev>
 <20250212120451.GO1977892@ZenIV>
 <220DFA78-0A12-4F46-B778-B331A7F2841A@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220DFA78-0A12-4F46-B778-B331A7F2841A@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 01:11:08PM +0100, Thorsten Blum wrote:
> /*
>  * Here provide a series of helpers in the str_$TRUE_$FALSE format (you can
>  * also expand some helpers as needed), where $TRUE and $FALSE are their
>  * corresponding literal strings. These helpers can be used in the printing
>  * and also in other places where constant strings are required. Using these
>  * helpers offers the following benefits:
>  *  1) Reducing the hardcoding of strings, which makes the code more elegant
>  *     through these simple literal-meaning helpers.
>  *  2) Unifying the output, which prevents the same string from being printed
>  *     in various forms, such as enable/disable, enabled/disabled, en/dis.
>  *  3) Deduping by the linker, which results in a smaller binary file.
>  */

Printf modifiers would've covered all of that, though...

The thing is, <expr> ? "yes" : "no" is visually easier to distinguish than
str_yes_no(<expr>), especially when expression itself is a function call, etc.
So I'd question elegance, actually...

