Return-Path: <linux-fsdevel+bounces-77541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMARA9RolWm2QgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:23:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B66153A53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30CE63019F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428230E0E9;
	Wed, 18 Feb 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Ghshd05L";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="K2jQOvbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316B29994B;
	Wed, 18 Feb 2026 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399369; cv=none; b=YG6/D20/L72BPUNpDpTpRFSgzQRENfvclHk5+RBhucaSUrmRdKeKRzIwrQ/H7JsFHG0MCKp650cz/aKfYgwziQHdxvCFAwCiSZ0WXmKgxKuReo/TRmgsqhyFTzsZH05UXjzuJIO4yQ9eIM0jlngSNjxBK6Pq/aJ9QQC1DDUvntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399369; c=relaxed/simple;
	bh=ckG1pT/mwO/hIbdHUc0Xko/AXSkG68y6JAn19SISK9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1ENCnEo93WrflD/jCxJb7hyN3/bSYvg7CbcOnujf3tuB5XrfEoqxudCIyqd7TUIR46YwQ+8bJrwNjS6w+GeMYcAzDdRH4zR3kSOy/sP7gwmEvLpp3ZVmjfKLA6mW0NAXQ/DF5EzVYfYsNmiyQouyRHdLcEnWJxfqP19uwMiA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Ghshd05L; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=K2jQOvbM; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4AA2F209655A;
	Wed, 18 Feb 2026 16:22:38 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1771399358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5/PMnfZTcYIrO+eVzQJRqlO0Isnkv9LR1mTCFLwYws=;
	b=Ghshd05LVbaa4QRkLjYyZfku2TFXb1yBqKr32ofpD2rEj4KoSKeQaOzfb5GWPif1zNORlp
	wYZFGgDzyTYiaQrJwCgFJ9ioUMfi+TQwkE02vscu9+1SZYizyOhSPoUR5NAQ3FVdvUn7H/
	iIKcvswRQUSuIelZEv+EVWy6P+QdgqI/SQ/sxMgg4bSO/rA3AWWtmMNABET8ffJfiEyRJu
	bVGyusI0Rj8cuzyoB6MlVcWRhrT0DcNiM8bRzr+1Teo22VCyup4RurZqOhde+UFgj79IER
	tjcoUzCg3B29wa71VHBSoJPZNLwU8/d4ntm7vMvcRudZrFQj7qoG7IPb6XIO/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1771399358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5/PMnfZTcYIrO+eVzQJRqlO0Isnkv9LR1mTCFLwYws=;
	b=K2jQOvbMTgVsR/C78+0XtkSCuTgLt69Tol7WtB09s+l2CRTNJh9Tot8LsCmzbxBJv+cdoS
	T+abvWjAl9fVxcBQ==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 61I7MajW100446
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 16:22:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 61I7Ma8t329097
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 16:22:36 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.2/8.18.2/Submit) id 61I7MZPo329096;
	Wed, 18 Feb 2026 16:22:35 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
In-Reply-To: <20260217230628.719475-3-ethan.ferguson@zetier.com>
References: <20260217230628.719475-1-ethan.ferguson@zetier.com>
	<20260217230628.719475-3-ethan.ferguson@zetier.com>
