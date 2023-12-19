Return-Path: <linux-fsdevel+bounces-6497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC3818A27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 15:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482CC1C21516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B001CA88;
	Tue, 19 Dec 2023 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zodlag+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A91B29E;
	Tue, 19 Dec 2023 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702996460; x=1734532460;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/XNQlqMP1ii8IkFRiQLOMuoNmOBV0HJGKqUTMOklGRM=;
  b=Zodlag+016PU53gcJAq8RUUervQDR5ocJ5KBqCswLznpz/qBuDPyeXv5
   hxMZGBa66HiX0kOrQheDaqYtUaVSI69tCarcrvDn3whPYDvtp3CHC5ECz
   5AV8RNXnT68DrLvxeodO54F5rKK8hJKENqkY3LZiGqTKjG/WYZwkf9eKn
   Fc4/TfSZMSekQZRqTPNrR6HihPh9OuUwlCiKoUnp3QgZ2Hz2IIVdtcaON
   8VWHFx0dyriPtjNtTPmWDWAALS9wPYd7Nmfpkp/kn0mYfYwWHvQQA7Htv
   YJbGdsKR5g72H9acPK3cXfADimekcPagKEv/sGBWxSPAGEOg3F3zPpyCd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="395395592"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="395395592"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107367757"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="1107367757"
Received: from vvpatel-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.174.186])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:34:01 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, hu1.chen@intel.com,
 miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com,
 mikko.ylinen@intel.com, lizhen.you@intel.com,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Seth
 Forshee <sforshee@kernel.org>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
In-Reply-To: <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
 <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
 <875y0vp41g.fsf@intel.com>
 <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>
Date: Tue, 19 Dec 2023 06:33:59 -0800
Message-ID: <87le9qntwo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Mon, Dec 18, 2023 at 11:57=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Christian Brauner <brauner@kernel.org> writes:
>>
>> >> > Yes, the important thing is that an object cannot change
>> >> > its non_refcount property during its lifetime -
>> >>
>> >> ... which means that put_creds_ref() should assert that
>> >> there is only a single refcount - the one handed out by
>> >> prepare_creds_ref() before removing non_refcount or
>> >> directly freeing the cred object.
>> >>
>> >> I must say that the semantics of making a non-refcounted copy
>> >> to an object whose lifetime is managed by the caller sounds a lot
>> >> less confusing to me.
>> >
>> > So can't we do an override_creds() variant that is effectively just:
>
> Yes, I think that we can....
>
>> >
>> > /* caller guarantees lifetime of @new */
>> > const struct cred *foo_override_cred(const struct cred *new)
>> > {
>> >       const struct cred *old =3D current->cred;
>> >       rcu_assign_pointer(current->cred, new);
>> >       return old;
>> > }
>> >
>> > /* caller guarantees lifetime of @old */
>> > void foo_revert_creds(const struct cred *old)
>> > {
>> >       const struct cred *override =3D current->cred;
>> >       rcu_assign_pointer(current->cred, old);
>> > }
>> >
>
> Even better(?), we can do this in the actual guard helpers to
> discourage use without a guard:
>
> struct override_cred {
>         struct cred *cred;
> };
>
> DEFINE_GUARD(override_cred, struct override_cred *,
>             override_cred_save(_T),
>             override_cred_restore(_T));
>
> ...
>
> void override_cred_save(struct override_cred *new)
> {
>         new->cred =3D rcu_replace_pointer(current->cred, new->cred, true);
> }
>
> void override_cred_restore(struct override_cred *old)
> {
>         rcu_assign_pointer(current->cred, old->cred);
> }
>
>> > Maybe I really fail to understand this problem or the proposed solutio=
n:
>> > the single reference that overlayfs keeps in ovl->creator_cred is tied
>> > to the lifetime of the overlayfs superblock, no? And anyone who needs a
>> > long term cred reference e.g, file->f_cred will take it's own reference
>> > anyway. So it should be safe to just keep that reference alive until
>> > overlayfs is unmounted, no? I'm sure it's something quite obvious why
>> > that doesn't work but I'm just not seeing it currently.
>>
>> My read of the code says that what you are proposing should work. (what
>> I am seeing is that in the "optimized" cases, the only practical effect
>> of override/revert is the rcu_assign_pointer() dance)
>>
>> I guess that the question becomes: Do we want this property (that the
>> 'cred' associated with a subperblock/similar is long lived and the
>> "inner" refcount can be omitted) to be encoded in the constructor? Or do
>> we want it to be "encoded" in a call by call basis?
>>
>
> Neither.
>
> Christian's proposal does not involve marking the cred object as
> long lived, which looks a much better idea to me.
>

In my mind, I am reading his suggestion as the flag "long lived
cred/lives long enough" is "in our brains" vs. what I proposed that the
flag was "in the object". The effect of the "flag" is the same: when to
use a lighter version (no refcount) of override/revert.

What I was thinking was more more under the covers, implicit. And I can
see the advantages of having them more explicit.

> The performance issues you observed are (probably) due to get/put
> of cred refcount in the helpers {override,revert}_creds().
>

Yes, they are. Sorry that it was lost in the context. The original
report is here:

https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.com/

> Christian suggested lightweight variants of {override,revert}_creds()
> that do not change refcount. Combining those with a guard and
> I don't see what can go wrong (TM).
>
> If you try this out and post a patch, please be sure to include the
> motivation for the patch along with performance numbers in the
> commit message, even if only posting an RFC patch.
>

Of course.

And to be sure, I will go with Christian's suggestion, it looks neat,
and having a lighter version of references is a more common idiom.

Thank you all.


Cheers,
--=20
Vinicius

