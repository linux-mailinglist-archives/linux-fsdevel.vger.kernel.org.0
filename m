Return-Path: <linux-fsdevel+bounces-29871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A6397EE63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C001F226A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1582198E6D;
	Mon, 23 Sep 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="APlDxWqm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Az776og0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107398F7D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106147; cv=none; b=qDefqruwepq6hEkhLfw9+7Droztj9mXagbl1ZliwoXrcEQj6I+OyxJgz2R8omg5VgrZlzdR71rqz6DZElc3B/shtVxl0K+A0echfv6/Bb9lvcCzI9cEMj5W4Xtri+tE4jVPIp9EzdbET/OvAKTops50NqI4DWIz1PqXedUEpTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106147; c=relaxed/simple;
	bh=jiaxN8v6Qalp5o4bqqg3abzazuoU9/7sYLZwTbmnuaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHb9HxV2BkHJ+dTL0t1KP9Ac46y0KBfdwXlbesdYD93m+NrhskwS7ZqzCNkStxQ7AuiHfuNwsLcKO5DJ2XxEXIlsVx8VpdyJUxoKVI63X1APnv9mL3O3zRSvbjyqaqgmrX1e+/O8n0VjLXJeNbmOR4zUlEkVlj+/ySO7R5iooJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=APlDxWqm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Az776og0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=APlDxWqmTBXAFe7838HFRj9wZn/EWIxAzqoUbY+dtTNtL3NrEjwwpb2IytDBm2MipAoeI4721ewChjGJvkv8WjGylOmIee53b4nhX5tx8UQ9K6cn9wjS6GPMLKbTRXzQjO0toZlPrf/3O2NzaRKA/gK0k4Zm4tGR98tQ9DYO523wUm0kKXOP4gPJLl7OBze7+WI4s3h5tLgaEj13ptNEyjgRx1B4reyGFqMUR9mkKM+bbfwlSo4eXFawqOgqiCm5n4eCewVJzQXmJXF9kd4KWuRlIrHG1CpKaVEqlW0MydwDSd1SwPMEPk4/TDa5MBii+Ypgtw1usXjclr26pGWH0A==; s=purelymail3; d=lkcamp.dev; v=1; bh=jiaxN8v6Qalp5o4bqqg3abzazuoU9/7sYLZwTbmnuaY=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Az776og0L+ls8jqQjYsVmQ9ClT/HCXcaXmtyN6Qjm5EOYbkcJ9XnxOHW3KxOIsyDP7eimWjHRwAzFU9pNtNI6NI16TmExBu7WIAHh2AAj41hIzInk2asE6CKSH+zvPMFuJ6w8ZqSZhxhSdVnDS9cbC3+T409mzTalb2rccfTScoQ5XkpqJL2Re+snnvhpGFxpByzCfLO+bgGgSE/Xnqih3UMyez2rdcdRc/2f1JUtlkZaKwq9aI35IBC4C79woiNz1nlIN4hLk/TInDzgAJ+Mzf6CE5mVsQXL6C0+u0MLn4xuqeWRn4jC39GYOi1SIk7SLlEy7QPLi1bWsvY9b7IAQ==; s=purelymail3; d=purelymail.com; v=1; bh=jiaxN8v6Qalp5o4bqqg3abzazuoU9/7sYLZwTbmnuaY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 48571:7130:null:purelymail
X-Pm-Original-To: linux-fsdevel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1210100400;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 23 Sep 2024 15:42:18 +0000 (UTC)
Message-ID: <53395c4b-8e7e-4871-aeed-cf56215a3c26@lkcamp.dev>
Date: Mon, 23 Sep 2024 12:42:14 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] unicode: kunit: refactor selftest to kunit tests
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
 dpereira@lkcamp.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Pedro Orlando <porlando@lkcamp.dev>
References: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
Content-Language: en-US
From: Pedro Orlando <porlando@lkcamp.dev>
In-Reply-To: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+CC linux-kselftest

-------

On 22/09/2024 17:16, Gabriela Bittencourt wrote:
> Hey all,
> 
> We are making these changes as part of a KUnit Hackathon at LKCamp [1].
> 
> This patch sets out to refactor fs/unicode/utf8-selftest.c to KUnit tests.
> 
> The first commit is the refactoring itself from self test into KUnit, while
> the second one applies the naming style conventions.
> 
> We appreciate any feedback and suggestions. :)
> 
> [1] https://lkcamp.dev/about/
> 
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> 
> Gabriela Bittencourt (2):
>    unicode: kunit: refactor selftest to kunit tests
>    unicode: kunit: change tests filename and path
> 
>   fs/unicode/Kconfig                            |   5 +-
>   fs/unicode/Makefile                           |   2 +-
>   fs/unicode/tests/.kunitconfig                 |   3 +
>   .../{utf8-selftest.c => tests/utf8_kunit.c}   | 152 ++++++++----------
>   4 files changed, 76 insertions(+), 86 deletions(-)
>   create mode 100644 fs/unicode/tests/.kunitconfig
>   rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (63%)
> 

