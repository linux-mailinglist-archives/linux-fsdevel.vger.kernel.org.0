Return-Path: <linux-fsdevel+bounces-44284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6708A66CB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D678A3BCC5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F11FF7CC;
	Tue, 18 Mar 2025 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBsga6EI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985C1DF742;
	Tue, 18 Mar 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284034; cv=none; b=rYvABsA2Cg5+mBjNcNxaReu59QY3mTUuH+PqD34GzuHxcbLMcOVyk6S9znIQHDZdyceNqz1g60P1t6tImLsabQXx6n+V5iL0S8YrLwZFwB0h1iig6v9vu6o5Vsl++3cbJoMtIGfhd86nGRN3/C77Tkg2gge5au6W7CLgt0+oQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284034; c=relaxed/simple;
	bh=q5gyFvbl6bkYEOehFIWAJ1zNNVQ1iTslUk/DCfO4Rq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWRcT2ctHCduzXv2adIeQVEQAVIoWzIBI085qjbg9QOEtwd0v7TaLvigmjvCq46DMuGd2GrxtqUsT4MquhqfcnH1ONWEF2FMiX87ZnzLpbee3ORgP0PyjqwEsSgmvNSCFSDkmnDYnKN+00NMeClcDWS/3UGXhZDvQJywmhCPwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBsga6EI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742284033; x=1773820033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q5gyFvbl6bkYEOehFIWAJ1zNNVQ1iTslUk/DCfO4Rq4=;
  b=mBsga6EIGtOTVf/NYvzjMtIOscge6tXLBz9QOmUT1k3H1WXjY8+7VeLy
   YzOmyhcmfIymtfOa7WEqvFqWkKIbbcqip032horJrfWCn5mN8/PoG99oh
   AlT2eHeR/UWziEgBU8psncDioNxPq2Q8oqH0QF2K9ttSYrhwJpEoJVwJq
   WXRKeM8r+g4h9+3cEN70K278YjodfZjnLIcFfvoEnKwx4YsSaSScrMfqR
   PQmhkq/KD4hYUKjaXaO0YiM+yt0Yz0CQdG+39muN37L5eLF2YI3DPmxSB
   U/boTyn/Se+lS0LIhmF3J4hRuk1k1TT8CNdyNmNdHH/OgosiDY2RZtgGG
   Q==;
X-CSE-ConnectionGUID: 25reoVTdSASkBNXpqglEpw==
X-CSE-MsgGUID: 1DMXB/VlRCSZGSys0nB5uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="30991861"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="30991861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 00:47:12 -0700
X-CSE-ConnectionGUID: 3VtcVOfoQgyR2trRmJu9Zw==
X-CSE-MsgGUID: 5KlqKzSiQtuXt3IwL/ft+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122198631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 18 Mar 2025 00:47:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9E39217B; Tue, 18 Mar 2025 09:47:07 +0200 (EET)
Date: Tue, 18 Mar 2025 09:47:07 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, akpm@linux-foundation.org, surenb@google.com, 
	pasha.tatashin@soleen.com, catalin.marinas@arm.com, david@redhat.com, jeffxu@chromium.org, 
	andrii@kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH] Documentation: Add "Unaccepted" meminfo entry
Message-ID: <6lh47q4gsgrmt2bajjngwfyjxs6dn7zmkuhnfftsrazp5ivs5j@pr4q6fpb2ulx>
References: <20250317230403.79632-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317230403.79632-1-npache@redhat.com>

On Mon, Mar 17, 2025 at 05:04:03PM -0600, Nico Pache wrote:
> Commit dcdfdd40fa82 ("mm: Add support for unaccepted memory") added a
> entry to meminfo but did not document it in the proc.rst file.
> 
> This counter tracks the amount of "Unaccepted" guest memory for some
> Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP.
> 
> Add the missing entry in the documentation.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

