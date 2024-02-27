Return-Path: <linux-fsdevel+bounces-13009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988286A23F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BD2288682
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB2153516;
	Tue, 27 Feb 2024 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIgrx1r5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CC14A4C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072024; cv=none; b=e5Oj6HsrlnoxdHEEzRNR5i7Sg6m6KNbTfuOhvVbnawu976M8ADbWIKFrDFfwIbG82RedGcDdiSQj8oJuog23yuUko5gKG7es4N/zktGHsLVyWEwI1iIyAoM3nIKlAxUuY/GaKzYzQJ7hPFgCPp9a2On0OpX8sngjyE28klmnNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072024; c=relaxed/simple;
	bh=iuEhIgk7KqdLt1+37gB72PcGaSZq/l+N028nI4tYN10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GudP7rdmCOqEPr6QdlYPqWpWX0nPwv/mPtGyPNHJQ3ipSuDfDzgDUk+A0r3fgf5gv8WAqQNaCh4VvoEG13EV2goA5veJUTZL75frUD1cokH+lAzCBRfjNY7WHvFRPqwdYPNoW9BREyjhkkdaxbR1z3xnnP6ll4Jzlq0s5SC8j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIgrx1r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2EEC433C7;
	Tue, 27 Feb 2024 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709072023;
	bh=iuEhIgk7KqdLt1+37gB72PcGaSZq/l+N028nI4tYN10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIgrx1r5FsCoqkpWnGjoYPYrZY7Ht9gzZDKzsNwS1nIJNj1USHxNzSeSI2al3S0ep
	 KvelWizf/ndUTzfc7RrDCWo+cUSx/CDY3o0ctbJ3ZTmzlHIn1HErBtKSQYx3/qIMFv
	 KITRR+umX340UfQdSKLdkUyXlPtMNpW7DkD6v9sUybEDP/HA4qk2t/ObbtXABU/o8G
	 Ua0QmWeNSBxqyDVzn/y5PtJdfawlseaDRVnmSARAdzgdoxnk4ht6Ed7y/ohdGuNKuM
	 0ueHVXreHZFVWSEm5ekzSFEkaGZUFC9MOyZ6fImBm5vrjIy3yeK5ZnVvOrEYuXnut1
	 VNkkM9QOBEO+w==
Date: Tue, 27 Feb 2024 23:13:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>, Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240227-sobald-sommer-18e4e81a3e83@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
 <20240224-westseite-haftzeit-721640a8700b@brauner>
 <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
 <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>
 <20240227192648.GA2621994@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227192648.GA2621994@dev-arch.thelio-3990X>

> boot like I used to). I do see some SELinux denials for pidfs, although
> it seems like it is only write that is being denied, rather than open,
> read, and write?

Yeah, the full extent of this just became apparent to me today. pidfd
inodes are currently private and they need to continue to be so until
userspace has caught up. This is now fixed and will show up in -next
tomorrow.

