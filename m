Return-Path: <linux-fsdevel+bounces-1115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF957D5A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E011AB21055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCEE3B2BD;
	Tue, 24 Oct 2023 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMr6o4nO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1518273CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 18:01:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691DA10DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698170462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rRUTdijOYZODyhIUu5lwhM1sh+LeLiZh2xcrppa9E0=;
	b=JMr6o4nOJcQoe+m3kzgZ6lKB1YBCZJTcZrTqNXaEUwzX1SrAil1EL3S4mk6xeeafMUbbS8
	GMgFU87utQozRVASzWH+2dtPpsD99jPuEvF/rKCephz+iPfVZrciIpWd6nFYYrne7ox/TW
	9vCREjBfFDHg0u7/N57r/ypNV//O740=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-qDrhfe1EOneTbvC3vZXt9Q-1; Tue, 24 Oct 2023 14:00:57 -0400
X-MC-Unique: qDrhfe1EOneTbvC3vZXt9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34D82857A86;
	Tue, 24 Oct 2023 18:00:56 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 883682026D4C;
	Tue, 24 Oct 2023 18:00:54 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: derive f_fsid from server's fsid
Date: Tue, 24 Oct 2023 14:00:53 -0400
Message-ID: <41F5B54F-0345-4C44-99FB-6E2A6C9F365C@redhat.com>
In-Reply-To: <CAOQ4uxho0ryGuq7G+LaoTvqHRR_kg2fCNL2sGMLvNujODA8YPQ@mail.gmail.com>
References: <20231024110109.3007794-1-amir73il@gmail.com>
 <1CFE0178-CE91-4C99-B43E-33EF78D0BEBF@redhat.com>
 <CAOQ4uxhe5pH3yRxFS_8pvtCgbXspKB6r9aacRJ8FysGQE2Hu9g@mail.gmail.com>
 <2382DA9B-D66B-41D9-8413-1C5319C01165@redhat.com>
 <CAOQ4uxho0ryGuq7G+LaoTvqHRR_kg2fCNL2sGMLvNujODA8YPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 24 Oct 2023, at 13:12, Amir Goldstein wrote:
> On Tue, Oct 24, 2023 at 6:32 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>> Yes, but if the specific export is on the same server's filesystem as the
>> "root", you'll still get zero.  There are various ways to set fsid on
>> exports for linux servers, but the fsid will be the same for all exports of
>> the same filesystem on the server.
>>
>
> OK. good to know. I thought zero fsid was only for the root itself.

Yes, but by "root" here I always mean the special NFSv4 root - the special
per-server global root filehandle.

...

>> I'm not familiar with fanotify enough to know if having multiple fsid 0
>> mounts of different filesystems on different servers will do the right
>> thing.  I wanted to point out that very real possibility for v4.
>>
>
> The fact that fsid 0 would be very common for many nfs mounts
> makes this patch much less attractive.
>
> Because we only get events for local client changes, we do not
> have to tie the fsid with the server's fsid, we could just use a local
> volatile fsid, as we do in other non-blockdev fs (tmpfs, kernfs).

A good way to do this would be to use the nfs_server->s_dev's major:minor -
this represents the results of nfs_compare_super(), so it should be the same
value if NFS is treating it as the same filesystem.

> I am not decisive about the best way to tackle this and since
> Jan was not sure about the value of local-only notifications
> for network filesystems, I am going to put this one on hold.
>
> Thanks for the useful feedback!

Sure!

Ben


