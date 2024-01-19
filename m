Return-Path: <linux-fsdevel+bounces-8286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987B8323C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 04:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5307286517
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 03:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053321FA6;
	Fri, 19 Jan 2024 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqMAVJL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A3184E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635149; cv=none; b=mL9EoanuqdT88uAhTjBRaXmi+f+Tb0gap8L+5B7qfUnVwHCFkdrbvO4n/MMCJEQHzc+kTW9nuU39lzfvo6yJcbPIvXXLuYIQzQ1OCAak2Gldkc/WD9KRrCfAkG5lO+KVAXcmj6fimapipXNNtodU5nqwU/A0wyZ46cIRAqCAUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635149; c=relaxed/simple;
	bh=BvKh3M6EVInsnKQ06RFn3GYgxIC+vXofvFdVf5K7/NM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+fE2P3p72sx5HKDesQ6X1D+E1nH0x6xmxaEvUQ2xn/Ex4NRM3VMrvJ7LCiZHed6wGAhHxSA+FL2cVzP0gAvJUZ8XxlF7aKDKiR3Fk/SrGvERKsh+wEoz8lLAfAxFVPvKOr8kPSz6uB/q5JmRIxzvBTRKJnnRidZdHGSQNcY7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqMAVJL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEAFC43394
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 03:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705635149;
	bh=BvKh3M6EVInsnKQ06RFn3GYgxIC+vXofvFdVf5K7/NM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=HqMAVJL5nFmIUp4zPFxPFrPZtVpXxXVyu8ixywc0eTIHbXmDyih96+z088xi85SkG
	 za7QSqJf6Xp3fkPyYpxVBJruOquITWLZAvRk1JD/HnU1/BP4fJV80bNTdzqwpumbZo
	 58GqSwYUwTX8s6Cawn3kpqCt4rJc6aVZr8pahj1+Q5uh4V1qrDly/F4hw36wEXbR5B
	 k3gJA3Oc2agHh0zsy7ROAzvf0oVgPoHSLkMO1gr7kME1S//dav3vf4FFwxArnTbqlw
	 CnUpVk9bQSv3J7V3munp1scNmJAYPshUQ15r3Z2rTkvBK3eUrJjkg/XjKXsBhtve9K
	 2jBT9exqBoZKA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2053f5e97b2so256787fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 19:32:28 -0800 (PST)
X-Gm-Message-State: AOJu0YzAOzyd2Rx0MK0xglTAY21iT5rgTPKqqhPRBWkAOdf92DQR3Mf5
	U12Tsqc32E9inauGClpvKjS/rm/jJ26h0BWjHX4SlEqklK/5LpWqsoIe5fAQj4reU5SySaeCNOM
	uI9G618T3o7HUO8+HzLxBHWpv3cg=
X-Google-Smtp-Source: AGHT+IFxNZphozSNRZ0FsssUqjMM83Gfo/AlC9fZWPYTjLWVoL0FMhUv8DF3e8ePBL4TTlqJuuVb/SAsph4th+Hwdg4=
X-Received: by 2002:a05:6870:468a:b0:210:9fe7:37ee with SMTP id
 a10-20020a056870468a00b002109fe737eemr2074541oap.3.1705635148293; Thu, 18 Jan
 2024 19:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8d:0:b0:513:8ad5:8346 with HTTP; Thu, 18 Jan 2024
 19:32:27 -0800 (PST)
In-Reply-To: <PUZPR04MB631609520C4F2CE212A9A5F781712@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB631609520C4F2CE212A9A5F781712@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Jan 2024 12:32:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9V4thGjzFPnU1brokGf_uAdi9WSd4K8hAmTN_dhnAUmw@mail.gmail.com>
Message-ID: <CAKYAXd9V4thGjzFPnU1brokGf_uAdi9WSd4K8hAmTN_dhnAUmw@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix zero the unwritten part for dio read
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"

2024-01-18 18:43 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> For dio read, bio will be leave in flight when a successful partial
> aio read have been setup, blockdev_direct_IO() will return
> -EIOCBQUEUED. In the case, iter->iov_offset will be not advanced,
> the oops reported by syzbot will occur if revert iter->iov_offset
> with iov_iter_revert(). The unwritten part had been zeroed by aio
> read, so there is no need to zero it in dio read.
>
> Reported-by: syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied, Thanks for your patch!

