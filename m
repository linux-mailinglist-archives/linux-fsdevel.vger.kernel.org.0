Return-Path: <linux-fsdevel+bounces-6389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C75817784
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37701C23BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26842363;
	Mon, 18 Dec 2023 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE4tIxcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9423D7;
	Mon, 18 Dec 2023 16:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E9CC433C7;
	Mon, 18 Dec 2023 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702917043;
	bh=vzJT46XWAVR+AYyo+bbvE2VcoW5+6hnEFuhEHPUf3Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eE4tIxcMGFAtSKGwxbvZXUWQQVXG25HLFk+23hKD4QEh478DYEcoxuBtITIQ80JBv
	 u748CUw6imyf5u9biVlTwpp7vMSI33GzO07N2Oabx5VE+cPomvTyooCfsNov3lt+3Y
	 1GJ2B1PC0Zec/q+39Xy+hMNeFeNqkloRnxT50fQH5+GHxBP1M34aQHZBTkGIzSY4rX
	 DapjFUR4dGx+q65ccAmWNXwp1UmCbDOwtRVV4GcoryyuKFyhVHoBGMwvE+ItHxDqgb
	 cfaYsZU/JCfkk4y+FAfdouXbXfYaTmMQXT5L8q4/1iI8RerVtqjq2KRyz0nbpNsSMe
	 3TGVinTNMlfag==
Date: Mon, 18 Dec 2023 17:30:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, hu1.chen@intel.com,
	miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com,
	mikko.ylinen@intel.com, lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
Message-ID: <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>

> > Yes, the important thing is that an object cannot change
> > its non_refcount property during its lifetime -
> 
> ... which means that put_creds_ref() should assert that
> there is only a single refcount - the one handed out by
> prepare_creds_ref() before removing non_refcount or
> directly freeing the cred object.
> 
> I must say that the semantics of making a non-refcounted copy
> to an object whose lifetime is managed by the caller sounds a lot
> less confusing to me.

So can't we do an override_creds() variant that is effectively just:

/* caller guarantees lifetime of @new */
const struct cred *foo_override_cred(const struct cred *new)
{
	const struct cred *old = current->cred;
	rcu_assign_pointer(current->cred, new);
	return old;
}

/* caller guarantees lifetime of @old */
void foo_revert_creds(const struct cred *old)
{
	const struct cred *override = current->cred;
	rcu_assign_pointer(current->cred, old);
}

Maybe I really fail to understand this problem or the proposed solution:
the single reference that overlayfs keeps in ovl->creator_cred is tied
to the lifetime of the overlayfs superblock, no? And anyone who needs a
long term cred reference e.g, file->f_cred will take it's own reference
anyway. So it should be safe to just keep that reference alive until
overlayfs is unmounted, no? I'm sure it's something quite obvious why
that doesn't work but I'm just not seeing it currently.

