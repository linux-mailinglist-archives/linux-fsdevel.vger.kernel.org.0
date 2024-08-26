Return-Path: <linux-fsdevel+bounces-27138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DA95EEA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B3C2836D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341614A639;
	Mon, 26 Aug 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+Qz6zNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDC14A617
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668784; cv=none; b=mrHAGpQPGGO+6xsP/tHKfuZpn1t6MnVBQC6WAWt+Y6rNJi0/19xMzoiZw4e9nfTPgLhu5VIyNiouxi/oHSAuk7V124DBTQSvsIbo5Ih6TAVBWdYohQPQp4tcspfdnQXrTqeB14v5Ox2ttwdkTcjjYoBrMiY0pXD+rhhp/ekNtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668784; c=relaxed/simple;
	bh=hESx77ebw8dZgO4uq4/MDtB481GaPvFBexLUlmVoFY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKk+NGElJNF2CM4TonMvCi3fNvAXLFluFIHakUuj6kALBVOCh/DBksT4UYJukCNSk5hEDPnkGj/4VHFghuOLd3u94yVNZM6eJezMDyi8ebbbSJX8UK5+EHVdq58AQzYy+mXnEX1UU7AI14jsU8xmohXXreJbS/pQuCjbmyC339g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+Qz6zNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC0DC51407;
	Mon, 26 Aug 2024 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668784;
	bh=hESx77ebw8dZgO4uq4/MDtB481GaPvFBexLUlmVoFY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+Qz6zNBuLU8oAYy0zmkUKjKSgpFNN1t49JgXWMUuJwR1Fd9YQA+pUzFUQqE7apwy
	 uV9C9FHQCYP674/3x9Zv+t4lfNWiyOKocIETH64wng20+V3rImgdvmn8RaoxqiBKmf
	 FRza7VWwasvuPFqt1GPN3xePKBxVM+7xtaJVoCn9fLx4AnudpDICZr3gl1Mfon97SI
	 jEJkTMRV8poooFR6YdZRmGq9uoRnKYHXSEjzhLGUuGdlKZ7P4YaZd/GrQG5cyASnyu
	 Cbyo3aoK2vDeJnF0kpf6rbmZk2p9S0wbpDZi7Sl2NkBEAHzi/rA9ThtWP4bxcdEWSk
	 sUVOtTEh3OB1Q==
Date: Mon, 26 Aug 2024 12:39:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] fs: proc: Fix error checking for d_hash_and_lookup()
Message-ID: <20240826-festland-ungeteilt-a281f70a1afc@brauner>
References: <20240826090802.2358591-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826090802.2358591-1-yanzhen@vivo.com>

On Mon, Aug 26, 2024 at 05:08:02PM GMT, Yan Zhen wrote:
> The d_hash_and_lookup() function returns either an error pointer or NULL.
> 
> It might be more appropriate to check error using IS_ERR_OR_NULL().
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---

I distinctly remember having NAKed a patch like this either earlier this
or last year. Procfs doesn't have a custom d_hash() function so
d_hash_and_lookup() will never return an error pointer afaict.

