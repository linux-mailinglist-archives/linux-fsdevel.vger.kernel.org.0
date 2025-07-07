Return-Path: <linux-fsdevel+bounces-54189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805AAFBE3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B07A9A0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CD267B61;
	Mon,  7 Jul 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E7fjmCc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FC186A;
	Mon,  7 Jul 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927177; cv=none; b=bKisyZkIWYLDKA2UAzM/30dqqIIS3SwRsEU6BWUTrOwb7Blge5T3xFgMX6ENVAh5or69YC9z3q+1t+CKVbRoc/1PU490HrVbp6OqlVYkRL9A53xVdJqsNwkkobmVtH530dcb0FitQzLODD4KP6vWAvmoKRZ7lnaIryT3g4vy0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927177; c=relaxed/simple;
	bh=gHkf2cujb+trpgM2oTxU2vt97Dgnq5s/OXDze+10Pvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3UP+7DD2s5ziDakRZDK259ZDpV9B7RiC1UdN13F3cixhaOwMMYwlfnYH04ZOORpNTWrEn1iOr5WQmuquT+7Un9xlTvshpeFq4FnKWq5zAz/8dPwJEF6GdcmAubz412lGAxf/AF2vozqYkYMNRHioO+yRF/ryv+VYX6MLgYlGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E7fjmCc9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=EzIem5ISPiXtqhmnYKa2/9ZUhiwjfO7LzPdKS2Q4R1o=; b=E7fjmCc90FNh+QXwjI5bs1yv3w
	U0TnPu2sx7jkAj1IMZ9HV3G2OJLMFHFi/PwM2KP8FIAUKjsG2hyk43ukwOoNpH70KT6em1GJPwo1d
	1vueSqCfWgbRO8pt6cU4LLZ/c2R3mmrN3QA/PRVAwOqdFglJvpsPyVQivi5PqLhATjANvWNGj4xr/
	0sXGpcNYgi3+CLMG+0DxhyRvoeU3x4sW7I0urw2Lp9wuky972pQePC2MIkYGir+vD9lNqsfAdtUSV
	1bpVu67mf45YMhToTbr51in/xEUIyssp4wf4iQ9KB2MNtnLCoAgppSCyo8G18ON5qhWyT+m2dwnP/
	HGSNqZmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYuHs-00000004HqV-1W2o;
	Mon, 07 Jul 2025 22:26:12 +0000
Date: Mon, 7 Jul 2025 23:26:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707222612.GP1880847@ZenIV>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 07:20:28PM +0200, Max Kellermann wrote:
> Hi Al,
> 
> On Mon, Jul 7, 2025 at 7:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

BTW, a minor nit: that was Fri, 24 Nov 2023 06:04:21 +0000...


