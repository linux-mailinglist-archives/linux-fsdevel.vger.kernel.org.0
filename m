Return-Path: <linux-fsdevel+bounces-45924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF69A7F48C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9111697B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC025F7AB;
	Tue,  8 Apr 2025 06:05:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B11A3149;
	Tue,  8 Apr 2025 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092301; cv=none; b=Q04PkpaxlFc4dzvwdYIJBo/TMb46wrvfdSlS25QQ58b2//UBVBKCM/lvfziEgFB65mJdzLKGecw/zygALAQl4BdmD4Md2dXC0MC0EZvcaPmW2oL6zks6cTh2joZlwKqMVNeABEXdxD4iSN0C7YgEvBxqpYP9p1K5S82SMG+G8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092301; c=relaxed/simple;
	bh=IcEyZClMGD4C/NJt3DeJJ3OwwaNadWRTAclqaNX1ruQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/zY0xivfmTTFWJxiwFOYRm0/uUZext00hVISXMEYUR5JifRRHLZ86PM2cVoYqP4qKErNOC00Iwm4s4IL3jzIaOr9hFlnmjdvoFGXlykjMAcwGaU6tzPIByQu+95QE8F4PUcHpUzat3cblLwPDvw5VEL9hyO6iEleRwaBfC9IGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 53864Z7Y046352;
	Tue, 8 Apr 2025 15:04:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 53864YBH046349
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 8 Apr 2025 15:04:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <77b1b228-3799-43e3-ab30-5aec1d633816@I-love.SAKURA.ne.jp>
Date: Tue, 8 Apr 2025 15:04:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
To: Andreas Gruenbacher <agruenba@redhat.com>, cgroups@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Rafael Aquini <aquini@redhat.com>,
        gfs2@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407182104.716631-1-agruenba@redhat.com>
 <20250407182104.716631-2-agruenba@redhat.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250407182104.716631-2-agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/04/08 3:21, Andreas Gruenbacher wrote:
> @@ -1156,6 +1146,18 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NOSEC;
>  	sb->s_magic = GFS2_MAGIC;
>  	sb->s_op = &gfs2_super_ops;
> +
> +	/* Set up an address space for metadata writes */
> +	sdp->sd_inode = new_inode(sb);
> +	if (!sdp->sd_inode)
> +		goto fail_free;
> +	sdp->sd_inode->i_ino = GFS2_BAD_INO;
> +	sdp->sd_inode->i_size = OFFSET_MAX;
> +
> +	mapping = gfs2_aspace(sdp);
> +	mapping->a_ops = &gfs2_rgrp_aops;
> +	mapping_set_gfp_mask(mapping, GFP_NOFS);
> +
>  	sb->s_d_op = &gfs2_dops;
>  	sb->s_export_op = &gfs2_export_ops;
>  	sb->s_qcop = &gfs2_quotactl_ops;

This will be an inode leak when hitting e.g.

	error = init_names(sdp, silent);
	if (error)
		goto fail_free;

path, for what free_sbd() in

fail_free:
	free_sbd(sdp);
	sb->s_fs_info = NULL;
	return error;

path does is nothing but free_percpu() and kfree().


