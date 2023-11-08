Return-Path: <linux-fsdevel+bounces-2403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E067E5B1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 17:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3722814F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11231A87;
	Wed,  8 Nov 2023 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYeExoDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9B19440;
	Wed,  8 Nov 2023 16:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4246DC433C7;
	Wed,  8 Nov 2023 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699460630;
	bh=5fCZ7rfSZquKbxbTGp5RqeJxHmLnbRIpmC4Rako2Cbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYeExoDLkAvqSJ4k1lO/O2P+CeHBKbCD4mJ4+iKYa38HxVDUPABfB68PaWmLFU1e9
	 3W2uEdfmcCBTcynPc7mmK7ncwGZ2M+xB5QXbYdjYAyVGtOROdV/bUaDVoWrvuPhIU7
	 e517oi+/Qz8DJJmx5ueVxPfwspRnATj51B1MT7AGfCKJSuZO+8ZDfoXAQOqt48b16O
	 tn1JLWnWGtW0PJhhOVRxryTAw2y4TIQritCcjVEINSv2lCL9esiXJE209MDtHxO1n6
	 rfR+RkLs6iQwXnTXoS8cAM01JNeG4lkE4xHA6PoVVmmM+xatQZTQQl7a88jMyCUnye
	 SV8juozs13ORQ==
Date: Wed, 8 Nov 2023 17:23:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Message-ID: <20231108-grinsen-entfachen-f04195b92e7d@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <87il6d1cmu.fsf@meer.lwn.net>
 <20231108-redakteur-zuschauen-a9aeafaf4fad@brauner>
 <87o7g4xlmb.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7g4xlmb.fsf@meer.lwn.net>

On Wed, Nov 08, 2023 at 09:20:28AM -0700, Jonathan Corbet wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> >> Why use struct __mount_arg (or struct mnt_id_req :) here rather than
> >> just passing in the mount ID directly?  You don't use the request_mask
> >
> > Please see Arnd's detailed summary here:
> > https://lore.kernel.org/lkml/44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com
> 
> Ah, makes sense, I'd missed that.
> 
> Given this, though, it seems like maybe sys_listmount() should enforce
> that req->request_mask==0 ?

Good catch, it does now:

diff --git a/fs/namespace.c b/fs/namespace.c
index ae09321b0f72..21edddd75532 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5030,6 +5030,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,

        if (copy_from_user(&kreq, req, sizeof(kreq)))
                return -EFAULT;
+       if (kreq.request_mask != 0)
+               return -EINVAL;
        mnt_id = kreq.mnt_id;

        down_read(&namespace_sem);

