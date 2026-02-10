Return-Path: <linux-fsdevel+bounces-76848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMaEFQNZi2ljUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:12:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87B11CF6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FEA43055816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0938885C;
	Tue, 10 Feb 2026 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJL2NnRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EE3876CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739921; cv=none; b=Kgu45nNiT6MlHGQ+3i5vwxRyZWz9AUB8+HMGnPBBK/32pgW60xMlnDjY0wlSCNA+jQ0N2OACW9OpySKMHfzvODrHTxyWwiED45I3cC95ueOFw/Ku3u5a3MIG+PgBnEIYao9Clq5izGlL0LoU1AqSyqg7isDfsQQdvTaspeTn0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739921; c=relaxed/simple;
	bh=rcwUUzRQ+nNfp/Q0W2b52PC8lI1R+ayfS5CWHPkazsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAo+5bbdyC5FIyAP7iyWbPYEEjtm+Wc9bQ3QErdseCZ+k0y67jfoNOzWSOZ3+56SIVguWIxdR0MaFlVpz6ihC2uhji69Ra0+Y+pIgZTdhYWzNy67MD9AcZjVmQV7cbrSMVElqcc576DWzCSYAYWVvP3SUva5M453NifjtM1Op4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJL2NnRZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a929245b6aso37694705ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770739920; x=1771344720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0r2fUEvWGlF2e7USxRILxffKA5SaIfZKmd2JjKgC7zU=;
        b=eJL2NnRZY6Fx8GvLATrf+ifT8QISnqJfnXBO0cfd9xT7HEmCYZucF+B6MEbXvO+Gna
         zj5rdX7CEDOFb93Jh3+ByrytkmGtb+UqLtLKdF/DmeLk2FXLGh7gjlCNVEfbcM9X5LTE
         ifI1rm+djcMgDJPGe6E6rCXkcGqWnTDCeCKtPGp7lcGELdKvK+LQYq82vgprUDL4o3AR
         CYDCjbwx6CYVP9c63pNN4/Fltz8tn+1g6b2qzyivNkkclVxDnBJPMf4VzFkONk4rOKdo
         AkRBpuwGB3QK1YPt2lNZHg6IumwXXgNgwoDIiU2Y9FRamfyiRxh/ge+54Vt34EwVZiz/
         VVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770739920; x=1771344720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0r2fUEvWGlF2e7USxRILxffKA5SaIfZKmd2JjKgC7zU=;
        b=k1ROZ4kzoelQ5jOrKjH5ZhSla5hjIVJxEJwNvq72LNEK9Oe8mt+z3uu8JjZEnWHQLo
         RVoA7Yo1QaPVAA/KywhfEJj8FscQS0jlxw3nr1u4KK2q0IU7Ec6GvbZYFu8nSYXFpU9I
         rD0Ylst0uEfOSY1Pg8ej5SotjkxTLIaQ8JfWd2jD6/MXpeQsFsRbPlosXdzC2K5pwPr3
         0sTX0AnayIB7lZZQpFoTPbAQ6EZvFpH39jE3Owfqg2t2HvWkSjYLYJNUJMWJ1azEl6Lk
         1cIETeSZ/yK2HM9c/KhAZwrkJ/YRE85045X4pxyPn8jo7oCOtrejxLtr4wfMsBzg2O2X
         jPWA==
X-Forwarded-Encrypted: i=1; AJvYcCV2AY6CJwumbAr4A8XxQj5tDs1tiNNUWzOaJO3Lj31B/blq21hcWvwEaQlLUrq05Leel/TjqrV9mIa7HJIm@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpbM3n91dxl8HXohZTq4o3+g1WN9r3btqDBnmNGCf5sTGJfGz
	gr0g8R3REOjQDgHpYcFoGxgXp1rlqc/yf2oZy/VfgwM93vYuxWoCVwFE
