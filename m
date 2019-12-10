Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31D118C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLJPep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:34:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54015 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727407AbfLJPep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575992082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QXtqZi+Tzfb5fqvXxAZpZIZVvZQndAEpbcZuOzu7Sk=;
        b=Guo3lOAcfdfwLuTn6XC6rmkBJ3NUw9DR+/chHUTRpPRNQWNN+X8hXiZxdvJNnRAxLloue9
        zKCXC8MtK11nXjXWdAm9wyW5GAeamPAedySZzixgcT3Iliy8WlOn02zBFrkCeux+n6ixU4
        HMPSo3YG9EtbM69WX3lr0dJ/lQF3IDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-L5-0HYQeNRGENNdGyOYhvQ-1; Tue, 10 Dec 2019 10:34:41 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so9063381wrp.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 07:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0QXtqZi+Tzfb5fqvXxAZpZIZVvZQndAEpbcZuOzu7Sk=;
        b=opaB9N4zFvdd6PtFmMEDNxDWmKZOHVHG5I+nBaGA2XL2SJqFYcmPAYNubcqulbI7n8
         hwZDEmiBvDCKbRxBiMkGj+xIzDo6Yho0JdneWbcjtqoN2d54HtcsmvMjcB97fyXErw6J
         YAf0WE09MpGfwXsJJqq8q/SnAg6Ep7OfSqv93d69uKl7Uowee/vXldsS2kXh2fn75pkj
         t60IWUFxPpznPrsI7Yv9bNGNS1hbw1MEu+fdVxlgdChVAgrThENTaKJ1GuJte361hTAF
         GWgT0esQwrhFn/kGY4fGQhjM3sPpcoi4vWuRKy47+oI1GE5MSJeUZfDsHRHi1OxAQnii
         UgNg==
X-Gm-Message-State: APjAAAW2R0HA4pGZD8Rs27/EtmGAk1UmItmGG/JH0SElhUSeNm/Gd4VQ
        gtrVgDmpIEkxq8QHyJK/xMqR/PMzbHsjbrf9pfjekMtZyRS+whQlFKBxIRIjEAm1IqEJZhRu8lK
        LIQD+SFthzW0d5vC7A6jMtQt/Tg==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr5883308wmm.70.1575992080105;
        Tue, 10 Dec 2019 07:34:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/37u4i8g7Ewl4Bjg5vvBo42gOY2bkNqnUZBVl70XCyc7MpcW5hkCikG8AiAfuEBIgRESzgQ==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr5883269wmm.70.1575992079760;
        Tue, 10 Dec 2019 07:34:39 -0800 (PST)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id c1sm3623621wrs.24.2019.12.10.07.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:34:38 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v18] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20191125140839.4956-1-hdegoede@redhat.com>
 <20191125140839.4956-2-hdegoede@redhat.com>
 <20191208053350.GS4203@ZenIV.linux.org.uk>
Message-ID: <eccbf88a-f626-56f5-c313-3919dd3ab501@redhat.com>
Date:   Tue, 10 Dec 2019 16:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191208053350.GS4203@ZenIV.linux.org.uk>
Content-Language: en-US
X-MC-Unique: L5-0HYQeNRGENNdGyOYhvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Thank you for the review.

You probably know this alreayd but to be sure here is some
background info on vboxsf. vboxsf is not really a filesystem, it
is a kernel driver for VirtualBox virtual machines to access part
of the host filesystem (a Shared-Folder) in the guest.

This uses an IPC interface between the guest and the host and we
are limited to what this interface offers us, in some cases this
is not ideal, e.g. there is no locking.


