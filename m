Return-Path: <linux-fsdevel+bounces-64836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C916BF5592
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED9CC3514B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D588313270;
	Tue, 21 Oct 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="xIYYXvhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D752F6906;
	Tue, 21 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036467; cv=pass; b=Wx6ACOTs25rIDc/a8DO+pVzvvhjaSasrH7QUlhzaZwSRSBvolHYl9O2CEJmbjMdGq/jJ+MP3geT0fdcloLlTApL0SNa/g9x+xLD9/AQZ1Jt7NY9acxXQEXdqgTwwEFViS4H0fngQpsjODFwUO2piT6BIxvidi5Y7sDLyfsxnz2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036467; c=relaxed/simple;
	bh=kyWJ9roC67QZ319Iyxgmxe8C9zLN9F5Ccnaxj8rj91w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKgi6+qcn17743QFEfDOYo+31W33HsRRxQNo05C4zT/ckWb9WHOdPMMkot3sGbnk/yt7cM8ztVxYLZjNp8BlAF1hXeS+9AkW0bLMTyVIsy9bIIQmzMJf+PTsQVFehyYSkAuEZsOH6jcE4gl5fJNFrwoWY6pyuyhmtEexWewO7U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=xIYYXvhy; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from chcpu18 (191host009.mobilenet.cse.ust.hk [143.89.191.9])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59L8lH6X705340
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:47:36 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1761036456; cv=none;
	b=JLk15leHILx2eBXZwJhOv1TiFq5Rhn/oW9ljdA2IhQ0w7XgrlDnO4Bu1g/ftK9K28yiZzqUXLT1B10aHAHnwJP+eb8ljpfhRCSKEYtKYCT6GYPl8j49BpwhDlVWkUfhKBWIFbaRzoNwheOIqhmV+ejpSHa5at7AJyvTjB8DepLI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1761036456; c=relaxed/relaxed;
	bh=DqWPzOvAXxLlm0VuXAAZzgx40cnlDESWeJC9lpH/EeA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=gjt5xNv0NB3RLmoLr8hUUpZzBeJBWe2TMhXtz3gScdLArZYgAIYD/rQcyLykO91HP0PmetIIIixF3sMdEl0UsGHft8YIjGdX6GPPy/W5hO8FAqmXoX/RPnQAuipgx17QnIVop3wnp0fs9qohbK/leyCmXLgPk6AwE8wCSS4XGXk=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1761036456;
	bh=DqWPzOvAXxLlm0VuXAAZzgx40cnlDESWeJC9lpH/EeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xIYYXvhyG4U2KYRf/wyrkT7GJA+UhE+v2YymzRSQwtHwHZ5SwUO8wxUDbmSP7GWNX
	 6X0Suwpi9GyE3hSZ/GZsi7X2xHrxSrDgKzWRiCNWIy/IAYJcQEG+aQy1oaKvI7PEfY
	 oRgV8D+0XvH6ra2pDNuXyHSjmaaYaggacBbUVJqY=
Date: Tue, 21 Oct 2025 08:47:12 +0000
From: Shuhao Fu <sfual@cse.ust.hk>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix refcount leak in exfat_find
Message-ID: <aPdIkNGpwXwA/SMz@chcpu18>
References: <aPZOpRfVPZCP8vPw@chcpu18>
 <PUZPR04MB63160790974C70C70C8A062481F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aPc-gzWVu6q9FmZ5@osx.local>
 <PUZPR04MB6316F58807941F86C2769FCC81F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB6316F58807941F86C2769FCC81F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Env-From: sfual

On Tue, Oct 21, 2025 at 08:21:57AM +0000, Yuezhang.Mo@sony.com wrote:
> On Tue, Oct 21, 2025 16:04 Shuhao Fu <sfual@cse.ust.hk> wrote:
> > On Tue, Oct 21, 2025 at 01:38:29AM +0000, Yuezhang.Mo@sony.com wrote:
> > > On Mon, Oct 20, 2025 23:00 Shuhao Fu <sfual@cse.ust.hk> wrote:
> > > 
> > > I think it would be better to move these checks after exfat_put_dentry_set().
> > > Because the following check will correct ->valid_size and ->size.
> > > 
> > >         if (!is_valid_cluster(sbi, info->start_clu) && info->size) {
> > >                 exfat_warn(sb, "start_clu is invalid cluster(0x%x)",
> > >                                 info->start_clu);
> > >                 info->size = 0;
> > >                 info->valid_size = 0;
> > >         }
> > > 
> > 
> > Do you mean that we should put these two checks after
> > `exfat_put_dentry_set`, like below?
> > 
> 
> Yes, that's what I mean.
> 

Thank you for your suggestion. Patch v2 has been sent out addressing
your comments.

https://lore.kernel.org/linux-fsdevel/aPdHWFiCupwDRiFM@osx.local/

