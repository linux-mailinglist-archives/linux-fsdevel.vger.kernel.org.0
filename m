Return-Path: <linux-fsdevel+bounces-6429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC01817D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4CEB2375C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB4740B7;
	Mon, 18 Dec 2023 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDsMDIIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486891DA3A;
	Mon, 18 Dec 2023 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702936659; x=1734472659;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UTSFwDQbGfcrEl1amDoPvVacSO4lCY7esjcaPwWu+8s=;
  b=hDsMDIIMxNDXWso+rRNEhmYd9g1qOqgorTRtIL2GMACS4adIBW0CEA+2
   HSlNuKF7kETrZAV96G4Z02dGgVOv40lcbdvDDOIojiuiGCZPadno0Pk3L
   nYCeC+qzt8r8Sz/pZ7rYi6rLHX5Dfg9DDYQJnW6BaZTbK8PtHb7aE81sB
   S6d1iTwxT/OjwmMleXyJajNh1OESHGQDF5ze+pLd6yG4hAhyei+7pnF/Y
   54Z/v0ZO7E2KKtiEBB9MDYD66ZTw9FHXU57Vh+jyNgRQzUBVYGwBEDBrA
   1TELq5RU3wap5D/yDs8ByhalrZaXjfizqn8P1KUdSsdomAzH/JSEXT0gi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="9019283"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="9019283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919408264"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="919408264"
Received: from jamesgou-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.213.162.171])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:57:34 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: hu1.chen@intel.com, miklos@szeredi.hu, malini.bhandaru@intel.com,
 tim.c.chen@intel.com, mikko.ylinen@intel.com, lizhen.you@intel.com,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Seth
 Forshee <sforshee@kernel.org>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
In-Reply-To: <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
 <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
Date: Mon, 18 Dec 2023 13:57:31 -0800
Message-ID: <875y0vp41g.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

>> > Yes, the important thing is that an object cannot change
>> > its non_refcount property during its lifetime -
>> 
>> ... which means that put_creds_ref() should assert that
>> there is only a single refcount - the one handed out by
>> prepare_creds_ref() before removing non_refcount or
>> directly freeing the cred object.
>> 
>> I must say that the semantics of making a non-refcounted copy
>> to an object whose lifetime is managed by the caller sounds a lot
>> less confusing to me.
>
> So can't we do an override_creds() variant that is effectively just:
>
> /* caller guarantees lifetime of @new */
> const struct cred *foo_override_cred(const struct cred *new)
> {
> 	const struct cred *old = current->cred;
> 	rcu_assign_pointer(current->cred, new);
> 	return old;
> }
>
> /* caller guarantees lifetime of @old */
> void foo_revert_creds(const struct cred *old)
> {
> 	const struct cred *override = current->cred;
> 	rcu_assign_pointer(current->cred, old);
> }
>
> Maybe I really fail to understand this problem or the proposed solution:
> the single reference that overlayfs keeps in ovl->creator_cred is tied
> to the lifetime of the overlayfs superblock, no? And anyone who needs a
> long term cred reference e.g, file->f_cred will take it's own reference
> anyway. So it should be safe to just keep that reference alive until
> overlayfs is unmounted, no? I'm sure it's something quite obvious why
> that doesn't work but I'm just not seeing it currently.

My read of the code says that what you are proposing should work. (what
I am seeing is that in the "optimized" cases, the only practical effect
of override/revert is the rcu_assign_pointer() dance)

I guess that the question becomes: Do we want this property (that the
'cred' associated with a subperblock/similar is long lived and the
"inner" refcount can be omitted) to be encoded in the constructor? Or do
we want it to be "encoded" in a call by call basis?

I can see both working.


Cheers,
-- 
Vinicius

