Return-Path: <linux-fsdevel+bounces-64831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA41BF5261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D44404523
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8D2DF70E;
	Tue, 21 Oct 2025 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="lFtz75J1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6C241665;
	Tue, 21 Oct 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033924; cv=pass; b=VU0KhWikxh5dqSEs2HRJqguWEd8XfW/KG8Xyneeh0O+koX2XV1NmQjIrWCL9Ted0wYIRHz0dUXQY0z3SvLeq4emqZdCTqUdpQxKeUqL87NijNO99Ilp+VXuxKUsO30jwQJxcNZMX5TioTVqYgi/ojagQtXPKSxPu8NferLezFYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033924; c=relaxed/simple;
	bh=eOSED2/f5mmoSZxZ3IuoB9jkfgiffqUSTt5WWZxhLhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqEDxS20zMsYTX1P36FwLsJUMXLlSgoqiJlA4Qg+kRtUAybmRk/6PwFPd/4aC2fry3KFyaihIpAK/fExi5J/ToR3CKj5/FSQGA9A7/TVGNlg/tCeWY/qACvgpTXofVA1Fp0kyuXhmUJUv+mQv/V9WPZFfc5JklERfqDCubtEm8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=lFtz75J1; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-30.compute.hwclouds-dns.com [119.8.240.30])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59L84svM697318
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 16:05:01 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1761033902; cv=none;
	b=P70CPACDjwUr1gvmFw75AcCHVN2NUmTFjoxXZpVHTksq3ByPyxarJfGD8wcD7MNnLGTdo8at1DYaJ7iU+tUPtVHWneOfCNstIqi46UYRWGajMqy2p3FiuBoruJqVw8NHjJze4gDGX2GQ0mUXzKCaXFl12fQT2Q5OMKQujbEQlow=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1761033902; c=relaxed/relaxed;
	bh=CL+CpOn7M2P3opGiPZKnwgIOYSjBqdGfmEEP/5N0zDw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=IB3/pS/NPVtqBeTPBzWsrvsnAKvRjFMyR/WZcQW1NEVtuMTq5nNF/l8xLyV68rXatKkNo13IZbs+DcsQ7qH0B45FiT0dUY1Hrf04YHsXym/VlAIcP875pDpZ0DmIkja2URyPk0zYk4fM/hJZtcwAmtRV1TtaWXQc2Nv2B/GQvZY=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1761033901;
	bh=CL+CpOn7M2P3opGiPZKnwgIOYSjBqdGfmEEP/5N0zDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFtz75J1mdb/1yjIgwGdjiERh0AJ/S6Euck884doEZknNy8NO5Ug2FaPQxc0QHKDS
	 a5LS4/aNQP1eFXHEpbvbhj1b8iemisly6FvnaOiTuSVhnZvPUJsO+Sse8uqqzwfVb9
	 qjmKxTDNg4B2jsZL0uy3Dc9ZrCfVB2ajmyBQVeIs=
Date: Tue, 21 Oct 2025 16:04:49 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix refcount leak in exfat_find
Message-ID: <aPc-gzWVu6q9FmZ5@osx.local>
References: <aPZOpRfVPZCP8vPw@chcpu18>
 <PUZPR04MB63160790974C70C70C8A062481F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB63160790974C70C70C8A062481F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Env-From: sfual

On Tue, Oct 21, 2025 at 01:38:29AM +0000, Yuezhang.Mo@sony.com wrote:
> On Mon, Oct 20, 2025 23:00 Shuhao Fu <sfual@cse.ust.hk> wrote:
> 
> I think it would be better to move these checks after exfat_put_dentry_set().
> Because the following check will correct ->valid_size and ->size.
> 
>         if (!is_valid_cluster(sbi, info->start_clu) && info->size) {
>                 exfat_warn(sb, "start_clu is invalid cluster(0x%x)",
>                                 info->start_clu);
>                 info->size = 0;
>                 info->valid_size = 0;
>         }
> 

Do you mean that we should put these two checks after
`exfat_put_dentry_set`, like below?

@@ -645,18 +645,6 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 	info->valid_size = le64_to_cpu(ep2->dentry.stream.valid_size);
 	info->size = le64_to_cpu(ep2->dentry.stream.size);
 
-	if (info->valid_size < 0) {
-		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
-		return -EIO;
-	}
-
-	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
-		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
-		return -EIO;
-	}
-
 	info->start_clu = le32_to_cpu(ep2->dentry.stream.start_clu);
 	if (!is_valid_cluster(sbi, info->start_clu) && info->size) {
 		exfat_warn(sb, "start_clu is invalid cluster(0x%x)",
@@ -694,6 +682,16 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 			     0);
 	exfat_put_dentry_set(&es, false);
 
+	if (info->valid_size < 0) {
+		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
+		return -EIO;
+	}
+
+	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
+		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
+		return -EIO;
+	}
+
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
 			       "non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",

> > --
> > 2.39.5 (Apple Git-154)

