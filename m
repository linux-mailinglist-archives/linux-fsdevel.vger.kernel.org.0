Return-Path: <linux-fsdevel+bounces-28719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B196D78F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E08228379C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572B199FD2;
	Thu,  5 Sep 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpe8ufD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D0199E8F;
	Thu,  5 Sep 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537058; cv=none; b=SHzHJ8IvIcsxxzxxirDEPItWN30bh0cZtEbxh6L5y9CkinPlpaNgV3K5DkBc2m5cqEQ3Xhm32DZA/aC4qlfIREhn64eI/24YFxupCN0MjN5d3XihkWp0P2+Ng63g0ZraG/SKO+c+b6G79KLFJyJ2TaA0jlrFST9OV7k42OwMfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537058; c=relaxed/simple;
	bh=wIvm975lkI6zYizk3o+d70RN/0ouhHAZ7kxJBQSU1lY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=siifgTSpz5h5SfJCZXL1uYhMjy9R5Wqy1TkZpGfyPLXjdkDi4BvL5DkkrGk7KCAnLVRdtWIHArRiemFQiqZHCfcEsSWGMnTrMENsb5r0lIVo/Op37BRbTt4pSdk7ZnvNix4PWZytf1P+lQgism3qbGXKJzBU263YKtoY59YKqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpe8ufD2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277c861d9f6so410244fac.2;
        Thu, 05 Sep 2024 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725537055; x=1726141855; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eKXDBKqXxnvuGBRmPekTjD0zETdvpmLvKTHKmbd7YjI=;
        b=fpe8ufD2JgaN5pO3Up5g9qH2MPRKOvcuCIricsmC/FFxOI7ZYyYkAIHtNSe+BEMpJN
         SSm8/FO901teGvgJCWApfHUaxbQcA9fVNwi36lMJX69xrh/qcyNm5hkDQ9YbgvB7bg5q
         VdlOSoumasuCbNn/xjtoxONFKE/lcWaDPVnlb5IQn3/Ht4dLi+iduPxqS0OKO4JtknvW
         q6mq39jTkVv9BHnXPgmYi8n7f/8OrGj6cbnEdQcV631zeZ9On2p9HlEKS34dpmhWhN4P
         RZBwnbFPravlF8HXm7YgOPF8PdqfjR3GbdkUpplwnTjalON/UVoBXBIQTUSReRITnfwp
         sEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725537055; x=1726141855;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKXDBKqXxnvuGBRmPekTjD0zETdvpmLvKTHKmbd7YjI=;
        b=F15UuTUE3FVHJxos4COU9I2cH8wccxx5VVQB5WfpXKp1YyZkXF4yt9I9lPc6dYUOrl
         YAOJ5CWUrc3ImtZZJ8mNb99aZ4WTwUEY0mM4HbPXg7PZMBU/LQwQCXsKc2TgyULDRtwo
         6IQjyN57D2U3+pbSTCpapNa5lenEHi+X9LndvxS8sJlEAiCFaxw0XOAl1YBGUMRS935Q
         Uh+htJvtjH24DTXRHX7YqSPfo065eqLko4qJvdqwQNqc6Rf4JBi3U4szGelQBFILtDKC
         cfeUOoRlSHn2pBgjQ1n29JRrchVcoK3PHkiKEPYv48uwY8c+cOiBy0nzagsxHqPkpDvl
         afIw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Mv1FU76z7bPc2Y6iHhl4FMnVhm6kZJexcqd9g3wJyVLx+CDEmRYzFl+Jg4FeyQgbT3FnBllgsQ4TOIkS@vger.kernel.org, AJvYcCUEIc4hZJAEL/qPil+kDacDZfdDWN2emci4Ee9Y0nY0XTBbQ6Ns6mVX74xZydgYtdINF3iZHta9uHB6etPQsQ==@vger.kernel.org, AJvYcCVCtmq/DuMi4VAUpgFOujHlFyK8pb26BZkd04O/Psllmy60FsUnmYaIgRvvrRMxWMeLOUiuPoWm14jC@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbvfmbEc0Mqekl7jxQD5lkhsDhs/OOsuvlaIGBLVwWnN6d7Vr
	aw5PIKXs2q96qc294AjHVyE3xj1DVeKRW3uHFgJnM7E6R8dmDTnmtJs9Fg==
X-Google-Smtp-Source: AGHT+IE3rwnK+RWahTYcsoWgBhuqjpTJynlW6DtaXhynzZ55bSr2PmL51H2kLKhzMqy8HY+tgEU4PQ==
X-Received: by 2002:a05:6358:5927:b0:1ad:14ec:a002 with SMTP id e5c5f4694b2df-1b81180a790mr1068270355d.26.1725537055394;
        Thu, 05 Sep 2024 04:50:55 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd93559sm3202523a12.54.2024.09.05.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 04:50:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/9] ext4: Add direct-io atomic write support using fsawu
In-Reply-To: <c6e22d5e-b8d1-44df-9e00-0a6b076e1804@oracle.com>
Date: Thu, 05 Sep 2024 17:03:10 +0530
Message-ID: <8734me2v49.fsf@gmail.com>
References: <cover.1709356594.git.ritesh.list@gmail.com> <c6e22d5e-b8d1-44df-9e00-0a6b076e1804@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 02/03/2024 07:41, Ritesh Harjani (IBM) wrote:
>
> Hi Ritesh,
>
>> Hello all,
>> 
>> This RFC series adds support for atomic writes to ext4 direct-io using
>> filesystem atomic write unit. It's built on top of John's "block atomic
>> write v5" series which adds RWF_ATOMIC flag interface to pwritev2() and enables
>> atomic write support in underlying device driver and block layer.
>
> I am curious - do you have any plans to progress this work?
>

Yes John. I have resumed my work on the interfaces changes for
direct-io atomic write for ext4 (hence all the queries on the other
email). We do intend to get this going.

Meanwhile Ojaswin has been working on extsize feature for ext4 (similar
to XFS). It uses some of our previous mballoc order-0 allocation work,
to support aligned allocations.
The patch series is almost in it's final stages. He will be soon be
posting an initial RFC design of the same (hopefully by next week).

Thanks again for your help!

-ritesh

