Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA09630E8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 12:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiKSLsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 06:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKSLsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:48:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172715F9D;
        Sat, 19 Nov 2022 03:48:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so1571619pjk.1;
        Sat, 19 Nov 2022 03:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9rax4FYMHEb547bH//upiZ4fWNtX6HGAiatJ0B5KnU=;
        b=Li+Cd9f2NbxvaipGdSKNRKGOXCqcC0A9ty2Hid1W6VAz5eMylxnedWgcyV9qekkn7T
         JCiXkaDo8STa9G2DerltgmgDi0R48Q4xoJqyosNg9x/pSZV62ooybmkJP8h4dwjvbdhW
         rt/rAvRDZMiXjpPJEqhgXI40zz+deFiGPpkWjmh/CfoUFilC6qTuK67RZ1PpKltYw3Ut
         JPUx5jt8A0nF99ma96ojCxfit1aWia6eD4BfwkPcHhBNHPb9CQhtU/d8gTMDHpzMwSSL
         qaqq1VfvyieFuthOaLvA9ONC09GJDIk7YOUI6h2i9l+N+I5q7AP6MlUzEC4wYpvXpOMu
         lOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9rax4FYMHEb547bH//upiZ4fWNtX6HGAiatJ0B5KnU=;
        b=VZlHloVWzvu5Z1d/u4hiPH0kzK634o0whPXuf1cjOlXkOUHN9wAEvCcOJIVOvTItw8
         o1YPSaeBy4R/j9SOaOY34Y7z//qZODk3HWZ9TsUhedQp1VdSBXv+bgSXkOjz1+0fwGKn
         BF9n7/BtEKAkhzRhap9PGztM5ZxDmCQL2NX8G0Mlj0dflWFm0h30Vd4z6MubddbgXnHl
         1HuuxFXhTjCGhgSIeiWRqRd8foNmovntuBqZaI83l8C7jCyXGZHRrbZAOhYTQ05VkgMl
         YKEISLJh+PlEkPsZwF0uee/udf8XF2m/cDqeDUXn3beGCiiBV4WDh8Ejv9N6fpHnbD+A
         9vbg==
X-Gm-Message-State: ANoB5pkhKiv2iSyb59Ekcqk9lG4m/sjZ6aAt0fXyxxm0rujDVzS0yk+k
        VG++w3SQ8SpPkLBnU+/x+M4=
X-Google-Smtp-Source: AA0mqf7P6jcJsjQXvLal1h/ppkR43bLZK00uIGIYM+K8pwUk5a2M3yzRQjUExDLjUVbGY/+dyYdhpg==
X-Received: by 2002:a17:90b:394e:b0:20a:6106:a283 with SMTP id oe14-20020a17090b394e00b0020a6106a283mr2037841pjb.107.1668858505491;
        Sat, 19 Nov 2022 03:48:25 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id 189-20020a6218c6000000b0056299fd2ba2sm4885404pfy.162.2022.11.19.03.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 03:48:24 -0800 (PST)
Date:   Sat, 19 Nov 2022 17:18:20 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Message-ID: <20221119114234.nnfxsqx4zxiku2h6@riteshh-domain>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com>
 <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Nayna, 

On 22/11/09 03:10PM, Nayna wrote:
> 
> On 11/9/22 08:46, Greg Kroah-Hartman wrote:
> > On Sun, Nov 06, 2022 at 04:07:42PM -0500, Nayna Jain wrote:
> > > securityfs is meant for Linux security subsystems to expose policies/logs
> > > or any other information. However, there are various firmware security
> > > features which expose their variables for user management via the kernel.
> > > There is currently no single place to expose these variables. Different
> > > platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
> > > interface as they find it appropriate. Thus, there is a gap in kernel
> > > interfaces to expose variables for security features.
> > > 
> > > Define a firmware security filesystem (fwsecurityfs) to be used by
> > > security features enabled by the firmware. These variables are platform
> > > specific. This filesystem provides platforms a way to implement their
> > >   own underlying semantics by defining own inode and file operations.
> > > 
> > > Similar to securityfs, the firmware security filesystem is recommended
> > > to be exposed on a well known mount point /sys/firmware/security.
> > > Platforms can define their own directory or file structure under this path.
> > > 
> > > Example:
> > > 
> > > # mount -t fwsecurityfs fwsecurityfs /sys/firmware/security
> > Why not juset use securityfs in /sys/security/firmware/ instead?  Then
> > you don't have to create a new filesystem and convince userspace to
> > mount it in a specific location?

