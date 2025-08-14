Return-Path: <linux-fsdevel+bounces-57849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F9B25EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F677B30FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B32E7F30;
	Thu, 14 Aug 2025 08:25:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5925B2E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159901; cv=none; b=t1xAj+8JVuFYhhRr0eBlSGO3BSGzdTHYT3YB2sy/uxroHFKXx6uviieuQ8AYWbYyRrTnuW1Jyyk9vn2aHvmJ+DyKU8ZTps+ccQJcKaHTJqRL5q+h9gq+4RUy06AFYPDPlA9Ect88wCadkYll+5FkzaZEUslhzXQrrodhcZ/EMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159901; c=relaxed/simple;
	bh=hiwDlsGH0fHkmle1q4Tqg8lsoDoSA8Vo0JAIFxjlmRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWAACRYE3d37I3wXd6xp3iTPrDcufkwIBO+Rl+jaWzsqt0Y11bxNXjy9eZ4Q0iwHrI9cqCGS/UgitcVUOAGuJcCGNGhzOc6lvYyZYIwKY3VN7obKv1kL6P6qN5mgtEdvZ3r8Vud4ON4fc+Eb+AN2aRJI3MrnbKs6Y4+S7lxGA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.37])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f5dfb5ab;
	Thu, 14 Aug 2025 16:24:45 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: mszeredi@redhat.com
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	bschubert@ddn.com,
	fweimer@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] copy_file_range: limit size if in compat mode
Date: Thu, 14 Aug 2025 16:24:44 +0800
Message-ID: <20250814082444.198-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813151107.99856-1-mszeredi@redhat.com>
References: <20250813151107.99856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98a7ae765403a2kunmd4e658e4161292
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk1OVhhITUhLSRhKS0kZTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhMWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

On Wed, Aug 13, 2025 at 5:11 PM Miklos Szeredi wrote:
> @@ -1624,8 +1629,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	 * to splicing from input file, while file_start_write() is held on
>  	 * the output file on a different sb.
>  	 */
> -	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -			       min_t(size_t, len, MAX_RW_COUNT), 0);
> +	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out, len, 0);
>  done:
>  	if (ret > 0) {
>  		fsnotify_access(file_in);

There is no problem with submission, but I have a doubt in the call chain:
`do_splice_direct -> do_splice_direct_actor:`
static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
				      struct file *out, loff_t *opos,
				      size_t len, unsigned int flags,
				      splice_direct_actor *actor)
{
	struct splice_desc sd = {
		.len		= len,  //unsigned int len
		.total_len	= len, 
		...
	};
	
The len member in the struct splice_desc is of type unsigned int. 
The assignment here may cause truncation, but in reality, this len
won't be used. Can we directly delete it? 
Otherwise, it's very confusing here.

Thanks
Chunsheng Luo

