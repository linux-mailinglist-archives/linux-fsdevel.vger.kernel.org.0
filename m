Return-Path: <linux-fsdevel+bounces-8610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB14839511
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 17:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5FD1F2DD14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83C7FBC4;
	Tue, 23 Jan 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQKH7OdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F07F7DC;
	Tue, 23 Jan 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027845; cv=none; b=suR0DlV9MEXoGdT+UA0wN0UoK4U6vW1hVyfeM6TxAMX95hUxKi6FRFLyQbf43Wa73zRgX1CgBUKAprm2m3C3uZ3l2zuG18hgqwpux6jIo4vbaTRhXpZGzdZ76kJnibwgnOX/LrhjUqx/ehIUfAQLBDPBDtaLdcWAEhgphln9IYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027845; c=relaxed/simple;
	bh=nkWULrJKr0g4IyTo5nQBTn36gTwU6vzvs00o9QdUlhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EEuoRysQr7Ps8hOeeI7DhD0NwTNTYy0iKZtf9IVid6E8u9lROmVAIcAousk17vpnFVCEbqncwLpV4yb89o9hh5d3ecQvex4dO3FFXSxmUu5ocQmHm9n/z/FmfSUKNULTNAPqRZCcv0CqrynUZK3c264HWorDYcZ2xVcnoZeLuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQKH7OdE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706027842; x=1737563842;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=nkWULrJKr0g4IyTo5nQBTn36gTwU6vzvs00o9QdUlhc=;
  b=aQKH7OdESOZQdka/T/Q26jK/AlQScvCjgTqp0DHrMgZDhehxLrqXkkpN
   A8jTF5bltbLZxi/7QE9zci1vWtsgKsGzyR89VBXDl+HkfOpkVdwNUHE1D
   PTn97Zn5Rqx6g2TQ5WXrl3kCbrRnXXXH3lxeSE50qIUxAl546gDwZK75v
   WDpNMgofc6qiE6jJ8T1Y8PKhdy8FhR55HmTCxf4ry3FRfHYpQoO+jS7qW
   2xVBjnBNWqJe+Oobq6QMSqz0+VTbnYQftDw9a26DVhzfVJkVJcaixYCib
   dziuWAME6s14pt8ofj//kO8/HUWVisa52draMZkyj8Gu8ttOhp2dSYAQF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8330202"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8330202"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 08:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735623447"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="735623447"
Received: from unknown (HELO vcostago-mobl3) ([10.125.19.148])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 08:37:21 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, hu1.chen@intel.com,
 miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com,
 mikko.ylinen@intel.com, lizhen.you@intel.com,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Seth
 Forshee <sforshee@kernel.org>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
In-Reply-To: <20240123-apparat-flohen-a18640d08ae2@brauner>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
 <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
 <875y0vp41g.fsf@intel.com>
 <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>
 <87le9qntwo.fsf@intel.com> <20240123-apparat-flohen-a18640d08ae2@brauner>
