Return-Path: <linux-fsdevel+bounces-25166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F415949807
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AC51C220D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA882876;
	Tue,  6 Aug 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSy5DWxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F404F8A0;
	Tue,  6 Aug 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971516; cv=none; b=GdSQCgYUsAw2D3TJ/fXlvagjHdZQ9KrZKZolN+vuSxQMXZjDPOfVirRxn+I27GnQUA4FfKdryXgWDBRhSUDS2CY00q0xWq44GsCUV7atN5srdSXsFQf9ZRcPCfqu5mriIPmpq8nrE/a6bz2lPNulnLyHGm9p1SwZvobVtM5edd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971516; c=relaxed/simple;
	bh=1GuZY7l73RPYRon+EVmjfQ9BpjAR5+4uqRreZFXzwKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djMDh7oWmypqBKeTKOButAObXWipGPuuM1TLTjQ/xlY/4Xg3nlwek5+cYBIRhieXJZ3aNEPcxHUuF0B6Rf42e8e4/aaFinS8CT1eyWto/cPIsP+jLm5ASAhcrV1vUCMVIfV4v9oGeAkuuYZmabNkqisqlhebU2Iqt5xPwlzKlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSy5DWxm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722971515; x=1754507515;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1GuZY7l73RPYRon+EVmjfQ9BpjAR5+4uqRreZFXzwKI=;
  b=TSy5DWxmxT+Ahu4Kyl5kQ2WC3ARcPC4SJ1Pcelz31eIqq5GmF2EEGt04
   T/JOQWfd100UjYxPPySIofYuo1pCoL079z+cUzjrhMsmkhCUJ5od1nUqE
   GQlzUgb3pVvlFfz2auk+KUBBxS4Lzj4rpIKds+rWz0Fa2xZrEEC+F13lN
   /lmlP8cVG/vZY2l2TD5jspubAhHOu62td2rGxN4VPM1rJqQwJa9IFjKct
   i0pjnJuCP/lirOszpSJoxbw+YSIQHZFWTws1/Fi5+9Ut/i/FHq2zmA08N
   PX1FmVJEn8V5+KAoS4zF/wRg0NvWVyAYDJgKeM71uQa4LhBXioVHJ5iRH
   g==;
X-CSE-ConnectionGUID: POP96g3fQtCSkAb/MZjdPA==
X-CSE-MsgGUID: +oUHlzbnS+qKvwn4RNiPEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21160760"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21160760"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 12:11:54 -0700
X-CSE-ConnectionGUID: 6LEnu33RTgW2TY7adEPoyA==
X-CSE-MsgGUID: kHY7WZL/SAGx5KyzZpi+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61484207"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2024 12:11:51 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 27036301A9C; Tue,  6 Aug 2024 12:11:49 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Andrew Morton <akpm@linux-foundation.org>,  Josef
 Bacik <josef@toxicpanda.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
In-Reply-To: <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
	(Mateusz Guzik's message of "Tue, 6 Aug 2024 17:25:30 +0200")
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
	<CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
Date: Tue, 06 Aug 2024 12:11:49 -0700
Message-ID: <87ikwdtqiy.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mateusz Guzik <mjguzik@gmail.com> writes:
>
> I would bench with that myself, but I temporarily don't have handy
> access to bigger hw. Even so, the below is completely optional and
> perhaps more of a suggestion for the future :)
>
> I hacked up the test case based on tests/open1.c.

Don't you need two test cases? One where the file exists and one
where it doesn't. Because the "doesn't exist" will likely be slower
than before because it will do the lookups twice,
and it will likely even slow single threaded.

I assume the penalty will also depend on the number of entries
in the path.

That all seem to be an important considerations in judging the benefits
of the patch.

-Andi

