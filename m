Return-Path: <linux-fsdevel+bounces-3911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B97F9B15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BC7280E73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926E61096F;
	Mon, 27 Nov 2023 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCApJVMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628B3E6;
	Sun, 26 Nov 2023 23:43:35 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b8603e0fbaso844250b6e.0;
        Sun, 26 Nov 2023 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701071014; x=1701675814; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEp1eL0mhAV0UufmpMlyF9Fycg/v4NqkyxmqGqPMx7c=;
        b=eCApJVMcDbW+X5t8nhNymBiKhcMnQZOd8u5/6v+pMkuehVvn+NU7hM1KWJv1Dhlk77
         F2m2X9rDmAFWU/is6PfuTyZEA9BC+i0eoF5Xe17qFwiwhlRyVWRXsU+THuL61s6OF32Q
         A9B6ioKCcqBEuVtnjev49F5sF3d+3c2bctD3Yym4c53q2wWuaTdS2VJol5BbyYmbGf2k
         JH4nTZMgrMB3l1eL2aTpg+M2qpXnPFGXhqGBpb4YVr6eduqfCbRkjUecTUc3J/07sJKN
         zauTXOA6fOHSlnrXbq5564qvQPEEN4NfgHdhpaWnAeWjd29IRnyVMx1X1f/MpSUBZ8Ry
         lj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701071014; x=1701675814;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEp1eL0mhAV0UufmpMlyF9Fycg/v4NqkyxmqGqPMx7c=;
        b=wAap5YVGvu8jPM1qO+8ilQlBNIovV1/+nJyvCx0y2G0ZIlZZYN4JbKAvjQLJHhZqPB
         wp6bKtMze7fqfNw05rZK8IjBH0t5JgUu2sJvu06yAZHDTsaQgAng5ItVjZOt3iukyt8S
         S9YSNfOxO7Q3PvkeOTUMkiBT3YiSTu5Q/6U0PUDYtylUH0nPRkgX9pX87gZPohtX6i56
         48rBi9kAsnj2tgTBi1Yi0g18XGt6ssPa88QcNMj4cqrJbjYKIpE/XQVXHFNgbJ+P0ekv
         SnRRbEgffjS4sysMN5WLmSO8YFrE2ICdA1aPFqwf8JGHoXmG+Has2uzHyKhs3VECZMzi
         1tjA==
X-Gm-Message-State: AOJu0Yxkw9yohnSGulzlo5MI8ngmRyb0/11q1N79nbS/YCFY6cPgbzip
	IfItpPspynLfXd/wvQ6OA+hiav2is4w=
X-Google-Smtp-Source: AGHT+IEp9mSIbzrB1sUCgzRsyBnGDaEa6e7LIl4NFZQT15VO0MRL7aA5v6WsH3Ev4Df73H+jMfK9Zw==
X-Received: by 2002:a05:6870:2182:b0:1f9:8f1b:86f7 with SMTP id l2-20020a056870218200b001f98f1b86f7mr13438791oae.42.1701071014141;
        Sun, 26 Nov 2023 23:43:34 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id j6-20020a056a00234600b006c7c6ae3755sm6616937pfj.80.2023.11.26.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 23:43:33 -0800 (PST)
Date: Mon, 27 Nov 2023 13:13:29 +0530
Message-Id: <87ttp7r68u.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/13] iomap: clean up the iomap_new_ioend calling convention
In-Reply-To: <20231126124720.1249310-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Switch to the same argument order as iomap_writepage_map and remove the
> ifs argument that can be trivially recalculated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Straight forward change. Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

