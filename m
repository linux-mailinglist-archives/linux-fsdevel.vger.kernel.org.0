Return-Path: <linux-fsdevel+bounces-58811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A44B31AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05DF6048B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9573054C5;
	Fri, 22 Aug 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VXVXOdnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A22C3261;
	Fri, 22 Aug 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871655; cv=none; b=t9SiQNnruDhfrJ8v+bAsBYdEa8UvzOhKu6ROKTQKlCycyhWzlBTpzFVT7UA8SZM3ItQSn4D6ZLWCj/9zdVmK8hnRBQCiTAZM6Cl/pwtW6sgnLATCA7h4IIZVwwXQuMgFMJm6fGxImCkOKHz8FLandY6EZGXC9zC7vJAcy/VF89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871655; c=relaxed/simple;
	bh=j6Gt5IZtxTbNbjVeBp6YN/qynlfox9l4Yo9xkXt4ufM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4InoKOwwCkxTaJLRKF/AdHpeYssvH4lnQ2nWOlFgrSkbzYjVUs9dpZo0VbNFOZsh3mIwv8bOmoaJSh5dJPOxSdULgGqVAkT9rOrgnEcq125udOGmQlwVjtQdKaB72M5GrRZQnzIxqspu2pL0hXFo5ULPdpsIVdwveI3g5TdhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VXVXOdnm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/IcI3fs+CdosW5+lwwgmJ6BWeUSk0gNZDPTOXnVmqXs=; b=VXVXOdnmASDMqhMBxRarlqc5oi
	GSBhG6C1yh0DvjPBGkYWez60anZn0mcR4t3SsgjRXcX51pnrUmFXPDRekFgx0ZESljE2usqNFKzjC
	yjGPw3QrmHR+IE606lkgv6c7HmRg3zjKd5r8/pJq/t+iAudqyoIorJjIJ0THBzGk3syYkpb4UMLeN
	0mDikYu2WgqHWeyKMDDrMu9RrQgVTu0BhJg0wuElpTm4qXYZkv1z0R56UhnpPTF9m455JesV+iiH0
	eQ1If/ewF4NqrgYyOHiuAQPGUheugYdZXcV3oq381vqTQTdvfHnSMEw37ogUuiWNOr2fYs7OhXZw5
	fjfzYoDQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upSQJ-00080K-Mc; Fri, 22 Aug 2025 16:07:19 +0200
Message-ID: <c1e1f4b3-e3a0-4a9a-982d-9fd6f6e96090@igalia.com>
Date: Fri, 22 Aug 2025 11:07:14 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
 <CAOQ4uxiX+ZURzvNdJw+UJw-2OTS5DRGr4LLr9YnHjjPKOv57TA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxiX+ZURzvNdJw+UJw-2OTS5DRGr4LLr9YnHjjPKOv57TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/08/2025 11:33, Amir Goldstein escreveu:
