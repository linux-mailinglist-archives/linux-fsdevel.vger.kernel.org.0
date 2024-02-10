Return-Path: <linux-fsdevel+bounces-11033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D7850147
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 01:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B367C1C21BAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 00:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3181FB5;
	Sat, 10 Feb 2024 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0JLZkn5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E26364
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525972; cv=none; b=Ej3zhjYfVQMwcPoI+rPxjiDsToMJQs8Rqf8ygvPjhBY5q1Y29O/kbYStMU6wx+JPjK+me4bmxlDtDOCuXG8YAvpPOJlwl/5UwWqNbRejdhzC89Vf45mrlOVtLZe7GY/Dq46bv7FOnpRw8CeX9GkgVJG7T7GROWKkre0+ig7N7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525972; c=relaxed/simple;
	bh=c1m98uWJHsoVBsgAVtMUrA7Ex+4IBof/+TdUbyPKdEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewk1swX5jBRYjMyPZtMIGZ2FMROJ438gD9LVSRZQsyk8Ik+74+ihjUNz7fW8cCWLWTk0MI7DETDorjpxu4fK7RhvbOYckGOfGO1CFXO94oymIiuOBeeH1gLg76NK/1sMQlWZy0sn+Zwajrie/s/AUg5iahak1H6RaDwWaNucMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0JLZkn5M; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e08dd0c7eeso776843b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 16:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707525970; x=1708130770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kF95EmwupPw/fzcMgiHi7D1T8Cm5RLvxdbpHGZs30QQ=;
        b=0JLZkn5M5VzAlLXDHUE1D38vczUgZ+Ya+uBOkWgiT/rzdwXzTJo/jeBtrmu6oDxmXT
         NUeQJdE5iS0JpL7misaC2qSZj6tfl1yAJ41YlIijn9bvMXNOjq2SChC+G0Mo4iYQs07g
         mUBdgRLPmKGJP/i1uGH/39lEus59ZPopinP3xLNihTMqiTNvQVqDmf3eBiWp9a1Mxj9Z
         kgY5EE+uXzgpyb8v+kpe2PscCPB+OsSIZ6/wggoIwezaUc0VqFDfMtyTmADtFXa8qdZ9
         99T1lJXlAKUOFGj7LEuCG64dEbv+Up0H/alTIormUIwtFBnJWx2qxV2jNEhVR945WP1m
         upew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525970; x=1708130770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF95EmwupPw/fzcMgiHi7D1T8Cm5RLvxdbpHGZs30QQ=;
        b=PxxHuDC4ov0PiqZn27OSmuWC6rp5S2ZL3ROBMgiBTyg2EuH9R9LbH/CvB80NSbx3Y/
         oDpa2yGKC8w8SD0umdoVA7GxOOsPSyWURqBLzUYe2EnkQ0AnK3WViXawFQzaWQ20Eoa8
         OkfrKr55JWOVihOsPKb91yIHbl7dK+B1Jw57CY6rk657LQOV4G6sIn31hcQJF6xUznav
         mni5diJyTQQs+Ls915p4T0WxrjuG1m9ddUP/wja2nRSebW5A+bEsiFtQj5fdS3mZiJ6C
         qeS7KizCPVmSTWS89jG5hjAvY0JGbsSV7Zs9YX9yJnL0ylC+IoiAoGy+N3Ag+fjj0Gfn
         JHzg==
X-Gm-Message-State: AOJu0Yz2Twk4X8qm/xuzvlknVjoDqy6j++CHFASN39XfV3S5+YsLFbO0
	OrLgirHFSHshDtLONOCM4a5ZqSayGDtHFxucKW98pQSsKjwVOq6rXeG/2d0gtWw=
X-Google-Smtp-Source: AGHT+IGR32e6FiZSJeLMwjErq+5wSggpYLYqWeQRw3rXGEh4OM9E/+gmLbxQGY0ECxZ7RUB2aTOC3Q==
X-Received: by 2002:a05:6a21:1394:b0:19c:9f1b:1d8d with SMTP id oa20-20020a056a21139400b0019c9f1b1d8dmr761155pzb.12.1707525969682;
        Fri, 09 Feb 2024 16:46:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW73GxaqqiIc5gHy1xKaJWZSQGU7/DufxWN03Ho4lKGpPSAQELayJGU4CNDSqxZrHxGI7A6pysp34ILZ+5B3jnEMBCRkcf7rTGNqPeOwyh+BqlSHnPJkfD8jNITPa+Yz4A9bLRkaxuXb5r3lxIx2k+m359LDkhmEUWibItUCENM4Nv8qwQ+vqhG2JYiaZs=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006ddcf5d5b0bsm1140526pfb.153.2024.02.09.16.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:46:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rYbVN-004OSC-2b;
	Sat, 10 Feb 2024 11:46:05 +1100
Date: Sat, 10 Feb 2024 11:46:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] fs/writeback: remove unneeded check in
 writeback_single_inode
Message-ID: <ZcbHTYLSO7mU0e9G@dread.disaster.area>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-5-shikemeng@huaweicloud.com>

On Fri, Feb 09, 2024 at 01:20:21AM +0800, Kemeng Shi wrote:
> I_DIRTY_ALL consists of I_DIRTY_TIME and I_DIRTY, so I_DIRTY_TIME must
> be set when any bit of I_DIRTY_ALL is set but I_DIRTY is not set.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2619f74ced70..b61bf2075931 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1788,7 +1788,7 @@ static int writeback_single_inode(struct inode *inode,
>  		else if (!(inode->i_state & I_SYNC_QUEUED)) {
>  			if ((inode->i_state & I_DIRTY))
>  				redirty_tail_locked(inode, wb);
> -			else if (inode->i_state & I_DIRTY_TIME) {
> +			else {
>  				inode->dirtied_when = jiffies;
>  				inode_io_list_move_locked(inode,
>  							  wb,

NAK.

The code is correct and the behaviour that is intended it obvious
from the code as it stands.

It is -incorrect- to move any inode that does not have I_DIRTY_TIME
to the wb->b_dirty_time list. By removing the I_DIRTY_TIME guard
from this code, you are leaving a nasty, undocumented logic trap in
the code that somebody is guaranteed to trip over into in the
future. That's making the code worse, not better....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

