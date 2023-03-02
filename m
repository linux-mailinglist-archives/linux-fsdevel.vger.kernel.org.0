Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB44B6A88D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCBTCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBTCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:02:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC3193F3;
        Thu,  2 Mar 2023 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lpBNVR74iubjvON2wguO4B8ttWa6FZ0mrtSI3Z/IcA8=; b=rL03dt7h2WxlaKHIIhcEPhjJxg
        bn28ifI4tDnDJLbkFxlRtgBxfHTWBCn3JNL/d67e3Qek5xAdY9QlEWOeA2rtKVd8FI/HWCLZtWTA3
        bBEGr74fT+YeSYz6BKm1vQQc7m1zT7oZ+Kr6ixxkfHdmgsp2m5+pEkOvmTBTUWAe7EnQQC92qcCWw
        0/b6MbJRr2vvy0BChdIuu5UlRVaKuRNo3giHvqq8i1e3Qi2J/3v5fUzuris51tvCvNdQuRFNrcQkp
        R8v4jASZ7AcFUyk97Ebmvr/yK3LI1XZyQEPz67Mw38spqI95ibMVF2ht8IY4n+Ui+ynvR4fDbv8cA
        Gw530wDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXoBv-00DNPR-05;
        Thu, 02 Mar 2023 19:02:11 +0000
Date:   Thu, 2 Mar 2023 19:02:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZADysodnEPRqhKqc@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <ZADuWxU963sInrj/@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADuWxU963sInrj/@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:43:39PM +0000, Al Viro wrote:
> On Thu, Mar 02, 2023 at 07:22:17PM +0100, Mateusz Guzik wrote:
> 
> > Ops, I meant "names_cache", here:
> > 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
> > 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
> > 
> > it is fs/dcache.c and I brainfarted into the above.
> 
> So you mean __getname() stuff?

The thing is, getname_flags()/getname_kernel() is not the only user of that
thing; grep and you'll see (and keep in mind that cifs alloc_dentry_path()
is a __getname() wrapper, with its own callers).  We might have bugs papered
over^W^Whardened away^W^Wpapered over in some of those users.

I agree that getname_flags()/getname_kernel()/sys_getcwd() have no need of
pre-zeroing; fw_get_filesystem_firmware(), ceph_mdsc_build_path(),
[hostfs]dentry_name() and ima_d_path() seem to be safe.  So's
vboxsf_path_from_dentry() (I think).  But with this bunch I'd need
a review before I'd be willing to say "this security theatre buys us
nothing here":

fs/cifs/cifsproto.h:67: return __getname();
fs/exfat/dir.c:195:     nb->lfn = __getname();
fs/fat/dir.c:287:               *unicode = __getname();
fs/fat/namei_vfat.c:598:        uname = __getname();
fs/ntfs3/dir.c:394:     name = __getname();
fs/ntfs3/inode.c:1289:  new_de = __getname();
fs/ntfs3/inode.c:1694:  de = __getname();
fs/ntfs3/inode.c:1732:  de = __getname();
fs/ntfs3/namei.c:71:    struct cpu_str *uni = __getname();
fs/ntfs3/namei.c:286:   de = __getname();
fs/ntfs3/namei.c:355:   struct cpu_str *uni = __getname();
fs/ntfs3/namei.c:494:   uni = __getname();
fs/ntfs3/namei.c:555:   uni1 = __getname();
fs/ntfs3/xattr.c:532:   buf = __getname();

fs/cifs/cifs_dfs_ref.c:168:     page = alloc_dentry_path();
fs/cifs/cifsacl.c:1697: page = alloc_dentry_path();
fs/cifs/cifsacl.c:1760: page = alloc_dentry_path();
fs/cifs/cifsproto.h:65:static inline void *alloc_dentry_path(void)
fs/cifs/dir.c:187:      void *page = alloc_dentry_path();
fs/cifs/dir.c:604:      page = alloc_dentry_path();
fs/cifs/dir.c:664:      page = alloc_dentry_path();
fs/cifs/file.c:594:     page = alloc_dentry_path();
fs/cifs/file.c:796:     page = alloc_dentry_path();
fs/cifs/file.c:2223:    void *page = alloc_dentry_path();
fs/cifs/file.c:2255:    void *page = alloc_dentry_path();
fs/cifs/inode.c:1663:   page = alloc_dentry_path();
fs/cifs/inode.c:1938:   page = alloc_dentry_path();
fs/cifs/inode.c:2001:   void *page = alloc_dentry_path();
fs/cifs/inode.c:2170:   page1 = alloc_dentry_path();
fs/cifs/inode.c:2171:   page2 = alloc_dentry_path();
fs/cifs/inode.c:2446:   page = alloc_dentry_path();
fs/cifs/inode.c:2738:   void *page = alloc_dentry_path();
fs/cifs/inode.c:2893:   void *page = alloc_dentry_path();
fs/cifs/ioctl.c:34:     void *page = alloc_dentry_path();
fs/cifs/link.c:491:     page1 = alloc_dentry_path();
fs/cifs/link.c:492:     page2 = alloc_dentry_path();
fs/cifs/misc.c:803:     page = alloc_dentry_path();
fs/cifs/readdir.c:1071: void *page = alloc_dentry_path();
fs/cifs/smb2ops.c:2059: void *page = alloc_dentry_path();
fs/cifs/xattr.c:112:    page = alloc_dentry_path();
fs/cifs/xattr.c:277:    page = alloc_dentry_path();
fs/cifs/xattr.c:382:    page = alloc_dentry_path();
