Return-Path: <linux-fsdevel+bounces-26023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EAB952922
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 08:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6932E1C22301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527F176AD3;
	Thu, 15 Aug 2024 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=eugen.hristev@collabora.com header.b="K70a8Ryb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9C39FE5;
	Thu, 15 Aug 2024 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701838; cv=pass; b=Jg+K7KlXXsL142ZB1vwxBXEqokJ5fd3vCTUcm8IaGOnED1oLa6Jod+Pc5NOzTE06PXnbd4fTdV+8aAzT4WKkXcsl+6U/K0xxtE1Vzbz8XU69JCcL1bcVyynmpwHGmHmp8IUsr4RW1p1xyRNQlJfyP7dRQRR5nqaVbJNH7A6n13k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701838; c=relaxed/simple;
	bh=Xx+/AyQ134n42czrEU1KUaSRZpjaDaWaFu7zmyt8Z9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ow6Rk43wRPqWT5MA4KgP8P2VKdvzNpsGAQehQ+qiJH15rg1fGaEuvEF9fIHb1W72IwJG3fCSpBPaFxXn31WRkxi2HKiWJcXA+e+dBSALvT5Vw8124ifPwE/gb0C+yANe+00rAxG2WlrOFXmZhf51gAKxBvSFh3mTyid16uUoogw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=eugen.hristev@collabora.com header.b=K70a8Ryb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723701809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ONLkAptYYvW1RCG+LSVVZuOogSmAj3as3u35Npi40VFIiYnAxMYSjsagXDeFj68fad/Hm45W03HrVnh12b+0aL9NWG8x3IAEEHSY+MtTqqDQI3SX6loCvwwXo5wz3bj0yUaH+6ZYcHHFxfXXILNN5dlbGlwequQNiS6FwcfsReI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723701809; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IFcEpqXjckIV9NDm7vtqPjwRNp0LilOzZsxtjiZwS7s=; 
	b=GR8sAB6+6a/ScTl7S4bl9sqnj5W84KI9mq0bs/ljQlz+qjKKPPTEjrd4U7O8AyyVD/PqRQgWKniNQoiVnPjfkT6+o6gfOkYIOwM8CdkXKKVXDSfVcDdpvG2KMR73PCRung83f6I4fjysLrlwvfpiJkn5WqTq2Sag9/64qs5Y7I8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=eugen.hristev@collabora.com;
	dmarc=pass header.from=<eugen.hristev@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723701809;
	s=zohomail; d=collabora.com; i=eugen.hristev@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IFcEpqXjckIV9NDm7vtqPjwRNp0LilOzZsxtjiZwS7s=;
	b=K70a8Ryb2Bmy6BH8HssYePaGByT2SCAQmnOYGrPfjQK03dKUniQMrdW5L4ygKQmI
	SdBF5KMHiriAiDt1a7lbLypjbDc0nlQP/Gp3c7BCXftbTMrqYsSirH9xwJwi73h54WV
	So77AhAh7t+ExtkCIJ1cLiMIomKwNZOdU/zWNYJE=
Received: by mx.zohomail.com with SMTPS id 1723701807188757.8000277911274;
	Wed, 14 Aug 2024 23:03:27 -0700 (PDT)
Message-ID: <181856a3-3378-4136-9734-b20a732d10c4@collabora.com>
Date: Thu, 15 Aug 2024 09:02:58 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fs/dcache: fix cache inconsistency on
 case-insensitive lookups
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 linux-ext4@vger.kernel.org
Cc: jack@suse.cz, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, krisman@suse.de, kernel@collabora.com,
 shreeya.patel@collabora.com
References: <20240705062621.630604-1-eugen.hristev@collabora.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240705062621.630604-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/5/24 09:26, Eugen Hristev wrote:
> Hello,
> 
> This is an attempt to go back to this old patch series here :
> 
> https://lore.kernel.org/lkml/cover.1632909358.git.shreeya.patel@collabora.com/
> 
> First patch fixes a possible hang when d_add_ci is called from a filesystem's
> lookup function (like xfs is doing)
> d_alloc_parallel -> lookup -> d_add_ci -> d_alloc_parallel
> 
> Second patch solves the issue of having the dcache saving the entry with
> the same case as it's being looked up instead of saving the real file name
> from the storage.
> Please check above thread for motivation on why this should be changed.
> 
> Some further old discussions here as well:
> https://patchwork.ozlabs.org/project/linux-ext4/patch/20180924215655.3676-20-krisman@collabora.co.uk/
> 
> I am not sure whether this is the right way to fix this, but I think
> I have considered all cases discussed in previous threads.
> 
> Thank you for your review and consideration,
> Eugen
> 

Hello,

I have sent this series a while back, anyone has any opinion on whether it's a good
way to solve the problem ?

Thank you,
Eugen

> 
> Eugen Hristev (2):
>   fs/dcache: introduce d_alloc_parallel_check_existing
>   ext4: in lookup call d_add_ci if there is a case mismatch
> 
>  fs/dcache.c            | 29 +++++++++++++++++++++++------
>  fs/ext4/namei.c        | 13 +++++++++++++
>  include/linux/dcache.h |  4 ++++
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 


