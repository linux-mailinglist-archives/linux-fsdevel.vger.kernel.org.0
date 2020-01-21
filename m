Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D61446D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 23:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAUWF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 17:05:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43318 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgAUWF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:05:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so2192553pfo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHL1t/EyEsW/kDCQVsvBnpYeqWiiNR3Qofvm72VP2xo=;
        b=b+DkuJVKIKETrJ5dpTxidfDLzDLkavoiNLhArG3sMhvs1V6c3puRQUI9pG9KRYRWPd
         8fRSkviBHz+tFzxp4t+VfIOdI/jgi3sJ8Vewc009gojBVO6V1BECgJK5222fsEzQXJQm
         wbAnTgKeIHbOU4Tr5RKZqicWx20WuZ71yUO7sN1kR4zsn3mD7Zznv4+GsRhRluFNXZeS
         DWYSw9vYZzXEm7IIrBEuVWdlXIRxeFhGVZcjpgT2fJKpY4FFj1SMuLJIJkxJTe5YPqoE
         FIMd1Y6nmyaf6ERoXAdUmhkH+AVj9CIIhltvG0/65sNQMh+6F+GSHDHh8Fzlp3CXn/CF
         WCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHL1t/EyEsW/kDCQVsvBnpYeqWiiNR3Qofvm72VP2xo=;
        b=JMav85gnvaDuuRZDyvZLzNNi2X8sWCCfVbYLIPtMg5rbk0Ni3ckUh4C/jAXGqUo/68
         HYVJm949boR6DgDkrvyHXFLJS/HLhM5YM7cvDX4o5QeXUJCQg1W7uCJRQ9NOBu4/+o9Y
         7EvSWc77jQ2FqMJp0QueGa+OOk8/HcqAgz5nIPjK95FXYWeKta2ctRhghH/T20XGk6Id
         XSm24DbNSdOBa4KP3A0rTFnDQbETUmAogg288Clpn4wBf505DdEqj5d8Pq6NxFTptfHS
         oh4H3HN21AALI/JBCZt+tlIiI7RD7EHrLZvdsWvQIW1pWkb+NfIrY/AE4W0FxiFaEdk7
         NG8g==
X-Gm-Message-State: APjAAAU4NjQglOSkP5iqsSPsIccM2lRzRy4CarK4JGvjph2CZ2brr8Ze
        QHZ3nAA1afp5hG9/n4iHGbBItQ==
X-Google-Smtp-Source: APXvYqwh8OnW+eP9V0DrV7fz7N0b2aotldt8ipMvaida+/kr2JuRziMzbgGUGDkawpb/E1PWbTxPyg==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr7771059pgc.90.1579644327592;
        Tue, 21 Jan 2020 14:05:27 -0800 (PST)
Received: from google.com ([2620:15c:201:0:7f8c:9d6e:20b8:e324])
        by smtp.gmail.com with ESMTPSA id a16sm41620400pgb.5.2020.01.21.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:05:27 -0800 (PST)
Date:   Tue, 21 Jan 2020 14:05:22 -0800
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20200121220522.GA243816@google.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
 <20191218212116.GA7476@magnolia>
 <yq1y2v9e37b.fsf@oracle.com>
 <20191218222726.GC47399@gmail.com>
 <yq1fthhdttv.fsf@oracle.com>
 <20200108140730.GC2896@infradead.org>
 <20200108172629.GA232722@sol.localdomain>
 <20200117083221.GA324@infradead.org>
 <20200118051132.GC3290@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118051132.GC3290@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 09:11:32PM -0800, Eric Biggers wrote:
