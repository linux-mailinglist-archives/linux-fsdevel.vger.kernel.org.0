Return-Path: <linux-fsdevel+bounces-11942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A68594C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 06:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E333B20DEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97E4C80;
	Sun, 18 Feb 2024 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJSkD6Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6162F50
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235066; cv=none; b=jiAcfEjY6kYnmmVs3i6msEEcJBCnntg3HgZLIZei+O6sHP1S97aBqyzOGVQqAMf183ZlXzYSYSiJqOX9rrmAdLfd5bOvPPpQ6KG73cNDaZF1COh/ezaYvZfFaKnhL2MhkLKf5D7ZEkAWt/pJyIx44Pjf9KbcbtEc+8YeNJzn3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235066; c=relaxed/simple;
	bh=GVpq0tCBxAHE6XOWWI2PQO0aSuROWq/GbG+5INhPXfo=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azQop4pPcT69zFw0W0leOJnyS0DoI4xWILXwIcAq/vypBOm1LXCsd2pvT67bwmbSSBRHOay2ydeykcG7e6JvLI7EIUjgoD+aFf8YaWH2z4+Wq6AeZMPWah3fKXRAnFXdDryAMQppUDCxntCIilIxbpIbUI4g3lYZ8EIYzkXHDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJSkD6Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAF3C433F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 05:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708235065;
	bh=GVpq0tCBxAHE6XOWWI2PQO0aSuROWq/GbG+5INhPXfo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=dJSkD6SwjUJWXGr/DJQFX+SdQG+hgsIIVVBF4/Gnep5Z/P/qN4Yziw99iIj0xzEqg
	 3W3jmTyuJ2KfqcrgdLPcjdxQgTCpItx+5JCVwUQBM5PBdQUbWbfdRSWrAqLPGnq5yr
	 +qpzpVzNHeRmRqfWi/AwT2tabIXAXh/RRratxNoTuCux8uY8Tx/HkaIER3zkAsODcu
	 EaqCNPgOGaDXKfxDX21PgQzYvvBgwdrKWp7g3N3wCvvB+qu1MJIvUNjxSLpQCo3EW4
	 kl8RuIf+qGJMzOwDkCG55Y295e1/EMbqgss7TFaQo/+AhWkbem2P1B1GfQ8v0Bezyd
	 poZI2LhFcSdyw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c031a077d5so1621007b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 21:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd1wPdY+4oTrl+xU+v8iPQWPdSS00soewsohQt49Uo2MFMClchy8TxiEqj52Q3qItDddTZEvVHqCV/9x3OMf9gScewyaR6g3Jk02Z9uA==
X-Gm-Message-State: AOJu0YyneP6tnsVH1i4O6ILBAA88PuQPag+5c7sbkZjgDAhIS5ATv3jK
	kFqrH4BG48piHPGNpBpU1PwOct4Juni0cHIVs9UuJEWDCslBUKupPNAR2txWxNefkN4f0LZSFMT
	kdmZYwN+HCrvwbnlNzkvZpMG4PAY=
X-Google-Smtp-Source: AGHT+IERmGq1Pr3R1PclCxW08TFUh4Pb4lbe545qVpgcTTLpBsimshFx+L4DybTkwOOdIRJBEhMmybrViBHAuYGQfHE=
X-Received: by 2002:a05:6808:4487:b0:3c0:4719:45ad with SMTP id
 eq7-20020a056808448700b003c0471945admr13532908oib.40.1708235064739; Sat, 17
 Feb 2024 21:44:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7bd1:0:b0:51a:6e80:39f1 with HTTP; Sat, 17 Feb 2024
 21:44:23 -0800 (PST)
In-Reply-To: <PUZPR04MB63167444783A68A96C950E5981532@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB63167444783A68A96C950E5981532@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Feb 2024 14:44:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8yvGvstGxej2nOXeH8ByU-jZWnJG521LTUzk10GX1k5Q@mail.gmail.com>
Message-ID: <CAKYAXd8yvGvstGxej2nOXeH8ByU-jZWnJG521LTUzk10GX1k5Q@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix appending discontinuous clusters to empty file
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "erichong@qnap.com" <erichong@qnap.com>, 
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>, "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"

2024-02-17 15:38 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Eric Hong found that when using ftruncate to expand an empty file,
> exfat_ent_set() will fail if discontinuous clusters are allocated.
> The reason is that the empty file does not have a cluster chain,
> but exfat_ent_set() attempts to append the newly allocated cluster
> to the cluster chain. In addition, exfat_find_last_cluster() only
> supports finding the last cluster in a non-empty file.
>
> So this commit adds a check whether the file is empty. If the file
> is empty, exfat_find_last_cluster() and exfat_ent_set() are no longer
> called as they do not need to be called.
>
> Fixes: f55c096f62f1 ("exfat: do not zero the extended part")
> Reported-by: Eric Hong <erichong@qnap.com>
> Closes: https://github.com/namjaejeon/linux-exfat-oot/issues/66
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks for your patch.

