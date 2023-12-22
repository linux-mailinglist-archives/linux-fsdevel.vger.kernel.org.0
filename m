Return-Path: <linux-fsdevel+bounces-6765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1781C48B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 06:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB021C240A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 05:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4753AA;
	Fri, 22 Dec 2023 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcOtJ0io"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625A5390
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46D6C433CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703221647;
	bh=Jb4K8Psn4R3byIPJ8hfyWtQUF9eVRJh33m35KS8/d/I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=EcOtJ0iozyr4VMLZbU8EYXubGEWuuPj8wgfmZb6F5wwtXedRv610Dg7Il/BL99lVR
	 hXzwxyaYIZD4TtkQBt8oqR8Yre72bVaZOkva4/qCQYE0LnkCFlXRUqb2bmLbvjfcxl
	 78vKVBMNzPDbwHz5vfeP343bRBoo/jgQBZTkMMaHwVQZ+Dw6j7Y/E8kHCwrt7a/zzv
	 cQDCDCy3T0hQ+AOWPGhm1G3Cdjq1N5TdieegWY/1w0OKEx/KXFU4HSOxGN73LWv/g9
	 seIXIyn5biMoFXUP4XWs75KCsXulZbaRptq/Bz5ASXqD9CyN728Ua/8hz75oRgzeFd
	 WdvKB1ND84Gxw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbbef36fe0so464496a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 21:07:27 -0800 (PST)
X-Gm-Message-State: AOJu0YzZ2GhcHM5go1n6Q8r2DmBntqgLojA0RwAmP81RECNu9LXEUtCb
	OUgANNvKrngOVOJuJDNaksursBETAlwjEO1gci8=
X-Google-Smtp-Source: AGHT+IGeFNpitFgVB3bXvbXE0m+bYNFyhXtZY74ozDra6zCAcybQs1YCAe3HtpURhTGSLEAWK83mG2/y/SYsrusokYA=
X-Received: by 2002:a9d:6f18:0:b0:6db:bb32:b0b3 with SMTP id
 n24-20020a9d6f18000000b006dbbb32b0b3mr847098otq.29.1703221647274; Thu, 21 Dec
 2023 21:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5990:0:b0:507:5de0:116e with HTTP; Thu, 21 Dec 2023
 21:07:25 -0800 (PST)
In-Reply-To: <tencent_FB9B093068189C7EB944A7EEFB35A46F8B0A@qq.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com> <tencent_FB9B093068189C7EB944A7EEFB35A46F8B0A@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 22 Dec 2023 14:07:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_JF_RbuOeqW0Ek2qtyaKTJoF5ShCrQO9P-Zc+wZrfLXQ@mail.gmail.com>
Message-ID: <CAKYAXd_JF_RbuOeqW0Ek2qtyaKTJoF5ShCrQO9P-Zc+wZrfLXQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] exfat: remove __exfat_find_empty_entry()
To: yuezhang.mo@foxmail.com
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	wataru.aoyama@sony.com, Yuezhang Mo <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

2023-12-08 20:23 GMT+09:00, yuezhang.mo@foxmail.com <yuezhang.mo@foxmail.com>:
> From: Yuezhang Mo <Yuezhang.Mo@sony.com>
>
> This commit removes exfat_find_empty_entry() and renames
> __exfat_find_empty_entry() to exfat_find_empty_entry().
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
If you update 0003 patch, this patch is not needed. I don't understand
why you delete function again after adding it in previous patch.

