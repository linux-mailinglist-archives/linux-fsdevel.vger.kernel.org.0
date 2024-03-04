Return-Path: <linux-fsdevel+bounces-13440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCE86FF12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B48B21EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 10:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F030336;
	Mon,  4 Mar 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHE0NiyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE01756F;
	Mon,  4 Mar 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548286; cv=none; b=S92R//hnssHOyiN8JxfIFUQgI3SOg8GdcjNBhvk/7ZvmNkOEF+KV+feW4TI0YLg5C5JxxMJXVU5HWrYO3q/agienndHsB3Bp5DrfgClRNG5hW9oD9y2c+BtfJBLqGPdf1Dstf97qBfippg2ej3yvrESKt05pY4dmefCrGM8XF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548286; c=relaxed/simple;
	bh=lNPwMDdZ8aL1Wr12Rp0wfGSShllnVM3A4M0wxiP5tl0=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=FHeSqaQlIeCVQ+J/RIw7CcfzgMPs8xEkisg7nGCTAevpr+1ncfG1tqwOTiof15yvcwf/LlLJhN6++8KTS11hExWpp9tgLe5LNh2FlER05O2iFGOFCOSZ36DdbfsDaZ/2K8PCch7BM01IS7il9FryYs6Tesx6W22VQbZKPfGiXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHE0NiyM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc13fb0133so31189835ad.3;
        Mon, 04 Mar 2024 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709548282; x=1710153082; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=64zcOG6BSjkI7rSmLTRy2iBdJj50IWiO7CuBZCeR9EE=;
        b=CHE0NiyMweT8NCHmAeDcQOAZStFiXVcn++P9ClUcrfkM510IPFzGo1Hl3nCWQXeMT0
         cbJ8vePq8hCo9OKVzoDfhBNibycGDqqZb/r3RT082aOX1Zcx3JUNwBnWRveM1rMi/Lid
         cL+LjqOjyeW1YPB4OPXDV7BUj9BZN6UWIXwx214IWxYvFhKh+5ulvHHKWWgXH37rxizA
         Cw4v8p4lyxbG2jTWPlvTaNMP9KyECAV42KrrccuonQGyf9muLxAKdDZUwh1Oe9L2N5EZ
         Q+IdLW5GCAzm4rYGRxViLkktnXHvhQQ7IcJPUxDPaPHIs49qSmGk2wgXLx1sT8FakOQU
         2yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548282; x=1710153082;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64zcOG6BSjkI7rSmLTRy2iBdJj50IWiO7CuBZCeR9EE=;
        b=JZEI2kN38OQ8Eku0Lc77fw/7oEW84i/38JuDIAcKRN3JxRKkOK5ZF/yBsZh0TXWA2q
         F6QocCNOmNT1kBAVLcGKIlukMGMPlZ0zUa53oCdSCaBZR4Low2YghB6oj1edON7BRntL
         Cx8VPm03CkTxSIke5AptiW2JdeTksH8DX9WHwyScxy0gxgt2joGqpr7XJQdPiI3haI+a
         sTlJVM3X4VqfcCU2pMlE/4NLz3Ty1oc5mGE2BrgVb8xyPQQi4qrFdN9DhVgiNpMlxLbs
         AYENYzk+zoKfOMi1eey31lTyVk1/rp7BwZy+Mh/N/QI2HWgP2ReIPq7TPpjwxJY1px1n
         IeKA==
X-Forwarded-Encrypted: i=1; AJvYcCXtkVkkX6lrmi3o66CXMFicsjg1PRT1URjPC7blyLyxBvC54Mzp7H8tAZZLWxGkoRPk3L/AoMz15g5Jv9quT3ISCTd8XyfG/GJpBgXUCaOGE1LKRc/rXVfCbyTSZcr+PmDkRYLb3mDLBg==
X-Gm-Message-State: AOJu0YyFjr3LBIeDNneJkxzjpj+eOfC1qo/HAMW9fxH3VIP3tr5RmTtI
	qv9pgcRAIubM7+oPD8AwI+h6eG1kunJt4TozDSyuzhGksRjBFw8Xxh48twP2dLs=
X-Google-Smtp-Source: AGHT+IFePQs/iCup0WOHrdtkHWUadj5YrNqikiU4egQU8fkAHr2Gt4LqqbldfvaQlJ2u6vQgIvPa6A==
X-Received: by 2002:a17:903:32c8:b0:1dc:fadb:4b1a with SMTP id i8-20020a17090332c800b001dcfadb4b1amr5619103plr.54.1709548282035;
        Mon, 04 Mar 2024 02:31:22 -0800 (PST)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902f21200b001da34166cd2sm8176787plc.180.2024.03.04.02.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:31:21 -0800 (PST)
Date: Mon, 04 Mar 2024 16:01:16 +0530
Message-Id: <87bk7u47bf.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/8] iomap: Add atomic write support for direct-io
In-Reply-To: <7ca900f8-2d19-44dc-9241-6208b155d950@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!PqMMFBeUqdWwlm0AxVyI_Vr1HPajTQ6AG2_GwK_IrhBSa-Wnz4cc-1w0LEFyTXY9Q9gT0WwhxvXloSqnOHb6Btg$
>>>
>>> and now this one.
>>>
>>> Can the two of you please co-ordinate your efforts and based your
>>> filesysetm work off the same iomap infrastructure changes?
>> 
>> Sure Dave, make sense. But we are cc'ing each other in this effort
>> together so that we are aware of what is being worked upon.
>
> Just cc'ing is not enough. I was going to send my v2 for XFS/iomap 
> support today. I didn't announce that as I did not think that I had to. 

ok. Let me take care of this next time to avoid any overlapping change
hitting the mailing list to avoid double reviews/competing changes from
2 people. Hopefully I can find you on xfs IRC channel in case if I would
like to post anything in the related/overlapping area . My handle is riteshh. 

> Admittedly it will be effectively an RFC, as the forcealign feature (now 
> included) is not mature. But it's going to be a bit awkward to have 2x 
> overlapping series' sent to the list.
>
> FWIW, I think that it's better to send series based on top of other 
> series, rather than cherry-picking necessary parts of other series (when 
> posting)
>

Ok. Sure John. Make sense. Now that I understood what I am looking for
in from iomap side of the changes, I can provide my review comments to
your series, whenever you post them.

Thanks for your feedback.

-ritesh

