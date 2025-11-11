Return-Path: <linux-fsdevel+bounces-67957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ABCC4E802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A9CA4FC01A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684CB2F5A10;
	Tue, 11 Nov 2025 14:27:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44373AA188;
	Tue, 11 Nov 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871229; cv=none; b=RjIgxd4pd6iVlnchYeVvOqFI5cAE3ShEAzuIt4umy4n7kmyzVL+QlLXb2g6hQIjWn9BXCh16QfiVFv9J6edDl3YHST/UPNwQqSKw638EIa4KGGY4KCL0Oh/ErySd43KUA2UTmXCXaF5wXyN2gdVm+bOn56okqIwFmaF9m6K9Wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871229; c=relaxed/simple;
	bh=NxCYtQgXDL/5i83mAH+Oo1A2ixPr+6QVKgoUtm0HxA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnUiTSvhVnkhKOE0RGsplkxCY5uAIxE2bddj2ryYr4C8IlYJabkd/GdWmj8RKmR0D0tWOJvDiIQr+incutsX89UsiAk1gbe0W9/ntjEkc2wNtDuqslDTwzkQrmC1LQUPygL6qU4iLhtBHbrtHxlkCMusXzw6RAvEvqGvt/u99fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5ABEQ9uK054070;
	Tue, 11 Nov 2025 23:26:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5ABEQ9BI054067
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 11 Nov 2025 23:26:09 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <515b148d-fe1f-4c64-afcf-1693d95e4dd0@I-love.SAKURA.ne.jp>
Date: Tue, 11 Nov 2025 23:26:07 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hfs: Update sanity check of the root record
To: George Anthony Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
 <linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
 <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-4-contact@gvernon.com>
 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
 <aRJvXWcwkUeal7DO@Bertha>
 <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
 <aRKB8C2f1Auy0ccA@Bertha>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aRKB8C2f1Auy0ccA@Bertha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2025/11/11 9:23, George Anthony Vernon wrote:
>> Technically speaking, we can adopt this check to be completely sure that nothing
>> will be wrong during the mount operation. But I believe that is_valid_cnid()
>> should be good enough to manage this. Potential argument could be that the check
>> of rec.dir.DirID could be faster operation than to call hfs_iget(). But mount is
>> rare and not very fast operation, anyway. And if we fail to mount, then the
>> speed of mount operation is not very important.
> 
> Agreed we're not worried about speed that the mount operation can reach
> fail case. The check would have value if the bnode populated in
> hfs_find_data fd by hfs_cat_find_brec() is bad. That would be very
> defensive, I'm not sure it's necessary.

With my patch, mount() syscall fails with EIO unless rec.dir.DirID == 2.
Without my patch, mount() syscall succeeds and EIO is later returned when
trying to read the root directory of the mounted filesystem.

This is not a problem of speed. Fuzzing unreadable root directory is useless.
There is no point with making mount() syscall succeed.


