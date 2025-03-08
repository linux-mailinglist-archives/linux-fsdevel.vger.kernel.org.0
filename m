Return-Path: <linux-fsdevel+bounces-43528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B7A57DB6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BF87A55CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407961EB5E6;
	Sat,  8 Mar 2025 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BLVTFt2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F449620
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461323; cv=none; b=GV3G4K/1pMbHrLuksd6Wr3yhwWQYKpfHh7CguQz3qp+Ls1PTtfjHxaI38WHy+L6nQwscEATJqHdaEXszUSka4yyABqjCeLkvd6SfB3b3heaqPmYc97JRIQF8CK1bAUo5nlxdgNd7rxjVCaGWIN6Si85lSLCsbGxp5EFZMsDVcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461323; c=relaxed/simple;
	bh=VDCJKutHmSz/5La3lz5PJbl5ZWBxk4kyfp1yUDlRlpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV7ASfL+L95H47ZJ5HcuM4ddiARzrknSAIrTy95J00dewppUmlZZ6DTThEcb1l4+XNQB+EZfJxoj1Q/KgdUpQaN46FXXBI6nRS/KdGH0zwxeFxhHZY/jxjWPmzB8vqPLzg7ASH23OYPRaq2QxpLYR7lnmFRnum5sKUgeiX2i2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BLVTFt2X; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9CXl6Yp7zXym;
	Sat,  8 Mar 2025 20:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741461319;
	bh=XzFUGkJEyiyA873F6Twj4a/Wg9Xdpy8nIyVORKhmS1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLVTFt2XFfysAMI/1yqUt95oesseticqQI8pvPmO9xnAgz7Ci3YBe1k/jF03ZszUS
	 CnNSCOXyi9SdmL465HkgK6qUfuBBIds0IukvKjJFhWQUbQjpfe6xZznzmPijb8N+VY
	 wsW1NErIxuEweBPa2Q8ABjCEqR2hvWss+OGWIdSE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9CXl303Tz47r;
	Sat,  8 Mar 2025 20:15:19 +0100 (CET)
Date: Sat, 8 Mar 2025 20:15:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jan Kara <jack@suse.cz>
Cc: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <20250308.Ce9iqu4evooL@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <7hpktxh4s6pho2cgoi6x7ptzimqrgflgbztrmtnamstpuefooj@orahctcwxqxm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7hpktxh4s6pho2cgoi6x7ptzimqrgflgbztrmtnamstpuefooj@orahctcwxqxm>
X-Infomaniak-Routing: alpha

On Thu, Mar 06, 2025 at 10:04:54PM +0100, Jan Kara wrote:
> On Tue 04-03-25 01:12:56, Tingmao Wang wrote:
> > Alternatives
> > ------------
> > 
> > I have looked for existing ways to implement the proposed use cases (at
> > least for FS access), and three main approaches stand out to me:
> > 
> > 1. Fanotify: there is already FAM_OPEN_PERM which waits for an allow/deny
> > response from a fanotify listener.  However, it does not currently have
> > the equivalent _PERM for file creation, deletion, rename and linking, and
> > it is also not designed for unprivileged, process-scoped use (unlike
> > landlock).
> 
> As Amir wrote, arbitration of creation / deletion / ... is not a principial
> problem for fanotify and we plan to go in that direction anyway for HSM
> usecase. However adjusting fanotify permission events for a per-process
> scope and for unpriviledged users is a fundamental difference to how
> fanotify is designed to work (it watches filesystem objects, not processes
> and actions they do) and so I don't think that would be a great fit. Also I
> don't see fanotify expanding in the networking area as the concepts are
> rather different there :).

Yes, I agree.  We should take inspiration from the fanonify interface
though.

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

