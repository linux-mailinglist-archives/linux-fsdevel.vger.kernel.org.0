Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C5683A7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 00:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAaXb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 18:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAaXb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:31:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D84A223
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 15:31:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o13so15681044pjg.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 15:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8MB56q9vfvlJA565WpCyEkeIG1X8rQRlw2aoYs4F/4=;
        b=71r/HeZwPXQZTQevtJlDWtDC0L1YLubXfPRI4A9QxH6b5yi2FlwwZTUTReRs3J1tls
         cMhwi80p4USqlY5DlRBBMhktY4GC6GlA01jnr3t1y9JsDCzTi8RivxP+JMTB/SfVcA8i
         HdlrncMs1UjrPoKAwDb4wRUrUD0p3JIb44ug/n0Wbay89qfcbiDj3xeptiJoAYSg8rG4
         +LESP7lyQsrWexmXkl6m5UDOkXFSk/0FFlXUR68P838cgaJQu6SCLfd3DNqkuKBZfoXH
         1hOKVARo9CU/GZsxLMb1IlMLDt7LmKCAzHaGrCr99Tc4xMLxxKp3cRr98HjtzADbkSyv
         tIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8MB56q9vfvlJA565WpCyEkeIG1X8rQRlw2aoYs4F/4=;
        b=Qu473Rhe9NJyX0xU3G1qCqPGRIEXYGGrUvTU6b2jHSfE3ovonHw9XM/b4FUiwJTCIk
         COttG9MXOxaZUrv2m4RYDOkmhRxGXKMn0GIzztvcUxS/fZTR8O02EOVYHE533jL0osJ8
         KzdGOc51+5SiRpwWUiuRP81TmaYyOHwf1/13D87268+8e2CCtFZa4DNVoi/GSvBhk4R5
         UZhcJw7YIuxTcgEH4jLcs+RzYNUF2hgxd05plreBl9w42fotRaF9AnxyL5XgYJEaw5s0
         339/xmbuduY+iKwAD9Fh7Vbafoa2CRsyIbGpqPX5CnkEIZWV9bH5kOvUUpi+bMO0q66k
         Lvzg==
X-Gm-Message-State: AO0yUKVT648gEvYtNhk1oLFiPbEzKDzcQT2DEMMS+3nu/FljWuGj9nCp
        Jrbx8A8C+nQNIMnXi42DS4Khyw==
X-Google-Smtp-Source: AK7set9T8Da2vtUKw8moywVro/lMA7YXIriPTZdEe2MxtY/ftvC98Bdi2cm4LEygyrCh/P/qYliKAQ==
X-Received: by 2002:a17:90b:17c3:b0:22c:46a2:ab0b with SMTP id me3-20020a17090b17c300b0022c46a2ab0bmr18928578pjb.43.1675207884115;
        Tue, 31 Jan 2023 15:31:24 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a680600b0022c35f1c576sm8160905pjj.57.2023.01.31.15.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:31:23 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pN05w-009rls-4w; Wed, 01 Feb 2023 10:31:20 +1100
Date:   Wed, 1 Feb 2023 10:31:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: replacement i_version counter for xfs
Message-ID: <20230131233120.GR360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
 <20230125000227.GM360264@dread.disaster.area>
 <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
 <Y9FZupBCyPGCMFBd@magnolia>
 <4d16f9f9eb678f893d4de695bd7cbff6409c3c5a.camel@kernel.org>
 <20230130020525.GO360264@dread.disaster.area>
 <619f0cd76d739ade3249ea4433943264d1737ab2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619f0cd76d739ade3249ea4433943264d1737ab2.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:02:56AM -0500, Jeff Layton wrote:
> On Mon, 2023-01-30 at 13:05 +1100, Dave Chinner wrote:
> > On Wed, Jan 25, 2023 at 12:58:08PM -0500, Jeff Layton wrote:
> > > On Wed, 2023-01-25 at 08:32 -0800, Darrick J. Wong wrote:
> > > > On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > > > > Note that there are two other lingering issues with i_version. Neither
> > > > > of these are xfs-specific, but they may inform the changes you want to
> > > > > make there:
> > > > > 
> > > > > 1/ the ctime and i_version can roll backward on a crash.
> > > > > 
> > > > > 2/ the ctime and i_version are both currently updated before write data
> > > > > is copied to the pagecache. It would be ideal if that were done
> > > > > afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> > > > > for this, but they need a lot more testing.)
> > > > 
> > > > You might also want some means for xfs to tell the vfs that it already
> > > > did the timestamp update (because, say, we had to allocate blocks).
> > > > I wonder what people will say when we have to run a transaction before
> > > > the write to peel off suid bits and another one after to update ctime.
> > > > 
> > > 
> > > That's a great question! There is a related one too once I started
> > > looking at this in more detail:
> > > 
> > > Most filesystems end up updating the timestamp via a the call to
> > > file_update_time in __generic_file_write_iter. Today, that's called very
> > > early in the function and if it fails, the write fails without changing
> > > anything.
> > > 
> > > What do we do now if the write succeeds, but update_time fails? We don't
> > 
> > On XFS, the timestamp update will either succeed or cause the
> > filesystem to shutdown as a failure with a dirty transaction is a
> > fatal, unrecoverable error.
> > 
> 
> Ok. So for xfs, we could move all of this to be afterward. Clearing
> setuid bits is quite rare, so that would only rarely require a
> transaction (in principle).

See my response in the other email about XFS and atomic buffered
write IO. We don't need to do an update after the write because
reads cannot race between the data copy and the ctime/i_version
update. Hence we only need one update, and it doesn't matter if it
is before or after the data copy into the page cache.

> > > want to return an error on the write() since the data did get copied in.
> > > Ignoring it seems wrong too though. There could even be some way to
> > > exploit that by changing the contents while holding the timestamp and
> > > version constant.
> > 
> > If the filesystem has shut down, it doesn't matter that the data got
> > copied into the kernel - it's never going to make it to disk and
> > attempts to read it back will also fail. There's nothing that can be
> > exploited by such a failure on XFS - it's game over for everyone
> > once the fs has shut down....
> > 
> > > At this point I'm leaning toward leaving the ctime and i_version to be
> > > updated before the write, and just bumping the i_version a second time
> > > after. In most cases the second bump will end up being a no-op, unless
> > > an i_version query races in between.
> > 
> > Why not also bump ctime at write completion if a query races with
> > the write()? Wouldn't that put ns-granularity ctime based change
> > detection on a par with i_version?
> > 
> > Userspace isn't going to notice the difference - the ctime they
> > observe indicates that it was changed during the syscall. So
> > who/what is going to care if we bump ctime twice in the syscall
> > instead of just once in this rare corner case?
> > 
> 
> We could bump the ctime too in this situation, but it would be more
> costly. In most cases the i_version bump will be a no-op. The only
> exception would be when a query of i_version races in between the two
> bumps. That wouldn't be the case with the ctime, which would almost
> always require a second transaction.

You've missed the part where I suggested lifting the "nfsd sampled
i_version" state into an inode state flag rather than hiding it in
the i_version field. At that point, we could optimise away the
secondary ctime updates just like you are proposing we do with the
i_version updates.  Further, we could also use that state it to
decide whether we need to use high resolution timestamps when
recording ctime updates - if the nfsd has not sampled the
ctime/i_version, we don't need high res timestamps to be recorded
for ctime....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
