Return-Path: <linux-fsdevel+bounces-22808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28191CC58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF261F21E82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BA482D7;
	Sat, 29 Jun 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="jI+a8ibg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50D1DA53;
	Sat, 29 Jun 2024 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659970; cv=none; b=KRv8SRSVn3YPHDhEnPhJCpazMSnOuGLPK9xErBbybYBoCVBQMBh1d2XuJdzwUX2Q9d73ngTjGnPCrfljMruugOvgSZPB3HLXb7vljpbIA+ldNp+RkgHoe986sjYjjA69T7qxg0MITYluU4NRT591DDjlYahh1qvXuYcs6ZVkhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659970; c=relaxed/simple;
	bh=lrIqHyuGoF7AjCj2b9NNA59IMJzZbuLuT0VFmF6IutQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPHJLZbXJFeSaGAeZ+O7kokB2rMeELO0KCqhs5uDqME414+IH+dhoQ/ViEnHa75kkYo++ujRbqSV8aN0KUH0176UfjaAgbC4e0fGCuDMOcn6IhquSX7101KtuJrAoZEPtEYC3D+P0bAD+NG77AMXMLIyp/JEQcuD1LFwRFuuwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=jI+a8ibg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1719659965; bh=lrIqHyuGoF7AjCj2b9NNA59IMJzZbuLuT0VFmF6IutQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI+a8ibgWQ+i2FZnNno6FgELqSuNGiHhN597SnZgwI21mOPHSKDhUVJKGXp1dDRk9
	 3jRPlbg05CXL2b5tDGbDBaH0F8uiWY0vmZGGGHNhEAATNqrp0hm68w/OLWg8HWejmN
	 ySq20rojU+r4ftFfqOAwsBx/SpnBhsV+M6GP/5Co=
Date: Sat, 29 Jun 2024 13:19:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: lin jia <chinasjtu@msn.com>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: can anyone explain the meaning of improvement of try_attach
 function in sysctl.c?
Message-ID: <88bce653-9985-4e80-9953-3fb107af3ae2@t-8ch.de>
References: <DS0PR12MB8069A682100DDA71C3C97DCAB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>
 <e0fc5569-6169-4c93-93c3-76f5e5844192@t-8ch.de>
 <DS0PR12MB80698E311887F57598680BCDB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR12MB80698E311887F57598680BCDB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>

Hi lin jia,

thanks for posting to the list.
I'll also add Joel, Kees, Luis and the fsdevel lists to Cc, as per
"PROC SYSCTL" from the MAINTAINERS file.

On 2024-06-29 10:54:15+0000, lin jia wrote:
> Hi all:
>    I've been reading the sysctl part of the Linux kernel source code( 3.3.8) recently and encountered some issues. I'm not sure who I can ask for help.
>    In sysctl.c ,  the function of __register_sysctl_paths is to register a sysctl hierarchy,  I am confused by the function " try_attach", 

This is a very old kernel.

The function you mention was removed over ten years ago and the way
sysctls are registered today is completely different.

> /* see if attaching q to p would be an improvement */
> static void try_attach(struct ctl_table_header *p, struct ctl_table_header *q)
> 
> what is the meaning of "improvement",  I don’t know the matching standard for the entry in the list
> 
> another question is , why not break when variable is_better and
> not_in_parent is true, so as to save time,  when I config about 2k~4k
> net device objects in system,  "register_net_sysctl_table" cost
> considerable time.

try_attach() was removed in
commit 7ec66d06362d ("sysctl: Stop requiring explicit management of sysctl directories")
citing performance reasons.
This may be same performance issue you are encountering and maybe you
can take inspiration from that commit to avoid it.

Or even better, upgrade to a newer kernel.

> <snip>


Thomas

