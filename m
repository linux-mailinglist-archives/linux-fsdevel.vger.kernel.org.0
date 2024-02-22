Return-Path: <linux-fsdevel+bounces-12481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED27885FB29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4214F280F12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994614A08E;
	Thu, 22 Feb 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB9vSenv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5C1474A3;
	Thu, 22 Feb 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611829; cv=none; b=Oy/q/RiYiPPPtcx06GmgTlwzYEKCCYY8A1HMdhCG9wIt9D39q+r1e8Ks7AHj5SuPF715GOrF8Yzb11dwzQtBFdyiCQN4VnQf2dgpdU/FgmRHm1GgSEIgTtSuu3rybiDFr+VJ4iz8m1jc3ts4JKK+lQlybJpihDTn865QYOMPqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611829; c=relaxed/simple;
	bh=IVHMiNwhpyx/WmURPSJJE0+FpXgBaS1dvoXWJ0mwczk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOk3t4CiphYOgdZsr+jOpEYGMHSKNMDGcrAssmsDmvvVVrqxDTme6Eb6rjIAFiU6WghpHYrETh1TZORuJLJ4vNXfdvLGabTmYt7GevwYFpefRi17tjH1Oj6U8v0vs64Tq0Hq08/jqjq1Mo1Yqr0jFJ1uaDoOrlr5t7tFUvFJJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB9vSenv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089CEC433C7;
	Thu, 22 Feb 2024 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708611828;
	bh=IVHMiNwhpyx/WmURPSJJE0+FpXgBaS1dvoXWJ0mwczk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QB9vSenvdcRaK7WdgpOAEoVXr12giECr+tJ7OlnCpzRC6DIJasWwNf+puNTUJB+g+
	 wNjVsYOnvVsKsT/vXMxgm/KOm68CMvbGR1F57JidOItenPX9Qgh/CvmEFg1KMYXT9d
	 Q8RU+UrlDodo153Zdb9Q6StPILoak4QnCe3KiQ6NjuBea/dfTYljBEXd7Vth0tYheY
	 p16QCboQNyomb216m1QiAVGkvRvyEWGqf4+/U/aklaEqs6iUe5HUlh9RglBwDNifj5
	 4w8O+S9qdwjlLeBkQoX9klB+A/qTj9AWNMglb3Ka3CB1Q8d80L2c4VeE2RnBQu9rET
	 sMv52695ADs9w==
Date: Thu, 22 Feb 2024 15:23:40 +0100
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
Subject: Re: [PATCH v2 03/25] capability: add static asserts for
 comapatibility of vfs_cap_data and vfs_ns_cap_data
Message-ID: <20240222-gerammt-lieblich-573fd7f3edc7@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-3-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-3-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:34PM -0600, Seth Forshee (DigitalOcean) wrote:
> Capability code depends on vfs_ns_cap_data being an extension of
> vfs_cap_data, so verify this at compile time.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

