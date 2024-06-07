Return-Path: <linux-fsdevel+bounces-21201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740F900480
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3721C2412B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1311940B5;
	Fri,  7 Jun 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAjbR0st"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0B15DBC1;
	Fri,  7 Jun 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766504; cv=none; b=i+sUnnEfyj2G2p/lKZfKzsGwaIMXjDlcySS6ZTccsuS643Jz8Z3y1TETndDfMwJyCqyfQDWKNzSpaWdKlhi/XrCtcD0MGeSblQT1xpQ+Qx/l+isxn9tELCzytiFIxMtzZLipjzK7z1qWSbFF1yKyrohwwZvcm1ge3k+5v+/gKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766504; c=relaxed/simple;
	bh=66ItDEBV4jS+09dfkkkWnz77ZbxcDPYfcnQncpt+GIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nggFYaGunk3kUmLCrFIQYq05BHJlNEcoZ7lsfzHUFCe8cfv48C8PUIp3EMZjSMp92zB4cnQROz4QRfE/iD6VE7R/5o/t/0Nn/0bgQTH0/GMIoFvrkCI2fwOUJfQZ7PLs+IXGqa00BdMVPvehkacc+v9ZvOgM2/qW+zK9pLeLvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAjbR0st; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717766503; x=1749302503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=66ItDEBV4jS+09dfkkkWnz77ZbxcDPYfcnQncpt+GIE=;
  b=PAjbR0stFs8SX9OiAEOoEAnCi7pkRO9TA6lex9QF5oClWdu8sPpdjEHo
   qqDJUPpLgMngPs69ChT3OBp2EnMZ1FrEz4/Tubq3H2BWt4L8nBbT+7/n4
   WFQyuGg7nVWOxinkCNRrj3jqH4V9JYlLkPoL3/gT52x7r/4fzsEGka/tT
   5rX+S7YhuvYtddHsJbFwZ1NyOaaF0CvFf5PDmyoSiC3OFvS8bpDGXUbV5
   D9cECvcNLbFQfhzx5mGp+zFSR4WZa+sn1Y2Ra3IFMzPnfJOcbOhQdOo80
   kIUUkqN2DMx4wDjuO9CmSKA15Sed3gSrw1VnzxJIw7ndBBajYcZpKHHNH
   g==;
X-CSE-ConnectionGUID: 25esuFVkR3yPYOGmySotGw==
X-CSE-MsgGUID: o9J+CiKOQ566fLdkxurvBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14369585"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14369585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:21:42 -0700
X-CSE-ConnectionGUID: kYFj0mAATZCn0eBj1lGUlQ==
X-CSE-MsgGUID: 9i1iPm6sS7W8Et5Qjdg4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38995491"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 07 Jun 2024 06:21:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8EAA1389; Fri, 07 Jun 2024 16:21:39 +0300 (EEST)
Date: Fri, 7 Jun 2024 16:21:39 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 1/6] fs/proc/task_mmu: indicate PM_FILE for PMD-mapped
 file THP
Message-ID: <6rzt76g3qhznxhw3iftgbgskyukrsvklq5xhsacopgugb2wzzr@ycpxby6zzuzg>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122357.115423-2-david@redhat.com>

On Fri, Jun 07, 2024 at 02:23:52PM +0200, David Hildenbrand wrote:
> Looks like we never taught pagemap_pmd_range() about the existence of
> PMD-mapped file THPs. Seems to date back to the times when we first added
> support for non-anon THPs in the form of shmem THP.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

