Return-Path: <linux-fsdevel+bounces-3215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169937F1779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D8CB21903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9621DA26;
	Mon, 20 Nov 2023 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XggcxYpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5901D546;
	Mon, 20 Nov 2023 15:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDA8C433C8;
	Mon, 20 Nov 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700494691;
	bh=V/gEbXHf7msuIYmekR4+CzwjOqMIaKw26uDtvj0+qFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XggcxYpdOUX2bbB8XTJAwJYcatmv0J9n0vYM4cR4w7viqBhtBRsz7CTZ9T+cqbUIL
	 44Aj/5aqonkcHTjvUrEjR9s7FRvivyFau/DZyMdBS/23foob8BJ18/ODKMotPsNt90
	 ka20WHes20fBe0hfg9bWBTKJgBGDgfLFduMUGGkUN0JjrhUp6BnEsqMYOdWsB7tTmQ
	 zq8iL6dA/lgOiTSC/pL35W7gUFWVkWnIy23mqKPPHpuFnE8aati9dM7xDgw8TDXBqS
	 DEGdC6qmJZW4mq8vl5J0WeOmqNuAzsCtqvbD6Fak09QFFxc95clvVGo4nC4Xa+cBRL
	 +yow5ssMmjaNw==
Date: Mon, 20 Nov 2023 16:38:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
	linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Message-ID: <20231120-wachhalten-darfst-ed3244509881@brauner>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>

On Mon, Nov 20, 2023 at 12:55:17PM +0100, Miklos Szeredi wrote:
> On Fri, Nov 17, 2023 at 04:50:25PM +0100, Miklos Szeredi wrote:
> > I wonder... Is there a reason this shouldn't be done statelessly by
> > adding an "continue after this ID" argument to listmount(2)?  The
> > caller will just need to pass the last mount ID received in the array
> > to the next listmount(2) call and iterate until a short count is
> > returned.
> 
> No comments so far... maybe more explanation is needed.
> 
> New signature of listmount() would be:
> 
> ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
> 		  uint64_t *buf, size_t bufsize, unsigned int flags);
> 
> And the usage would be:
> 
> 	for (last = 0; nres == bufsize; last = buf[bufsize-1]) {
> 		nres = listmount(parent, last, buf, bufsize, flags);
> 		for (i = 0; i < nres; i++) {
> 			/* process buf[i] */
> 		}
> 	}
> 
> 
> Here's a kernel patch against the version in Christian's tree.  The syscall
> signature doesn't need changing, since we have a spare u64 in the mnt_id_req for
> listmount.
> 
> The major difference is in the order that the mount ID's are listed, which is
> now strictly increasing.  Doing the recursive listing in DFS order is nicer, but
> I don't think it's important enough.
> 
> Comments?

Sure. We can also add a size argument to struct mnt_id_req then you can
version it by size and extend it easily later (see sched_{g,s}etattr()
that do similar things):

struct mnt_id_req {
	__u32 size;
	__u64 mnt_id;
	__u64 request_mask;
	union {
		__u64 request_mask;
		__u64 last_mnt_id;
	};
};

foo(struct mnt_id_req __user *ureq)
{
	u32 size;
	struct mnt_id_req kreq;

	ret = get_user(size, &ureq->size);
	if (ret)
		return ret;

        if (size < MNT_ID_REQ_SIZE_VER0 || size > PAGE_SIZE)
		return -EINVAL;

	ret = copy_struct_from_user(&kreq, sizeof(kreq), ureq, size);
	if (ret)
		return ret;
}

