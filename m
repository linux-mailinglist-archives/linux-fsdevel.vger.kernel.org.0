Return-Path: <linux-fsdevel+bounces-54006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B9AF9F16
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 10:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE42C1C45DB2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17B4224244;
	Sat,  5 Jul 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A1TtvcP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBC9475
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751703372; cv=none; b=EdyO8Jw5JMNVRvXGSCp5lbs6pCa1SfFlag+4LqK+o8GJIv728p3CTwJMG+7jcEb/ZicUEDJFdqmrPgqSE5X1GhDSYi1tnPb1Y0r+Ry+rZ6I4tjcHNxSLJQnndQWC32A4MSH8PT5OEb5CQRbCVHuf6D//SZ19dA0PdCfGKiXHPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751703372; c=relaxed/simple;
	bh=6B5FRP8L1KRuVh3TsN1XocpXahIOP7WtTZJ4PeGKPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X43ovvmHEftk1sxzKfWOOL2ov8m+rS8/Ph3eOl7qT+cnhiw1l5NPC37MqjQ28d4xcesjU6Fcg+VYjjiKNwymx8gHpCraeaz9mP1h8BuN59SWGMtLVRAY1kGDrxjB6xJLU4vhRIgomOrA93iup7ehwBg3rCIiyi9Pixs1tmsO0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A1TtvcP0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pp9G0BqyWEEtcE1Iy0Fp6ar9kC+/QMYOg70LKVlOwo0=; b=A1TtvcP0nOPFHpLTrpXzrCYg7v
	4X51rHQ9PjhET1X0M4lc7DGim/AIxoMfABiZCKonhfNOXlq01CiTIPOKXSBqvdAVOBqlRkrlQG4Gf
	u/vmAUAS1xTtF9VWqyt9N/9YqYJvERpHESnWU/csx7cYTSXgSVsF3F66C+MuT4dkIa1uNf5g4n6T4
	GL/RLJ8uooiGUgDdaxtKNSQjNL8zE/rl+Ref8+cpJGXd3m4snTT7DMSs2wqwrq5ye83NGz3/TMuz7
	vwCVXQyNqRlHy/YwW9xlXFDpPeQ9Y4+Iucyq1b1Nv7NO/b89+byB3dyRi99dATkxRJD4fzvgmBpOA
	Ex6Q3/KA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXy44-00000001PDM-3dL0;
	Sat, 05 Jul 2025 08:16:04 +0000
Date: Sat, 5 Jul 2025 09:16:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250705081604.GY1880847@ZenIV>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV>
 <20250705000114.GU1880847@ZenIV>
 <CAJfpegu8aidxbF7XwfkC02waYpGNHSu1v184UEa2M8CTwtSGjw@mail.gmail.com>
 <20250705055715.GX1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705055715.GX1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 05, 2025 at 06:57:15AM +0100, Al Viro wrote:
> +static inline void mnt_add_instance(struct mount *m, struct super_block *s)
> +{
> +	struct mount *first = s->s_mounts;
> +
> +	if (first)
> +		first->mnt_prev_for_sb = (unsigned long)m;
					 ^^^^^^^^^^^^^^^^
					 (unsigned long)&m->mnt_next_for_sb;

that is...

