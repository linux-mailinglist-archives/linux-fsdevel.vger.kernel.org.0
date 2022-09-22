Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE645E602A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIVKs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIVKs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:48:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0088CC8F8
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 03:48:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7430B21A01;
        Thu, 22 Sep 2022 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663843704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tcv1NqtSRv9ek7IKQn888Cg3Lz/9Y/b/qT4Xg7vvvJA=;
        b=vrpUJSki12yU6h9NYyQhg+k8zo0x5h7SLx/dW0lYw+0u+IewNr+XrpTW2S/maLWn0VMnV8
        //2VJN6vEjN/DXTgJTONybr2YYVTHYzbBGLJA7E1bYcczADVGR9Z5gscRGXtrjU0gCoAdp
        dYsK7AyAo3184b6/iRsbLb9jAbvP6CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663843704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tcv1NqtSRv9ek7IKQn888Cg3Lz/9Y/b/qT4Xg7vvvJA=;
        b=Rl7Jg5gopNO6+V1bzU33Ri2SLDfEb78uvmLLUfRSgO0YAWckaaEaZlkY5Q1gLgginO68/k
        j6WuEGEaK9mtceBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6564D1346B;
        Thu, 22 Sep 2022 10:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dYC3GHg9LGMlJwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Sep 2022 10:48:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D9645A0684; Thu, 22 Sep 2022 12:48:23 +0200 (CEST)
Date:   Thu, 22 Sep 2022 12:48:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Fufu Fang <fangfufu2003@gmail.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220922104823.z6465rfro7ataw2i@quack3>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3>
 <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3>
 <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-09-22 21:19:25, Amir Goldstein wrote:
> On Wed, Sep 14, 2022 at 2:52 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > > > So I'd prefer to avoid the major API
> > > > > > extension unless there are serious users out there - perhaps we will even
> > > > > > need to develop the kernel API in cooperation with the userspace part to
> > > > > > verify the result is actually usable and useful.
> > > >
> > > > Yap. It should be trivial to implement a "mirror" HSM backend.
> > > > For example, the libprojfs [5] projects implements a MirrorProvider
> > > > backend for the Microsoft ProjFS [6] HSM API.
> > >
> > > Well, validating that things work using some simple backend is one thing
> > > but we are probably also interested in whether the result is practical to
> > > use - i.e., whether the performance meets the needs, whether the API is not
> > > cumbersome for what HSM solutions need to do, whether the more advanced
> > > features like range-support are useful the way they are implemented etc.
> > > We can verify some of these things with simple mirror HSM backend but I'm
> > > afraid some of the problems may become apparent only once someone actually
> > > uses the result in practice and for that we need a userspace counterpart
> > > that does actually something useful so that people have motivation to use
> > > it :).
> >
> 
> Hi Jan,
> 
> I wanted to give an update on the POC that I am working on.
> I decided to find a FUSE HSM and show how it may be converted
> to use fanotify HSM hooks.
> 
> HTTPDirFS is a read-only FUSE filesystem that lazyly populates a local
> cache from a remote http on first access to every directory and file range.
> 
> Normally, it would be run like this:
> ./httpdirfs --cache-location /vdf/cache https://cdn.kernel.org/pub/ /mnt/pub/
> 
> Content is accessed via FUSE mount as /mnt/pub/ and FUSE implements
> passthrough calls to the local cache dir if cache is already populated.
> 
> After my conversion patches [1], this download-only HSM can be run like
> this without mounting FUSE:
> 
> sudo ./httpdirfs --fanotify --cache-location /vdf/cache
> https://cdn.kernel.org/pub/ -
> 
> [1] https://github.com/amir73il/httpdirfs/commits/fanotify_pre_content
> 
> Browsing the cache directory at /vdf/cache, lazyly populates the local cache
> using FAN_ACCESS_PERM readdir hooks and lazyly downloads files content
> using FAN_ACCESS_PERM read hooks.
> 
> Up to this point, the implementation did not require any kernel changes.
> However, this type of command does not populate the path components,
> because lookup does not generate FAN_ACCESS_PERM event:
> 
> stat /vdf/cache/data/linux/kernel/firmware/linux-firmware-20220815.tar.gz
> 
> To bridge that functionality gap, I've implemented the FAN_LOOKUP_PERM
> event [2] and used it to lazyly populate directories in the path ancestry.
> For now, I stuck with the XXX_PERM convention and did not require
> FAN_CLASS_PRE_CONTENT, although we probably should.
> 
> [2] https://github.com/amir73il/linux/commits/fanotify_pre_content
> 
> Streaming read of large files works as well, but only for sequential read
> patterns. Unlike the FUSE read calls, the FAN_ACCESS_PERM events
> do not (yet) carry range info, so my naive implementation downloads
> one extra data chunk on each FAN_ACCESS_PERM until the cache file is full.
> 
> This makes it possible to run commands like:
> 
> tar tvfz /vdf/cache/data/linux/kernel/firmware/linux-firmware-20220815.tar.gz
> | less
> 
> without having to wait for the entire 400MB file to download before
> seeing the first page.
> 
> This streaming feature is extremely important for modern HSMs
> that are often used to archive large media files in the cloud.

