Return-Path: <linux-fsdevel+bounces-51705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE95ADA742
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 06:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CED516D590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABB194A60;
	Mon, 16 Jun 2025 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eDCBpcIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B572607
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750049497; cv=none; b=VOyGmtI7eMsp098wSEsifn5DScqUYBfw6Dv438MZ43LEaOS+VDasqXXr7Sp0WdAUxyvHu8SoNShHXyeyb2hKRd2+KR1XQXCWWOzWfo+6WaBjqtbdr8+VymddLidPUcvnRRceU04S4zirEYbuC10Wp9v9XrGtalGJL5RnzhPTFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750049497; c=relaxed/simple;
	bh=GwlWiaJG4Zzcf72WkTxa3Iogv1BmfYtzCg58LICAWRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9BvBCDo7ODVpVndl/If7XN7ANtwTW/BoXK/Q75H38yxeVzXUEtmiLGdirjm42lfgQjCkl20RwXDlEF9dVYnqzlCRs/b8yIHI34WvEuzCzhUdQ9hQPexKkn6dyqC4hX/2D8Grmu39q/bD/zTvTaQh5mUKMiD66f0sd6Tk6yywtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eDCBpcIM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c0723d6-952d-4475-a2be-59f2871fccf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750049489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7raY7tU+Mw0NuCNmxoo5mV1EbHqhVyGjh1Shf64sUPE=;
	b=eDCBpcIMNK7CPxncUeFKjo4jOJapL1HIOia8UVLB9AORtJAMkuY7pKngGvWJJ9ZOoalAQf
	kVSydUqr4bVd5mQDM5E1KMilKmoHl+MVkAmFrzrG2kc1VVzCmcnCnVN9ne+0teS779IXLU
	ZThNrkgC0+qfvdd6BI4ICnzd87lobIs=
Date: Sun, 15 Jun 2025 21:51:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf_iter] get rid of redundant 3rd argument of
 prepare_seq_file()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV> <20250615003321.GC3011112@ZenIV>
 <20250615003507.GD3011112@ZenIV> <20250615004719.GE3011112@ZenIV>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250615004719.GE3011112@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/14/25 5:47 PM, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> always equal to __get_seq_info(2nd argument)
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

LGTM. Thanks for simplifying the code.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/bpf_iter.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 380e9a7cac75..303ab1f42d3a 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -38,8 +38,7 @@ static DEFINE_MUTEX(link_mutex);
>   /* incremented on every opened seq_file */
>   static atomic64_t session_id;
>   
> -static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
> -			    const struct bpf_iter_seq_info *seq_info);
> +static int prepare_seq_file(struct file *file, struct bpf_iter_link *link);
>   
>   static void bpf_iter_inc_seq_num(struct seq_file *seq)
>   {
> @@ -257,7 +256,7 @@ static int iter_open(struct inode *inode, struct file *file)
>   {
>   	struct bpf_iter_link *link = inode->i_private;
>   
> -	return prepare_seq_file(file, link, __get_seq_info(link));
> +	return prepare_seq_file(file, link);
>   }
>   
>   static int iter_release(struct inode *inode, struct file *file)
> @@ -586,9 +585,9 @@ static void init_seq_meta(struct bpf_iter_priv_data *priv_data,
>   	priv_data->done_stop = false;
>   }
>   
> -static int prepare_seq_file(struct file *file, struct bpf_iter_link *link,
> -			    const struct bpf_iter_seq_info *seq_info)
> +static int prepare_seq_file(struct file *file, struct bpf_iter_link *link)
>   {
> +	const struct bpf_iter_seq_info *seq_info = __get_seq_info(link);
>   	struct bpf_iter_priv_data *priv_data;
>   	struct bpf_iter_target_info *tinfo;
>   	struct bpf_prog *prog;
> @@ -653,7 +652,7 @@ int bpf_iter_new_fd(struct bpf_link *link)
>   	}
>   
>   	iter_link = container_of(link, struct bpf_iter_link, link);
> -	err = prepare_seq_file(file, iter_link, __get_seq_info(iter_link));
> +	err = prepare_seq_file(file, iter_link);
>   	if (err)
>   		goto free_file;
>   


