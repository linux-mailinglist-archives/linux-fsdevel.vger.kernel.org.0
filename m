Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383E22B7894
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKRI1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKRI1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:27:12 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC574C061A4D
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 00:27:11 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id w8so1186946ilg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6JSsnASGEEmmT+0rR4JRK2MhDJx5jdve6OEXE7gcBvM=;
        b=l2yITOMclwmXPKygoSWHT2HzHx7wmsUB1Dwd9kGhZVxWkbR0z+ZpU5FZUoupcoaxdk
         yz9n7IfBx88to5kg6d3hT+/cMhVD7a+Y/qzyjaw44RI2fG4D4mPJX43oZI1UL87Ypn7k
         DhkG5kBmIMM56nN/HwIsk0YvqP41MLVa4b8xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6JSsnASGEEmmT+0rR4JRK2MhDJx5jdve6OEXE7gcBvM=;
        b=GQIO7Yfsx4ymYTR3CycGpfU892O28ucSsZ9qAL3A+sfaYVD8DmT6PFDc+aWdTwH7Kl
         GIxsJVVUj289m2HOB0iano1ts6ydPeuXMakHj4tDN4JLDBcX5SDu1BxqDw6Y9xBJHB34
         a9vWItrD+dSw/sfgloKpNwBswq+kNTWRQjPQsso7gpdzbBoUJdg7aP84009eM3jpLCMU
         d3T5I7mmeUwxWkP+icBZVbs/R+JLULVgcWEJ2K30SFIygFO/54lFaXLDTMd7S44E+XzZ
         YDVJQSX8281Rrz6zpsg1vA2Pv0Q6VCCPLoMetu5Bq1WNNBVpvynm73s9w0ekrobwL/GC
         0Zig==
X-Gm-Message-State: AOAM530boqhyx64bbkBUDYayzXeVPER7y7zyKVOXph5AWhENh67DozKK
        i44W7fWtyusbx6L+LKgmvZnCcA==
X-Google-Smtp-Source: ABdhPJxkzHDHxJ/cGAtZSv9Ht7V5LrG2NIkvboHpV2xdDYFqa6ZUwTErZWfGxMIgA7s5DcgyE3UERA==
X-Received: by 2002:a92:a805:: with SMTP id o5mr16194779ilh.233.1605688031012;
        Wed, 18 Nov 2020 00:27:11 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id w81sm15255719ilk.38.2020.11.18.00.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 00:27:10 -0800 (PST)
Date:   Wed, 18 Nov 2020 08:27:08 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
Message-ID: <20201118082707.GA15687@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201116163615.GA17680@redhat.com>
 <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com>
 <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com>
 <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
 <20201117164600.GC78221@redhat.com>
 <CAOQ4uxgi-8sn4S3pRr0NQC5sjp9fLmVsfno1nSa2ugfM2KQLLQ@mail.gmail.com>
 <20201117182940.GA91497@redhat.com>
 <CAOQ4uxjkmooYY-NAVrSZOU9BDP0azmbrrmkKNKgyQOURR6eqEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkmooYY-NAVrSZOU9BDP0azmbrrmkKNKgyQOURR6eqEg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:24:04AM +0200, Amir Goldstein wrote:
> On Tue, Nov 17, 2020 at 8:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 08:03:16PM +0200, Amir Goldstein wrote:
> > > > > C. "shutdown" the filesystem if writeback errors happened and return
> > > > >      EIO from any read, like some blockdev filesystems will do in face
> > > > >      of metadata write errors
> > > > >
> > > > > I happen to have a branch ready for that ;-)
> > > > > https://github.com/amir73il/linux/commits/ovl-shutdown
> > > >
> > > >
> > > > This branch seems to implement shutdown ioctl. So it will still need
> > > > glue code to detect writeback failure in upper/ and trigger shutdown
> > > > internally?
> > > >
> > >
> > > Yes.
> > > ovl_get_acess() can check both the administrative ofs->goingdown
> > > command and the upper writeback error condition for volatile ovl
> > > or something like that.
> >
> > This approach will not help mmaped() pages though, if I do.
> >
> > - Store to addr
> > - msync
> > - Load from addr
> >
> > There is a chance that I can still read back old data.
> >
> 
> msync does not go through overlay. It goes directly to upper fs,
> so it will sync pages and return error on volatile overlay as well.
> 
> Maybe there will still be weird corner cases, but the shutdown approach
> should cover most or all of the interesting cases.
When would we check the errseq_t of the upperdir? Only when the user
calls fsync, or upon close? Periodically?

> 
> Thanks,
> Amir.

We can tackle this later, but I suggest the following semantics, which
follow how ext4 works:

https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
errors=remount-ro	Remount the filesystem read-only on an error.
errors=continue		Keep going on a filesystem error.
[Sargun: We probably don't want this one]
errors=panic		Panic and halt the machine if an error occurs.
                        (These mount options override the errors behavior
                        specified in the superblock, which can be configured
                        using tune2fs)

----
We can potentially add a fourth option, which is shutdown -- that would
return something like EIO or ESHUTDOWN for all calls.

In addition to that, we should pass through the right errseqs to make
the errseq helpers work:
int filemap_check_wb_err(struct address_space *mapping, errseq_t since) [1]
errseq_t filemap_sample_wb_err(struct address_space *mapping) [2]
errseq_t file_sample_sb_err(struct file *file)

etc...

These are used by the VFS layer to check for errors after syncfs or for 
interactions with mapped files. 

[1]: https://elixir.bootlin.com/linux/v5.9.7/source/include/linux/fs.h#L2665
[2]: https://elixir.bootlin.com/linux/v5.9.7/source/include/linux/fs.h#L2688
[3]: https://elixir.bootlin.com/linux/v5.9.7/source/include/linux/fs.h#L2700
