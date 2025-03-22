Return-Path: <linux-fsdevel+bounces-44755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB0A6C77C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 04:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8353A5933
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 03:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF660148316;
	Sat, 22 Mar 2025 03:37:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284111552FA
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614621; cv=none; b=rCMOvuAZ+/d0q+fQJ5Hfib6eJyw4i+LxCATzZwfa12vqxFiPQfCh7zoEnoKw+yQ71b8tt6dl39xA8rcmMMhaaqPzFq7WIcANb2ODdsKWkf2qwU0urRJ3ON0rcArUP9METaaDn2QqNsMqT4v9cFFqJIIZMAcLDqsmhRb83vmbqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614621; c=relaxed/simple;
	bh=9WdwlONds9AwiYBhY7fdJ9jErqwt6qjAMS1lVKzFY44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UG1m/HeE8eM1AzBYaY13M5GVZb0huaQF2KxsfMSuzbeHdVPhUpXs2roLGx/AOQAKodaFiYlWpJvkmvdTfoVAi44DXRgEGRyI2nR6yk3i6sLc1wExnIFt8zXQRF6qhAhON3RPasZT1bYxr+YxbgE56pb8nOD08Ns68G5EKuoNAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMJu007704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C15532E010F; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] jbd2: add a missing data flush during file and fs synchronization
Date: Fri, 21 Mar 2025 23:36:18 -0400
Message-ID: <174261457016.1344301.7380792216760002334.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
References: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 06 Dec 2024 19:13:27 +0800, Zhang Yi wrote:
> When the filesystem performs file or filesystem synchronization (e.g.,
> ext4_sync_file()), it queries the journal to determine whether to flush
> the file device through jbd2_trans_will_send_data_barrier(). If the
> target transaction has not started committing, it assumes that the
> journal will submit the flush command, allowing the filesystem to bypass
> a redundant flush command. However, this assumption is not always valid.
> If the journal is not located on the filesystem device, the journal
> commit thread will not submit the flush command unless the variable
> ->t_need_data_flush is set to 1. Consequently, the flush may be missed,
> and data may be lost following a power failure or system crash, even if
> the synchronization appears to succeed.
> 
> [...]

Applied, thanks!

[1/1] jbd2: add a missing data flush during file and fs synchronization
      commit: aac45075f6d79a63ac8dff93b3e1d7053a6ba628

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

