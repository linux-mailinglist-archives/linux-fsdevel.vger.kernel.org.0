Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23283386DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbhEQX0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 19:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhEQX0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 19:26:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2AC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 16:25:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b21so4055927plz.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bFFfy9yk3m/QXROnTT4QRmPFgG5jO1tT2Y3M0OVwiRw=;
        b=1651g/hihCdmqRw8X6kAmIF7yXxYroCCzBjygFmnY8Lz/EFaqdQqhFtIi/CThv6vKn
         A0cI8rZTGwJj28SaYPo27fdRcfli/aTuSE5Ka2Y8L187qyn6fpmYRrF+OAmQkHKzZpL9
         OLejYi3rzrBJmCuUjNVnjWTo9Ag0USyr1ivODD2tnVuaM/ZZou+cm+hRANfWcQKh9cjs
         MQ1Y6sJPoMmnLLT3MpSxA9y6ge1RWoXwxqUnsI7gUEwD6Rmcs/C7RZ44HH9ior31EvHN
         J0OR4Lr7h3ZoR9VeLV8MUSh3uSU6aU19my3odhiUs/M7XYnsU1D3bHmo8RLbqboyqVeP
         /ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bFFfy9yk3m/QXROnTT4QRmPFgG5jO1tT2Y3M0OVwiRw=;
        b=MNr3YIG28DJS6gTKlcUPaaut+opJFBzoukjoWuh9tBmQYcSWDrwg4Ymbu5TFO5ugoZ
         54FRT2S+mP2Saqo/x4Wq6XFXnmL8h2mY0tn7kCF9MIeY5WfDyhcXePwzMKSGk7huTUgE
         iLgoh7iibpl5aOIBq9w5pH55kp/HOOUvi54XSf0GjDtlH6T17zx/gcP0j75d7d+nUyyL
         H5ogpP6Z76rU1bFWC2czDK5I8G1//C8+H+nu2QkOp0TDl3o5fJw2Jus7li8z7BE1z8EJ
         5EvPip1m7yka7yvxMaRTq0j5MuKOyBBk36p8v5LELTio6TVFQIfdOPb+hUmdyvU8Kt/T
         YV/w==
X-Gm-Message-State: AOAM530lqbYuQs6up3cOA5XOzUtn3MwnX52z8R3wrXxTTtk4wuBT7tUF
        SuJWB3XA9nKq4drpTWGnOv5WVg==
X-Google-Smtp-Source: ABdhPJyzg9OFeGXKPdmPRtuD7qWtQw+6QYm2rOELNvfJz3QocKkdDTzGU95k0au+O0Y4ClZu9uLuzg==
X-Received: by 2002:a17:902:d4c6:b029:ef:80f3:c543 with SMTP id o6-20020a170902d4c6b02900ef80f3c543mr1042732plg.85.1621293917798;
        Mon, 17 May 2021 16:25:17 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:19a9])
        by smtp.gmail.com with ESMTPSA id g20sm3965432pfj.146.2021.05.17.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:25:16 -0700 (PDT)
Date:   Mon, 17 May 2021 16:25:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
Message-ID: <YKL7W7QO7Wis2n8a@relinquished.localdomain>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
 <YKLt5GyznttizBjd@relinquished.localdomain>
 <YKLyvnb19QmayJaJ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKLyvnb19QmayJaJ@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 03:48:30PM -0700, Eric Biggers wrote:
