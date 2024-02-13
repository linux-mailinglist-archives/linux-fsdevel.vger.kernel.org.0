Return-Path: <linux-fsdevel+bounces-11502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D8985402D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52EA285F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B763108;
	Tue, 13 Feb 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/7q2If5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF05FF09
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867445; cv=none; b=uKbn3zO4ZKIgEzh+hLYH5YXUKBkffKwXFNjzPYkikB6ECqQzDdQ8+AM9GO8hLH/T1wwVqCmVqIYGrAbYGzSaVE0Bs5nWHhqF/wDT4ChQ9fzyXq8TRY9HD+BXiN+AdGve6Pmi4wt5ojFuuhaXmfQA0F25Kn6LoJaHdWCFWguZD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867445; c=relaxed/simple;
	bh=Aw2oRRNo/NaZ4cyyzflyZ/m5Yxz6p63nkI0y3oMDyw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFFskeMSxrWNnZWT8orTDYyvwebBJQ4InQHz6h+JCjq36CgbTeQX9ikR6VR/4mAbMf01UOk7dJDwKY688QdI+5sGAc2nDYFXcv9OKdFMxNnwidlmDkvm4/f6xoCrBg14wxg0CCKLcUG1C6h7bVmHEeyO5quVqjcVSpiKHOvOzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/7q2If5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707867442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+eevMmuC9SOCF4M+xKCE/zShHSwFbeelJYpzYu0hho=;
	b=U/7q2If5qpkCiXWZ2Ot4A1srSzPfWQZRlNzYVcSnnol8zZw9nav155IX+z8yE1a+qjeIeO
	0MRLKRYD5ax2nvduPtSGBkXSUKmUpOHpmvAzVJ5eXmY8C+uLuZIr0MGaaps9ARZSS1sFCV
	fb4nK38ymaTN4FWPLN90GvLV35yeQE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-LF2V7yGxP_K2HvlRFOKxMg-1; Tue, 13 Feb 2024 18:37:21 -0500
X-MC-Unique: LF2V7yGxP_K2HvlRFOKxMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCC20185A780;
	Tue, 13 Feb 2024 23:37:20 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E6848077;
	Tue, 13 Feb 2024 23:37:20 +0000 (UTC)
Date: Tue, 13 Feb 2024 17:37:19 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
Message-ID: <Zcv9L4t9t6QfAKJ0@redhat.com>
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
 <3252c311-8f8f-4e73-8e4a-92bc6daebc7b@themaw.net>
 <7cf58fb0-b13c-473c-b31c-864f0cac3754@kernel.org>
 <a312df58-4f52-44fe-8eec-92d34aaa46f2@themaw.net>
 <341e9b40-17b9-4607-8bac-693980c1ab75@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <341e9b40-17b9-4607-8bac-693980c1ab75@themaw.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Wed, Feb 14, 2024 at 07:31:09AM +0800, Ian Kent wrote:
> On 12/2/24 20:12, Ian Kent wrote:
> > On 12/2/24 09:13, Damien Le Moal wrote:
> > > On 2/11/24 12:36, Ian Kent wrote:
> > > > > > +static void zonefs_free_fc(struct fs_context *fc)
> > > > > > +{
> > > > > > +    struct zonefs_context *ctx = fc->fs_private;
> > > > > I do not think you need this variable.
> > > > That's a fair comment but it says fs_private contains the fs context
> > > > 
> > > > for the casual reader.
> > > > 
> > > > > > +
> > > > > > +    kfree(ctx);
> > > > > Is it safe to not set fc->fs_private to NULL ?
> > > > I think it's been safe to call kfree() with a NULL argument for ages.
> > > That I know, which is why I asked if *not* setting fc->fs_private to
> > > NULL after
> > > the kfree is safe. Because if another call to kfree for that pointer
> > > is done, we
> > > will endup with a double free oops. But as long as the mount API
> > > guarantees that
> > > it will not happen, then OK.
> > 
> > Interesting point, TBH I hadn't thought about it.
> > 
> > 
> > Given that, as far as I have seen, VFS struct private fields leave the
> > 
> > setting and freeing of them to the file system so I assumed that, seeing
> > 
> > this done in other mount api implementations, including ones written by
> > 
> > the mount api author, it was the same as other VFS cases.
> > 
> > 
> > But it's not too hard to check.
> 
> As I thought, the context private data field is delegated to the file
> system.
> 
> The usage here is as expected by the VFS.

Thanks for the reviews. I submitted a v2 patch.
Cheers-
Bill

> 
> 
> Ian
> 
> > 
> > 
> > Ian
> > 
> > > 
> > > > 
> > > > This could be done but so far the convention with mount api code
> > > > 
> > > > appears to have been to add the local variable which I thought was for
> > > > descriptive purposes but it could just be the result of cut and pastes.
> > > Keeping the variable is fine. After all, that is not the fast path :)
> > > 
> > > 
> > 
> 