> On Fri, Jan 17, 2020 at 12:32:21AM -0800, Christoph Hellwig wrote:
> > 
> > File systems don't move data around all that often (saying that with my
> > fs developer hat on).  In traditional file systems only defragmentation
> > will move data around, with extent refcounting it can also happen for
> > dedup, and for file systems that write out of place data gets moved
> > when parts of a block are rewritten, but in that case a read modify
> > write cycle is perfomed in the Linux code anyway, so it will go through
> > the inline encryption engined on the way and the way out.
> > 
> > So in other words - specifying an IV would be useful for some use cases,
> > but I don't think it is a deal blocker. Even without that is is useful
> > for block device level encryption, and could have some usefulness for
> > file system encryption usage.
> > 
> > I think that adding an IV would eventually be useful, but fitting that
> > into NVMe won't be easy, as you'd need to find a way to specify the IV
> > for each submission queue entry, which requires growing it, or finding
> > some way to extend it out of band.
> 
> Sure, people have even done inline crypto on ext4 before (downstream), using the
> LBA for the IV.  But log-structured filesystems like f2fs move data blocks
> around *without the encryption key*; and at least for fscrypt, f2fs support is
> essential.  In any case it's also awkward having the physical on-disk location
> determine the ciphertext on-disk, as then the result isn't fully controlled by
> the encryption settings you set, but also based on where your filesystem is
> located on-disk (with extra fun occurring if there's any sort of remapping layer
> in between).  But sure, it's not *useless* to not be able to specify the IV,
> it's just annoying and less useful.
> 
> [I was also a bit surprised to see that NVMe won't actually allow specify the
> IV, as I thought you had objected to the naming of the INLINE_CRYPT_OPTIMIZED
> fscrypt policy flag partly on the grounds that NVMe would support IVs longer
> than the 64 bits that UFS is limited to.  Perhaps I misunderstood though.]
> 
> > > So let's not over-engineer this kernel patchset to support some broken
> > > vaporware, please.
> > 
> > Not sharing bio fields for integrity and encryption actually keeps
> > the patchset simpler (although uses more memory if both options are
> > enabled).  So my main point here is to not over engineer it for broken
> > premise that won't be true soon.
> 
> Well there are 3 options:
> 
> (a) Separate fields for bi_crypt_context and bi_integrity
> (b) bi_crypt_context and bi_integrity in union
> (c) One pointer that can support both features,
>     e.g. linked list of tagged structs.
> 
> It sounds like you're advocating for (a), but I had misunderstood and thought
> you're advocating for (c).  We'd of course be fine with (a) as it's the
> simplest, but other people are saying they prefer (b).
> 
> Satya, to resolve this I think you should check how hard (b) is to implement --
> i.e. is it easy, or is it really tricky to ensure the features are never used
> together?  (Considering that it's probably not just a matter of whether any
> hardware supports both features, as dm-integrity supports blk-integrity in
> software and blk-crypto-fallback supports blk-crypto in software.)
> 
> - Eric

What I have right now for v7 of the patch series was my attempt at (b) (since
some were saying they prefer it) - it may still be incomplete though because I
missed something, but here's what I think it involved:

1) bi_crypt_context is never set after bi_integrity, so I don't check if
   bi_integrity is set or not when setting bi_crypt_context - this keeps the
   code cleaner when setting the bi_crypt_context.

2) I made it error whenever we try to set bi_integrity on a bio with
   REQ_BLK_CRYPTO.

3) There is an issue with the way the blk-crypto-fallback interacts with bio
   integrity. One of the goals of the fallback is to make it inline encryption
   transparent to the upper layers (i.e. as far as the upper layers are
   concerned there should be no difference whether there is actual hardware
   inline encryption support or whether the fallback is used instead).

   The issue is, when the fallback encrypts a bio, it clones the bio and
   encrypts the pages in the clone, but the clone won't have a bi_crypt_context
   (since otherwise, when the clone is resubmitted, blk-crypto would incorrectly
   assume that the clone needs to be encrypted once again). When bi_integrity is
   set on the clone, there won't be any error detected since REQ_BLK_CRYPTO
   won't be set on the clone. However, if hardware inline encryption support had
   been present, and the blk-crypto had not used the fallback, the same bio
   would have bi_crypt_context set when we try to set bi_integrity, which would
   then fail.

   To fix this issue, I introduced another flag REQ_NO_SPECIAL (subject to being
   renamed when I think of/someone suggests a better name), which when set on
   the bio, indicates that bi_integrity (and in future whatever other fields
   share the same union, shouldn't be set on that bio. I can probably do away
   with the new flag and just set REQ_BLK_CRYPTO and also set
   bi_crypt_context = NULL to signify the same thing, but either way, it doesn't
   seem like a very clean solution to me.

4) I don't think there's actually an issue with dm-integrity as long as when we
   add support for inline encryption to dm, we ensure that if any of the child
   targets is dm-integrity, then the dm device says it doesn't support any
   crypto mode. This way, encryption is always consistently done before
   integrity calculation, which is always consistently done before decryption
   (and when dm-integrity is not using the internal hash, then the bio will fail
   because of (2), but this is still consistent whether or not hardware inline
   encryption support is present.

However, even if we decide to do (a), I'll still need to ensure that when bio
integrity and blk-crypto are used together, the results are consistent
regardless of whether hardware inline crypto support is present. So I either
disallow bio integrity to be used with blk-crypto, in which case I'll need to
do something similar to what I had to do in (3) like introduce REQ_NO_SPECIAL
and we also lose the advantage of not having the two fields shared in a union,
or I allow them to be used together while ensuring consistent results by
maybe doing something like forcing blk-crypto to fallback to the crypto API
whenever the target device for a bio has a bio integrity profile (and whatever
checks are done in bio_integrity_prep).

So I'm not sure if (a) is a lot easier or cleaner. But unlike (b), (a)
does give us the option of using the two features together....if it seems
likely that we'll want to use both these features together at some point,
then maybe I should switch back to (a), and for now just disallow the two
features from being used together since that's still easier than trying to get
them both to work together, and once we know for sure that we want to use both
together, we can make the necessary additions then?
