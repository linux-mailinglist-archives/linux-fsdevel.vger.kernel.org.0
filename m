Return-Path: <linux-fsdevel+bounces-57651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A7B242D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AEF16B3AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927D82DFA3E;
	Wed, 13 Aug 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UpwN8WfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DEF2C375A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070349; cv=none; b=rzYUg1ig/pdUmT7pR5eqIocBNy1B/2tq9G0dhR5+rep7BJZRnP3MIBzMGE3WTZvtksnkhpA3LdDcWkz037WaMTPVIxjIt9/YPKCDgam6t+9t1gUMKpAydr7V3TYK0EoLp/zm/KYvnLLzbk/KIINun+N8X/8/aIaLr0Tu1ExNeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070349; c=relaxed/simple;
	bh=nDtDLt2/1s674ZlRUCKDm0dwr1fqoH2QpulB/eRyJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq4R7GfPWs47fC7CQdzj2e09G/V7DPluddTm+wALy9TPN7KimYenTdGsS8TfeSU92Y+cJ7tGZ24nEXbgsqV9KcuRmxD0XOxO1Ray/O5C1dcHG6obEDn1qgN4IyrvTOp52S+4kLkMan6cfTf37etbVs8qvp88fmZrPMyH9BQmChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UpwN8WfK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LCR+6RxTmw+qQPUwCnKBZPirwu8L9n8+wKvlfcihAUY=; b=UpwN8WfK/WSmGDpTchnjXcuFLI
	4IjZstFgCz2AnnYI5z/k1r/lV8FOZq1D0WWQngoRkcbtlT2EEsOVhgYXXxAiAIe5eDdyPpExxu3q2
	xx2+0UM9oCIPxThTU2YNtFB9XWOQ90xKl/Yqaf0vm/UmBXjzB4XgX2PBShwb2T0vR4g51uy/5POiG
	+BDBUFSn3VlcQ2rIB/sgCmKtBQThNWS6NDrUwJAjMWbgegOUuafeSvZ5c4UjzXf/3a+wY5PKgkWE7
	aMD2+oDBro3NaPWZM5ivNQk1A7yxwasjA4GdTIdlUN8hy+X/qcd8Pc6lRBhVN6gOVQVqSNxohOZ2Z
	Ir9XoJfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5yC-000000076UW-0Ypc;
	Wed, 13 Aug 2025 07:32:24 +0000
Date: Wed, 13 Aug 2025 08:32:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, yi1.lai@intel.com,
	ebiederm@xmission.com, jack@suse.cz, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Message-ID: <20250813073224.GI222315@ZenIV>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
 <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
 <aJw0hU0u9smq8aHq@ly-workstation>
 <20250813071303.GH222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813071303.GH222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 13, 2025 at 08:13:03AM +0100, Al Viro wrote:
> On Wed, Aug 13, 2025 at 02:45:25PM +0800, Lai, Yi wrote:
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/repro.c
> 
> 404: The main branch of syzkaller_logs does not contain the path 250813_093835_attach_recursive_mnt/repro.c.

https://github.com/laifryiee/syzkaller_logs/blob/main/250813_093835_attach_recursive_mnt/repro.c

does get it...  Anyway, I'm about to fall down right now (half past 3am here),
will take a look once I get some sleep...

