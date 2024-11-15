Return-Path: <linux-fsdevel+bounces-34999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27B9CFAEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 00:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C19288ADF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 23:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46637192D9A;
	Fri, 15 Nov 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uSpudNOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFD824BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712339; cv=none; b=no25Q65oOaJ02mPgzQkB7bbJbERVEb/aWsXrzA0eGg8G+FJffRfkknNd0Si9jaNwX461HjFGNXP/3h0mHVXFgbG5Q7Hru4aVy0ghkxfghtk/wsENb7p415jVmnte7XgGZVBDCzFJdZd8b017129O47EQyuBfXJLMfdCIASrhL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712339; c=relaxed/simple;
	bh=JuHD5gpQK+SdoSDEAkL6JWtW03wkRHX9p61GTvpBonw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFJtoJji5rwAACBE5793p/IwPdIEEw4dfC65zrFRDZafgRzA77E0jd6sJVm+1msqBIzckXDRxK2P8HWv/gs2a7jW5C1tnvs49GLgfA8gEbwBOJQFw4q7sb6YxXjpzc83nJVDP4lZd/hY6kturThlF/CH4dyxFRDPEIOU4uixj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uSpudNOV; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 15:12:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731712335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHfdDZoSwlnSxXwkj/JFyaVvB+bWrTXJ0GuvPgcg21w=;
	b=uSpudNOVzrFahdAVhbs1OAX3WlPEf/puuRMpsxMgOu/uNgfg01RMm95JZhL0QAp2vsyqGo
	ettBUqlq5hMeZKe1FsOybFMPWkGpj9ObBAMWJgINgFpXY5maSnYV7pXKID4AsQ1y9YcG7j
	Z8sEJj7V3QeIs0rZNdNLIl8xI08YS4g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v5 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <vtqdv4frejx4ikkj64wzrqqk2wdycs7jkd3mikmhzcy2r7vvj5@ej75b5fn4loq>
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115224459.427610-5-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 02:44:58PM -0800, Joanne Koong wrote:
> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
> writeback may take an indeterminate amount of time to complete, and
> waits may get stuck.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

