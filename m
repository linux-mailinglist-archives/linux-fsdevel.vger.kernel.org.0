Return-Path: <linux-fsdevel+bounces-28853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C496F79D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181241C246D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765331D2783;
	Fri,  6 Sep 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PRouuDsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC941C8FBC;
	Fri,  6 Sep 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634831; cv=none; b=M5c+cAxUcxnzIp7IJZb+Ac6Uc8TIYdxU6sdoxND2EbljePbGy8BcTvQQR5lcEWWlYvUXuucprLUjk4UVj3+ib13rN5miJlkPbk07p1U06U6XpIPW9CDlNvjD+o9+MC6kfOqzCcv+CryoYk6+fETHe+qapxpyCAvwnMQLQwpngwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634831; c=relaxed/simple;
	bh=0FnpEeuepLhQGRiA70+XCzLxb478a2ds5lQAg2Lk0bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJzIFD55C5k5VcKdbiSsOqy/4UPPWPf0LrmZyQCREvye2k14Hjop2q6gi+XpuKKJMIBRUfmjgr/NSe94n1texw17rzwQeIrptFaXMsgS09hX5CL0jqeZypsUJVn2OmZTJVSFxi05ALMoaL8R99qRJpaIMmD30o49xEe/JGK6sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PRouuDsq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4o4UfI0GEDOQr5RG64NMJaSJ5pP4AubwmneRtbCDzTQ=; b=PRouuDsqCRkgONmplqQkjV5F3S
	0RiIWVrm9DidqQqzUiYGHlr6ODRdFYBYuFnem4iep4nCyHyyrmeT6sIB82UXaXXligTQH31ANshlf
	qykkMoOHUogYgUJFG6hvfuqUJjK+luIz8RhvlGVoow4r3LCw9jVvTxtRqR3i/fB6RC8SZ1raE5eZJ
	sIUzIXNHcSGPvESNzMDMFBrQFT20MKCE6T8gMR8EUImJs2judv7LxsWWPQP8lEOU/2TGI7WKSVQJi
	itE9loG0KWlM9RZDTtCjwsoUJoLTstZoenOO6Q0wPP1v3V/eh3OFhJUKFdQIu31oRY6gcA5qSzk/k
	AhHWbW7Q==;
Received: from [179.218.15.202] (helo=[192.168.1.105])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1smaRI-00ASen-5t; Fri, 06 Sep 2024 16:59:56 +0200
Message-ID: <956192d3-5fb8-4ecc-8625-a34812df537b@igalia.com>
Date: Fri, 6 Sep 2024 11:59:45 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] tmpfs: Add casefold lookup support
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 krisman@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
 Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
 Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
 <20240905190252.461639-7-andrealmeid@igalia.com>
 <87zfoln622.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87zfoln622.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey!

On 9/5/24 18:28, Gabriel Krisman Bertazi wrote:
> Hi,
>
> André Almeida <andrealmeid@igalia.com> writes:
>> @@ -3427,6 +3431,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   
>> +	if (IS_ENABLED(CONFIG_UNICODE))
>> +		if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
>> +			return -EINVAL;
>> +
> if (IS_ENABLED(CONFIG_UNICODE) &&
>      generic_ci_validate_strict_name(dir, &dentry->d_name))
>
>>   static const struct constant_table shmem_param_enums_huge[] = {
>> @@ -4081,9 +4111,62 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>>   	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
>>   	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit),
>>   #endif
>> +	fsparam_string("casefold",	Opt_casefold_version),
>> +	fsparam_flag  ("casefold",	Opt_casefold),
>> +	fsparam_flag  ("strict_encoding", Opt_strict_encoding),
> I don't know if it is possible, but can we do it with a single parameter?

I tried, but when you use casefold with no args, the code fails 
somewhere before that, claiming that there's no arg.

>> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
>> +				    bool latest_version)
> Instead of the boolean, can't you check if param->string != NULL? (real
> question, I never used fs_parameter.
>
>> +{
>> +	struct shmem_options *ctx = fc->fs_private;
>> +	unsigned int maj = 0, min = 0, rev = 0, version = 0;
>> +	struct unicode_map *encoding;
>> +	char *version_str = param->string + 5;
>> +	int ret;
> unsigned int version = UTF8_LATEST;
>
> and kill the if/else below:
>> +
>> +	if (latest_version) {
>> +		version = UTF8_LATEST;
>> +	} else {
>> +		if (strncmp(param->string, "utf8-", 5))
>> +			return invalfc(fc, "Only UTF-8 encodings are supported "
>> +				       "in the format: utf8-<version number>");
>> +
>> +		ret = utf8_parse_version(version_str, &maj, &min, &rev);
> utf8_parse_version interface could return UNICODE_AGE() already, so we hide the details
> from the caller. wdyt?

I like it!

>
>> +		if (ret)
>> +			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
>> +
>> +		version = UNICODE_AGE(maj, min, rev);
>> +	}
>> +
>> +	encoding = utf8_load(version);
>> +
>> +	if (IS_ERR(encoding)) {
>> +		if (latest_version)
>> +			return invalfc(fc, "Failed loading latest UTF-8 version");
>> +		else
>> +			return invalfc(fc, "Failed loading UTF-8 version: %s", version_str);
> The following covers both legs (untested):
>
> if (IS_ERR(encoding))
>    return invalfc(fc, "Failed loading UTF-8 version: utf8-%u.%u.%u\n"",
> 	           unicode_maj(version), unicode_min(version), unicode_rev(version));
>
>> +	if (latest_version)
>> +		pr_info("tmpfs: Using the latest UTF-8 version available");
>> +	else
>> +		pr_info("tmpfs: Using encoding provided by mount
>> options: %s\n", param->string);
> The following covers both legs (untested):
>
> pr_info (fc, "tmpfs: Using encoding : utf8-%u.%u.%u\n"
>           unicode_maj(version), unicode_min(version), unicode_rev(version));
>
>> +
>> +	ctx->encoding = encoding;
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
>> +				    bool latest_version)
>> +{
>> +	return invalfc(fc, "tmpfs: No kernel support for casefold filesystems\n");
>> +}
> A message like "Kernel not built with CONFIG_UNICODE" immediately tells
> you how to fix it.
>
>> @@ -4515,6 +4610,16 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	}
>>   	sb->s_export_op = &shmem_export_ops;
>>   	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
>> +
>> +#if IS_ENABLED(CONFIG_UNICODE)
>> +	if (ctx->encoding) {
>> +		sb->s_encoding = ctx->encoding;
>> +		generic_set_sb_d_ops(sb);
> This is the right place for setting d_ops (see the next comment), but you
> should be loading generic_ci_always_del_dentry_ops, right?
>
> Also, since generic_ci_always_del_dentry_ops is only used by this one,
> can you move it to this file?
>
>> +static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
>> +{
>> +	const struct dentry_operations *d_ops = &simple_dentry_operations;
>> +
>> +#if IS_ENABLED(CONFIG_UNICODE)
>> +	if (dentry->d_sb->s_encoding)
>> +		d_ops = &generic_ci_always_del_dentry_ops;
>> +#endif
> This needs to be done at mount time through sb->s_d_op. See
>
> https://lore.kernel.org/all/20240221171412.10710-1-krisman@suse.de/
>
> I suppose we can do it at mount-time for
> generic_ci_always_del_dentry_ops and simple_dentry_operations.
>
>> +
>> +	if (dentry->d_name.len > NAME_MAX)
>> +		return ERR_PTR(-ENAMETOOLONG);
>> +
>> +	if (!dentry->d_sb->s_d_op)
>> +		d_set_d_op(dentry, d_ops);
>> +
>> +	/*
>> +	 * For now, VFS can't deal with case-insensitive negative dentries, so
>> +	 * we prevent them from being created
>> +	 */
>> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
>> +		return NULL;
> Thinking out loud:
>
> I misunderstood always_delete_dentry before.  It removes negative
> dentries right after the lookup, since ->d_delete is called on dput.
>
> But you still need this check here, IMO, to prevent the negative dentry
> from ever being hashed. Otherwise it can be found by a concurrent
> lookup.  And you cannot drop ->d_delete from the case-insensitive
> operations too, because we still wants it for !IS_CASEFOLDED(dir).
>
> The window is that, without this code, the negative dentry dentry would
> be hashed in d_add() and a concurrent lookup might find it between that
> time and the d_put, where it is removed at the end of the concurrent
> lookup.
>
> All of this would hopefully go away with the negative dentry for
> casefolded directories.
>
>> +
>> +	d_add(dentry, NULL);
>> +
>> +	return NULL;
>> +}
> The sole reason you are doing this custom function is to exclude negative
> dentries from casefolded directories. I doubt we care about the extra
> check being done.  Can we just do it in simple_lookup?

So, in summary:

* set d_ops at mount time to generic_ci_always_del_dentry_ops
* use simple_lookup(), get rid of shmem_lookup()
* inside of simple_lookup(), add (IS_CASEFOLDED(dir)) return NULL

Right?

>> +
>>   static const struct inode_operations shmem_dir_inode_operations = {
>>   #ifdef CONFIG_TMPFS
>>   	.getattr	= shmem_getattr,
>>   	.create		= shmem_create,
>> -	.lookup		= simple_lookup,
>> +	.lookup		= shmem_lookup,
>>   	.link		= shmem_link,
>>   	.unlink		= shmem_unlink,
>>   	.symlink	= shmem_symlink,
>> @@ -4791,6 +4923,8 @@ int shmem_init_fs_context(struct fs_context *fc)
>>   	ctx->uid = current_fsuid();
>>   	ctx->gid = current_fsgid();
>>   
>> +	ctx->encoding = NULL;
>> +
>>   	fc->fs_private = ctx;
>>   	fc->ops = &shmem_fs_context_ops;
>>   	return 0;

