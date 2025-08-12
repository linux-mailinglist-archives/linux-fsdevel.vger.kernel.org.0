Return-Path: <linux-fsdevel+bounces-57468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC27B21F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8496869F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247592DEA62;
	Tue, 12 Aug 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV7aYnWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710771FBE87;
	Tue, 12 Aug 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984006; cv=none; b=nSZoticI9EBmADuY6Gen0B0M5j6JcXUsWeFbXlao75WEMHY4EFrxGbIKW1QqhUhFdb7mgFjywuZHb2eH5iek3bURF5wttYNgARodkAYry07cT/Cxs6Oc76tr9HPxMVkWckv+EnbnbFPiq/Wbv6Vj/8t5PhNNxBUGfxU/fKU45k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984006; c=relaxed/simple;
	bh=1zwIg61p0aZAz/MHzJHLtHrthB9VhlqRgKswzzLDMvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PprAxaeiaGe7eqgk227Kimh86z1XVoJw3hE2Jp7SiCVlRWXwj9cEPB7jr6Z1smllUnTJuB2+vxNgiIv6jt/mI/YbHrbb/MIfF971Myyu3nvQ7c+l/gqFidyeemx4bOYwnfJKXsEgSHuftlRw2n3EM1EHNod3ob2SijCUpVuGibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV7aYnWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0F1C4CEF7;
	Tue, 12 Aug 2025 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754984006;
	bh=1zwIg61p0aZAz/MHzJHLtHrthB9VhlqRgKswzzLDMvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EV7aYnWLpVgEV8DPgJrDBgLiTguQZXAAcUklGDv+bi/inh03vNkEXU3h2cGGK5Z6U
	 /LQY4KruwgX6C5avdYZQoDDe7lrLP6kKBo0n2f4V/GUYbkwJ77Qqlw0CmzDSucgREX
	 zLf2WnOUG//kBuBmP0fbpYE1/y/adcfbyf6dSv9JvUZJz2F6lWoGC+SyUv60c5FKH2
	 tvn5SW1U7e/vjgLbNJ64XBW95zcxVWRxhVazy4yZDo6sSJkOnjlQHtd1ZSEEn7gOPd
	 j2t9RhINxZ5/nCX5vldW7z7C511tEiVOPtGUVas3JsgdtWMXhagoanJRlfZwXxlAg8
	 lJB8kzowbad6w==
From: Carlos Maiolino <cem@kernel.org>
To: djwong@kernel.org, hch@lst.de, dan.j.williams@intel.com, 
 willy@infradead.org, jack@suse.cz, brauner@kernel.org, 
 viro@zeniv.linux.org.uk, John Garry <john.g.garry@oracle.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250724081215.3943871-1-john.g.garry@oracle.com>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v3 0/3] xfs and DAX atomic writes changes
Message-Id: <175498400299.824422.14848821788318521460.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 09:33:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 24 Jul 2025 08:12:12 +0000, John Garry wrote:
> This series contains an atomic writes fix for DAX support on xfs and
> an improvement to WARN against using IOCB_ATOMIC on the DAX write path.
> 
> Also included is an xfs atomic writes mount option fix.
> 
> Based on xfs -next at ("b0494366bd5b Merge branch 'xfs-6.17-merge' into
> for-next")
> 
> [...]

Applied to for-next, thanks!

[1/3] fs/dax: Reject IOCB_ATOMIC in dax_iomap_rw()
      commit: e7fb9b71326f43bab25fb8f18c6bfebd7a628696
[2/3] xfs: disallow atomic writes on DAX
      commit: 68456d05eb57a5d16b4be2d3caf421bdcf2de72e
[3/3] xfs: reject max_atomic_write mount option for no reflink
      commit: 8dc5e9b037138317c1d3151a7dabe41fa171cee1

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


