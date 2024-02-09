Return-Path: <linux-fsdevel+bounces-10895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50184F2D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA04B29925
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7267E89;
	Fri,  9 Feb 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUdAj7Ia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A067E90;
	Fri,  9 Feb 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472593; cv=none; b=t611BDA94CX8yahimZc2+zPSzky7YLPFM+vdrsM/qjyOrAsNE2rzhQ6eDiDGOx/Q8enug1jDXMwdQefhyMp892kyViQ43gRLA9PF4bhZvjHu1srg/pe0ZjoF1lMwgwAZxlmtUZJrz6Xj7F+qksPTuzDU6NNAD7FiyVzEA5PIHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472593; c=relaxed/simple;
	bh=xYEtR0Wr2t6KUJov/TRaojVdpD4mNvA5x9mBkXjvx6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiPi4iYe17xnGDCDydJU6/4IOlrxJfUGuKTZSN6Ze3Uc0oLuZS3kAZVg7tfU2zWrynPlqPASNZdVSIEK7PcT3KMbFBAnorMByGSxBq2e2rM7prEfCt9CffAIHQ/SVNgYLqIPVoNFrWlP5727fhY7kVqNBE+fGnHuRB9xV+4zxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUdAj7Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79E2C433C7;
	Fri,  9 Feb 2024 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472592;
	bh=xYEtR0Wr2t6KUJov/TRaojVdpD4mNvA5x9mBkXjvx6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUdAj7Iahkgr5Q6NWtXGxYvOl/rJpHVTWnfo3glfNrjL6pHaZeHwmQUiJbcul2RRJ
	 UKGYtLqvOd/+KQtfM26Qa65dJ3KoQyZmI1LikiWgXt3Py+DnyYEDL+YNpo+OQ6gWua
	 ggGnviTBDn0dC1nfu7gVRTK5rKX/3n5Q9iJyzVa8NnRRMn81ctyAL7q7UNx/XrGP/P
	 Ho0E7gPdZWV6/TdJOSDVNDGEYINEXsnHb9JyPwpR3RPYbD2578wQTxlhwJ3o2wtxJE
	 e2RfrMoZW65K8reAXsEORo85jV/5kAUZmyE/Um8j6z8S6XQoExierkC/Cu3DrbB+LD
	 1qBf/njye9Kxw==
Date: Fri, 9 Feb 2024 10:56:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
Message-ID: <20240209-wertlos-opern-45e9bce87014@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-13-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:56PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.
> 
> Based on policy, IMA calculates the digest of the file content and
> extends the TPM with the digest, verifies the file's integrity based on
> the digest, and/or includes the file digest in the audit log.
> 
> LSMs could similarly take action depending on the file content and the
> access mask requested with open().
> 
> The new hook returns a value and can cause the open to be aborted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  2 ++

Acked-by: Christian Brauner <brauner@kernel.org>

