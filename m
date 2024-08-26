Return-Path: <linux-fsdevel+bounces-27259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82C95FDBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9524C2816FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD119D886;
	Mon, 26 Aug 2024 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rc/zL9Tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8580027;
	Mon, 26 Aug 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724714511; cv=none; b=AlM0nXkEEiNiZOCKrebv+U5yuY3lqpVk8rbc2AJUG1U3fhR+fa/hiu5xFjeervvXgEggkJEAyerW3wxddt7fgM3IdfG6QJQJ5BvrEFjQiQytB+NPTegFCH+ETdUQRb4PZxp4ii7vwvfIZ7C2WGqPMMKb/T5w2QMwS6XRnKSidYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724714511; c=relaxed/simple;
	bh=nrxAK3cZ51QgoEX/irFEk03z6aVmYQZR0sYAle5hMGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hzyw23Xr3Vfl72VZc+aKvgI8VMUMG+Eb4faLY7aFN/vtaD7jmDcLKEERp8nRbtOiknZs+qZWMdQCwR8/yaLZlYeebDRPo0mRH4GVttAk7d/37rp6ryuymEWsrftDnkvqQZnKBXjXsOypRrO0af50M8iWlFZyzfdFwo0M6BTL8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rc/zL9Tk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724714509; x=1756250509;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nrxAK3cZ51QgoEX/irFEk03z6aVmYQZR0sYAle5hMGw=;
  b=Rc/zL9TkX1FkFV1LGUuDGY9+nJgQa6RCQ5R2vSrsOrNjMVcMMuJ/PJb0
   q6OMs7LqFlr2ZQCLV64w4JhDRmrhyydsCvA41RYStbJyLtXcqpo/5hZtH
   Tm3sD6PsnzZKCRSB+luPj22Uv0/63wOBEeFkNUUZrN1PgBuTdkXIcIc0I
   vERc2vGRsNxWhPWYJMCngUQkTCAT1EcYdOtwWc4vV9rkbTsuIZKB496pQ
   qf/pAm+PGStCzHI8xmMDzxKMovm1WSWH/qX/Q0kDqZ6SUIhedxSFIL5Kd
   3Ay339sXZxiPS02+iqQI3l2nRWnpFzCAGTTiB2ZEwsm9d7whsY8tNfw33
   Q==;
X-CSE-ConnectionGUID: 3bSVQ4xoQpSMhXPHeYDbGQ==
X-CSE-MsgGUID: ynkT5hOuSVKSFv61LHiLsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26959489"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="26959489"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:21:49 -0700
X-CSE-ConnectionGUID: tbt0GUXcQrKwymXuya3qsA==
X-CSE-MsgGUID: 6P5uqhX1QtmCh0b9VhOttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62982573"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.39])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:21:46 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/16] overlayfs: Remove ovl_override_creds_light()
In-Reply-To: <CAJfpegt+M3RAQbWgfos=rk1iMu7CRhVS1Z5jHSHFpndTOb4Lgw@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-17-vinicius.gomes@intel.com>
 <CAJfpegt+M3RAQbWgfos=rk1iMu7CRhVS1Z5jHSHFpndTOb4Lgw@mail.gmail.com>
Date: Mon, 26 Aug 2024 16:21:42 -0700
Message-ID: <87jzg2kgzd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Remove the declaration of this unsafe helper.
>>
>> As the GUARD() helper guarantees that the cleanup will run, it is less
>> error prone.
>
> This statement is somewhat dubious.
>
> I suggest that unless and until the goto issue can be fixed the
> conversion to guards is postponed.

That's a good point. I just want to point out that the issue is only
with the combination of the "plain" (not scoped) GUARD() statements and
'goto'.

But I would be happy to postpone that, if the trouble is not worth it.
As all the performance gains come from the conversion to the _light()
helpers.

>
> Thanks,
> Miklos

Cheers,
-- 
Vinicius

