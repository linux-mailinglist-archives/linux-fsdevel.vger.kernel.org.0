Return-Path: <linux-fsdevel+bounces-21898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0390DD8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 22:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445C3284E44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AC1741F9;
	Tue, 18 Jun 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYfcb9bM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485153E24;
	Tue, 18 Jun 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743244; cv=none; b=J1+SF7+XoMpkAmYrtAUO6b0rMWgtQnxitjFS6vyVaQ/tev87TqGu4fXZj5Pqi2PI+/Qld5hgU+HyJIiiLW9YuXOTcT/UPFV7Q8Dn2hFnQmoTn4PYDupOMAqpGOfEoTThUN4Fgv/sKq8aIStZJviZCGTiIxzRQ/CvAHBgsmDxm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743244; c=relaxed/simple;
	bh=SkekENq0hipzevfj00AK20IlSkJZ1QWx0rBZmBBmZAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hj/KMWjm2otkI0lOjd9rtELaG6TyNGqWOw1N7470ysEDbDOzs5fStI6keZDMGaGejmZb50xjLC9Ql4df9/STTv6lEGLCC5I6TnnpJErlhcP4Piz1FCMau4HQxrlveltzdDGT0Jevp3WXqVn3WlCROnyNjUcSmK+eg66xcDbVUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYfcb9bM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718743243; x=1750279243;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SkekENq0hipzevfj00AK20IlSkJZ1QWx0rBZmBBmZAk=;
  b=RYfcb9bMot4oreqhTeXvl+7p9PScBlwLZXr4h+5+0VKJ50Tn7Km7cK+M
   cnZQPqrfGlqxcE3TQBC4SvXuETuH2wy/wJscj69Op/qoUVXzjh+SAqcqO
   xQO9XHTxZ5A+IDDoTJgxMzZQCRXeFSDlxLfHEvrHG4rb9M1BZC4+QmICM
   n0lbBJ2lz0eXxXAGRzei5SfJ8h94nHoKfQLQf+icD7BBoymVdFL2fwFbX
   TBtD9uceqZM/Mt8shsu6mNUslaS3oEmwBVWlazGadf03S06v4OLcy2sap
   sKJQ6ZSutFhYgqoO1RRVxbLkX9Yw7wlRcOveGeYepH9oxTRIvutkwl9Vp
   Q==;
X-CSE-ConnectionGUID: vByXXz5HRKiHDLvYjT8SnA==
X-CSE-MsgGUID: HbGa1iZXToO+9eWv4PyRPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15798674"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15798674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:40:41 -0700
X-CSE-ConnectionGUID: WFCrUdItQcS/sWSjctIuPA==
X-CSE-MsgGUID: j0j7mdG0R12yVzQFC8VNfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41521742"
Received: from apahleva-mobl.amr.corp.intel.com (HELO [10.209.7.169]) ([10.209.7.169])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:40:41 -0700
Message-ID: <1c33b2c904f6055400817053504198e3bf3fad3d.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Yu Ma <yu.ma@intel.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Date: Tue, 18 Jun 2024 13:40:40 -0700
In-Reply-To: <ZnFGy2nYI9XZSvMl@tiehlicka>
References: <20240614163416.728752-1-yu.ma@intel.com>
	 <20240614163416.728752-4-yu.ma@intel.com>
	 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
	 <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
	 <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
	 <8fa3f49b50515f8490acfe5b52aaf3aba0a36606.camel@linux.intel.com>
	 <ZnFGy2nYI9XZSvMl@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 10:35 +0200, Michal Hocko wrote:
> On Mon 17-06-24 11:04:41, Tim Chen wrote:
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 3a2df1bd9f64..b4e523728c3e 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -1471,6 +1471,7 @@ static int do_prlimit(struct task_struct *tsk, un=
signed int resource,
> >                 return -EINVAL;
> >         resource =3D array_index_nospec(resource, RLIM_NLIMITS);
> > =20
> > +       task_lock(tsk->group_leader);
> >         if (new_rlim) {
> >                 if (new_rlim->rlim_cur > new_rlim->rlim_max)
> >                         return -EINVAL;
>=20
> This is clearly broken as it leaves the lock behind on the error, no?

Thanks for pointing that out.  Need unlock before return. I don't like
adding task_lock in alloc_fd path if there are multiple alloc_fd going
on causing contention. =C2=A0

The race with rlimit change should be a very rare thing.  Should be
sufficient that patch one check for fd not going beyond the observed
rlimit.

Tim