I am also curious to know on why not use securityfs, given the similarity
between the two. :)
More specifics on that below...

> 
> From man 5 sysfs page:
> 
> /sys/firmware: This subdirectory contains interfaces for viewing and
> manipulating firmware-specific objects and attributes.
> 
> /sys/kernel: This subdirectory contains various files and subdirectories
> that provide information about the running kernel.
> 
> The security variables which are being exposed via fwsecurityfs are managed
> by firmware, stored in firmware managed space and also often consumed by
> firmware for enabling various security features.

That's ok. As I see it users of securityfs can define their own fileops
(like how you are doing in fwsecurityfs).
See securityfs_create_file() & securityfs_create_symlink(), can accept the fops
& iops. Except maybe securityfs_create_dir(), that could be since there might
not be a usecase for it. But do you also need it in your case is the question to
ask.

> 
> From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose of
> securityfs(/sys/kernel/security) is to provide a common place for all kernel
> LSMs. The idea of

Which was then seperated out by commit,
da31894ed7b654e2 ("securityfs: do not depend on CONFIG_SECURITY").

securityfs now has a seperate CONFIG_SECURITYFS config option. In fact I was even
thinking of why shouldn't we move security/inode.c into fs/securityfs/inode.c .
fs/* is a common place for all filesystems. Users of securityfs can call it's 
exported kernel APIs to create files/dirs/symlinks.

If we move security/inode.c to fs/security/inode.c, then...
...below call within securityfs_init() should be moved into some lsm sepecific 
file.

#ifdef CONFIG_SECURITY
static struct dentry *lsm_dentry;
static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
			loff_t *ppos)
{
	return simple_read_from_buffer(buf, count, ppos, lsm_names,
		strlen(lsm_names));
}

static const struct file_operations lsm_ops = {
	.read = lsm_read,
	.llseek = generic_file_llseek,
};
#endif

securityfs_init()

#ifdef CONFIG_SECURITY
	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
						&lsm_ops);
#endif

So why not move it? Maybe others, can comment more on whether it's a good idea 
to move security/inode.c into fs/security/inode.c? 
This should then help others identify securityfs filesystem in fs/security/ 
for everyone to notice and utilize for their use?

> fwsecurityfs(/sys/firmware/security) is to similarly provide a common place
> for all firmware security objects.
> 
> /sys/firmware already exists. The patch now defines a new /security
> directory in it for firmware security features. Using /sys/kernel/security
> would mean scattering firmware objects in multiple places and confusing the
> purpose of /sys/kernel and /sys/firmware.

We can also think of it this way that, all security related exports should 
happen via /sys/kernel/security/. Then /sys/kernel/security/firmware/ becomes 
the security related firmware exports.

If you see find /sys -iname firmware, I am sure you will find other firmware
specifics directories related to other specific subsystems
(e.g. 
root@qemu:/home/qemu# find /sys -iname firmware
/sys/devices/ndbus0/nmem0/firmware
/sys/devices/ndbus0/firmware
/sys/firmware
)

But it could be, I am not an expert here, although I was thinking a good 
Documentation might solve this problem.

> 
> Even though fwsecurityfs code is based on securityfs, since the two
> filesystems expose different types of objects and have different
> requirements, there are distinctions:
> 
> 1. fwsecurityfs lets users create files in userspace, securityfs only allows
> kernel subsystems to create files.

Sorry could you please elaborate how? both securityfs & fwsecurityfs
calls simple_fill_super() which uses the same inode (i_op) and inode file 
operations (i_fop) from fs/libfs.c for their root inode. So how it is enabling
user (as in userspace) to create a file in this filesystem?

So am I missing anything?

> 
> 2. firmware and kernel objects may have different requirements. For example,
> consideration of namespacing. As per my understanding, namespacing is
> applied to kernel resources and not firmware resources. That's why it makes
> sense to add support for namespacing in securityfs, but we concluded that
> fwsecurityfs currently doesn't need it. Another but similar example of it

It "currently" doesn't need it. But can it in future? Then why not go with
securityfs which has an additional namespacing feature available?
That's actually also the point of utilizing an existing FS which can get 
features like this in future. As long as it doesn't affect the functionality 
of your use case, we simply need not reject securityfs, no?

> is: TPM space, which is exposed from hardware. For containers, the TPM would
> be made as virtual/software TPM. Similarly for firmware space for
> containers, it would have to be something virtualized/software version of
> it.
> 
> 3. firmware objects are persistent and read at boot time by interaction with
> firmware, unlike kernel objects which are not persistent.

I think this got addressed in a seperate thread.

-ritesh
