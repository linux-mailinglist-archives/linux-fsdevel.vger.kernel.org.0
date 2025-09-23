Return-Path: <linux-fsdevel+bounces-62510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC8B95FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A60D2A5D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BF324B22;
	Tue, 23 Sep 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yGwEv5jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E079322C67
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633426; cv=none; b=DMR+3QR81kBw7LYkk7WdQZ4+ctdIcpRPFvHrm+MhB271VYXy3+0A3IbtyJgrbNlaKK4M4x88VJJNb39fAiFByV4z4kO1vvivLRwHA9ps7U4bPklv2/tUVQVRMWYs+YXmMS6cYcwQRbKkSnUyPKMUBdeYH3iXzPWWqcYBY3kUCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633426; c=relaxed/simple;
	bh=MjdyuQrqVvsTBegSnd3yU00JR+DMJq7p6mLUJWTlZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/8CpRyCFwCDQFLOqHAwofGhEeH58kjQI2eODO/QMZJtp1CerxdBQKKQszn7nuHC8tnum1VmFLJPqlOLiSmhI0hIYEDd+kIFkiE8R65KQ8bb1j4Wr6sY1OAdNjOj2W6k52JGCeElGuyr5lJS1VnUpjoUIooPz8AsIEpg8G2LA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yGwEv5jd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so4847721a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758633424; x=1759238224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZ8DWqCix+BtHtElOYwM96MkEfMXUBhKMzH5BSjHrU=;
        b=yGwEv5jdMt4Rgfi0m0bN3rxya9s2FAbia8xtqcTwhc19IK5r4PXmdK+C7UWreg1NfH
         4sk+1SJaFqWoZk8UMTPHgcndklOJpzScvLF5bjkG6gqoUSKB2k3ZVGlgvwgMKVkiX9tQ
         HMMHDCD3TrzFuqxXTV9HAJcgYYX2He2h5yQzLxkZURdzd28u2rXo3M/TKNd/GoKCTF5R
         SSJHzKnVcZ1kR/S8ehZjuwzeAqAlS4edQgRc1y0V8xkXIINs5b4r82gsRo8F8hz5liGg
         WFWMrwFtm4OO2twE/EkvNGL9ESDPBnyP6iVe3AlnhcR6cmuUPbA6c7z1EUU5XrhnwxMP
         WISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633424; x=1759238224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGZ8DWqCix+BtHtElOYwM96MkEfMXUBhKMzH5BSjHrU=;
        b=e/XpK31NpUuqH1AuCb5qR1lb7z4kyVy05tbEvNBatFmlI6tM8z/wZxVDRm4Twdcpkz
         h+1Y4DU+iJFNpJ6QVTw128Imvyjt0c2O6/A7D/B6j98QF+PGDY0UM/yED1OQBmW7zQZ+
         ppi6bG34hmE2KGwkKWDfQOjr6jRXkr0/gGNFaDwUE48oNpyqgPCUazzpPmhFOPR20uxz
         pzT/X3o3+hHbphQ2FYHbChLqwj9dt0/eOy3DcjCbVrMoYpL1aEhY1O4KAkJTWq82/vg7
         auIq8aB+fW4eyh0HZzq5akU50/v8utWnBzFXRvIsVxtlCwM+XUKqlBGUndD6emIYDCZM
         lVYw==
X-Forwarded-Encrypted: i=1; AJvYcCUDry+M8yUCtwnpmpMs9RNJK3Xf2Th1dGA8pkt2D6MWrqD0arU4FdshMrP453/TSRCJ65DMCBZvsLS3M8lM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7sw39unNHuB3CQqKjT1D9V69Kc5evf9RYHUGY5UFKvPLlM8/
	Am7qOahwbct8ZpH9CYsoQvn28Z4quGToFJ5b0Ud+L517yIejRYvLuUS5n9r42GOyn34=
X-Gm-Gg: ASbGnct1x++nz++4ACKZzt6OZCg+pW+Oaq5aG9T/8g7pNrlPlK3DTSaExm/Exk5+JoB
	kfcYCIxy1mQY7Ylh4QJdc1PhJG0qlXp9vuPHTVqd2PPWNx7GZvs76/k+lK9B/ZL5ajJwBCpGwRG
	Y7e9oGBhRk1kLzh5ubAr9K6yNLcaQuQRCvIns4HCtyb7elnPo52CI4C8jq4c2Z7sfitKlG+r00k
	xqJ1Y4viik3luQaIlM4WJ4XrEJ34kDMLiMmLnqkGxhvrQEW4irsualknUdMQLiLRC4z7E+oT7O3
	AkKmzAN/j80dsKXnrIeORPH5i6sLETv+Bwxgw3ChQtG8pfZGoXGwSfW0lFacE1J/TNdizkuBiMk
	r6Vd35XbJqNMlwW1cUDUmqrf+hg3osm93cFWu6zpZURPP/2rnntYJkhgAfuWH3xzfuVode0Puq9
	Cvs8x6rENL
X-Google-Smtp-Source: AGHT+IEK7PfWxNFc7fb1bUErPP+++ZIWocUE2B9M31SxyszIkGAjugG30aXgLbzSTbCpFRJZYYXACg==
X-Received: by 2002:a17:90b:17cc:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-332a95e0514mr2945365a91.27.1758633423462;
        Tue, 23 Sep 2025 06:17:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551705bd02sm12047994a12.41.2025.09.23.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:17:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v12t9-00000005h4t-0IOy;
	Tue, 23 Sep 2025 23:16:59 +1000
Date: Tue, 23 Sep 2025 23:16:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Message-ID: <aNKdy1vYsWoMvU3c@dread.disaster.area>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>

On Tue, Sep 23, 2025 at 12:47:06PM +0200, Mateusz Guzik wrote:
> First commit message quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> Given the late stage of the release cycle this patchset only aims to
> hide access, it does not provide any of the checks.
> 
> Consumers can be trivially converted. Suppose flags I_A and I_B are to
> be handled, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> [/quote]
> 
> Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.
> 
> Given this, I decided to not submit any per-fs patches. Instead, the
> conversion is done in 2 parts: coccinelle and whatever which was missed.
> 
> Generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

Much simpler and nicer than the earlier versions. Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

