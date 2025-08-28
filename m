Return-Path: <linux-fsdevel+bounces-59487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618CB39D34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252514E3158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74EB30F935;
	Thu, 28 Aug 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpGbjg2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2130F547;
	Thu, 28 Aug 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383926; cv=none; b=YERphEOWy0ZKDiKTl71dl491hTZ0Yr5C+C1QKb7DHBApIDYHQSMIPIAS/iG6E+O2+SCylEilkwZamg5hy/wGhmmTuCQfHgN09Vask8CNlo6eM9pFLKp+9UL6uFYTzL5ZXgkhKpD2WzrGQS0JsY5IRUsH+B2BTy8lt9JTuyVrnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383926; c=relaxed/simple;
	bh=sxFZXDa8jERLCRJzbvawXkWWrfTFVr2v+vC5TylGwyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZftlNQKNnI7yND9IdZsb8nZDPapuZaVMuVws5CqyfDs8qlTEkFNT6mYgBRDYpD0x/4fhynYIQTVL6+VE3ngbdVz2uRB8NPG6Bb4b1x81xMqk7y3bQQ2Cwo4CWwOO0gi66iWbtfIlKiPggKoeOfWcwEZWiXvWT1o1M99WYub/Cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpGbjg2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993A1C4CEEB;
	Thu, 28 Aug 2025 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756383925;
	bh=sxFZXDa8jERLCRJzbvawXkWWrfTFVr2v+vC5TylGwyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpGbjg2XugK08UMPFIYdy5M/1AoseXOgOOD2lSbdT/C0HkE/WB52jjVXvn/XilyeR
	 S0dt/PQVYIOaq1tkbU8Mfj4UFtPtvTe06yWgwJVi0vJxTDBMMQL4IyXMSvtnfeyCWj
	 s8YRApThaUQnMXdHt1vq/pUYS1SQt3a5crpgAgL685veiSiI3zDRzr2388axm5G8GV
	 MiGy9Af1GU62rr8XlD2dGZT0D69VFXKSzD/CjQi2oOvwJSlIYIIcRGhuKPgZy64dgJ
	 bo9AiQcZyAtWcdslgJG6m6KTPrTUr4EHAeb9UxvjCUXOrnVbSn9w2a1x4PoSJhiylQ
	 ni/Kv+15ltC1A==
Date: Thu, 28 Aug 2025 14:25:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 30/54] fs: change evict_dentries_for_decrypted_inodes
 to use refcount
Message-ID: <20250828-risse-negieren-f9a3d1526782@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <283eebefe938d9a1dd4a3a162820058f3550505c.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <283eebefe938d9a1dd4a3a162820058f3550505c.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:30AM -0400, Josef Bacik wrote:
> Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
> make sure we have a live inode.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

I have no idea how the lifetime of such decrypted inodes are managed.
I suppose they don't carry a separate reference but are still somehow
safe to be accessed based on the mk_decrypted_inodes list. In any case
something must hold an i_obj_count if we want to use igrab() since I
don't see any relevant rcu protection here.

>  fs/crypto/keyring.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 7557f6a88b8f..969db498149a 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> @@ -956,13 +956,16 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
>  
>  	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
>  		inode = ci->ci_inode;
> +
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +		if (inode->i_state & I_NEW) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -		__iget(inode);
>  		spin_unlock(&inode->i_lock);
> +
> +		if (!igrab(inode))
> +			continue;
>  		spin_unlock(&mk->mk_decrypted_inodes_lock);
>  
>  		shrink_dcache_inode(inode);
> -- 
> 2.49.0
> 

