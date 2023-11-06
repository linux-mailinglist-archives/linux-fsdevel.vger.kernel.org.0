Return-Path: <linux-fsdevel+bounces-2083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1767E2102
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E27B208F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703521EB4B;
	Mon,  6 Nov 2023 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSVmI81I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD01EB36
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C9173C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 04:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699272661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bFqlESwPJo1XpM6rSXjb9JYObqnfNl5+smLVo9k46Wo=;
	b=YSVmI81IaDQfvpnUuSMLcJqlfYN/rZVJMMXhiHdkaJNqbY1NdhLcAp03a/neBcWWcj821f
	ty0HZQi4Hvr6FdEL3PETzm7P3iK4Zn+gxEjeCppeEUmRE1GmXOIKi3+TNzCJ4P7eEbKwY1
	wpLC/L10mbz/e1IhAXgy1tVXvZXZJvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-UylgK2iQOROjE5ju1YmJxw-1; Mon, 06 Nov 2023 07:10:58 -0500
X-MC-Unique: UylgK2iQOROjE5ju1YmJxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E7C7185A781;
	Mon,  6 Nov 2023 12:10:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.1])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EC66492BE0;
	Mon,  6 Nov 2023 12:10:55 +0000 (UTC)
Date: Mon, 6 Nov 2023 13:10:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/6] querying mount attributes
Message-ID: <20231106121053.egamth3hr7zcfzji@ws.net.home>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <374433e3-ab72-64a3-0fa0-ab455268e5e0@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374433e3-ab72-64a3-0fa0-ab455268e5e0@themaw.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, Nov 01, 2023 at 07:52:45PM +0800, Ian Kent wrote:
> On 25/10/23 22:01, Miklos Szeredi wrote:
> Looks ok to me,covers the primary cases I needed when I worked
> on using fsinfo() in systemd.

Our work on systemd was about two areas: get mount info (stat/listmount()  
now) from the kernel, and get the mount ID from notification.                 

There was watch_queue.h with WATCH_TYPE_MOUNT_NOTIFY and struct       
mount_notification->auxiliary_mount (aka mount ID) and event subtype  
to get the change status (new mount, umount, etc.) 

For example David's:
 https://patchwork.kernel.org/project/linux-security-module/patch/155991711016.15579.4449417925184028666.stgit@warthog.procyon.org.uk/

Do we have any replacement for this?

> Karel, is there anything missing you would need for adding
> libmount support?

Miklos's statmount() and listmount() API is excellent from my point of
view. It looks pretty straightforward to use, and with the unique
mount ID, it's safe too. It will be ideal for things like umount(8)
(and recursive umount, etc.).

For complex scenarios (systemd), we need to get from the kernel the
unique ID's after any change in the mount table to save resources and
call statmount() only for the affected mount node. Parse mountinfo
sucks, call for(listmount(-1)) { statmount() } sucks too :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


