Return-Path: <linux-fsdevel+bounces-58843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FAEB320BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE16F624E22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEE308F17;
	Fri, 22 Aug 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BF1IZwiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BF289E0F;
	Fri, 22 Aug 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881252; cv=none; b=bxXyH4c4rapIedwQPBeQkutElgHYNzi1TwCf/N5q3QitsDpfC8YKkWMIiagmQtB2NPuvcV+sYr9b9uHsalOZcwYUDBAXZMkQODa7SD7e7kwTemSJO0aggDJmXtzXh5ZTaF7MZd+YP1PWsYXUYMxR9jJDgsgplr0Or80nMdBZR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881252; c=relaxed/simple;
	bh=Cg0YOGc3/tSEhmSX9Qz0lgdsx5463Om2fx6dxhxRkmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAAUadasrv/lFy7tQgBkf6n0cMwNT2sMI9DX4E+/lBL38KAGkuYJ6yQin0UBaMbb5lYGHv7EGFrfL+Vf6ay7VL0esS5V2G6+LqfDXWL0dTvuC/KlwdRNlBcDwl0Wwh00i1KE4rWiHfTIBk7ueU8W4NzynqVTJdFDu8XBfCqClTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BF1IZwiB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zQ0lOQ0oHKrpLxM/oUwMClZCb0nI9Ag0xuepWkH2Aes=; b=BF1IZwiBMkZ+9EHvqxHaA3KHBC
	qWU97F/uJ3c1nopKAduatmf9c5rPgVw7HKDd1xhDDuGAlwlHvzesAZ373BiI24UPvVkFS67mFWbzI
	K69svKvuMtLocx6NiENiZg37AhvSG0/6rg6deqT65La5ioCcWIX4nDzuP3e45zMhD1LYhTqPpYjNR
	+IHRLF1FgKqHSVW1vC0EWb3pmX8Hh2yy+c9RVSmONXNE4N98JpL/D2gZ3Pn4jA9CHrKk460hhT4Ss
	jMsN/6egr7MQPLUDybuu/g3liNp5k5b9P9HLMdVXtAcGbuHyrnTIZgfZwW46shtUmCu0fRfbXQnFq
	KR+T7gEQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upUv8-000BiJ-BN; Fri, 22 Aug 2025 18:47:18 +0200
Message-ID: <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com>
Date: Fri, 22 Aug 2025 13:47:14 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled
 layers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
 <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 22/08/2025 13:34, Amir Goldstein escreveu:
> On Fri, Aug 22, 2025 at 4:17 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Drop the restriction for casefold dentries lookup to enable support for
>> case-insensitive layers in overlayfs.
>>
>> Support case-insensitive layers with the condition that they should be
>> uniformly enabled across the stack and (i.e. if the root mount dir has
>> casefold enabled, so should all the dirs bellow for every layer).
>>
>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> Changes from v5:
>> - Fix mounting layers without casefold flag
>> ---
>>   fs/overlayfs/namei.c | 17 +++++++++--------
>>   fs/overlayfs/util.c  | 10 ++++++----
>>   2 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
>> index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499b47a7609fd41ecaec8 100644
>> --- a/fs/overlayfs/namei.c
>> +++ b/fs/overlayfs/namei.c
>> @@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>>          char val;
>>
>>          /*
>> -        * We allow filesystems that are case-folding capable but deny composing
>> -        * ovl stack from case-folded directories. If someone has enabled case
>> -        * folding on a directory on underlying layer, the warranty of the ovl
>> -        * stack is voided.
>> +        * We allow filesystems that are case-folding capable as long as the
>> +        * layers are consistently enabled in the stack, enabled for every dir
>> +        * or disabled in all dirs. If someone has modified case folding on a
>> +        * directory on underlying layer, the warranty of the ovl stack is
>> +        * voided.
>>           */
>> -       if (ovl_dentry_casefolded(base)) {
>> -               warn = "case folded parent";
>> +       if (ofs->casefold != ovl_dentry_casefolded(base)) {
>> +               warn = "parent wrong casefold";
>>                  err = -ESTALE;
>>                  goto out_warn;
>>          }
>> @@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>>                  goto out_err;
>>          }
>>
>> -       if (ovl_dentry_casefolded(this)) {
>> -               warn = "case folded child";
>> +       if (ofs->casefold != ovl_dentry_casefolded(this)) {
>> +               warn = "child wrong casefold";
>>                  err = -EREMOTE;
>>                  goto out_warn;
>>          }
>> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
>> index a33115e7384c129c543746326642813add63f060..52582b1da52598fbb14866f8c33eb27e36adda36 100644
>> --- a/fs/overlayfs/util.c
>> +++ b/fs/overlayfs/util.c
>> @@ -203,6 +203,8 @@ void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
>>
>>   bool ovl_dentry_weird(struct dentry *dentry)
>>   {
>> +       struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
>> +
>>          if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(dentry))
>>                  return true;
>>
>> @@ -210,11 +212,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
>>                  return true;
>>
>>          /*
>> -        * Allow filesystems that are case-folding capable but deny composing
>> -        * ovl stack from case-folded directories.
>> +        * Exceptionally for layers with casefold, we accept that they have
>> +        * their own hash and compare operations
>>           */
>> -       if (sb_has_encoding(dentry->d_sb))
>> -               return IS_CASEFOLDED(d_inode(dentry));
>> +       if (ofs->casefold)
>> +               return false;
> 
> I think this is better as:
>          if (sb_has_encoding(dentry->d_sb))
>                  return false;
> 
> I don't think there is a reason to test ofs->casefold here.
> a "weird" dentry is one that overlayfs doesn't know how to
> handle. Now it known how to handle dentries with hash()/compare()
> on casefolding capable filesysytems.
> 
> Can you please push v6 after this fix to your gitlab branch?
> 

Ok, it's done


