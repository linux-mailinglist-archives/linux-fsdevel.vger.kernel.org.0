Return-Path: <linux-fsdevel+bounces-27257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9709D95FDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D871F22168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93D19B3ED;
	Mon, 26 Aug 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDmTCPkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19A199392;
	Mon, 26 Aug 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713982; cv=none; b=eB78nZYGr4itq3opEYLM0IMJ+kXHsBLJ24a1HFqDX4yrc2KfHJpefPl3pPMzYC0JdY1priVn/53UW3vRIh7iAqgCU8Hj46yFh8L+wJlMZO+DQ9M4FSLt0Oql96C9xVYvpLVFezrtZ0Dk1PkzIlhQAU/C+fm4Y5jxhjWWnDo3y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713982; c=relaxed/simple;
	bh=7XwBAUfGnZtL6nJVvm5SlBN+15gz4hx3z3sZy495raE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YRFD2/ZAWfbFVBG/08nNBnziyncMblB0gYH6L4qtAvsAWboBbF9b+r3xeGnxN1Y04JOMs6TW6bKVQZvnmX1Ze2NkqhYZZl0Tvy9GAoqqgI2+Ql8N5OL5zmdH5QqvdsN7rhgBrMetFCYlTssH2eYHbJGXvV7g9zVDqAXysbn2FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDmTCPkf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724713980; x=1756249980;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7XwBAUfGnZtL6nJVvm5SlBN+15gz4hx3z3sZy495raE=;
  b=LDmTCPkfca0iI2aDYhMHPi9scExcZqTRwqkf7bGvhmRTsUpGs14tQtfr
   mgFLiEYfZ+3wMie7AqD0QLmn81Mrft29/ccuGYGmpZy8/ARSugT21vx6g
   RKQh77riLnFMDsNx1VldwXNm6RULT1IX7vB7keueDQ0ZR/IOYJbj6G3Ae
   rEGNMCU3/Ma3EGo16Vroyw+BuKiM1yVKkhBxMo9o4FayZrd07COmRGcaK
   SRMEhQ+8I6VqeevvnuojDuYTUW+cViXZ0bx8CCgSOvBW6pzlI6eF8xehr
   xEOa8ZygX0931Clc6EZsZIUlLbbAELgIteJ8KTDJrTECD8yrTOIJyh7kA
   w==;
X-CSE-ConnectionGUID: cSFXfE5FRjC/Jq/CqMQbHA==
X-CSE-MsgGUID: Yl0P4CczRfiaZyC90Vz+rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13225919"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="13225919"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:12:58 -0700
X-CSE-ConnectionGUID: puOaTtgaQcW2cSkKQRpJlg==
X-CSE-MsgGUID: WLwHcCqZS6uGwMl6CnJWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="67478376"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.39])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:12:56 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/16] overlayfs/file: Convert to cred_guard()
In-Reply-To: <CAJfpegsq5NruDeL6HRgkpj=QvdOKdnqOwZiRS0VY092=h0RSkg@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-11-vinicius.gomes@intel.com>
 <CAJfpegsq5NruDeL6HRgkpj=QvdOKdnqOwZiRS0VY092=h0RSkg@mail.gmail.com>
Date: Mon, 26 Aug 2024 16:12:52 -0700
Message-ID: <87v7zmkhe3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Replace the override_creds_light()/revert_creds_light() pairs of
>> operations with cred_guard()/cred_scoped_guard().
>>
>> Only ovl_copyfile() and ovl_fallocate() use cred_scoped_guard(),
>> because of 'goto', which can cause the cleanup flow to run on garbage
>> memory.
>
> This doesn't sound good.  Is this a compiler bug or a limitation of guards?
>

This is a gcc bug, that it accepts invalid code: i.e. with a goto you
can skip the declaration of a variable and as the cleanup is inserted by
the compiler unconditionally, the cleanup will run with garbage value.
clang refuses to compile and emits an error.

Link to a simpler version of the bug I am seeing:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951

>> @@ -211,9 +208,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>>         ovl_inode_lock(inode);
>>         real.file->f_pos = file->f_pos;
>>
>> -       old_cred = ovl_override_creds_light(inode->i_sb);
>> +       cred_guard(ovl_creds(inode->i_sb));
>>         ret = vfs_llseek(real.file, offset, whence);
>> -       revert_creds_light(old_cred);
>
> Why not use scoped guard, like in fallocate?

No reason. I was only under the impression that cred_guard() was
preferred over cred_scoped_guard(). 

>
>> @@ -398,9 +393,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>>
>>         /* Don't sync lower file for fear of receiving EROFS error */
>>         if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
>> -               old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
>> +               cred_guard(ovl_creds(file_inode(file)->i_sb));
>>                 ret = vfs_fsync_range(real.file, start, end, datasync);
>> -               revert_creds_light(old_cred);
>
> Same here.
>

Will keep it consistent whatever version is chosen.

>> @@ -584,9 +571,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
>>                 return err;
>>
>>         if (real.file->f_op->flush) {
>> -               old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
>> +               cred_guard(ovl_creds(file_inode(file)->i_sb));
>
> What's the scope of this?  The function or the inner block?
>

As far as I understand, the inner block.

> Thanks,
> Miklos


Cheers,
-- 
Vinicius

