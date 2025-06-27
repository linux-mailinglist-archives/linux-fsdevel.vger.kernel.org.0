Return-Path: <linux-fsdevel+bounces-53127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F4AEACF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 04:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1BE4A70B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 02:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC597198A2F;
	Fri, 27 Jun 2025 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lQSdPlm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FE26281;
	Fri, 27 Jun 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992428; cv=none; b=fwGXHUBxAIa6zT7i8WS1k5s/lxeus97Pj/4tPa8Stm9YTGl+i1sPDOM7YbkyA0G8RRXBUMwx1dSFVCiMDdgJAHbVVPlEZzr8c9Dcpja3csP5rK17UjxrTyQRwpZ5Qvzfr9RNbr87OjJ3JpEwJ5OgKhBVsadXzsRh8eT1Plqs7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992428; c=relaxed/simple;
	bh=WQLNRAGTO03Ea/3tQ6gRyiAtgMsPG1wwx2zGsAwYKSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoLUQd0apEEbdsJvtanJlioVR1EK4gewUnB+TlXjl1s5i1g+uaQmL99cQYVyBKzx4Cz7ptUSXK/uM0kQQqKQr/LaIiGxnbgJgmAg42/SCeiAdF88jnFM6JkPpNfOMogoYB7KDOtGq1Ao8nXrV1J+OJ22TktujW65dn4r3LQoFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lQSdPlm5; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750992414; bh=Pu0jA1GVRoKDx2l6du1YCcmFc4TR2c85F/Sld/qZPu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lQSdPlm5fiG5AxnyTsXZTrkD9Sw3jm7nCDQH75MdVkvw8U0VpZBv7lbPAQiIyKQBy
	 4YnBLnkK8uA8+uLkqmK+9cJ+ovmtKTQFclaYvNpcAPFIg+pktnqZJkAdUGyFh1VtJ/
	 ZDZH+OXVQpLcUYJZJXeTl/ptCiLYEeRVHXLK7sGc=
Received: from [172.25.20.158] ([111.202.154.66])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id A2A3B4EF; Fri, 27 Jun 2025 10:40:42 +0800
X-QQ-mid: xmsmtpt1750992042t5ouc00kx
Message-ID: <tencent_5B902C24516F8FB647C156B41596BF68E70A@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAf2UFzEHsFZTqx+Kq6+t/DjOoALtts+bmxTDYe0aOhXVnuSwlBh
	 IKwrkPpmAPshTmKQvzmwkCKcnTChguPERIY3OFEg0UHXTqoUrZRp2DDlAO+zFQL43ghY2PXedN0N
	 v8yTrkQcBKQXpry/j0lTZgxTRyMAJ4il5YSrVQ49OOvk7MOOXLV05fMdiFvaAzTH/AyBkC/8onJx
	 fGCrWZ6Kc1086A9ImQRn8VYJhRsJ2A0ajoWlmFyH/RMMrgB+du2d3S5ta6e1sIqRWANj6DaSBB/Z
	 0H9/sugRPpHBgWCYNx0zR4SZV+D9aVueby9w0rHO8uiZchZTQ55JEiGAU+zYCwUEnpO/WrQquPrS
	 xNORxDZhqJvu3bpgFlZuUB2or5Lb138OPPBVk7ISqU7M9BBuVNhOAABrKgy88NMMi3v7RE5NmASd
	 bsqw5KWSGbMh07yPp6WqG7AbWmS6f+8NMhKaGFBrzr8G31elIiLR0nBUI5Hq+4hzlmKOb4pJPYl4
	 K7dCql/f4y0YBj9NR4/zukyH8EbMDdqBMv5KWHeqTg0br5FOrW3Vf2cgQnlbgpeADTVolKDZCQXU
	 YvFE7JYMY6cWF5Lbz2XGMTgX/PuvSTc7+VlaJ0KCKC36LdQIub3IYqgAYHlqka42BjVm+2rQnIcW
	 drCOo/tZbyhVd3A9q9ehEgnJ7LRGMQngSn1TiWgra5iFlb6L2UAknqV687ygfwTjMMM6SFmyGzKf
	 TJj38y0CFzTSxkhVcKswqdpAyGx5Iyv4ZIue+K43wEjB8Opss/jsbBlrwBU40X9Znabyx/nUnLfy
	 6cr3oIyu9m1nQZpc9UuJMwfrSU/V51GolaiyJW1CvRALeD6jxrTKx2ZYlVX/+QW67bN3K7D9FJCx
	 Wdpk5o2c9KC/id7uBgDRKQXndyxAXpa2USSSOtHHe1iTSMZvWKw+fPK30Lh5vaJqcMkhQnSUsOFx
	 rlUJPhp6v1cO2wygZAmvfIo/alad3u5jx2A2RXxVFTLQaz9X0RlA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <3753a0b7-fed3-4391-9fc4-fade83c89a34@qq.com>
Date: Fri, 27 Jun 2025 10:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] fs: change write_begin/write_end interface to take
 struct kiocb *
To: Christian Brauner <brauner@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6ZmI5rab5rabIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-4-chentaotao@didiglobal.com>
 <aFqfZ9hiiW4qnYtO@casper.infradead.org>
 <20250625-erstklassig-stilvoll-273282f0dd1b@brauner>
From: Chen Taotao <chentao325@qq.com>
In-Reply-To: <20250625-erstklassig-stilvoll-273282f0dd1b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/6/25 16:04, Christian Brauner 写道:
> On Tue, Jun 24, 2025 at 01:51:51PM +0100, Matthew Wilcox wrote:
>> On Tue, Jun 24, 2025 at 12:12:08PM +0000, 陈涛涛 Taotao Chen wrote:
>>> -static int blkdev_write_end(struct file *file, struct address_space *mapping,
>>> +static int blkdev_write_end(struct kiocb *iocb, struct address_space *mapping,
>>>   		loff_t pos, unsigned len, unsigned copied, struct folio *folio,
>>>   		void *fsdata)
>>>   {
>>>   	int ret;
>>> -	ret = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
>>> +	ret = block_write_end(iocb->ki_filp, mapping, pos, len, copied, folio, fsdata);
>> ... huh.  I thought block_write_end() had to have the same prototype as
>> ->write_end because it was used by some filesystems as the ->write_end.
>> I see that's not true (any more?).  Maybe I was confused with
>> generic_write_end().  Anyway, block_write_end() doesn't use it's file
>> argument, and never will, so we can just remove it.
>>
>>> +++ b/include/linux/fs.h
>>> @@ -446,10 +446,10 @@ struct address_space_operations {
>>>   
>>>   	void (*readahead)(struct readahead_control *);
>>>   
>>> -	int (*write_begin)(struct file *, struct address_space *mapping,
>>> +	int (*write_begin)(struct kiocb *, struct address_space *mapping,
>>>   				loff_t pos, unsigned len,
>>>   				struct folio **foliop, void **fsdata);
>>> -	int (*write_end)(struct file *, struct address_space *mapping,
>>> +	int (*write_end)(struct kiocb *, struct address_space *mapping,
>>>   				loff_t pos, unsigned len, unsigned copied,
>>>   				struct folio *folio, void *fsdata);
>> Should we make this a 'const struct kiocb *'?  I don't see a need for
>> filesystems to be allowed to modify the kiocb in future, but perhaps
>> other people have different opinions.
> Given I picked up Willy's change I'll wait for a resubmit of this series
> on top of vfs-6.17.misc unless I hear otherwise?
Sure, I’ll update the series on top of vfs-6.17.misc and resend it as 
soon as possible.

Best regards,
Taotao Chen


