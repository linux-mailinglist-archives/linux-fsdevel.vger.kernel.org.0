Return-Path: <linux-fsdevel+bounces-16158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB98995E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 08:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA551C21A41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5225765;
	Fri,  5 Apr 2024 06:51:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40623774;
	Fri,  5 Apr 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299902; cv=none; b=Rzqe/y5m2Jy8M+epucAu6BmE9wfACUIgyAJgz/Wi0hrq1xGGABRppTa9XwpEVOWHt6FWJS8l5JqBJxijrrqceN35mZZlCWynS1J/B+VPm9oQOdoVmjNYQDbcO7Z2xGVRib5SRllqVkZKIUspYA+DPracfeqjhdShN2r/vRO7BIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299902; c=relaxed/simple;
	bh=u0DVGxQ/Nm0tNWYQG+wNZ6KotMW7/NQoiImt8Bh6Iu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUXlUJfxsFHvaqO00xwhC2Q6OhwGpZMaCdTOSoTZ5MHr9lnDgqHyfgrdgg+3AIuQVbOzBzPh+Ud2oSvmuKK4DHZ9SrMbhO1PhH7m9obKwwPs+srIe0eIyT+1ramDPry/kI0z2bfuZR2enhbyC2tshgrR4LBr2+dYgLGR+iQirR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C4B768D07; Fri,  5 Apr 2024 08:51:36 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:51:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240405065135.GA3959@lst.de>
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com> <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com> <20240404081122.GQ538574@ZenIV> <20240404082110.GR538574@ZenIV> <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> I don't follow what you are saying.
> Which code is in non-starter violation?
> kernfs for calling lookup_bdev() with internal of->mutex held?

That is a huge problem, and has been causing endless annoying lockdep
chains in the block layer for us.  If we have some way to kill this
the whole block layer would benefit.