> On Thu, Aug 14, 2025 at 7:22 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> To add overlayfs support casefold layers, create a new function
>> ovl_casefold(), to be able to do case-insensitive strncmp().
>>
>> ovl_casefold() allocates a new buffer and stores the casefolded version
>> of the string on it. If the allocation or the casefold operation fails,
>> fallback to use the original string.
>>
>> The case-insentive name is then used in the rb-tree search/insertion
>> operation. If the name is found in the rb-tree, the name can be
>> discarded and the buffer is freed. If the name isn't found, it's then
>> stored at struct ovl_cache_entry to be used later.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> Changes from v4:
>>   - Move the consumer/free buffer logic out to the caller
>>   - s/aux/c_name
>>
>> Changes from v3:
>>   - Improve commit message text
>>   - s/OVL_NAME_LEN/NAME_MAX
>>   - drop #ifdef in favor of if(IS_ENABLED)
>>   - use new helper sb_encoding
>>   - merged patch "Store casefold name..." and "Create ovl_casefold()..."
>>   - Guard all the casefolding inside of IS_ENABLED(UNICODE)
>>
>> Changes from v2:
>> - Refactor the patch to do a single kmalloc() per rb_tree operation
>> - Instead of casefolding the cache entry name everytime per strncmp(),
>>    casefold it once and reuse it for every strncmp().
>> ---
>>   fs/overlayfs/readdir.c | 115 +++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 97 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
>> index b65cdfce31ce27172d28d879559f1008b9c87320..803ac6a7516d0156ae7793ee1ff884dbbf2e20b0 100644
>> --- a/fs/overlayfs/readdir.c
>> +++ b/fs/overlayfs/readdir.c
>> @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>>          bool is_upper;
>>          bool is_whiteout;
>>          bool check_xwhiteout;
>> +       const char *cf_name;
>> +       int cf_len;
> 
> We should also change these member names to c_name
> Because they are the "compare/canonicalized" name, which
> may or may not be casefolded.
> 
>>          char name[];
>>   };
>>
>> @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>>          struct list_head *list;
>>          struct list_head middle;
>>          struct ovl_cache_entry *first_maybe_whiteout;
>> +       struct unicode_map *map;
>>          int count;
>>          int err;
>>          bool is_upper;
>> @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
>>          return rb_entry(n, struct ovl_cache_entry, node);
>>   }
>>
>> +static int ovl_casefold(struct unicode_map *map, const char *str, int len, char **dst)
>> +{
>> +       const struct qstr qstr = { .name = str, .len = len };
>> +       int cf_len;
>> +
>> +       if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len))
>> +               return 0;
>> +
>> +       *dst = kmalloc(NAME_MAX, GFP_KERNEL);
>> +
>> +       if (dst) {
>> +               cf_len = utf8_casefold(map, &qstr, *dst, NAME_MAX);
>> +
>> +               if (cf_len > 0)
>> +                       return cf_len;
>> +       }
>> +
>> +       kfree(*dst);
>> +       return 0;
>> +}
>> +
>>   static bool ovl_cache_entry_find_link(const char *name, int len,
>>                                        struct rb_node ***link,
>>                                        struct rb_node **parent)
>> @@ -79,7 +103,7 @@ static bool ovl_cache_entry_find_link(const char *name, int len,
>>
>>                  *parent = *newp;
>>                  tmp = ovl_cache_entry_from_node(*newp);
>> -               cmp = strncmp(name, tmp->name, len);
>> +               cmp = strncmp(name, tmp->cf_name, tmp->cf_len);
>>                  if (cmp > 0)
>>                          newp = &tmp->node.rb_right;
>>                  else if (cmp < 0 || len < tmp->len)
> 
> This looks like a bug - should be len < tmp->c_len
> 
>> @@ -101,7 +125,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
>>          while (node) {
>>                  struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
>>
>> -               cmp = strncmp(name, p->name, len);
>> +               cmp = strncmp(name, p->cf_name, p->cf_len);
>>                  if (cmp > 0)
>>                          node = p->node.rb_right;
>>                  else if (cmp < 0 || len < p->len)
> 
> Same here.
> 
> But it's not the only bug, because this patch regresses 3 fstests without
> enabling any casefolding:
> 

That was due to the following change:

-               cmp = strncmp(name, p->name, len);
+               cmp = strncmp(name, p->cf_name, p->cf_len);

Keeping len (instead of p->cf_len) as the third argument fixed it. I 
will send a v6 with that and the other changes.

> overlay/038 12s ...  [14:16:39] [14:16:50]- output mismatch (see
> /results/overlay/results-large/overlay/038.out.bad)
>      --- tests/overlay/038.out 2025-05-25 08:52:54.000000000 +0000
>      +++ /results/overlay/results-large/overlay/038.out.bad 2025-08-17
> 14:16:50.549367654 +0000
>      @@ -1,2 +1,3 @@
>       QA output created by 038
>      +Merged dir: Invalid d_ino reported for ..
>       Silence is golden
> 
> overlay/041 11s ...  [14:16:54] [14:17:05]- output mismatch (see
> /results/overlay/results-large/overlay/041.out.bad)
>      --- tests/overlay/041.out 2025-05-25 08:52:54.000000000 +0000
>      +++ /results/overlay/results-large/overlay/041.out.bad 2025-08-17
> 14:17:05.275206922 +0000
>      @@ -1,2 +1,3 @@
>       QA output created by 041
>      +Merged dir: Invalid d_ino reported for ..
>       Silence is golden
> 
> overlay/077 19s ...  [14:17:08][  107.348626] WARNING: CPU: 3 PID:
> 5414 at fs/overlayfs/readdir.c:677 ovl_dir_read_impure+0x178/0x1c0
> [  107.354647] ---[ end trace 0000000000000000 ]---
> [  107.399525] WARNING: CPU: 2 PID: 5415 at fs/overlayfs/readdir.c:677
> ovl_dir_read_impure+0x178/0x1c0
> [  107.406826] ---[ end trace 0000000000000000 ]---
> _check_dmesg: something found in dmesg (see
> /results/overlay/results-large/overlay/077.dmesg)
>   [14:17:28]- output mismatch (see
> /results/overlay/results-large/overlay/077.out.bad)
>      --- tests/overlay/077.out 2025-05-25 08:52:54.000000000 +0000
>      +++ /results/overlay/results-large/overlay/077.out.bad 2025-08-17
> 14:17:28.762250671 +0000
>      @@ -1,2 +1,6 @@
>       QA output created by 077
>      +getdents: Input/output error
>      +Missing created file in impure upper dir (see
> /results/overlay/results-large/overlay/077.full for details)
>      +getdents: Input/output error
>      +Found unlinked file in impure upper dir (see
> /results/overlay/results-large/overlay/077.full for details)
>       Silence is golden
> 
> Thanks,
> Amir.


