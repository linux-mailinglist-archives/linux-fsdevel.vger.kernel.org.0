Return-Path: <linux-fsdevel+bounces-7588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC682821E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 09:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF8288AC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59439AF2;
	Tue,  9 Jan 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hae9Vcp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92229431;
	Tue,  9 Jan 2024 08:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359E9C433F1;
	Tue,  9 Jan 2024 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704789185;
	bh=A8Hyrx8gv2NivKMAgmiyJ4RK4toNpxNWKdpezhMjsB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hae9Vcp8/kaaJWKrCD8n2rypMTJgDsf+fIUhRrlgD2zzHG1fE0pMkgVLy2Aay16i1
	 cyOHkhWI6T9AA0gmkJRtZt2jCOTuc/GnE/NFt35tRFGpCvFIalZbChShpHaOxn17RM
	 sI5RHW0Ki3H0e99EmMwZ6tO0SgA6QAqR2LAPQFlkuKHdVPcV2i/aQ865CceI5/rxfK
	 gR0HZ9dSmm6LFVOSKnwJUC2JqLjmUkL+hI52eC592xyJdoFew40D8m5YvlAVdr2EqL
	 CHVYbJeXgyIcRIjxYeABsn7YZUkU56k8rkALLN+maFLPBr7Q+5gP4DXI0YDvuJOFww
	 WRb5Fwe1ZVgUw==
Date: Tue, 9 Jan 2024 08:32:57 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yiqun Leng <yqleng@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH 1/5] cachefiles: Fix __cachefiles_prepare_write()
Message-ID: <20240109083257.GK132648@kernel.org>
References: <20240107160916.GA129355@kernel.org>
 <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-2-dhowells@redhat.com>
 <1544730.1704753090@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544730.1704753090@warthog.procyon.org.uk>

On Mon, Jan 08, 2024 at 10:31:30PM +0000, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > I realise these patches have been accepted, but I have a minor nit:
> > pos is now unsigned, and so cannot be less than zero.
> 
> Good point.  How about the attached patch.  Whilst I would prefer to use
> unsigned long long to avoid the casts, it might 

Hi David,

I would also prefer to avoid casts, but I agree this is a good way forward.
Thanks for the quick fix.

Reviewed-by: Simon Horman <horms@kernel.org>

