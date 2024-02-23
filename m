Return-Path: <linux-fsdevel+bounces-12547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E2860C3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD5C1C22516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D818E14;
	Fri, 23 Feb 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5O9J95v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E11862A;
	Fri, 23 Feb 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676766; cv=none; b=hOLLtORdyR+mxG4mwGqM1pMPYeHbvAqEDXguTiOsskCq29VW1r3w500vS/MkurB0wiUfRUo55IWTXUAP47dWDr+VtoAQV+gvbNLcSrP/EJiC/zclvVvWQNIhzAmaJeubXtJWxiYgGQuq2lYs/D/G2wb0frsLZGmJ0b9qUS5Wgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676766; c=relaxed/simple;
	bh=d4+85PokRLij+Pmcnj8Pzm2cYiTlHEWq84xygWKmed4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGRvh27WeoDs8iWwfXYlhmKdcHoTmxweCvRu/rnSVzZeUXJdWiH2QaF5jaN4DPMvnfhDbLF5+ZPolo87nFU+r6MGNz8QgbTzw4EoMCc3rSkHCqCf+ma0x/Rvl7fIvqs1TPJwdxVTRrMh9hsg22IgRR721bxCqLEK5u8LdTI04gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5O9J95v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DCC433C7;
	Fri, 23 Feb 2024 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708676765;
	bh=d4+85PokRLij+Pmcnj8Pzm2cYiTlHEWq84xygWKmed4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5O9J95vaF2F1dkRoBkfaW7+FCxJ20NW/E9KygKO7GFkmI66PWmV1g1X8hqQ52Y/F
	 L2zxy0cpQxjWkAMB455E0lrlAW8+YQok/uXW/w0aUIlDlydD5Dq3s/n0pZr6aVxGHj
	 hQe12ogvC9AcqWjPbb/maDCxlmDN6jaAtPia8b5yZgLBMJevCH+I1xNq8N1Krbu+yo
	 A8WBGiQBZAmZcS+r+tGLZv9bS/xIGw5rR8K9WbbLqIdvs9I0qJ2d5YH8xcX6iMa0RY
	 tZd/K5dMIS+QZadpDrhbudfAz8gxUcodysUo8Jk4lm5q78tqx5UkJ8/FdeiR+4J9wW
	 DCRCXRV8EXMRA==
Date: Fri, 23 Feb 2024 09:25:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 16/25] fs: add inode operations to get/set/remove
 fscaps
Message-ID: <20240223-landen-frisst-06ff8597cdf5@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-16-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-16-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:47PM -0600, Seth Forshee (DigitalOcean) wrote:
> Add inode operations for getting, setting and removing filesystem
> capabilities rather than passing around raw xattr data. This provides
> better type safety for ids contained within xattrs.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

