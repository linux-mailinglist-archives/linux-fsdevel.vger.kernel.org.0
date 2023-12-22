Return-Path: <linux-fsdevel+bounces-6767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1081C48E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 06:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80992815CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360553AA;
	Fri, 22 Dec 2023 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po4UZGLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB565390
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B31C433C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703221736;
	bh=pNYYHequpwfnQkwVLEdS6Gz0hNdzCadbj12fI0KMkL8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=po4UZGLX2YZMLj/LN1y6VZkFxH0Wt75HxZV9gfXPRkEvoPD0T2/ItGJrzYsc3IhuO
	 1c/bipOTgYH/rFaSnaQM30CMAdxSeYOcKj/mW457hX9/kwUXP9GJpYq6voWVcYz6UX
	 HVWRNkaF178ArfZrNgFgvVNlF/RTJZ8V0w7Ag0Fzws/GIQDrnBaFiwXUbkZCEZEvqp
	 rXM/6mU8CoZwoRQdzTWTB7ucwBryTGyG79RmHtqr/rkJLOQbo5l7AQCQ02MY249cX+
	 rnb6LFDjPC4u5AQcSTARwQHIuMETi4Jev2rHxwtfEHEmN+XpgCdp9niFHsU1urERxF
	 PKxSIU9/HAYPg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59426ca689cso646353eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 21:08:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yx8WYz7WpEUAO0/VtrxH0S2MN9ewEhu2wTHKerKfmSjWmrrPKQS
	oSCsZM1R3YM4k0l3dxmD8F9j5jyFNcK/nzdUO8o=
X-Google-Smtp-Source: AGHT+IGG/BaYDAOXDrDVQDp0qKx8IR0v/QpoBP7oxXokBt6SOr09hQYt+EW8Q7fvC971prrpFZonnJO/vvn5+SYMDPc=
X-Received: by 2002:a05:6820:230d:b0:58d:9b89:a844 with SMTP id
 cn13-20020a056820230d00b0058d9b89a844mr504885oob.7.1703221735815; Thu, 21 Dec
 2023 21:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5990:0:b0:507:5de0:116e with HTTP; Thu, 21 Dec 2023
 21:08:54 -0800 (PST)
In-Reply-To: <tencent_C819A7DB899F09F0693C9C36BA8CA422FA0A@qq.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com> <tencent_C819A7DB899F09F0693C9C36BA8CA422FA0A@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 22 Dec 2023 14:08:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9QEbr9AnKb+2Mf8iUkZsWyFZcekfYCKqDq2CiJ93EbmQ@mail.gmail.com>
Message-ID: <CAKYAXd9QEbr9AnKb+2Mf8iUkZsWyFZcekfYCKqDq2CiJ93EbmQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] exfat: do not sync parent dir if just update timestamp
To: yuezhang.mo@foxmail.com
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	wataru.aoyama@sony.com, Yuezhang Mo <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

2023-12-08 20:23 GMT+09:00, yuezhang.mo@foxmail.com <yuezhang.mo@foxmail.com>:
> From: Yuezhang Mo <Yuezhang.Mo@sony.com>
>
> When sync or dir_sync is enabled, there is no need to sync the
> parent directory's inode if only for updating its timestamp.
>
> 1. If an unexpected power failure occurs, the timestamp of the
>    parent directory is not updated to the storage, which has no
>    impact on the user.
Well, Why do you think timestamp sync of parent dir is not important ?
>
> 2. The number of writes will be greatly reduced, which can not
>    only improve performance, but also prolong device life.
How much does this have on your measurement results?

