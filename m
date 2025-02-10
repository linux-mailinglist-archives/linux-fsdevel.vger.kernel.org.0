Return-Path: <linux-fsdevel+bounces-41363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685FA2E3CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB64E3A59DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60F17CA12;
	Mon, 10 Feb 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GtwUm8RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DA2F2E;
	Mon, 10 Feb 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739166828; cv=none; b=bDtc9N1ACYSaGV+0vBvUnnoNsYBwcVaxebJ1Xptg8wdONEFUlThAJ6B5PaWi7NgSucNkkcV5F6xBdqTc4qOfVwuMvuxuCuExbn5ChU2xBFsZ+iUgbwcYz/WoI5KCcM8YFGbVPnTggTMfd/slewovLCUp/IHj20/lSWDEhKO1pws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739166828; c=relaxed/simple;
	bh=8dp3yp+chNrfH+5YEymmAyuzInspRrSxObIGPMzAqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzum3L++1T3rozvdVp971CY+HIGUUaq93wI5+w9YDZLTeEtW0jyw9KBilCOY3xvjo9wjYXwb67Tgb8q85Y0kRqeth59B/Out5QVg96/RTJbLwzwqnDULTkyZBhGHVYHGyV1TLcC8ucSHyZNyNL/6AmsVxcoFJu162BiqolcsrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GtwUm8RX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=84y4QeGazzPnxyheSUGC6dxlwC9g9ggxs1w9zCAEAdk=; b=GtwUm8RXNR9zfA3Ii6m++D/Hq/
	jzj09yeu0o+wuk5zzktvH/89LX/Gb+WkqCRmQ1s8jcV2p281t+bnucxwsm5F8NQpZuvfWV8pmpPVv
	qRAs6wU50Z50+Ua8U+jL/Z8fkKK6bBKsWJkQL6gq7/f2MbZUCu1xxmOekOuYMxTjc1cO8vTFdFR20
	ASru4qTnFRJAIY4l6BAmA21wVopLyliPDWEM97V07PUqll5pwAbkbAMv9vV/GjwbqxcIAy6wfbHly
	Ei8inWO6FRDcqO8TKqOnSkPqEQ8LSR7mSTxkwYHp74th3vHiVxFnjh/o2kALRVkzJeJT0lG4JHebz
	xoEvWhkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thMjl-000000094XM-11C4;
	Mon, 10 Feb 2025 05:53:41 +0000
Date: Mon, 10 Feb 2025 05:53:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle in
 debugfs API
Message-ID: <20250210055341.GZ1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 09, 2025 at 09:20:20PM -0800, David Reaver wrote:
> Overview
> ========
> 
> This patch series replaces raw dentry pointers in the debugfs API with
> an opaque wrapper struct:
> 
> 	struct debugfs_node {
> 		struct dentry dentry;
> 	};
> 
> Intermediate commits rely on "#define debugfs_node dentry" to migrate
> debugfs users without breaking the build. The final commit introduces
> the struct and updates debugfs internals accordingly.
> 
> Why an RFC?
> ===========
> 
> This is a large change, and I expect a few iterations -- unless this
> entire approach is NACKed of course :) Any advice is appreciated, and
> I'm particularly looking for feedback on the following:

Do not embed struct dentry into anything else.

Do not take over its lifetime rules.

For the record:

	Anything of that sort is going to be vetoed.

