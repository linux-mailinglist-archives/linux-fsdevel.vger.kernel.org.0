Return-Path: <linux-fsdevel+bounces-18811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE918BC7DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F6BB20E82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE264F20E;
	Mon,  6 May 2024 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="HVgPopCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D24EB23;
	Mon,  6 May 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978388; cv=none; b=mz+/GJGmW4N+FZ75Hwb+cYoAeqRr+AmIPBWxaeCNmXxb+r2d7ZU5GaUJEsGdSHfDx/Ge9R+6EfHGX0/AAcv6LD13y9p5KlmhvRWdxVBenfK8ztp+kSei578r3NQ0IVWK3MtXMwcfebhuosXjcuDiLG88FMKOrVGX27Maqnv0VKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978388; c=relaxed/simple;
	bh=Dy66GOaQxrCaDynaoClMZVGXzDzZMqaoN+1OXSlX9Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhuWh9CfMaiV/GAIYwI1QAo0FfATQf7HKkruloWUIKw7jMXdw8xJzQt0VypqqHFJmvALP+Go8pa/bRL+Y1I9dwIv+kawjQlBNnElG/WQ+M8N3IlEZijzQLRrZxTOvY2oXVUsM7LqT8QpbHSqOekl85QtgtWw3DP1ORV/EZai8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=HVgPopCz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id D128840769D5;
	Mon,  6 May 2024 06:52:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D128840769D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714978376;
	bh=EwcyDJdNTrTep2VJgQcoEYJczFdF5PJ0OxkRi2D2QSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVgPopCzwZafYnLSZgHdpcikZS1YufZHSp084ZfpvrRSz4N6jayBI6+FhTaWcSN+E
	 AGxhcMK1YH0vOee3JKJz/Csl+7M7TfPY/sgIz9v8rPyrUK9K7NCp67ksSwakGaPmP+
	 Or7pT76bA9Yg9g7jus8fRotbxXPHuXR46nskXj4w=
Date: Mon, 6 May 2024 09:52:50 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	lvc-project@linuxtesting.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, Zhiguo Jiang <justinjiang@vivo.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Subject: Re: [lvc-project] [PATCH] [RFC] dma-buf: fix race condition between
 poll and close
Message-ID: <20240506-6128db77520dbf887927bd4d-pchelkin@ispras.ru>
References: <20240423191310.19437-1-dmantipov@yandex.ru>
 <85b476cd-3afd-4781-9168-ecc88b6cc837@amd.com>
 <3a7d0f38-13b9-4e98-a5fa-9a0d775bcf81@yandex.ru>
 <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
 <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
 <a87d7ef8-2c59-4dc5-ba0a-b821d1effc72@amd.com>
 <5c8345ee-011a-4fa7-8326-84f40daf2f2c@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c8345ee-011a-4fa7-8326-84f40daf2f2c@yandex.ru>

On Fri, 03. May 14:08, Dmitry Antipov wrote:
> On 5/3/24 11:18 AM, Christian König wrote:
> 
> > Attached is a compile only tested patch, please verify if it fixes your problem.
> 
> LGTM, and this is similar to get_file() in __pollwait() and fput() in
> free_poll_entry() used in implementation of poll(). Please resubmit to
> linux-fsdevel@ including the following:
> 
> Reported-by: syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5d4cb6b4409edfd18646
> Tested-by: Dmitry Antipov <dmantipov@yandex.ru>

I guess the problem is addressed by commit 4efaa5acf0a1 ("epoll: be better
about file lifetimes") which was pushed upstream just before v6.9-rc7.

Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/

