Return-Path: <linux-fsdevel+bounces-18206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718A8B6830
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE9A1F219B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4612E47;
	Tue, 30 Apr 2024 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Scw+1QMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18C10A3F;
	Tue, 30 Apr 2024 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446695; cv=none; b=FmnhnRgzp/IrL0uheqT314nKMuEM1RS6GJkOwVwKeY0PP/FgSzDv/x9AYCh/n2bm5ZMjOhA4K/Nf2ckAUHVfaVRsLa0jTJ9dz50IduDULrtCcRio6pirbjMCbF9gUw+YiqqBbbwmaRzDl8klNtOSpTqOAtsyf0co8irq0TowVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446695; c=relaxed/simple;
	bh=A8QF0hCv/rRDWvm7PRNjr6csL2b1LpGRZeV48g0jPps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XproKQsH9srAbUc67KtVAUZlJFM3AcypFOzZ2nc7TsY+AXfj3wQCK1uZd4Bp7xdKZB5WSYlDjXlyModwfgYwJA6MHNVZXBq3+ZzAAbzhiUQg3RCfr+37JjRmNs71hWF8Qs8iQ6a/qHltbtnOp50CaHeAbYkYJVGoacdoWHvMpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Scw+1QMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079ECC4AF1C;
	Tue, 30 Apr 2024 03:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714446695;
	bh=A8QF0hCv/rRDWvm7PRNjr6csL2b1LpGRZeV48g0jPps=;
	h=Date:From:To:Cc:Subject:From;
	b=Scw+1QMolGFEJkNC/RBOzE+eTC3kc/tDNlwztUZm1AS7Fqv53Ct+ZwatPZNeV6SC2
	 UKZyN+mOJ1MSc+pULck0nIX0b3cmzprG5A7oSBo32E/bqXTINZeL4MFtuuxM4dIY9i
	 LnPIjsol+9ain0Z73IRfL4tHKfPXMdo6xapwn1qtnJ97jVkhyA5SifMhCkL+bccSiE
	 9qPihle51fhcdIJVYLBK7iHgwsEhUaImJKAGf0TXB3pL9i5z6UB+D5DiTjpTcrMx1R
	 VNGscqOkQ72ow2Pkrq7Mjnym9S3hXo91FxcyccP2Q7gXJNcf7gLsiTQ1N4Pk92Ahqx
	 7pFAlr37Z3o8w==
Date: Mon, 29 Apr 2024 20:11:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCHBOMB v5.6] fs-verity support for XFS
Message-ID: <20240430031134.GH360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

Another month has gone by, so here's another RFC of fsverity support for
XFS.  I'm going to take off for a bit of R&R the week before and after
LSFMM, so I wanted to blast this out for everyone's enjoyment. ;)

I /think/ I've addressed Eric's feedback about the v5.5 patchset.  The
merkle tree cache has been moved to a per-AG rhashtable; XFS now uses
only a u64 merkle tree pos value in the merkle_read/drop paths to match
the merkle_write path; and online repair can now unwind broken verity
files that are otherwise unopenable.

The kernel series now takes advantage of all the xattr cleanups that hch
and I did for parent pointers.

Full versions are here:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity

--D

