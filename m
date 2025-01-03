Return-Path: <linux-fsdevel+bounces-38359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E5A006A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 10:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D61883E9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1261BEF93;
	Fri,  3 Jan 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XpSe/w+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820B1119A;
	Fri,  3 Jan 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895951; cv=none; b=p7b7rKyxk5ut72boUVC1QTO/972AJ+DbDIuE1g41u39Wsnl7IJAIp0a65LvRtZg6m2E5oYYkjAgIrQg+etoo7BtynLLCB9XY0nYVgGJfDESpWmrB8Rm4x365kTqgYU0VrMAYiIEnCTZo4yj4B13yb6c10WRBikJupcx/QX5vta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895951; c=relaxed/simple;
	bh=LoaH5SggD7j/Nmcl8Er330OFbScOCFciTX3gc/Ql5AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eej4K6k2snICraOvNE/fh9aBRIKi8AtN9l8k8scytqvEDgwFGZtUq0RQWaZcRTbsPCZOv8V0SBEj86NzSbl2By7PKcu9G0HHdJvuyOwtYlrH5KpBXK8MBFTMLVlN5b31JHir3mDCC/g/pAS22QC/V57MFpVe/SI+a0mv41Gr4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XpSe/w+F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=crNJE83AO+7TdLr8gKwvunqJAJ17AfMSOW25JgwAjp0=; b=XpSe/w+F/s67C64D6bIwEwzWGa
	XpbUtUcYysvfVnckZA2Kd1lmSKNzEQdL5UYIzy1rc8xbgbUcJQl3gdQRGJDJ2yLAEcL0mvFlvl4CU
	4qerDUKRB3AksIZiqTakK0jD1BMPT7+JhGIJtmcj5Y2nZEF0ilQHgerChMVfuC0WFARRFZFJrMsbJ
	MK/2rlds7Qa4kmByBfgfoz5AM6BvbWgC9nlRl792DxUb7WHwzyI34LZL6Pg5vuR9WnB5prQaA00Ri
	MnKFLszfXuQS0aiv1/go0iakbDA1gHXgfaBHwWZI/UFROFWn+DnobULLLzy/6wzV80bAQH3QaQRm6
	sgDfqGjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdpi-0000000F1tu-0jhl;
	Fri, 03 Jan 2025 09:19:06 +0000
Date: Fri, 3 Jan 2025 09:19:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "WARNING in max_vclocks_store" in Linux kernel version 6.13.0-rc2
Message-ID: <20250103091906.GD1977892@ZenIV>
References: <CAKHoSAu3D+s_jzquKrR2YXFd_gNMu5AfDg7_+HjYEtyCSwJ-4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAu3D+s_jzquKrR2YXFd_gNMu5AfDg7_+HjYEtyCSwJ-4g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 03, 2025 at 04:19:35PM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 6.13.0-rc2. This issue was discovered using our
> custom vulnerability discovery tool.
>
> HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)
> 
> Detailed Call Stack:

Out of curiosity, what would you expect any of us to be able to do with that
information, given that we
	* have no information about that tool of yours
	* have no idea how to interpret those call chains
	* have no way to compare those for different commits
etc?

Seriously, step back and imagine somebody with zero information about your tool
staring at the email you've sent.

Al, completely bewildered...