Thanks for update Amir! I've glanced through the series and so far it looks
pretty simple and I'd have only some style / readability nits (but let's
resolve those once we have something more complete).

When thinking about HSM (and while following your discussion with Dave) I
wondered about one thing: When the notifications happen before we take
locks, then we are in principle prone to time-to-check-time-to-use races,
aren't we? How are these resolved?

For example something like:
We have file with size 16k.
Reader:				Writer
  read 8k at offset 12k
    -> notification sent
    - HSM makes sure 12-16k is here and 16-20k is beyond eof so nothing to do

				expand file to 20k
  - now the file contents must not get moved out until the reader is
    done in order not to break it

> For the next steps of POC, I could do:
> - Report FAN_ACCESS_PERM range info to implement random read
>   patterns (e.g. unzip -l)
> - Introduce FAN_MODIFY_PERM, so file content could be downloaded
>   before modifying a read-write HSM cache
> - Demo conversion of a read-write FUSE HSM implementation
>   (e.g. https://github.com/volga629/davfs2)
> - Demo HSM with filesystem mark [*] and a hardcoded test filter
> 
> [*] Note that unlike the case with recursive inotify, this POC HSM
> implementation is not racy, because of the lookup permission events.
> A filesystem mark is still needed to avoid pinning all the unpopulated
> cache tree leaf entries to inode cache, so that this HSM could work on
> a very large scale tree, the same as my original use case for implementing
> filesystem mark.

Sounds good! Just with your concern about pinning - can't you use evictable
marks added on lookup for files / dirs you want to track? Maybe it isn't
great design for other reasons but it would save you some event
filtering...

> If what you are looking for is an explanation why fanotify HSM would be better
> than a FUSE HSM implementation then there are several reasons.
> Performance is at the top of the list. There is this famous USENIX paper [3]
> about FUSE passthrough performance.
> It is a bit outdated, but many parts are still relevant - you can ask
> the Android
> developers why they decided to work on FUSE-BFP...
> 
> [3] https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf
> 
> For me, performance is one of the main concerns, but not the only one,
> so I am not entirely convinced that a full FUSE-BFP implementation would
> solve all my problems.
> 
> When scaling to many millions of passthrough inodes, resource usage start
> becoming a limitation of a FUSE passthrough implementation and memory
> reclaim of native fs works a lot better than memory reclaim over FUSE over
> another native fs.
> 
> When the workload works on the native filesystem, it is also possible to
> use native fs features (e.g. XFS ioctls).

OK, understood. Out of curiosity you've mentioned you'd looked into
implementing HSM in overlayfs. What are the issues there? I assume
performance is very close to native one so that is likely not an issue and
resource usage you mention above likely is not that bad either. So I guess
it is that you don't want to invent hooks for userspace for moving (parts
of) files between offline storage and the local cache?

> Questions:
> - What do you think about the direction this POC has taken so far?
> - Is there anything specific that you would like to see in the POC
>   to be convinced that this API will be useful?

I think your POC is taking a good direction and your discussion with Dave
had made me more confident that this is all workable :). I liked your idea
of the wiki (or whatever form of documentation) that summarizes what we've
discussed in this thread. That would be actually pretty nice for future
reference.

The remaining concern I have is that we should demonstrate the solution is
able to scale to millions of inodes (and likely more) because AFAIU that
are the sizes current HSM solutions are interested in. I guess this is kind
of covered in your last step of POCs though.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