> On Mon, May 17, 2021 at 03:27:48PM -0700, Omar Sandoval wrote:
> > On Mon, May 17, 2021 at 02:32:47PM -0700, Linus Torvalds wrote:
> > > On Mon, May 17, 2021 at 11:35 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > >
> > > > Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
> > > > are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
> > > > patch 9 adds Btrfs encoded write support.
> > > 
> > > I don't love the RWF_ENCODED flag, but if that's the way people think
> > > this should be done, as a model this looks reasonable to me.
> > > 
> > > I'm not sure what the deal with the encryption metadata is. I realize
> > > there is currently only one encryption type ("none") in this series,
> > > but it's not clear how any other encryption type would actually ever
> > > be described. It's not like you can pass in the key (well, I guess
> > > passing in the key would be fine, but passing it back out certainly
> > > would not be).  A key ID from a keyring?
> > > 
> > > So there's presumably some future plan for it, but it would be good to
> > > verify that that plan makes sense..
> > 
> > What I'm imagining for fscrypt is:
> > 
> > 1. Add ENCODED_IOV_ENCRYPTION_* types for fscrypt. Consumers at least
> >    need to be able to distinguish between encryption policy versions,
> >    DIRECT_KEY policies, and IV_INO_LBLK_{64,32} policies, and maybe
> >    other details.
> > 2. Use RWF_ENCODED only for the data itself.
> > 3. Add new fscrypt ioctls to get and set the encryption key.
> > 
> > The interesting part is (3). If I'm reading the fscrypt documentation
> > correctly, in the default mode, each file is encrypted with a per-file
> > key that is a function of the master key for the directory tree and a
> > per-file nonce.
> > 
> > Userspace manages the master key, we have a FS_IOC_GET_ENCRYPTION_NONCE
> > ioctl, and the key derivation function is documented. So, userspace
> > already has all of the pieces it needs to get the encryption key, and
> > all of the information it needs to decrypt the data it gets from
> > RWF_ENCODED if it so desires.
> > 
> > On the set/write side, the user can set the same master key and policy
> > with FS_IOC_SET_ENCRYPTION_POLICY, and we'd need something like an
> > FS_IOC_SET_ENCRYPTION_NONCE ioctl (possibly with a requirement that it
> > be set when the file is empty). I think that's it.
> > 
> > The details will vary for the other fscrypt policies, but that's the
> > gist of it. I added the fscrypt maintainers to correct me if I missed
> > something.
> > 
> 
> Well, assuming we're talking about regular files only (so file contents
> encryption, not filenames encryption),

Yes, I was thinking of regular files. File operations using encrypted
names sounds... interesting, but I think out of scope for this.

> with fscrypt the information needed to
> understand a file's encrypted data is the following:
> 
> 1. The encryption key
> 
> 2. The filesystem's block size
> 
> 3. The encryption context:
> 
>     struct fscrypt_context_v2 {                                                      
>          u8 version; /* FSCRYPT_CONTEXT_V2 */                                     
>          u8 contents_encryption_mode;                                             
>          u8 filenames_encryption_mode;                                            
>          u8 flags;                                                                
>          u8 __reserved[4];                                                        
>          u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];                   
>          u8 nonce[FSCRYPT_FILE_NONCE_SIZE];                                       
>     };                                                                               
> 
>    (Or alternatively struct fscrypt_policy_v2 + the nonce field separately;
>     that results in the same fields as struct fscrypt_context_v2.)
> 
> This is definitely more complex than the compression cases like "the data is a
> zlib stream".  So the question is, how much of this metadata (if any) should
> actually be passed around during RWF_ENCODED pread/pwrite operations, and how
> much should be out-of-band.
> 
> I feel like this should be mostly out-of-band (e.g. via the existing ioctls
> FS_IOC_{GET,SET}_ENCRYPTION_POLICY), especially given that compression and
> encryption could be combined which would make describing the on-disk data even
> more difficult.
> 
> But I'm not sure what you intended.

Okay, I think we're in agreement: RWF_ENCODED for the data and separate
ioctls for the encryption context. Since the fscrypt policy struct
includes all of the relevant information, RWF_ENCODED can probably just
have a single ENCODED_IOV_ENCRYPTION_FSCRYPT encryption type.
RWF_ENCODED can express data which is both compressed and encrypted, so
that should be fine as well.

The only other missing piece that I see (other than filesystem support)
is an FS_IOC_SET_ENCRYPTION_NONCE ioctl. Would such an interface be
reasonable?
