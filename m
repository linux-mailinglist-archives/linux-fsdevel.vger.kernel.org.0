Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DA358FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFEIup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 04:50:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37690 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFEIuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:50:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so4661250eds.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 01:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SPhbPJ47CtSYCBTvHx6NT8w22SsIwvmm0sTowytpOvY=;
        b=b4hAMc3cyhUVrpfO056HUsqANIDNtOJzNIxYmUjg3kFL6ivJcG9d5x9jYQ6mj/Okqj
         bYbGDAN5JmEHsYp7cjELKeZ4XDR6lxAIkBEXSRt3YEddmYUAY+rn26HAqwM2FbwDBLn2
         gDYhRD0HK8PtizAVlZQZTGo6Yidpxb7V0WhoQ0CLOvQG/lPPmPgLnOq2PBdhGSoyVXYX
         Gz2khrcvdmlOyI/2cv4QmA4ePF8peqN6n82MV9RSpMmio6sIGMCWuITUHjLAM35sb7SE
         OUhgI9ieiZ5fTTw9kfnlX/qm28JMfuMJWTlWCJXVb3pcslkTfJGODSAt6rOBg3S928+n
         QAyw==
X-Gm-Message-State: APjAAAV6CRD4rh0tXU0nucDEpQH2WcHZT2W/gQCtX9iqP+ifcIWcewVe
        KQ1SCxE3er3fbbXs5ZEk4Ya9HoJBSWw=
X-Google-Smtp-Source: APXvYqwUPIdyPgk5MNMujXygGEaMPAPqOsDfvm7cUFqVgOw78DlBgsGUutTNtZO9IiuMa08ATzEC3Q==
X-Received: by 2002:a17:906:7ad8:: with SMTP id k24mr4165175ejo.188.1559724641771;
        Wed, 05 Jun 2019 01:50:41 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c10sm1555297edk.80.2019.06.05.01.50.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:50:41 -0700 (PDT)
Subject: Re: [PATCH v10] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20190418100412.19016-2-hdegoede@redhat.com>
 <20190418100412.19016-1-hdegoede@redhat.com>
 <19229.1559051752@warthog.procyon.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8828673a-7107-dfd7-86fb-0837863a510d@redhat.com>
Date:   Wed, 5 Jun 2019 10:50:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <19229.1559051752@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Thank you for the review.

On 28-05-19 15:55, David Howells wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> +	params.create_flags = 0
>> +	    | SHFL_CF_DIRECTORY
>> +	    | SHFL_CF_ACT_OPEN_IF_EXISTS
>> +	    | SHFL_CF_ACT_FAIL_IF_NEW | SHFL_CF_ACCESS_READ;
> 
> The 0 here would seem to be superfluous.  Also, most common practice in the
> kernel would put the binary operator at the end of the preceding line.

Ack, will fix for the next version.

>> +/**
>> + * This is called when reference count of [file] goes to zero. Notify
>> + * the host that it can free whatever is associated with this directory
>> + * and deallocate our own internal buffers
>> + * Return: 0 or negative errno value.
>> + * @inode	inode
>> + * @file	file
>> + */
>> +static int sf_dir_release(struct inode *inode, struct file *file)
> 
> I'm pretty certain most of your kdoc comments are invalid, but I could be
> wrong.  Shouldn't this be:
> 
> 	/**
> 	 * name_of_function - Brief description
> 	 * @arg1: Summary arg 1
> 	 * @arg2: Summary arg 2
> 	 * @arg3: Summary arg 3
> 	 *
> 	 * Description...
> 	 */
> 	type name_of_function(type arg1, type arg2, type arg3)
> 	{
> 		...
> 	}

Right, this code is derived from the out of tree vboxsf code from
VirtualBox upstream, which uses doxygen comments. I did not want to
just rip the comments out so I've tried to convert them to kerneldoc
style (note no docs are built from them). But you are right, my
conversion is incomplete. I will fix this for the next version.

>> +static int sf_get_d_type(u32 mode)
> 
> unsigned int would be preferable, I think.

Ack, will fix for the next version.

