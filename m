Return-Path: <linux-fsdevel+bounces-12030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF885A716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD01B1F21F26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71F3DBB3;
	Mon, 19 Feb 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHeFqz1Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAE20319
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355456; cv=none; b=Ody9WeZPEBtgjyvPz5xwPzoPN81oGHJXEfvKKJqZ88G+iKXjbxDTwF5jKhalwNVLDOCsPhvWp/xWGpSUYMCirwzSreSqFZ/YMlTuWfSZ2gQBIcNts09tAXdTXyPrvGPm8O8V6UxKxZzlV3yXS/uSLafwCx3oOzJul18HxvzD1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355456; c=relaxed/simple;
	bh=o6fyOf6G7BhIiVO7M4QfgNflaD8M9HcGvUR8Y5llcxQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rwjlUaSHc32csEGFDZfIYJ2gg6fsSwie/x9jaHUL0AhfHP+HRLzNxe/VoMvpAIizMykOLMBEOUcL7ikejw/Sp49t3Y9iev3Avuvrq08SWGxNwZoLTm93gnRr8gUJWa7WBmcQN6rVqBTNQUul5juDF/SUfVGqcYbiNVZbHcxLVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHeFqz1Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708355451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSqXWjK+LddXqIK8pJkcj8gOwnFmQLsFMFK0s1Et2YI=;
	b=PHeFqz1QOKPIG+Cjl9/hzX5DZxxt6BpiPkRF7YpOCHdl9JS8Xe5W/GmWzr2CDqLXDBcqAF
	kWywxkQ9K4YELKCj67rDDgt4T5xgq6K0M96I08BH3Xn9wWAQPGvSRmR0/GhXMnCy7eCvHO
	Y9TuP3WfiDbKhRkFIxD5LejPTDPFQVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-H-vk5ZXBOuiyEmjzhFTpBQ-1; Mon, 19 Feb 2024 10:10:48 -0500
X-MC-Unique: H-vk5ZXBOuiyEmjzhFTpBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7698881C87;
	Mon, 19 Feb 2024 15:10:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 014748077;
	Mon, 19 Feb 2024 15:10:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240209105947.GF1516992@kernel.org>
References: <20240209105947.GF1516992@kernel.org> <20240205225726.3104808-1-dhowells@redhat.com> <20240205225726.3104808-10-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH v5 09/12] cifs: Cut over to using netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <140601.1708355444.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 15:10:44 +0000
Message-ID: <140602.1708355444@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Simon Horman <horms@kernel.org> wrote:

> >  /* Functions related to files and directories */
> > +extern const struct netfs_request_ops cifs_req_ops;
> >  extern const struct file_operations cifs_file_ops;
> >  extern const struct file_operations cifs_file_direct_ops; /* if direc=
tio mnt */
> >  extern const struct file_operations cifs_file_strict_ops; /* if stric=
tio mnt */
> =

> Nit: this hunk would probably be better placed in the
>      patch at adds cifs_req_ops to fs/smb/client/file.c

I'm not sure I understand what you mean.  Is there a bit missing between "=
at"
and "adds" in that?

David


