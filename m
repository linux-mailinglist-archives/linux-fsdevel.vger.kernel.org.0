Return-Path: <linux-fsdevel+bounces-34541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077359C6241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C075828415D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DB219CA1;
	Tue, 12 Nov 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSWQztis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92A209F2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442231; cv=none; b=lCRZbOn3D0z6uGcKl3TD8VEnNFEPXaQDC8kqUPKdpiHvos7x3JgVCI7PNnxr14EeMY1plMfin5JxuM4NKjeRMW6Bhn0jsXQvJHf6BlgdBeL9GT+v8R+tHIIQg+QlqdEUD5tXqZNftAEZHdSkbRN1T+n24pXFYeQMvZj81PZiax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442231; c=relaxed/simple;
	bh=lm2fWQdu2sVVztY4FJ5Hif/D7O5Ww+qRDoeXttY829s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+uGxflY7QgskZ9BatJlpt3D1VvSR1mYgK3HkUXhaqo+eGVlJY587chPk6C8D57tsAnitAclSLHVsAUVzQb46thnyvewdBHaKd5chhUyx9dWpU0N9nSMR0fM+cLmv21PbIRVAkD1huJ+pR1CD71bgBYB2cD4Ja03oB9/WBxqp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSWQztis; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731442228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQvCSgq64T+wf/TPNFDiNWUiao198TlsvJUEDfd6IKY=;
	b=NSWQztisbZ0LIJoaD9ezFzlx46g8WnrSlnbHgq+pgzKGan8o5ER0DWFplhJlLhQpmwKPaw
	c+nTgu7T+NqRLWzphpy08KJgBBcbQvRP96GhUZ47+2EG9NsfskVBpm4wdmSd9ioAymQ3AM
	UxZrIvfG7OjaVMOpfzT/WaLAvpej1ec=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-9wYFJSKuOy2Ip-OBMrooKw-1; Tue,
 12 Nov 2024 15:10:23 -0500
X-MC-Unique: 9wYFJSKuOy2Ip-OBMrooKw-1
X-Mimecast-MFC-AGG-ID: 9wYFJSKuOy2Ip-OBMrooKw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA06119560AF;
	Tue, 12 Nov 2024 20:10:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5554F1956086;
	Tue, 12 Nov 2024 20:10:18 +0000 (UTC)
Date: Tue, 12 Nov 2024 21:10:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, 
	Johannes Berg <johannes@sipsolutions.net>, rrs@debian.org
Subject: Re: UML mount failure with Linux 6.11
Message-ID: <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


 Hi,

On Mon, Nov 11, 2024 at 09:16:18AM GMT, Hongbo Li wrote:
> We are discussing about the hostfs mount with new mount API in [1]. And may
> need your help.
> 
> After finishing the conversion to the new mount API for hostfs, it
> encountered a situation where the old version supported only one mount
> option, and the whole mount option was used as the root path (it is also
> valid for the path to contain commas). But when switching to the new mount
> API, the option part will be split using commas (if I'm not mistaken, this
> step would be done in libmount), which could potentially split a complete
> path into multiple parts, and the call fsconfig syscall to set the mount
> options for underline filesystems. This is different from the original
> intention of hostfs. And this kind of situation is not common in other
> filesystems.

The options has been always parsed by mount(8) and it's very fragile
to assume that kernel get as in the original order (etc.). 

For decades, commas have been supported in mount options. For example,
SeLinux uses them frequently in context settings. All you need to do
is use quotes, but be careful because the shell will strip them off.
Therefore, double quoting is required.

   mount -o 'rw,bbb="this,is,value",ccc'

It's also supported in fstab, just use name="v,a,l,u,e"

You can try it:

 # strace -e fsconfig mount -t tmpfs -o 'rw,bbb="this,is,value",ccc' tmpfs /dontexist

 fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
 fsconfig(3, FSCONFIG_SET_FLAG, "rw", NULL, 0) = 0
 fsconfig(3, FSCONFIG_SET_STRING, "bbb", "this,is,value", 0) = -1 EINVAL 

You can see the expected result when using fsconfig().

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


