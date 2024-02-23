Return-Path: <linux-fsdevel+bounces-12541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7C860BBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83121F25412
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06F17583;
	Fri, 23 Feb 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg3XufS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA79171A3;
	Fri, 23 Feb 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675694; cv=none; b=gYQJYZKALYYDrvjYOmPb6PsZ4naS5uvKkWADeIEiS/Dsav4kbCWWak/e1mi4Nij9cuUNJ+/+6BspzbhHOyaJX+GPlLBJAsx1FDFDAUBeAMXc9PRs2cjPXlT96NGC+tsbPknmar/5wzVlymKMZCuN0nPRJ8ITBvEfhoHwmxjsmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675694; c=relaxed/simple;
	bh=sHWn05MJttavUBMB12+GNMdadLjZiLx3RXhhBDrmsJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLVFLbFuiY4m7qiPVRJVvHHFNzBwV8sfTr3nTdbAL0LNvfpLSxyrTJ7cQxlFinIES8g2kSoHS9Y40pxvG1iWcrVys0DZP6SdJfgo7f5WcbI+Zqjd9AAlguMT0KwYXuyRJXKrutKhQ1MOr04lXn2gJdjaeA2kWOgT5Xbzqfbr2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg3XufS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A8C433C7;
	Fri, 23 Feb 2024 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675694;
	bh=sHWn05MJttavUBMB12+GNMdadLjZiLx3RXhhBDrmsJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg3XufS0q2T0sNHkSOrBEvEFenHkbXULgGhZWIT/XqOkumh1aj0AiFgeSUL7Z6Hyf
	 5Bty9R6AcZFx0YaW121AcFq+dSWQMWU8RrZy3vqXKB/NyVtOeIaOBmRcs1zzLDjiKY
	 uJIS2kyqqlK5TlhAMzk/j/70dR0J5sICT2U4aWIroXzev3OEltfWpNjQ3uN/PhJZY/
	 Ss3LBviK+JcQf4ucWSVTPNaVDQevgquBsc8UzNJSLe/UTPBiqC6QxkmZE18KgHBwKQ
	 tZz6Yz0TLQD1ogAfVNnqygGlx7NnzU9hEiD0oyA7ZFDlfo6bUNETAb7lVpxzM7ka0h
	 6/mVZwFzxICOg==
Date: Fri, 23 Feb 2024 09:08:05 +0100
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
Subject: Re: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
Message-ID: <20240223-beilhieb-nagetiere-83d9488f05f8@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
 <20240222-wieweit-eiskunstlauf-0dbab2007754@brauner>
 <ZddqXN51+8UaKVTC@do-x1extreme>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZddqXN51+8UaKVTC@do-x1extreme>

On Thu, Feb 22, 2024 at 09:38:04AM -0600, Seth Forshee (DigitalOcean) wrote:
> On Thu, Feb 22, 2024 at 04:20:08PM +0100, Christian Brauner wrote:
> > > +	if ((magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
> > > +		vfs_caps->permitted.val += (u64)le32_to_cpu(caps->data[1].permitted) << 32;
> > > +		vfs_caps->inheritable.val += (u64)le32_to_cpu(caps->data[1].inheritable) << 32;
> > 
> > That + makes this even more difficult to read. This should be rewritten.
> 
> Do you meant that you would prefer |= to +=, or do you have something

Yes.

