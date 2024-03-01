Return-Path: <linux-fsdevel+bounces-13253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1986DD71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 09:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E06028A4CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423396A014;
	Fri,  1 Mar 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i07hoD+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACA69E16
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282902; cv=none; b=rsfWy48XtpHOMCZbTMg8w2dDrNPkpfADZATNId01vnaVBaoitSX6ZKeJDsQ8JrKw2fM0d1tOQaAlE6nepd8WiriMDaPqbhRabBZ+wAVQMr6o/7VPEx4QSZowFdLwZEWaYa9ETynBYT2kIOoeik9ABerytsCI21rRO+1lGQOH76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282902; c=relaxed/simple;
	bh=H6TBSGxmawqfFl0A8AG6YK5ovbMCC/eJhUaZ0m/t/uY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ff7vSV3u2fPemFTR6BNWJeACzo6GqMQOYG4P16IqguowwSMiBF4e0lKyGAGKmH2Z9HXZLVOEJebQtIMZFQAzBCEVTNseHttOp0iUeqKlT8qJK2cfOe3c7PX33CUxsULxJMTuw63fuDlaco1LFnug6rMJYXhv7cjaUHSv6vO6mWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i07hoD+0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709282894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbBBj7bPPwmnqKCHJkxs4sd8l0ti0Ate4aOBplA9Gh8=;
	b=i07hoD+0dyYHGfXcBtEEWNy7vbO0lb6xSABBkHIQO7nEqu9OaVGY6EgpfdZHmX0qaMf0m4
	Lk5fITBYu/CoPclt4ZQAzzEuxgWbU5RPQg/IG0ox5o1WowtQXTidlSC3YPX7QpPR6CN3VC
	2gZ0vMdgsJde5uBQJ3Q6Gqh61xkPjB8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] hugetlbfs: support idmapped mounts
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <87ttlq5q6g.fsf@redhat.com>
Date: Fri, 1 Mar 2024 16:47:30 +0800
Cc: linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 rodrigo@sdfg.com.ar
Content-Transfer-Encoding: 7bit
Message-Id: <B8C52AAA-C8B5-4DF9-B9B2-A7DC1270E0AF@linux.dev>
References: <20240229152405.105031-1-gscrivan@redhat.com>
 <1B974CF9-C919-48F5-AC0F-7F296EC5364F@linux.dev> <87ttlq5q6g.fsf@redhat.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Mar 1, 2024, at 16:09, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> 
> Muchun Song <muchun.song@linux.dev> writes:
> 
>>> On Feb 29, 2024, at 23:24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>> 
>>> pass down the idmapped mount information to the different helper
>>> functions.
>>> 
>>> Differently, hugetlb_file_setup() will continue to not have any
>>> mapping since it is only used from contexts where idmapped mounts are
>>> not used.
>> 
>> Sorry, could you explain more why you want this changes? What's the
>> intention?
> 
> we are adding user namespace support to Kubernetes to run each
> pod (a group of containers) without overlapping IDs.  We need idmapped
> mounts for any mount shared among multiple pods.
> 
> It was reported both for crun and containerd:
> 
> - https://github.com/containers/crun/issues/1380
> - https://github.com/containerd/containerd/issues/9585

It is helpful and really should go into commit log to explain why it
is necessary (those information will useful for others). The changes
are straightforward, but I am not familiar with Idmappings (I am not
sure if there are more things to be considered).

Thanks.

> 
> Regards,
> Giuseppe



