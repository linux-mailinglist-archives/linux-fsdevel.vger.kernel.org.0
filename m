Return-Path: <linux-fsdevel+bounces-77591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P4EMYPilWliVwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:02:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D2F157900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 939EA300E5BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C834107C;
	Wed, 18 Feb 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="WdZnOpHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5D344059
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430504; cv=none; b=MhBvUwAe4Z6NmnJO8IJ7POhysAO0aLeEKsGd6W4uX+n7l5ZeSj1lSoLQd5YZLOOw7druvwkdgMOR/vTOyI3hian5QPfUxiGcPQuif+zkbhVDApjlWEnCv7N/7kTYDyplUrHM6TCrnYyICNPwyQhLZmxWaFKobMBvFSRIyn8KbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430504; c=relaxed/simple;
	bh=MgV2LzGE2tnVbJO/Rz8MR6RGZPmFaJ8fiTRY57hhD/Y=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=b7ZRaIBeJHUtyx2jLcthkdQpB6c55BqQ4hsd3XiJeYXUf2S+xyYa1mvITsRjMxwA+a2zhnHc709DDaNJjaQ63Y/CLk+er2dl5Oef0RtQ6C6FY7iY+pi0FFra8n1NMalD8a2l4t0wDnswS9wobX1Rr3qzM/hlbAGdzranv9WzIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=WdZnOpHU; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5fc4220b0acso1194292137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771430501; x=1772035301; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODhbjXy6wk3D2HE0/UrjwI8BxjlEgTnz/AVFGc7F1Sw=;
        b=WdZnOpHUym0pzuVxhXO9BK5XBNIh5hhsjKEyAmGAoANw0sdgatX9xzObnXyVgkFlqd
         awlzMXYEIIXEr5cvCYXk6zd5I+LV/k44xfsQhybHETrhBx4JfW6zniHWP9kwjVbCqZx3
         wFR0MkKwMqdcU7K5JhPMJJscamSRMhpzIHIeuE0f354RX0R8innsRQM87R+PMwnRJHbI
         RzONP2TMKcYEyjYDo4ZVcIXe1rYsAtbVs2WBtmj1O+lnmjELTVlsQPXjJrivP/eOd+pn
         0elqw1Mfx568mKA/Hzzkj+5NWlhuFqvwCgsoocT+5lMN1bDmPOb3dVW2QooPpq0vEm1V
         lS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430501; x=1772035301;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODhbjXy6wk3D2HE0/UrjwI8BxjlEgTnz/AVFGc7F1Sw=;
        b=GGjyu8t2IVDQH7GUaNiBldrdqbxG14X3wv4kXAAG+MHJRnUyrnIizSzEw4fmFNX5/y
         bbRigJRwZOB8OyDkomo1VcO9PTOatWGkM7yXb56NR6fmoaUfbOajqodFSbVJS4RqXbO+
         AFPR36S0v+5+lKHJBfb8hVGDq3TCsTvL/Ctncvz9ELeQAKOFARbL1gRcQjdJ6GU5D7sQ
         w+bKeJMkCd2lUTBrPcCqvQPdEM3DYzzRX2Ui2L8LxxLFqiEuI6W5EbfOYfm4oBrh4faM
         UieIeFWQ0657hSs8reumLTtu7vKZ+gDgLKMQdN4a3atas9BQMNROSlA3+wf3HyhCxdeF
         lwrQ==
X-Gm-Message-State: AOJu0Yw50XB/pyiPnc8azfCoVkF70eYkQGIEu1OeujucvNavqFL+0qcX
	qKpf4QFxINfQn1yoGf3qvEnnho60eBATvNDHJ2uGoYkYCXwfmuaN7eW8oIjJXSLiC5s=
X-Gm-Gg: AZuq6aJVYcKKbWElj0w9EZuF471K6kh63bwazt/mH5Q6fRtrODGsBQI/anzaDmD/k4N
	oUhOxd2i/i2EIaFiL0CwfeExkvXi3NCX0eQnk4uyrpU5r9fH/LLwgE0fixs6HnE0+bdanGtl+pH
	FSHtGxZkjUbud8aAmmd30GCx+4jyA9SmyicLFwTroprQzkEuVpDVulj53vrz+ojWHPFI0nhknBJ
	3z7kL3VwPsH7fu+vm46r+s9F3y0pMiCQD7i1KxPEgAaNAspNFXiUNl21QFrbTdKbn1HxCAlAgIr
	hk1z7AtBR064Xx3Z2yi8IEZvir5j5ufZOj5tfOZypJiF/6K3WkXN1p5YjyE25vl7eJmxOAZ0jaW
	QJj103iA5xaw9BPTIup85F8oFWC+QU++0vhqpf9fi6OqB4C7KP5SBHF1+xkrBKPJDnJAgKy5IHl
	No03UT/Yu/BmPrkxVc+0ix/yH8+HoNJkyUxyFG8vurMPY3V5j0sI4iKVYx++DZDQ==
