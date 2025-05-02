Return-Path: <linux-fsdevel+bounces-47908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B6AA6FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEAA465667
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC342AAF;
	Fri,  2 May 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQnSjer3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369B1EA7F1;
	Fri,  2 May 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182723; cv=none; b=Ye7q207cj0y07UVaL5RfqvwMZty1IZMWGj31VnXVEtPo2Sy7fCkKLHyy93sx0aQzQ/RKvdSbJsxHSXzse5yVo4IYJKEouDuoEQ7T0oM64ji/7Nr0s/c7T4MZwUNAZXuBmN0jC5ufvR5HGxr8kjWcDlhZpt9YFa9h5bMXm7tOQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182723; c=relaxed/simple;
	bh=kabmlv0KkQDAyrTzn6zjy1nl1svXPwvfHYYf/932dMc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVHZWcnkOUWYwM3jPLdWVUuivz5NulA8S1gDMdJLafpyzvqe5fUBw2q71HlUmC7VUrQQggY2cDcA+YUt79jhEa55sELJU74z31ADlN03sKxjKIFApOk3J2edoNnVgiZeBiMKua9nShWll2z/vHyRK9+xMcGPt3ZePEhfMcpGdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQnSjer3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746182723; x=1777718723;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kabmlv0KkQDAyrTzn6zjy1nl1svXPwvfHYYf/932dMc=;
  b=SQnSjer3b2rqwHtCYrKVHoRNTidB87lFiYNv3v2HN2q5AxL0BtQKelSW
   bpl1SBy0Fml08FfYopmhytfxGXLH3UmZ4qdzdup8oQV1S8QdzZihbbtLc
   VekMclL26bUwS59Vtp8DZutndCBTpxz+muC1M6DtXWzu55XZHHFiqe6jJ
   UX5QGj1nNms22OVZp6/BTx+yz+2zyNDfh0DqtOhu4AKukJzQKtFN0HWzA
   fDUXFoMQSpLi5d3RWNUMi6ZH9SXa+JxuEX/dCN0NZSinERNWDBSCa3drD
   JcNK/eEbiNA3j1hs62JfOQQfHJi8dQdETDcJOTb445abet1zV39Qy4yrT
   g==;
X-CSE-ConnectionGUID: Srfaajz8ScC1ik+6FKrqGA==
X-CSE-MsgGUID: siakygFkSFqdOaQXCePIvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47874582"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47874582"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:45:22 -0700
X-CSE-ConnectionGUID: xCwqsuJUQiCqtrX/wmzsYw==
X-CSE-MsgGUID: Dr+n9SJTRY+OMs3pDcKF5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139612566"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO [10.245.246.151]) ([10.245.246.151])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:45:17 -0700
Message-ID: <9c8dbbafdaf9f3f089da2cde5a772d69579b3795.camel@linux.intel.com>
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Al Viro
	 <viro@zeniv.linux.org.uk>, Matthew Brost <matthew.brost@intel.com>
Cc: Kees Cook <kees@kernel.org>, Somalapuram Amaranath	
 <Amaranath.Somalapuram@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew
 Auld	 <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>
Date: Fri, 02 May 2025 12:44:26 +0200
In-Reply-To: <da694af6-1a9a-4cee-86b7-1da97e1e91de@amd.com>
References: <20250502002437.it.851-kees@kernel.org>
	 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
	 <20250502023447.GV2023217@ZenIV>
	 <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com>
	 <20250502043149.GW2023217@ZenIV>
	 <aBRPeLVgG5J5P8SL@lstrano-desk.jf.intel.com>
	 <20250502053303.GX2023217@ZenIV>
	 <da694af6-1a9a-4cee-86b7-1da97e1e91de@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 09:49 +0200, Christian K=C3=B6nig wrote:
> On 5/2/25 07:33, Al Viro wrote:
> > On Thu, May 01, 2025 at 09:52:08PM -0700, Matthew Brost wrote:
> > > On Fri, May 02, 2025 at 05:31:49AM +0100, Al Viro wrote:
> > > > On Thu, May 01, 2025 at 09:26:25PM -0700, Matthew Brost wrote:
> >=20
> > > > And what is the lifecycle of that thing?=C2=A0 E.g. what is
> > > > guaranteed about
> > > > ttm_backup_fini() vs. functions accessing the damn thing?=C2=A0 Are
> > > > they
> > > > serialized on something/tied to lifecycle stages of struct
> > > > ttm_tt?
> > >=20
> > > I believe the life cycle is when ttm_tt is destroyed or api
> > > allows
> > > overriding the old backup with a new one (currently unused).
> >=20
> > Umm...=C2=A0 So can ttm_tt_setup_backup() be called in the middle of
> > e.g. ttm_backup_drop() or ttm_backup_{copy,backup}_page(), etc.?
> >=20
> > I mean, if they had been called by ttm_backup.c internals, it would
> > be an internal business of specific implementation, with all
> > serialization, etc. warranties being its responsibility;
> > but if it's called by other code that is supposed to be isolated
> > from details of what ->backup is pointing to...
> >=20
> > Sorry for asking dumb questions, but I hadn't seen the original
> > threads.=C2=A0 Basically, what prevents the underlying shmem file
> > getting
> > torn apart while another operation is using it?=C2=A0 It might very wel=
l
> > be simple, but I had enough "it's because of... oh, bugger" moments
> > on the receiving end of such questions...
>=20
> It's the outside logic which makes sure that the backup structure
> stays around as long as the BO or the device which needs it is
> around.
>=20
> But putting that aside I was not very keen about the whole idea of
> never defining the ttm_backup structure and just casting it to a file
> in the backend either.
>=20
> So I would just completely nuke that unnecessary abstraction and just
> use a pointer to a file all around.

Hmm, yes there were early the series a number of different
implementations of the struct ttm_backup. Initially because previous
attempts of using a shmem object failed but now that we've landed on a
shmem object, We should be able to replace it with a struct file
pointer.

Let me take a look at this.=20

/Thomas

>=20
> Regards,
> Christian.


