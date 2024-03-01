Return-Path: <linux-fsdevel+bounces-13264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB786E15E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9BB2816F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210AF6A34F;
	Fri,  1 Mar 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOegZl9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3E40BE4;
	Fri,  1 Mar 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297662; cv=none; b=gKQNM4fzlemsDZqxHGnIZDbGpd2btv2u3LGJ1siSrvyIdwpj3tGDuJVGRmrpVA9aSUPc3aQiF9Qr8WZTdYWnL6F0ZDD4JZm4vbZ0hgil2AL+LzHXJdK+vUxMXwIto4T83+AN/rQ+C1xDRzu3ieLRw/zIuKnhhPRRylmMOrRvdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297662; c=relaxed/simple;
	bh=t89dHoO9bnrvVzN2QBdLQzcy9IB8Yy8zK1DVwzYtJLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTR9+GXbZjEElDJq7r0SwUuP/RwctYAFTzysvMFkxUNMUsYdW6mZlZ/G03VUNbBbq7vik6FusQDn57kZRSwp/m2EcFDnmu0gKKNctrHmhfFkcpEVFaipGwQlXIXJYiRNVSZNWrIrlxSaSP5VM6O88dqQ8PHV5hXUHgl7FORpnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOegZl9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C649FC433C7;
	Fri,  1 Mar 2024 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709297661;
	bh=t89dHoO9bnrvVzN2QBdLQzcy9IB8Yy8zK1DVwzYtJLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOegZl9pozxzAbNhZv0jA1i+vi3ItTby1MFSlr85hLGQhHFfLDxrb01Ceft8ywLFL
	 LZ3cQODIhl86m39/bVdMjbCEGtXEN/QMGOahwbFOylrsu1CQrG61u7Mp9u04yFsgOw
	 W57pcEh7jkhTp99h8FyYr8ewF5aOeSMjxSVk28NEaFvIINTfHFRoVVsdhKWyvoqgmO
	 co4E/QYluflcEX5cUQnbbEfUG7q0AkEwjGZrlg6hmhebo54BNR3f+fBHClu3SVGAL/
	 t6dpupiMJRB0ZDmFBluzhc/umtXAqkNtVyElMzMTlFv7n3rkzHzHcEfhi1TB5X/T0+
	 7toYd61I6SV/w==
Date: Fri, 1 Mar 2024 13:54:13 +0100
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
Message-ID: <20240301-zucht-umfeld-9a923a7d070a@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
 <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>

On Fri, Mar 01, 2024 at 10:19:13AM +0100, Roberto Sassu wrote:
> On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > Support the new fscaps security hooks by converting the vfs_caps to raw
> > xattr data and then handling them the same as other xattrs.
> 
> Hi Seth
> 
> I started looking at this patch set.
> 
> The first question I have is if you are also going to update libcap
> (and also tar, I guess), since both deal with the raw xattr.
> 
> From IMA/EVM perspective (Mimi will add on that), I guess it is
> important that files with a signature/HMAC continue to be accessible
> after applying this patch set.
> 
> Looking at the code, it seems the case (if I understood correctly,
> vfs_getxattr_alloc() is still allowed).
> 
> To be sure that everything works, it would be really nice if you could
> also extend our test suite:
> 
> https://github.com/mimizohar/ima-evm-utils/blob/next-testing/tests/portable_signatures.test
> 
> and
> 
> https://github.com/mimizohar/ima-evm-utils/blob/next-testing/tests/evm_hmac.test
> 
> 
> The first test we would need to extend is check_cp_preserve_xattrs,
> which basically does a cp -a. We would need to set fscaps in the
> origin, copy to the destination, and see if the latter is accessible.
> 
> I would also extend:
> 
> check_tar_extract_xattrs_different_owner
> check_tar_extract_xattrs_same_owner
> check_metadata_change
> check_evm_revalidate
> check_evm_portable_sig_ima_appraisal
> check_evm_portable_sig_ima_measurement_list
> 
> It should not be too complicated. The purpose would be to exercise your
> code below.
> 
> 
> Regarding the second test, we would need to extend just check_evm_hmac.
> 
> 
> Just realized, before extending the tests, it would be necessary to
> modify also evmctl.c, to retrieve fscaps through the new interfaces,
> and to let users provide custom fscaps the HMAC or portable signature
> is calculated on.

While request for tests are obviously fine they should be added by the
respective experts for IMA/EVM in this case. I don't think it's
appropriate to expect Seth to do that especially because you seem to
imply that you currently don't have any tests for fscaps at all. We're
always happy to test things and if that'd be adding new IMA/EVM specific
features than it would be something to discuss but really we're
refactoring so the fact that you don't have tests we can run is not the
fault of this patchset and IMA/EVM is just a small portion of it. 

