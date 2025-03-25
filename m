Return-Path: <linux-fsdevel+bounces-45008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B856A701F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D633E1882E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DCF25A651;
	Tue, 25 Mar 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU9OVafZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072631A5B8F
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907900; cv=none; b=ppYFGsLNWsj4D7On1HePKoKl3ou92PsO6H+AV7OvleuY5WzYYe2bOtZO71s3UQGBRvwi8pEMmd4ZADDh3MTEfpCYzQkKHNguFcNimeGpDa2GN9KjCAxyMUbvb9zPTB/S8/Q88Fu6h7IypQ6G/wHrAshcXQ1ZzDQIVtxSouVzYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907900; c=relaxed/simple;
	bh=KtXukF7zS507yXC0bV3Lgtc0k1fuYoFUyPiii35Srw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtpJh7K86uIJtOLs6oeLN8CeMVCXptnmj1XynAneFUAKPJFMtZTqV1nlYkoG88JkkXzHiKprkgUy3hCdlQpUUxTnXpA9Zm0fjkoQGGPZWFGOgnPzMk4yCu7JJI4RwbgpHJoKO+qujXz8qRHPDH2YZ4YFm8pM/zocSG39q/yOT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU9OVafZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742907897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a717aorAR0FFD6ZXSPKWzRFsANFSqFlPrG/xcqr9NTM=;
	b=YU9OVafZAgzynuL3xyL4Cf5Gx/TXMMkPm2thizX1ws8braLuDCE6Ic9w7YRV/u7goukamr
	+EsZ3825Nr4TWyZxUH3bQvgD1MsqAhA6Mmtd9vvY5RtYwyHDemcpStRi7mSbnp3m3c9A+q
	OF/BX3lWFSr9KV5j6jy6fodH+0N4aLI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-ONqfwzWAMceN_6i1pbI_rA-1; Tue,
 25 Mar 2025 09:04:54 -0400
X-MC-Unique: ONqfwzWAMceN_6i1pbI_rA-1
X-Mimecast-MFC-AGG-ID: ONqfwzWAMceN_6i1pbI_rA_1742907891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66D21956067;
	Tue, 25 Mar 2025 13:04:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 719BF19541A5;
	Tue, 25 Mar 2025 13:04:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 14:04:17 +0100 (CET)
Date: Tue, 25 Mar 2025 14:04:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250325130410.GA10828@redhat.com>
References: <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325121526.GA7904@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/25, K Prateek Nayak wrote:
>
> I chased this down to p9_client_rpc() net/9p/client.c specifically:
>
>         err = c->trans_mod->request(c, req);
>         if (err < 0) {
>                 /* write won't happen */
>                 p9_req_put(c, req);
>                 if (err != -ERESTARTSYS && err != -EFAULT)
>                         c->status = Disconnected;
>                 goto recalc_sigpending;
>         }
>
> c->trans_mod->request() calls p9_fd_request() in net/9p/trans_fd.c
> which basically does a p9_fd_poll().

Again, I know nothing about 9p... but if p9_fd_request() returns
an err < 0, then it comes from p9_conn->err and p9_fd_request()
does nothing else.

> Previously, the above would fail with err as -EIO which would
> cause the client to "Disconnect" and the retry logic would make
> progress. Now however, the err returned is -ERESTARTSYS

OK... So p9_conn->err = -ERESTARTSYS was set by p9_conn_cancel()
called by p9_write_work() because pipe_write() returns ERESTARTSYS?

But I don't understand -EIO with the reverted commit aaec5a95d59615

Oleg.


