Return-Path: <linux-fsdevel+bounces-14038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC4876ED2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 03:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB3E1F21E2A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785F2D638;
	Sat,  9 Mar 2024 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMtotnxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35B2CAB;
	Sat,  9 Mar 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709951852; cv=none; b=Tv47O/yKwiuEtyK/1n/896/sHgW6O/XxmG5gBdBAI6HkGK9D2JLKrq1v7rk5SMcD3hGgxx85Inh8GBE0slflmy7gwW3TZwcgP0djsMIfAe5Dmlf9h9K0bT97k3G71E435TVmXC5eEtq2/6enP14MwZCiwLU5V54wj63NhKdlp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709951852; c=relaxed/simple;
	bh=+V5eYFbW9Pi34yqv4WG/8jsaw5ZIuEVqrbU/JjZq1UM=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=b25pb1y9hyHXwEmfLB5fI4bjdSqru8nBRPpb4dQUOHfgNoWan7xG9YunDO6TJGpqi12mKSHvzfiPHQwjeakYfG9jhs3ecCFkczh+wCE2Cx+QDYLWOIEjrYARFS/1umqmWfLjtpUPlRj1OkNcKSJz8bYBQg+7vidSXzKIJ5ihuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMtotnxW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2334817a12.0;
        Fri, 08 Mar 2024 18:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709951850; x=1710556650; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPqIY44RfomfvdSfs4exdvUnb+SWr+WBXQBqExXLvyw=;
        b=gMtotnxWP62Phz8+WkTq+HZyBKCSDqzDbgcOzZgiCl7qeew09EAJY7U5EbDrlcKq3u
         3X7pRw+quiwtF5aypyrwSjBHHdXylYFBQ4sbghXc5zFpcGE8gaTkcGg4V2pfJ65o+d3G
         mBiGerHW7oGTxMej8FFVvyV3CJr0WnyygdJyCRIxVhFVwGUHMcp4Ww12q9AQg9CvPOiF
         9uVr99IF1GXHMywp0EuX5aatSRhmSXHElkH+lUYsBQoPoVpmkotYUnMHoH5apLEU6ydE
         kIG1TLXCh342hP/UhlJERJlPhmXBbq1ZxvQDxnv2Z+c0J03LbE8fSepEVZi/dJ5PYWEN
         mPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709951850; x=1710556650;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPqIY44RfomfvdSfs4exdvUnb+SWr+WBXQBqExXLvyw=;
        b=gN9JQ1PxNZaRPlIRPnM4YYq0xoX4RW31pVR0g4AoSziXpnQsjRwRHBo2fRccmZxmLa
         TaMAvKexZXBmnkGJVCItc08w8R28pLqN+vE1EHhrgyF/LI+Gw1IHG8xxDF2fFfn+sbw9
         apWweR9GhOHRiXfD36o4c/kUBKSfB8lg4e8yiuhVDtZ/Vr1ZGGDpCkedUUEwvcNgGuan
         G0KTJ2OW8paI8LpdXdYDv0kAoFfM7NFYO19M4KlGOmdiaee+j67hvIf9r84FGHKSk6au
         pMz93XVd9lCADnbZXPfP4vaSqmyr0KhMK5VQxm+8VHs1NDKVlLfu3AYHmsU4hIQ1hA0t
         LNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcO4beqqmtHubDJBWPH+kizn8BXrPXqwFeUZwy7O8TfmX9SQl5HWGAX6L7IkoPJN1BmgW7hO5dY8vq/iqlpCZYtWIJnQFtlY306jbxJQwG7sOdwExqhRA4a2VSUnpUZkb8kZAgOJmW3CfJxIHWzz7SMvVH59iJVbFZZ5QXccK2Zmld6Ax0Ktw=
X-Gm-Message-State: AOJu0Yz9ejLmYYaKFPH89og/6zUDw+QEJ27pq/XIR9jb0l8Ub2HfU5Sb
	k8Nw3s7yTcAerXolHPUnlqQvqHaRVLiipc3PmyNqoFHd1kTqJmZ6
X-Google-Smtp-Source: AGHT+IHbZjFqte6ZkYyboZObXPWHpvViry8+kZzGaw7+ymEUBiEFIgOonRtxY9n8+VrkaZiYg0xORw==
X-Received: by 2002:a17:902:7403:b0:1dd:e34:d820 with SMTP id g3-20020a170902740300b001dd0e34d820mr718053pll.28.1709951849852;
        Fri, 08 Mar 2024 18:37:29 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001dd7c2ea323sm142391plg.114.2024.03.08.18.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 18:37:29 -0800 (PST)
Date: Sat, 09 Mar 2024 08:07:19 +0530
Message-Id: <87msr85dwg.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC] ext4: Add support for ext4_map_blocks_atomic()
In-Reply-To: <3a417188e5abe3048afac3d31ebbf11588b6d68d.1709927824.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> +int ext4_map_blocks_atomic(handle_t *handle, struct inode *inode,
> +			   struct ext4_map_blocks *map, int flags)
> +{
> +	unsigned int mapped_len = 0, m_len = map->m_len;
> +	ext4_lblk_t m_lblk = map->m_lblk;
> +	int ret;
> +
> +	WARN_ON(!(flags & EXT4_GET_BLOCKS_CREATE));
> +
> +	do {
> +		ret = ext4_map_blocks(handle, inode, map, flags);
> +		if (ret < 0)
> +			return ret;
> +		mapped_len += map->m_len;
> +		map->m_lblk += map->m_len;
> +		map->m_len = m_len - mapped_len;
> +	} while (mapped_len < m_len);
> +
> +	map->m_lblk = m_lblk;
> +	map->m_len = mapped_len;
> +	return mapped_len;

ouch! 
1. I need to make sure map.m_pblk is updated properly.
2. I need to make sure above call only happens with bigalloc.

Sorry about that. Generally not a good idea to send something that late
at night.
But I guess this can be fixed easily. so hopefully the algorithm should
still remain, more or less the same for ext4_map_blocks_atomic().

-ritesh

