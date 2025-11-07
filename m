Return-Path: <linux-fsdevel+bounces-67435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADEC401E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7731E3435BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54622E62AC;
	Fri,  7 Nov 2025 13:29:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0C2E54A0;
	Fri,  7 Nov 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522199; cv=none; b=LFUyeCIagt9wzhFM9YBcULevx055iuqpj9a2ftINRK4SJjdUnmtP64paf35QCfIDXZRDfLO36ym2dFJmfxY7w+8pQD5s1U4HkZ92CEITcX3Kt/rvBV+GCycTUgY01B7ZZI3W1FQh9GBt/9A3jwWlC0z08XBYC0X/e8KdEEa0suE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522199; c=relaxed/simple;
	bh=8iXwrOU0C3IojicxUuawvMbCEKKsTTuMh6/gsqE3GaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSeofoocyUEq5cnQFJX1orczXOomPOkuqycJ668jN7TzsEqG3EfZIlaBFhaJ+iCaLEOFPp+UAoC0Q3BqbSz/z/4/bN9xgTZm0C7E+RhBsR8nH+9umi6TRi/MVpR4mNp4VlgKERSpSwTukRAh5lcTgLUjkDNxfPV7BNMhxdw/g9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0246227AAE; Fri,  7 Nov 2025 14:29:49 +0100 (CET)
Date: Fri, 7 Nov 2025 14:29:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: Fix server hang when there are multiple
 layout conflicts
Message-ID: <20251107132949.GB4796@lst.de>
References: <20251106170729.310683-1-dai.ngo@oracle.com> <20251106170729.310683-3-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106170729.310683-3-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 09:05:26AM -0800, Dai Ngo wrote:
> When a layout conflict triggers a call to __break_lease, the function
> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
> its loop, waiting indefinitely for the conflicting file lease to be
> released.
> 
> If the number of lease conflicts matches the number of NFSD threads
> (which defaults to 8), all available NFSD threads become occupied.
> Consequently, there are no threads left to handle incoming requests
> or callback replies, leading to a total hang of the NFS server.
> 
> This issue is reliably reproducible by running the Git test suite
> on a configuration using SCSI layout.
> 
> This patch addresses the problem by using the break lease timeout
> and ensures that the unresponsive client is fenced, preventing it from
> accessing the data server directly.
> 
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4layouts.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 683bd1130afe..b9b1eb32624c 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -747,11 +747,10 @@ static bool
>  nfsd4_layout_lm_break(struct file_lease *fl)
>  {
>  	/*
> -	 * We don't want the locks code to timeout the lease for us;
> -	 * we'll remove it ourself if a layout isn't returned
> -	 * in time:
> +	 * Enforce break lease timeout to prevent starvation of
> +	 * NFSD threads in __break_lease that causes server to
> +	 * hang.
>  	 */
> -	fl->fl_break_time = 0;
>  	nfsd4_recall_file_layout(fl->c.flc_owner);
>  	return false;
>  }
> @@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>  	return lease_modify(onlist, arg, dispose);
>  }
>  
> +static void nfsd_layout_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> +	struct nfsd_file *nf;
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (nf) {

Just a little note on the existing infrastructure (and not this change
that uses it)h ere:  I wish this would be nfsd_file_tryget and the
RCU locking was hidden in the helper.  At least some users seems to
miss the RCU protection or rely on undocumented locks making it
not required (maybe?).

> +		int type = ls->ls_layout_type;

ls_layout_type is a u32, so please use the same type.

Otherwise this looks good to me.

