Return-Path: <linux-fsdevel+bounces-6766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962F81C48D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 06:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85272892CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 05:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF216FD9;
	Fri, 22 Dec 2023 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdPuWAto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B163B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C80C433C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 05:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703221670;
	bh=XQOOjChktiM6+JtPhm4nhnCtm8fFcd923WOStyPozEQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=JdPuWAto/MjETUGjvokVbVzVwQjdFnspdrOWLTux2AGDnKyVzURnr0/tvF1o5hNIi
	 XfmCAdxN71x+iLuxmmxnhVLmcp2EkID2NGmM4sWMT58Pci1i0q/SFmqPxzc+qhzvCH
	 Owef58O0G5l+paGeGXY7dLXaAW8UrU1jc4h9rFyy2seGL/QpFPqXZHfWujBO6PSS7S
	 hvZxyU1AFqEfcLoLWeRMg2CQh0aUgX7Rv0VZjA78KJelN0YJ++FCwT6FTFMioBTvsL
	 H5qwtz1gJHFWe99S+4guN20IGrz/F1gxGPBQa4POXNoEj7K088TTzAk2Maj8Z4kCvA
	 tOTufV+S8AVAg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-594015ee9e6so864212eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 21:07:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7JkMcF3KkPMfMx66TKVj0xnxbJQTuyHx3Nw+Hil/343f00iak
	R9FJsoMYxNbduYkl3JQ5QYG4+FdrAwoniHJgPuk=
X-Google-Smtp-Source: AGHT+IEmE4Yh/W6NEGml/DlD+EzXzW7YH07Yd9y4XK6F3h4PqQ6jspYWE1tyPwmGm6jwHXDXgBy6xM7f+sPHxT35Jcw=
X-Received: by 2002:a4a:ab42:0:b0:58e:21d6:1b40 with SMTP id
 j2-20020a4aab42000000b0058e21d61b40mr495877oon.4.1703221669640; Thu, 21 Dec
 2023 21:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5990:0:b0:507:5de0:116e with HTTP; Thu, 21 Dec 2023
 21:07:48 -0800 (PST)
In-Reply-To: <tencent_444D2AB5DF5F3AA5389300B986E7A99CCB06@qq.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com> <tencent_444D2AB5DF5F3AA5389300B986E7A99CCB06@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 22 Dec 2023 14:07:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9BTTByZBbe2xQbQpx8C0=9U3Lzog+V=JP7uup=7sDf9A@mail.gmail.com>
Message-ID: <CAKYAXd9BTTByZBbe2xQbQpx8C0=9U3Lzog+V=JP7uup=7sDf9A@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] exfat: covert exfat_remove_entries() to use
 dentry cache
To: yuezhang.mo@foxmail.com
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	wataru.aoyama@sony.com, Yuezhang Mo <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

2023-12-08 20:23 GMT+09:00, yuezhang.mo@foxmail.com <yuezhang.mo@foxmail.com>:
> From: Yuezhang Mo <Yuezhang.Mo@sony.com>
>
> Before this conversion, in exfat_remove_entries(), to mark the
> dentries in a dentry set as deleted, the sync times is equals
> the dentry numbers if 'dirsync' or 'sync' is enabled.
> That affects not only performance but also device life.
>
> After this conversion, only needs to be synchronized once if
> 'dirsync' or 'sync' is enabled.
s/covert/convert in patch subject ?