>> + * Return: 0 or negative errno value.
>> ...
>> +static int sf_getdent(struct file *dir, loff_t pos,
>> +		      char d_name[NAME_MAX], int *d_type)
>> ...
>> +	return 1;
> 
> The return value is not concordant with the function description.

Ack, will fix for the next version.

>> + * This is called when vfs wants to populate internal buffers with
>> + * directory [dir]s contents.
> 
> I would say "the directory" rather than "directory [dir]s".  It's fairly
> obvious what the definite article refers to in this case.
> 
>> [opaque] is an argument to the
>> + * [filldir]. [filldir] magically modifies it's argument - [opaque]
>> + * and takes following additional arguments (which i in turn get from
>> + * the host via sf_getdent):
> 
> opaque and filldir no longer exist.
> 
>> + * name : name of the entry (i must also supply it's length huh?)
>> + * type : type of the entry (FILE | DIR | etc) (i ellect to use DT_UNKNOWN)
>> + * pos : position/index of the entry
>> + * ino : inode number of the entry (i fake those)
> 
> I would indent these more (use a tab after the '*' rather than a space).

Right this comment has become a bit stale, will fix.

>> +		/* d_name now contains a valid entry name */
>> +		sanity = ctx->pos + 0xbeef;
>> +		fake_ino = sanity;
>> +		/*
>> +		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
>> +		 * unsigned so fake_ino may overflow, check for this.
>> +		 */
>> +		if (sanity - fake_ino) {
> 
> Ugh.  Why '0xbeef'?  Why not '1'?  I wonder if:
> 
> 	if ((ino_t)(ctx->pos + 1) != (unsigned long long)(ctx->pos + 1))
> 
> would work.

Yes I believe that that should work fine, will fix.

>> +/* Query mappings changes. */
>> +#define SHFL_FN_QUERY_MAPPINGS      (1)
>> +/* Query mappings changes. */
>> +#define SHFL_FN_QUERY_MAP_NAME      (2)
>> ...
> 
> Enumify?

Ack, will fix.

>> +#define SHFL_ROOT_NIL ((u32)~0)
> 
> UINT_MAX?
> 
>> +#define SHFL_HANDLE_NIL  ((u64)~0LL)
> 
> ULONGLONG_MAX?

ULLONG_MAX, otherwise ack, will fix both.


>> +/** Shared folder filesystem properties. */
>> +struct shfl_fsproperties {
>> ...
>> +};
>> +VMMDEV_ASSERT_SIZE(shfl_fsproperties, 12);
> 
> Should this be __packed given the size assertion?

AFAICT packing it would give it a size of 10, 4 for
the u32 + 6 bytes for the bools. So I'm keeping this
as is.

>> +static const match_table_t vboxsf_tokens = {
>> +	{ opt_nls, "nls=%s" },
>> +	{ opt_uid, "uid=%u" },
>> +	{ opt_gid, "gid=%u" },
>> +	{ opt_ttl, "ttl=%u" },
>> +	{ opt_dmode, "dmode=%o" },
>> +	{ opt_fmode, "fmode=%o" },
>> +	{ opt_dmask, "dmask=%o" },
>> +	{ opt_fmask, "fmask=%o" },
>> +	{ opt_error, NULL },
>> +};
> 
> This needs converting to the new mount API.  See:
> 
> 	Documentation/filesystems/mount_api.txt
> 
>> +	if (options[0] == VBSF_MOUNT_SIGNATURE_BYTE_0 &&
>> +	    options[1] == VBSF_MOUNT_SIGNATURE_BYTE_1 &&
>> +	    options[2] == VBSF_MOUNT_SIGNATURE_BYTE_2 &&
>> +	    options[3] == VBSF_MOUNT_SIGNATURE_BYTE_3) {
>> +		vbg_err("vboxsf: Old binary mount data not supported, remove obsolete mount.vboxsf and/or update your VBoxService.\n");
>> +		return -EINVAL;
>> +	}
> 
> This bit should go in your ->parse_monolithic() method.

Ok, I will start working on converting it to the new mount
API and once that is done and tested I will post a new version.

Regards,

Hans