Date: Wed, 18 Feb 2026 16:22:35 +0900
Message-ID: <871piifrd0.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mail.parknet.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[parknet.co.jp:s=20250114,parknet.co.jp:s=20250114-ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77541-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[parknet.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[hirofumi@mail.parknet.co.jp,linux-fsdevel@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.parknet.co.jp:mid,zetier.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 61B66153A53
X-Rspamd-Action: no action

Ethan Ferguson <ethan.ferguson@zetier.com> writes:

> Add support for writing to the volume label of a FAT filesystem via the
> FS_IOC_SETFSLABEL ioctl.
>
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
> ---
>  fs/fat/dir.c         | 51 +++++++++++++++++++++++++++++++++++
>  fs/fat/fat.h         |  6 +++++
>  fs/fat/file.c        | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/fat/inode.c       | 15 +++++++++++
>  fs/fat/namei_msdos.c |  4 +--
>  5 files changed, 137 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 07d95f1442c8..1b11713309ae 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1425,3 +1425,54 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(fat_add_entries);
> +
> +static int fat_create_volume_label_dentry(struct super_block *sb, char *vol_label)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	struct inode *root_inode = sb->s_root->d_inode;
> +	struct msdos_dir_entry de;
> +	struct fat_slot_info sinfo;
> +	struct timespec64 ts = current_time(root_inode);
> +	__le16 date, time;
> +	u8 time_cs;
> +
> +	memcpy(de.name, vol_label, MSDOS_NAME);
> +	de.attr = ATTR_VOLUME;
> +	de.starthi = de.start = de.size = de.lcase = 0;
> +
> +	fat_time_unix2fat(sbi, &ts, &time, &date, &time_cs);
> +	de.time = time;
> +	de.date = date;
> +	if (sbi->options.isvfat) {
> +		de.cdate = de.adate = date;
> +		de.ctime = time;
> +		de.ctime_cs = time_cs;
> +	} else
> +		de.cdate = de.adate = de.ctime = de.ctime_cs = 0;
> +
> +	return fat_add_entries(root_inode, &de, 1, &sinfo);
> +}
> +
> +int fat_rename_volume_label_dentry(struct super_block *sb, char *vol_label)
> +{
> +	struct inode *root_inode = sb->s_root->d_inode;
> +	struct buffer_head *bh = NULL;
> +	struct msdos_dir_entry *de;
> +	loff_t cpos = 0;
> +	int err = 0;
> +
> +	while (1) {
> +		if (fat_get_entry(root_inode, &cpos, &bh, &de) == -1)
> +			return fat_create_volume_label_dentry(sb, vol_label);
> +
> +		if (de->attr == ATTR_VOLUME) {
> +			memcpy(de->name, vol_label, MSDOS_NAME);
> +			mark_buffer_dirty_inode(bh, root_inode);
> +			if (IS_DIRSYNC(root_inode))
> +				err = sync_dirty_buffer(bh);
> +			brelse(bh);
> +			return err;
> +		}
> +	}

I didn't check how to know the label though, the label is only if
ATTR_VOLUME? IOW, any other attributes are disallowed?

What if label is marked as deleted?

I'm not sure though, no need to update timestamps? (need to investigate
spec or windows behavior)

> +static int fat_convert_volume_label_str(struct msdos_sb_info *sbi, char *in,
> +					char *out)
> +{
> +	int ret, in_len = max(strnlen(in, FSLABEL_MAX), 11);
> +	char *needle;

Silently truncate is the common way for this ioctl?

> +	/*
> +	 * '.' is not included in any bad_chars list in this driver,
> +	 * but it is specifically not allowed for volume labels
> +	 */
> +	for (needle = in; needle - in < in_len; needle++)
> +		if (*needle == '.')
> +			return -EINVAL;

memchr() or such?

> +	ret = msdos_format_name(in, in_len, out, &sbi->options);
> +	if (ret)
> +		return ret;

> +	/*
> +	 * msdos_format_name assumes we're translating an 8.3 name, but
> +	 * we can handle 11 chars
> +	 */
> +	if (in_len > 8)
> +		ret = msdos_format_name(in + 8, in_len - 8, out + 8,
> +					&sbi->options);
> +	return ret;

fat module should not import msdos module.

> +static int fat_ioctl_set_volume_label(struct super_block *sb, char __user *arg)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	struct inode *root_inode = sb->s_root->d_inode;
> +	char from_user[FSLABEL_MAX];
> +	char new_vol_label[MSDOS_NAME];
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (sb_rdonly(sb))
> +		return -EROFS;
> +
> +	if (copy_from_user(from_user, arg, FSLABEL_MAX))
> +		return -EFAULT;
> +
> +	ret = fat_convert_volume_label_str(sbi, from_user, new_vol_label);
> +	if (ret)
> +		return ret;
> +
> +	inode_lock(root_inode);
> +	ret = fat_rename_volume_label_dentry(sb, new_vol_label);
> +	inode_unlock(root_inode);
> +	if (ret)
> +		return ret;

This rename will have to take same or similar locks with rename(2)?

> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 6f9a8cc1ad2a..a7528937383b 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -736,6 +736,21 @@ static void delayed_free(struct rcu_head *p)
>  static void fat_put_super(struct super_block *sb)
>  {
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	struct buffer_head *bh = NULL;
> +	struct fat_boot_sector *bs;
> +
> +	bh = sb_bread(sb, 0);
> +	if (bh == NULL)
> +		fat_msg(sb, KERN_ERR, "unable to read boot sector");
> +	else if (!sb_rdonly(sb)) {
> +		bs = (struct fat_boot_sector *)bh->b_data;
> +		if (is_fat32(sbi))
> +			memcpy(bs->fat32.vol_label, sbi->vol_label, MSDOS_NAME);
> +		else
> +			memcpy(bs->fat16.vol_label, sbi->vol_label, MSDOS_NAME);
> +		mark_buffer_dirty(bh);
> +	}
> +	brelse(bh);

Why this unconditionally update the vol_label at unmount?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

