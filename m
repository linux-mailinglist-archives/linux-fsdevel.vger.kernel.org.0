Return-Path: <linux-fsdevel+bounces-22846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960391D819
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 08:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF001C21AF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF366F2F0;
	Mon,  1 Jul 2024 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="BpaFwr7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7F64CEC;
	Mon,  1 Jul 2024 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815618; cv=none; b=cIktqeKZnOEH+u7SZOHv7xUZkk14947baM99gfsdH1X2kt5qyBQKR94W+QgPm9tPkB4/DOGc0OyMtIN2X63/GyKJKB/CVyyjKbIcdNZ4ymvGX4dF++jwo3xsi0Q4Wq3ecnwHzNd2G7ckx4GLrLqBgv1pn/lODfW3RfRIa82TiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815618; c=relaxed/simple;
	bh=jMZeRvagEPIt4nT/ZFLx3sBg2tajz5Y4HeESJbh4f7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHgnQrLxnsulxvFHQePWVnpUCE2ZjRBGnQo+wRBquxWxMplNfZEov/UvuCzC7BGEG+TdtPbahpBt9kIPO/Ft7bDiWx21XByqYMtOqz3chFw6+ACDWeRF1A7UGbuWWZ49Xmbpg71gfwkL1ZCpLZiErpO6t2NCs+CTKoTaGwjaye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=BpaFwr7C; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1719815612; bh=jMZeRvagEPIt4nT/ZFLx3sBg2tajz5Y4HeESJbh4f7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpaFwr7CRgKIdssV9xjDr5wjvDdEapHIlc4tAaDeClJ0/J9tQ9odprDQZRMev9XnP
	 s95F/cbboUcEHWTNU8k+S8LsbcA0IdBiiLe/WO2YRUj2nEdn18Xzixx6oHJ/BGNfhW
	 0IHeFDfO/FTNNPwiAjOiq7T3AOdYxs8rIBsfzLWU=
Date: Mon, 1 Jul 2024 08:33:30 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: lin jia <chinasjtu@msn.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBjYW4gYW55b25lIGV4cGxhaW4gdGg=?=
 =?utf-8?Q?e?= meaning of improvement of try_attach function in sysctl.c?
Message-ID: <197a3669-c72f-45ee-8aa7-47bf4816fbdd@t-8ch.de>
References: <DS0PR12MB8069A682100DDA71C3C97DCAB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>
 <e0fc5569-6169-4c93-93c3-76f5e5844192@t-8ch.de>
 <DS0PR12MB80698E311887F57598680BCDB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>
 <88bce653-9985-4e80-9953-3fb107af3ae2@t-8ch.de>
 <DS0PR12MB806916BE88F4847B72B278DAB0D32@DS0PR12MB8069.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR12MB806916BE88F4847B72B278DAB0D32@DS0PR12MB8069.namprd12.prod.outlook.com>


On 2024-07-01 01:06:32+0000, lin jia wrote:
> dear sir :
> thanks for reply,  Mr Thomas,  I read the commit log of "sysctl: Stop
> requiring explicit management of sysctl directories" , found  the
> following section of benchmark in sysctl: Stop requiring explicit
> management of sysctl directories - kernel/git/sysctl/sysctl.git -
> joel.granados's fork of
> linux.git<https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?id=7ec66d06362da7684a4948c4c2bf1f8546425df4>

Please don't top-post, use inline quotes.

> 
>       Benchmark before:
>     make-dummies 0 999 -> 0.7s
>     rmmod dummy        -> 0.07s
>     make-dummies 0 9999 -> 1m10s
>     rmmod dummy         -> 0.4s
> 
> Benchmark after:
>     make-dummies 0 999 -> 0.44s
>     rmmod dummy        -> 0.065s
>     make-dummies 0 9999 -> 1m36s
>     rmmod dummy         -> 0.4s
> 
> does it means the difference on the performance between new implement
> and old of sysctl?  If that's the case, it seems the difference is not
> significant

In your original mail you reported that it helps to exit earlier from
the loop.
This commit completely removes the loop, so I would guess that should be
even better.
The benchmark probably also depends on the actual usage, did you test yours?

Personally I don't know much about the sysctl internals, especially that
old ones. So can't give any other advice.

> ________________________________
> 发件人: Thomas Weißschuh <thomas@t-8ch.de>
> 发送时间: 2024年6月29日 19:19
> 收件人: lin jia <chinasjtu@msn.com>
> 抄送: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Luis Chamberlain <mcgrof@kernel.org>; Kees Cook <keescook@chromium.org>; Joel Granados <j.granados@samsung.com>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>
> 主题: Re: can anyone explain the meaning of improvement of try_attach function in sysctl.c?
> 
> Hi lin jia,
> 
> thanks for posting to the list.
> I'll also add Joel, Kees, Luis and the fsdevel lists to Cc, as per
> "PROC SYSCTL" from the MAINTAINERS file.
> 
> On 2024-06-29 10:54:15+0000, lin jia wrote:
> > Hi all:
> >    I've been reading the sysctl part of the Linux kernel source code( 3.3.8) recently and encountered some issues. I'm not sure who I can ask for help.
> >    In sysctl.c ,  the function of __register_sysctl_paths is to register a sysctl hierarchy,  I am confused by the function " try_attach",
> 
> This is a very old kernel.
> 
> The function you mention was removed over ten years ago and the way
> sysctls are registered today is completely different.
> 
> > /* see if attaching q to p would be an improvement */
> > static void try_attach(struct ctl_table_header *p, struct ctl_table_header *q)
> >
> > what is the meaning of "improvement",  I don’t know the matching standard for the entry in the list
> >
> > another question is , why not break when variable is_better and
> > not_in_parent is true, so as to save time,  when I config about 2k~4k
> > net device objects in system,  "register_net_sysctl_table" cost
> > considerable time.
> 
> try_attach() was removed in
> commit 7ec66d06362d ("sysctl: Stop requiring explicit management of sysctl directories")
> citing performance reasons.
> This may be same performance issue you are encountering and maybe you
> can take inspiration from that commit to avoid it.
> 
> Or even better, upgrade to a newer kernel.
> 
> > <snip>
> 
> 
> Thomas

