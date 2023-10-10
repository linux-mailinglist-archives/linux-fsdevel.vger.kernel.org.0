Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1E7C020B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjJJQzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjJJQzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:55:20 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC28E;
        Tue, 10 Oct 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V2QzVKR6NnbDqxtaY+D9qdeGyiCbjRysyT5wl9T3ReM=; b=IsG0+Kt98e/CJGkI/DTSxhI3k3
        VPl4cpmROzlgivr6xRRKw2YykVAEZ/EJ8wO2Y/m8CFtisgcKM3XLdG25iwT4LoFGwIiZfa1m3lVul
        RDbx0WqKPtDlKVYNV4E7OLJme6ryK2xc817i/w4afHopttrecQxY79y/SXwHtYe7sveJnLnNZnZVd
        1e9du1w0CbOOR7OhfkyCYxBxg6S3IOLAglYmC2OAW1+X0YL2/JhjLNbLSwWAimZ7p/kWmrSgeWCQi
        WrBrQrwYaFDsdf9yi6uPGkvCc3Ord5gjNxAkz5nZ9g4iL0Q5AkhrG9T4QnqEEtI2YVw/CPdPTX0XR
        AMEAy0Tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqG0e-0000Gp-35;
        Tue, 10 Oct 2023 16:55:05 +0000
Date:   Tue, 10 Oct 2023 17:55:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231010165504.GP800259@ZenIV>
References: <20231009153712.1566422-1-amir73il@gmail.com>
 <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > Sorry, you asked about ovl mount.
> > To me it makes sense that if users observe ovl paths in writable mapped
> > memory, that ovl should not be remounted RO.
> > Anyway, I don't see a good reason to allow remount RO for ovl in that case.
> > Is there?
> 
> Agreed.
> 
> But is preventing remount RO important enough to warrant special
> casing of backing file in generic code?  I'm not convinced either
> way...

You definitely want to guarantee that remounting filesystem r/o
prevents the changes of visible contents; it's not just POSIX,
it's a fairly basic common assumption about any local filesystems.

Whether that should affect generic code...  You could do what CODA does,
I suppose; call ->mmap() of underlying file, then copy the resulting
->vm_ops into your private structure and override ->close() there
(keeping the original elsewhere in the same structure).  Then your
->close() would call the original and drop write access on the
ovl mount explicitly taken in your ->open().

*IF* we go that way, we probably ought to provide a ->get_path()
method for VMAs (NULL meaning "take ->vm_file->f_path") and use
that in procfs accesses.  That could reduce the impact on generic
code pretty much to zero - FMODE_BACKING included.

But it would cost you an allocation of vm_operations_struct per
mmap, most of them almost identical ;-/  And merging would not be
trivial - CODA stores a reference to original ->vm_file in
that structure, and uses container_of() to get to it in
their ->close().  AFAICS, there's no other safe place to stash
that information in anywhere in vm_area_struct.
