Return-Path: <linux-fsdevel+bounces-27968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB396551E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49E1282A9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C5071742;
	Fri, 30 Aug 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZOHFfZJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785D1D131C;
	Fri, 30 Aug 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983834; cv=none; b=pzK2OdgB3TpdCgxkpCdjvcV3t3sbSiHKcczX2GQoktFkwoH7VjEA4zdLK0uDIfDBcqvtMXbEZNhTW9+LTzeOHGoUD0KUJaEX9CeI490dtwuwkyHOwN+NwMVZzhZBhCadVdj394wlRL75UKN3Vazh47ZOn8ttK3pxAgOi795o4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983834; c=relaxed/simple;
	bh=G15KnXW8AjYXE6Rb/jrWfl5W+S5jOUrSI0bR7qHqY5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFz/LC7SLQPQ7Q7InZ6tK+mZ023fFu3QBE4ioQ4KlT5AKNN4MlCQr5uHEf7ZfHdKvX/Ovq//3hfQUxvIUmGd7o3dfkiww/ZGUuTb555K5uXKHommgYERiiZB41gibr8sgJ9g8BJKU57cBdBpQo/Ylnwz0+i7uk/MFw3exiQpSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZOHFfZJc; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724983822; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CUhaHXVQH1bsT+53nrrH4/g48t++P31ZwVXwMhP2Jks=;
	b=ZOHFfZJct9JBFfYLP+aTi99TD9wyWc1hCbnuc2PSEd6E2D1I/HP7hew32NwKB0grzkyGq1UpFT6FyrrSErPhoIfVvA/G4OTJtc6jVTKEiDo376sri3zT38zgrSB4OauIzSaiLkMPw43upIQ0oQ4dcOLoN8W9DYKG+z/yytlBBis=
Received: from 30.221.145.153(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDuezWF_1724983821)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 10:10:22 +0800
Message-ID: <09c09a93-d3c3-45c6-bc6a-780423e07b5c@linux.alibaba.com>
Date: Fri, 30 Aug 2024 10:10:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: make foffset alignment opt-in for optimum backend
 performance
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
 <ca86fc29-b0fe-4e23-94b3-76015a95b64f@fastmail.fm>
 <8fd07d19-b7eb-4ae6-becc-08e6e1502fc8@linux.alibaba.com>
 <CAJfpegsgCJEv=XxuHgo+Qn-3y8Rc_Bsmt2YKTHn4XaBqvgshew@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegsgCJEv=XxuHgo+Qn-3y8Rc_Bsmt2YKTHn4XaBqvgshew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/24 3:51 PM, Miklos Szeredi wrote:
> On Fri, 5 Jul 2024 at 14:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>> I'm okay with resuing max_pages as the alignment constraint.  They are
>> the same in our internal scenarios.  But I'm not sure if it is the case
>> in other scenarios.
> 
> max_pages < alignment makes little sense.
> 
> max_pages = n * alignment could make sense, i.e. allow writes that are
> whole multiples of the alignment.

Agreed.

> 
> I'm not against adding a separate alignment, but it could be just
> uint8_t to take up less space in init_out.   We could have done that
> with max_stack_depth too.   Oh well...

Make sense, as the new added fuse_init_out.opt_alignment is already
log2(byte alignment).  I think uint8_t is already adequate in this case.
(Actually I'm going to rename @opt_alignment field of fuse_init_out to
something like @log_opt_align to indicate it's actually a log2() value
as Berned previously suggested)

Besides, I'm not sure if it's worth adding a new init flag, i.e.
FUSE_OPT_ALIGNMENT, as the init flag bits are continually consumed.
Maybe we could stipulate that a zero log_opt_align indicates no
alignment constraint (the default behavior), while a non-zero
log_opt_align indicates an alignment constraint.  However IIUC the user
daemon may or may not zero the unused fields of fuse_init_out.  Thus if
a fuse server not supporting opt_alignment doesn't zero
fuse_init_out.unused, then the kernel side will enforce an alignment
constraint unexpectedly.


-- 
Thanks,
Jingbo

