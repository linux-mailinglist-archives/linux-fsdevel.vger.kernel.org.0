Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA70438742D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347547AbhERIjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347546AbhERIj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 04:39:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F787C061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 01:38:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y32so6489713pga.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IsQfm8chUVW8ruU/zwByxDAGkqSQlL5HqkqOWaarZV8=;
        b=ukKsxtmbByI4qezd83ECTisfNU/W3KX1341Kq8mn/bXYGJIQFF5FVFs6ml6etvOWnM
         P4Y6opKG3OzR7KUZDDRCr8FgTcikK4OgoE/WdDTxu0dFJ9Kej3iPNHcBd3Bbn3sN/tkJ
         /+Tv2uunokVukXMQePMGBC1+TrnTjgksMOu4eDzYQNZ1+v01YfTdNIOydFkNbEBBpE0H
         GEctc769XK+UcZoMpylKZKlVI77NKgBjYH8nwpW5+ya0X1+oAWPvzlk0nZp91KR+4KVJ
         P/IOGS6kSlB1J3h6rHZDrARrdUYXbA7byXCDPJGUwqXZ3dkTsxU5K0u64vxTK7VNvH7V
         waLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IsQfm8chUVW8ruU/zwByxDAGkqSQlL5HqkqOWaarZV8=;
        b=FopMd22ZyDXem+iO7ltjMcfbHvQRyN5dm9yff28g9JCfTwXH5TI/BWwKwGiYk70p3s
         ZH4XxhSp51nLq5DZlnWsfBqmV8g5MZQWn6n8UfNXnRl0wTDiXNSbzFxH8EbrkLfnPoD0
         n014RqKc3kMEGkAyA6BdujlUvddU+vHyd5BzbIcDIC4o6ba4wIupoJ0pGq0msO1oyZX7
         JHDSbdSK5YCY3YtqE2SRbrwAYunTcM/0muZ1HM5PU3BkU6hgeItWjbPQco0qfRrGAFyy
         uC4a968Iix6Gy5RKkvOBxB1g5f9NpDAMqDr4zxvnBhsRNPfJ3sAbrsqoe2RVWOWattO4
         Tq4w==
X-Gm-Message-State: AOAM530uCNvAySwoB5xC5SSCRYI4DRNCVlGuTn20IkUKGKQXXWeuqoY8
        p3JveaLfn4yRservin2H8eoEJA==
X-Google-Smtp-Source: ABdhPJwq2DvEeYKKKsKEj0GvuM/V84fu3u6/yO05LFfNBw62ZDKXiiHqOcm4KC2CB68fvJt8JakOeQ==
X-Received: by 2002:a63:f651:: with SMTP id u17mr3960422pgj.300.1621327090512;
        Tue, 18 May 2021 01:38:10 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::1e58])
        by smtp.gmail.com with ESMTPSA id n21sm4279949pfu.99.2021.05.18.01.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 01:38:09 -0700 (PDT)
Date:   Tue, 18 May 2021 01:38:08 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YKN88AbnmW73uRPw@relinquished.localdomain>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
 <YKLt5GyznttizBjd@relinquished.localdomain>
 <YKLyvnb19QmayJaJ@gmail.com>
 <YKL7W7QO7Wis2n8a@relinquished.localdomain>
 <YKMsHMS4IfO8PhN1@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKMsHMS4IfO8PhN1@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 10:53:16PM -0400, Theodore Y. Ts'o wrote:
> On Mon, May 17, 2021 at 04:25:15PM -0700, Omar Sandoval wrote:
> > > Well, assuming we're talking about regular files only (so file contents
> > > encryption, not filenames encryption),
> > 
> > Yes, I was thinking of regular files. File operations using encrypted
> > names sounds... interesting, but I think out of scope for this.
> 
> So the question I have is why would you want to get the raw encrypted
> data?  One possible reason (and this is what Michael Halwcrow and I
> had tried designing years ago) was so you could backup a device that
> had multiple users' files without having all of the users' keys ---
> and then be able to restore them.  So for example, suppose you had a
> tablet that is shared by multiple family members, and you want to be
> backup all of the data on the shared device so that it could be
> restored in case one of the kids drop the tablet in the swimming pool....
> 
> But in order to do that, you need to be able to restore the encrypted
> files in the encrypted directories.  In practice, encrypted files
> generally exist in encrypted directories.  That's because the typical
> way fscrypt gets used is we set a policy on an empty directory, and
> then all of the newly files created files have encrypted file names,
> inherit the directory's encryption policy, and then have encrypted
> file contents.
> 
> So do you have the encryption key, or not?  If you do have the
> encryption key, then you can ignore the issue of the file name when
> you open the file, but what's the reason why you would want to extract
> out the raw encrypted data plus the raw encryption metadata?  You're
> not going to be able to restore the encrypted file, in the encrypted
> directory name.  Perhaps it's because you want to keep the data
> encrypted while you're tranferring it --- but the filename needs to be
> encrypted as well, and given modern CPU's, with or without
> inline-crypto engines, the cost of decrypting the file data and then
> re-encrypting it in the backup key isn't really that large.
> 
> If you don't have the encryption key, then you need to be able to open
> the file using using the encrypted name (which fscrypt does support)
> and then extract out the encrypted file name using another bundle of
> encryption metadata.  So that's a bit more complicated, but it's
> doable.
> 
> The *really* hard part is *restoring* an encrypted directory
> hierarchy.  Michael and I did create a straw design proposal (which is
> too small to fit in the margins of this e-mail :-), but suffice it to
> say that the standard Posix system calls are not sufficient to be able
> to create encrypted files and encrypted directories, and it would have
> been messy as all hell.  Which is why we breathed a sign of relief
> when the original product requirement of being able to do
> backup/restore of shared devices went away.   :-)
> 
> The thing is, though, just being able to extract out regular files in
> their raw encrypted on-disk form, along with their filename metadata,
> seems to be a bit of a party trick without a compelling use case that
> I can see.  But perhaps you have something in mind?

Thanks for the detailed response, Ted. I personally don't have a use
case for reading and writing encrypted data. I only care about skipping
compression/decompression, but early on it was pointed out that this API
could potentially also be used for encrypted data. The question at this
point is: if someone else comes along and solves the problems with
restoring encrypted filenames, is this interface enough for them to
restore the encrypted file data? It seems like the answer is yes, with a
couple of additions to fscrypt. I should've been clearer that I don't
have concrete plans to do this, I just wanted to leave the door open for
it so that we don't need a second, very similar interface.

Thanks,
Omar
