Return-Path: <linux-fsdevel+bounces-61458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF6B58783
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E9F482D66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234442C1786;
	Mon, 15 Sep 2025 22:28:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6626AE4;
	Mon, 15 Sep 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975291; cv=none; b=SlDsTQ7x13DZKi8f01PJW9t2G/0M+9YseJDDxE8RKGvnQfpHr0S0i24FujWVb4MZOQdwDVncbxCMoTui75ZUC2vZlRDjO1e2ixCL7QsqMpAg5YKMWZuugmvf49Ru3PkXGJb8Wr42/bSNJ7735/X4ZykHaPrxBcRNI5fVByn1C1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975291; c=relaxed/simple;
	bh=gj4vhmLZ80HZ49RFQNzOQ+6G+7wvHfi/fpS6n8Y4stY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZOo0mnFH9Tp1MgWLVnhXWNdGEVMV3IY+un0Ty1ql2zy4Mn/eGqqUsF9mBm3WkCD/CKDINfltcHDePrI9Ggq42fvcVsMwaJAtuTjHSPm9PgceUam2tq/lFPkNS9uBEHfVGXlF76SRb4cow2Z/IUFhKtrBUrJSeBAk9XmONV9p6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58FMRiB0034727;
	Tue, 16 Sep 2025 07:27:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58FMRefe034717
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 16 Sep 2025 07:27:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <afaca575-2393-4dd8-8159-1b79b01d007f@I-love.SAKURA.ne.jp>
Date: Tue, 16 Sep 2025 07:27:39 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hfs: update sanity check of the root record
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <56dd2ace-7e72-424d-a51a-67c48ae58686@I-love.SAKURA.ne.jp>
 <0dc4e0a9888b7b772e8093fc40c2d44a22f49daf.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0dc4e0a9888b7b772e8093fc40c2d44a22f49daf.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

On 2025/09/16 7:14, Viacheslav Dubeyko wrote:
> On Fri, 2025-09-12 at 23:59 +0900, Tetsuo Handa wrote:
>> syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
>> operation when the inode number of the record retrieved as a result of
>> hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
>> commit b905bafdea21 ("hfs: Sanity check the root record") checked
>> the record size and the record type but did not check the inode number.
>>
>> Viacheslav Dubeyko considers that the fix should be in hfs_read_inode()
>> but Viacheslav has no time for proposing the fix [1]. Also, we can't
>> guarantee that the inode number of the record retrieved as a result of
>> hfs_cat_find_brec(HFS_ROOT_CNID) is HFS_ROOT_CNID if we validate only in
>> hfs_read_inode(). Therefore, while what Viacheslav would propose might
>> partially overwrap with my proposal, let's fix an 1000+ days old bug by
>> adding a sanity check in hfs_fill_super().
>>
> 
> I cannot accept any fix with such comment. The commit message should explain the
> issue and fix nature.

Then, see v4 at https://lkml.kernel.org/r/427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp


