Return-Path: <linux-fsdevel+bounces-41995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F25DA39DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D7A17A699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5326A0DB;
	Tue, 18 Feb 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YFW5rhIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE713E02A;
	Tue, 18 Feb 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885742; cv=none; b=hRIZ+KMMNcpljwPut3UKLEMqeZgo1uahj7Mh4dKrXDcX3eM+xdgxHBvsnZkesRsZEm8fjf9SNug9Hh1oy4WFrPUrg4v5Vj5toCXycSZ17Y09BBo4WAOfQ1Ubr/Sw8DWXQgPpRaA75AEQJ4S4qk9fB8yIM9YDJL7H+DS9YJ8/5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885742; c=relaxed/simple;
	bh=xJCeqRpz+Q8IH1elsfPGpaxkwPvGxOdqAX04kwC1ZnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADO+XoqRSZ8hl8oaA9LPVoygJYnxUrIqwj6vOZv/ZVf5pkcO9wTwYvbGVJ3BOdya8xRXSFA48RForH4Eugmb0cVRLsPkrcVZM1wpA1tratIzSffm0THmZx2FjiJuIN9Oi2KdEZdl8RJjLWE5uL/TZXQ0Lko2Q0OatrwYLkuaD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YFW5rhIK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vvCZsgrRy05xwjW+JkqFP2cfNx3lEW0ME6VYNGp1xWk=; b=YFW5rhIK3luY9KNyhNxx1hzgSu
	47xgs7siAgxbEh4CkIpaoLfHbr4cYeuI9w+onNmEyj0RUEOEgxKtyJY5idT+7hpziVSnuXlSC8G2g
	z7LJdT94FiNB90WoowxqkhW1l2fa0OoSI1SwwEUoWObGqKcmO2/yRAe+5ga0Eo57y5UraGcxRYJa7
	tjTMhCY6me3xRkJOc98tGH+/F5sVvzaa3B4zggEmy0qlQVaDf3Q8j94pdox4URljNz0gABWONrMdR
	HOzZpkubcWDIpZJKQ0iSJUeFCRbHi65eITCJ/WuLyX51GDKos6ubJ8ep0CC8Glgn+t2kp9dHv6n1O
	ojbwzMDA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkNkv-00AQQY-0y; Tue, 18 Feb 2025 14:35:26 +0100
From: Luis Henriques <luis@igalia.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  Dave Chinner <david@fromorbit.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] vfs: export invalidate_inodes()
In-Reply-To: <ze23goaoxiryaczmik3y66p23c35tf3ipfw27prlozrqciqlap@6lmpmsx7xsy3>
	(Jan Kara's message of "Tue, 18 Feb 2025 12:59:37 +0100")
References: <20250216165008.6671-1-luis@igalia.com>
	<20250216165008.6671-2-luis@igalia.com>
	<ze23goaoxiryaczmik3y66p23c35tf3ipfw27prlozrqciqlap@6lmpmsx7xsy3>
Date: Tue, 18 Feb 2025 13:35:26 +0000
Message-ID: <8734gb8jfl.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18 2025, Jan Kara wrote:

> On Sun 16-02-25 16:50:07, Luis Henriques wrote:
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>
> Please use evict_inodes(). It is already exported and does exactly the sa=
me
> these days. We should really merge the patch deleting invalidate_inodes()
> :)

Thank you for the suggestion, Jan.  Yeah that makes sense, of course.

However, since it's still not clear what's the future of this patchset
will be, I'll hold on re-sending it for now, but I'll definitely replace
invalidate_inodes() in a future revision.

Cheers,
--=20
Lu=C3=ADs


>
> 									Honza
>
>> ---
>>  fs/inode.c         | 1 +
>>  fs/internal.h      | 1 -
>>  include/linux/fs.h | 1 +
>>  3 files changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 5587aabdaa5e..88387ecb2c34 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -939,6 +939,7 @@ void invalidate_inodes(struct super_block *sb)
>>=20=20
>>  	dispose_list(&dispose);
>>  }
>> +EXPORT_SYMBOL(invalidate_inodes);
>>=20=20
>>  /*
>>   * Isolate the inode from the LRU in preparation for freeing it.
>> diff --git a/fs/internal.h b/fs/internal.h
>> index e7f02ae1e098..7cb515cede3f 100644
>> --- a/fs/internal.h
>> +++ b/fs/internal.h
>> @@ -207,7 +207,6 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
>>   * fs-writeback.c
>>   */
>>  extern long get_nr_dirty_inodes(void);
>> -void invalidate_inodes(struct super_block *sb);
>>=20=20
>>  /*
>>   * dcache.c
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 2c3b2f8a621f..ff016885646e 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3270,6 +3270,7 @@ extern void discard_new_inode(struct inode *);
>>  extern unsigned int get_next_ino(void);
>>  extern void evict_inodes(struct super_block *sb);
>>  void dump_mapping(const struct address_space *);
>> +extern void invalidate_inodes(struct super_block *sb);
>>=20=20
>>  /*
>>   * Userspace may rely on the inode number being non-zero. For example, =
glibc
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


