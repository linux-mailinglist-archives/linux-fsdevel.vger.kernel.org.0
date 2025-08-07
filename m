Return-Path: <linux-fsdevel+bounces-56962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B1B1D275
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C103AA0A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CA21C9EA;
	Thu,  7 Aug 2025 06:24:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313F1537A7
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547875; cv=none; b=HSVwfJGdUSZEcK2ajxL9heZtuFoNMbSFjdBW0FmqoVhiilO/w5Y+orqjcS2PugfiYrfZBsTaUxYau4KRuius2U1x6k0PucuqEMdSwKgA+BzeNsV+qIMsJVY3SxTYMmSbjGAwxzK4G9SWXjC8nDz8N9p59Odrq/enAMrPNwHdMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547875; c=relaxed/simple;
	bh=U0MYI67nuyvtu1+h2yN0YHGJT7aZgIR7cCtQpaxpPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irToq6Ko39+qxuhtpvSS/3uPbfvNmHTrRjvcRo/MRJn2Nnqya5Odcrpz++903m6ncTFrm2YfoIUYxb5si3E3nXEGho53FKDvUcqv08MZqqiC4hd8fnxuDiw5SYuP2MD/TSpf9EMuCioTshgqpEsxZFexTKYoL/NdLQ+cLq9tVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.36])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e971c126;
	Thu, 7 Aug 2025 14:24:26 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: mszeredi@redhat.com
Cc: bschubert@ddn.com,
	fweimer@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Date: Thu,  7 Aug 2025 14:24:25 +0800
Message-ID: <20250807062425.694-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805183017.4072973-1-mszeredi@redhat.com>
References: <20250805183017.4072973-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a988333c98e03a2kunm340965d2348ccf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEIfVh9LSkgdTklMGk5PSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhNWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

On Thu, Aug 07 2025, Chunsheng Luo wrote:

> On Tue, Aug 05 2025, Miklos Szeredi wrote:
>
> +	bytes_copied = fc->no_copy_file_range_64 ?
> +		outarg.size : outarg_64.bytes_copied;
> +
>  	truncate_inode_pages_range(inode_out->i_mapping,
>  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
> -				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
> +				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
>  
>  	file_update_time(file_out);
> -	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
> +	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);

The copy_file_range syscall returns bytes_copied, a value provided by the userspace filesystem that the kernel cannot control. If bytes_copied > len, how should the application handle this? Similarly, if pos_out + bytes_copied < pos_outdue to integer overflow, could this cause any issues? Since vfs_copy_file_range->generic_copy_file_checks already check that pos_out + len does not overflow, so just need check bytes_copied > len.

Thanks
Chunsheng Luo