X-Gm-Gg: AZuq6aLV901hHoxHF/Ef+uE+9H2hSqcSU4+ItCeF5lNye91ot8SvtwPvSSSkxinadwQ
	uzpbM8swvfoj4j1dxb8yNQnkDUfE59ZkxUwzCcw5jHDjUQ6NKIZSXfgJAaxGWOZ66Sy2CG08djW
	jdYI/zIlatHkzxpkmcUifo6+owfwuQqa24VxpJ6ME4gYXRZRJHBIh/gVkRc6Bb0vcUKzbsN219u
	rxQKv0cfnHG8lLwKgy7uuUc0eE+cfdh0n8/knyD5hWNFiBONRRr8LjT46dojYRujU4BhQpSwxqp
	9eK1KxXH0jujZHM/AUhhMFvSA/O/d8f092Y57lJgFXokNQEMl6AemtCJYDjiNk4VifSJRq9D9+m
	krgQjnlfMQ2wPQRgk8OQXLOE6fWN3/XBxI1rVeIsRrOVxZguhnsBS7WNiDsT+80CHBZ2mwtkCa3
	mWB3chmQQf690fDEC0lMKKCHNBpe1yjtPegk8n1kR+Yb6kP78saNtOu+TGLWnOCCkNyhq+oqchR
	g==
X-Received: by 2002:a17:903:38c5:b0:2a9:5db8:d659 with SMTP id d9443c01a7336-2a95db8e070mr135977875ad.31.1770739920092;
        Tue, 10 Feb 2026 08:12:00 -0800 (PST)
Received: from ?IPV6:240e:390:a90:6d21:e579:6116:b665:1484? ([240e:390:a90:6d21:e579:6116:b665:1484])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ec43bsm189495745ad.72.2026.02.10.08.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 08:11:59 -0800 (PST)
Message-ID: <d8b84bb5-8fb4-48fe-9ccb-7a0b724eb4b9@gmail.com>
Date: Wed, 11 Feb 2026 00:11:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially block
 truncating down
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org,
 djwong@kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com, Zhang Yi <yi.zhang@huaweicloud.com>
References: <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
 <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
 <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
 <yrnt4wyocyik4nwcamwk5noc7ilninlt7cmyggzwhwzjjsjzfc@uxdht432fgzm>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <yrnt4wyocyik4nwcamwk5noc7ilninlt7cmyggzwhwzjjsjzfc@uxdht432fgzm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76848-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com,huaweicloud.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE87B11CF6B
X-Rspamd-Action: no action

On 2/10/2026 10:07 PM, Jan Kara wrote:
> On Tue 10-02-26 20:02:51, Zhang Yi wrote:
>> On 2/9/2026 4:28 PM, Zhang Yi wrote:
>>> On 2/6/2026 11:35 PM, Jan Kara wrote:
>>>> On Fri 06-02-26 19:09:53, Zhang Yi wrote:
>>>>> On 2/5/2026 11:05 PM, Jan Kara wrote:
>>>>>> So how about the following:
>>>>>
>>>>> Let me see, please correct me if my understanding is wrong, ana there are
>>>>> also some points I don't get.
>>>>>
>>>>>> We expand our io_end processing with the
>>>>>> ability to journal i_disksize updates after page writeback completes. Then
>>
>> While I was extending the end_io path of buffered_head to support updating
>> i_disksize, I found another problem that requires discussion.
>>
>> Supporting updates to i_disksize in end_io requires starting a handle, which
>> conflicts with the data=ordered mode because folios written back through the
>> journal process cannot initiate any handles; otherwise, this may lead to a
>> deadlock. This limitation does not affect the iomap path, as it does not use
>> the data=ordered mode at all.  However, in the buffered_head path, online
>> defragmentation (if this change works, it should be the last user) still uses
>> the data=ordered mode.
> 
> Right and my intention was to use reserved handle for the i_disksize update
> similarly as we currently use reserved handle for unwritten extent
> conversion after page writeback is done.
> 
> 								Honza

IIUC, reserved handle only works for ext4_jbd2_inode_add_wait(). It 
doesn't work for ext4_jbd2_inode_add_write() because writebacks 
triggered by the journaling process cannot initiate any handles, 
including reserved handles. So, I guess you're suggesting that within 
mext_move_extent(), we should proactively submit the blocks after 
swapping, and then call ext4_jbd2_inode_add_wait() to replace the 
existing ext4_jbd2_inode_add_write(). Is that correct?

Thanks,
Yi.




