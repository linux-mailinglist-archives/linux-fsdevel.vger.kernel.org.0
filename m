Return-Path: <linux-fsdevel+bounces-67958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5670C4E9E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C35B3BD3B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD2341677;
	Tue, 11 Nov 2025 14:39:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1155340DAC;
	Tue, 11 Nov 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871988; cv=none; b=pAmvoHsJNI/UVvQI1hLMq3BkctOUZLRL0iN0f4DqviAGpFGow/PoVJd5nGgNNSbILXhEexpn1iIc+fahH4Gwri9w1wEoDw/6EHl0Tq4V67TvK8XK3kxbrAk87s3c0+KNTvO6m7VFZ3D+zFawJe4cacxz99IH5qBf3lweV3X3cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871988; c=relaxed/simple;
	bh=NXqSvb17NNCUFpvhD7cqdSlUrGCN4ubhKTPQFX6Fflo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul0+UXxP0Ym1bg5T5tW51WS8UpeGhpzrlzBkcTWtTKZrSl+moyLZuuAD9ROu8NtXJlhcOEv/aKSdlNqbArkG8rZ3HQETldxuHrObpVZgJEAS1+NrYFXnxaDaZ7g5FWLDY9ul0rWRUnN5dzKwn9sdhnbJVal2+dOnHcwXsYZEbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5ABEdHtu056322;
	Tue, 11 Nov 2025 23:39:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5ABEdGNN056319
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 11 Nov 2025 23:39:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
Date: Tue, 11 Nov 2025 23:39:14 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
To: George Anthony Vernon <contact@gvernon.com>, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
        linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-3-contact@gvernon.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20251104014738.131872-3-contact@gvernon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/11/04 10:47, George Anthony Vernon wrote:
> +	if (!is_valid_cnid(inode->i_ino,
> +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
> +		BUG();

Is it guaranteed that hfs_write_inode() and make_bad_inode() never run in parallel?
If no, this check is racy because make_bad_inode() makes S_ISDIR(inode->i_mode) == false.


