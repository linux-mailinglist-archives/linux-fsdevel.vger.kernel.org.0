Return-Path: <linux-fsdevel+bounces-45082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F4A716DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 13:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3854D188A0C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7811E51EC;
	Wed, 26 Mar 2025 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTVRq0fN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC857C9F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993095; cv=none; b=GWGiWjm2YhQNkU4KQQbYvueE/VxkCGxx8EHrjzjW501nMH0LPo6mvNuMGlNPbXfQmHxZvOzQYZrL4K4PYnD0oxBVWSg63GnHiIiv7wYmkmvokTdqNZfo/l0XDAJF2aRcwEfECr+no+snRXdUrQIOj5IeZJWIJHlrKlGtu8/PCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993095; c=relaxed/simple;
	bh=XKWMPLPo1WH5vVWYpjrlZj/2ZgPVqf4aRksu4KN91vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne1z9M4QNeC21SyMgBLCoymsTJb7+HTck6Zzk9P4K04nhEs5PaBIJRnFn5xwecGIAoS3lPOPuoHqCktU2jZ4SDFXTXYeG8D7TS3CwkUJRoZOBKPJ6lfdFt8m/8CMgJwgsO2ebz/pCUj3iR86aUGgDPGwMrgQb+gTP2BnG7E6Btc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTVRq0fN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742993092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fvRV+vXgcsKP9jFTuEcTFLOervcwZLIt7LcD5mec5E=;
	b=GTVRq0fNEw+kFJT8K4WJi3bJFI7pA/cqq+fN3XRHhw+hVyFcxp43uGtYgDptXPlD23TxDo
	nBhvmh1PvZCEss8+2jlcP1tcFX4nUHYOI4ZZfViBbL5CRyNmem+5FZZNpcQufkjoaVHZps
	fWC7u/ngGRXyNLENwPYjVb9VwUC2kQE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-t5IosiLiOCGREskSV5Cxig-1; Wed,
 26 Mar 2025 08:44:47 -0400
X-MC-Unique: t5IosiLiOCGREskSV5Cxig-1
X-Mimecast-MFC-AGG-ID: t5IosiLiOCGREskSV5Cxig_1742993085
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64F7119560B0;
	Wed, 26 Mar 2025 12:44:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A0B1419560AB;
	Wed, 26 Mar 2025 12:44:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Mar 2025 13:44:11 +0100 (CET)
Date: Wed, 26 Mar 2025 13:44:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250326124402.GD30181@redhat.com>
References: <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
 <20250325130410.GA10828@redhat.com>
 <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
 <Z-LEsPFE4e7TTMiY@codewreck.org>
 <20250326121946.GC30181@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326121946.GC30181@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/26, Oleg Nesterov wrote:
>
> Hmm... I don't understand why the 2nd vfs_poll(ts->wr) depends on the
> ret from vfs_poll(ts->rd), but I assume this is correct.

I meant, if pt != NULL and ts->rd != ts->wr we need both
vfs_poll(ts->rd) and vfs_poll(ts->wr) ?

and the reproducer writes to the pipe before it mounts 9p...

Prateek, this is just a shot in the dark but since you can reproduce,
can you check if the patch below makes any difference?

Oleg.

--- x/net/9p/trans_fd.c
+++ x/net/9p/trans_fd.c
@@ -234,8 +234,10 @@ p9_fd_poll(struct p9_client *client, str
 	}
 
 	ret = vfs_poll(ts->rd, pt);
-	if (ts->rd != ts->wr)
+	if (ts->rd != ts->wr) {
+		if (pt != NULL) vfs_poll(ts->wr, pt);
 		ret = (ret & ~EPOLLOUT) | (vfs_poll(ts->wr, pt) & ~EPOLLIN);
+	}
 	return ret;
 }
 


