Return-Path: <linux-fsdevel+bounces-3869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56327F96BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 01:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E9CB20A9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 00:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB836D;
	Mon, 27 Nov 2023 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLN+NiOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109B360
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 00:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9098C433C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 00:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701043897;
	bh=v6KYsFBOE/h21xrIiu2YqFkVW86DG2fulZc6cLhrlC0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=lLN+NiOfMIYWQkZRRXfrYhwlTurB9NuL0DpMyZ942c2OBo6OiBmzKrxLSzuIA9UT+
	 iBvgURpcWlnPzPhYp2qWLT8yknfcjaxsMjN9IVfzOb95EdMv1MGXYp2tcNL1ozM/33
	 vQJdh06d88r43byeitYfnFkCP+V3umXYDPN2qW4h5sRyLhWyBS0qT574sU1LsyIOzZ
	 /LfKrnPhp6aMiPJmAuKzvHjmmem/nVqFl5af4ohN8BUE9S+YsokhqBYl28JbO4FBzr
	 4dnJCy+b8K1aF5hp68QkcBig5Ip06QjR4ecocEjxGc7OSUPPbvwgzKlmDvzg9PyJdS
	 n0tzDyRwl0J0Q==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58d564b98c9so883042eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 16:11:37 -0800 (PST)
X-Gm-Message-State: AOJu0YxaJ9cz7dz8qwYSb2o/2uBMBlZPMdUCwidl+T5LTQeBV7p4PHbJ
	SUHmxfVFidLu9DD3Wj6c+Q+K3xNrC9wIy94vFk0=
X-Google-Smtp-Source: AGHT+IFn7ezSIqzidC5R33gGMfKclYN4i9L+tr6MX2D9VW2WEmVTMmASS9KOaQxm+ngwpEdAOvuF5u4XMIklqeDnNFg=
X-Received: by 2002:a05:6820:1ca0:b0:58a:67b1:47ca with SMTP id
 ct32-20020a0568201ca000b0058a67b147camr11825811oob.6.1701043897206; Sun, 26
 Nov 2023 16:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:407:0:b0:507:5de0:116e with HTTP; Sun, 26 Nov 2023
 16:11:36 -0800 (PST)
In-Reply-To: <PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 27 Nov 2023 09:11:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CFaxxHnQTKYv1dL9n=Ank+tg9mMiUBH6_LVM2xkDV+A@mail.gmail.com>
Message-ID: <CAKYAXd_CFaxxHnQTKYv1dL9n=Ank+tg9mMiUBH6_LVM2xkDV+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] exfat: change to get file size from DataLength
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"

[snip]
> +	map_bh(bh_result, sb, phys);
> +	if (buffer_delay(bh_result))
> +		clear_buffer_delay(bh_result);
> +
>  	if (create) {
> +		sector_t valid_blks;
> +
> +		valid_blks = EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
> +		if (iblock < valid_blks && iblock + max_blocks >= valid_blks) {
> +			max_blocks = valid_blks - iblock;
> +			goto done;
> +		}
I don't know why this check is needed. And Why do you call
exfat_map_new_buffer() about < valid blocks ?
> +
>  		err = exfat_map_new_buffer(ei, bh_result, pos);
>  		if (err) {
>  			exfat_fs_error(sb,

