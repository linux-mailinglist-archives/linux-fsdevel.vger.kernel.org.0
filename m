Return-Path: <linux-fsdevel+bounces-12542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD85860BD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2631C2161B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550A17583;
	Fri, 23 Feb 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq5xWvjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F015168CE;
	Fri, 23 Feb 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675803; cv=none; b=OARIarYbU1/R9ZAtYhfUhZCpDQ0uQjxemVFEHNPh+9Mq7YXmpyGVLyWLVrpvjJkEKiY52enWnZjYQzmQCD7b3EF45zq/KO9rFPC/sNpfesQioWAFCMJ/R/zt/gcEji030Py1pTAsTw7SL/udT+esYDXB5vurMhpsYxH8k5zrtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675803; c=relaxed/simple;
	bh=cG0bbfNplqrjhHWLt+sMedW2m9unaNdtzKj/bQQrOFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoqhHPnxCZSt/69JWF6YfanmhvXlgYHbYREgLp8OQpgoTpEy9sN5IDKzxf8Bio6yU+L83PWg2DCFTX45sgDb5yFGVCq+pTGYMuD2OenW/avnPCP+2WZqV3tGXX9ahclE0L4vkWVcZK8o+eR9wygC7wGvHVm3peRDbcj/ON//wbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq5xWvjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E9C433F1;
	Fri, 23 Feb 2024 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675802;
	bh=cG0bbfNplqrjhHWLt+sMedW2m9unaNdtzKj/bQQrOFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cq5xWvjWUSza+XxqmuGHogSYI1HWEyU6ocGaMvQLD05z7421fMO2oTxHc9DvFsyXC
	 nRnQfi0eTUSCxzyfSwBYAATxQsS+U3lN/+g9hBNqolwcYb3XJsWWfy3thv2c5GrWFW
	 QDiJVWV3jNMmjuQPwPcuVxywwRV2zAIfWhB6h8yZT0ela73NOiSJmO6j5KMRQoclUq
	 Le6rcBh+/AHzr6QpXQknsCx22HjSoAomoEIp1uRaPkZdAnP95AJ9G5ezDEBDSvm8aO
	 iRfcKdLByBF6EU00he7RaoLu1heVlD/C6jK1EpHW0smvwsGaahWyJnb6+cXL2tCqUW
	 5uo8BcnauJJYw==
Date: Fri, 23 Feb 2024 09:09:54 +0100
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
Subject: Re: [PATCH v2 08/25] xattr: add is_fscaps_xattr() helper
Message-ID: <20240223-bussard-einfliegen-0e04fd945921@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-8-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-8-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:39PM -0600, Seth Forshee (DigitalOcean) wrote:
> Add a helper to determine if an xattr time is XATTR_NAME_CAPS instead of
> open-coding a string comparision.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

