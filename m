Return-Path: <linux-fsdevel+bounces-14555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F887DABC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108E41C20BF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE091BC46;
	Sat, 16 Mar 2024 16:18:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D141BC26;
	Sat, 16 Mar 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710605915; cv=none; b=lSTVKGJCYK80HG6mVUqDsFKn/B+MHcYEivnEJDz9nREMTekDWoCcWQt2cUzGZ1xm3cwa1Jzgdh8bVqjYn4W+hCfJVZUQFobcxi6pBIiyHWzIgHLGJoNFhf1Igt97vQSMmj6OqNuR3e4b/UEBpzNoJcNq5EnBNkIAYN/9R3CLoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710605915; c=relaxed/simple;
	bh=hvbUUq9f/GiXN7fKCaWZQk8iwgflf0jTqSr+1+6t9kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfC9eGNQzIkvMbhQDc3OGU5DlLYoSSd577s9BdneS0bIkZlsK8aUdq47uGeXPzYDN7bOJ6tZMmNPn5b/rUkFhufyaxKS4ocSVtjE8ogR3kHZQSXrF9IBVuJ8IiC2OZicj0auIm592n64o9p9U6ppi4a5TH+ebsWZZ8IwNJeZKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id F129B8C2405;
	Sat, 16 Mar 2024 17:18:30 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: bcachefs: do not run 6.7: upgrade to 6.8 immediately if you have a multi
 device fs
Date: Sat, 16 Mar 2024 17:18:30 +0100
Message-ID: <4555054.LvFx2qVVIh@lichtvoll.de>
In-Reply-To: <2c3smz5wnk5z2kaqyqbo6kr3bb6dtvanfvupsqdydggzmvkukc@xssb53m4lyey>
References:
 <muwlfryvafsskt2l2hgv3szwzjfn7cswmmnoka6zlpz2bxj6lh@ugceww4kv3jr>
 <12416320.O9o76ZdvQC@lichtvoll.de>
 <2c3smz5wnk5z2kaqyqbo6kr3bb6dtvanfvupsqdydggzmvkukc@xssb53m4lyey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Kent Overstreet - 15.03.24, 18:57:51 CET:
> > I take it that single device BCacheFS filesystems can be upgraded just
> > fine?
> > 
> > I can also recreate and repopulate once I upgraded to 6.8. Still
> > waiting a bit.
> 
> No need to recreate and repopulate - you just don't want to be going
> back to 6.7 from a newer version.

Unfortunately I need to do exactly that, as 6.8.1 breaks hibernation on 
ThinkPad T14 AMD Gen 1:

[regression] 6.8.1: fails to hibernate with 
pm_runtime_force_suspend+0x0/0x120 returns -16

https://lore.kernel.org/linux-pm/12401263.O9o76ZdvQC@lichtvoll.de/T/#t

No luck with kernel upgrades these days. :(

I will backup the test filesystem so in case something breaks I can 
recreate and repopulate it again. Downgrading to 6.7.10 then and will see 
what happens. Can repopulate from backup again if need be. Also when
upgrading to 6.8 again after the regression has been fixed.

Best,
-- 
Martin



