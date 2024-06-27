Return-Path: <linux-fsdevel+bounces-22639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93D91AAFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1DB29A64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED942198A2B;
	Thu, 27 Jun 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3o0wOh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDF195383;
	Thu, 27 Jun 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501526; cv=none; b=pXUSGz9Pu/c5h3VaIHzEhGHxF6xAlUW2EcbMTrEfneobT2ZpL+SqwL4n4jc59jRAoICS2ucCddmu+ID8mH2vTQ0HHhBpvS9BEYZ6Y8hk88OtBTydTCHpK2OXHo7qydOtaINEY/isGTchn/hBn9r8N/eFXfEvITdabAZNVmzSsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501526; c=relaxed/simple;
	bh=hNlvklwWESHsTITC4Xz4ZjyNEZ0W6rbDTEZviL0qPkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt8FsaRvQxhlXSc7Y2JmFjE6n2Nmmmg/yJm0X48X5/2+F1RdTzM8csTPCUJxBFxVn67NWcGQmhIfLg+6jXxhROnFVzokl7zq9hQ6Y64SjepHOnddMHtsEr7I73ujDwjOBpXg66YYrtlwttTWqm7kYVCvrXPbB/aNubpKaWa6zSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3o0wOh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9345DC2BBFC;
	Thu, 27 Jun 2024 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719501525;
	bh=hNlvklwWESHsTITC4Xz4ZjyNEZ0W6rbDTEZviL0qPkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3o0wOh+uQMCynJkUwYUjA0WFoGgFGgC09ncK9B7PkfvnNhVCTEt4vJuM4EEEIKvI
	 PneAPhbCHWqZNgqv3+ImOrtB6B/IuSBt4/r8Zn0NIFc2qoam8ZdcYzq09eWCTftYqo
	 4OwiOGvsGy17z9Y+YjYFsi9HSl2bziEp07rbb75DU5ali6lj8HQ6kUMoAYx4RGFOmM
	 gFR1tNo7vh+8190GYToMAmNAEXr7BoOk9+eNXlIIjE33JGpLFOZgN+/p05Anxygn+g
	 woks7DoYhoAnQXV03dHCVewsMNdrsB193kvvP8dpx+oryMSwuD0lrAzeX/kc+M/a6P
	 lVZ24ywVVjSUw==
Date: Thu, 27 Jun 2024 17:18:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	dhowells@redhat.com, hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com, 
	zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, 
	wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object
 that is being dropped
Message-ID: <20240627-beizeiten-hecht-0efad69e0e38@brauner>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-3-libaokun@huaweicloud.com>
 <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
 <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>

On Thu, Jun 27, 2024 at 07:20:16PM GMT, Baokun Li wrote:
> On 2024/6/27 19:01, Jeff Layton wrote:
> > On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > Because after an object is dropped, requests for that object are
> > > useless,
> > > flush them to avoid causing other problems.
> > > 
> > > This prepares for the later addition of cancel_work_sync(). After the
> > > reopen requests is generated, flush it to avoid cancel_work_sync()
> > > blocking by waiting for daemon to complete the reopen requests.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> > > index 73da4d4eaa9b..d24bff43499b 100644
> > > --- a/fs/cachefiles/ondemand.c
> > > +++ b/fs/cachefiles/ondemand.c
> > > @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
> > > cachefiles_object *object)
> > >   void cachefiles_ondemand_clean_object(struct cachefiles_object
> > > *object)
> > >   {
> > > +	unsigned long index;
> > > +	struct cachefiles_req *req;
> > > +	struct cachefiles_cache *cache;
> > > +
> > >   	if (!object->ondemand)
> > >   		return;
> > >   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
> > >   			cachefiles_ondemand_init_close_req, NULL);
> > > +
> > > +	if (!object->ondemand->ondemand_id)
> > > +		return;
> > > +
> > > +	/* Flush all requests for the object that is being dropped.
> > > */
> > I wouldn't call this a "Flush". In the context of writeback, that
> > usually means that we're writing out pages now in order to do something
> > else. In this case, it looks like you're more canceling these requests
> > since you're marking them with an error and declaring them complete.
> Makes sense, I'll update 'flush' to 'cancel' in the comment and subject.
> 
> I am not a native speaker of English, so some of the expressions may
> not be accurate, thank you for correcting me.

Can you please resend all patch series that we're supposed to take for
this cycle, please?

