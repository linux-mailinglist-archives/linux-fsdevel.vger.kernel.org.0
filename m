Return-Path: <linux-fsdevel+bounces-17841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B2D8B2CED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA15B288BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642515666F;
	Thu, 25 Apr 2024 22:16:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105C15666D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083359; cv=none; b=Sa3gSzqjciM6j68jvG49NEJQYUsNN8wAm602BPexxYNqt/V+z2xES6jGVgDF3xSTnNWYnXtQJ5+4XBKHNOBrgBkHY7v8iLqwuheI0hFPosh6F75BlH41LojI5koFaax5WrI3lvGDhgX81FLJyFDNBrQU7/Go7FRA4JqthAfuYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083359; c=relaxed/simple;
	bh=vc3ZIhnohH2VEthuI6IgTUifUs1vfLvxV3OgAkCTFJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SewNK0Zeflab5W+NfE9wm9t9NSadFNVwLT+vT0QX1NY6B8eqYED8ooXG5nUf6GFCN5hqQZu9HKBM4Li1nGjWaK9WszzOUCVyIjXPEaUfZvwS+7GlUB/yBGcAo5EayzZk9aFfL2AsnS+UtsBW12LSJ0J84G533DYIGyBXa/245sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski; spf=none smtp.mailfrom=osuchow.ski; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osuchow.ski
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4VQVYQ3kRKz9ttm;
	Fri, 26 Apr 2024 00:15:54 +0200 (CEST)
Message-ID: <022a152f-11c8-404c-8d7f-f7f788f17471@osuchow.ski>
Date: Fri, 26 Apr 2024 00:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] fs: Create anon_inode_getfile_fmode()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
References: <20240425215803.24267-1-linux@osuchow.ski>
 <20240425220329.GM2118490@ZenIV>
Content-Language: en-US
From: Dawid Osuchowski <linux@osuchow.ski>
In-Reply-To: <20240425220329.GM2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4VQVYQ3kRKz9ttm

On 4/26/24 00:03, Al Viro wrote:
> On Thu, Apr 25, 2024 at 11:58:03PM +0200, Dawid Osuchowski wrote:
>> +struct file *anon_inode_getfile_fmode(const char *name,
>> +				const struct file_operations *fops,
>> +				void *priv, int flags, fmode_t f_mode)
> 						       ^^^^^^^
>> +struct file *anon_inode_getfile_fmode(const char *name,
>> +				const struct file_operations *fops,
>> +				void *priv, int flags, unsigned int f_mode);
> 						       ^^^^^^^^^^^^
> 
> They ought to match (and fmode_t is the right type here).

Should I include the <linux/fs.h> header (or a different one) into 
anon_inodes.h to get the fmode_t type or can I copy the typedef directly 
as a sort of "forward declare" instead?

The latter would mean something like this:

	struct inode;
+	typedef unsigned int fmode_t;

-- Dawid

