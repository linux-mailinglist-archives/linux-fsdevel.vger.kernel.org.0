Return-Path: <linux-fsdevel+bounces-6996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8381F6FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010FF281CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB86FB6;
	Thu, 28 Dec 2023 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0lbqOyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB46AA4;
	Thu, 28 Dec 2023 10:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32363C433C8;
	Thu, 28 Dec 2023 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703760473;
	bh=5Oj5V39vAkN1/+i+CrgR3hM1xoyNKUjIkt8y2kK2itI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0lbqOyoJyeMAeYseh2byh6ANjb73lLSFoo/4Vf3UE84vYDk1TieZPcsFMbb0loqB
	 J5c41nJjfroqg+lE9GGc0kOGcMTJxCy3AYauRg4GYPutMX/m+iGhLmhRqkfKY8IoEv
	 HQ6gkkpXqpfaUSwSu7V7SK0kirgYW//TghKZrO0OFcZ8vFivTervREY8Iia7YzaARU
	 4nrS8pD062BAXhO50kSt3MeaqULSjKL976XU3bOxCS4tcxu9/yoI/LjuylHOVl+oXi
	 rYFTNFdvU8qGKDS84wZ+xsCp/I0UcygpkM55NDFDntoL8POVYFgAFXl/4qpQMmPknr
	 lSRN3+TRLr3ug==
Date: Thu, 28 Dec 2023 11:47:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 15/40] netfs: Add support for DIO buffering
Message-ID: <20231228-wohlbefinden-museen-c5efad4e0d84@brauner>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-16-dhowells@redhat.com>
 <20231226165442.GA1202197@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226165442.GA1202197@dev-arch.thelio-3990X>

> This will break the build with versions of clang that have support for
> counted_by (as it has been reverted in main but reapplication to main is
> being actively worked on) because while annotating pointers with this
> attribute is a goal of the counted_by attribute, it is not ready yet.
> Please consider removing this and adding a TODO to annotate it when
> support is available.

It's really unpleasant that we keep getting new attributes that we
seemingly are encouraged to use and get sent patches for it. And then we
learn a little later that that stuff isn't ready yet. It's annoying. I
know it isn't your fault but it would be wise to be a little more
careful. IOW, unless both clang and gcc do support that thing
appropriately don't send patches to various subsystems for this.

In any case, this is now fixed. I pulled an updated version from David.

