Return-Path: <linux-fsdevel+bounces-27546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD7962511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26D81C20EAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909E16BE29;
	Wed, 28 Aug 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxmvhUIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296D1684B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841473; cv=none; b=ZoHdIUqyLibAub0shMpwywmrhd458IBymbqIiVLJSOG/AJye08r+lkBCaDwI0qhMAmFKVrjdEMAT2IkmItSHLtUmozeS6gnSqCRHdwDbwSh6h1JQbZBYRWIJ+NLC09V6K7p87wxkyk7X23BveIW36Q8e+121SLxJRrZaLzdY4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841473; c=relaxed/simple;
	bh=awO9DQBZwmRwy4r7lJ+MHeDWGPO1ch0i7FbvQQz5STw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fiejuaHV9YX2GrpfSTaDL7vwdphRcjPWOG4so5XRop/8uGYlA1Oceq43oAwSaqaGmJ5ueFZrtrFYydfM0YoloYa3s9CeVYzaAIJJFehZqRcumJ6kcLX/TPtR1NY46Fju7ov/LLjL2hYVYxafJHlVhHMy+YC/xLBJn5w7xLMNfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxmvhUIH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724841470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzUkFIussh+cyc5LHCiRLDkre+V+EO0118aAT2+MjKQ=;
	b=ZxmvhUIHcy6sVvF6sRt44C6GmAnweAwg3VZRk5rq/wsGXhW9ijMebUZtcYjCGg4J91BQi8
	5vqt4SIhkw0P8dXQz9cN6KZLU6xirWZceqPTWhQf9AYPAJKHNL0ag+JuA+AlPNWHpnmBi7
	4iPyUIw+p3hCJcLX4anXy4AFvGX4VLw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-xiNa3xA0NW2wayu8oJcNdg-1; Wed,
 28 Aug 2024 06:37:46 -0400
X-MC-Unique: xiNa3xA0NW2wayu8oJcNdg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E17A1955D4C;
	Wed, 28 Aug 2024 10:37:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58CDF1955D56;
	Wed, 28 Aug 2024 10:37:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240826113404.3214786-1-libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
To: libaokun@huaweicloud.com
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    linux-erofs@lists.ozlabs.org, brauner@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
    wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
    stable@kernel.org
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <952422.1724841455.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Aug 2024 11:37:35 +0100
Message-ID: <952423.1724841455@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

libaokun@huaweicloud.com wrote:

> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs=
',
> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> deleting its subtree. This triggers the following WARNING:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at l=
east 'requests'
> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x16=
0/0x1c0
> Modules linked in: netfs(-)
> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> RIP: 0010:remove_proc_entry+0x160/0x1c0
> Call Trace:
>  <TASK>
>  netfs_exit+0x12/0x620 [netfs]
>  __do_sys_delete_module.isra.0+0x14c/0x2e0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
> fix the above problem.
> =

> Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/=
netfs and put in a symlink")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Should remove_proc_entry() just remove the entire subtree anyway?

But you can add:

	Acked-by: David Howells <dhowells@redhat.com>

David


