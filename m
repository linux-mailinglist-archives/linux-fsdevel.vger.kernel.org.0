Return-Path: <linux-fsdevel+bounces-43407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F2A56096
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 07:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA5016E2D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9386A19CC3E;
	Fri,  7 Mar 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VDocaQE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE00198E91;
	Fri,  7 Mar 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327391; cv=none; b=o1xa13v0OcQzMyUHjgMOrMg9FVMWbBaF+H+5w5JXurEJ1Ux9hGjku7lKdgJu6A3uq5KvWzkzARR6vH74id6nxMyzfVTUQkYuFNLYl/UoIrNO5hUHVFHEyxjylbVfXav1kUOcwVB8r3xAhHlnKwjE3I515SUr32KcwCulU/4dQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327391; c=relaxed/simple;
	bh=CRAihNkGRLaidsZuzsLC506Y8MOu0f2lmWlCIxy18H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIUh1ApD8uIYjaG9j3onmpcZ5rmDiCSGX3hhENsaRwjYXwnng9OouRQltffgKR2lWrwJTutd9jECc/Wy4aO5jtP1sS1vcdc3C2mRol0nOpVTx7bMLcaoZ51YSKZMSH4R/lmdAJEpqK/P4VmuswL9o3GepFE411QAvYPxA/yhVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VDocaQE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A418CC4CEE2;
	Fri,  7 Mar 2025 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741327390;
	bh=CRAihNkGRLaidsZuzsLC506Y8MOu0f2lmWlCIxy18H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDocaQE++DVK22rJjR70kxQTmMZHHuSCR7WjyiwjfJTHNTUq7Ul09dyUSB6USROlD
	 PmFKhruwh42vcXvtqkr1t9+HYVC57Vfcc370h8VlDwUIoKmoqVTdPJpIBz4ssbdX1U
	 2s4q7IFjhxQudeGaTX2sDHFRIa1SeDM5gE0ebBEM=
Date: Fri, 7 Mar 2025 07:03:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <2025030700-paramedic-untoasted-9cec@gregkh>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307005830.65293-2-ptyadav@amazon.de>

One quick review note:

On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
> +/**
> + * struct fdbox - A box of FDs.
> + * @name: Name of the box. Must be unique.
> + * @rwsem: Used to ensure exclusive access to the box during SEAL/UNSEAL
> + *         operations.
> + * @dev: Backing device for the character device.
> + * @cdev: Character device which accepts ioctls from userspace.

You now have a structure that contains 2 different reference counts,
which is going to be impossible to handle properly.  Which one defines
the lifetime of the object?  That's not going to work, please fix.

thanks,

greg k-h

