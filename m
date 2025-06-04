Return-Path: <linux-fsdevel+bounces-50551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C2ACD219
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343F73A2BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F51FBEB3;
	Wed,  4 Jun 2025 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BET8d/Qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47831F8733;
	Wed,  4 Jun 2025 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998552; cv=none; b=uEdpmtEveP+NcK4ZqizzXxYm5kG8MoVOH03AVJsk0IIS6mTVYdPFUgUGL7r2+xDcaA8N0ovFanGHY/J4PianxPLuD8OOokuoXZSlEDZKxZBk22LD0t9OiTUZ5C2Wh2T8rGGa9FvDXiychS4OHGaP/wnxFqy3hwbKnErMmgr4R24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998552; c=relaxed/simple;
	bh=0NzGh0IlNXyCxnXVt8Hx58oluxYIZMGCIHFC6P/U+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/9r/8nVggrojn3LJG9CoB83sKOjbjoX5WaQNjO2wvHQ1gan1L4C5jxnj/8Rl45vLOixw4WStYL6eK6twPA3cz5FP0fW+AtJc4LckSOziWGoabjhw22ywcNeJZpJNIUsQVHn6/tckYTxZD5i134zDx2H68ixShviRn7a3F/HDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BET8d/Qj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zEs/4dqCCYqoB/Fxi10eZN6xtCdvwtGl+0Aws0ZSGSc=; b=BET8d/QjhiCAL6g0P8YNVFn22o
	tsZg5wthAzveS1pq+LsUWVkdp/ZKvTBCHg5c0baJhYhsdjov0qDP4eXdT2WXaAe1g1ZshCbOmDjDb
	RS/H4Iu2f1YfWi81GiZY6P27Gd984H4HILOk6Yln7cBOm4uuyJxShqZ6TFnPx5euzNTQ1f1jpWeAx
	ylnveibPM19Z/omAcXsITLoys4yvOCaJlZ6KrFxDog5/eK4lwp7WhT+8Gb43xrpwjdFq4QM/gEH0W
	+XlhuOAmUkLcS6CcWfBf5Cdw3brPEXWnJd/P7NpHBA3Y/zMjQqbhKYmZ3T3g1UNShd6jcqMsj8X3W
	/xxfW05g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMcPy-00000001LCh-35m5;
	Wed, 04 Jun 2025 00:55:46 +0000
Date: Wed, 4 Jun 2025 01:55:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Song Liu <song@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
Message-ID: <20250604005546.GE299672@ZenIV>
References: <cover.1748997840.git.m@maowtm.org>
 <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 04, 2025 at 01:45:45AM +0100, Tingmao Wang wrote:
> +		rename_seqcount = read_seqbegin(&rename_lock);
> +		if (rename_seqcount % 2 == 1) {

Please, describe the condition when that can happen, preferably
along with a reproducer.

