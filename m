Return-Path: <linux-fsdevel+bounces-22692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E091B1BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEA51C21780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7391A2544;
	Thu, 27 Jun 2024 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMxlGNFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878BA3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525227; cv=none; b=Kyy5+cdLRsy4XKZ/hoPAMb3OJYGDsMiy9CbvlFaaEjSDbsEq5XDxP9KxEBnz3RGKman1h44A/luHaNPF2hzOmjnWZudjaChCIcnAw6/nIwx2GE9npYxDWdaSm9Db8LBifY/WO+ZJUDEpLlJfxdtgn9EIYZ5u5mAxyHyoz64jAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525227; c=relaxed/simple;
	bh=9qvxQtPCaTubukuf0wRj3l5en347yScZmHMKVI+jgS4=;
	h=From:To:Subject:In-Reply-To:References:cc:Date:Message-ID:
	 MIME-Version:Content-Type; b=ozP6LgOhBamd64Jz8mbDWYynwPMe5XgyTZoui4d/VroKGe4+KQ0xehErWKilwWIFpROOC6AAkxTOUck7JC2GH4o7rpoqQAGn038g0Pp/hxMQCnYNDhqfOBdmNtIpDCBK5ug8qHiZf6ZG6CELba0autLDJAO1Ety+PUXCorfbHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMxlGNFb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719525226; x=1751061226;
  h=from:to:subject:in-reply-to:references:cc:date:
   message-id:mime-version;
  bh=9qvxQtPCaTubukuf0wRj3l5en347yScZmHMKVI+jgS4=;
  b=VMxlGNFby+XNpxYTrL1ttx0L1EWR5qYjw5BztgHz5PNzQ+Q2JZjtWITG
   E/v2bPcuE+Z5XKhkfyLAQ31geKdmIk0kFEH0biK256G8vE2Q7wncSSGoh
   j2NPuM1zpOAdxoI+yaMQzeLkWFiASjSbOibU4MixyORcJt8kxCgKM+9Rz
   0N8ek3/3t63QwyvQbjPiJj7kSY8NbC+Vhm7ZEF1lW6IOrtUxSl1tZrP1N
   4ybvy0mn3NNvvwpCDaE+mrPHz763qt53iej4Za+78RjiTm+wcLcc7w0Zv
   cFtxbYzxawSkA+B3+ZlHMl1kChQizjWKwjEpxNLadO818N3RV3lUE6ByK
   g==;
X-CSE-ConnectionGUID: Uch/8HQoRTez/8OtxzBFzA==
X-CSE-MsgGUID: cLlt9G5ISKuJYPuaHaOkRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16507670"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16507670"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 14:53:45 -0700
X-CSE-ConnectionGUID: CEIDz3nzQB6z8g1egjZveA==
X-CSE-MsgGUID: Kx8nVFj6TpuYnB+6P3uSdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="45272561"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa008.jf.intel.com with ESMTP; 27 Jun 2024 14:53:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 94196302A3B; Thu, 27 Jun 2024 14:53:44 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 04/10] fs: add infrastructure for multigrain timestamps
In-Reply-To: <4470c858a2a9056a9a26bb48ce36dbfc52a463e2.camel@kernel.org> (Jeff
	Layton's message of "Thu, 27 Jun 2024 11:35:47 -0400")
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
	<20240626-mgtime-v1-4-a189352d0f8f@kernel.org>
	<Zn1/FVS4NrAwEBwz@tissot.1015granger.net>
	<4470c858a2a9056a9a26bb48ce36dbfc52a463e2.camel@kernel.org>
cc: linux-fsdevel@vger.kernel.org
Date: Thu, 27 Jun 2024 14:53:44 -0700
Message-ID: <87frsyt5lj.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Layton <jlayton@kernel.org> writes:
>> 
>> Would it be of any benefit to keep a distinct ctime_floor in each
>> super block instead?
>> 
>
> Good question. Dave Chinner suggested the same thing, but I think it's
> a potential problem:
>
> The first series had to be reverted because inodes that had been
> modified in order could appear to be modified in reverse order with the
> right combination of fine and coarse grained timestamps. With the new
> floor value, that's no longer possible, but if we were to make it per-
> sb then it becomes possible again with files in different filesystems.
>
> This sort of timestamp comparison is done by tools like "make", and
> it's rather common to keep built objects in one location and generate
> or copy source files to another. My worry is that managing the floor as
> anything but a global value could cause regressions in those sorts of
> workloads.

Have you considered the interactions with time name spaces?

It seems you may need a floor for each, otherwise if the floor is set by
some name space with a more future time the other users lose out.

Also there's the issue to what happens if time gets set backwards.

-Andi

