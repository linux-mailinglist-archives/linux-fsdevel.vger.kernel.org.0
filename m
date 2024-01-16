Return-Path: <linux-fsdevel+bounces-8079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAAC82F340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02F3B23A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E081CD05;
	Tue, 16 Jan 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oB2T4v4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96E1CA8C;
	Tue, 16 Jan 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426433; cv=none; b=W1JhDbTc1vQsP1u2fjT4UhzvZrIF75cH5VdhClK2ZmOXKY3Rvi2chVP0mUJp1E0KKncPqtLooogiPhyGmpnjMp+Nm0xB/j+/9QwGpCP/ywuSzwzICy0b5KL87pfFNkLCdCpB3iFtpkBUd01QsvU1jbyLXSWFH+DmnWO+ARz/p6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426433; c=relaxed/simple;
	bh=eO4OQip7Vt8iBukXP9TAx2AYps5FjXjzaKh58KGbU+U=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender; b=mgt7i0rhcF4NmKvI9Toxh/tR73zBv6sowCCL5cINF4EjskIlMfBvqUfHQUviYLuWFgDcmfseGZiZFbH9fPtRJLLgGyC4TLuD3RXeS+oj9F3j5tJh9CEXol6ZJfoji3rUG4idkpwQJdBc09ecuKeeceQybAXve9D/LddMnlSviGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oB2T4v4o; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S+5my9jXWKBreUOHlR6pw/2iHlpnFX5ZhPEFeXmOIzU=; b=oB2T4v4oLxkQEl5he5aGeli2CM
	22r5wlr+d67aycYttFH91VKhE4z4GFMtZCLZ/t5N5Dy8EnFkFyO35Kx+42NeZjon4az/S7jao3zQt
	oOc30bwbkfVK/bIYToXwaAZijTrmhqgvTSExU0PZXKz9Y32gME5PiJX6f/o/VOYV8YFOoTBQd5cZR
	N/U6CgHtJ9kHws5CwSe0OijCh0Y08yklS2uRQzVYk4NnUCpXG4Kgq1QDaW/CY7H1uoe0ZCn6BPK1l
	dDTU5uHuJNYSfiOyxHFVJdpvoTrZBff9+VvcrIVStbRrfPIka65NVBC0E6aS32uosVxIU6OnOllvV
	x718UZbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPnJN-004gXh-1E;
	Tue, 16 Jan 2024 17:33:17 +0000
Date: Tue, 16 Jan 2024 17:33:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, brauner@kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
	stephen.smalley.work@gmail.com, eparis@parisplace.org,
	shuah@kernel.org, mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
Message-ID: <20240116173317.GL1674809@ZenIV>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
 <20240115191508.GG1674809@ZenIV>
 <3b440f064a1ae04d69f7e85f4077f8406c0eac67.camel@huaweicloud.com>
 <00b7ff22-f213-471a-a604-658a9af80d59@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b7ff22-f213-471a-a604-658a9af80d59@schaufler-ca.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 16, 2024 at 08:51:11AM -0800, Casey Schaufler wrote:
> On 1/16/2024 12:47 AM, Roberto Sassu wrote:
> > On Mon, 2024-01-15 at 19:15 +0000, Al Viro wrote:
> >> On Mon, Jan 15, 2024 at 07:17:57PM +0100, Roberto Sassu wrote:
> >>> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>>
> >>> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> >>> the file_release hook.
> >>>
> >>> IMA calculates at file close the new digest of the file content and writes
> >>> it to security.ima, so that appraisal at next file access succeeds.
> >>>
> >>> An LSM could implement an exclusive access scheme for files, only allowing
> >>> access to files that have no references.
> >> Elaborate that last part, please.
> > Apologies, I didn't understand that either. Casey?
> 
> Just a hypothetical notion that if an LSM wanted to implement an
> exclusive access scheme it might find the proposed hook helpful.
> I don't have any plan to create such a scheme, nor do I think that
> a file_release hook would be the only thing you'd need.

Exclusive access to what?  "No more than one opened file with this
inode at a time"?  It won't serialize IO operations, obviously...
Details, please.

