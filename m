Return-Path: <linux-fsdevel+bounces-12402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C662C85EDBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609EF1F23DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212FEA92A;
	Thu, 22 Feb 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IztFEWeO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99C8BF3;
	Thu, 22 Feb 2024 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560697; cv=none; b=JUL8Bo/oTrvviEK+frWhnEpXz88TLDLtar/sGXcpUaH4N0Y8ea9HQ3eLx71RbC2TqRZwPDpuxCYJxQBPRQTafGNylXu5xnTFWp1nzXHlPiCgZIkwG3YxGm78kRW1m4NCOTydDUnp0GN2RONwt29PLHlK3VjtX903nGNBpFjWxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560697; c=relaxed/simple;
	bh=h9qy7DWnOvkeO6XeQXJWoofO0MXkEAwGozMFN95Vvcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP0BvB8dCcs0CtGOYBZEiO9zfpwGKs5ST1B1kYZvFE8wBnkbTHtAzMdj6w0VNEmV/JWM0y26WglSgdQXGTmqrRqFZ58tdVW3n5jcnV7YHnKQEOqoxw1/SlQGu13ahJjQAfzksjA5zrPF3r8eO+0fGBT2bkgkUnjpwBpUvG69tGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IztFEWeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F1FC433C7;
	Thu, 22 Feb 2024 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708560696;
	bh=h9qy7DWnOvkeO6XeQXJWoofO0MXkEAwGozMFN95Vvcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IztFEWeOzlO9FUghVzfV5D2nwwPqZG91UAYBolXVkyMw/4Ftx6JrK/9xCDjILDbnn
	 R3fsplJB/OgQKVGQlcT4tcVedG4q3vcvaiMH3Q6kpieLD0q+RO2Hlpdtgjcg+Ks8ZL
	 GyQ0m9TU8rR1lQxmLiAcn4Kdb+jg70yWGJhk9mj1jw1suEmINDl2XEaTl/eC2ZSRIf
	 GeVqq8VsCg4WEy128tsFjpACKXacjtGNd27eutPHhKh82Iovi66GcUVPraQozJUxR+
	 BXY6d69m7Hg+ULqUYyyLQcWFZN5ATBkwkdo62bw60D1cOakNw+F2hhtQvagUShOWWJ
	 A2WRfwCCC0waA==
Date: Wed, 21 Feb 2024 18:11:35 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 13/25] smack: add hooks for fscaps operations
Message-ID: <ZdaRN9gUkjgxxoHB@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-13-3039364623bd@kernel.org>
 <b14d41b6-547b-4a1d-b2b5-0bae11454482@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14d41b6-547b-4a1d-b2b5-0bae11454482@schaufler-ca.com>

On Wed, Feb 21, 2024 at 02:52:50PM -0800, Casey Schaufler wrote:
> > +/**
> > + * smack_inode_remove_acl - Smack check for removing file capabilities
> 
> s/smack_inode_remove_acl/smack_inode_remove_fscaps/

Fixed, thanks! I guess you can see where I copied my work from :-)