X-Received: by 2002:a05:6102:50a4:b0:5fd:eff4:825 with SMTP id ada2fe7eead31-5fe2aed01aamr4964089137.26.1771430496954;
        Wed, 18 Feb 2026 08:01:36 -0800 (PST)
Received: from smtpclient.apple ([2600:382:7e03:34fb:b0eb:9f57:81ff:5d84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7d7csm1865031285a.27.2026.02.18.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ethan Ferguson <ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Message-Id: <594BF488-47D8-498F-9777-7E48F6997F5E@zetier.com>
Date: Wed, 18 Feb 2026 11:01:25 -0500
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
To: Hirofumi OGAWA <hirofumi@mail.parknet.co.jp>
X-Mailer: iPhone Mail (23C71)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77591-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	APPLE_IOS_MAILER_COMMON(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,de.date:url,zetier.com:mid,zetier.com:dkim,zetier.com:email,parknet.co.jp:email]
X-Rspamd-Queue-Id: 84D2F157900
X-Rspamd-Action: no action

=EF=BB=BF
> On Feb 18, 2026, at 02:22, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wr=
ote:
>=20
> =EF=BB=BFEthan Ferguson <ethan.ferguson@zetier.com> writes:
>=20
>> Add support for writing to the volume label of a FAT filesystem via the
>> FS_IOC_SETFSLABEL ioctl.
>> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
>> ---
>> fs/fat/dir.c         | 51 +++++++++++++++++++++++++++++++++++
>> fs/fat/fat.h         |  6 +++++
>> fs/fat/file.c        | 63 ++++++++++++++++++++++++++++++++++++++++++++
>> fs/fat/inode.c       | 15 +++++++++++
>> fs/fat/namei_msdos.c |  4 +--
>> 5 files changed, 137 insertions(+), 2 deletions(-)
>> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
>> index 07d95f1442c8..1b11713309ae 100644
>> --- a/fs/fat/dir.c
>> +++ b/fs/fat/dir.c
>> @@ -1425,3 +1425,54 @@ int fat_add_entries(struct inode *dir, void *slots=
, int nr_slots,
>>  return err;
>> }
>> EXPORT_SYMBOL_GPL(fat_add_entries);
>> +
>> +static int fat_create_volume_label_dentry(struct super_block *sb, char *=
vol_label)
>> +{
>> +    struct msdos_sb_info *sbi =3D MSDOS_SB(sb);
>> +    struct inode *root_inode =3D sb->s_root->d_inode;
>> +    struct msdos_dir_entry de;
>> +    struct fat_slot_info sinfo;
>> +    struct timespec64 ts =3D current_time(root_inode);
>> +    __le16 date, time;
>> +    u8 time_cs;
>> +
>> +    memcpy(de.name, vol_label, MSDOS_NAME);
>> +    de.attr =3D ATTR_VOLUME;
>> +    de.starthi =3D de.start =3D de.size =3D de.lcase =3D 0;
>> +
>> +    fat_time_unix2fat(sbi, &ts, &time, &date, &time_cs);
>> +    de.time =3D time;
>> +    de.date =3D date;
>> +    if (sbi->options.isvfat) {
>> +        de.cdate =3D de.adate =3D date;
>> +        de.ctime =3D time;
>> +        de.ctime_cs =3D time_cs;
>> +    } else
>> +        de.cdate =3D de.adate =3D de.ctime =3D de.ctime_cs =3D 0;
>> +
>> +    return fat_add_entries(root_inode, &de, 1, &sinfo);
>> +}
>> +
>> +int fat_rename_volume_label_dentry(struct super_block *sb, char *vol_lab=
el)
>> +{
>> +    struct inode *root_inode =3D sb->s_root->d_inode;
>> +    struct buffer_head *bh =3D NULL;
>> +    struct msdos_dir_entry *de;
>> +    loff_t cpos =3D 0;
>> +    int err =3D 0;
>> +
>> +    while (1) {
>> +        if (fat_get_entry(root_inode, &cpos, &bh, &de) =3D=3D -1)
>> +            return fat_create_volume_label_dentry(sb, vol_label);
>> +
>> +        if (de->attr =3D=3D ATTR_VOLUME) {
>> +            memcpy(de->name, vol_label, MSDOS_NAME);
>> +            mark_buffer_dirty_inode(bh, root_inode);
>> +            if (IS_DIRSYNC(root_inode))
>> +                err =3D sync_dirty_buffer(bh);
>> +            brelse(bh);
>> +            return err;
>> +        }
>> +    }
>=20
> I didn't check how to know the label though, the label is only if
> ATTR_VOLUME? IOW, any other attributes are disallowed?
I'm pretty sure ATTR_VOLUME is disallowed except for:
* Volume labels, where it is the only flag present
* Long file name entries, where it is /not/ the only flag present
This is why I check if attr =3D=3D ATTR_VOLUME, not attr & ATTR_VOLUME
> What if label is marked as deleted?
As far as I know, a Volume label can never be marked as deleted, but if you w=
ant me to change the behavior of my patch, just let me know how you would li=
ke me to handle it and I'd be happy to change it.
> I'm not sure though, no need to update timestamps? (need to investigate
> spec or windows behavior)
It's not in the spec that I know either, I'm happy to remove if you deem thi=
s unnecessary.
>> +static int fat_convert_volume_label_str(struct msdos_sb_info *sbi, char *=
in,
>> +                    char *out)
>> +{
>> +    int ret, in_len =3D max(strnlen(in, FSLABEL_MAX), 11);
>> +    char *needle;
>=20
> Silently truncate is the common way for this ioctl?
When I implemented this in exfat, I returned -EINVAL for names that were lon=
ger than allowed, but only after converting from nls to UTF16. I can copy th=
is behavior here as well.
>=20
>> +    /*
>> +     * '.' is not included in any bad_chars list in this driver,
>> +     * but it is specifically not allowed for volume labels
>> +     */
>> +    for (needle =3D in; needle - in < in_len; needle++)
>> +        if (*needle =3D=3D '.')
>> +            return -EINVAL;
>=20
> memchr() or such?
Noted, will use, thanks.
>> +    ret =3D msdos_format_name(in, in_len, out, &sbi->options);
>> +    if (ret)
>> +        return ret;
>=20
>> +    /*
>> +     * msdos_format_name assumes we're translating an 8.3 name, but
>> +     * we can handle 11 chars
>> +     */
>> +    if (in_len > 8)
>> +        ret =3D msdos_format_name(in + 8, in_len - 8, out + 8,
>> +                    &sbi->options);
>> +    return ret;
>=20
> fat module should not import msdos module.
Fair. How would you implement checking the validity of the new volume label?=

>=20
>> +static int fat_ioctl_set_volume_label(struct super_block *sb, char __use=
r *arg)
>> +{
>> +    struct msdos_sb_info *sbi =3D MSDOS_SB(sb);
>> +    struct inode *root_inode =3D sb->s_root->d_inode;
>> +    char from_user[FSLABEL_MAX];
>> +    char new_vol_label[MSDOS_NAME];
>> +    int ret;
>> +
>> +    if (!capable(CAP_SYS_ADMIN))
>> +        return -EPERM;
>> +
>> +    if (sb_rdonly(sb))
>> +        return -EROFS;
>> +
>> +    if (copy_from_user(from_user, arg, FSLABEL_MAX))
>> +        return -EFAULT;
>> +
>> +    ret =3D fat_convert_volume_label_str(sbi, from_user, new_vol_label);=

>> +    if (ret)
>> +        return ret;
>> +
>> +    inode_lock(root_inode);
>> +    ret =3D fat_rename_volume_label_dentry(sb, new_vol_label);
>> +    inode_unlock(root_inode);
>> +    if (ret)
>> +        return ret;
>=20
> This rename will have to take same or similar locks with rename(2)?
Sure, so should I only lock on sbi->s_lock through the whole function?
>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>> index 6f9a8cc1ad2a..a7528937383b 100644
>> --- a/fs/fat/inode.c
>> +++ b/fs/fat/inode.c
>> @@ -736,6 +736,21 @@ static void delayed_free(struct rcu_head *p)
>> static void fat_put_super(struct super_block *sb)
>> {
>>  struct msdos_sb_info *sbi =3D MSDOS_SB(sb);
>> +    struct buffer_head *bh =3D NULL;
>> +    struct fat_boot_sector *bs;
>> +
>> +    bh =3D sb_bread(sb, 0);
>> +    if (bh =3D=3D NULL)
>> +        fat_msg(sb, KERN_ERR, "unable to read boot sector");
>> +    else if (!sb_rdonly(sb)) {
>> +        bs =3D (struct fat_boot_sector *)bh->b_data;
>> +        if (is_fat32(sbi))
>> +            memcpy(bs->fat32.vol_label, sbi->vol_label, MSDOS_NAME);
>> +        else
>> +            memcpy(bs->fat16.vol_label, sbi->vol_label, MSDOS_NAME);
>> +        mark_buffer_dirty(bh);
>> +    }
>> +    brelse(bh);
>=20
> Why this unconditionally update the vol_label at unmount?
I can add a dirty bit to msdos_sb_info, and only write if it's present.
> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

