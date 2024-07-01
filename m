Return-Path: <linux-fsdevel+bounces-22903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC5A91EB89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6681C211E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786CA173323;
	Mon,  1 Jul 2024 23:48:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEF502A9;
	Mon,  1 Jul 2024 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877687; cv=none; b=PdCuaHQd8jsyj0OdEOqgrRjMeUD21pyfmfx5EF2YYobYmD51NRnaQuXc2upWrB8KezDbeNuB6rRm6J7EirxiBtgHRHp0Pze8KeJp98IwLF2hUtymUg0K9JS0sQCcRY1Ai3o00HI89VfDV/yfZACdWcslZasq2aNkf3Vy31SboyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877687; c=relaxed/simple;
	bh=Hs/3V/EDUVH1ePdQNsyRIcof/5TxXo32RR7iRrPFtQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4lFpB9V0YebcX2bOP3cXpYSZGfZcSjN1dVE2qJ22kS/kci3RgTwKA/NuBIebJP1r1e9wTRcbp97yR37aRf5391VJ8FWUsreJrLT83AO7JSnqZgVGCOJc+g8Rx6Q3l8PTgFq4NCCYYbzvdA27CSEHFud5jdJHQyWGGzqF1AR1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C574CC116B1;
	Mon,  1 Jul 2024 23:48:05 +0000 (UTC)
Date: Mon, 1 Jul 2024 19:49:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <muchun.song@linux.dev>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
Message-ID: <20240701194906.3a9b6765@gandalf.local.home>
In-Reply-To: <20240612011156.2891254-3-lihongbo22@huawei.com>
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
	<20240612011156.2891254-3-lihongbo22@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 09:11:56 +0800
Hongbo Li <lihongbo22@huawei.com> wrote:

> @@ -934,6 +943,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
>  	if (error)
>  		return error;
>  
> +	trace_hugetlbfs_setattr(inode, dentry->d_name.len, dentry->d_name.name,
> +			attr->ia_valid, attr->ia_mode,
> +			from_kuid(&init_user_ns, attr->ia_uid),
> +			from_kgid(&init_user_ns, attr->ia_gid),
> +			inode->i_size, attr->ia_size);
> +

That's a lot of parameters to pass to a tracepoint. Why not just pass the
dentry and attr and do the above in the TP_fast_assign() logic? That would
put less pressure on the icache for the code part.

-- Steve

