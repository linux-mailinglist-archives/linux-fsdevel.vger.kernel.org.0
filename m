Return-Path: <linux-fsdevel+bounces-24572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A9940790
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876A11F20FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8411A16133E;
	Tue, 30 Jul 2024 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rRvodZJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13E16B75F;
	Tue, 30 Jul 2024 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316638; cv=none; b=pUsZqZ3CfiL9RVHIC1QbZnqm0u67lTcj2cGy5VS8OQ4e4TsWO0SF4JU2XYQy3Hy4p7H+5h64paYPsQirleylLZz3xkEdSfuVu6qYVrs4rfDtn5gViGOHpBASKmcPfOvf4mm6NE7W6pHLigJP7DUBdT4Nku/7HXFmXAHLKVUMlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316638; c=relaxed/simple;
	bh=fAjU5WaInR7mVp0QWF3slEMwYNZL3ZGJFUtUuhAOWfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O17HgUkUYhbcNB0D/DJjK/NryYbBPZplbP2JbpDW8zoQVC7DzC2zFSP3cbmYHUnDEgxl9gPc1DVwRJZKTwI8pYOoogaUzdGJghxYqN6EPXXujjoDRm5U2ePLfcFgr/xt5kNNBRXVY5r8WVFK1ctD1FQG/viXYmwDZeRmuORtmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rRvodZJw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKdfCBkzmGHE+z6MbstBXoi5ul1FqYJjo5minGhId28=; b=rRvodZJwyDyhKnvQG9W0bbAbN9
	xm3Rynw0zVfTv8gH33vlJvwIbNSXG1DG6Xd/OQPM+ECERMpluwEHrSatEAoHTlzrYqLtB9prMkkGk
	cy4INOvDdlpq55l4oWu8OsphRDqzBgaBIc+cgIcfgGT8y1VJVPLvdIfk1PjqfoAsI/bRvmyAej92D
	k7efNUxJE9U6jN3x8dsIcBXc4lD3Md3J19Es/A+0Hj0/A7J9LJx9IQGp7fHCTgD2ds+3fdR3VZpql
	SzbW45HKc+7ZM4VWjMgR2NVf/m3BZX1Wp3Yj512BL/UKskUIvvCxzVSOt2X64RflXONFPGqGZXte/
	MgmD+JvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYfEZ-000000009US-02Oa;
	Tue, 30 Jul 2024 05:17:15 +0000
Date: Tue, 30 Jul 2024 06:17:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240730051714.GD5334@ZenIV>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:
 
> Individual patches in followups; it definitely needs review and testing.

... followups sent via kernel.org account, due to git-send-email missing
on zeniv at the moment ;-/

