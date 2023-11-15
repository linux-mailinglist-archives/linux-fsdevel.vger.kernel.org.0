Return-Path: <linux-fsdevel+bounces-2919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E57ED1F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E471C20940
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8E433DF;
	Wed, 15 Nov 2023 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLDGV3zN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B53D96E
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E12C433C8;
	Wed, 15 Nov 2023 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700079953;
	bh=sqyMxxCh+Ng+x/gZPB9sWxiyR3AXQq4p48XGxDxMuFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLDGV3zNwpX1aR8HoBDJKGt6Xmu2cUS1GvQpFKZW7r0UZBUBmYoSQZv2JYPlUkxnS
	 5Y2bMJBTFJ8s0Jc/cT8tPlYrpezHXoWBtIwrm03mq6i9kfsBSiZ29Xa5vC0QcOjPnd
	 3dFPg4wVeXIZZdMtioq3xIf3/UUBNnbNesXGDaisMHsLXi3s5ErHkpzt9ifXseP6jG
	 zUKNlC8rVTWCCWWa8MUF9rFVPqz9rayDUBo90eNWU6lp3NowHzYHRZn/lG32fcI+EJ
	 ANN9VU9WagM7lNJ/7RLneTw2+QjucJu2k8GCh3kfr0t3ssTqWNFsay/9EcH9chA4CW
	 Vfgefh8qY7ssA==
Date: Wed, 15 Nov 2023 21:25:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Chuck Lever <cel@kernel.org>, akpm@linux-foundation.org,
	hughd@google.com, jlayton@redhat.com,
	Tavian Barnes <tavianator@tavianator.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231115-formt-siedeln-45b635164d38@brauner>
References: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
 <20231114-begleichen-miniatur-3c3a02862c4c@brauner>
 <20231114175714.GT1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114175714.GT1957730@ZenIV>

On Tue, Nov 14, 2023 at 05:57:14PM +0000, Al Viro wrote:
> On Tue, Nov 14, 2023 at 06:29:15PM +0100, Christian Brauner wrote:
> 
> > I think it's usually best practice to only modify the file->private_data
> > pointer during f_op->open and f_op->close but not override
> > file->private_data once the file is visible to other threads. I think
> > here it might not matter because access to file->private_data is
> > serialized on f_pos_lock and it's not used by anything else.
> 
> That is entirely up to filesystem.  Warning that use of that library
> helper means that you can't use your ->d_fsdata for anything else - sure,
> but that's it.

Yes, but it's usually easier to reason about if the pointer just changes
during open/close. Nothing I wrote said that it's mandated just so I'm
clear.

