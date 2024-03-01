Return-Path: <linux-fsdevel+bounces-13280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACAD86E262
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3672281CF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042416EB60;
	Fri,  1 Mar 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmlsN0Af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49333381DE;
	Fri,  1 Mar 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300371; cv=none; b=NDepxziwH9glH1JqBipUQzmemy7LvQ8sEhbzmoX7tvmBYOpJWqaTD0OsvBNLtUTn4SIJPeYFVr7oQg9ZqkM9XSG6CAzRldu6YyyFaPy7Vk+Tevl3xmiDX9ydaqKgP94om78oUaKmJ/XqVY7NKR0b5g5zAsJixD/Z1e9JWJZ5/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300371; c=relaxed/simple;
	bh=200DnVfdBW01DT/X3+moyKLm3jYVD1mA8Rk9R6nnvy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxVTsNeAyUAatAjKzCJEbQv+lXdHuGmDqhzqch0aDiTlrHDUlVmzSo9/sLHQD3z4XRjhTuw5xk4Qy8YJqGK7svHU/NQouzSAp6JOuSu+RI+lcaRQPKW5FptR5BR58B+AjL+nf6fkUH39pM5TqqCFny6tMFsx1xGZpllOIdeL77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmlsN0Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7827C433C7;
	Fri,  1 Mar 2024 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709300371;
	bh=200DnVfdBW01DT/X3+moyKLm3jYVD1mA8Rk9R6nnvy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmlsN0Afn3hqkExjN7Wyw+6uU+Dpkw1N5GNTe84u1nwEX8OeaUvMkmMNvrEZ2TmVC
	 j0lcFtUkG0FmPkNWw2wmFAjH83SByHMprhRWazPBtPscr8gzzMkm+Psxu3yn0At+M8
	 2nm9OOjvrm2E4B8jXOaYIj4ooZGeOqbJgeOq2p/gtpMP5/8l1PSOlSjPeUzxM/MbIu
	 nGYgHnOjfgUprywtIpDeOSN6rCVEN/GWi6TvCO2yXQbDvIWM2qVDCfMZQZASfV9JV+
	 4sDMCQmrBrgCcyxmb8DE50icAWVqKwKSa+A1qMkg1HMvMMq72jD1VdwIpkC4MhNoPr
	 gfHvFPrOUsJ2w==
Date: Fri, 1 Mar 2024 14:39:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 14/25] evm: add support for fscaps security hooks
Message-ID: <20240301-sport-bekriegen-5b34fd5a014b@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
 <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>
 <20240301-zucht-umfeld-9a923a7d070a@brauner>
 <e6f263b25061651e948a881d36bfdff17cfaf1b0.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6f263b25061651e948a881d36bfdff17cfaf1b0.camel@huaweicloud.com>

> I have seen this policy of adding tests in other subsystems (eBPF),

It makes sense if the drive of the patchset would be IMA/EVM features
not refactoring of existing code.

> Happy to try adding the tests, would appreciate your help to review if

Cool, happy to help review them.

