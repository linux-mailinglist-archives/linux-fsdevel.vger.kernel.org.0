Return-Path: <linux-fsdevel+bounces-12543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5E860BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92401C245FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824F179BF;
	Fri, 23 Feb 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+iPI2x5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39817552;
	Fri, 23 Feb 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675830; cv=none; b=AoFTiCo6EpLP1lItl3GLPaBDbVNmRmhZMZwvX9QzTvkucrQ5nD8JApOt2u2DGgUE0GVhI9mlk/s+N29aykbNvQoRwzu6uLAcNJ+8FII3AGuXwbuiscv/LCChMlRsdoWgTfLcnJiFhlngDlvGQutv5dZlAYc2ehMHboTcMX3OZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675830; c=relaxed/simple;
	bh=vDlBk0JrMuu36VS+7I1c5BfB6boHpR1/PxKZAdBtvTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aODAaNcQHTdQx5LtlOO24tWpGEduYdlq7LuijmA9XbYmwxBpBmRYUSmSc6NDV9VamozPcVm027Q7YI8PhgIiAIctUt+vT7czuiGSp5lCC+wnZdRUnGCGs909iBm5NbCXj6ZmrF6QVHVLCrjyKgJ0TjpqcOaSPnC3maJZpxUZ6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+iPI2x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE411C433C7;
	Fri, 23 Feb 2024 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675829;
	bh=vDlBk0JrMuu36VS+7I1c5BfB6boHpR1/PxKZAdBtvTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+iPI2x5SPMHae2zUGagiG2SAyHjqh4AnTe5o6E9c/7DkzBSIlZ/px5MiST/qNSjY
	 v4kCEciNenQMdQZg/Jv0duQPGwulmbYojmFefZps5BPD5KgG+5Ifsg0ML/0GXdGfpb
	 Jitm6+6FVoby0nBHraO3FDar8UoXvHeNwqjdNcp2ASPEl+uphYosxrBBbuc5J10uob
	 858lGicNNbgiuCY1sPtVc+jbUko069OlVjS7GBXAMDNIA7wXKIgWfWVPhAo83GKf/f
	 beLYxpB62taeVTY0MLHw2gA7K3sKJAtE8IFY8jiUU+ufdTzSGcDB0SccGS4ElShHtT
	 g34DQmoeKR10Q==
Date: Fri, 23 Feb 2024 09:10:22 +0100
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
Subject: Re: [PATCH v2 09/25] commoncap: use is_fscaps_xattr()
Message-ID: <20240223-banditen-zebra-8aa361b18104@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-9-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-9-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:40PM -0600, Seth Forshee (DigitalOcean) wrote:
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

