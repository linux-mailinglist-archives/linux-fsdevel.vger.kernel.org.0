Return-Path: <linux-fsdevel+bounces-37772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E059F7238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDA77A11A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98B15B122;
	Thu, 19 Dec 2024 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sBTgTpaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380B78F37
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572839; cv=none; b=EPWCxxCDrE4FIxTBzFnD5LfyWc0/Ge0eePs18yxVyQrmovLWTFEynPf/4G6heIsMdbqYPkMLj9it43gmOT84EGDRomIcsm9+eFpNBpiJ0D+WAnyna+1NZqYF3jDDoZgu8hFrhnbjteCMQ87X8HJgr02ot1W9/D7DsG7vnEOiXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572839; c=relaxed/simple;
	bh=QoEtvf7G0kC0x/Wl3nJ0XIYl2HZa0Re3rk+nGV30jwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUHZ+ucgbl3Guuy/8kXVQVKWNaz0iVsumV6l21E8Kk0Sgss6dGVbxcGXRv2jsN0v/4AF9KxhR2jaW0KfMzw0FPtBOH2LxlxAsZqDBkw7zeejzA8fbX88Tf2Ov0OZo/KDeKaZ76eTJFBuXNIuajsyi6yn596xxnq279WfsjfMQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sBTgTpaZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21644aca3a0so3248255ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 17:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734572837; x=1735177637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFHEfXVHBOjseorucBg5TQ9yn5KG0rfffOIvw+zi84o=;
        b=sBTgTpaZ8mVD4iBQgBXOlDPLUcA5D4ujZK+4p/HUNST3Ta9ntAVCPRnVoYkIbRgbwj
         BxAi5U3Kfw7qQvfqcPkVo4P6RsG56qd9I9pFjG8p0wkGGZJZwXdXUDKpxUf9maop46i/
         AbPkuAuyhFSmGz6HZ0ZhQEjEcjzc08AiDx2hC30agh/yco9b77JUDOHTv0F8V5GWaPiF
         fc77ZlyF6VTKe2YM3h85tATwMlj0NU45kEZ06niLjkXDkxTtcl440PwxVSuPb+AQg8e9
         WbwbGBfbyy3wNrbd5CNivDXmZH3H/6RrwbTb9JyvPI51sXy3+lyOj2n8OQEFaN+ys4Xa
         UOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572837; x=1735177637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFHEfXVHBOjseorucBg5TQ9yn5KG0rfffOIvw+zi84o=;
        b=qC2H6TOEAcPGkwNF284eF9Fef/dysDxRHu0powWo7mxmBwfaFM2FI6VR7x55Bfo5gh
         tQmro+PsErnYMxapdUpZPoeCCEdnBiq1o6xnFwxvatthDRBgbgIEdbzByRxf0UDcmrkM
         vbsaYzPBOvfv7oM/5PX6umu1H8DIPoF/lGpT2fzuzMzANxspET2JDFgHLO5EIDyRdasD
         Y1tNpS0xfrckq7BE8TLMumEStTXXn4eF24Nd+V8IebCcf08exJXLvWa7l6X9nYJP89+X
         HZ2fwMAIE4BvIG1XCxs+3NOdwLnldQsZf8At/u2HqZGI6c5OBHgomAd2ZH+pOwt6bJS1
         P+Zw==
X-Gm-Message-State: AOJu0YyOeqMnWDtKWZtLo9dzQjlLya9+n0wIHB81RUlJM2Wsa3b5JNI4
	Ezx8NjA32i491aB+kUXreJCxZ7LbIXXdzjwXokHgQ7/lsshHOkNfOSCgfv7s+QhCayPCDcSxax1
	o
X-Gm-Gg: ASbGnctll2OQQtTbrCgvzs5A9voGlwaFsVBzDNDjSzWSW1NM49tpLFLgj+SiV9XYj4C
	upZJ3R0anJs2BY8pMnH1BfdGNgMNnEshaZXwSWLZPy00qOqxzT1eYwcSR1fYEDtsvymxh2AIUhP
	LFIUQ4D4j4g6IF705NA58vGNHxJXfFOaBYabxP8deCD62IRA1M/SYMknvap401JksrCXQ4oPpj9
	yMfrkIXyfwAufw9o1KBq1BBVI6FXnV0aVBbGnQeYIvU30T0188qaisPB/8K+BGkYYIv2rr/5aDj
	a+iuttaFcXpPZ39HruMjCW1zd4k9kw==
X-Google-Smtp-Source: AGHT+IHoM9BuzRwWE3UvBbujRjFPqKOpZTGf3EdvmaxlJ9Nm6SjjQJoIghbJbF3BGqAvlV3zRrZEww==
X-Received: by 2002:a17:902:fc4e:b0:20c:6399:d637 with SMTP id d9443c01a7336-219d96d213emr29814395ad.40.1734572837007;
        Wed, 18 Dec 2024 17:47:17 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962940sm1898825ad.34.2024.12.18.17.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:47:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tO5dB-0000000CUAL-2X1s;
	Thu, 19 Dec 2024 12:47:13 +1100
Date: Thu, 19 Dec 2024 12:47:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	willy@infradead.org, corbet@lwn.net, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, brauner@kernel.org,
	jack@suse.cz, cem@kernel.org, djwong@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	fdmanana@suse.com, johannes.thumshirn@wdc.com, kernel-team@meta.com
Subject: Re: [RFC v2] lsm: fs: Use inode_free_callback to free i_security in
 RCU callback
Message-ID: <Z2N7Ibxnmm-KEvea@dread.disaster.area>
References: <20241218211615.506095-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218211615.506095-1-song@kernel.org>

On Wed, Dec 18, 2024 at 01:16:15PM -0800, Song Liu wrote:
> inode->i_security needes to be freed from RCU callback. A rcu_head was
> added to i_security to call the RCU callback. However, since struct inode
> already has i_rcu, the extra rcu_head is wasteful. Specifically, when any
> LSM uses i_security, a rcu_head (two pointers) is allocated for each
> inode.
> 
> Rename i_callback to inode_free_callback and call security_inode_free_rcu
> from it to free i_security so that a rcu_head is saved for each inode.
> Special care are needed for file systems that provide a destroy_inode()
> callback, but not a free_inode() callback. Specifically, the following
> logic are added to handle such cases:
> 
>  - XFS recycles inode after destroy_inode. The inodes are freed from
>    recycle logic. Let xfs_inode_free_callback() call inode_free_callback.

NACK. That's a massive layering violation.

LSMs are VFS layer functionality. They *must* be removed from the
VFS inode before ->destroy_inode() is called. If a filesystem
supplies ->destroy_inode(), then it -owns- the inode exclusively
from that point onwards. All VFS and 3rd party stuff hanging off the
inode must be removed from the inode before ->destroy_inode() is
called.

Them's the rules, and hacking around LSM object allocation/freeing
to try to handle how filesystems manage inodes -underneath- the VFS
is just asking for problems. LSM object management needs to be
handled entirely by the generic LSM VFS hooks, not tightly coupled
to VFS and/or low level filesystem inode lifecycle management.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