Date: Tue, 23 Jan 2024 08:37:20 -0800
Message-ID: <87le8ggg5b.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Dec 19, 2023 at 06:33:59AM -0800, Vinicius Costa Gomes wrote:
>> Amir Goldstein <amir73il@gmail.com> writes:
>>=20
>> > On Mon, Dec 18, 2023 at 11:57=E2=80=AFPM Vinicius Costa Gomes
>> > <vinicius.gomes@intel.com> wrote:
>> >>
>> >> Christian Brauner <brauner@kernel.org> writes:
>> >>
>> >> >> > Yes, the important thing is that an object cannot change
>> >> >> > its non_refcount property during its lifetime -
>> >> >>
>> >> >> ... which means that put_creds_ref() should assert that
>> >> >> there is only a single refcount - the one handed out by
>> >> >> prepare_creds_ref() before removing non_refcount or
>> >> >> directly freeing the cred object.
>> >> >>
>> >> >> I must say that the semantics of making a non-refcounted copy
>> >> >> to an object whose lifetime is managed by the caller sounds a lot
>> >> >> less confusing to me.
>> >> >
>> >> > So can't we do an override_creds() variant that is effectively just:
>> >
>> > Yes, I think that we can....
>> >
>> >> >
>> >> > /* caller guarantees lifetime of @new */
>> >> > const struct cred *foo_override_cred(const struct cred *new)
>> >> > {
>> >> >       const struct cred *old =3D current->cred;
>> >> >       rcu_assign_pointer(current->cred, new);
>> >> >       return old;
>> >> > }
>> >> >
>> >> > /* caller guarantees lifetime of @old */
>> >> > void foo_revert_creds(const struct cred *old)
>> >> > {
>> >> >       const struct cred *override =3D current->cred;
>> >> >       rcu_assign_pointer(current->cred, old);
>> >> > }
>> >> >
>> >
>> > Even better(?), we can do this in the actual guard helpers to
>> > discourage use without a guard:
>> >
>> > struct override_cred {
>> >         struct cred *cred;
>> > };
>> >
>> > DEFINE_GUARD(override_cred, struct override_cred *,
>> >             override_cred_save(_T),
>> >             override_cred_restore(_T));
>> >
>> > ...
>> >
>> > void override_cred_save(struct override_cred *new)
>> > {
>> >         new->cred =3D rcu_replace_pointer(current->cred, new->cred, tr=
ue);
>> > }
>> >
>> > void override_cred_restore(struct override_cred *old)
>> > {
>> >         rcu_assign_pointer(current->cred, old->cred);
>> > }
>> >
>> >> > Maybe I really fail to understand this problem or the proposed solu=
tion:
>> >> > the single reference that overlayfs keeps in ovl->creator_cred is t=
ied
>> >> > to the lifetime of the overlayfs superblock, no? And anyone who nee=
ds a
>> >> > long term cred reference e.g, file->f_cred will take it's own refer=
ence
>> >> > anyway. So it should be safe to just keep that reference alive until
>> >> > overlayfs is unmounted, no? I'm sure it's something quite obvious w=
hy
>> >> > that doesn't work but I'm just not seeing it currently.
>> >>
>> >> My read of the code says that what you are proposing should work. (wh=
at
>> >> I am seeing is that in the "optimized" cases, the only practical effe=
ct
>> >> of override/revert is the rcu_assign_pointer() dance)
>> >>
>> >> I guess that the question becomes: Do we want this property (that the
>> >> 'cred' associated with a subperblock/similar is long lived and the
>> >> "inner" refcount can be omitted) to be encoded in the constructor? Or=
 do
>> >> we want it to be "encoded" in a call by call basis?
>> >>
>> >
>> > Neither.
>> >
>> > Christian's proposal does not involve marking the cred object as
>> > long lived, which looks a much better idea to me.
>> >
>>=20
>> In my mind, I am reading his suggestion as the flag "long lived
>> cred/lives long enough" is "in our brains" vs. what I proposed that the
>> flag was "in the object". The effect of the "flag" is the same: when to
>> use a lighter version (no refcount) of override/revert.
>>=20
>> What I was thinking was more more under the covers, implicit. And I can
>> see the advantages of having them more explicit.
>>=20
>> > The performance issues you observed are (probably) due to get/put
>> > of cred refcount in the helpers {override,revert}_creds().
>> >
>>=20
>> Yes, they are. Sorry that it was lost in the context. The original
>> report is here:
>>=20
>> https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.com/
>>=20
>> > Christian suggested lightweight variants of {override,revert}_creds()
>> > that do not change refcount. Combining those with a guard and
>> > I don't see what can go wrong (TM).
>> >
>> > If you try this out and post a patch, please be sure to include the
>> > motivation for the patch along with performance numbers in the
>> > commit message, even if only posting an RFC patch.
>> >
>>=20
>> Of course.
>>=20
>> And to be sure, I will go with Christian's suggestion, it looks neat,
>> and having a lighter version of references is a more common idiom.
>
> Did this ever go anywhere?

Oh, yes! Had to do a few tweaks to what you suggested, but it's working
fine.

Just collecting some fresh numbers for the cover letter. Will propose
the v2 of the RFC soon.


Cheers,
--=20
Vinicius

