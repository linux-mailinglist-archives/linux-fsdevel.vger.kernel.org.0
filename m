Return-Path: <linux-fsdevel+bounces-72710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C01D00F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 05:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B2F730019F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 04:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ECB285072;
	Thu,  8 Jan 2026 04:04:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17CEBA21;
	Thu,  8 Jan 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767845040; cv=none; b=hU6dONV+CNQENIGXfsSsrb20DJVR5Q6OYbfLVtwpFWVk2tG3SNoG86pon/n72eR2WEDCWrKfWwzCliMz6sq2liTdbBIpQnmwxyBU7dbTuEmzvrcnmrTA4p/K8wECHYi4EhIs68puKD++MDwkQzvXCCv2A4o1c2Envp6mnj5z0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767845040; c=relaxed/simple;
	bh=jnLStAix3XPWkAaGt9Q5bxZm79Jqj6UIqMS97i6WZqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iktkcgapXtL1FvAY97uJhtdfvzuJVIzGh0hkTDv5kQAwx8FuClBORRaOcU7lzlUOckSXVuAinA6AO13BTg7pqw3pwkQaw7LtoqzjtAG5n8LtaRdeQC2l3B0vaI7fueTJ/wheteB9SA0phTP1YuUgNgyyCkiJ1rl+ndU/a1cMxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [192.168.255.10] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [101.226.143.247])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fe53db82;
	Thu, 8 Jan 2026 11:48:26 +0800 (GMT+08:00)
Message-ID: <c5e3cce3-5953-4060-ae62-76e33022f4aa@ustc.edu>
Date: Thu, 8 Jan 2026 11:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overlayfs: mask d_type high bits before whiteout check
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bschubert@ddn.com, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20260107034551.439-1-luochunsheng@ustc.edu>
 <CAOQ4uxhjWwTdENS2GqmOxtx4hdbv=N4f90iLVuxHNgH=NLem9w@mail.gmail.com>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <CAOQ4uxhjWwTdENS2GqmOxtx4hdbv=N4f90iLVuxHNgH=NLem9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b9bb84f3703a2kunm00b0d9a22c51c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUwfVklNTU9LT0tIH0sYT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT0xZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++



On 1/8/26 4:43 AM, Amir Goldstein wrote:
> On Wed, Jan 7, 2026 at 4:46 AM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>
>> Commit c31f91c6af96 ("fuse: don't allow signals to interrupt getdents
>> copying") introduced the use of high bits in d_type as flags. However,
>> overlayfs was not adapted to handle this change.
>>
>> In ovl_cache_entry_new(), the code checks if d_type == DT_CHR to
>> determine if an entry might be a whiteout. When fuse is used as the
>> lower layer and sets high bits in d_type, this comparison fails,
>> causing whiteout files to not be recognized properly and resulting in
>> incorrect overlayfs behavior.
>>
>> Fix this by masking out the high bits with S_DT_MASK before checking.
>>
>> Fixes: c31f91c6af96 ("fuse: don't allow signals to interrupt getdents copying")
>> Link: https://github.com/containerd/stargz-snapshotter/issues/2214
>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> 
> Hi Chunsheng,
> 
> Thanks for the report and the suggested fix.
> 
> This time overlayfs was surprised by unexpected d_type flags and next
> time it could be another user.
> 
> I prefer to fix this in a more profound way -
> Instead of making overlafys aware of d_type flags, require the users that
> use the d_type flags to opt-in for them.
> 
> Please test/review the attached patch.
> 
> Thanks,
> Amir.
> 

Thank you for the profound solution!

The attached patch has been tested and verified to effectively address 
the d_type high bits usage issue by enforcing the opt-in mechanism.

The variable `dt_flag_mask` might be clearer if renamed to 
`dt_flags_mask` (plural "flags").

Reviewed-by: Chunsheng Luo <luochunsheng@ustc.edu>
Tested-by: Chunsheng Luo <luochunsheng@ustc.edu>

> 
>> ---
>>   fs/overlayfs/readdir.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
>> index 160960bb0ad0..a2ac47458bf9 100644
>> --- a/fs/overlayfs/readdir.c
>> +++ b/fs/overlayfs/readdir.c
>> @@ -246,6 +246,9 @@ static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
>>   {
>>          struct ovl_cache_entry *p;
>>
>> +       /* Mask out high bits that may be used (e.g., fuse) */
>> +       d_type &= S_DT_MASK;
>> +
>>          p = ovl_cache_entry_find(rdd->root, c_name, c_len);
>>          if (p) {
>>                  list_move_tail(&p->l_node, &rdd->middle);
>> @@ -316,6 +319,9 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
>>          char *cf_name = NULL;
>>          int c_len = 0, ret;
>>
>> +       /* Mask out high bits that may be used (e.g., fuse) */
>> +       d_type &= S_DT_MASK;
>> +
>>          if (ofs->casefold)
>>                  c_len = ovl_casefold(rdd, name, namelen, &cf_name);
>>
>> @@ -632,6 +638,9 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
>>          struct ovl_readdir_data *rdd =
>>                  container_of(ctx, struct ovl_readdir_data, ctx);
>>
>> +       /* Mask out high bits that may be used (e.g., fuse) */
>> +       d_type &= S_DT_MASK;
>> +
>>          rdd->count++;
>>          p = ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_type);
>>          if (p == NULL) {
>> @@ -755,6 +764,9 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
>>          struct dir_context *orig_ctx = rdt->orig_ctx;
>>          bool res;
>>
>> +       /* Mask out high bits that may be used (e.g., fuse) */
>> +       d_type &= S_DT_MASK;
>> +
>>          if (rdt->parent_ino && strcmp(name, "..") == 0) {
>>                  ino = rdt->parent_ino;
>>          } else if (rdt->cache) {
>> @@ -1144,6 +1156,9 @@ static bool ovl_check_d_type(struct dir_context *ctx, const char *name,
>>          struct ovl_readdir_data *rdd =
>>                  container_of(ctx, struct ovl_readdir_data, ctx);
>>
>> +       /* Mask out high bits that may be used (e.g., fuse) */
>> +       d_type &= S_DT_MASK;
>> +
>>          /* Even if d_type is not supported, DT_DIR is returned for . and .. */
>>          if (!strncmp(name, ".", namelen) || !strncmp(name, "..", namelen))
>>                  return true;
>> --
>> 2.43.0
>>


