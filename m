Return-Path: <linux-fsdevel+bounces-27797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52A96423D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA71E1F2631E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147C18E358;
	Thu, 29 Aug 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dNxxJbUO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3C189F5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928696; cv=none; b=UFwi2CfLGu6O+UVl+sy+bUmtSUMJb1AgFgjeaANlD2DWzruZ4u8+nFI6VfpSt2AzSerhIgOh2PcCptZSIXKRbt4DmlQ1B98Z6u6YF1JcSDMV82vdmry7mhxGQUY5Zycoc0KiUa9c43XsPpvBZqt59RMTHFEKegKUNrIiM2U5JzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928696; c=relaxed/simple;
	bh=bSQG74glTIqLWI5zw9DlZqUwe9+EgnUSSZdzhQ41LWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG2uwoaIktTWFVBDuXEImIQsOg/ddf3mUsh01mCYOEYyCYuxbfBvVe6V7VN5yzzzTccgRkY2pHAmr0xr+YN4AK6WAtxVWWGx6KphfXco0qbeXRj2tQ2IvJ7UwbnyswtIgJMcesHjlUI+CyKFnEV9M7w7tf6GrlmSvRP328/meDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dNxxJbUO; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:3099:0:640:f09b:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 115EB61954;
	Thu, 29 Aug 2024 13:46:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6kTQQUOoCuQ0-WEtIHFUS;
	Thu, 29 Aug 2024 13:46:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1724928367; bh=bSQG74glTIqLWI5zw9DlZqUwe9+EgnUSSZdzhQ41LWE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=dNxxJbUOxkO7/U/l0QaBvlhzXlem/TOawkBOazhYzIqZSNLvniuEK8OUyfCe7lVPZ
	 lwmss7NdaPf78Ca2prfGjBl4xrsOasZzpjcNnIjhEwUqzIIEgxRsd7vT/3itZlDrrm
	 dwKvWGmu5pWmscZxuPh4aECUY3bkdq3X8cRm3iAM=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6dd2e2ac-00a5-4796-90d5-27c36604f5a8@yandex.ru>
Date: Thu, 29 Aug 2024 13:46:06 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: permission problems with fuse
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Dave Marchevsky <davemarchevsky@fb.com>, Miklos Szeredi
 <mszeredi@redhat.com>, Andy Lutomirski <luto@kernel.org>
References: <9fb28d29-d566-4d96-a491-8f0fbe2e853b@yandex.ru>
 <CAJfpegsbZScBZbN+iaydOD2SKPgfnfj4t=EJz8KyMBX5X3yJWQ@mail.gmail.com>
 <28f37d0d-6262-4620-af89-b70ab982f592@fastmail.fm>
 <CAJfpegtjZ_iE4bemsVJbxucsMitVZV25JAmno7x+z0YfKYQfdw@mail.gmail.com>
 <e8d2ec2b-8753-49e4-b51e-aa4fe0f7802a@yandex.ru>
 <CAJfpegupwAKhaJkorZzzQfPZkD+f_ffwSs+5pQpQeUvfCnd32w@mail.gmail.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CAJfpegupwAKhaJkorZzzQfPZkD+f_ffwSs+5pQpQeUvfCnd32w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


29.08.2024 13:21, Miklos Szeredi пишет:
> On Thu, 29 Aug 2024 at 12:16, stsp <stsp2@yandex.ru> wrote:
>>
>> 29.08.2024 13:07, Miklos Szeredi пишет:
>>
>> Just one note: "allow_other" doesn't require root, it just requires
>> ability create a new mount.
>>
>> The root is needed to edit /etc/fuse.conf and enable
>> "user_allow_other".
> No, it isn't:
>
> $ ./passthrough -oallow_other ~/mnt
> fusermount3: option allow_other only allowed if 'user_allow_other' is
> set in /etc/fuse.conf
> $ unshare -rUm
> # ./passthrough -oallow_other ~/mnt
You still need root to do this:
sudo sysctl kernel.apparmor_restrict_unprivileged_userns=0


