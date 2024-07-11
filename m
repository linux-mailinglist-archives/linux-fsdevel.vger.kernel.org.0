Return-Path: <linux-fsdevel+bounces-23555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32892E28B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44261C20A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2D15821D;
	Thu, 11 Jul 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="gAGyHnh1";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="KtBs9Wnt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00001581F0;
	Thu, 11 Jul 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686999; cv=none; b=Z0NvOAsBb1pPYcyYp65eoH52bMoTM0SRyU+6QndpUAkFoyBorkXtADE5Pnt9NIrB3iENuVPdfHGqQl5uFTQhzfbpdursGrF6DFJWl5pW3T+vdBtaGft4FYL9RBZI5XWcSl4bgBZ19WuNwXAhWj6L/nsCkRYNf8ZVCLEp7+lG+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686999; c=relaxed/simple;
	bh=1bwqFinbtDkxAjW+8WZSgeF63cbN78DWBNtyGL2nQlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lxIiIfX3E4lw6MuDnPVqQIwJqqZdN1HlsZxaE7+WQRyizQqiC6dY1w4mkW29Gp8Xyxd49n/o7j6rk2CBw+3u7e61hYxFpOEosHTnfVSGzZp/ce4exIBeOIp54V4pm2oLtkaNBslZvI2vFSrsQotOp6g9ygCj+NmFMWgmBwa69wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=gAGyHnh1; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=KtBs9Wnt; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 96F1F1D43;
	Thu, 11 Jul 2024 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1720685961;
	bh=2lEB1CwnPIAdMdowq8U5BKOPAzNq4douQboeJQ9Bho0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gAGyHnh1h1+4+vr9qI1qCl99UqNtF0br+qa85Zr50J/O7EBPbyG5jNgqK16M5ygXQ
	 R2dRxUbK1HiWAEF4Nwrb9ry21sfVmMWfjRRKMHWA4/NYx9Lug4fMgiCC96Vx9nO07/
	 AB97AY7Tt+z84+I3yQ+IW5h8Y+61MmO3osicS+UY=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0EB6621C8;
	Thu, 11 Jul 2024 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1720686452;
	bh=2lEB1CwnPIAdMdowq8U5BKOPAzNq4douQboeJQ9Bho0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KtBs9Wntn8bYdopHYHiA5ajMgyd/L1KY+9R+rk6AyT8pnNGYcl/lCzSW+/DgWkcj+
	 lmkEe+gQ+xfI+Zd24CxKqHbm0+Y4tqc40bm8OhOL5y++qP9HIjNkE4/NWRD/QB3fbC
	 Ay99ORjmdIhoL7Rp8djm7rgbBqP4rjricDMm0Wcs=
Received: from [192.168.211.91] (192.168.211.91) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Jul 2024 11:27:31 +0300
Message-ID: <216de662-023a-4a94-8b07-d2affb72aeb5@paragon-software.com>
Date: Thu, 11 Jul 2024 11:27:30 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
To: Dmitry Vyukov <dvyukov@google.com>, Lizhi Xu <lizhi.xu@windriver.com>
CC: <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>,
	<syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, Kees Cook <keescook@google.com>
References: <CACT4Y+ZWjUE6-q1YF=ZaPjKgGZBw4JLD1v2DphSgCAVf1RzE8g@mail.gmail.com>
 <20240705135250.3587041-1-lizhi.xu@windriver.com>
 <CACT4Y+YrjD=3Tn6o4FJFefDYsOCbUFWahPUp87PXXcHQsr0xXg@mail.gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <CACT4Y+YrjD=3Tn6o4FJFefDYsOCbUFWahPUp87PXXcHQsr0xXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 08.07.2024 09:54, Dmitry Vyukov wrote:
> On Fri, 5 Jul 2024 at 15:52, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>> On Thu, 4 Jul 2024 15:44:02 +0200, Dmitry Vyukov wrote:
>>>> index 53629b1f65e9..a435df98c2b1 100644
>>>> --- a/fs/ntfs3/record.c
>>>> +++ b/fs/ntfs3/record.c
>>>> @@ -243,14 +243,14 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
>>>>                  off += asize;
>>>>          }
>>>>
>>>> -       asize = le32_to_cpu(attr->size);
>>>> -
>>>>          /* Can we use the first field (attr->type). */
>>>>          if (off + 8 > used) {
>>>>                  static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
>>>>                  return NULL;
>>>>          }
>>>>
>>>> +       asize = le32_to_cpu(attr->size);
>>>> +
>>>>          if (attr->type == ATTR_END) {
>>>>                  /* End of enumeration. */
>>>>                  return NULL;
>>> Hi Lizhi,
>>>
>>> I don't see this fix mailed as a patch. Do you plan to submit it officially?
>> Hi Dmitry Vyukov,
>> Here: https://lore.kernel.org/all/20240202033334.1784409-1-lizhi.xu@windriver.com
> I don't see this patch merged upstream.  Was it lost? Perhaps it needs
> to be resent.
Hi, Lizhi, Dmitry, This patch is indeed not present in either the 
upstream or our repository. I will retest it and figure out why I didn't 
add it. Around the same time, I was making changes to mi_enum_attr, so I 
might have mixed something up. Thanks for your attention! Regards,
Konstantin

