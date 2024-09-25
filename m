Return-Path: <linux-fsdevel+bounces-30095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A3986175
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EAB1F2AB42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD10188584;
	Wed, 25 Sep 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWlhs6Br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40F282FD;
	Wed, 25 Sep 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273845; cv=none; b=p+dOqDDgqinoq7mwc6ltdQ95RwYRe4I+DpKkqKU+mZKfuPSfxTR/vkl6S8vUHZJjdSh5xvCfmq/NeM+uKBSj/Mz6CASIqbHHmqmsMq0ExGXNoVtXKqX929wkX8Wl509iDjYbpPU2jc28ZftEFSZgcn9jq/q0ArDGSIPGm9MF9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273845; c=relaxed/simple;
	bh=OlkeQTPorZrC/+fkJlrtFsckAz58CEKPkG61d+T1guA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BndLcXvfROCsp/sq0Pbi0DDZCzuEqjjsMrZFLIyBpCuzLATkl9nWRBNqMPSI/JBcXpcZr9s2NtaUngXHHa2EcV8ffBg86BcKqpOXtVUNT/gGjCxBH1cCJTWzo5HHFRg0FqJPQXhj7M414FxsqHOod/6cyd0MX6XozZp55NYhhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWlhs6Br; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727273844; x=1758809844;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OlkeQTPorZrC/+fkJlrtFsckAz58CEKPkG61d+T1guA=;
  b=JWlhs6Bri9SY88SDEJe71/sLOYKfkkpN+R27lubEl/euAvEh110sfW5p
   1qgymIHd2Ace8KcvANK7IRhD3QIEsBQfeCYJB+1GokwBGlhf/6FiluCVR
   7SwG0ca78xGs2iz4vjZ8lFabw1FXGzK4FLkf5IuUEYVPlXcVF89u0vN2G
   vqBh55JMhALXm/RKTvucoLNx6c6YXaYj5QkfBwkBOd3cjkjTKa6Y7Vm/9
   KKUSyM+tw90L64gvlKRh52yVQEWOg/5C3zf5QRdREBXTH7BSqOY2ohQz+
   bFqSDW5UgMiVFjoNHydsGSxGISGcuBQ7viFnP4/SDCztWOgbF0IEDK5+4
   w==;
X-CSE-ConnectionGUID: 3OI3YHvdTg++8LFHQBWKhQ==
X-CSE-MsgGUID: plsNVX9tRYaqt7GiJQisog==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37466465"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="37466465"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:17:23 -0700
X-CSE-ConnectionGUID: GUI/zqUlQ8m7CNfmoi47bg==
X-CSE-MsgGUID: u4mLht3jRsaQgu7mKP7uxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="102558425"
Received: from hcaldwel-desk1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.154])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:17:18 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, amir73il@gmail.com,
 hu1.chen@intel.com, malini.bhandaru@intel.com, tim.c.chen@intel.com,
 mikko.ylinen@intel.com, lizhen.you@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds()
 operations
In-Reply-To: <20240925-umweht-schiffen-252e157b67f7@brauner>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-5-vinicius.gomes@intel.com>
 <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
 <87wmk2lx3s.fsf@intel.com> <87h6a43gcc.fsf@intel.com>
 <20240925-umweht-schiffen-252e157b67f7@brauner>
Date: Wed, 25 Sep 2024 11:17:15 -0300
Message-ID: <87bk0b3jis.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Sep 24, 2024 at 06:13:39PM GMT, Vinicius Costa Gomes wrote:
>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> 
>> > Miklos Szeredi <miklos@szeredi.hu> writes:
>> >
>> >> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
>> >> <vinicius.gomes@intel.com> wrote:
>> >>>
>> >>> Add a comment to these operations that cannot use the _light version
>> >>> of override_creds()/revert_creds(), because during the critical
>> >>> section the struct cred .usage counter might be modified.
>> >>
>> >> Why is it a problem if the usage counter is modified?  Why is the
>> >> counter modified in each of these cases?
>> >>
>> >
>> > Working on getting some logs from the crash that I get when I convert
>> > the remaining cases to use the _light() functions.
>> >
>> 
>> See the log below.
>> 
>> > Perhaps I was wrong on my interpretation of the crash.
>> >
>> 
>> What I am seeing is that ovl_setup_cred_for_create() has a "side
>> effect", it creates another set of credentials, runs the security hooks
>> with this new credentials, and the side effect is that when it returns,
>> by design, 'current->cred' is this new credentials (a third set of
>> credentials).
>
> Well yes, during ovl_setup_cred_for_create() the fs{g,u}id needs to be
> overwritten. But I'm stil confused what the exact problem is as it was
> always clear that ovl_setup_cred_for_create() wouldn't be ported to
> light variants.
>
> /me looks...
>
>> 
>> And this implies that refcounting for this is somewhat tricky, as said
>> in commit d0e13f5bbe4b ("ovl: fix uid/gid when creating over whiteout").
>> 
>> I see two ways forward:
>> 
>> 1. Keep using the non _light() versions in functions that call
>>    ovl_setup_cred_for_create().
>> 2. Change ovl_setup_cred_for_create() so it doesn't drop the "extra"
>>    refcount.
>> 
>> I went with (1), and it still sounds to me like the best way, but I
>> agree that my explanation was not good enough, will add the information
>> I just learned to the commit message and to the code.
>> 
>> Do you see another way forward? Or do you think that I should go with
>> (2)?
>
> ... ok, I understand. Say we have:
>
> ovl_create_tmpfile()
> /* current->cred == ovl->creator_cred without refcount bump /*
> old_cred = ovl_override_creds_light()
> -> ovl_setup_cred_for_create()
>    /* Copy current->cred == ovl->creator_cred */
>    modifiable_cred = prepare_creds()
>
>    /* Override current->cred == modifiable_cred */
>    mounter_creds = override_creds(modifiable_cred)
>
>    /*
>     * And here's the BUG BUG BUG where we decrement the refcount on the
>     * constant mounter_creds.
>     */
>    put_cred(mounter_creds) // BUG BUG BUG
>
>    put_cred(modifiable_creds)
>
> So (1) is definitely the wrong option given that we can get rid of
> refcount decs and incs in the creation path.
>
> Imo, you should do (2) and add a WARN_ON_ONC(). Something like the
> __completely untested__:
>

> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ab65e98a1def..e246e0172bb6 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -571,7 +571,12 @@ static int ovl_setup_cred_for_create(struct dentry *dentry, struct inode *inode,
>                 put_cred(override_cred);
>                 return err;
>         }
> -       put_cred(override_creds(override_cred));
> +
> +       /*
> +        * We must be called with creator creds already, otherwise we risk
> +        * leaking creds.
> +        */
> +       WARN_ON_ONCE(override_creds(override_cred) != ovl_creds(dentry->d_sb));
>         put_cred(override_cred);
>
>         return 0;
>

At first glance, looks good. Going to test it and see how it works.
Thank you.

For the next version of the series, my plan is to include this
suggestion/change and remove the guard()/scoped_guard() conversion
patches from the series.


Cheers,
-- 
Vinicius

