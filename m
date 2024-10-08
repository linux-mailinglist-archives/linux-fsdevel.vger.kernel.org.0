Return-Path: <linux-fsdevel+bounces-31342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA8994E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2331F23B0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02F1DF266;
	Tue,  8 Oct 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AAKLZgdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947561DE4CD;
	Tue,  8 Oct 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393151; cv=none; b=ato5m8cc7tk1QFiYs8oACd3dj70pvyLLoIzvU7ggh8E+LYJIdLUvHM9Q9dVI9I2y0gi8dzFKj+lDbnqE5lwfsx/yPeVSZMoymYxQ8ZU8Bc2fcUYEJ4hMdotcENcmAmeqgIzP9iVMVG3GrAqhEUcQ4WEsKwm2au59e1aXrTxvMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393151; c=relaxed/simple;
	bh=XNJg90BcPtOh5bOTDEKFgeZnHPnV0Mgej+wWmD0tL+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0MfiIv2V8tTaOzBtJZ86XKI/qd/j3/bdtk87bzvTC9HdBFQLmePwZebiI7Ko7TEqCKAZlPi82zSKSHxfdir+FWsmn3IeJ0y2X9guphxTTz0pkimLNkhd2DvYHaehb+aVEN9X17rNLtO8RqPPkBvtGuFjC9Cg+WCtyD258tjsWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AAKLZgdF; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728393146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L2tMYa++LilgFGUn5qa+f4HeMfwMqFzOdCyNTGH96cU=;
	b=AAKLZgdF83PdF5jp4cbgn0tYkATeuuTSGnoZOj681gis+wRNNY9VHPp3TLoyfVnBvci23PieHXLwzgt0C/Rolztz3xS+saWLqpnidMFkzAXypfApfwbWDjZTfnBPZ2vFIF+ORX4fGmvKescmKJZylEORkX2kfU0hjh9Y0DY0jjI=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGfRSit_1728393144)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 21:12:25 +0800
Message-ID: <9774de2b-2bd6-443e-b502-2c1dd3ccf0a8@linux.alibaba.com>
Date: Tue, 8 Oct 2024 21:12:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
 <ZwUkJEtwIpUA4qMz@infradead.org>
 <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
 <ZwUr2HthVw9Hc1ke@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwUr2HthVw9Hc1ke@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/8 20:55, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 08:33:27PM +0800, Gao Xiang wrote:
>> how about
>> int get_tree_bdev_flags(struct fs_context *fc,
>> 		int (*fill_super)(struct super_block *,
>> 				  struct fs_context *), bool quiet)
>>
>> for now? it can be turned into `int flags` if other needs
>> are shown later (and I don't need to define an enum.)
> 
> I'd pass an unsigned int flags with a clearly spellt out (and
> extensible) flags namespae.

okay, got it.

Thanks,
Gao Xiang

