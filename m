Return-Path: <linux-fsdevel+bounces-14133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B88780F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02A41C221B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2E3FB94;
	Mon, 11 Mar 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuwmEZGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5533070;
	Mon, 11 Mar 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165156; cv=none; b=cg6CmMDJ6uZcycQynW9a2cJ/MpldkyzNYm1+Clpoz5b2Td0xQOGDtUSmPF3KViHfFYi2yHt6psztGbnf43h8bfzx8taLfnYLO+pIk8JJpHtoyL2Fp8iu5rnA0Z3ZW4FzXMNXL87bZH2T0nEIr7Gnevb2cD/qCHJSE5U32dFC2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165156; c=relaxed/simple;
	bh=h6afG13XMRMdLzEs28dWZKjJEqPyHjcxouc4tzKmG1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu8Pr7TM6xc0b6nQEopYEr2uebJe7CLv6Ea25yD0IciTBOmc7YQXnyO8/thw5wxqDGhElovOScJSQajdthSQAxh3mkgDwTtZbTuHb1dXvj2Q9L+P45iCNEPW5QW6BO/e9013J7yJWVHvUD5sndSfbJJ+9jW5iz6O/A3FIo81cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuwmEZGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CE8C433F1;
	Mon, 11 Mar 2024 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710165156;
	bh=h6afG13XMRMdLzEs28dWZKjJEqPyHjcxouc4tzKmG1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuwmEZGiZCzLxHwf+V9pn5GzIcRUVpW+D3unKvoRrq5oTXPvedjoBvgtM0xGy+Fig
	 SKWMJnfIZ9SVWG9UpmUJjOI2U+wd2kcWMNDEZY1vZw+YVskYlTj3AaBUvkZD4gFp0R
	 yacw2KKHy4jpkN8c22E/1vLCX+luYw6cTNlv0v34y90u67UoFseiBU+6elrqE0rUkd
	 o/JDqvTkgEEpLAGWaiTa+UsUpllIFOszVg96GRMt2EGC1YjFG28E0pvKWTuVVPAYR3
	 gipFGQnVuixvS03+Xy6+bVl7OazSpDdvcKbRz1n5XOb2S23WQGqo9gzvfKN3rtAZc1
	 HdrBe5ZWg76wA==
Date: Mon, 11 Mar 2024 14:52:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH 3/4] ovl: only lock readdir for accessing the cache
Message-ID: <20240311-angreifbar-herleiten-a13b6c6d29ed@brauner>
References: <20240307110217.203064-1-mszeredi@redhat.com>
 <20240307110217.203064-3-mszeredi@redhat.com>
 <CAOQ4uxh9sKB0XyKwzDt74MtaVcBGbZhVJMLZ3fyDTY-TUQo7VA@mail.gmail.com>
 <CAJfpegsQrwuG7Cm=1WaMChUg_ZtBE9eK-jK1m_69THZEG3JkBQ@mail.gmail.com>
 <CAJfpegv8RyP_FaCWGZPkhQoEV2_WcM0_z5gwb=mVELNcExY5zQ@mail.gmail.com>
 <CAOQ4uxj9=FRnN-qiXdt5PFp15Nx9Jfqx3+8_eSSGy_xgHQ0tHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj9=FRnN-qiXdt5PFp15Nx9Jfqx3+8_eSSGy_xgHQ0tHA@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:31:35PM +0200, Amir Goldstein wrote:
> On Thu, Mar 7, 2024 at 6:13 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 7 Mar 2024 at 15:09, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Thu, 7 Mar 2024 at 14:11, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > P.S. A guard for ovl_inode_lock() would have been useful in this patch set,
> > > > but it's up to you if you want to define one and use it.
> >
> > I like the concept of guards, though documentation and examples are
> > lacking and the API is not trivial to understand at first sight.
> >
> > For overlayfs I'd start with ovl_override_creds(), since that is used
> > much more extensively than ovl_inode_lock().
> >
> 
> OK. let's wait for this to land first:
> https://lore.kernel.org/linux-unionfs/20240216051640.197378-1-vinicius.gomes@intel.com/
> 
> As I wrote in the review of v2,
> I'd rather that Christian will review and pick up the non-overlayfs bits,
> which head suggested and only after that will I review the overlayfs
> patch.

On it. Had been on my queue but didn't get around to it. I wanted to
play with this a bit.

