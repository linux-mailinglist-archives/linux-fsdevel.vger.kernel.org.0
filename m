Return-Path: <linux-fsdevel+bounces-55984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7384B1146B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF8F1C88152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC523F421;
	Thu, 24 Jul 2025 23:20:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4D222564;
	Thu, 24 Jul 2025 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399255; cv=none; b=sRQmG2XPv4nU4uyK4KaqpMUITcXjzSawd+CmeZPLujBSinfz0OkOd48QceQXyEwZ7YDY5J+vP6au3agrlW7olm867Rb31bIp/anBVBSipK6xGZRqVuOX2wBS22WAQoiS51H6GWc1sQWxHBtutmTehLL7qFiD6NZbTMce+yMHdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399255; c=relaxed/simple;
	bh=4mO7U2SOZhEz+nxhWBi0fooMEyLMy9GePPIHY8JxDxM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CaLh3zfHohcui0/THt8QTABcOYCcMvfy/iKXcuIYpVLnybe3jMurvXzd4RBp4pUDJp+q0HaEEcr4RSd7CkGPk69G/WeOajWdHacraZM/6LFZs6cgjkci6G2cfDidfNEZoxJBmr1NX4nF1erA0zeegsBIi+rYuj+0jZ+XybsIBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56ONKT87025594;
	Fri, 25 Jul 2025 08:20:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56ONKSXs025591
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 25 Jul 2025 08:20:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
Date: Fri, 25 Jul 2025 08:20:28 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/25 7:05, Tetsuo Handa wrote:
>>> But I can't be convinced that above change is sufficient, for if I do
>>>
>>> +	            static u8 serial;
>>> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
>>> +                       inode->i_ino = (serial++) % 16;
>>
>> I don't see the point in flags introduction. It makes logic very complicated.
> 
> The point of this change is to excecise inode->i_ino for all values between 0 and 15.
> Some of values between 0 and 15 must be valid as inode->i_ino , doesn't these? Then,

Background: I assume that the value of rec->dir.DirID comes from the hfs filesystem image in the
reproducer (i.e. memfd file associated with /dev/loop0 ). But since I don't know the offset to modify
the value if I want the reproducer to pass rec->dir.DirID == 1...15 instead of rec->dir.DirID == 0,
I am modifying inode->i_ino here when rec->dir.DirID == 0.

> 
>>
>>>
>>> instead of
>>>
>>> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
>>> +                       make_bad_inode(inode);
>>>
>>> , the reproducer still hits BUG() for 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15
>>> because hfs_write_inode() handles only 2, 3 and 4.
>>>
>>
>> How can we go into hfs_write_inode() if we created the bad inode for invalid
>> inode ID? How is it possible?

Calling make_bad_inode() for some of values between 0...15 at hfs_read_inode() will prevent
that inode from going into hfs_write_inode(). But regarding the values between 0...15 which
were not calling make_bad_inode() at hfs_read_inode() will not prevent that inode from going
into hfs_write_inode().

Since hfs_write_inode() calls BUG() for values 0...15 except 2...4, any values between 0...15
except 2...4 which were not calling make_bad_inode() at hfs_read_inode() will hit BUG().

If we don't remove BUG(), the values which hfs_read_inode() does not need to call
make_bad_inode() will be limited to only 2...4.

And since you say that hfs_read_inode() should call make_bad_inode() for 3...4, the only value
hfs_read_inode() can accept (from the point of view of avoid hitting BUG() in hfs_write_inode())
will be 2.

> 
> are all of 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15 invalid value for hfs_read_inode() ?
> 
> If all of 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15 are invalid value for hfs_read_inode(),
> and 3 and 4 are also invalid value for hfs_read_inode(), hfs_read_inode() would accept only 2.
> Something is crazily wrong.
> 
> Can we really filter some of values between 0 and 15 at hfs_read_inode() ?
> 

Can the attempt to filter some of values between 0 and 15 at hfs_read_inode() make sense,
without the attempt to remove BUG() from hfs_write_inode() ?

I think that we need to remove BUG() from hfs_write_inode(), even if you try to filter
at hfs_read_inode().

