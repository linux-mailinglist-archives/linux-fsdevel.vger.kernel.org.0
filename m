Return-Path: <linux-fsdevel+bounces-31572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D99987F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02BA1F24314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26F21C9EBA;
	Thu, 10 Oct 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhLCWXoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DC1C9DF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567362; cv=none; b=M8RICYBcWcY7rISBER5hYZuvKeSBVTtf1zitek9gJ+xYaEblEUGqEjdsfwWniFeH3Y7NnToptfdsdV7/z4WM2L7tPXezd+PLkTD1VE0Lwcnt82FfSjrAnV/b09E/k8YdKjqPiW/CNwhwN2BZR+uXU7MJzmF+FJP19/DsS+uxFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567362; c=relaxed/simple;
	bh=cWoxMYwouaWii08puJZXUqyXaUlP+sbTkbJwaLhvTsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUpv9sjwaaqMiDx0BivZ1fc33pLb1CPsmS4OjbV2e5BkTsDYjXOt3Sq4sKiqEgDTwqevK2MQ5tmFDRJwiyGidKjwr6hz+Kb9ZYMhRU5utlFZVcFHzQmTgj4Gg2ZuXx+rAgeZHN+1VJTngnPJ7pMzcuBzQHoQ7OO+Ap99VBhIJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhLCWXoK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728567359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLWSdhm4cWTI/JECrdxeIVeuumDvtSKGj0GSu8fNSOg=;
	b=JhLCWXoKKuOjR7J1sDvNNqCrDgtmsP/iN8Pf6alIpHmNolTz/X2kzIonaBh6Q2sLTZDeln
	XDJ6OolUtyMcfk4udcDAlp+HOgcpAr5c204kSoZ9i+UZtMLu9mmNpeHySzsYjA6FS1RIzi
	mc5BmqK3o465WeKX/KmLxluOBS0k0P8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-PFTnS5JvPJaBuq8QEBPi4A-1; Thu,
 10 Oct 2024 09:35:54 -0400
X-MC-Unique: PFTnS5JvPJaBuq8QEBPi4A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9A5919560B6;
	Thu, 10 Oct 2024 13:35:51 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DABE19560A2;
	Thu, 10 Oct 2024 13:35:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Date: Thu, 10 Oct 2024 09:35:46 -0400
Message-ID: <5A1217C0-A778-4A9A-B9D8-5F0401DC1013@redhat.com>
In-Reply-To: <20241010121607.54ttcmdfmh7ywho7@quack3>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
 <20241010121607.54ttcmdfmh7ywho7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10 Oct 2024, at 8:16, Jan Kara wrote:

> On Thu 10-10-24 19:25:42, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> In order to better analyze the issue of file system uninstallation cau=
sed
>> by kernel module opening files, it is necessary to perform dentry recy=
cling
>
> I don't quite understand the use case you mention here. Can you explain=
 it
> a bit more (that being said I've needed dropping caches for a particula=
r sb
> myself a few times for debugging purposes so I generally agree it is a
> useful feature).
>
>> on a single file system. But now, apart from global dentry recycling, =
it is
>> not supported to do dentry recycling on a single file system separatel=
y.
>> This feature has usage scenarios in problem localization scenarios.At =
the
>> same time, it also provides users with a slightly fine-grained
>> pagecache/entry recycling mechanism.
>> This patch supports the recycling of pagecache/entry for individual fi=
le
>> systems.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>  fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mm.h |  2 ++
>>  kernel/sysctl.c    |  9 +++++++++
>>  3 files changed, 54 insertions(+)
>>
>> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
>> index d45ef541d848..99d412cf3e52 100644
>> --- a/fs/drop_caches.c
>> +++ b/fs/drop_caches.c
>> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_tab=
le *table, int write,
>>  	}
>>  	return 0;
>>  }
>> +
>> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int =
write,
>> +				  void *buffer, size_t *length, loff_t *ppos)
>> +{
>> +	unsigned int major, minor;
>> +	unsigned int ctl;
>> +	struct super_block *sb;
>> +	static int stfu;
>> +
>> +	if (!write)
>> +		return 0;
>> +
>> +	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) !=3D 3)
>> +		return -EINVAL;
>
> I think specifying bdev major & minor number is not a great interface t=
hese
> days. In particular for filesystems which are not bdev based such as NF=
S. I
> think specifying path to some file/dir in the filesystem is nicer and y=
ou
> can easily resolve that to sb here as well.

Slight disagreement here since NFS uses set_anon_super() and major:minor
will work fine with it.  I'd prefer it actually since it avoids this
interface having to do a pathwalk and make decisions about what's mounted=

where and in what namespace.

Ben


