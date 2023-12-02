Return-Path: <linux-fsdevel+bounces-4695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA25B801F0B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6CB20AA8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05809224C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L00IxRP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1BE5;
	Sat,  2 Dec 2023 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mzmbYFT6eXgeUvFzA1AjZh/++WkproRxrIlBwE1gCY0=; b=L00IxRP0LYY+aPJJMHp1lU47ZA
	J176Pu7GbGT10FCC346cVLmX3g4rokO0HR8qfU7qotr7mZRJxwPbvsTyIGYtKqUjjY6C63yY4Jke0
	Yytq/fZRQsrgejmnx9MZDzaUzJuZ/SkWZ44LwDPyeWhEtGySoc/T/EWn8uCH2HvyFGjz/SsJqXTlJ
	51L/vgsBow83BFz5+SBn8AQpHa5PE31NM3JiuftoaVkYrOsK5SZaA0uqdoMDGhFkSs68EWHG5IjDI
	Ja6wcomXEuo3azj/d/V5rZFelUc41t3Vfy9vL5qf5O6FOnJPAmn7dTkYCjhlcQD8ft6zLjVDRmTp8
	ACZNl36A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r9XXa-006Nv1-0M;
	Sat, 02 Dec 2023 21:28:46 +0000
Date: Sat, 2 Dec 2023 21:28:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231202212846.GQ38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212217.243710-3-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 02, 2023 at 01:22:13PM -0800, Kees Cook wrote:
> Allow __free(iput) markings for easier cleanup on inode allocations.

NAK.  That's a bloody awful idea for that particular data type, since
	1) ERR_PTR(...) is not uncommon and passing it to iput() is a bug.
	2) the common pattern is to have reference-consuming primitives,
with failure exits normally *not* having to do iput() at all.

Please, don't.

