Return-Path: <linux-fsdevel+bounces-12658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A5862421
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 11:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1E01F21273
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62311C680;
	Sat, 24 Feb 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+nOQoaK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A11B7F8;
	Sat, 24 Feb 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708769971; cv=none; b=oYtJiFNWftxQSAA68xZpsF6ahi2KxlpW4X80SsVK1NLC+eWviLWl0T8sMmYPOclpjt4uISX6hGU56VkPTTUOoLYRUwyoSjjXwo/AGwSrgRFvgi6t1jeOEwBRHO3NihBQOGIoRONG7BnhmMiWCk/y9QfW6KB+V/axIN5bvAuyX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708769971; c=relaxed/simple;
	bh=NgenpzYFzKC99G66bTl+4Fk9Z3+8lCFk+a0bIyBrcIU=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=s5FKdiSAqp9TTcnGODuGXDjszFYxsuzEL+vV8oMRdDSb1a4dsA1RED/bcdDEwGYoPdv2+mKs/79pScZeCnB0cHiPiEwSwnVPH4iK9ME2F6YzaV3//cy/lUkHe7tdLW9YB1do7VIjpBYM3Gtban0DQ91eYtmgd4sKDHjfhN0AUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+nOQoaK; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36521bd11a6so4078705ab.2;
        Sat, 24 Feb 2024 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708769968; x=1709374768; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u2IgToWRdAVI2ZYsCFwAaWzVoKw3B3n2xzbczdxurfY=;
        b=I+nOQoaKJBge182rHceaKk7PtfkP6mNuConAg0OVUrRE4RUSc4FBJXiX4YgJdbGNEM
         CrP2hM5j53c40DueEmaKFgQF5NOCghWBIza8yRqSB45L92odkzV7LwHTqmcn3i6y7GKa
         tUQPCngy2z+cKa9o2otZEblLVS8uRDUbp4+/b2H1kf4hpsJ9hDxslip08TeJoZIVJ7Wo
         VKqJg9K/I4VV7rzlZ21zOvAXZ3k16leRXtsWAC3wv6bHtShPhl9j2TuhnRpveioIN7zB
         fncYZAOw87/U8dCuxnsyjVsj95Oue90iQ8IrJYoeR/n9xbgvHzZEPlMLI0qR/kDGX1mb
         QQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708769968; x=1709374768;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2IgToWRdAVI2ZYsCFwAaWzVoKw3B3n2xzbczdxurfY=;
        b=FwS1kpvFacgcAUEBKgRna2jzDv9TU61rVlrcSHqgAGCHi16kFZLeDeDqwTDeywOjG5
         cXxXubXT11nx7KOgYfhGqnzCBn+OwVnwQyK3zcswmcmpXnt0/c9hFjoC0z1Y0QU3VyxO
         nvmxRIcqCZnqIvUGNSkIQwWq7Pf7NboM9ENTlOsOjOer/77Kul1X3E784z0mQGX4EKLM
         rKpHuh5igpzrRV4VUAsMycQXcjmmanWM3DNoYJ/epSFR1VcT1MWvKyt2320rvH/ZVNAx
         QT0El/cN1OpMthy2jVv2IfCZCayUGCqFOwuYHHRUXMElR1r+Cu07OTgL9eukxpanrgmk
         3G/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOqs/UV7VrtlE2BY6Mzlp3i8LIPDvO7L74WmNAf+3cPEscLOK5Zu9fw1rFv9BL8uhC9EjZht+FJdAWNSm7Bc2SfPwMp9CBMvnIUQ==
X-Gm-Message-State: AOJu0Yy3YeTBQTW9NAlsQIn2negLTPEgpCKZRrKsVJk0yuahXPNeMrJR
	Xf608PIiEQYLO6YLT1ORudrQOQY1bR7CDXKPofMfSq469RpCNwsaySbBxFwn
X-Google-Smtp-Source: AGHT+IE8Du323hUrvE+IULTRFvNjh/d9PXjAaWleeYDKEifjAQ6LpoQqs1Wqe5x9igYMApUXELPIsQ==
X-Received: by 2002:a92:d343:0:b0:365:80d:9aee with SMTP id a3-20020a92d343000000b00365080d9aeemr2404088ilh.31.1708769967793;
        Sat, 24 Feb 2024 02:19:27 -0800 (PST)
Received: from dw-tp ([171.76.80.106])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090274c900b001d9773a198esm740725plt.201.2024.02.24.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 02:19:27 -0800 (PST)
Date: Sat, 24 Feb 2024 15:49:23 +0530
Message-Id: <87y1ba17x0.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC]: Challenges and Ideas in Transitioning EXT* and other FS to iomap
In-Reply-To: <871q922v9u.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

++ linux-ext4

> In continuation from last year's efforts on conversion of ext* filesystems to iomap,
> I would like to propose an LSFMM session on the said topic. Last year's session
> was mainly centered around documentation discussion around iomap (so that it can help others
> converting their filesystems to iomap), and I think we now have a kernelnewbies page [1] 
> which can provide good details on how one can start transitioning their filesystem to iomap
> interface.
>
> Note, ext2/ext4 filesystems direct-io path now utilizes iomap where ext2
> DIO conversion happened last year during LSFMM [2] [3]. I have also submitted patches
> for ext2 buffered-io path for regular files to move to iomap and thereby enabling
> large folio support to it. Along similar lines there are also patches around EXT4
> buffered-io conversion to iomap.
>
> Some of the challenges
> =======================
> 1. For EXT2 directory handling which uses page cache and buffer heads, moving that path to 
>    iomap has challenges with writeback path since iomap also uses folio->private to keep some 
>    of its internal state (iomap_folio_state).
> 2. One other thing which was pointed out by Matthew is the BH_Boundary handling currently missing
>    in iomap. This can lead to non-optimized data I/O patterns causing performance penalty. 
> 3. Filesystems need a mechanism to validate cached logical->physical block translations 
>    in iomap writeback code (can this be lifted to common code?)
> 4. Another missing piece from iomap is the metadata handling for filesystems. There is no
>    interface which iomap provides that the FS can utilize to move away from buffer heads
>    for its metadata operations. It can be argued that it is not the responsibility of iomap, however
>    filesystems do need a mechanism for their metadata handling operations.
>
> Proposal
> =========
> In this talk I would like to discuss about the efforts, challenges & the lessons learnt in doing the conversion of
> ext2's DIO and buffered-io paths to iomap, which might help others in conversion of their filesystem.
> I would also like to have a discussion on the current open challenges we have in converting ext2 (buffered-io path) 
> and discuss on what ideas people have, which we can consider for transitioning ext* and other filesystems to iomap. 
>
> PS: As we speak, I am in the process of rebasing ext2 bufferred-io path to latest upstream kernel. 
> It's mostly done and I am also looking into some of the open problems listed by community. 
>
>
> References
> ============
> [1]: https://kernelnewbies.org/KernelProjects/iomap
> [2]: https://lore.kernel.org/linux-ext4/cover.1682069716.git.ritesh.list@gmail.com/
> [3]: https://lwn.net/Articles/935934/
> [4]: https://lore.kernel.org/linux-ext4/cover.1700505907.git.ritesh.list@gmail.com/

