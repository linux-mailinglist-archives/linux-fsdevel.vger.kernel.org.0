Return-Path: <linux-fsdevel+bounces-34845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B519C93A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 22:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A21F243E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 21:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BBC1ADFF8;
	Thu, 14 Nov 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9/6YK4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C272BD04;
	Thu, 14 Nov 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618081; cv=none; b=B6kkiE3iO/cmldtu0L3r5eglpnL91nl2xI1uDlmAcYd4P2uSHhV8yMXb4xSbPD8mvcn5Y9uwkhzCVcvNSXPLdhAQQ8sbyla0tF8FieRh8N86sgYbpXPqntXJh8yjAXRztSnFT8mfDN4sAIe6OnCnjtyWPPUcgrhadltOFQJuvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618081; c=relaxed/simple;
	bh=0Xa51NQBmIFxJI/7q1BAtFG5/NjjcxuIeZfJ/7Nn0gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMgNx07seFA+MJyrJKuXsYIs6vwYJic2aLVZ4ukVBZs4b7TCVbtVXqzLmnr6JMiyG0NY+xTqdCKUn+mYQx982hJQ1LshHvv4wILJz/5S2heVkZxiYWxvlDdzcfVWe7DS/tOB9bxphA1pD0kIlQbHfETQsNZuhp9tCFdTfsEal4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9/6YK4n; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731618080; x=1763154080;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=0Xa51NQBmIFxJI/7q1BAtFG5/NjjcxuIeZfJ/7Nn0gI=;
  b=K9/6YK4nweuuX+l/RGZUXiwYlji6zf5C+yc59CoFiRSRpNSLIg/OuRy4
   9jzZxxFGHVxAcYmKFvW9prucKWQMm0t4MnDhpwtyg1piCtjednxsAqoXq
   dKjC8JdaUsYv/SjbJ1SqlZ/Cq6YY6KtjqjanmTfXsFrk/9s9lkF3wbfej
   QHE29YG1+6D4aTlkF6bFRVLF3OFeDwLFNYzEn2kMwIdPdEtrDZmuZuHZj
   zIk2RXMMJS5axV9+N4wEOZQapY5l/t8otMgePT+2I+TIQQNahVNwrdgH6
   F3Fo9tzPJkXSkkTAeiFdmXmSLM+4dNPWbbVNeoHzUNNpwYSR1NlHoYHCC
   A==;
X-CSE-ConnectionGUID: enKjyZLNREKGZk35PP+y4g==
X-CSE-MsgGUID: gQDUACC8Sq6D24IcBex2/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42982411"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42982411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 13:01:19 -0800
X-CSE-ConnectionGUID: svpUZT0nSKS/hiaIa8I6dQ==
X-CSE-MsgGUID: O8qaj1ypQ8aFie3ZoxYChA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="93403296"
Received: from unknown (HELO vcostago-mobl3) ([10.241.226.11])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 13:01:19 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
In-Reply-To: <CAOQ4uxiXt4Y=fP+nUfbKkf46of4em633Dmd+iUCFyB=5ijvHdw@mail.gmail.com>
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
 <20241107005720.901335-5-vinicius.gomes@intel.com>
 <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
 <87ldxnrkxw.fsf@intel.com>
 <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
 <CAOQ4uxiXt4Y=fP+nUfbKkf46of4em633Dmd+iUCFyB=5ijvHdw@mail.gmail.com>
Date: Thu, 14 Nov 2024 13:01:18 -0800
Message-ID: <87h689sf6p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Nov 14, 2024 at 9:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
>>
>> On Wed, Nov 13, 2024 at 8:30=E2=80=AFPM Vinicius Costa Gomes
>> <vinicius.gomes@intel.com> wrote:
>> >
>> > Amir Goldstein <amir73il@gmail.com> writes:
>> >
>> > > On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
>> > > <vinicius.gomes@intel.com> wrote:
>> >
>> > [...]
>> >
>> > >
>> > > Vinicius,
>> > >
>> > > While testing fanotify with LTP tests (some are using overlayfs),
>> > > kmemleak consistently reports the problems below.
>> > >
>> > > Can you see the bug, because I don't see it.
>> > > Maybe it is a false positive...
>> >
>> > Hm, if the leak wasn't there before and we didn't touch anything relat=
ed to
>> > prepare_creds(), I think that points to the leak being real.
>> >
>> > But I see your point, still not seeing it.
>> >
>> > This code should be equivalent to the code we have now (just boot
>> > tested):
>> >
>> > ----
>> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
>> > index 136a2c7fb9e5..7ebc2fd3097a 100644
>> > --- a/fs/overlayfs/dir.c
>> > +++ b/fs/overlayfs/dir.c
>> > @@ -576,8 +576,7 @@ static int ovl_setup_cred_for_create(struct dentry=
 *dentry, struct inode *inode,
>> >          * We must be called with creator creds already, otherwise we =
risk
>> >          * leaking creds.
>> >          */
>> > -       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dent=
ry->d_sb));
>> > -       put_cred(override_cred);
>> > +       WARN_ON_ONCE(override_creds_light(override_cred) !=3D ovl_cred=
s(dentry->d_sb));
>> >
>> >         return 0;
>> >  }
>> > ----
>> >
>> > Does it change anything? (I wouldn't think so, just to try something)
>>
>> No, but I think this does:
>>
>
> Vinicius,
>
> Sorry, your fix is correct. I did not apply it properly when I tested.
>
> I edited the comment as follows and applied on top of the patch
> that I just sent [1]:
>

I just noticed there's a typo in the first sentence of the commit
message, the function name that we are using revert_creds_light() is
ovl_revert_creds(). Could you fix that while you are at it?

Glad that the fix works:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>
> -       put_cred(override_creds(override_cred));
> +
> +       /*
> +        * Caller is going to match this with revert_creds_light() and dr=
op
> +        * reference on the returned creds.
> +        * We must be called with creator creds already, otherwise we risk
> +        * leaking creds.
> +        */
> +       old_cred =3D override_creds_light(override_cred);
> +       WARN_ON_ONCE(old_cred !=3D ovl_creds(dentry->d_sb));
>
>         return override_cred;
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-unionfs/20241114100536.628162-1-amir73i=
l@gmail.com/

--=20
Vinicius