On 12/8/19 6:33 AM, Al Viro wrote:
> On Mon, Nov 25, 2019 at 03:08:39PM +0100, Hans de Goede wrote:
> 
>> +	list_for_each_entry(b, &sf_d->info_list, head) {
>> +try_next_entry:
>> +		if (ctx->pos >= cur + b->entries) {
>> +			cur += b->entries;
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * Note the vboxsf_dir_info objects we are iterating over here
>> +		 * are variable sized, so the info pointer may end up being
>> +		 * unaligned. This is how we get the data from the host.
>> +		 * Since vboxsf is only supported on x86 machines this is not
>> +		 * a problem.
>> +		 */
>> +		for (i = 0, info = b->buf; i < ctx->pos - cur; i++) {
>> +			size = offsetof(struct shfl_dirinfo, name.string) +
>> +			       info->name.size;
>> +			info = (struct shfl_dirinfo *)((uintptr_t)info + size);
> 
> Yecchhh...
> 	1) end = &info->name.string[info->name.size];
> 	   info = (struct shfl_dirinfo *)end;
> please.  Compiler can and will optimize it just fine.

Ok I will rework this as you suggest for the next version.

> 	2) what guarantees the lack of overruns here?

We have checked that (ctx->pos - cur) < b->entries above,
so "i" will be limeted to the range of 0 - (b->entries - 1).

Or do you mean what guarantees that we do not overrun
b->used which is the total (used) number of bytes of the vboxsf_dir_buf?

Currently the code is trusting the host to have not filled the
vboxsf_dir_buf with nonsense and that it b->entries is accurate.

I guess we could add some checks for b->used here as an extra check.

> 
>> +{
>> +	bool keep_iterating;
>> +
>> +	for (keep_iterating = true; keep_iterating; ctx->pos += 1)
>> +		keep_iterating = vboxsf_dir_emit(dir, ctx);
> 
> Are you sure you want to bump ctx->pos when vboxsf_dir_emit() returns false?

No that seems to be a bug, thank you for catching that.

>> +static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
>> +			     umode_t mode, int is_dir)
>> +{
>> +	struct vboxsf_inode *sf_parent_i = VBOXSF_I(parent);
>> +	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
>> +	struct shfl_createparms params = {};
>> +	int err;
>> +
>> +	params.handle = SHFL_HANDLE_NIL;
>> +	params.create_flags = SHFL_CF_ACT_CREATE_IF_NEW |
>> +			      SHFL_CF_ACT_FAIL_IF_EXISTS |
>> +			      SHFL_CF_ACCESS_READWRITE |
>> +			      (is_dir ? SHFL_CF_DIRECTORY : 0);
>> +	params.info.attr.mode = (mode & 0777) |
>> +				(is_dir ? SHFL_TYPE_DIRECTORY : SHFL_TYPE_FILE);
>> +	params.info.attr.additional = SHFLFSOBJATTRADD_NOTHING;
>> +
>> +	err = vboxsf_create_at_dentry(dentry, &params);
> 
> That's... interesting.  What should happen if you race with rename of
> grandparent?  Note that *parent* is locked here; no deeper ancestors
> are.
> 
> The same goes for removals.

vboxsf_create_at_dentry (and the removal and open paths) all use
vboxsf_path_from_dentry which uses dentry_path_raw to get a path
relative to the mount-point. The vboxsf IPC interface does not have
directory-handles or some-such, so we need to do everything with a path
relative to the mount-point. dentry_path_raw() itself does check for
renames happening while it is running, but a rename could still happen
between it finishing and us passing the path to the host, in which
case the IPC call will fail with an ENOENT error.

I see 2 possible solutions for this:

1) Leave this as is, a rename can not only happen on the guest
side (which we could catch) but also on the host side, so a rename
happening while we are doing another path based operation is always
possible. IOW a user can always shoot theirselves in the foot by
doing renames while other operations are in progress.

2) Add a rename mutex to the vboxsf code and lock that around all the cases
where we do a dentry_path_raw() followed by a path based IPC call (keeping
the mutex locke during the ipc call) and also lock the mutex around renames.

I would prefer option 1. I'm open to other suggestions.

>> +static const char *vboxsf_get_link(struct dentry *dentry, struct inode *inode,
>> +				   struct delayed_call *done)
>> +{
>> +	struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);
>> +	struct shfl_string *path;
>> +	char *link;
>> +	int err;
>> +
>> +	if (!dentry)
>> +		return ERR_PTR(-ECHILD);
>> +
>> +	path = vboxsf_path_from_dentry(sbi, dentry);
>> +	if (IS_ERR(path))
>> +		return (char *)path;
> 
> ERR_CAST(path)

Ok, will fix for the next version.

> 
>> +	/** No additional information is available / requested. */
>> +	SHFLFSOBJATTRADD_NOTHING = 1,
> 
> <unprintable>
> Well, unpronounceable, actually...

This comes from the upstream VirtualBox headers defining the IPC
interface (this header in essence is a much cleaned up copy of
the official header defining the IPC interface). As such
I would prefer to keep this as is.

>> +	switch (opt) {
>> +	case opt_nls:
>> +		if (fc->purpose != FS_CONTEXT_FOR_MOUNT) {
>> +			vbg_err("vboxsf: Cannot reconfigure nls option\n");
>> +			return -EINVAL;
>> +		}
>> +		ctx->nls_name = param->string;
>> +		param->string = NULL;
> 
> Umm...  What happens if you are given several such?  A leak?

Ah yes, I did not realize a user could specify the same option more then
once I will fix this for the next version.

>> +{
>> +	int err;
>> +
>> +	err = vboxsf_setup();
>> +	if (err)
>> +		return err;
>> +
>> +	return vfs_get_super(fc, vfs_get_independent_super, vboxsf_fill_super);
> 
> 	return get_tree_nodev(fc, vboxsf_fill_super);
> please,

Ok, will fix for the next version.

>> +static int vboxsf_reconfigure(struct fs_context *fc)
>> +{
>> +	struct vboxsf_sbi *sbi = VBOXSF_SBI(fc->root->d_sb);
>> +	struct vboxsf_fs_context *ctx = fc->fs_private;
>> +	struct inode *iroot;
>> +
>> +	iroot = ilookup(fc->root->d_sb, 0);
>> +	if (!iroot)
>> +		return -ENOENT;
> 
> Huh?  If that's supposed to be root directory inode, what's wrong
> with ->d_sb->s_root->d_inode?

That is indeed better, I will fix this for the next version.
>> +	path = dentry_path_raw(dentry, buf, PATH_MAX);
>> +	if (IS_ERR(path)) {
>> +		__putname(buf);
>> +		return (struct shfl_string *)path;
> 
> ERR_CAST(path)...

Ok, will fix for the next version.

Regards,

Hans

