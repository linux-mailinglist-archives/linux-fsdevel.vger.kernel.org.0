Return-Path: <linux-fsdevel+bounces-77842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IpWFJl8PmWmjPgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 02:50:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB516BC73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 02:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AF3930185A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2C324B27;
	Sat, 21 Feb 2026 01:50:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775531B122
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771638617; cv=none; b=mmKRpJBiAecy2SCD4/4/3wOXwkre3rmw+MUC/I4AGsZjA+96tzKbACWBrDsAu5yQuBBf77aVh3Rfglaic+2Vu+AgAPJP65RnvCc8BNN3/Jae2Kz7r3Q6j3eHLSgjJZIiNslJZmp+jM48R4lnPUst4TUcSWdAY6bl4lczYp0PdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771638617; c=relaxed/simple;
	bh=b3zfsBQ/BAYTstfiP1UTz49Pj6zQSNW6c+2DVDUBTNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXOdcS1MVqXnGKSGYdISgDI6J8tVCea8PxRVHqlJkPvvrzAU9XFFbLnQDg4zZRedO67RaopPf3OIOXA94q/EFR4RqOD9qL9YkcP7Jf4SbiJYNSlShE24uLQvK6SgxzOUvJMJ2+sGJ7xGdIARoaqc+8XSIBVNSqwI55YnyYpM6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61L1o14d011889;
	Sat, 21 Feb 2026 10:50:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61L1o17i011886
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Feb 2026 10:50:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <15eebd5d-cf5b-42ca-a772-6918520ff140@I-love.SAKURA.ne.jp>
Date: Sat, 21 Feb 2026 10:50:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: don't fail operations when files/directories counter
 overflows
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
 <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
 <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
 <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
 <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
 <fd5c05a5-2752-4dab-ba98-2750577fb9a4@I-love.SAKURA.ne.jp>
 <be0afbc9cf2816b19952a8d38ffb4a82519454e2.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <be0afbc9cf2816b19952a8d38ffb4a82519454e2.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77842-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ibm.com,physik.fu-berlin.de,vivo.com,dubeyko.com,xs4all.nl];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 90CB516BC73
X-Rspamd-Action: no action

On 2026/02/21 5:03, Viacheslav Dubeyko wrote:
>> @@ -216,13 +214,8 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
>>  	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
>>  	if (S_ISDIR(mode)) {
>>  		inode->i_size = 2;
>> -		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
>> -		if (folder_count> U32_MAX) {
>> -			atomic64_dec(&HFS_SB(sb)->folder_count);
>> -			pr_err("cannot create new inode: folder count exceeds limit\n");
>> -			goto out_discard;
>> -		}
>> -		if (dir->i_ino == HFS_ROOT_CNID)
>> +		atomic64_add_unless(&HFS_SB(sb)->folder_count, 1, U32_MAX);
> 
> We cannot simply silently stop accounting folders count. We should complain and
> must return error.

If there were no race window of committing stale counter values to mdb, and if there
were no possibility of mdb corruption, it is impossible to overflow, for
0 <= file_count + folder_count <= U32_MAX is guaranteed because the cnid is 32bits.

But like syzbot reports, file_count can be larger or smaller than actual number of files
and folder_count can be larger or smaller than actual number of folders when mdb is
corrupted/inaccurate. Also, like I mentioned in this patch, there is always race window of
committing stale counter values. Users won't notice this inaccuracy unless fsck.hfs is run,
and this inaccuracy needlessly disturbs user's operation if we return error.

I suggested reporting this inaccuracy via printk() once, but you said that doing it at
unmount time is too late. And you also don't want to add per-mount flags for tracking
whether we already reported this inaccuracy after we detected it. Then, we should not
call printk() because it is too much noise.

Also, we are simply silently ignoring overflow of root folders/files counters.
Overflow of root folders/files counters should be handled as well as overflow
of total folders/files counters.


>> @@ -272,16 +260,18 @@ void hfs_delete_inode(struct inode *inode)
>>  
>>  	hfs_dbg("ino %lu\n", inode->i_ino);
>>  	if (S_ISDIR(inode->i_mode)) {
>> -		atomic64_dec(&HFS_SB(sb)->folder_count);
>> -		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
>> +		atomic64_add_unless(&HFS_SB(sb)->folder_count, -1, 0);
> 
> I don't see point to change atomic64_dec() on atomic64_add_unless() here.

When folder_count is smaller than actual number of folders, folder_count can
become negative value. But due to s64 and u32 comparison, the counter became
negative is not reported. Overflow upon decrement should be handled as well as
overflow upon increment, but you are not seeing the point.


>> @@ -73,14 +73,6 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
>>  		pr_warn("next CNID exceeds limit\n");
>>  		corrupted = true;
>>  	}
>> -	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
>> -		pr_warn("file count exceeds limit\n");
>> -		corrupted = true;
>> -	}
>> -	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
>> -		pr_warn("folder count exceeds limit\n");
>> -		corrupted = true;
>> -	}
> 
> We need to have this check here. I don't see the point to remove these checks.

This check here is useless. Calling printk() *only once for each mount* when overflow
(either increment or decrement) was detected for that mount would be useful.


