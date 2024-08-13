Return-Path: <linux-fsdevel+bounces-25742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DB94FAF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9B11F2272B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969EB6FB9;
	Tue, 13 Aug 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRl4QxMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57915A8;
	Tue, 13 Aug 2024 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723511157; cv=none; b=Rbv1dFFgYSNyp86UvhCBlVjIeRzRORSyXP0+vwe3YWiI6fkYda8HB8n+aUnG6xMFcKIiMT7zrg8CbAavw/JdRuikfiLJlQC7xGKKOD3NJSrGFB59AjUYuwvJKRZcQgcVCECsoD0RA8hPUGYWf/VIDrkKpPdOxyaZtftM57FP/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723511157; c=relaxed/simple;
	bh=SEETdzXsGLJjBMachZ8uZP2L2aFsUOCJw1Br58Y+dtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/AHmyXvgyLFzzsXyIBvb1Pm/d9RYaJMIT6SCzKHz2GZNCgSjgDDGjjWSYLYngLxRsOjcIIA4Yotf9xNx2aF0M+qe8ZY6+a1XBiY0CCaVLRzJnJeCvKkE0h9Qwt0wbgBuC19mj/DdfjYtCyfn9uhFp9X4i14aYK/LzUUatRJk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRl4QxMd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723511155; x=1755047155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEETdzXsGLJjBMachZ8uZP2L2aFsUOCJw1Br58Y+dtU=;
  b=IRl4QxMdTb1dMOoIxva0YVv98AXnCITqHXM5GKJNHGB5Pj7oyMOFgoLn
   V3Ls0m2pJa9uJ3VE3NTogS9iNwFQ+sRgY3+Wc1f6Cfml9GDWe29qWL6We
   ycPI37TYlAwwLE0VLXyr/S++l5TG8LMKpVQLud2i+eru4++/jAqgPE0RL
   /0MYOAFopML4M6fyweEpInW8qxLcKcUYHzH4+cKbg/s+8NGrlqU7NNtrx
   Vl0MqCQG3qa7ISYsqgucF+TcNWA/JlHvoF/Cur+LShCDPmEYO6pKFeip4
   o/yFuXsN5rWsHjx8TSADTkvvmWKNhXPhvn0EbnHad2XyWqR2sq0QuB/2m
   A==;
X-CSE-ConnectionGUID: OsK3HztoTq6IOGjlvPdr6w==
X-CSE-MsgGUID: 7/d/GffXQ0exMH8cC/jwNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24558066"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="24558066"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:05:54 -0700
X-CSE-ConnectionGUID: GAdeG6rJTa+71Wzuo2p68g==
X-CSE-MsgGUID: Evg7vkv/RLujk0H9U9iVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="63334943"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:05:54 -0700
Date: Mon, 12 Aug 2024 18:05:53 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org, jannh@google.com,
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v5 bpf-next 10/10] selftests/bpf: add build ID tests
Message-ID: <ZrqxcU5ceeAIesOb@tassilo>
References: <20240813002932.3373935-1-andrii@kernel.org>
 <20240813002932.3373935-11-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813002932.3373935-11-andrii@kernel.org>

For the series

Reviewed-by: Andi Kleen <ak@linux.intel.com>

