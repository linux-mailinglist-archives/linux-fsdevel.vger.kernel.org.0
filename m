Return-Path: <linux-fsdevel+bounces-10736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCD84D9B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 06:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3151C22B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D467C7A;
	Thu,  8 Feb 2024 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hTH1fYzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389772C6BA;
	Thu,  8 Feb 2024 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371610; cv=none; b=Vd/91b6rYNXAV2Dpg2N8CgpbJ1dfecRpdWg6SrlrohcQGJ8uSh/0JeMzzcHy1V1XNlRogOOuMIroMwKM/TXe8YCS6Bfmef34iZXXahIJC3gEouBdFa+3bwHxDYfNLrx+Eehjo+IgARLM3s5RrWIRkCAtSd7m+NdlX/NOU7fJuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371610; c=relaxed/simple;
	bh=XJbCPDjfMjOfSQEBoqY2Y9QX28Ux2kDGK4gtMZN7IcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2q8Vry3MQ9dzWnrESN2WZyX8Rq/WI1+qaLozeTlqR7neTX6gC6TNXaS9wcdWs6qRlX22ORWbdOwRTXig0hpfe5504ywK1lejbRkyDiljfR3pJUlNdhRSKGGufI0EN67uCbq55kRgbwYXXa3FVvUQ5b72AbqJMEaRQdol0XKjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hTH1fYzn; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1707371297;
	bh=HeD4MdsWZP+nT6F3x0Ch5xUnu4rjQuX4K7nZXpOagJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hTH1fYznOrzJXqu9F0ny1lu8dRelTtxLwwtYi6bgGNnAAFaP7Zt1NCt99IVdxgnUk
	 Kn0B0n5/8QhSxSnYI7U1HSfP31ilQbunsvJ+985d5K/VMQZNGEdksUhrcA2lavtySa
	 4sw85yrygj5SCLt94K/JGz6kufAxe0ccNeMfyDt8=
Received: from [192.168.0.101] ([175.152.81.97])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 8ADA76B3; Thu, 08 Feb 2024 13:34:45 +0800
X-QQ-mid: xmsmtpt1707370485tafmacghl
Message-ID: <tencent_1D3AC867D2233D8E19C8CFF3B9A8AA893A05@qq.com>
X-QQ-XMAILINFO: M58CI+QHpTskpw88BVg3fOVTznYDaB5PMTU1xQCVQ0f/DjnnKFFh97qCwRQr/o
	 W9CZnMdZmDFcRREruZVUKNwTRvBkSNZcqz8bHVXpanUOWXAAeTbwRA6p61Y9pt3SjLK/BRdeyDRC
	 MJ+6xpxNrwm9tJEAmIY6JFiYTR00MK5h6f1nNzU5XIZ8N1qiySOZFufSTh6Vbpzg21896en6IfNR
	 sGRKWH85htqY3tHjSwk4RB5qv3a8zGmOVzEKo8ClnXdttMMg6nPf0TincVPmMRxDkVGCIaN2nwP2
	 zdw1NX/kZIgO0kD6yjwDW0fVh9wPS9wx95xoHLDtcaVgsDbKIM0Xzblc+R8a1SkRjyCYlRsHLI3l
	 l+fsbe266Kyytz2pFg0HfIxfnc5Q9uPvFrhNWKEld1WBr1RwyiNEqyoCbafu9QZTNOmQCCYap3aL
	 sZ/9FkOTq2ffANnpn9nddlWSqGOmQ9UyHCmq0inY6EQCMGxJNA5CAKtjjYhxTc2YAq/R3KYXaALz
	 z/JdIo4q93dzN3SN1RZZVUwBQwBMaSEqlPAa2HdIFp87BRK3ZhsvPEGYMm1WLkc1+am6jKj2ihzo
	 /jGBGlDnTxGGkGkVI9AIMRJHq+avSzgjmf+PO9RRmlbctXZknX23q/2B4D3fiU88xvDDr4SPDaCq
	 QwTzlthFIdGw2AbKAMyyBfDATdr+jiW+Fq4WJcMqCiV5gVwB7x2a1q4PoHzNI6RvV2dx6KI/CzaW
	 qROvMjWOho6jcMzED706SOkHVO4fly0STeXx2rHYIL9AH60LRDqORMduXvEhfzKTPCPiwFjl9FgJ
	 HFlNcMYgiKj8bKwbdrHVY4RMgGWVXWOWIsV62kOk1E96Q6HK80I43VhLMTWmieFJqX+G+Cprq34m
	 ITeCUU+bqtxEbwwOeKQBujuPyBuTssYkOark6W3Vq2rR3St+vWIBZm61UyN2oeNAwo3kAwZILXd5
	 XuuV/3ybG/VKzhkd1fPw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <4c493a71-ab68-b7f2-101b-85cefe0e6659@foxmail.com>
Date: Thu, 8 Feb 2024 13:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] eventfd: strictly check the count parameter of
 eventfd_write to avoid inputting illegal strings
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 David Woodhouse <dwmw@amazon.co.uk>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
 <20240208043354.GA85799@sol.localdomain>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240208043354.GA85799@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/2/8 12:33, Eric Biggers wrote:
> On Wed, Feb 07, 2024 at 12:35:18AM +0800, wenyang.linux@foxmail.com wrote:
>> By checking whether count is equal to sizeof(ucnt), such errors
>> could be detected. It also follows the requirements of the manual.
> Does it?  This is what the eventfd manual page says:
>
>       A write(2) fails with the error EINVAL if the size of the supplied buffer
>       is less than 8 bytes, or if an attempt is made to write the value
>       0xffffffffffffffff.
>
> So, *technically* it doesn't mention the behavior if the size is greater than 8
> bytes.  But one might assume that such writes are accepted, since otherwise it
> would have been mentioned that they're rejected, just like writes < 8 bytes.


Thank you for your commtents.
Although this behavior was not mentioned, it may indeed lead to
undefined performance, such as (we changed char [] to char *):

#include <sys/eventfd.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main()
{
     //char str[32] = "hello world";
     char *str = "hello world";
     uint64_t value;
     ssize_t size;
     int fd;

     fd = eventfd(0, 0);
     size = write(fd, &str, strlen(str));
     printf("eventfd: test writing a string:%s, size=%ld\n", str, size);
     size = read(fd, &value, sizeof(value));
     printf("eventfd: test reading as uint64, size=%ld, value=0x%lX\n", 
size, value);
     close(fd);

     return 0;
}


$ ./a.out
eventfd: test writing a string:hello world, size=8
eventfd: test reading as uint64, size=8, value=0x560CC0134008

$ ./a.out
eventfd: test writing a string:hello world, size=8
eventfd: test reading as uint64, size=8, value=0x55A3CD373008

$ ./a.out
eventfd: test writing a string:hello world, size=8
eventfd: test reading as uint64, size=8, value=0x55B8D7B99008


--

Best wishes,

Wen


>
> If the validation is indeed going to be made more strict, the manual page will
> need to be fixed alongside it.
>
> - Eric


