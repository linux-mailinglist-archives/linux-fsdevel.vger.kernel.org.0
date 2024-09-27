Return-Path: <linux-fsdevel+bounces-30255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93C98878B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079401F224C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E11C0DE7;
	Fri, 27 Sep 2024 14:51:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9F176FD3;
	Fri, 27 Sep 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448717; cv=none; b=rvW/wZH0b/JMYVEvkclc6JHJWlnl0DZTy8K9inuyHn2FowwdpviE6Fa6Kta250VTPEax6qlIFsuS3DZ/MPD0WnYAzx07JgRfYxTgNMYUEuJLi6bTwUgTh7USRoDqQufncDxpeoqPQXCgKgXzacrftFdUpTyrhg1sfGavDscKL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448717; c=relaxed/simple;
	bh=0lNC2lHIVhikuBOVsjECArMslx5NKUJkFbp1ZJ1iQO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjhglnTuFQcX4vqDQ/okrkQvRgY2Uw+r/0rdHT3cBUVmVGhh63uDm2GGMarTA0rj/YXho881BctXv0eZdt+jfXHwZ5H8NKvLlwwCAHOyoXFUqois9N/BAsQVzRsBk5tcrbsTrKjcxfTENFM8OVSIpSuoA1KhxxsCQNZ3IJH7NTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Kairui Song <ryncsn@gmail.com>,Greg KH <gregkh@linuxfoundation.org>
Cc: stable@kernel.org,  clm@meta.com,  Matthew Wilcox <willy@infradead.org>,
  axboe@kernel.dk,  ct@flyingcircus.io,  david@fromorbit.com,
  dqminh@cloudflare.com,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-xfs@vger.kernel.org,  regressions@leemhuis.info,
  regressions@lists.linux.dev,  torvalds@linux-foundation.org
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
In-Reply-To: <CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
	(Kairui Song's message of "Thu, 26 Sep 2024 00:06:18 +0800")
Organization: Gentoo
References: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
	<87plotvuo1.fsf@gentoo.org>
	<CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
Date: Fri, 27 Sep 2024 15:51:50 +0100
Message-ID: <87y13dtaih.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Sep 25, 2024 at 1:16=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>>
>> Kairui, could you send them to the stable ML to be queued if Willy is
>> fine with it?
>>
>
> Hi Sam,

Hi Kairui,

>
> Thanks for adding me to the discussion.
>
> Yes I'd like to, just not sure if people are still testing and
> checking the commits.
>
> And I haven't sent seperate fix just for stable fix before, so can
> anyone teach me, should I send only two patches for a minimal change,
> or send a whole series (with some minor clean up patch as dependency)
> for minimal conflicts? Or the stable team can just pick these up?

Please see https://www.kernel.org/doc/html/v6.11/process/stable-kernel-rule=
s.html.

If Option 2 can't work (because of conflicts), please follow Option 3
(https://www.kernel.org/doc/html/v6.11/process/stable-kernel-rules.html#opt=
ion-3).

Just explain the background and link to this thread in a cover letter
and mention it's your first time. Greg didn't bite me when I fumbled my
way around it :)

(greg, please correct me if I'm talking rubbish)

thanks,
sam

