Return-Path: <linux-fsdevel+bounces-64731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE40BF2F25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E759D4F8190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8231B242D76;
	Mon, 20 Oct 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ3C/7RE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A51A262A;
	Mon, 20 Oct 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985189; cv=none; b=KSYXJ7CrEqiU4MYHSNvkDBvdiswShFFWZlCyAqEoKCu76CVOhS+l8eRIAnxe8fqyAMsBJOvFP9+IBg6T9ruNiP1/9rXBSrXCdb1lGqNgWl4qUA2mKoa3gyuBp80mXRnseeDYzMmHnJUvgTMlU/+crm45kIrOC2WEyp9OYSvajsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985189; c=relaxed/simple;
	bh=hngoAyREJmI3NxsC47gSFZTRqeZYnGhsBqNJamSsNXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9ILvQ1qVnfE8ThB9FzgY49sbEu9kZFwaB1bDDsxkHGsMdPCtge6QiVoBf6hyVanXczI/mzPSyZIdUkQfE7S9JZnH3Np2NYn8A1p3kTLBYBPFjrsrOg2OtujmO7YNoGdfng1A1enxxuz6+IXIFPsyfoCZ5ntuOcOE5Nognv+Yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ3C/7RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A1EC113D0;
	Mon, 20 Oct 2025 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760985189;
	bh=hngoAyREJmI3NxsC47gSFZTRqeZYnGhsBqNJamSsNXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ3C/7RECo6JatE7dPRcwR7OxRUgFqSLoMTtBDqx2H/pQtPRUDbVev1A6ISeKbJ9e
	 rjvDZBisHRDNjkoqQFNumPk+Ojw/yWIqgKlF7a18ZyM+Pfb7DeM1xSj39v9W3SCsKy
	 GB/5iDF1aMkkfxBv4ox6JDTzrb86Cy1acymPJqN8eEQ6muiomsMDFRjJcDH4SQzNNo
	 Bud67/d05MI2/lPv1gmbTW3R2x95u7veFq7svQHE5MXeR/2o0DVCAlV3fqrkY+8GAY
	 1U7jG9ykr58IJZumFnFDorIah4OcTlHiX8QVUzRCNn0W9thjzJ64fG3cGCujNrH7dV
	 ZYm9D9ctmzgIg==
Received: by pali.im (Postfix)
	id A6833678; Mon, 20 Oct 2025 20:33:04 +0200 (CEST)
Date: Mon, 20 Oct 2025 20:33:04 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <20251020183304.umtx46whqu4awijj@pali>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020020749.5522-1-linkinjeon@kernel.org>
User-Agent: NeoMutt/20180716

Hello,

Do you have a plan, what should be the future of the NTFS support in
Linux? Because basically this is a third NTFS driver in recent years
and I think it is not a good idea to replace NTFS driver every decade by
a new different implementation.

Is this new driver going to replace existing ntfs3 driver? Or should it
live side-by-side together with ntfs3?

If this new driver is going to replace ntfs3 then it should provide same
API/ABI to userspace. For this case at least same/compatible mount
options, ioctl interface and/or attribute features (not sure what is
already supported).

You wrote that ntfsplus is based on the old ntfs driver. How big is the
diff between old ntfs and new ntfsplus driver? If the code is still
same, maybe it would be better to call it ntfs as before and construct
commits in a way which will first "revert the old ntfs driver" and then
apply your changes on top of it (like write feature, etc..)?

For mount options, for example I see that new driver does not use
de-facto standard iocharset= mount option like all other fs driver but
instead has nls= mount option. This should be fixed.

Pali

