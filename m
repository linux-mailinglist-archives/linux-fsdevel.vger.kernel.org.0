Return-Path: <linux-fsdevel+bounces-45923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35AA7F470
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 07:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D52B177D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C222E25EFAA;
	Tue,  8 Apr 2025 05:54:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-09.prod.sxb1.secureserver.net (sxb1plsmtpa01-09.prod.sxb1.secureserver.net [188.121.53.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64F213E67
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744091679; cv=none; b=H1Fqa/0lBYWwAXbQyPXjL98YopBwaf+oU00iJf9DDKkNnC8Xm+4npiUZ7Nfcy5xoN3U0ZsO5bZLlXgrEsGLtJWhYgKCvpjtZwvO8y7m8TbExgYcMAkU6+TdqiqqHCpi90+VbYMRzmdXnv6cmZtpl3o9h+IDaV/BmGZe4PNlj4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744091679; c=relaxed/simple;
	bh=LXuGmP+5eI2TnnMyC1FFsctp5JoeYuH/0EnQ5k2XhjE=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=KJlohB+X5LHPY2I0lxoHF0hTxvQqmMRGaujUcgiBpsELZPLO6LYMS9p3xKIN/meMOLcXqzjpor5KmEJ97jOm3kaxv/my/YTbti5b9ZFZOVXGBxFCuP6VyGzx6rXwy/Mgm3vyBTHee4ZeQnWSTQwwXGQmMRkLJKonb3RZl0qMxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id 21bfujqzDxJGd21bhufVIz; Mon, 07 Apr 2025 22:34:46 -0700
X-CMAE-Analysis: v=2.4 cv=ZqoXK87G c=1 sm=1 tr=0 ts=67f4b577
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=FXvPX3liAAAA:8 a=36k9kUrpFmN1ouI47esA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
Date: Tue, 8 Apr 2025 06:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
From: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: Recent changes mean sb_min_blocksize() can now fail
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLgiVd6w7M1jJ8sxx/5VfnM0oNjxj3+zXBOKGWp9QyJM+1OrRGPRadhmTQ6uxIhSqs8CBa7rDntCLR/pMBIuPxl6r5O9W6W2eHmmNzqBx2B2OV8KaJ8d
 NuWIkMO2MBbW8c+HnDL7oWTgP+Xf0IENCaa1x/KMyADqDZ/ykUwsOeM1w8AE6wgzeVsAR/GGG7xkRjC8Eee0MOlb+37zD4FuIYV32618X9j9HoRUcBvlMj7o
 dAytz1y+t4Hrwkpgu/27DhsSw/fVcjJqmHpmH7ltEQcu909KQIhOGWTYGsFB7JMBOF3G06EjL7/8r5BGmqyrDSRBp9s5xqtIQyhD/KOcO+j4NGqcI2K8ruV7
 4aVjjIQ0DrPvShzZfA/p4lC0MlGA4rIr5nc/ffkuViWhshlr8bnswblMbKAjliEKAQiYGRLNYpWqOplLP3EqSIb9/0/FI4mDAPmu6ky4MT9G3zTKkI/1yagS
 leM1xnJd5q+2XrIU

Hi,

A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
and any filesystem which doesn't check the result may behave unexpectedly as a
result.  This change has recently affected Squashfs, and checking the kernel code,
a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
check the result.  This is a courtesy email to warn others of this change.

The following emails give the relevant details.

https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/

Regards

Phillip

