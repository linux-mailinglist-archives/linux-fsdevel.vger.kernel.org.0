Return-Path: <linux-fsdevel+bounces-14556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18A87DADD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163BB1F22AA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F001BF27;
	Sat, 16 Mar 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h43J1Pat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A1199B4
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710607277; cv=none; b=PojAaR3Z6pki+H5vCN9CZnOp6FndCn65C/+a1hBtrYASTWPJ9holYxLnuf/g5zADQaIdWg5Py02Kx6JuakDsKM0ZiZMtLqYWgn7b1IVF7y/fNyTf2wb0Y6neU1Lv3ax1EABbozlDBuUcYkHr4rmS4GNet1fOZuFIP5Gc2uMO3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710607277; c=relaxed/simple;
	bh=kKffwzgolEu+ProIAthVzsYCW1zHl+A3Na/D6agUWRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orh9quNJeLcsouUHZT4KEb+f4cOZIpgP27HuNDsIf2GepOb7NPaquZIG9DkLB/rXSO4k3Rbh8ylqb0p3ydfnedaJio09CNDcMoU3/MFXnfTUeX0jHxO2/p7ZUdTJ2Cj9YxAj6DV5aQJGFaibRpGePBLEJG9C2qU5+agMjk13U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h43J1Pat; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Mar 2024 12:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710607273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6fD5UoE5jQH4CqrkoJBA79RG3yUAYDA0Plt93ehr1FY=;
	b=h43J1PatXnrqLWZSfKdJ8ThM+nYkiEav5GGQ+Oew0NSYDNAt3zqTE3SCSFj0MCKeEj65Dp
	gwx+VthKFcA8fZz9x7DeWo9E55quLa6mgsSQqQKtKOjpEj7VXviYvWwQBEfoOezzGOlZDi
	65HydDCfSXVHR3WkYQRiqBB42hTttwg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: bcachefs: do not run 6.7: upgrade to 6.8 immediately if you have
 a multi device fs
Message-ID: <foqeflqjf7h2rz4ijmqvfawqzinni3asqtofs3kmdmupv4smtk@7j7mmfve6bti>
References: <muwlfryvafsskt2l2hgv3szwzjfn7cswmmnoka6zlpz2bxj6lh@ugceww4kv3jr>
 <12416320.O9o76ZdvQC@lichtvoll.de>
 <2c3smz5wnk5z2kaqyqbo6kr3bb6dtvanfvupsqdydggzmvkukc@xssb53m4lyey>
 <4555054.LvFx2qVVIh@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4555054.LvFx2qVVIh@lichtvoll.de>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 16, 2024 at 05:18:30PM +0100, Martin Steigerwald wrote:
> Kent Overstreet - 15.03.24, 18:57:51 CET:
> > > I take it that single device BCacheFS filesystems can be upgraded just
> > > fine?
> > > 
> > > I can also recreate and repopulate once I upgraded to 6.8. Still
> > > waiting a bit.
> > 
> > No need to recreate and repopulate - you just don't want to be going
> > back to 6.7 from a newer version.
> 
> Unfortunately I need to do exactly that, as 6.8.1 breaks hibernation on 
> ThinkPad T14 AMD Gen 1:
> 
> [regression] 6.8.1: fails to hibernate with 
> pm_runtime_force_suspend+0x0/0x120 returns -16
> 
> https://lore.kernel.org/linux-pm/12401263.O9o76ZdvQC@lichtvoll.de/T/#t
> 
> No luck with kernel upgrades these days. :(
> 
> I will backup the test filesystem so in case something breaks I can 
> recreate and repopulate it again. Downgrading to 6.7.10 then and will see 
> what happens. Can repopulate from backup again if need be. Also when
> upgrading to 6.8 again after the regression has been fixed.

run this tree then:

https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-v6.7

