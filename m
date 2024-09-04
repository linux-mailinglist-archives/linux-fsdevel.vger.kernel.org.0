Return-Path: <linux-fsdevel+bounces-28614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC696C650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3961C252D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEF1E1A34;
	Wed,  4 Sep 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BujEe65x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788A12BEBB;
	Wed,  4 Sep 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474296; cv=none; b=OrVe1Rk9jhTihMfUjBmNilnqTXEboX3S6uYbGt16kP5U/ECijuyrXvZKZ0x7GXPWuPk9LCIPFqpshK4XenFRzmDpgpxFJSWSx+DQnFVogallibc3hgHbIk19R7POC2kkUpJrjze63qPq4DKZjIRxuCKI+OdhOLvrKlYL6cZBoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474296; c=relaxed/simple;
	bh=oTygpKrcBoVJtqSNVkgv22Lqd069o3jfJeouisBqqWo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Pb3gJcgS700ibU2CJp6LCYdpurIhnx2VTpZwG/PZTm25ydzfeAbwoAWoKOyoyJG7KfsG2fXVFeXj7oYcMKSve2xD345aMscffpp6CqgBJypXkMjmJvYsNn9NcbjSQu0Qf2rhvpCm/EjkY1gnB/aQUApyhvrMycKSvqmUmxZ1gDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BujEe65x; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055136b612so43189925ad.0;
        Wed, 04 Sep 2024 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725474294; x=1726079094; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2IO0UamiFjwdYmyIGjlqy1tP39MG7vWaltTAyQyjoUA=;
        b=BujEe65xcFuQbBCzdrhXt0KnMG5k6zfL822JQdKWSrPTp7/88c7mJkTv1hQsElv2P9
         4nyRjuv+SC+hVGssKCC6NcJmMNOcWRUHhB2ea6P6CFT8QIpVpwtIX6lMlXrDnbaCfE5p
         i9P009+o5dCXfSgmPG5wSbdjGtoPH7QmzOs2Kep1s4m/R0F30enqHvBpfcXYzQLEWGVz
         hIuCe8OnCU5SGLLtpSTnxRxYxPBAi/tTQqZVcpLNQjC8QQz+uzgBiJaUaIerV3U9W7qV
         O3fDVBNTP3/amHK09M8ewfwaYaamQVkSW37Ox80nZoW/0Q5HhihgO+GGDoY3D4A7J3n4
         Amnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474294; x=1726079094;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IO0UamiFjwdYmyIGjlqy1tP39MG7vWaltTAyQyjoUA=;
        b=N8o/A012jBR526xytl5dgtwYD6uK07wEiX5DZmAEuMzuLwsoiOiZ2wkK9kiD1teIEx
         CTjcScE+TwY9NpjnZbGv8A32EZkEe7tzDj3/E2jCDWp7lBzKO+/6ylgsG/1TbNwS9GIG
         w1z04LqArk/zsPJSKV4KP+w2X6dC8Bmar5eMsuk54CCVw61BCV76W3y0d+IS2ID2j+tC
         QGmYo9buJ4ebxfHFfdjvuHAeFpes/dAE/cOge7jsUaXM/r4Dz+WdCed2chFe/zc3kyIR
         WHBIKmWlitdxtS6DkPDiYH7RtFlt8pwliKEWiZXqt13tvD8BXx6ftLX+8kmCNInY/zOz
         TCPA==
X-Forwarded-Encrypted: i=1; AJvYcCVywp59JcDU18Mu4ZoYN7P9t4ar5DkSuly8fTdSDGICB7U7/83pVxvPJz6sm+Vd7neaU0rSVsbi8vFK4Lu+@vger.kernel.org, AJvYcCWPZiGYkVxWY+YK5ORi+sRjUHqw8iKP1zQnaBsu6+ZTJIT4aAHfYoQlYz1ji/eP6nKo3MVpRHkAk50L@vger.kernel.org, AJvYcCWxFjBde3K9ZAZCpUFmPrtz2CCEIk1vEoD9iVSUhXLzncTD7UXpvH4MExtcx5Zg52Hwkj9dgKxu75aicQtT@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIN0Gcv49VzuxhBDDM7ETV9ivlQEQFSoe6n6rIWasUxRwaTf0
	VCaECINhzdbkS8jXs9zl92hSdbQAvKp6rHdpGkp4ouK+qxH4KLa8
X-Google-Smtp-Source: AGHT+IGbuwAK6u2tFoQixAjgshxr3k87zv2jDIi8q2w8lMUvaZTuDRG8JRaXxeFK0eqKSSAblDoBgw==
X-Received: by 2002:a17:902:db0d:b0:205:7835:38dc with SMTP id d9443c01a7336-20578353a3emr139131155ad.60.1725474293499;
        Wed, 04 Sep 2024 11:24:53 -0700 (PDT)
Received: from dw-tp ([171.76.86.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae78c41csm16720445ad.0.2024.09.04.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:24:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com, martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 00/14] forcealign for xfs
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
Date: Wed, 04 Sep 2024 23:44:29 +0530
Message-ID: <87frqf2smy.fsf@gmail.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> This series is being spun off the block atomic writes for xfs series at
> [0].
>
> That series got too big.
>
> The actual forcealign patches are roughly the same in this series.
>
> Why forcealign?
> In some scenarios to may be required to guarantee extent alignment and
> granularity.
>
> For example, for atomic writes, the maximum atomic write unit size would
> be limited at the extent alignment and granularity, guaranteeing that an
> atomic write would not span data present in multiple extents.
>
> forcealign may be useful as a performance tuning optimization in other
> scenarios.
>
> I decided not to support forcealign for RT devices here. Initially I
> thought that it would be quite simple of implement. However, I discovered
> through much testing and subsequent debug that this was not true, so I
> decided to defer support to later.
>
> Early development xfsprogs support is at:
> https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/
>

Hi John,

Thanks for your continued work on atomic write.
I went over the XFS patch series and this is my understanding + some queries. Could you please help with these.

1. As I understand XFS untorn atomic write support is built on top of FORCEALIGN feature (which this series is adding) which in turn uses extsize hint feature underneath.
   Now extsize hint mainly controls the alignment of both "physical start" & "logical start" offset and extent length, correct?
   This is done using args->alignment for start aand args->prod/mode variables for extent length. Correct?

   - If say we are not able to allocate an aligned physical start? Then since extsize is just a hint we go ahead with whatever best available extent is right?
   - also extsize looks to be only providing allocation side of hints. (not de-allocation). Correct?

2. If say there is an append write i.e. the allocation is needed to be done at EOF. Then we try for an exact bno (from eof block) and aligned extent length, right?
   i.e. xfs_bmap_btalloc_filestreams() -> xfs_bmap_btalloc_at_eof(ap, args);
   If it is not available then we try for nearby bno xfs_alloc_vextent_near_bno(args, target) and similar...

3. It is the FORCEALIGN feature which _mandates_ both allocation (by using extsize hint) and de-allocation to happen _only_ in extsize chunks.
   i.e. forcealign mandates -
   - the logical and physical start offset should be aligned as per args->alignment
   - extent length be aligned as per args->prod/mod.
     If above two cannot be satisfied then return -ENOSPC.

   - Does the unmapping of extents also only happens in extsize chunks (with forcealign)?
     If the start or end of the extent which needs unmapping is unaligned then we convert that extent to unwritten and skip, is it? (__xfs_bunmapi())
     This is a bit unclear to me. Maybe I need to look more deeper into the __xfs_bunmapi() while loop.

My knowledge about this is still limited so please ignore any silly questions.

-ritesh

